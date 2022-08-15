Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92BB1C25B06
	for <git@archiver.kernel.org>; Mon, 15 Aug 2022 01:07:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232007AbiHOBHA (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 14 Aug 2022 21:07:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiHOBG7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Aug 2022 21:06:59 -0400
Received: from mail-vk1-xa31.google.com (mail-vk1-xa31.google.com [IPv6:2607:f8b0:4864:20::a31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4229E1115F
        for <git@vger.kernel.org>; Sun, 14 Aug 2022 18:06:58 -0700 (PDT)
Received: by mail-vk1-xa31.google.com with SMTP id b81so3068324vkf.1
        for <git@vger.kernel.org>; Sun, 14 Aug 2022 18:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=QVEhpwR/nsAm3pfBVX29qb4QXg+PI99GMq8Ee/1D7ws=;
        b=GANcs1OthQC7KaERQwNvpDpdxIWJnFj6IhJttJ6cx2fzwQtUeThB/gzRXt5BeYSjdc
         3zsQtaodCvwYF0kFhnzWrIsu+Wi0mO0RUnlES+tDKZdM5hFGDE9AlYkDqbxhxesLCisX
         GxqahttmlArZCmP+y0g3jtIdbgPcC3wHqG6+vePrVMydUoG/ssxtclvhbvLW15leTul4
         IUB3Fjjxi6icoZ5bglV6HUrg+Cju5QeXkNCbDJ9vOim/f7WvlQkH/jmhhdYC0V5D3Pnr
         U8HZ2vVxpgY0tlGncWbHmKfWbOs+COimNatkmzdLf8WYzZWBiUH6UNZ6rgbTOn+S/t/Y
         sFkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=QVEhpwR/nsAm3pfBVX29qb4QXg+PI99GMq8Ee/1D7ws=;
        b=U9aXk/2lfRO+otGqBi1oK246MGL2V3ULCAZYjAt6L/CCeaON6ZgkNWDWT5K7ji73aO
         euQEvIfVAutSxynxFY86JrstVf+imFP1Qc0s4LDKPJwUGugUuzXozSbWmbH5tZ8Okz4j
         vxdrDZD6cV8/VdekNR4vyxFoLv+dHUuXvPjsuDkeFuTITpNY8jhgv1OQiRTcEUK9EYFh
         4B+lkw2QH0cRgmYl6jFCxAPzp5joMuhKs6C4NuE3g2frFF19V898Qjom9UdXllBRXG7b
         2ylIqIoae8OsMFXeJiYiZUgcrichqPnXTKvAX3cHPlFJ+XzxGJzkNxAMY71pa8s3aTYX
         cDDA==
X-Gm-Message-State: ACgBeo3YNwXpKYjJmpKBtiQ6AisLIi8M1g7y5OO9oPg31eekTA3E0MvV
        BGWATw9Mxf1Md5NgVKSubdWE7+qalnCUgw==
X-Google-Smtp-Source: AA6agR7BbmFoQv+DwWi6mqlFtIeMtDnfnjZFhEowdhzikkaVOLZW7mKSY7/QrB3kLPtwfk6DaBp1hQ==
X-Received: by 2002:a1f:2c58:0:b0:37c:e649:135e with SMTP id s85-20020a1f2c58000000b0037ce649135emr5660562vks.14.1660525617048;
        Sun, 14 Aug 2022 18:06:57 -0700 (PDT)
Received: from mango.meuintelbras.local ([177.32.109.17])
        by smtp.gmail.com with ESMTPSA id d66-20020a1f9b45000000b003791113188csm5943133vke.55.2022.08.14.18.06.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Aug 2022 18:06:56 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, avarab@gmail.com, johannes.schindelin@gmx.de
Subject: [PATCH v4 1/3] t0021: avoid grepping for a Perl-specific string at filter output
Date:   Sun, 14 Aug 2022 22:06:36 -0300
Message-Id: <64dc9af1ad90c31e988ea8d6ece4a23a930d57d0.1660522524.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <cover.1660522524.git.matheus.bernardino@usp.br>
References: <cover.1660522524.git.matheus.bernardino@usp.br>
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

