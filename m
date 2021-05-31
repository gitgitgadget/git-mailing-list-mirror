Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A15C8C47082
	for <git@archiver.kernel.org>; Mon, 31 May 2021 19:51:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A3B4606A5
	for <git@archiver.kernel.org>; Mon, 31 May 2021 19:51:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231585AbhEaTxK (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 May 2021 15:53:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230519AbhEaTxJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 May 2021 15:53:09 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A05EC061574
        for <git@vger.kernel.org>; Mon, 31 May 2021 12:51:29 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id a13so7843123oid.9
        for <git@vger.kernel.org>; Mon, 31 May 2021 12:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=a3esfwa0ioPNHMlz0GR2X8p05KfASrhzJA4HO3JEBek=;
        b=FO3KVb8FevPVoPYjZ6dUyWRBELE6he/oAxjoqtSwDMKX6lZFVh/HWu2MHUiGn3hpqi
         APINgxcY7Tj9alfXHfznzsm1a0PyVJl2AZXop6xoPRg7EA5iwf7zttDPaJe1BsQvXOUj
         DG/E7X8jwf4KunmUuRCcTQA9Ous+F2KeqUoGPh8Axo5rKJdbIThj8qqvo3DkjS7Xbf3z
         vk6uZZ8y7nDFChKxWP9dp+NlnWFLhopNIiVd1qOCx672ZsxNmkVscShY1KPhS2Ox1LIh
         M9SGz55F7NiUFumZjuJ8iE1QZTSueNdRVl8ARNxhcwlDiXU/3saFLkstae2/louvAfwI
         JvQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=a3esfwa0ioPNHMlz0GR2X8p05KfASrhzJA4HO3JEBek=;
        b=k7PTeq3SDVso9ep0m1Zot3y/NmWR6D5MBHbFjLSARG3gbzC6VohYIHDOPNTsZaRdns
         wzLt1C7T7435rBAhAglPjOJoB9smI7/xg2faR7g2iNZx4Txv+qszMIJCueeuDtaxWYJu
         nRrNiIJHFBl0DNPemnFNdEdp1ADQiPPfurqimhTF8RhuADVh7EZTsp16vMM7LEwk9ClD
         pDQPFPVgaoI8qUatXx9duf1mAXxrJ8EunV2LoB7zNfQZ1op0CE/RrSz4Lg+3K9kmIfVF
         btJatl2ydqqTKcxB0sHyy+2tazAoYaQIOE6coiZ4ammyBuxbm9S7++F+5Ui4Cpe4jr/P
         n47w==
X-Gm-Message-State: AOAM531Qauta25+LCT7SBTd5e0w2ZyZuB4bqpAuNYRjkap5ipulOlqPf
        RatO92gBsfJWKu/AVIvpTl2ooWglJORrtQ==
X-Google-Smtp-Source: ABdhPJzinsxZNX57GQIHELYBWxMPk5bXq+ryECdx78g6HAarle8fw+DQFHMtZFJeOizj+iNXLioGCw==
X-Received: by 2002:a05:6808:159d:: with SMTP id t29mr445839oiw.112.1622490688173;
        Mon, 31 May 2021 12:51:28 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id h7sm1028195oib.49.2021.05.31.12.51.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 May 2021 12:51:27 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Brandon Williams <bwilliams.eng@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 01/13] push: create new get_upstream_ref() helper
Date:   Mon, 31 May 2021 14:51:12 -0500
Message-Id: <20210531195124.218325-2-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0.rc0
In-Reply-To: <20210531195124.218325-1-felipe.contreras@gmail.com>
References: <20210531193237.216726-1-felipe.contreras@gmail.com>
 <20210531195124.218325-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This code is duplicated among multiple functions.

No functional changes.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin/push.c | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/builtin/push.c b/builtin/push.c
index 29fea70ff1..e3e792c69c 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -185,29 +185,37 @@ static const char message_detached_head_die[] =
 	   "\n"
 	   "    git push %s HEAD:<name-of-remote-branch>\n");
 
-static void setup_push_upstream(struct remote *remote, struct branch *branch,
-				int same_remote)
+static const char *get_upstream_ref(struct branch *branch, const char *remote_name)
 {
-	if (!branch)
-		die(_(message_detached_head_die), remote->name);
 	if (!branch->merge_nr || !branch->merge || !branch->remote_name)
 		die(_("The current branch %s has no upstream branch.\n"
 		    "To push the current branch and set the remote as upstream, use\n"
 		    "\n"
 		    "    git push --set-upstream %s %s\n"),
 		    branch->name,
-		    remote->name,
+		    remote_name,
 		    branch->name);
 	if (branch->merge_nr != 1)
 		die(_("The current branch %s has multiple upstream branches, "
 		    "refusing to push."), branch->name);
+
+	return branch->merge[0]->src;
+}
+
+static void setup_push_upstream(struct remote *remote, struct branch *branch,
+				int same_remote)
+{
+	const char *upstream_ref;
+	if (!branch)
+		die(_(message_detached_head_die), remote->name);
+	upstream_ref = get_upstream_ref(branch, remote->name);
 	if (!same_remote)
 		die(_("You are pushing to remote '%s', which is not the upstream of\n"
 		      "your current branch '%s', without telling me what to push\n"
 		      "to update which remote branch."),
 		    remote->name, branch->name);
 
-	refspec_appendf(&rs, "%s:%s", branch->refname, branch->merge[0]->src);
+	refspec_appendf(&rs, "%s:%s", branch->refname, upstream_ref);
 }
 
 static void setup_push_current(struct remote *remote, struct branch *branch)
@@ -223,20 +231,12 @@ static void setup_push_simple(struct remote *remote, struct branch *branch, int
 		die(_(message_detached_head_die), remote->name);
 
 	if (same_remote) {
-		if (!branch->merge_nr || !branch->merge || !branch->remote_name)
-			die(_("The current branch %s has no upstream branch.\n"
-			    "To push the current branch and set the remote as upstream, use\n"
-			    "\n"
-			    "    git push --set-upstream %s %s\n"),
-			    branch->name,
-			    remote->name,
-			    branch->name);
-		if (branch->merge_nr != 1)
-			die(_("The current branch %s has multiple upstream branches, "
-			    "refusing to push."), branch->name);
+		const char *upstream_ref;
+
+		upstream_ref = get_upstream_ref(branch, remote->name);
 
 		/* Additional safety */
-		if (strcmp(branch->refname, branch->merge[0]->src))
+		if (strcmp(branch->refname, upstream_ref))
 			die_push_simple(branch, remote);
 	}
 	refspec_appendf(&rs, "%s:%s", branch->refname, branch->refname);
-- 
2.32.0.rc0

