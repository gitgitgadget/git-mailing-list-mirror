Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A051C43460
	for <git@archiver.kernel.org>; Fri,  7 May 2021 04:05:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 728E261076
	for <git@archiver.kernel.org>; Fri,  7 May 2021 04:05:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230022AbhEGEGJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 May 2021 00:06:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbhEGEGG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 May 2021 00:06:06 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB256C06138A
        for <git@vger.kernel.org>; Thu,  6 May 2021 21:05:05 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id l2so7679709wrm.9
        for <git@vger.kernel.org>; Thu, 06 May 2021 21:05:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=0e4RrCJuKuAV6s9KmC98iAx1qWZSkyg2U2VQQvqOO0E=;
        b=NcF8oNBbFpq/WdT6o5VY3METqwQXMPhIlg/Ea+fqfrzk7HcGRN8E/jqOMYD5wdKzmk
         1K8D6jSUFUeApLDdcR12euWkM1IMfyb0igqPDa0HZr+MlZGWgUYtgFll4mrWagfzdV5x
         nndxDjDEmjNaznX236pFV4LWEX3BP7Pyy12L4NxyTITxUW7eV5GI1QdUmzRGKv3KpMqq
         6BEcgjmUcWutAYsvM2+3f5ETuT10qDmGTcdkogHEIeCatNrNLy9qaTlnLdDlL6X2TfI3
         ke1w6/OhSQIaJUd1JxlxBFtXvVkMGYx5m0VKkoqNWoivvrC4qVC4paMhrO04IdnHWY1H
         GtrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=0e4RrCJuKuAV6s9KmC98iAx1qWZSkyg2U2VQQvqOO0E=;
        b=nW2RqGFQeg9hmORhCYtRYlsEfzBCEhdsL/EUYiqBfSzBAKGrP9az0+YaYzQ1InzKgV
         g9y/wkmZXOXA+boCk6I3gKBgIkKUDcWcycCUafiv572ODq3Bh9QhDhu3GkJvh8+pQ+u4
         rTckSES0JVFu4tgs9sQkuvYUwidKq6zuHirMaeigveGgJCjJg8vVuMlCXdJ4/p922YYO
         oDxyLWP3J4uV9XRys3+QVVrqxfh5IOdfxocswmMlKZzKOARe3ojUfdREKZtjchGyJFvI
         R7cz0HBnPHbEnwGt3bPvXTOZ5uaGtMwQxyjRXKqImR9Bq/E+lY4eIBBqmZTXPdIaut3J
         KzNA==
X-Gm-Message-State: AOAM532cAD48R3SrAxQ2yPu3Ld2IUxynT8U4ayUEK8AehKqJiVGntsTj
        NVbNf15710gtPsKBfnU3z2Pd7Yu1nsY=
X-Google-Smtp-Source: ABdhPJw6waGUVhahrJRkOQp7ez98/xQPxcIqNro7Gt8JzqQMVppX9J1d9iokfxEddZWpi3eOQJFzQA==
X-Received: by 2002:a5d:6752:: with SMTP id l18mr9221953wrw.422.1620360304471;
        Thu, 06 May 2021 21:05:04 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n22sm11118008wmo.12.2021.05.06.21.05.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 May 2021 21:05:04 -0700 (PDT)
Message-Id: <3d8dd00ccd10d6b7ce9f928f31f8a04e885730fc.1620360300.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1020.git.git.1620360300.gitgitgadget@gmail.com>
References: <pull.1020.git.git.1620360300.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 07 May 2021 04:05:00 +0000
Subject: [PATCH 5/5] [RFC] ls-files: error out on -i unless -o or -c are
 specified
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

ls-files --ignored can be used together with either --others or
--cached.  After being perplexed for a bit and digging in to the code, I
assumed that ls-files -i was just broken and not printing anything and
had a nice patch ready to submit when I finally realized that -i can be
used with --cached to find tracked ignores.

While that was a mistake on my part, and a careful reading of the
documentation could have made this more clear, I suspect this is an
error others are likely to make as well.  In fact, of two uses in our
testsuite, I believe one of the two did make this error.  In t1306.13,
there are NO tracked files, and all the excludes built up and used in
that test and in previous tests thus have to be about untracked files.
However, since they were looking for an empty result, the mistake went
unnoticed as their erroneous command also just happened to give an empty
answer.

-i will most the time be used with -o, which would suggest we could just
make -i imply -o in the absence of either a -o or -c, but that would be
a backward incompatible break.  Instead, let's just flag -i without
either a -o or -c as an error, and update the two relevant testcases to
specify their intent.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/ls-files.c          | 3 +++
 t/t1306-xdg-files.sh        | 2 +-
 t/t3003-ls-files-exclude.sh | 4 ++--
 3 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index 60a2913a01e9..9f74b1ab2e69 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -748,6 +748,9 @@ int cmd_ls_files(int argc, const char **argv, const char *cmd_prefix)
 	if (pathspec.nr && error_unmatch)
 		ps_matched = xcalloc(pathspec.nr, 1);
 
+	if ((dir.flags & DIR_SHOW_IGNORED) && !show_others && !show_cached)
+		die("ls-files --ignored is usually used with --others, but --cached is the default.  Please specify which you want.");
+
 	if ((dir.flags & DIR_SHOW_IGNORED) && !exc_given)
 		die("ls-files --ignored needs some exclude pattern");
 
diff --git a/t/t1306-xdg-files.sh b/t/t1306-xdg-files.sh
index dd87b43be1a6..40d3c42618c0 100755
--- a/t/t1306-xdg-files.sh
+++ b/t/t1306-xdg-files.sh
@@ -116,7 +116,7 @@ test_expect_success 'Exclusion in a non-XDG global ignore file' '
 test_expect_success 'Checking XDG ignore file when HOME is unset' '
 	(sane_unset HOME &&
 	 git config --unset core.excludesfile &&
-	 git ls-files --exclude-standard --ignored >actual) &&
+	 git ls-files --exclude-standard --ignored --others >actual) &&
 	test_must_be_empty actual
 '
 
diff --git a/t/t3003-ls-files-exclude.sh b/t/t3003-ls-files-exclude.sh
index d5ec333131f9..c41c4f046abf 100755
--- a/t/t3003-ls-files-exclude.sh
+++ b/t/t3003-ls-files-exclude.sh
@@ -29,11 +29,11 @@ test_expect_success 'add file to gitignore' '
 '
 check_all_output
 
-test_expect_success 'ls-files -i lists only tracked-but-ignored files' '
+test_expect_success 'ls-files -i -c lists only tracked-but-ignored files' '
 	echo content >other-file &&
 	git add other-file &&
 	echo file >expect &&
-	git ls-files -i --exclude-standard >output &&
+	git ls-files -i -c --exclude-standard >output &&
 	test_cmp expect output
 '
 
-- 
gitgitgadget
