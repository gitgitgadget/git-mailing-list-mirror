Return-Path: <SRS0=B37d=3G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA526C33C9E
	for <git@archiver.kernel.org>; Fri, 17 Jan 2020 20:44:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAE7A2072E
	for <git@archiver.kernel.org>; Fri, 17 Jan 2020 20:44:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MUu1t4nT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729792AbgAQUoy (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Jan 2020 15:44:54 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:44998 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729684AbgAQUoy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Jan 2020 15:44:54 -0500
Received: by mail-pl1-f193.google.com with SMTP id az3so10306380plb.11
        for <git@vger.kernel.org>; Fri, 17 Jan 2020 12:44:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=40ZTcfDlFLunQq8bCXR5tpFIJvrH/nDhTSeCDfIKH+U=;
        b=MUu1t4nTI0aOjM63kgX7iLj8OJRUU46G/ibDvOVgNT/CmgHH3iO0j9fu7qNxZ/KukY
         ZraOpoq7yHLBXCCAyQIXScbg7ndeo9VRuQK4njtElKMYSzSXj5TeT1zTDh99c4p2mLNf
         nsCWA3QgVq5yxSRe3pMfhoCApg1FHYURQY8bBC8Wp/6nV6F2SdDBElSaAgDQXKbfjPEN
         L6yq1OWOLVvqblukF30HtQre7MjxN3yLN6ct/5THh+lPWxKFI8bNlZ6B+pCC3g1a7hy8
         vpsg3KVLEpPUI0oc26ol8nuJyCd2+jlykQdP5DQR4BUrkTqAYy5LjyIfKVZXhI6l0/2S
         rPUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=40ZTcfDlFLunQq8bCXR5tpFIJvrH/nDhTSeCDfIKH+U=;
        b=ZngxSNHNYVugCxChZzAJpVb/vPnyK/1ahrPUqJIRWzTlVTEM8bvi0jkAVboBmoAWKt
         ZYiq80VNG3Nfpwl1o3GTTyLbmuyl282aCeSc4W5GhrZluC4YPHwECV1KuM4V9lPFrphI
         /Xx3iClTygZtrU5bkZYDzucLGljiOccz1ibw0Bes+XlMXvP5AvKA97PYSCVlcZmSp0Dh
         idgDGz1iy2D4YY5ygvXPW56JuS+rVrRJwCBWE0vuUHUV7Mkhamexpd/tzBFZU9gOj4Vq
         1Qlk/xnj3mtJphJ8eAr/1bdaX7XA8G0DE8xEaOBoeBRNkXMBgV7KIbrnsPTWWQ3gcMYK
         6dQg==
X-Gm-Message-State: APjAAAUJm20rizm0N+PkW00XzqeUfZbeGmefNT+qBYKOJioqVeWD0kPb
        POXvQ+xWQfFlXdlCMV2nViJqF5v8zZvNug==
X-Google-Smtp-Source: APXvYqwLW2gP1tqdpsFt2j29/lDeNgEDM0pSGefnroQto7o2imIgDFbCmA1guABte+mDUr1vk6Yi7w==
X-Received: by 2002:a17:902:bd94:: with SMTP id q20mr1026128pls.343.1579293893517;
        Fri, 17 Jan 2020 12:44:53 -0800 (PST)
Received: from konoha.iitr.ac.in ([103.37.201.169])
        by smtp.gmail.com with ESMTPSA id u20sm28844190pgf.29.2020.01.17.12.44.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2020 12:44:52 -0800 (PST)
From:   Shourya Shukla <shouryashukla.oo@gmail.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, johannes.schindelin@gmx.de,
        shouryashukla.oo@gmail.com
Subject: [PATCH 1/3] t6025: modernize style
Date:   Sat, 18 Jan 2020 02:14:24 +0530
Message-Id: <20200117204426.9347-2-shouryashukla.oo@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200117204426.9347-1-shouryashukla.oo@gmail.com>
References: <xmqqblr3f1q3.fsf@gitster-ct.c.googlers.com>
 <20200117204426.9347-1-shouryashukla.oo@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The tests in `t6025-merge-symlinks.sh` were written a long time ago, and
has a lot of style violations, including the mixed-use of tabs and spaces,
missing indentations, and other shell script style violations. Update it to
match the CodingGuidelines.

Signed-off-by: Shourya Shukla <shouryashukla.oo@gmail.com>
---
 t/t6025-merge-symlinks.sh | 97 ++++++++++++++++++++-------------------
 1 file changed, 50 insertions(+), 47 deletions(-)

diff --git a/t/t6025-merge-symlinks.sh b/t/t6025-merge-symlinks.sh
index 433c4de08f..7a19ba8520 100755
--- a/t/t6025-merge-symlinks.sh
+++ b/t/t6025-merge-symlinks.sh
@@ -10,52 +10,55 @@ if core.symlinks is false.'
 
 . ./test-lib.sh
 
-test_expect_success \
-'setup' '
-git config core.symlinks false &&
-> file &&
-git add file &&
-git commit -m initial &&
-git branch b-symlink &&
-git branch b-file &&
-l=$(printf file | git hash-object -t blob -w --stdin) &&
-echo "120000 $l	symlink" | git update-index --index-info &&
-git commit -m master &&
-git checkout b-symlink &&
-l=$(printf file-different | git hash-object -t blob -w --stdin) &&
-echo "120000 $l	symlink" | git update-index --index-info &&
-git commit -m b-symlink &&
-git checkout b-file &&
-echo plain-file > symlink &&
-git add symlink &&
-git commit -m b-file'
-
-test_expect_success \
-'merge master into b-symlink, which has a different symbolic link' '
-git checkout b-symlink &&
-test_must_fail git merge master'
-
-test_expect_success \
-'the merge result must be a file' '
-test -f symlink'
-
-test_expect_success \
-'merge master into b-file, which has a file instead of a symbolic link' '
-git reset --hard && git checkout b-file &&
-test_must_fail git merge master'
-
-test_expect_success \
-'the merge result must be a file' '
-test -f symlink'
-
-test_expect_success \
-'merge b-file, which has a file instead of a symbolic link, into master' '
-git reset --hard &&
-git checkout master &&
-test_must_fail git merge b-file'
-
-test_expect_success \
-'the merge result must be a file' '
-test -f symlink'
+test_expect_success 'setup' '
+	git config core.symlinks false &&
+	>file &&
+	git add file &&
+	git commit -m initial &&
+	git branch b-symlink &&
+	git branch b-file &&
+	l=$(printf file | git hash-object -t blob -w --stdin) &&
+	echo "120000 $l	symlink" |
+	git update-index --index-info &&
+	git commit -m master &&
+	git checkout b-symlink &&
+	l=$(printf file-different | git hash-object -t blob -w --stdin) &&
+	echo "120000 $l	symlink" |
+	git update-index --index-info &&
+	git commit -m b-symlink &&
+	git checkout b-file &&
+	echo plain-file >symlink &&
+	git add symlink &&
+	git commit -m b-file
+'
+
+test_expect_success 'merge master into b-symlink, which has a different symbolic link' '
+	git checkout b-symlink &&
+	test_must_fail git merge master
+'
+
+test_expect_success 'the merge result must be a file' '
+	test -f symlink
+'
+
+test_expect_success 'merge master into b-file, which has a file instead of a symbolic link' '
+	git reset --hard &&
+	git checkout b-file &&
+	test_must_fail git merge master
+'
+
+test_expect_success 'the merge result must be a file' '
+	test -f symlink
+'
+
+test_expect_success 'merge b-file, which has a file instead of a symbolic link, into master' '
+	git reset --hard &&
+	git checkout master &&
+	test_must_fail git merge b-file
+'
+
+test_expect_success 'the merge result must be a file' '
+	test -f symlink
+'
 
 test_done
-- 
2.20.1

