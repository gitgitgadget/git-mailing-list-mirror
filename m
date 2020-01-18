Return-Path: <SRS0=dClv=3H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DEC0C33CB1
	for <git@archiver.kernel.org>; Sat, 18 Jan 2020 08:33:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12A8E2468B
	for <git@archiver.kernel.org>; Sat, 18 Jan 2020 08:33:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bgJxT6s7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726819AbgARIdu (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 18 Jan 2020 03:33:50 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:38334 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726509AbgARIdu (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Jan 2020 03:33:50 -0500
Received: by mail-pl1-f196.google.com with SMTP id f20so10873698plj.5
        for <git@vger.kernel.org>; Sat, 18 Jan 2020 00:33:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=j5g/zU+696PeVmCC3WI7qXsAe3l0QgzXurFGkS4msws=;
        b=bgJxT6s7sanh36NRVrOUeKmFrCyZlgTsxMMM+KI9imOyk48EBUlmM18fkX+1YIpM3j
         W3Bj3G4b3unjg3ptOUBrTY9doqG+1RJPzWRBGsEB14AYTlvnYdF2uS1/2bkS8iHd5X1S
         6GXoKyySsTO6ayDzQwJjwrnI7UFTfS92vVwCjgdXQ+PG0l+j0ZB1edbqF4PcM8K2y459
         4OHw+kbSn3G74SgvdET3s78HlVWrk++9j3X5dRC1sYjwPl5kJ1YflLVlBQKYiwS6bPjE
         ookcvhhxiXiIznMNC6ZAE6lZjE4VnBSmPvfWmd1ILK4ggZj05OGhIeC9c+N5JrJZ+g43
         bG8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=j5g/zU+696PeVmCC3WI7qXsAe3l0QgzXurFGkS4msws=;
        b=pT6u1KqpQOi7vySbje9UuctBkqOBtbB6xCB9/PUKAy+ux7479JwdcEL6c09OpL0lWg
         I1B8Ppcd537j34zl9hRW1sN9nFEZBezKKEHVyTrbYmA8HJXKA1L0IVwWwmXLEVvezU5i
         efraUAL3KbMksqUVXecqpYdP8ccsAFGErGixXaYm/bSuvKSmnTd6dTa0cpnmPq/1Ewnz
         LdqEst2pF4wHtL6jw3l4lsrge6RzIP+vF4e/Ea56vSD8q2JxYgH1j6kkoteHwOTBrbiA
         IewDVMt9J2RH2lKbl3G5hGN+3mAVETJI+U3A4cWsO17iSXpmw48w4NNoPr92fouNF4Gj
         EstQ==
X-Gm-Message-State: APjAAAU5oAhytX/f4golJuB87yhCpN87Kp7g+/eV4xVEkXyctKwtLiu2
        xGTikGY/XJtIKfdJZWEn+Y4=
X-Google-Smtp-Source: APXvYqzp0djjaXy73JzjXlNihRxHSqMki4TMSinQomEMtVuyNAdE/bUcG1gvFGuUpLtexBLg3TWmUw==
X-Received: by 2002:a17:902:820b:: with SMTP id x11mr3836133pln.196.1579336429393;
        Sat, 18 Jan 2020 00:33:49 -0800 (PST)
Received: from konoha.iitr.ac.in ([103.37.201.169])
        by smtp.gmail.com with ESMTPSA id c10sm605038pgj.49.2020.01.18.00.33.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jan 2020 00:33:48 -0800 (PST)
From:   Shourya Shukla <shouryashukla.oo@gmail.com>
To:     sunshine@sunshineco.com
Cc:     git@vger.kernel.org, gitster@pobox.com, johannes.schindelin@gmx.de,
        shouryashukla.oo@gmail.com
Subject: [PATCH v3 1/2] t6025: modernize style
Date:   Sat, 18 Jan 2020 14:03:25 +0530
Message-Id: <20200118083326.9643-6-shouryashukla.oo@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200118083326.9643-1-shouryashukla.oo@gmail.com>
References: <CAPig+cQX=jB1KTKcOMVE9u0jX-ZXt_vQBndkzqqQWORu5iFxeA@mail.gmail.com>
 <20200118083326.9643-1-shouryashukla.oo@gmail.com>
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
 t/t6025-merge-symlinks.sh | 95 ++++++++++++++++++++-------------------
 1 file changed, 48 insertions(+), 47 deletions(-)

diff --git a/t/t6025-merge-symlinks.sh b/t/t6025-merge-symlinks.sh
index 433c4de08f..d257dcf34d 100755
--- a/t/t6025-merge-symlinks.sh
+++ b/t/t6025-merge-symlinks.sh
@@ -10,52 +10,53 @@ if core.symlinks is false.'
 
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
+	echo "120000 $l	symlink" | git update-index --index-info &&
+	git commit -m master &&
+	git checkout b-symlink &&
+	l=$(printf file-different | git hash-object -t blob -w --stdin) &&
+	echo "120000 $l	symlink" | git update-index --index-info &&
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

