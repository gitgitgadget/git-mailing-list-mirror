Return-Path: <SRS0=FxFb=2J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2872EC2D0D2
	for <git@archiver.kernel.org>; Thu, 19 Dec 2019 21:28:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1E4824682
	for <git@archiver.kernel.org>; Thu, 19 Dec 2019 21:28:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NeWv1e5Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727186AbfLSV2c (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Dec 2019 16:28:32 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:43138 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726880AbfLSV2c (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Dec 2019 16:28:32 -0500
Received: by mail-ed1-f65.google.com with SMTP id dc19so6291772edb.10
        for <git@vger.kernel.org>; Thu, 19 Dec 2019 13:28:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=O5bdAKERjFqZXYHkEGuYnzcy5g3lzmd91EZmqMjMLxI=;
        b=NeWv1e5QDv0+ikTrCaAiIv8RwsazFOO/R9WYl57oqw3GZzPTjn7N3riOY81uLSyfT0
         igUN7ELuNBaMHBenVZEP5j9j1I8hzmzYCv0NC2Ns5CkqZHl4IFU7ABaI2a0AwbOnVk25
         530DyRIPQXCWADUyC4u8IKHO4iOJfza8IZ6LjPLJWEgK4FWOpKEyN8FYEZ/8s5OAOCky
         apINquSpu8MagCX7kVrdLRvbCBwysa/21nrAaVV74Dvli5szHovaFvvqY/rHCcmre8W1
         dH4+FO/0op22EqO9YhqJeyyyeYxTY6t4vKc4D71B9Gj0BeCVGm8CRI+kiY5vckP+CqSj
         mktw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=O5bdAKERjFqZXYHkEGuYnzcy5g3lzmd91EZmqMjMLxI=;
        b=GvmK59xrU4d8TOTZh/X7Ub4tfe/pz1gAWxlaG7v1qxMp4FeaPXxFeMR/L3bAYoLVZQ
         OfSypFzmD4EqHtFmJ1KVoiJobCe5/MIz+t7pVlhHSZGw8QfaDJIy2WZCsKt3pmIl/5Eo
         OhrvcueTMqzMYC3+uPrep54ruSOf8vIAp7q5iGZLzOJTgEfzsdQ0He6WjZgavSQwcR+e
         HZ3VMtA4eJXALu2K7Dd2atWKfX0k7eKHz8Ntz4U0PzsQgJ3W+BoY3FQhIKsFPypYbj/4
         2kjg+eoT9u8awN6qtMnjev5Y8V2fOgr0StqZcxCsI5RHFhLUn5xqanqX5XBNJPqf2Inu
         lvSw==
X-Gm-Message-State: APjAAAVUSHvz92B8MJsOJ1yemRRtx6mmh+5AaKDgMrFw9LyoLVeu9FTt
        evuYg+JoE2QDbUaf0dF1GKY5wg/J
X-Google-Smtp-Source: APXvYqybXMm3UXLxcr8Cw1VwfjNshh8F1mLbLiib+dKI0WzKbCSr/m5Y7NCLzinWiP5DM4tw+/9hwQ==
X-Received: by 2002:a17:906:5358:: with SMTP id j24mr12396133ejo.44.1576790910174;
        Thu, 19 Dec 2019 13:28:30 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l11sm768667ejq.4.2019.12.19.13.28.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Dec 2019 13:28:29 -0800 (PST)
Message-Id: <79f2b561742372234a52dc7194dd72026c6e96ec.1576790906.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.676.v5.git.git.1576790906.gitgitgadget@gmail.com>
References: <pull.676.v4.git.git.1576697386.gitgitgadget@gmail.com>
        <pull.676.v5.git.git.1576790906.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 19 Dec 2019 21:28:20 +0000
Subject: [PATCH v5 2/8] Revert "dir.c: make 'git-status --ignored' work within
 leading directories"
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     blees@dcon.de, gitster@pobox.com, kyle@kyleam.com,
        sxlijin@gmail.com, Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Commit be8a84c52669 ("dir.c: make 'git-status --ignored' work within
leading directories", 2013-04-15) noted that
   git status --ignored <SOMEPATH>
would not list ignored files and directories within <SOMEPATH> if
<SOMEPATH> was untracked, and modified the behavior to make it show
them.  However, it did so via a hack that broke consistency; it would
show paths under <SOMEPATH> differently than a simple
   git status --ignored | grep <SOMEPATH>
would show them.  A correct fix is slightly more involved, and
complicated slightly by this hack, so we revert this commit (but keep
corrected versions of the testcases) and will later fix the original
bug with a subsequent patch.

Some history may be helpful:

A very, very similar case to the commit we are reverting was raised in
commit 48ffef966c76 ("ls-files: fix overeager pathspec optimization",
2010-01-08); but it actually went in somewhat the opposite direction.  In
that commit, it mentioned how
   git ls-files -o --exclude-standard t/
used to show untracked files under t/ even when t/ was ignored, and then
changed the behavior to stop showing untracked files under an ignored
directory.  More importantly, this commit considered keeping this
behavior but noted that it would be inconsistent with the behavior when
multiple pathspecs were specified and thus rejected it.

The reason for this whole inconsistency when one pathspec is specified
versus zero or two is because common prefixes of pathspecs are sent
through a different set of checks (in treat_leading_path()) than normal
file/directory traversal (those go through read_directory_recursive()
and treat_path()).  As such, for consistency, one needs to check that
both codepaths produce the same result.

Revert commit be8a84c526691667fc04a8241d93a3de1de298ab, except instead
of removing the testcase it added, modify it to check for correct and
consistent behavior.  A subsequent patch in this series will fix the
testcase.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 dir.c                      | 3 ---
 t/t7061-wtstatus-ignore.sh | 9 +++++++--
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/dir.c b/dir.c
index 61f559f980..0dd5266629 100644
--- a/dir.c
+++ b/dir.c
@@ -2083,14 +2083,12 @@ static int treat_leading_path(struct dir_struct *dir,
 	struct strbuf sb = STRBUF_INIT;
 	int baselen, rc = 0;
 	const char *cp;
-	int old_flags = dir->flags;
 
 	while (len && path[len - 1] == '/')
 		len--;
 	if (!len)
 		return 1;
 	baselen = 0;
-	dir->flags &= ~DIR_SHOW_OTHER_DIRECTORIES;
 	while (1) {
 		cp = path + baselen + !!baselen;
 		cp = memchr(cp, '/', path + len - cp);
@@ -2113,7 +2111,6 @@ static int treat_leading_path(struct dir_struct *dir,
 		}
 	}
 	strbuf_release(&sb);
-	dir->flags = old_flags;
 	return rc;
 }
 
diff --git a/t/t7061-wtstatus-ignore.sh b/t/t7061-wtstatus-ignore.sh
index 0c394cf995..84366050da 100755
--- a/t/t7061-wtstatus-ignore.sh
+++ b/t/t7061-wtstatus-ignore.sh
@@ -43,11 +43,16 @@ test_expect_success 'status untracked directory with --ignored -u' '
 	test_cmp expected actual
 '
 cat >expected <<\EOF
-?? untracked/uncommitted
+?? untracked/
 !! untracked/ignored
 EOF
 
-test_expect_success 'status prefixed untracked directory with --ignored' '
+test_expect_failure 'status of untracked directory with --ignored works with or without prefix' '
+	git status --porcelain --ignored >tmp &&
+	grep untracked/ tmp >actual &&
+	rm tmp &&
+	test_cmp expected actual &&
+
 	git status --porcelain --ignored untracked/ >actual &&
 	test_cmp expected actual
 '
-- 
gitgitgadget

