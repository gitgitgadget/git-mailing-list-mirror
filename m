Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 030EFC433FE
	for <git@archiver.kernel.org>; Mon, 15 Nov 2021 23:18:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC83D61AA9
	for <git@archiver.kernel.org>; Mon, 15 Nov 2021 23:17:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353277AbhKOXUx (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Nov 2021 18:20:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352951AbhKOXSa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Nov 2021 18:18:30 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCC56C03E037
        for <git@vger.kernel.org>; Mon, 15 Nov 2021 14:18:42 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id az33-20020a05600c602100b00333472fef04so385007wmb.5
        for <git@vger.kernel.org>; Mon, 15 Nov 2021 14:18:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ofTixTR0fKFDc5/BV1FRskedPCcP2EGXAiA1ywG2HdM=;
        b=X6Nmehu2Tmeh1WgGj5ll6cXxJzxvVCFekYnGA7IvV3PIqWNTONDvua0s9/5tznXP6/
         6CBCHZG6WJ7378moDgvuuEmRQHmkzdxYq//t7w/CevaSdkFNTG4qn3974O9dB3uI0tck
         sg1uOl2qgdHuZdP1IVFyaGevuLp5AdrZVCy58XnrlVsRx4yxT3Hmn5sZ9bBqJfB1JBHI
         ddhBBzySSVYVSf6IU8UOPqmDyUU8KzyRu6hbw3FoA9t79oT6/KrhOXBUtYXE+9viceyg
         8gr9KKCfww9N49VkzEVX2juqyTZmodS4L/wboZ4AYV2MD3j9+MQmIYuUnrQy1Rt98f/U
         /uRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ofTixTR0fKFDc5/BV1FRskedPCcP2EGXAiA1ywG2HdM=;
        b=LAbvE8O5kyAtzE8LaEFfQwXsSBMZ71rTSroA+11DXLGm5JQRu/+/ZjrsBRCLbSKTfg
         dUQrz3x2uDyjZ3Y4uxtTEcTleZi7lYUCoJ2XZUPPlMhDx6/lMex70L3DeSwkc+69hVQ6
         82oYeQqm2S1qLpLQDUZMFBYcwGKi9EYMp1eG03fnMH0GNA7Re+PS907MQjJf13MQFcUf
         DWCayELSDuudr1da5vJ9fSQFFtwBMxwRoCJDgOM/YlKRPvA7frmuZFNKz08zttBPQU3I
         71EVtcJ2iFlVu2Pp/+2LNvmbNp2AAzIvjg8AU2daNMTbWFY29jU7CMLhB5GgMnfhdSlX
         vTgg==
X-Gm-Message-State: AOAM5320nY7kCQl1aSg8MAvZW2twn0l/JCwDb1RI/o4WuHGLmntmIGZd
        U2578uwnLIpCy3jwuoYJZ3mb6c0BhNaH0Q==
X-Google-Smtp-Source: ABdhPJy8NMljGcKOqfxcWA4mb999GmQETCuSkaeSib+Xm1rkUu+5Nu0JMnToBs5J+u2Dhtya0CDOCw==
X-Received: by 2002:a1c:a9c6:: with SMTP id s189mr2202003wme.38.1637014721249;
        Mon, 15 Nov 2021 14:18:41 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n184sm526812wme.2.2021.11.15.14.18.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Nov 2021 14:18:40 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Elijah Newren <newren@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC PATCH 10/21] receive-pack: use bug() and BUG_if_bug()
Date:   Mon, 15 Nov 2021 23:18:20 +0100
Message-Id: <RFC-patch-10.21-9eb2d47aad9-20211115T220831Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.0.rc2.809.g11e21d44b24
In-Reply-To: <RFC-cover-00.21-00000000000-20211115T220831Z-avarab@gmail.com>
References: <RFC-cover-00.21-00000000000-20211115T220831Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Amend code added in a6a84319686 (receive-pack.c: shorten the
execute_commands loop over all commands, 2015-01-07) and amended to
hard die in b6a4788586d (receive-pack.c: die instead of error in case
of possible future bug, 2015-01-07) to the new bug() function instead.

Let's also rename the warn_if_*() function that code is in to
BUG_if_*(), its name became outdated in b6a4788586d.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/receive-pack.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 49b846d9605..42fabafa726 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -1824,21 +1824,17 @@ static int should_process_cmd(struct command *cmd)
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
+		if (!should_process_cmd(cmd) && si->shallow_ref[cmd->index])
+			bug("connectivity check has not been run on ref %s",
+			    cmd->ref_name);
 	}
-	if (!checked_connectivity)
-		BUG("connectivity check skipped???");
+	BUG_if_bug();
 }
 
 static void execute_commands_non_atomic(struct command *commands,
@@ -2010,7 +2006,7 @@ static void execute_commands(struct command *commands,
 		execute_commands_non_atomic(commands, si);
 
 	if (shallow_update)
-		warn_if_skipped_connectivity_check(commands, si);
+		BUG_if_skipped_connectivity_check(commands, si);
 }
 
 static struct command **queue_command(struct command **tail,
-- 
2.34.0.rc2.809.g11e21d44b24

