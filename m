Return-Path: <SRS0=MFMM=EH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14B9EC56201
	for <git@archiver.kernel.org>; Sun,  1 Nov 2020 17:28:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D35C322265
	for <git@archiver.kernel.org>; Sun,  1 Nov 2020 17:28:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="geZ0KJmJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727181AbgKAR25 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 1 Nov 2020 12:28:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727167AbgKAR24 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Nov 2020 12:28:56 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE521C0617A6
        for <git@vger.kernel.org>; Sun,  1 Nov 2020 09:28:55 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id b8so11950423wrn.0
        for <git@vger.kernel.org>; Sun, 01 Nov 2020 09:28:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=pvTbOkVCej7vBaecVN/j5bcrCnYzWqRKkM9jAV/hLb8=;
        b=geZ0KJmJJQ4yTBZcCXBWmCMmsiTPoeDcQMa2OyTq6ho3KnA7P1dHWDEm2Rp17DgMG4
         e837QTusbTOyIDlKKg1kC8m355ewj4RxENxptGmhpL+tLFMQE/aFcdGHiOJuiwIJiNfF
         HCpTU8cIFOa9GYdzGppv35yo39Cz2eEFyjck77IeibHBWjdITmSCjeCeWgq5xrbegmCl
         Esi2f6De1GqNORAOnYApjbfyno+V4zu4bWtJLmfOLv6kc2A6BzVjiYhc/IU1UiTMquL4
         /jRPh/nnmrFvIVVG6EWeNeXm0cdbaL4A3dMSlt86YIecxlpyVW5sNPOhQ8Z3pGz1ZzVu
         V/mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=pvTbOkVCej7vBaecVN/j5bcrCnYzWqRKkM9jAV/hLb8=;
        b=SynQyUVROYlIjoOBZJIll7blF88lUZ+dKGQ6/FfVhkca5jPmIOWHqgddszi5fawm4D
         qFqXl7xEZ+jEpkI697szrhwlMtBxg3gNLh55veUNwe/SUZjO+xhRzNqJXebrqxzXjBef
         krPWAs1OESeumsqyGLuLvy1VCsJ0DgWWXGQJe2Anb3N4nGpq/BP1VCVdkrm2I/fGWAci
         DXBICGzMc+aEi3B8SgzEQP86wqjM4T0Eu/aV9BlJe0bun4nKnHFXFC7UEH8onqpnC8k6
         DhWlkaEnUqhN9i7feHLBoJ9xDs4bXMqR/BKzZh0b8Wk0rchpbZ+SfSNdh+3Q26TQi3Jm
         PK/w==
X-Gm-Message-State: AOAM531YUrLQbElfTzzVrsY7kzpzJ2U7N8RnxFbvd1tQCtwBP5qlYErS
        B2NpnF2lJs/QeA3z0dEYdtLIR9YTg08=
X-Google-Smtp-Source: ABdhPJwH6NHEiAqOlYonwRy4BWB8njk+a5z4vLUmWgcrkxNz74ynp0xT85bEtqJJOroD/aCtlTRk4Q==
X-Received: by 2002:adf:e610:: with SMTP id p16mr8720477wrm.302.1604251734221;
        Sun, 01 Nov 2020 09:28:54 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x65sm12063590wmg.1.2020.11.01.09.28.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2020 09:28:53 -0800 (PST)
Message-Id: <c77108e864afe8c60018248923ff75cdef05efb4.1604251728.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.774.v2.git.1604251727.gitgitgadget@gmail.com>
References: <pull.774.git.1603889270.gitgitgadget@gmail.com>
        <pull.774.v2.git.1604251727.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 01 Nov 2020 17:28:45 +0000
Subject: [PATCH v2 6/8] blame: enable funcname blaming with userdiff driver
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Philippe Blain <levraiphilippeblain@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Philippe Blain <levraiphilippeblain@gmail.com>

In blame.c::cmd_blame, we send the 'path' field of the 'sb' 'struct
blame_scoreboard' as the 'path' argument to
'line-range.c::parse_range_arg', but 'sb.path' is not set yet; it's set
to the local variable 'path' a few lines later at line 1137.

This 'path' argument is only used in 'parse_range_arg' if we are blaming
a funcname, i.e. `git blame -L :<funcname> <path>`, and in that case it
is sent to 'parse_range_funcname', where it is used to determine if a
userdiff driver should be used for said <path> to match the given
funcname.

Since 'path' is yet unset, the userdiff driver is never used, so we fall
back to the default funcname regex, which is usually not appropriate for
paths that are set to use a specific userdiff driver, and thus either we
match some unrelated lines, or we die with

    fatal: -L parameter '<funcname>' starting at line 1: no match

This has been the case ever since `git blame` learned to blame a
funcname in 13b8f68c1f (log -L: :pattern:file syntax to find by
funcname, 2013-03-28).

Enable funcname blaming for paths using specific userdiff drivers by
initializing 'sb.path' earlier in 'cmd_blame', when some of its other
fields are initialized, so that it is set when passed to
'parse_range_arg'.

Add a regression test in 'annotate-tests.sh', which is sourced in
t8001-annotate.sh and t8002-blame.sh, leveraging an existing file used
to test the userdiff patterns in t4018-diff-funcname.

Also, use 'sb.path' instead of 'path' when constructing the error
message at line 1114, for consistency.

Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
---
 builtin/blame.c     |  4 ++--
 t/annotate-tests.sh | 18 ++++++++++++++++++
 2 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index 224b6f18d4..f2e528fcbc 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -1081,6 +1081,7 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 	sb.contents_from = contents_from;
 	sb.reverse = reverse;
 	sb.repo = the_repository;
+	sb.path = path;
 	build_ignorelist(&sb, &ignore_revs_file_list, &ignore_rev_list);
 	string_list_clear(&ignore_revs_file_list, 0);
 	string_list_clear(&ignore_rev_list, 0);
@@ -1110,7 +1111,7 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 		if ((!lno && (top || bottom)) || lno < bottom)
 			die(Q_("file %s has only %lu line",
 			       "file %s has only %lu lines",
-			       lno), path, lno);
+			       lno), sb.path, lno);
 		if (bottom < 1)
 			bottom = 1;
 		if (top < 1 || lno < top)
@@ -1135,7 +1136,6 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 	string_list_clear(&range_list, 0);
 
 	sb.ent = NULL;
-	sb.path = path;
 
 	if (blame_move_score)
 		sb.move_score = blame_move_score;
diff --git a/t/annotate-tests.sh b/t/annotate-tests.sh
index d933af5714..3aee61d2cc 100644
--- a/t/annotate-tests.sh
+++ b/t/annotate-tests.sh
@@ -479,6 +479,24 @@ test_expect_success 'blame -L ^:RE (absolute: end-of-file)' '
 	check_count -f hello.c -L$n -L^:ma.. F 4 G 1 H 1
 '
 
+test_expect_success 'setup -L :funcname with userdiff driver' '
+	echo "fortran-* diff=fortran" >.gitattributes &&
+	fortran_file=fortran-external-function &&
+	orig_file="$TEST_DIRECTORY/t4018/$fortran_file" &&
+	cp $orig_file . &&
+	git add $fortran_file &&
+	GIT_AUTHOR_NAME="A" GIT_AUTHOR_EMAIL="A@test.git" \
+	git commit -m "add fortran file" &&
+	sed -e "s/ChangeMe/IWasChanged/" <"$orig_file" >$fortran_file &&
+	git add $fortran_file &&
+	GIT_AUTHOR_NAME="B" GIT_AUTHOR_EMAIL="B@test.git" \
+	git commit -m "change fortran file"
+'
+
+test_expect_success 'blame -L :funcname with userdiff driver' '
+	check_count -f fortran-external-function -L:RIGHT A 7 B 1
+'
+
 test_expect_success 'setup incremental' '
 	(
 	GIT_AUTHOR_NAME=I &&
-- 
gitgitgadget

