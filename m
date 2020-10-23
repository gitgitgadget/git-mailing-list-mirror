Return-Path: <SRS0=cWhr=D6=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFA13C55179
	for <git@archiver.kernel.org>; Fri, 23 Oct 2020 16:01:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E53921D47
	for <git@archiver.kernel.org>; Fri, 23 Oct 2020 16:01:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QVQoOsRc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751217AbgJWQBi (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Oct 2020 12:01:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S464808AbgJWQBh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Oct 2020 12:01:37 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28454C0613CE
        for <git@vger.kernel.org>; Fri, 23 Oct 2020 09:01:37 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id n6so2463591wrm.13
        for <git@vger.kernel.org>; Fri, 23 Oct 2020 09:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=dm3ZWdoKJ4fCc1YirGC9Oa6AR/FNVWe6XQ3HESMkBuY=;
        b=QVQoOsRcdka+kNIlJC2ExAYA/SCYCU5u8+i83rKD9+sAbw+mcgeq6xUGBBfd3xstVF
         k+3aWi8YDibQp949j2/2tpxvp36lebYQtEW9xNPKIYjRZe55EaRGQuYCHqAQQYg7Wvdp
         yApW025zbpD6ePuPPvpGjs2h0qebTNQIUfcHrmmaBoWHxcPZgPJ2cWr8Bso2lT2AD8bF
         IyWDOCpLnXR55okDyjdF8eCXppcQ9DWwggjktO11oOpeNID+LFM8t5za8lKAteD97U0O
         ZTItQ8ZQ2zjiGM7TEESK1xPPr8k11nMq1lsuy+EVLCuUkbU+Lhqals2Onhy90JYR2Elw
         0WjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=dm3ZWdoKJ4fCc1YirGC9Oa6AR/FNVWe6XQ3HESMkBuY=;
        b=J4iHSOfHvolUqVy5wqBJCmt3ja1iC4O2A5G01zpEPbdZmwY7fqzJW5HEDTyo4Cm5KC
         CPnHyDOX+93+ilELnUavuP14b7FwlUI+ka9bG40XotBIyXpVFAapEUMO9w5yEplDaWMO
         yONJGoC9S10HokZbEYe0RK7ngfW3umU7JklTJSdF1Haukop2tZjaB4DeYBikOWZ+Mnbg
         vjMwBdZJOe5rGnGvd7tcFi0uUXqOG0pd6kopZXcsTCnn568wyF3ptwEoUJ7uRd281HVr
         hHvdnGPbLYN8jZl6UTTt9yMB9/jAoLvrU9qaCEIfwl2/hhtroMUKzZ8lsCERRyCQE6eg
         fYkQ==
X-Gm-Message-State: AOAM533Zsjuw5iipVp0A2mdWdyMBp8CYs0twMcM4rRq0d5WRu3j0fJFc
        denUtKvgOJZ3EOwWKceMr14G2wB734g=
X-Google-Smtp-Source: ABdhPJzG7aeZw3vpCm2vthHwS1tVa2SEiSYrUKMqpUdnTlsTZTBFNr5mDO3xGccSBrI4RqUrmzrE3w==
X-Received: by 2002:a5d:4b10:: with SMTP id v16mr3587923wrq.178.1603468895746;
        Fri, 23 Oct 2020 09:01:35 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b7sm4194291wrp.16.2020.10.23.09.01.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2020 09:01:35 -0700 (PDT)
Message-Id: <5bead7fa0d8d11f9587818e49b3e867f64e5a7b7.1603468885.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.769.git.1603468885.gitgitgadget@gmail.com>
References: <pull.769.git.1603468885.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 23 Oct 2020 16:01:20 +0000
Subject: [PATCH 5/9] t6423: expect improved conflict markers labels in the ort
 backend
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Elijah Newren <newren@gmail.com>
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

