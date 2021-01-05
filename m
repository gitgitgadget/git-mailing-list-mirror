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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2BF9C43381
	for <git@archiver.kernel.org>; Tue,  5 Jan 2021 19:44:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BFEFF22D6F
	for <git@archiver.kernel.org>; Tue,  5 Jan 2021 19:44:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730887AbhAEToO (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Jan 2021 14:44:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730882AbhAEToN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Jan 2021 14:44:13 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BD82C061798
        for <git@vger.kernel.org>; Tue,  5 Jan 2021 11:43:32 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id r3so364243wrt.2
        for <git@vger.kernel.org>; Tue, 05 Jan 2021 11:43:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LMaLfHsrFtR5TbYrAS2TUcw4yJ/c8dS9VHRIf5BDh/o=;
        b=Te9611pfANkc1f34KVNPH28Lx0cG/O8b+YKepg+qVygHXJ3/BQcTEUvTiIYjgqSa3n
         mnwR17gZneg+cTq9L9c3Alzf8ClkDpO3sjLxoMn1PUDBkIic77xKycVmzo6YZM/vqz64
         vvGElvz/bt8F0D7vJ4AaaZgrKIY30MSMl1UeudhZWMxYxab99K/M7Wuu/VfgRBXwGoww
         TY0Gczqzw6aTnUtG3RWIEQ/uZaMO8TLFvR3qOcu2+29R3WtmNxpqqHOL3TvamybYEiA+
         0EQYFT4hYMkL3ckMUpHv6eOqTIfwKTVBoNL47dJ+eb7v8UglcEjVx7UnxMJhRa1oAZZg
         C1yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LMaLfHsrFtR5TbYrAS2TUcw4yJ/c8dS9VHRIf5BDh/o=;
        b=b1/1Yy3GplMqv2uJpmG7Cf+5emTr613M68u+2vtgjspU2i+Pq/5lhSEjTJfpTX+4sm
         VpnPQszfINcmvVzCFFQrXVkw8QVpKeP61EC0uQJIBOl7g929Eqb1Jy3yXZheOUZ3/lmx
         08gsFyZ0iRbb8aHJ8PeLTzd/hJLWETUQtpaJ273vFMKfSCS7C3ROY1oCPMkZMqvofdVZ
         hW2O2D6ovIJIq/VlEx/RRMB9fkhaZKjji+6+ulpZ0Vg1fRzUv/HOQNtupf0WTRYpLuUU
         ozPX2M56zkZuI+n5/4E3Z6v8khrFNVGgzMZIoqJ/K7nKu/oz+PmDJV0Fbic4SzofrPMO
         NR4g==
X-Gm-Message-State: AOAM531leTwiLY/r1C+gJr+jNKZiQyyzVe0GMosBQLaJw0frSXQlQa8G
        2103FHSyRAhJIFACAVe5TZrHrxp2Hzk3bg==
X-Google-Smtp-Source: ABdhPJypCWNBEGztuhL+hyrioV7BILff5YkFQYaNQMdFKX+T58LoqD7kswimkNDfvi85XNsWHJrt4g==
X-Received: by 2002:a05:6000:1d0:: with SMTP id t16mr1051286wrx.203.1609875811149;
        Tue, 05 Jan 2021 11:43:31 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id s6sm151113wro.79.2021.01.05.11.43.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jan 2021 11:43:30 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 04/23] mktag tests: don't needlessly use a subshell
Date:   Tue,  5 Jan 2021 20:42:33 +0100
Message-Id: <20210105194252.627-5-avarab@gmail.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8
In-Reply-To: <20201223013606.7972-1-avarab@gmail.com>
References: <20201223013606.7972-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The use of a subshell dates back to e9b20943b77 (t/t3800: do not use a
temporary file to hold expected result., 2008-01-04). It's not needed
anymore, if it ever was.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t3800-mktag.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t3800-mktag.sh b/t/t3800-mktag.sh
index d696aa4e52e..0e411e3c45f 100755
--- a/t/t3800-mktag.sh
+++ b/t/t3800-mktag.sh
@@ -14,7 +14,7 @@ test_description='git mktag: tag object verify test'
 check_verify_failure () {
 	expect="$2"
 	test_expect_success "$1" '
-		( test_must_fail git mktag <tag.sig 2>message ) &&
+		test_must_fail git mktag <tag.sig 2>message &&
 		grep "$expect" message
 	'
 }
-- 
2.29.2.222.g5d2a92d10f8

