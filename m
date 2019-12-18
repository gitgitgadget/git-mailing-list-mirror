Return-Path: <SRS0=Z/Vr=2I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDFEDC2D0BF
	for <git@archiver.kernel.org>; Wed, 18 Dec 2019 19:29:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EA1D206A5
	for <git@archiver.kernel.org>; Wed, 18 Dec 2019 19:29:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ANoIYT9R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727557AbfLRT3w (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Dec 2019 14:29:52 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36933 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727484AbfLRT3v (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Dec 2019 14:29:51 -0500
Received: by mail-wm1-f65.google.com with SMTP id f129so3194193wmf.2
        for <git@vger.kernel.org>; Wed, 18 Dec 2019 11:29:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=O5bdAKERjFqZXYHkEGuYnzcy5g3lzmd91EZmqMjMLxI=;
        b=ANoIYT9RmotzFGAC7755K52g45bkv6qRWoMjZrqepOAUOQ6m1O8vLE3BzfOd2L0pfO
         5cYk+L4NJ25b/M9V55UoLN/nwifi1XkBRwzlPNmyQIUz9rzVV8YpJcxEMtwR9Y3U1PkT
         T6nIrzQokva/G53uM4gktKBDjoPgsjZtq3m8LIjDo1LbrpMZRA+jrPcAMruo/IUnsb3V
         7OLE2yQZm7q4Ao8i0YxzMSAShTSJQTdIpEAkoe0qTFrYYtDKHoNdB7TS9RRD5UNNXEPE
         WB7k+imzLZtm6RBmBN3vMMYeZTlUHhk3vQQzCTP2/60NMganCcL7yUyQaTU/kTDjO/Gm
         477w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=O5bdAKERjFqZXYHkEGuYnzcy5g3lzmd91EZmqMjMLxI=;
        b=eJ+ktsq4oIvXEUBGGtr7AaZ3tNj6TbGxVjWADm68uOj8qkP1plN9rm6zT2H1KLdWqI
         N+n1rrubeclMntdM5CCgSlBJJYqWLAoM5dkESWb2GvZRzAfob6nYvBw8asLgCI4708qz
         MeNDDLlcGTPKDt/XOe38BuOzepdHneJccPVkXxeMMzpY/BsAMqwOrY6YxIlXh4X4RKun
         JRBGlUmFiForCTEuiGbmJtaWngURCp0rU8ht2xkMU9HQiDYV9ko1a5agZtHCtDJoqyap
         q2DQFAWVZtP/gICkZMPAuZuMUGRhCyKpimB9VFvLuAZw8wKK/LC3W46NLENqsQvzcZ4f
         vIrw==
X-Gm-Message-State: APjAAAUr8K9yHGnBhNB2Kdfr+B5q/WQz5QsJnRrtYIWYMFSTRvlnLbFj
        pdF5+E+wSLQnGpX3EbF27GKu2JWb
X-Google-Smtp-Source: APXvYqweZZgwtAyqq0dvyQRCc/DOwYWKlmUgMoHrQVEr6WW539Oc7XF/ll2/JlGj1FKavfCnn0a4cg==
X-Received: by 2002:a1c:a543:: with SMTP id o64mr4897194wme.73.1576697390002;
        Wed, 18 Dec 2019 11:29:50 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v83sm3574305wmg.16.2019.12.18.11.29.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Dec 2019 11:29:49 -0800 (PST)
Message-Id: <79f2b561742372234a52dc7194dd72026c6e96ec.1576697386.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.676.v4.git.git.1576697386.gitgitgadget@gmail.com>
References: <pull.676.v3.git.git.1576571586.gitgitgadget@gmail.com>
        <pull.676.v4.git.git.1576697386.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 18 Dec 2019 19:29:40 +0000
Subject: [PATCH v4 2/8] Revert "dir.c: make 'git-status --ignored' work within
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

