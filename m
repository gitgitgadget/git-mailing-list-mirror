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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B47EC2B9F4
	for <git@archiver.kernel.org>; Mon, 14 Jun 2021 17:28:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 25DE86023E
	for <git@archiver.kernel.org>; Mon, 14 Jun 2021 17:28:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235563AbhFNRau (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Jun 2021 13:30:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235553AbhFNRat (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Jun 2021 13:30:49 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D05A4C0613A2
        for <git@vger.kernel.org>; Mon, 14 Jun 2021 10:28:32 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id my49so17956438ejc.7
        for <git@vger.kernel.org>; Mon, 14 Jun 2021 10:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bSXH8bRey7wuwHqc6Jt8YuNfC+4mrWhQy3TzT5XeETw=;
        b=a91YFnmQDxOZFRmJ/wybTmg0QltiQ7F2i27o5F+cStkqXCjeO0quJLi2uFV8si0jbA
         KtM/08/pRc5tLSK8SsK9CDWKu7gBrucD+1DLKz++fEVL0NerAilRKS7j5YnxMKgm/lsd
         9i6mvbSotDYhYoBh3+inWG2R0ueKPOV3Bd+GBdZX6apOt5FFyzg9WzLeDZM+Pv8Z11Z/
         MR9RXDG0bJORGLLPH6b0gEmqeDa2cPqmIuksztwkdkP2TSwroGHC1w62BxxmRcoPcbxV
         xZ04fNVDiF/sqVFydNSm4U3Tuw6Op6444/PeKqQ0MCd9vCpHGynFcVQwWKLTgeWJwoLY
         NAMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bSXH8bRey7wuwHqc6Jt8YuNfC+4mrWhQy3TzT5XeETw=;
        b=UkxF/ijusHSKxfiU/88b8AqZX/2Dmzp5/D7unILGswPSVtuqayjdgp8FksFafBLe55
         HD96POWzeGiB9Xnn68Aq5p5Ph0MnLGbx497vpVxybDjpbjGiGfk/oCvPMGk+zrRnN5cZ
         ZGZA3bJq6I8kupeOo5MR56X8LNqkSixDQVclAo/9WagG4m7+twzjCSynoZb/PKlqHVVV
         BvujUcEZu6V/vYUk+NOtACL35tyIcLBNcez0QC7HLwSVlvjvsCoi+L5rrG0mHFeDucjM
         uGg7Ykaplg7TbkYNi675+ZWZvyyYTZa67Q+0urZRGo3IDxQxRfPPzjmP8/5V6DGM6Dcg
         eMVg==
X-Gm-Message-State: AOAM531Uscbke/mov34V2TKTl9p4TjURcxuUPCZBkp5bC4RHaeUhJoi7
        /ZVEGxustSUNdGlYU+Uba10Ufk+TyLVI6w==
X-Google-Smtp-Source: ABdhPJwiBS4s0Pysk5zCqev0rzGZBye1Gn8Q48Gqq2NAx7Njy3N4cyuOXMQEDBmuRYEOPlM8nPJ2HA==
X-Received: by 2002:a17:906:2456:: with SMTP id a22mr15924564ejb.496.1623691711095;
        Mon, 14 Jun 2021 10:28:31 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id a24sm9376233edt.96.2021.06.14.10.28.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jun 2021 10:28:30 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Olga Telezhnaya <olyatelezhnaya@gmail.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 6/6] mktag tests: test fast-export
Date:   Mon, 14 Jun 2021 19:28:23 +0200
Message-Id: <patch-6.6-6d613d88acc-20210614T172422Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.555.g0268d380f7b
In-Reply-To: <cover-0.6-00000000000-20210614T172422Z-avarab@gmail.com>
References: <cover-0.6-00000000000-20210614T172422Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Pass the bad tags we've created in the mktag tests through
fast-export, it will die on the bad object or ref, let's make sure
that happens.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t3800-mktag.sh | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/t/t3800-mktag.sh b/t/t3800-mktag.sh
index 7d0ad3c8e62..ad0da2cd2b2 100755
--- a/t/t3800-mktag.sh
+++ b/t/t3800-mktag.sh
@@ -85,6 +85,11 @@ check_verify_failure () {
 
 		test_must_fail git -C bad-tag for-each-ref --format="%(*objectname)"
 	'
+
+	test_expect_success "fast-export & fast-import: $subject" '
+		test_must_fail git -C bad-tag fast-export --all &&
+		test_must_fail git -C bad-tag fast-export $bad_tag
+	'
 }
 
 test_expect_mktag_success() {
-- 
2.32.0.555.g0268d380f7b

