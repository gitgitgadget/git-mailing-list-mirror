Return-Path: <SRS0=OIeF=BS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF93EC433E1
	for <git@archiver.kernel.org>; Sat,  8 Aug 2020 17:01:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD858206CD
	for <git@archiver.kernel.org>; Sat,  8 Aug 2020 17:01:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V/ZOsx7G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726492AbgHHRBj (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 8 Aug 2020 13:01:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726402AbgHHRB3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Aug 2020 13:01:29 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C695CC061A29
        for <git@vger.kernel.org>; Sat,  8 Aug 2020 10:01:28 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id f12so4407104wru.13
        for <git@vger.kernel.org>; Sat, 08 Aug 2020 10:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=0vMZt73qbmIoI+rhDiNsvrAu1kWR485QNPmx86vZ0PU=;
        b=V/ZOsx7GnkdgAvQnuh85Px/ijZS2cIW1lQJ41LdpGm2Tp6avMYnb+OVTE9lQAyKXQF
         FetvYnnbDJCMgItQLVcY0Jzy037FTNwlipUA4ev4Ol6huj+3cutEfMW3aeao711QAwvV
         5nDhtbgfDz9LullQJurafHh/MFSSnuk+YGkQ1jWSe7e+iVrTNpgz8zmJtUCVEfHrQ3Q+
         udSBIJpN0wFc7Xp7GuC9kl+w9LXwubsOaWhr10UmHkaHpWkkCUtRb+G5vFYaV2nb5Pdh
         2S0JtLCJ8j/jchyj+mbOLP56d5ff7yM/u60lS4779HML0v8EsgNgoPihm/TX04PEXBSF
         D+nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=0vMZt73qbmIoI+rhDiNsvrAu1kWR485QNPmx86vZ0PU=;
        b=Tb+8tEOsVOn1tuPAGZ1UUNmhvylIxlWEm1R3Udt55rgNvpoWqSGbYRJEjVxwHWONGc
         uTUo2vb+GvjQpLPCaSFpbZ8mW3ZlrKvs73j1ErNbUYn0BABHUOckwWFKBE8Qohl6H54t
         TfCDN5l0WXXcoIIAnlRqcUU7z//GvaihYlyzxhZwGl+MBCSjjg8Sqypwh3nVhhgv6txj
         OizVctq5F3Ne5RruYs2VBcadsrS/p2uA73a1W21ejeNcEGIDdYpTsKx5lMuqWIEHEO2c
         WjKt3UehGSNCD7DwvLiiLLyQNhmPUY1IxS2xEgxhd3voZ32DU60JHGZbBFBECV6kCKpD
         1j8A==
X-Gm-Message-State: AOAM530ORPGZJww4HNrF74xnRjcXabVFNZTEBSiNexPzMZT+/7FIetX8
        AXvjhsNEKRxqg8syWOWvN2FrkLwk
X-Google-Smtp-Source: ABdhPJxOAarwlsZfOTkw4Zf6bTxQwFfodic7D5MPISK8WKgqiHaFxXs2zT7O+xUoxqmiR5rSk9mqYw==
X-Received: by 2002:a5d:60c5:: with SMTP id x5mr17530979wrt.67.1596906086408;
        Sat, 08 Aug 2020 10:01:26 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m1sm13985725wmc.28.2020.08.08.10.01.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Aug 2020 10:01:26 -0700 (PDT)
Message-Id: <9ce80f2f943278fcb8ef46fd1a9507d832657246.1596906081.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.827.v2.git.git.1596906081.gitgitgadget@gmail.com>
References: <pull.827.git.git.1596644952296.gitgitgadget@gmail.com>
        <pull.827.v2.git.git.1596906081.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 08 Aug 2020 17:01:13 +0000
Subject: [PATCH v2 04/11] t6416, t6422: fix incorrect untracked file count
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

Apparently I don't know how to count untracked files, and since the tests
in question were marked as test_expect_failure, no one every noticed it
until know.  Correct the count, as these tests clearly creates three
untracked files ('out', 'err', and 'file_count').

(I believe this problem arose because earlier incarnations counted lines
via a pipe to 'wc -l'.  Reviewers asked that it be replaced by writing
the output to a file and using test_line_count, but when the temporary
output was added to a separate file, the count of untracked files should
have increased.)

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t6416-recursive-corner-cases.sh    | 2 +-
 t/t6422-merge-rename-corner-cases.sh | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/t6416-recursive-corner-cases.sh b/t/t6416-recursive-corner-cases.sh
index b3bf462617..d272b418e4 100755
--- a/t/t6416-recursive-corner-cases.sh
+++ b/t/t6416-recursive-corner-cases.sh
@@ -1144,7 +1144,7 @@ test_expect_failure 'check symlink add/add' '
 		test_must_fail git merge -s recursive E^0 &&
 
 		git ls-files -s >out &&
-		test_line_count = 2 out &&
+		test_line_count = 3 out &&
 		git ls-files -u >out &&
 		test_line_count = 2 out &&
 		git ls-files -o >out &&
diff --git a/t/t6422-merge-rename-corner-cases.sh b/t/t6422-merge-rename-corner-cases.sh
index 7da75c1736..c8ee033ad9 100755
--- a/t/t6422-merge-rename-corner-cases.sh
+++ b/t/t6422-merge-rename-corner-cases.sh
@@ -899,7 +899,7 @@ test_expect_failure 'rad-check: rename/add/delete conflict' '
 		git ls-files -u >file_count &&
 		test_line_count = 2 file_count &&
 		git ls-files -o >file_count &&
-		test_line_count = 2 file_count &&
+		test_line_count = 3 file_count &&
 
 		git rev-parse >actual \
 			:2:bar :3:bar &&
@@ -967,7 +967,7 @@ test_expect_failure 'rrdd-check: rename/rename(2to1)/delete/delete conflict' '
 		git ls-files -u >file_count &&
 		test_line_count = 2 file_count &&
 		git ls-files -o >file_count &&
-		test_line_count = 2 file_count &&
+		test_line_count = 3 file_count &&
 
 		git rev-parse >actual \
 			:2:baz :3:baz &&
-- 
gitgitgadget

