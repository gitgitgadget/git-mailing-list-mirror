Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AE2CC433F5
	for <git@archiver.kernel.org>; Fri,  3 Dec 2021 21:16:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383199AbhLCVTn (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Dec 2021 16:19:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383193AbhLCVTj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Dec 2021 16:19:39 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86F4FC061354
        for <git@vger.kernel.org>; Fri,  3 Dec 2021 13:16:14 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id u1so8263961wru.13
        for <git@vger.kernel.org>; Fri, 03 Dec 2021 13:16:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=1xcvpy3GEbejXob77lGP4eiVvSIRlP14kwXnA4hYMvk=;
        b=Z7PUhpexz34MxL67S7/aD8PZd7XgeVq1FkwGXz0NT5hfRqv1cWFMlTyKSZh0IXJfAa
         uK77HV56lDIHfwMUCU+eQWGceiOSe/8QMXgu9HYTHGTzrKxAmgXsGF9fnwPXX5OUwEti
         h4LoHmsYSTC47z0vUvbF2LUkyimSChzkhkjL3wFjz86kui0KuPlzz65ZG93iHAv4dHqZ
         Cg5+NF1e9s8QIZPUMTQvVvK9HnBA/aZpup6wtFnyI+h3gpvoxHhxRphI2jCBB6JRQNf9
         Q9X21ROy79S7tQxj/1fFL3V5kVMQdrWm91/9n/lTcplJMVvYI0K9lr0IA8q/0NhxeuLM
         74EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=1xcvpy3GEbejXob77lGP4eiVvSIRlP14kwXnA4hYMvk=;
        b=EewJ9YqJJCa78sZ5Z8BW2kSyUOsvdT7c0x0729zLz/kUNMubOmpIMJ1/5TktaeiVGb
         fxaYFtmWqAZxAz1rAENBeDXxtl4Z7jLsC4d1dTIR3bem3S9uNVnNGX0KQd+M5+HUaU0C
         bacQq8ONFQy11Tf5it8t6tTKbf4VJI/lIypvil6iWqM5HKV2kgRPrCMnDBm07M7pFbdY
         hejutampGnVCxYl5GlgHj9AMfSoGUZ/qaLzQyrGqUzN6iYPyPewWG0aq7PwSKc9IP/NU
         o+bspkOHsHSloW+o2iPV+A9tV00Z/PzLpEYygzt7gA/wTlWjO6LzEvKjTewjtdU+tzSz
         +5AQ==
X-Gm-Message-State: AOAM533cUa9uWk125AsVxcPfqN7fgl0pdO2tFECP0MzJlJPgZRFEtzcs
        67yDLu0xV2zEsFeppbwBhZIO3IgvosY=
X-Google-Smtp-Source: ABdhPJys2GGc7Ex8PgVVMWR5eFQ8OZU8U6d5NMvu4x5WSFlQy/eiLd9KgufWRERwg5SMOVft5UBL3A==
X-Received: by 2002:a5d:4492:: with SMTP id j18mr24374032wrq.397.1638566172986;
        Fri, 03 Dec 2021 13:16:12 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n32sm3572381wms.42.2021.12.03.13.16.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Dec 2021 13:16:12 -0800 (PST)
Message-Id: <85e3e5c78e741496a1c99ccc84e59b16fa0a7158.1638566165.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1050.v5.git.1638566165.gitgitgadget@gmail.com>
References: <pull.1050.v4.git.1637620958.gitgitgadget@gmail.com>
        <pull.1050.v5.git.1638566165.gitgitgadget@gmail.com>
From:   "Lessley Dennington via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 03 Dec 2021 21:16:03 +0000
Subject: [PATCH v5 5/7] diff: replace --staged with --cached in t1092 tests
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, gitster@pobox.com, newren@gmail.com,
        Taylor Blau <me@ttaylorr.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        Lessley Dennington <lessleydennington@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Lessley Dennington <lessleydennington@gmail.com>

Replace uses of the synonym --staged in t1092 tests with --cached (which
is the real and preferred option). This will allow consistency in the new
tests to be added with the upcoming change to enable the sparse index for
diff.

Signed-off-by: Lessley Dennington <lessleydennington@gmail.com>
---
 t/t1092-sparse-checkout-compatibility.sh | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index 77e302a0ef3..203a594fa45 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -371,7 +371,7 @@ test_expect_success 'checkout and reset --hard' '
 	test_all_match git reset --hard update-folder2
 '
 
-test_expect_success 'diff --staged' '
+test_expect_success 'diff --cached' '
 	init_repos &&
 
 	write_script edit-contents <<-\EOF &&
@@ -380,10 +380,10 @@ test_expect_success 'diff --staged' '
 	run_on_all ../edit-contents &&
 
 	test_all_match git diff &&
-	test_all_match git diff --staged &&
+	test_all_match git diff --cached &&
 	test_all_match git add README.md &&
 	test_all_match git diff &&
-	test_all_match git diff --staged
+	test_all_match git diff --cached
 '
 
 # NEEDSWORK: sparse-checkout behaves differently from full-checkout when
@@ -400,8 +400,8 @@ test_expect_success 'diff with renames and conflicts' '
 		test_all_match git checkout rename-base &&
 		test_all_match git checkout $branch -- . &&
 		test_all_match git status --porcelain=v2 &&
-		test_all_match git diff --staged --no-renames &&
-		test_all_match git diff --staged --find-renames || return 1
+		test_all_match git diff --cached --no-renames &&
+		test_all_match git diff --cached --find-renames || return 1
 	done
 '
 
@@ -420,8 +420,8 @@ test_expect_success 'diff with directory/file conflicts' '
 		test_all_match git checkout $branch &&
 		test_all_match git checkout rename-base -- . &&
 		test_all_match git status --porcelain=v2 &&
-		test_all_match git diff --staged --no-renames &&
-		test_all_match git diff --staged --find-renames || return 1
+		test_all_match git diff --cached --no-renames &&
+		test_all_match git diff --cached --find-renames || return 1
 	done
 '
 
-- 
gitgitgadget

