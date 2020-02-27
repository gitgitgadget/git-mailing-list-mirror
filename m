Return-Path: <SRS0=G+lC=4P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EAE3C4BA24
	for <git@archiver.kernel.org>; Thu, 27 Feb 2020 00:14:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74F2C24650
	for <git@archiver.kernel.org>; Thu, 27 Feb 2020 00:14:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bg4r4jyi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728101AbgB0AOd (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Feb 2020 19:14:33 -0500
Received: from mail-wm1-f46.google.com ([209.85.128.46]:51127 "EHLO
        mail-wm1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728063AbgB0AOb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Feb 2020 19:14:31 -0500
Received: by mail-wm1-f46.google.com with SMTP id a5so1482280wmb.0
        for <git@vger.kernel.org>; Wed, 26 Feb 2020 16:14:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=owXpXZjSOk6raWlvCMX3fGYD2Nbscjr4e1+1p7riyqc=;
        b=Bg4r4jyisqAhWHSNa0eCUTVqwyAMSBUcDKRGLDlA/xg9pXmZiatiLibbPrbGN5aoMc
         9QNPaUnndclaARu1URWLIe9cZfyfUp7kZws8Wn2EPeM39os/FrBxmCpHu+ZEjDTGEWPA
         olzn5q6vg8XhE85apfG8cM/dwnSSvamRRBbW1VPHBcoHBZ/YyxLcRsrnvKd1gGSkPGRE
         YziiM03ayKEf1vOyeVOzU4y1roXWcHdB3lDpEXeqxjISZYz25NerHkkKqDvQb2jLbrJu
         R69A4RQCJK1sT5tUzfRPEgIMZsZKfsrSbIGIGJkVyqNy3DfLeMi8TOiBGg/MvDAqQCxh
         HxGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=owXpXZjSOk6raWlvCMX3fGYD2Nbscjr4e1+1p7riyqc=;
        b=NNwzWg3pYrlMzHPJ5lMsiJOETC+FDhB92rRIWFyFymiktw4rNJcgmv2vPcbi+Cgp35
         Rvc3ZFJkwawmsn1a6dqzPV/P8pKj8IJCLK1xYEktTygbUoiR5LevpJw3lcH3Khak1g7u
         eQYDcDKeviFc1gr0216ZbZOOVBqohChRB4tme4Ds0IMc1tMCXGEq9hinpNiioGDVIiE9
         MDUAbBDp0qPTrRjFtVCTUuS7x/ZBhkh7R/1OT4Ma4+758Xqhw0LmCo19QXYnrl9LE73A
         nIMzq7/1Iv8hEwmh/41gt1h5FvFzaYWigX6JDins253Kl8mseQzEnJ4WhuKYgMaq/Hqb
         f1tQ==
X-Gm-Message-State: APjAAAWPMXC7lmAI2WlYdMKwrn0pNxqdHTLeh4+1p+1t80t9cLeVX/AP
        E90yQQDZSrOzjkHN5GyRVaFD0c82
X-Google-Smtp-Source: APXvYqzq6B5lUg0nddmFHeOLfcFviTMqTsNhvkBmSuqpwTMEg6H0WEi+Gldcz7HGGqot4+hArO61ug==
X-Received: by 2002:a7b:c1cf:: with SMTP id a15mr1462202wmj.85.1582762469569;
        Wed, 26 Feb 2020 16:14:29 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p17sm3039111wre.89.2020.02.26.16.14.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2020 16:14:29 -0800 (PST)
Message-Id: <911de63afa274b0791e4d4252934a5e9b0031f10.1582762465.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.716.git.git.1582762465.gitgitgadget@gmail.com>
References: <pull.716.git.git.1582762465.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 27 Feb 2020 00:14:24 +0000
Subject: [PATCH 5/5] t6020: new test with interleaved lexicographic ordering
 of directories
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Elijah Newren <newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

If a repository has two files:
    foo/bar/baz
    foo/bar-2/baz
then a simple lexicographic ordering of files and directories shows
    ...
    foo/bar
    foo/bar-2
    foo/bar/baz
    ...
and the appearance of foo/bar-2 between foo/bar and foo/bar/baz can trip
up some codepaths.  Add a test to catch such cases.

t6020 might be a slight misfit since this testcase does not test any
kind of file/directory conflict.  However, it is similar in spirit to
some tests (4-6) already in t6020 that check cases where a *file* sorted
between a directory and the files underneath that directory.  This
testcase differs in that now there is a *directory* that sorts in the
middle.

Although merge-recursive currently has no problems with this simple
testcase, I discovered that it's very possible to accidentally mess it
up.  Further, we have no other merge or cherry-pick or rebase testcases
in the entire testsuite that cover such a case, so I felt like it would
be a worthwhile addition to the testsuite.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t6020-merge-df.sh | 43 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/t/t6020-merge-df.sh b/t/t6020-merge-df.sh
index cf662068da1..400a4cd1392 100755
--- a/t/t6020-merge-df.sh
+++ b/t/t6020-merge-df.sh
@@ -104,4 +104,47 @@ test_expect_success 'modify/delete + directory/file conflict; other way' '
 	test_path_is_file letters~HEAD
 '
 
+test_expect_success 'Simple merge in repo with interesting pathnames' '
+	# Simple lexicographic ordering of files and directories would be:
+	#     foo
+	#     foo/bar
+	#     foo/bar-2
+	#     foo/bar/baz
+	#     foo/bar-2/baz
+	# The fact that foo/bar-2 appears between foo/bar and foo/bar/baz
+	# can trip up some codepaths, and is the point of this test.
+	test_create_repo name-ordering &&
+	(
+		cd name-ordering &&
+
+		mkdir -p foo/bar &&
+		mkdir -p foo/bar-2 &&
+		>foo/bar/baz &&
+		>foo/bar-2/baz &&
+		git add . &&
+		git commit -m initial &&
+
+		git branch main &&
+		git branch other &&
+
+		git checkout other &&
+		echo other >foo/bar-2/baz &&
+		git add -u &&
+		git commit -m other &&
+
+		git checkout main &&
+		echo main >foo/bar/baz &&
+		git add -u &&
+		git commit -m main &&
+
+		git merge other &&
+		git ls-files -s >out &&
+		test_line_count = 2 out &&
+		git rev-parse :0:foo/bar/baz :0:foo/bar-2/baz >actual &&
+		git rev-parse HEAD~1:foo/bar/baz other:foo/bar-2/baz >expect &&
+		test_cmp expect actual
+	)
+
+'
+
 test_done
-- 
gitgitgadget
