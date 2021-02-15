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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31D72C433E9
	for <git@archiver.kernel.org>; Mon, 15 Feb 2021 00:55:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0AC3264E75
	for <git@archiver.kernel.org>; Mon, 15 Feb 2021 00:55:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230224AbhBOAzX (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 14 Feb 2021 19:55:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230160AbhBOAyj (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Feb 2021 19:54:39 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43FC9C06121D
        for <git@vger.kernel.org>; Sun, 14 Feb 2021 16:53:14 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id l17so4719798wmq.2
        for <git@vger.kernel.org>; Sun, 14 Feb 2021 16:53:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=l9v+px97V4yYRgKRXikUPIuux0GOzihLG6GbhTTTYuA=;
        b=BYv6PQOnxJteAjct/d9wDoHbtYknmr35cRfkAodDZFpB7Qdb+H0wJESksHWwVOVWmC
         /CibA5rv6A+up4i+pBXgjVzod1avSezRqY8zR4JGqXUE3e0fvTbm9BaZvebCUqmd9eoY
         hpJIwhexM94XiItdlQdTZtKeFK888K6xLVl0JY2EdBxv54SRbXuufKfa8TVMIUhcqZZf
         8Ex3zk2pGz19qMPD9LVnbRAZnfJH/09rHmqPwK803dAAiRerW0CZQ3y9oqABN9d9IOe8
         lBSPJuytDyD2cQxHbqKZKIwb3fz3Itc0+u27ZcKAk1V8ZZUmEfCk/Ukc2j6X0wEIhZZb
         S75w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=l9v+px97V4yYRgKRXikUPIuux0GOzihLG6GbhTTTYuA=;
        b=FCuQ345pJVFv7/cegqdhRwzPMcP52DMdkt9zz6XUaR+m9EhG2f09Q54aUg5njjioPX
         fH1GKEVJUJo8VAWYf2d/6P4KEVahPSPaD6cDYoa7XgECGVpWgaegndiDuBNAt1/0Eo64
         5r4KakhsoPHogNGc6TE/vuHyzZrz0hDe1Rz4uWmxSZnWZC4ntoRCwydTV6GTfl6xAHx/
         TU0Mt2KHm+HisPcVKuTpiIoUNHWUWrLnTqy/KqOmjXjFjSwfnskg3aWMaOJiG3z8HoXz
         VxpRFYigInPYgMoIqJk8k/T4vPfcT0Y7nOoZ8bB02W9THuWzEnzh1zMOWUgr5Z1qe3kg
         1mzA==
X-Gm-Message-State: AOAM532o81qd1OxkpdEPf1K7w9NQ/xDJf9LqVSS96UKUwFkQBj9P6lGD
        Zm5RW5Zu6lupbyOTW7JzVOqiUHZks91Q0Q==
X-Google-Smtp-Source: ABdhPJyZfKyLB5fnlkmd2AyQ7TPvXu+oGUp5ffEowSMv13mekXUS0OhsuYyCt0PQ94z8/X80Ksp/ag==
X-Received: by 2002:a7b:c20c:: with SMTP id x12mr3385243wmi.174.1613350392807;
        Sun, 14 Feb 2021 16:53:12 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id 3sm5209832wmi.2.2021.02.14.16.53.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Feb 2021 16:53:12 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
        Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Adam Spiers <git@adamspiers.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 17/20] userdiff tests: factor out test_diff_funcname() logic
Date:   Mon, 15 Feb 2021 01:52:33 +0100
Message-Id: <20210215005236.11313-18-avarab@gmail.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7
In-Reply-To: <87tuqebj6m.fsf@evledraar.gmail.com>
References: <87tuqebj6m.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Factor out logic in test_diff_funcname() into two helper functions,
these will be useful in a follow-up commit where we'll do this munging
in more than one place.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t4018-diff-funcname.sh | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/t/t4018-diff-funcname.sh b/t/t4018-diff-funcname.sh
index 3e4c07e42b..7a830ec57f 100755
--- a/t/t4018-diff-funcname.sh
+++ b/t/t4018-diff-funcname.sh
@@ -47,6 +47,17 @@ test_expect_success 'last regexp must not be negated' '
 	test_i18ngrep ": Last expression must not be negated:" msg
 '
 
+do_change_me () {
+	file=$1
+	sed -e "s/ChangeMe/IWasChanged/" <"$file" >tmp &&
+	mv tmp "$file"
+}
+
+last_diff_context_line () {
+	file=$1
+	sed -n -e "s/^.*@@\( \|$\)//p" <$file
+}
+
 test_diff_funcname () {
 	desc=$1
 	cat <&8 >arg.header &&
@@ -57,13 +68,12 @@ test_diff_funcname () {
 		cp arg.test "$what" &&
 		cp arg.header expected &&
 		git add "$what" &&
-		sed -e "s/ChangeMe/IWasChanged/" <"$what" >tmp &&
-		mv tmp "$what"
+		do_change_me "$what"
 	' &&
 
 	test_expect_success "$desc" '
 		git diff -U1 "$what" >diff &&
-		sed -n -e "s/^.*@@\( \|$\)//p" <diff >actual &&
+		last_diff_context_line diff >actual &&
 		test_cmp expected actual
 	'
 }
-- 
2.30.0.284.gd98b1dd5eaa7

