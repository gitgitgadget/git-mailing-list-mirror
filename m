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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C002DC433B4
	for <git@archiver.kernel.org>; Tue, 11 May 2021 18:34:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7DD9E61919
	for <git@archiver.kernel.org>; Tue, 11 May 2021 18:34:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231841AbhEKSfX (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 May 2021 14:35:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231789AbhEKSfV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 May 2021 14:35:21 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16EBEC06175F
        for <git@vger.kernel.org>; Tue, 11 May 2021 11:34:14 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id a4so21126073wrr.2
        for <git@vger.kernel.org>; Tue, 11 May 2021 11:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=MB7H5JuJEysZqOtYGFNJ+Q3PBPxGokFYW3/0nzpVPpQ=;
        b=JBSywS05/hRihNnpo65YGlBVjG5Kph9c+THSvTnHqhVf8KJwmz2pEaBkLItA0zfxJ5
         h9F0nsZqUYTxk9maFsoWGgKc/iHOXQog+Hvhy2dmuNhZvMDJEOkIAivg5QClxT6i3AcW
         9RwS6SSrM/G5stS3izZekkx9S7NO7NIQ53A7iXS7xD8HVzyhVR/YrQXmBfXNj7Ck3sNl
         C5D0UGO7TxP/pY/ReiaS4i8eL1zlZDYTWYkjCAr8p43IKgON6XnwEPSxJJC40CiNJqtk
         wndcsBzU16yxIJTJH3kgHPQ0vGDcDdSj7DmBcioYKnA1IPjP25NHBbqz13kYvVuQ+jfC
         +uaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=MB7H5JuJEysZqOtYGFNJ+Q3PBPxGokFYW3/0nzpVPpQ=;
        b=t7CEOBt7oD7UZkTpV8lh9w0avfibkK2L2P1yFiXq2yxGQTP3dQ34X7xG6yThGbf1uV
         4Ef1GsS6lIiQzIWCQjwCQM4i+od3cZUdXV5Ww5O4Niqw2lIqyKffw4SyRkSrfyOFiFSC
         QNn76bHw23AmDk7X7me2j7TKmKGXLSRr2pvV4lWHZTLY8Vdl/9yfzwQm3vfAF2GwVaCS
         SUqzfwdr7Kc3B0lgvYV/4kwrw/PMNjrAEQgtmBy0PKCbVi0To7SYpBGbuVemUynUkoOx
         GvU8ANbMsv/pNlFIkb5OOzjI5lz1lIlPOMqNgel3HvVC8bUGoEkZ4afEGP+wuOxgvUzZ
         /Ufg==
X-Gm-Message-State: AOAM533GuOQSw6HyeRTXEpjgpnaHzh9i50NtXPvVowsOA1rMtLSmRZcS
        VnqmvviqE+EerN0wq4GcaDIvbW30Aec=
X-Google-Smtp-Source: ABdhPJw7jHGjsaCqd+zV2FS40GTyMrH7HJq/MfuOHXHm313zepLOvo57SWRwDaH1H+tWlpjF+8i0Cg==
X-Received: by 2002:adf:fd0b:: with SMTP id e11mr39429776wrr.402.1620758052861;
        Tue, 11 May 2021 11:34:12 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a126sm4212294wmh.37.2021.05.11.11.34.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 May 2021 11:34:12 -0700 (PDT)
Message-Id: <8d0ca8104be628d02b30065009427062887b5e0a.1620758049.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1020.v4.git.git.1620758049.gitgitgadget@gmail.com>
References: <pull.1020.v3.git.git.1620503945.gitgitgadget@gmail.com>
        <pull.1020.v4.git.git.1620758049.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 11 May 2021 18:34:03 +0000
Subject: [PATCH v4 3/8] ls-files: error out on -i unless -o or -c are
 specified
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>, Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Josh Steadmon <steadmon@google.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

ls-files --ignored can be used together with either --others or
--cached.  After being perplexed for a bit and digging in to the code, I
assumed that ls-files -i was just broken and not printing anything and
I had a nice patch ready to submit when I finally realized that -i can be
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
index 60a2913a01e9..e8e25006c647 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -748,6 +748,9 @@ int cmd_ls_files(int argc, const char **argv, const char *cmd_prefix)
 	if (pathspec.nr && error_unmatch)
 		ps_matched = xcalloc(pathspec.nr, 1);
 
+	if ((dir.flags & DIR_SHOW_IGNORED) && !show_others && !show_cached)
+		die("ls-files -i must be used with either -o or -c");
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

