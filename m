Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAC44C43461
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 12:50:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F4EA613C9
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 12:50:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232160AbhDTMvY (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Apr 2021 08:51:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232094AbhDTMvU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Apr 2021 08:51:20 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 429B4C06138B
        for <git@vger.kernel.org>; Tue, 20 Apr 2021 05:50:49 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id k17so5413334edr.7
        for <git@vger.kernel.org>; Tue, 20 Apr 2021 05:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=D8DWL9PryUWitqPfiWdEg4/pquXBWMQuSrg2VTNdYYk=;
        b=uiYOj/iLGfwG05w0Ot+xT8tTdk4MOEVnvZfRw4MF5umBY4HGKFJQIQHXulxvUUt6FD
         pErIeSt4jIemiHbBXzzLbqTVs6wGIUymYTw5NVUNQ73sqCPdSMPJwb76S+e/FjClunS5
         bXwPg5OKdFLnnesF9Hrd21yxLkNvleBr94SO9mVUEo9V0SMdDwKHLmC2ZVL6El6YvhrP
         i2WjNR9XbMU8j4/v932RJdGKwLo5W0T5QiFIQU832zxqYNxBHP4b+cPmo00dzHuSuZ0y
         HjDdNIqN9tHJprVg2Lc2/VwSPriY1DdiwS0jT3BwTIqwdyk8ulNFLiSox5aURXUdRz4r
         uYMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=D8DWL9PryUWitqPfiWdEg4/pquXBWMQuSrg2VTNdYYk=;
        b=ov7Qo7bnjPzy2xjEm2MXOXjQJqRUipIkMbWeTbleMWzYsB0K67VUpPtX+cxL1pNVb1
         S01Zlg40vYUhxIX3PoR1VgtvwPSlAmIs3PSovw35NwdYz70GXN85felLdPkRsUN+6Wmh
         5tH8Ns/uE9dWOGk34n8+pkaQgKzWlrixoVLPRZk4WLIoWC4kdW6nHVlqp/1kT+LIRdpi
         /Ls4ZVBEHDq3gyCYE8hK/4qPFEAK1M57RTXec4MuL8gSKBsOtXRmbT4UJUbBkLcjN80n
         43durv3IvSCqfcfGViOfHmacv9FvC6C6vuLGxjoE6RrkmjOciUvqq69R8USv3Mit8fao
         V43A==
X-Gm-Message-State: AOAM531EJc13rzx9/t3QSZUHOFkcpzAXVW+sMRmgp9OGPbUoLgwU8WWr
        OtmZpkJ4bVLvh28AAqbRJdO3wz3Jr0NVXg==
X-Google-Smtp-Source: ABdhPJxJvlo9p1uJwFRytFPWHxzxHJMgy/Z77CVt5AGhRcmfuhfyrdR8/cDaSNE4gkegrTzvhSBSYA==
X-Received: by 2002:aa7:d74a:: with SMTP id a10mr20563421eds.82.1618923047784;
        Tue, 20 Apr 2021 05:50:47 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id f3sm12630900eje.45.2021.04.20.05.50.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Apr 2021 05:50:47 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 03/10] mktree tests: add test for invalid object type
Date:   Tue, 20 Apr 2021 14:50:36 +0200
Message-Id: <patch-03.10-cd585017a9-20210420T124428Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.723.ga5d7868e4a
In-Reply-To: <cover-00.10-0000000000-20210420T124428Z-avarab@gmail.com>
References: <cover-0.3-0000000000-20210409T080534Z-avarab@gmail.com> <cover-00.10-0000000000-20210420T124428Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a missing test for an invalid object type to the mktree tests,
making it consistent with the same tests in cat-file.c. This tests the
interaction of mktree_line() and type_from_string().

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t1010-mktree.sh | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/t/t1010-mktree.sh b/t/t1010-mktree.sh
index b946f87686..2a7b04aed8 100755
--- a/t/t1010-mktree.sh
+++ b/t/t1010-mktree.sh
@@ -58,6 +58,16 @@ test_expect_success 'allow missing object with --missing' '
 	test_cmp tree.missing actual
 '
 
+test_expect_success 'invalid object type' '
+	sed "s/tree/whee/g" <top >bad-type &&
+	test_must_fail git mktree <bad-type >out 2>err &&
+	test_must_be_empty out &&
+	cat >expected <<-\EOF &&
+	fatal: invalid object type "whee"
+	EOF
+	test_cmp expected err
+'
+
 test_expect_success 'mktree refuses to read ls-tree -r output (1)' '
 	test_must_fail git mktree <all >actual
 '
-- 
2.31.1.723.ga5d7868e4a

