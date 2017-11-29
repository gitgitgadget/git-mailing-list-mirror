Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AAE6020954
	for <e@80x24.org>; Wed, 29 Nov 2017 03:46:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752248AbdK2Dqn (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Nov 2017 22:46:43 -0500
Received: from mail-pl0-f66.google.com ([209.85.160.66]:40614 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751497AbdK2Dqm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Nov 2017 22:46:42 -0500
Received: by mail-pl0-f66.google.com with SMTP id 1so1283101pla.7
        for <git@vger.kernel.org>; Tue, 28 Nov 2017 19:46:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Fzvh5AUwKyQFVL+oLW8kDkgWEwQoZ86kkXMvzNIWEyk=;
        b=ec5kAjGPF0yXE1hSwhF01ddTPpozJdqkRRK9Gh6bfp6r6BcdL/SCCnFcBo6+IiKS/i
         g2PyoFlFKKEcIAaXzupHMbu2WlpZH7WAALR0kKtiB135SrUJ51zxVLTiW5HBGcjq0KBd
         gPagf5c0ig1KJzAshOYoaj8koTfR+VSpF3oKQXOKMmhrZ1PNtlxohtic/2qooiX5hkf+
         sbMnEdBHTw1RgpPFNvxEIs/Cf5vKmAMkjFd4fPdkWVBOv4f4QrRDvtpD2nVs9kYpzKUu
         kDv2ymeaVLWSuVvrsia6OPemAv7Km3PEpuTc7D9pTNF9qNBWvqfx33lxTOY02b5MCZo2
         6m3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Fzvh5AUwKyQFVL+oLW8kDkgWEwQoZ86kkXMvzNIWEyk=;
        b=j7wxkXO/XffPlDqvW7tLbGHg7d4OtIaBGb9IpVy0KyGnZpM31Tj8qCubq7IntWlJIq
         9R/5sKcRgj9a4EtIQeHv8Bg6kbnMD8LoIr0zQRYidbrPdv84+Ko/iCEpkAB3c/Cj3Jpw
         a5CW70EdYcGKv+yORMgGnAmKe+YkYFipMt+SCc7YxR5VjhPxjPiydq9Waw9waHeqefdy
         wg6x7S/zYOdrIUQFksjt/aC3hiYFm8wAtalTfh3GdL7Xs5LdvckXvFZVmk73U88UkZcj
         qrLCSPDBHUHuVhXIuTtFAbVwhMYuv4BdeMbsUuQXB7eT0O4+tA1dOSAdITnq0DJ26fHa
         ae/w==
X-Gm-Message-State: AJaThX4fIPD2qft0Pi2KX4j2jiUPJWlFSwahaevK5ai/j9dEC/g4gFjk
        QEi7rvBSZ89toPup2w1d3//8KyGc
X-Google-Smtp-Source: AGs4zMbC72eg257tNRk5o7Wv87oSTS40adFroADq5XMIFd7JwvEtLi2+CY5edGHelLGrFHiWcjVA6Q==
X-Received: by 10.159.247.140 with SMTP id e12mr1513723pls.135.1511927202324;
        Tue, 28 Nov 2017 19:46:42 -0800 (PST)
Received: from localhost.localdomain ([117.251.230.138])
        by smtp.gmail.com with ESMTPSA id e7sm785199pfj.44.2017.11.28.19.46.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Nov 2017 19:46:41 -0800 (PST)
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git mailing list <git@vger.kernel.org>
Subject: [PATCH v4 4/4] builtin/branch: strip refs/heads/ using skip_prefix
Date:   Wed, 29 Nov 2017 09:16:20 +0530
Message-Id: <20171129034620.4719-1-kaartic.sivaraam@gmail.com>
X-Mailer: git-send-email 2.15.0.531.g2ccb3012c
In-Reply-To: <20171118172648.17918-5-kaartic.sivaraam@gmail.com>
References: <20171118172648.17918-5-kaartic.sivaraam@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Instead of hard-coding the offset strlen("refs/heads/") to skip
the prefix "refs/heads/" use the skip_prefix() function which
is more communicative and verifies that the string actually
starts with that prefix.

Signed-off-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
---
 v2 and v3 of this patch got detached to a different thread due
 to a small mistake I made, sorry. You can find it at

 https://public-inbox.org/git/20171121141852.551-1-kaartic.sivaraam@gmail.com/

 I've brought v4 back to this thread to bring back the continuity. I guess
 this series gets stabilised with this patch.

 Changes in v4 from v1:

  - updated commit message

  - removed superfluous comment

  - updated variable names

  - checked for the errors pointed out by skip_prefix

 builtin/branch.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index ca9d8abd0..b2f5e4a0c 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -462,6 +462,8 @@ static void copy_or_rename_branch(const char *oldname, const char *newname, int
 {
 	struct strbuf oldref = STRBUF_INIT, newref = STRBUF_INIT, logmsg = STRBUF_INIT;
 	struct strbuf oldsection = STRBUF_INIT, newsection = STRBUF_INIT;
+	const char *interpreted_oldname = NULL;
+	const char *interpreted_newname = NULL;
 	int recovery = 0;
 	int clobber_head_ok;
 
@@ -493,6 +495,11 @@ static void copy_or_rename_branch(const char *oldname, const char *newname, int
 
 	reject_rebase_or_bisect_branch(oldref.buf);
 
+	if (!skip_prefix(oldref.buf, "refs/heads/", &interpreted_oldname) ||
+	    !skip_prefix(newref.buf, "refs/heads/", &interpreted_newname)) {
+		die("BUG: expected prefix missing for refs")
+	}
+
 	if (copy)
 		strbuf_addf(&logmsg, "Branch: copied %s to %s",
 			    oldref.buf, newref.buf);
@@ -508,10 +515,10 @@ static void copy_or_rename_branch(const char *oldname, const char *newname, int
 	if (recovery) {
 		if (copy)
 			warning(_("Created a copy of a misnamed branch '%s'"),
-				oldref.buf + 11);
+				interpreted_oldname);
 		else
 			warning(_("Renamed a misnamed branch '%s' away"),
-				oldref.buf + 11);
+				interpreted_oldname);
 	}
 
 	if (!copy &&
@@ -520,9 +527,9 @@ static void copy_or_rename_branch(const char *oldname, const char *newname, int
 
 	strbuf_release(&logmsg);
 
-	strbuf_addf(&oldsection, "branch.%s", oldref.buf + 11);
+	strbuf_addf(&oldsection, "branch.%s", interpreted_oldname);
 	strbuf_release(&oldref);
-	strbuf_addf(&newsection, "branch.%s", newref.buf + 11);
+	strbuf_addf(&newsection, "branch.%s", interpreted_newname);
 	strbuf_release(&newref);
 	if (!copy && git_config_rename_section(oldsection.buf, newsection.buf) < 0)
 		die(_("Branch is renamed, but update of config-file failed"));
-- 
2.15.0.531.g2ccb3012c

