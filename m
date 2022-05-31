Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EE14C433F5
	for <git@archiver.kernel.org>; Tue, 31 May 2022 16:59:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346300AbiEaQ73 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 May 2022 12:59:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242736AbiEaQ7L (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 May 2022 12:59:11 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A607E6A041
        for <git@vger.kernel.org>; Tue, 31 May 2022 09:59:10 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id e25so8896702wra.11
        for <git@vger.kernel.org>; Tue, 31 May 2022 09:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=easQ+hH+2Z/kvl70QBP/w04fPNgR0dc5NV1I0jkPKYA=;
        b=A1IRiAQ2XDYt4ik1W0ba/+2lgzJXz99+HyKHKCvaOjy7nmIaOeHJFgQ3aR8TqMHUaZ
         IKCTm/2E3e0l7OKwaL2H4kTrsZ137PlyreB+Qmo2efOC7xaU7REyKXYn6gXodUDLNjfC
         2PwAqrhgb9uhVZ3Iq79oJiNEgnDIDGDClYUcLGxNgGR+2riBTsST5+70TP79LPu/z9yL
         tWj6N7xs8O27hjPPyRCGENi04D3UChzvwABj3oRPvA1VC2gsY67w+0iO1kMtZ7Eb1xj9
         1ywMbBud/NU/8ynhPcU74YD6tK7JvAZhVFxWYTDyPQqnS6NmewYme1slwxXyHOhYCTSk
         v8tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=easQ+hH+2Z/kvl70QBP/w04fPNgR0dc5NV1I0jkPKYA=;
        b=XnuYX5qkk3kr5dwQNHHh/owgcNE1t0mkV0dgodp2vKRTUinv129ZD6mNZYfuD8wzk2
         Ugk23chfsYXODU5UP8EDckt12+H/8iekfjN+DRVjiJUSpU5gW+dIiPT9sxU0R42T7ni8
         HIm5zoJWgP2D3s4g2MiIY1bKXC3kTT1D+j+KsymiogiFIy2c3PIwiIXlNVCGKko3bLHH
         4HojMF/SI5eSdKWK7QiiZaNGKvi8x8HzB6mofFJlldED+QCTZHc/Xp4/FcBkKS9JlaGa
         NQOm1JAmphgufRTWeVXVRnxfVKHyVbfGiQbyVuXlErI5GAXBi2ejTNDBuuIMjUpsI3g1
         KahQ==
X-Gm-Message-State: AOAM533RDbpsMUeWDBQ9fTtu76vP97ncv7JfuiUGs/KFE/uHrMfI8tDD
        cr6yzXUjczA31e/B/A/fhKyFUckFZ9Jolw==
X-Google-Smtp-Source: ABdhPJzFRLIbpp3XdM3xAHeB3ks5Xa7fN5bGQYSt/ifAq9pt8DS62UROgFTcX7FAjgHEgKq/UD8sMA==
X-Received: by 2002:a05:6000:2a2:b0:20f:d7ca:476 with SMTP id l2-20020a05600002a200b0020fd7ca0476mr37688803wry.501.1654016348773;
        Tue, 31 May 2022 09:59:08 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o3-20020a5d47c3000000b0020d0cdbf7eesm12829820wrc.111.2022.05.31.09.59.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 May 2022 09:59:07 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>,
        Josh Steadmon <steadmon@google.com>,
        Glen Choo <chooglen@google.com>,
        Andrei Rybak <rybak.a.v@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 5/6] receive-pack: use bug() and BUG_if_bug()
Date:   Tue, 31 May 2022 18:58:47 +0200
Message-Id: <patch-v2-5.6-fe5c3926675-20220531T164806Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.1.1100.g16130010d07
In-Reply-To: <cover-v2-0.6-00000000000-20220531T164806Z-avarab@gmail.com>
References: <cover-0.5-00000000000-20220521T170939Z-avarab@gmail.com> <cover-v2-0.6-00000000000-20220531T164806Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Amend code added in a6a84319686 (receive-pack.c: shorten the
execute_commands loop over all commands, 2015-01-07) and amended to
hard die in b6a4788586d (receive-pack.c: die instead of error in case
of possible future bug, 2015-01-07) to use the new bug() function
instead.

Let's also rename the warn_if_*() function that code is in to
BUG_if_*(), its name became outdated in b6a4788586d.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/receive-pack.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index daa153d0446..4a62327dee9 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -1810,21 +1810,17 @@ static int should_process_cmd(struct command *cmd)
 	return !cmd->error_string && !cmd->skip_update;
 }
 
-static void warn_if_skipped_connectivity_check(struct command *commands,
+static void BUG_if_skipped_connectivity_check(struct command *commands,
 					       struct shallow_info *si)
 {
 	struct command *cmd;
-	int checked_connectivity = 1;
 
 	for (cmd = commands; cmd; cmd = cmd->next) {
-		if (should_process_cmd(cmd) && si->shallow_ref[cmd->index]) {
-			error("BUG: connectivity check has not been run on ref %s",
-			      cmd->ref_name);
-			checked_connectivity = 0;
-		}
+		if (should_process_cmd(cmd) && si->shallow_ref[cmd->index])
+			bug("connectivity check has not been run on ref %s",
+			    cmd->ref_name);
 	}
-	if (!checked_connectivity)
-		BUG("connectivity check skipped???");
+	BUG_if_bug("connectivity check skipped???");
 }
 
 static void execute_commands_non_atomic(struct command *commands,
@@ -2005,7 +2001,7 @@ static void execute_commands(struct command *commands,
 		execute_commands_non_atomic(commands, si);
 
 	if (shallow_update)
-		warn_if_skipped_connectivity_check(commands, si);
+		BUG_if_skipped_connectivity_check(commands, si);
 }
 
 static struct command **queue_command(struct command **tail,
-- 
2.36.1.1100.g16130010d07

