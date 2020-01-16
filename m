Return-Path: <SRS0=75zt=3F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C2E0C33CAF
	for <git@archiver.kernel.org>; Thu, 16 Jan 2020 20:36:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E446120748
	for <git@archiver.kernel.org>; Thu, 16 Jan 2020 20:36:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fFMzFJuv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388047AbgAPUgj (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Jan 2020 15:36:39 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:41706 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729637AbgAPUgi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Jan 2020 15:36:38 -0500
Received: by mail-pg1-f195.google.com with SMTP id x8so10481219pgk.8
        for <git@vger.kernel.org>; Thu, 16 Jan 2020 12:36:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=E1QmLD9GBO2uEs5uXCads3PwO8fhEo5QcewGiJ12mIc=;
        b=fFMzFJuvwaSI+8st4tdJYBWRvTHrK3P7hVJpEDN37eA21yzeU5whWo1A8wVmxNYOQQ
         4ShFbnKjvDhFgGfuLXFeOld5y247awVAdTZbVth7WTBO5eOWaImRPpb1wMYyoEl45nuR
         Wt7O0h/R7PbaTxTjRhpN53Ym53tOz4UORZIyVpWDQohJ9BzAP7IvKW9CYZj9O3cu0MSE
         1HnuTTbAV6ThX3GOAroJzk9xXvN19d8I5rbZtWBXDXgit/LM252Nyfm36J1KmhZgmSlY
         H/c+BRuv0NTCsS+eq5nBoGZARxkyVkP+BDPYZiqcz/lGq1b7C+x0QyFsUHq2blrC3aFo
         yIIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=E1QmLD9GBO2uEs5uXCads3PwO8fhEo5QcewGiJ12mIc=;
        b=djeYzdadNwf8ZIdaMoTLtZMEH8SoOOV7ZQhQry0BewhtDWstgKR7PQqeyArOPLLz7f
         13lTS3It63IRsPDcQa8+Tyu0YsOOCeSd5agXXsR2cYFIjhEAWneNgeGDQLfhtpdkj+TJ
         YFTw5F1GRnVyayGdI87f4YaomV2Mf8rN3H88RQkBJHHNUy1YNAQ0ciF23oN/Axl+bbIQ
         C0BMEno8ClFDm0sVvPyouVeVLyalSyXKtsiLgpTKMZSHbJIg6owjjCI7GDSb9DqZCnoD
         QGGVgJKnbxpSYUZlW7DDHkHoUlHaZ8U1XGNeonHJUqtmuo/hqNyyg7DuptWfbeqbejA9
         bZvg==
X-Gm-Message-State: APjAAAXI5IdCZxkbTSjcqrc9betfknfRRC4tebzTtF4eeJEN0Ygii0N4
        YHSG2qotxNSFxWGV5vZ7LzZSc0FLKpfP/w==
X-Google-Smtp-Source: APXvYqyvaAvmENEhLH/UzN5CUa7pUtrD19vg/pIQ+ZKCMknlt0ezisIjS2TwxzuLQUVR7VeLGG0xmA==
X-Received: by 2002:a63:9d85:: with SMTP id i127mr39498295pgd.186.1579206997453;
        Thu, 16 Jan 2020 12:36:37 -0800 (PST)
Received: from konoha.iitr.ac.in ([103.37.201.173])
        by smtp.gmail.com with ESMTPSA id d4sm3481167pjg.19.2020.01.16.12.36.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2020 12:36:36 -0800 (PST)
From:   Shourya Shukla <shouryashukla.oo@gmail.com>
To:     git@vger.kernel.org, gitster@pobox.com, johannes.schindelin@gmx.de
Cc:     Shourya Shukla <shouryashukla.oo@gmail.com>
Subject: [PATCH 1/3] t6025: modernize style
Date:   Fri, 17 Jan 2020 02:06:20 +0530
Message-Id: <20200116203622.4694-2-shouryashukla.oo@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116203622.4694-1-shouryashukla.oo@gmail.com>
References: <20200116203622.4694-1-shouryashukla.oo@gmail.com>
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

