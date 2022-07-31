Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01C28C19F2B
	for <git@archiver.kernel.org>; Sun, 31 Jul 2022 18:20:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236283AbiGaSUI (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 31 Jul 2022 14:20:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiGaSUF (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 31 Jul 2022 14:20:05 -0400
Received: from mail-ua1-x933.google.com (mail-ua1-x933.google.com [IPv6:2607:f8b0:4864:20::933])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B8CDB1D9
        for <git@vger.kernel.org>; Sun, 31 Jul 2022 11:20:03 -0700 (PDT)
Received: by mail-ua1-x933.google.com with SMTP id r12so3735552uaf.7
        for <git@vger.kernel.org>; Sun, 31 Jul 2022 11:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=QVEhpwR/nsAm3pfBVX29qb4QXg+PI99GMq8Ee/1D7ws=;
        b=hkBKIgiDsZbYBdn8dpvapG3NdT2S1dQfDbkEy6om+g7MW24ihNCg8ZoquYIoVY+y1S
         k0SFyiLMVeXAEQtPh54HhrxmK++kLbmvDkd4fSRH7V1542PE0CYeIatXc0jOqGImWlfN
         SKDr3D7Y9HxN+CMppuRpMq69rKa35NLxrBQZF4UHZC7sIh6JgCnxLx6OkbUk2d0gzDH5
         S2UWgKhxvB1RJ7j9VGI1Uu3NuJqJcSBG6x2jfpnsFdnxB3TdR3WbPrtM4dG4xvrfOuhA
         qxsgDgeWHLXqCydiobgcHQup8PqyOUisVcDkT1FiE9pjdl5L04Yrw8QvmMg8DvdHSC9z
         cLzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=QVEhpwR/nsAm3pfBVX29qb4QXg+PI99GMq8Ee/1D7ws=;
        b=MClS5PqzJOERwPaIQvPBaYBEMOpDh070tvby53Rjp+ZC4vh8Wlhqj8ybs2x79MeKeW
         Hvmibx9PDNg7gKZVEFE4s1ACdnj5SP1QtVG6mL3faxfEXNwHKNjcp4OnlLGTip/7DSkR
         ZHMUFi8LglgX8nvsLTtB9/2nkpiA7AKtKBHoAMqImDun5vj0XjRI/AT9CUt/OEtVpyNd
         YnjA++zt1JOLqmV7+W1WhP34O/YiKJ/4xgnvlBfg298HGvaTXVKPH/lZnv3ajpR/GnF/
         o0lBSRvN0bXrIOiSD56qbElBuQVf7ShBKuA7d4dJEB5SdB4B7u3fHFAyEr52DoT9hE+5
         unsQ==
X-Gm-Message-State: ACgBeo3sFF9WGVkBAxJUb+hq2doFahLiHYLazKiky2MXpvcg2/hOZKiM
        7/klqXuO8ClojdAqRjXNt04mblcvdX+dnQ==
X-Google-Smtp-Source: AA6agR7Yw9SQ1CGXOfU03K68oYalDWqFITDk8lG/YsvT+O3TnopMFByRKqC8koghwpzL6hzEF7ml5A==
X-Received: by 2002:ab0:2714:0:b0:383:63cc:70e7 with SMTP id s20-20020ab02714000000b0038363cc70e7mr4964215uao.97.1659291602349;
        Sun, 31 Jul 2022 11:20:02 -0700 (PDT)
Received: from mango.meuintelbras.local ([177.32.109.17])
        by smtp.gmail.com with ESMTPSA id l2-20020a056102050200b003573f2ff61asm3738795vsa.22.2022.07.31.11.20.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Jul 2022 11:20:01 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, avarab@gmail.com, johannes.schindelin@gmx.de
Subject: [PATCH v3 1/3] t0021: avoid grepping for a Perl-specific string at filter output
Date:   Sun, 31 Jul 2022 15:19:48 -0300
Message-Id: <5ec95c7e696a49104322d243bee1d5f137bc8222.1659291025.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <cover.1659291025.git.matheus.bernardino@usp.br>
References: <cover.1659291025.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This test sets the t0021/rot13-filter.pl script as a long-running
process filter for a git checkout command. It then expects the filter to
fail producing a specific error message at stderr. In the following
commits we are going to replace the script with a C test-tool helper,
but the test currently expects the error message in a Perl-specific
format. That is, when you call `die <msg>` in Perl, it emits
"<msg> at - line 1." In preparation for the conversion, let's avoid the
Perl-specific part and only grep for <msg> itself.

Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
 t/t0021-conversion.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t0021-conversion.sh b/t/t0021-conversion.sh
index 1c840348bd..963b66e08c 100755
--- a/t/t0021-conversion.sh
+++ b/t/t0021-conversion.sh
@@ -735,7 +735,7 @@ test_expect_success PERL 'process filter should restart after unexpected write f
 		rm -f debug.log &&
 		git checkout --quiet --no-progress . 2>git-stderr.log &&
 
-		grep "smudge write error at" git-stderr.log &&
+		grep "smudge write error" git-stderr.log &&
 		test_i18ngrep "error: external filter" git-stderr.log &&
 
 		cat >expected.log <<-EOF &&
-- 
2.37.1

