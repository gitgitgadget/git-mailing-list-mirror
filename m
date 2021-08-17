Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE7DDC4338F
	for <git@archiver.kernel.org>; Tue, 17 Aug 2021 11:49:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2BB561008
	for <git@archiver.kernel.org>; Tue, 17 Aug 2021 11:49:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236896AbhHQLuA (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Aug 2021 07:50:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236713AbhHQLt4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Aug 2021 07:49:56 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADE87C061764
        for <git@vger.kernel.org>; Tue, 17 Aug 2021 04:49:23 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id mq3so2084171pjb.5
        for <git@vger.kernel.org>; Tue, 17 Aug 2021 04:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=77z6NLuqcpoJ4ZEcygmOI7Zyfb6WVw1I6oJsH0DfZyE=;
        b=ehpnQUC7E2a7V41Uv9NH+ktPf1VpjpyCY6WaBhrhj7Tw81cSZPmE5hrKpLesYrmIlr
         dXtxhP9Glg6n+FgKYD6qJyx6CkyNgXwW6WlmxXUbaLzuLPLcNzfmnRLqeYAJzFtilRfq
         6Hi0h65lvfyLT9YXPMzA86UTgZ9HgwMex+cjjHKwKOVkf1gDX5twf8xuQ3fLfvPNcK3A
         U/Y3EWlpkxIeV5UQg6odjclJ3TDcnw+zJENkZC/ypB2wNcY/PNr3MVYomWxNKmTnrAsE
         p/fdBHYFk9mznf8O30kKMdvzF4BhZWlV0kOvWA+XSbh5CeJrKu6UzJ1CO45bjVk73BQ+
         DKOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=77z6NLuqcpoJ4ZEcygmOI7Zyfb6WVw1I6oJsH0DfZyE=;
        b=Qbncjgc3qyImPyjEYlnjp9phVUzC29wpRTbnAdjSqxhAPr21StGW1lazjU+x7/ZEmr
         HGJr1hZBjsluSgCwaYur1lggrtMpQPQKD6a7aU6d9ZRVGPwJ7zwOCHgRy1A54vKGZcgf
         sl7tz/nnPwQW+WahLsx1mJnXTRi3eXom0PI6rFfnmAvUvI4Zta0NoEhIldkx4f7Q2xOu
         MqP2O4kQlwXgZbVuqnk7CM69DLmQK6fht2aUSPU6cuRFzJJYJHAL2TAccLvXJ6/Cu7D3
         45TEO0PXk4pTBUarsaoD+PnHn/BhOFYxxJa+J2o32gTErUI4U/qY8bTUePfiojWG0U3K
         B2GQ==
X-Gm-Message-State: AOAM530Z/8QIWDXflf9c1oYrotn4TRqaej+wV3Tm5JcBXEPspFIICNWW
        BSa1Jfao8er6zxh3RhY4EeTO7k+e8/w=
X-Google-Smtp-Source: ABdhPJwQ2ef8NcUShDDLjX7AKk9izaNwAnxPmbHhZQ+zBvPq4vko/2uRz6oqo/U//njHPeXkiNfjog==
X-Received: by 2002:a17:90b:150a:: with SMTP id le10mr3146210pjb.135.1629200963034;
        Tue, 17 Aug 2021 04:49:23 -0700 (PDT)
Received: from athena.localdomain ([2402:800:63ed:4478:964c:2b9b:388e:4b0])
        by smtp.gmail.com with ESMTPSA id b10sm2518010pfi.122.2021.08.17.04.49.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 04:49:22 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
Subject: [PATCH] t6300: don't run cat-file on non-existent object
Date:   Tue, 17 Aug 2021 18:48:53 +0700
Message-Id: <bcbde2e7364865ac16702447b863b8a725670428.1629200841.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.33.0.rc1
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

Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
---
 t/t6300-for-each-ref.sh | 27 ++++++++++++++++-----------
 1 file changed, 16 insertions(+), 11 deletions(-)

diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index 9e0214076b..65fbed2bef 100755
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
+		expect=$(printf '%s' "$3" | wc -c)
 		test_expect_${4:-success} $PREREQ "basic atom: $1 contents:size" '
+			type=$(git cat-file -t "$ref") &&
+			case $type in
+			tag)
+				# We cannot use $3 as it expects sanitize_pgp to run
+				git cat-file tag $ref >out &&
+				expect=$(<out tail -n +6 | wc -c) ;;
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
2.33.0

