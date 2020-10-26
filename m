Return-Path: <SRS0=PD7l=EB=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE22AC2D0A3
	for <git@archiver.kernel.org>; Mon, 26 Oct 2020 17:02:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9906024640
	for <git@archiver.kernel.org>; Mon, 26 Oct 2020 17:02:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UqvSks/e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1787089AbgJZRCx (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Oct 2020 13:02:53 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40925 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1775634AbgJZRBx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Oct 2020 13:01:53 -0400
Received: by mail-wr1-f66.google.com with SMTP id h5so13477376wrv.7
        for <git@vger.kernel.org>; Mon, 26 Oct 2020 10:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=dm3ZWdoKJ4fCc1YirGC9Oa6AR/FNVWe6XQ3HESMkBuY=;
        b=UqvSks/eq7XjppR/a2XObrf9+t/F42L9a7MRKIKlPIZ7goG4HMTqbPNki7PGb52qZ1
         5oB7NxtCD8kBvVSjaZuWsTq/XpatobaeNDSWq6F6OCCXDPukjDG3wrWitGlLu5vPm9EU
         dVOi/KgTKIFjgMBGgG1inLaQnneEocM/gq4LvBzaahrkyaMbxosvPhv0olrvdt+DeC4g
         KKzzrjzHzkDA80yPMiffK5nJH8gKvTiq0jxdVAqqEHMSAI/fJDkL+TdhwTSwC2SxSjgK
         qmDdr8RzQLAWhpcwPcyBHEqUe8JVw/UsqDEFGis+JzVA2QDHObo/9mueGKnp8q/j++nC
         Rjrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=dm3ZWdoKJ4fCc1YirGC9Oa6AR/FNVWe6XQ3HESMkBuY=;
        b=kDivg+TmxHg+ka/EEpGr2xXPupWXUeMPQnvbLDDZker7vWCrlDfRvlrb3BpDEsImsp
         xAs1G18/eBXk9N0PCPewfyyIT2U29Oa5nRZlKpgwRX8iM0mlCSS4zTBzV/Siwd93Kff6
         YXJZqxQXRz3YNlLwBoQWBLRC0BA91/YWP8z5GwmIRBNYxR8H32FP6Hb24Cl1NrQfhNMz
         /cb/1cJXmw9eHL3uri1I/b4+JaFHuFk4+KczsuN6OIcPnFH+2fcAALqzOb3h2w1p5+os
         9xghcywR36rqq6+IRwO/s5t9BRXK+CpYITC3H13e8EwmFX49nLH9Z0l6AL8FYKc3Tk4R
         puog==
X-Gm-Message-State: AOAM531FZsy/NjKbZWIAyDyMaXSMCzG4xYirvPXWrmlSUtPqfwwfYGnT
        s166/6Epi5w1eaiBW8DjAPksxQuu4OI=
X-Google-Smtp-Source: ABdhPJyVekoA5jKJlj7MaF5rwNoZPyGfGM4fKfhUudLFVHVVnMnaTiDYxhb64dvGxFeJZogetRhPAQ==
X-Received: by 2002:adf:e443:: with SMTP id t3mr18998830wrm.14.1603731710679;
        Mon, 26 Oct 2020 10:01:50 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u5sm29005534wru.63.2020.10.26.10.01.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2020 10:01:50 -0700 (PDT)
Message-Id: <e8a7d6ac813b2d1c29c3cca6fc1ea27cb6f48a40.1603731704.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.769.v2.git.1603731704.gitgitgadget@gmail.com>
References: <pull.769.git.1603468885.gitgitgadget@gmail.com>
        <pull.769.v2.git.1603731704.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 26 Oct 2020 17:01:40 +0000
Subject: [PATCH v2 5/9] t6423: expect improved conflict markers labels in the
 ort backend
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        =?UTF-8?Q?=C4=90o=C3=A0n_Tr=E1=BA=A7n_C=C3=B4ng?= Danh 
        <congdanhqx@gmail.com>, Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Conflict markers carry an extra annotation of the form
   REF-OR-COMMIT:FILENAME
to help distinguish where the content is coming from, with the :FILENAME
piece being left off if it is the same for both sides of history (thus
only renames with content conflicts carry that part of the annotation).
However, there were cases where the :FILENAME annotation was
accidentally left off, due to merge-recursive's
every-codepath-needs-a-copy-of-all-special-case-code format.

Update a few tests to have the correct :FILENAME extension on relevant
paths with the ort backend, while leaving the expectation for
merge-recursive the same to avoid destabilizing it.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t6423-merge-rename-directories.sh | 38 +++++++++++++++++++++--------
 1 file changed, 28 insertions(+), 10 deletions(-)

diff --git a/t/t6423-merge-rename-directories.sh b/t/t6423-merge-rename-directories.sh
index f9a3f24039..7e32626913 100755
--- a/t/t6423-merge-rename-directories.sh
+++ b/t/t6423-merge-rename-directories.sh
@@ -302,11 +302,20 @@ test_expect_success '1d: Directory renames cause a rename/rename(2to1) conflict'
 		git cat-file -p :2:x/wham >expect &&
 		git cat-file -p :3:x/wham >other &&
 		>empty &&
-		test_must_fail git merge-file \
-			-L "HEAD" \
-			-L "" \
-			-L "B^0" \
-			expect empty other &&
+		if test "$GIT_TEST_MERGE_ALGORITHM" = ort
+		then
+			test_must_fail git merge-file \
+				-L "HEAD:y/wham" \
+				-L "" \
+				-L "B^0:z/wham" \
+				expect empty other
+		else
+			test_must_fail git merge-file \
+				-L "HEAD" \
+				-L "" \
+				-L "B^0" \
+				expect empty other
+		fi &&
 		test_cmp expect x/wham
 	)
 '
@@ -1823,11 +1832,20 @@ test_expect_success '7b: rename/rename(2to1), but only due to transitive rename'
 		git cat-file -p :2:y/d >expect &&
 		git cat-file -p :3:y/d >other &&
 		>empty &&
-		test_must_fail git merge-file \
-			-L "HEAD" \
-			-L "" \
-			-L "B^0" \
-			expect empty other &&
+		if test "$GIT_TEST_MERGE_ALGORITHM" = ort
+		then
+			test_must_fail git merge-file \
+				-L "HEAD:y/d" \
+				-L "" \
+				-L "B^0:z/d" \
+				expect empty other
+		else
+			test_must_fail git merge-file \
+				-L "HEAD" \
+				-L "" \
+				-L "B^0" \
+				expect empty other
+		fi &&
 		test_cmp expect y/d
 	)
 '
-- 
gitgitgadget

