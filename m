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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D049CC33CB1
	for <git@archiver.kernel.org>; Sat, 18 Jan 2020 08:33:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A62B72468C
	for <git@archiver.kernel.org>; Sat, 18 Jan 2020 08:33:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BkfQO1r+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726635AbgARIdi (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 18 Jan 2020 03:33:38 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:37938 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726509AbgARIdh (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Jan 2020 03:33:37 -0500
Received: by mail-pg1-f193.google.com with SMTP id a33so12842245pgm.5
        for <git@vger.kernel.org>; Sat, 18 Jan 2020 00:33:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=E1QmLD9GBO2uEs5uXCads3PwO8fhEo5QcewGiJ12mIc=;
        b=BkfQO1r+omLcep4q/qmqOdSn6cgz6wT+12Z3GbD7T+FjMTsFkjVeafrqnc7DL8YuAM
         DX6weyjlQWsGA9IbygqtXst8kjr6eRmYFxvOQ8ZaeoQOlD/CRyUt6GRdbYkDWow+ghm/
         XIWyxhlpyEgDg30pJfXX0fO3moyRO+HwS3K+Su4Oa6ptUNnUlzI6tRClQ2LmlAQUC9lL
         Tayf4AHxQga4vYzaTNICfYXKVV2yLbZI1IG0Q0rSiR265uOQo9OgpESdO5lWqrl2JgWa
         Ubx0B4aZQ7kGkwteZGcP7N339RF6GWhT+xr7LnDtoky9cZ09FK6HYh1EFOvSMp7OLRgz
         t/Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=E1QmLD9GBO2uEs5uXCads3PwO8fhEo5QcewGiJ12mIc=;
        b=m0lRHHmWYg23nZryXHCLNsiBXHriOLculoxX3a3ATAY568VRib112KFQT7dyC7C4Ki
         h6gjIkmyA15L3llrLLJz2c4/uEFiVPD/kM9RT8Yvd6rzzIR+nnRSPjZ/l65a691h2XhP
         NPypHhenfBm0JFs7wRE2KTY2L1RKoVCun1KBG4mAQujtLNANlsurdSEgBuxakFxr0+Nd
         uzwaepRvM/r0cqcJFwEUIcvnxlglj5o2LkhFwJrx+kg5F49cmQlP1N6YhtUz3z7HbdX5
         OXztrbIQpJAz+nkt7xsHl9zwHJ9VdejRw5OQkhvpwWqAXM7bntW+FzMLeOwZPi+fvHUl
         m+5w==
X-Gm-Message-State: APjAAAUhQa0Y0x7b2leaovNO6zqVgf5l8wZzwiL4UltaQTt58Ef1laMP
        AH28aKJlGcX7WVoN7mpFQL0=
X-Google-Smtp-Source: APXvYqzZc5CM0KGu3puKBcXkIZkRKy0apGAKM2XkTAErz3Ssy+5eL6VOeKiWOBouG/T8+INQNSEQcQ==
X-Received: by 2002:a65:64c6:: with SMTP id t6mr48296702pgv.392.1579336417017;
        Sat, 18 Jan 2020 00:33:37 -0800 (PST)
Received: from konoha.iitr.ac.in ([103.37.201.169])
        by smtp.gmail.com with ESMTPSA id c10sm605038pgj.49.2020.01.18.00.33.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jan 2020 00:33:36 -0800 (PST)
From:   Shourya Shukla <shouryashukla.oo@gmail.com>
To:     sunshine@sunshineco.com
Cc:     git@vger.kernel.org, gitster@pobox.com, johannes.schindelin@gmx.de,
        shouryashukla.oo@gmail.com
Subject: [PATCH 1/3] t6025: modernize style
Date:   Sat, 18 Jan 2020 14:03:21 +0530
Message-Id: <20200118083326.9643-2-shouryashukla.oo@gmail.com>
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
 t/t6025-merge-symlinks.sh | 97 ++++++++++++++++++++-------------------
 1 file changed, 50 insertions(+), 47 deletions(-)

diff --git a/t/t6025-merge-symlinks.sh b/t/t6025-merge-symlinks.sh
index 433c4de08f..b9219af659 100755
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
+	touch file &&
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

