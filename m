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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48784C433DB
	for <git@archiver.kernel.org>; Mon, 15 Feb 2021 16:20:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0837F64DEE
	for <git@archiver.kernel.org>; Mon, 15 Feb 2021 16:20:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232605AbhBOQUo (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Feb 2021 11:20:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231803AbhBOPrq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Feb 2021 10:47:46 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56E58C0611BC
        for <git@vger.kernel.org>; Mon, 15 Feb 2021 07:45:05 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id v7so9412434wrr.12
        for <git@vger.kernel.org>; Mon, 15 Feb 2021 07:45:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vylORr5S+ndzIx7zVRls3YLCDREzNgpl3dI596MorL8=;
        b=jadLgV6D4cOrbMNFSjuJEIwldrZbijM9H2tWGqciWyA+6sqvg9pQHPrZL0klvKXUal
         jgj+0ERdiriPvQOGfBuHaDuxum74uGN2KTmEc1HyLwTOdDqs1LrbOr0sDl55DNhKtMid
         1A5oWL1OrpOf6cW1DX+eStATuzhCBHy5m3mpIAVaVMWMTb5+XzHPqwNYLLJTn2nTSPJM
         qWRvAJJCKRFjupDysl8f0WnhMWc/YPbFxY5RuCjYOmcAoK9n+0lLWFPvkAsedJZg8Gvk
         T7/KyMUAdO07d3ahpYXnKfkxc79wDCUTAtZO3b50OI0VKzjXkOMhSFNAIhqsQNnkfpfK
         0ZLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vylORr5S+ndzIx7zVRls3YLCDREzNgpl3dI596MorL8=;
        b=Q6epRhmk97YXzQ3jy8NLeu8dnOC8K3CHo4rc1EwEKSsNQHPUJtjxYQ1Q59kHB01Jjl
         JtlXzUayvHNYQzPurEflQ2utEJRTUvxkGMk4dauXHWj30DSLVgZsdbiQ9R9AkiQdP6wW
         l/ih7LayKypGnXNnVx0iA9GfsHZni2US/TlhXZniUfECJ8gH8dGvjKFSyUsBPi9Pnd7/
         W5nb5+WP3Z5z9uEPxCryOCVy3jXLlzM/FtStWAi4/Rp57BfPqDt5tq17X5z4WtMOd6Qh
         g5dUJf5W1NUwCUGdlCaez8ZcyMe30WkO3i1mQdSC0J0mwEk1FvB9EoVQZ8ud6l0ohO/S
         fMkA==
X-Gm-Message-State: AOAM531+CNqXJcrX++1hlWHsDA3qbQe8eCOJKlapY6hi4yrLU+1XO+9Q
        S7zCfg6baLNWSzqiu1+1tXC/pNYW2m/Ldw==
X-Google-Smtp-Source: ABdhPJzrl7BF/b9qE/yZ3zYZBW3aUupi4M6/E0udMmO2JDIWGXF5klsD+Mo04SzLxpau+axKGYmUfQ==
X-Received: by 2002:adf:bb54:: with SMTP id x20mr19762829wrg.112.1613403903887;
        Mon, 15 Feb 2021 07:45:03 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id f17sm23562757wrx.57.2021.02.15.07.45.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Feb 2021 07:45:03 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
        Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Adam Spiers <git@adamspiers.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Chris Torek <chris.torek@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 21/27] userdiff tests: factor out test_diff_funcname() logic
Date:   Mon, 15 Feb 2021 16:44:21 +0100
Message-Id: <20210215154427.32693-22-avarab@gmail.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7
In-Reply-To: <20210215005236.11313-1-avarab@gmail.com>
References: <20210215005236.11313-1-avarab@gmail.com>
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
index 3ba9d657b1..2efe4e5bdd 100755
--- a/t/t4018-diff-funcname.sh
+++ b/t/t4018-diff-funcname.sh
@@ -41,6 +41,17 @@ test_expect_success 'last regexp must not be negated' '
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
+	sed -n -e "s/^.*@@$//p" -e "s/^.*@@ //p" <$file
+}
+
 test_diff_funcname () {
 	desc=$1
 	cat <&8 >arg.header &&
@@ -51,13 +62,12 @@ test_diff_funcname () {
 		cp arg.test "$what" &&
 		cp arg.header expected &&
 		git add "$what" &&
-		sed -e "s/ChangeMe/IWasChanged/" <"$what" >tmp &&
-		mv tmp "$what"
+		do_change_me "$what"
 	' &&
 
 	test_expect_success "$desc" '
 		git diff -U1 "$what" >diff &&
-		sed -n -e "s/^.*@@$//p" -e "s/^.*@@ //p" <diff >actual &&
+		last_diff_context_line diff >actual &&
 		test_cmp expected actual
 	' &&
 
-- 
2.30.0.284.gd98b1dd5eaa7

