Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9410C432BE
	for <git@archiver.kernel.org>; Wed, 18 Aug 2021 05:19:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA0AD6108B
	for <git@archiver.kernel.org>; Wed, 18 Aug 2021 05:19:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237316AbhHRFUO (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Aug 2021 01:20:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236730AbhHRFUM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Aug 2021 01:20:12 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3DD5C061764
        for <git@vger.kernel.org>; Tue, 17 Aug 2021 22:19:38 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id qe12-20020a17090b4f8c00b00179321cbae7so1572762pjb.2
        for <git@vger.kernel.org>; Tue, 17 Aug 2021 22:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=L8ZRAxQLcRuMwIDCjVPkZrcwMCXpZUDSkbMo47YNZsI=;
        b=JJJ7GM1qOfKFJZ7S4qpESnupm7aMd35sF0POgEEkNRvB35ESUIxb/BqFvSURVama7l
         +Z4zl19WmPBdQQD7SzWoI5RBNJpyVj3Z5q9AgKosBiDrVLuJgKWoyVRCgR20UREegynT
         XJtVIfzyrbPI5uPzL+kOa+Ev3JHmIzqhPagNiqkuFmbPs0c1RUZHR7fs5TBHprvbR6UP
         KyUSmO3e1p18G5em5quv2vWqRS8gvjhXNa70r1P1u8PeKi0hcDbWu32wa8CbVCHoJkcl
         Um4H5TwwMQy68O2W1SCvajR+qgeJ8YqWyXfmUBSR+Z8ZuZ7WpoCyJfvoYrUiEuzqLAEZ
         s/Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=L8ZRAxQLcRuMwIDCjVPkZrcwMCXpZUDSkbMo47YNZsI=;
        b=M7Oj99YgMvQBDXcEV2EpolhcKkFO9etT7fDrRLNmDmJdFvuJVLxxUEz8qqLCXBVGU2
         CzHvNdpNjPvcH8PbLu/D6PLgvVQamr2e+QAWbN4djmLE/2mMKV8GeghlSzSchCIA/2gH
         ynkJFM2j2TwZi5Eaf4EtGnDERaC1gMgL3dPy9QKlMxbN1SI6Zf17JefHw7Wrp1UsBYwD
         Gb1guav7w4CHmwhWvSYM26K17ugjYxFzOdQuji4xq4Hc4G0+gVYZcdT1WREnTHTUkAQh
         /gSAmuiYOmfW4wBDh6XQJIWaIfxQxugROawG/rOAXAd02I9/ULujIHSkYEw7+HZ+JsgV
         /6tw==
X-Gm-Message-State: AOAM5333YAgCS+zGz3LMIAemPVkazOEpoom5JdDntfR9Y8u8R521YYaO
        vCcBSnadgI/bwKEFdSxkgATvM8bzU54=
X-Google-Smtp-Source: ABdhPJwDn4kPqqt0bkarqfRal8pMkDBDJ816XuemcexRTRpxq6KNksvr2x+g5y+oj6JrSqq0tpyk/A==
X-Received: by 2002:a17:90a:a016:: with SMTP id q22mr7652171pjp.34.1629263978206;
        Tue, 17 Aug 2021 22:19:38 -0700 (PDT)
Received: from athena.localdomain ([2402:800:63ed:4478:964c:2b9b:388e:4b0])
        by smtp.gmail.com with ESMTPSA id g202sm4385410pfb.125.2021.08.17.22.19.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 22:19:37 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v2 1/2] t6300: don't run cat-file on non-existent object
Date:   Wed, 18 Aug 2021 12:19:26 +0700
Message-Id: <b813d6f2ad96d79a8904ef8b255d4b73ea6567d2.1629263759.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.33.0.rc1
In-Reply-To: <cover.1629263759.git.congdanhqx@gmail.com>
References: <bcbde2e7364865ac16702447b863b8a725670428.1629200841.git.congdanhqx@gmail.com> <cover.1629263759.git.congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In t6300, some tests are guarded behind some prerequisites.
Thus, objects created by those tests ain't available if those
prerequisites is unsatistified.  Attempting to run "cat-file"
on those objects will run into failure.

In fact, running t6300 in an environment without gpg(1),
we'll see those warnings:

	fatal: Not a valid object name refs/tags/signed-empty
	fatal: Not a valid object name refs/tags/signed-short
	fatal: Not a valid object name refs/tags/signed-long

Let's put those commands into the real tests, in order to:

* skip their execution if prerequisites aren't satistified.
* check their exit status code

The expected value for objects with type: commit needs to be
computed outside the test because we can't relies on "$3" there.
Furthermore, to prevent the accidental usage of that computed
expected value, BUG out on unknown object's type.

Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
---
 t/t6300-for-each-ref.sh | 27 ++++++++++++++++-----------
 1 file changed, 16 insertions(+), 11 deletions(-)

diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index 0d2e062f79..93126341b3 100755
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -59,18 +59,23 @@ test_atom() {
 	# Automatically test "contents:size" atom after testing "contents"
 	if test "$2" = "contents"
 	then
-		case $(git cat-file -t "$ref") in
-		tag)
-			# We cannot use $3 as it expects sanitize_pgp to run
-			expect=$(git cat-file tag $ref | tail -n +6 | wc -c) ;;
-		tree | blob)
-			expect='' ;;
-		commit)
-			expect=$(printf '%s' "$3" | wc -c) ;;
-		esac
-		# Leave $expect unquoted to lose possible leading whitespaces
-		echo $expect >expected
+		# for commit leg, $3 is changed there
+		expect=$(printf '%s' "$3" | wc -c)
 		test_expect_${4:-success} $PREREQ "basic atom: $1 contents:size" '
+			type=$(git cat-file -t "$ref") &&
+			case $type in
+			tag)
+				# We cannot use $3 as it expects sanitize_pgp to run
+				expect=$(git cat-file tag $ref | tail -n +6 | wc -c) ;;
+			tree | blob)
+				expect="" ;;
+			commit)
+				: "use the calculated expect" ;;
+			*)
+				BUG "unknown object type" ;;
+			esac &&
+			# Leave $expect unquoted to lose possible leading whitespaces
+			echo $expect >expected &&
 			git for-each-ref --format="%(contents:size)" "$ref" >actual &&
 			test_cmp expected actual
 		'
-- 
2.33.0.rc1

