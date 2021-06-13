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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 062ACC48BCF
	for <git@archiver.kernel.org>; Sun, 13 Jun 2021 14:36:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9A7B6128A
	for <git@archiver.kernel.org>; Sun, 13 Jun 2021 14:36:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231799AbhFMOfc (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 13 Jun 2021 10:35:32 -0400
Received: from mail-oi1-f178.google.com ([209.85.167.178]:39542 "EHLO
        mail-oi1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231755AbhFMOf2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 Jun 2021 10:35:28 -0400
Received: by mail-oi1-f178.google.com with SMTP id m137so11616313oig.6
        for <git@vger.kernel.org>; Sun, 13 Jun 2021 07:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pXZW6frsgci46wOzKK/WcBmrisXdw6gVbLr2vTWqRpU=;
        b=tuvhS4x1IpJB/JtfpWuGmV7czN86bndafij4cd7un8q+dFPaf0MGrTdDGPYM0bCquB
         ww1MHhGR7H5POECafDMYjBJ8KpaRtEvElxyo3JA/r0WESv4REvqzDUED2eK7E92LVTgW
         cCeOlWsIAX+VrpwQXAMcu616r9Kt0XWm1Lrmvb2v3sFimvRzXLjM3BW13RW5alp9bBY5
         j+wkYVjs3nA3Vqv8k2HR5WLST8HfcrQgkyj/X7EZOwjPdfrhNqxvHijVVL+iD4BDrcJ9
         +8e2hjMD+iivR0xKPnEEeYl2G5n5roo76a2SSoOmvz7uJmuJaiRKeDiDlkoQr9JYwhit
         5Amw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pXZW6frsgci46wOzKK/WcBmrisXdw6gVbLr2vTWqRpU=;
        b=KM3p/bQQUCw+4/d6+Mi0CN3k7IC+qPk3Yrou4VQOk3KDPUnlRhDXZOxu6s+Uv7iq7Z
         rKr2BFZP8LyRfmjif+2B3V+ilqRphE+bB7BQf/zLUohLHivyfyJ+tnJRyjqnoUyG3cgW
         9kpOII0DJPCWsW57dAM7ugB3y4bCgemfZN9dHAqwV7E9F5HjuZb6gOXUTqeS5noDVdxC
         hdGMvD0nb9kwhzeaH5ppkCjq+vioi6cnAtkLVw6rBG74Ls2p/OehEoAavGOKElC6qLe2
         4HTxTKg8Bx1ByrLz3h/i/LjWqAdFVV/RT7c823eOQX0excI/tuW4IrEKQkwj3jbH+UCS
         8JNQ==
X-Gm-Message-State: AOAM532WLIUUfN4RgsuodHBaURcsSFU3bftpwLYNlHeaWaZQAIeHoAYu
        ZxLU6xJwwZCBuK8+lDfm5Jspbl64F5mfyw==
X-Google-Smtp-Source: ABdhPJx/GmhMtV8GQnVtIy9kGo47mg4tKWKsmcMX9oafW+D7bGZ7p995tVtykBwG9UHs8POLxT25jw==
X-Received: by 2002:aca:2106:: with SMTP id 6mr9637784oiz.127.1623594720978;
        Sun, 13 Jun 2021 07:32:00 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id x2sm2461069oog.10.2021.06.13.07.32.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Jun 2021 07:32:00 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Johannes Sixt <j6t@kdbg.org>,
        Sergey Organov <sorganov@gmail.com>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Subject: [PATCH] xdiff: implement a zealous diff3
Date:   Sun, 13 Jun 2021 09:31:55 -0500
Message-Id: <20210613143155.836591-1-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

"zdiff3" is identical to ordinary diff3, only it allows more aggressive
compaction than diff3. This way the displayed base isn't necessary
technically correct, but still this mode might help resolving merge
conflicts between two near identical additions.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---

I'm re-sending this patch from 2013 because I do think it provides value
and we might want to make it the default.

I hardcoded diff3 to be zdiff3 and all the tests passed, so if our tests
don't care about the simplification level of diff3 perhaps many (or even
most) our users don't either.

FTR: this patch applied cleanly.

 builtin/merge-file.c                   | 2 ++
 contrib/completion/git-completion.bash | 2 +-
 xdiff-interface.c                      | 2 ++
 xdiff/xdiff.h                          | 1 +
 xdiff/xmerge.c                         | 8 +++++++-
 5 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/builtin/merge-file.c b/builtin/merge-file.c
index 06a2f90c48..e695867ee5 100644
--- a/builtin/merge-file.c
+++ b/builtin/merge-file.c
@@ -34,6 +34,8 @@ int cmd_merge_file(int argc, const char **argv, const char *prefix)
 	struct option options[] = {
 		OPT_BOOL('p', "stdout", &to_stdout, N_("send results to standard output")),
 		OPT_SET_INT(0, "diff3", &xmp.style, N_("use a diff3 based merge"), XDL_MERGE_DIFF3),
+		OPT_SET_INT(0, "zdiff3", &xmp.style, N_("use a zealous diff3 based merge"),
+				XDL_MERGE_ZEALOUS_DIFF3),
 		OPT_SET_INT(0, "ours", &xmp.favor, N_("for conflicts, use our version"),
 			    XDL_MERGE_FAVOR_OURS),
 		OPT_SET_INT(0, "theirs", &xmp.favor, N_("for conflicts, use their version"),
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index b50c5d0ea3..8594559298 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1566,7 +1566,7 @@ _git_checkout ()
 
 	case "$cur" in
 	--conflict=*)
-		__gitcomp "diff3 merge" "" "${cur##--conflict=}"
+		__gitcomp "diff3 merge zdiff3" "" "${cur##--conflict=}"
 		;;
 	--*)
 		__gitcomp_builtin checkout
diff --git a/xdiff-interface.c b/xdiff-interface.c
index 609615db2c..9977813a9d 100644
--- a/xdiff-interface.c
+++ b/xdiff-interface.c
@@ -308,6 +308,8 @@ int git_xmerge_config(const char *var, const char *value, void *cb)
 			die("'%s' is not a boolean", var);
 		if (!strcmp(value, "diff3"))
 			git_xmerge_style = XDL_MERGE_DIFF3;
+		else if (!strcmp(value, "zdiff3"))
+			git_xmerge_style = XDL_MERGE_ZEALOUS_DIFF3;
 		else if (!strcmp(value, "merge"))
 			git_xmerge_style = 0;
 		/*
diff --git a/xdiff/xdiff.h b/xdiff/xdiff.h
index 7a04605146..8629ae287c 100644
--- a/xdiff/xdiff.h
+++ b/xdiff/xdiff.h
@@ -65,6 +65,7 @@ extern "C" {
 
 /* merge output styles */
 #define XDL_MERGE_DIFF3 1
+#define XDL_MERGE_ZEALOUS_DIFF3 2
 
 typedef struct s_mmfile {
 	char *ptr;
diff --git a/xdiff/xmerge.c b/xdiff/xmerge.c
index 1659edb453..95871a0b6e 100644
--- a/xdiff/xmerge.c
+++ b/xdiff/xmerge.c
@@ -230,7 +230,7 @@ static int fill_conflict_hunk(xdfenv_t *xe1, const char *name1,
 	size += xdl_recs_copy(xe1, m->i1, m->chg1, needs_cr, 1,
 			      dest ? dest + size : NULL);
 
-	if (style == XDL_MERGE_DIFF3) {
+	if (style == XDL_MERGE_DIFF3 || style == XDL_MERGE_ZEALOUS_DIFF3) {
 		/* Shared preimage */
 		if (!dest) {
 			size += marker_size + 1 + needs_cr + marker3_size;
@@ -482,6 +482,12 @@ static int xdl_do_merge(xdfenv_t *xe1, xdchange_t *xscr1,
 	int style = xmp->style;
 	int favor = xmp->favor;
 
+	/*
+	 * This is the only change between XDL_MERGE_DIFF3 and
+	 * XDL_MERGE_ZEALOUS_DIFF3. "zdiff3" isn't 100% technically correct (as
+	 * the base might be considerably simplified), but still it might help
+	 * interpreting conflicts between two big and near identical additions.
+	 */
 	if (style == XDL_MERGE_DIFF3) {
 		/*
 		 * "diff3 -m" output does not make sense for anything
-- 
2.32.0

