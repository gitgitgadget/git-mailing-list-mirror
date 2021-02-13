Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E126AC433E6
	for <git@archiver.kernel.org>; Sat, 13 Feb 2021 01:53:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A90E064EA1
	for <git@archiver.kernel.org>; Sat, 13 Feb 2021 01:53:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232246AbhBMBx3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Feb 2021 20:53:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229918AbhBMBx1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Feb 2021 20:53:27 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ABECC061756
        for <git@vger.kernel.org>; Fri, 12 Feb 2021 17:52:47 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id i9so1531685wmq.1
        for <git@vger.kernel.org>; Fri, 12 Feb 2021 17:52:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=79t9jJ+yZK63eTMvmuldDuFRk21XscqyhvqiHozR0Bk=;
        b=dyC5NNSDszRODFzV7rMyHUb5t+umXA+tgX3LhB4GscfcaTKz1rIS6uDmC3446SDswz
         TlMwKMTDYWHRI5VK0+eN/aQcKta0Gdj0RgwHWo012gydpKyNY8z4jWDTMkGnwRVS+bxI
         DJqHdyfP2pQgkbFvrM6ZE+Qmc9vxfxDHk3BeFkxiPhqbuj8lhnJh2zHSGmvSndxFl/Xk
         1ItCPFNabK886oXHkrmZBeyfOdzzuEnvGtxq6yEEsdJgi+m1dSNQ2Ti4aOX5vNE3IAGf
         VlJ3dyji3HgkhsfeOfhNjTyWvkL16rAdynoWvL+2thmsApwHz8TVCIS2k5ArtTEIsxpq
         pWFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=79t9jJ+yZK63eTMvmuldDuFRk21XscqyhvqiHozR0Bk=;
        b=N7/HQsjBMLHT4GMK2H8rr4FZ/fnluGj3Ll98L9r5fU8BYgWe3LFdVRhsqYJurjL+Me
         LC0x9R8oZV8hXmwNL9dDhQE8uGOSHC3pzhi/V7nDaNpA5eytnigFA24GpFpuISIoSZle
         e/UWoYzLNcCxYpLpm4WaRUxZeGXdjYmcwEAfCbESB2cFHjrHsK/08Wp9Zf86/JUiYPQL
         wsPJOPOA8vA5OOuWmR8gTeKF4i0COE5NIo4V8O3SMtu4776czUG1TDZsDfKJZ3Az7zg6
         WgQurmF9Y+sqqa8lgZ0viNZw7JYSewqIxy+4If7/YOLnbcWSBr3pGeuEA9iM82Efe3ia
         HaHA==
X-Gm-Message-State: AOAM532OzTOW83xkHej6hEAKTMjJoWZVN//9/Q79lXJXqAGdnJJwQd4G
        Sg+wTX5lEpfn/yBe5Kn7eTXL6oyZ/OE=
X-Google-Smtp-Source: ABdhPJzdjAS/cs+F8oEl8YA70Yy3KSE+sADYY7hnXKlD/NXB1Ifz3ki27VTzaeSWHPSyTAPI8uWl/w==
X-Received: by 2002:a05:600c:2351:: with SMTP id 17mr4929624wmq.2.1613181165667;
        Fri, 12 Feb 2021 17:52:45 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e12sm4944347wrv.59.2021.02.12.17.52.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Feb 2021 17:52:45 -0800 (PST)
Message-Id: <410b02dbad20c77662dd4581f9985783ca08fc70.1613181163.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.726.v4.git.1613181163.gitgitgadget@gmail.com>
References: <pull.726.v3.git.1612602945.gitgitgadget@gmail.com>
        <pull.726.v4.git.1613181163.gitgitgadget@gmail.com>
From:   "Hariom Verma via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 13 Feb 2021 01:52:40 +0000
Subject: [PATCH v4 1/4] t6300: use function to test trailer options
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Hariom Verma <hariom18599@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Hariom Verma <hariom18599@gmail.com>

Add a function to test trailer options. This will make tests look cleaner,
as well as will make it easier to add new tests for trailers in the future.

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Mentored-by: Heba Waly <heba.waly@gmail.com>
Signed-off-by: Hariom Verma <hariom18599@gmail.com>
---
 t/t6300-for-each-ref.sh | 90 +++++++++++++++++++++--------------------
 1 file changed, 47 insertions(+), 43 deletions(-)

diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index ca62e764b586..a8faddd18a9b 100755
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -814,53 +814,57 @@ test_expect_success 'set up trailers for next test' '
 	EOF
 '
 
-test_expect_success '%(trailers:unfold) unfolds trailers' '
-	{
-		unfold <trailers
-		echo
-	} >expect &&
-	git for-each-ref --format="%(trailers:unfold)" refs/heads/main >actual &&
-	test_cmp expect actual &&
-	git for-each-ref --format="%(contents:trailers:unfold)" refs/heads/main >actual &&
-	test_cmp expect actual
-'
+test_trailer_option () {
+	title=$1 option=$2
+	cat >expect
+	test_expect_success "$title" '
+		git for-each-ref --format="%($option)" refs/heads/main >actual &&
+		test_cmp expect actual &&
+		git for-each-ref --format="%(contents:$option)" refs/heads/main >actual &&
+		test_cmp expect actual
+	'
+}
 
-test_expect_success '%(trailers:only) shows only "key: value" trailers' '
-	{
-		grep -v patch.description <trailers &&
-		echo
-	} >expect &&
-	git for-each-ref --format="%(trailers:only)" refs/heads/main >actual &&
-	test_cmp expect actual &&
-	git for-each-ref --format="%(contents:trailers:only)" refs/heads/main >actual &&
-	test_cmp expect actual
-'
+test_trailer_option '%(trailers:unfold) unfolds trailers' \
+	'trailers:unfold' <<-EOF
+	$(unfold <trailers)
 
-test_expect_success '%(trailers:only) and %(trailers:unfold) work together' '
-	{
-		grep -v patch.description <trailers | unfold &&
-		echo
-	} >expect &&
-	git for-each-ref --format="%(trailers:only,unfold)" refs/heads/main >actual &&
-	test_cmp expect actual &&
-	git for-each-ref --format="%(trailers:unfold,only)" refs/heads/main >actual &&
-	test_cmp actual actual &&
-	git for-each-ref --format="%(contents:trailers:only,unfold)" refs/heads/main >actual &&
-	test_cmp expect actual &&
-	git for-each-ref --format="%(contents:trailers:unfold,only)" refs/heads/main >actual &&
-	test_cmp actual actual
-'
-
-test_expect_success '%(trailers) rejects unknown trailers arguments' '
-	# error message cannot be checked under i18n
-	cat >expect <<-EOF &&
+	EOF
+
+test_trailer_option '%(trailers:only) shows only "key: value" trailers' \
+	'trailers:only' <<-EOF
+	$(grep -v patch.description <trailers)
+
+	EOF
+
+test_trailer_option '%(trailers:only) and %(trailers:unfold) work together' \
+	'trailers:only,unfold' <<-EOF
+	$(grep -v patch.description <trailers | unfold)
+
+	EOF
+
+test_trailer_option '%(trailers:unfold) and %(trailers:only) work together' \
+	'trailers:unfold,only' <<-EOF
+	$(grep -v patch.description <trailers | unfold)
+
+	EOF
+
+test_failing_trailer_option () {
+	title=$1 option=$2
+	cat >expect
+	test_expect_success "$title" '
+		# error message cannot be checked under i18n
+		test_must_fail git for-each-ref --format="%($option)" refs/heads/main 2>actual &&
+		test_i18ncmp expect actual &&
+		test_must_fail git for-each-ref --format="%(contents:$option)" refs/heads/main 2>actual &&
+		test_i18ncmp expect actual
+	'
+}
+
+test_failing_trailer_option '%(trailers) rejects unknown trailers arguments' \
+	'trailers:unsupported' <<-\EOF
 	fatal: unknown %(trailers) argument: unsupported
 	EOF
-	test_must_fail git for-each-ref --format="%(trailers:unsupported)" 2>actual &&
-	test_i18ncmp expect actual &&
-	test_must_fail git for-each-ref --format="%(contents:trailers:unsupported)" 2>actual &&
-	test_i18ncmp expect actual
-'
 
 test_expect_success 'if arguments, %(contents:trailers) shows error if colon is missing' '
 	cat >expect <<-EOF &&
-- 
gitgitgadget

