Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D33F3C433FE
	for <git@archiver.kernel.org>; Wed, 20 Oct 2021 18:40:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6EFB610D0
	for <git@archiver.kernel.org>; Wed, 20 Oct 2021 18:40:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231292AbhJTSmV (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Oct 2021 14:42:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230325AbhJTSmU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Oct 2021 14:42:20 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72A42C06161C
        for <git@vger.kernel.org>; Wed, 20 Oct 2021 11:40:05 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id g25so330155wrb.2
        for <git@vger.kernel.org>; Wed, 20 Oct 2021 11:40:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=W6EUYiqjbThAGB97XzJsl7LDwbgwXrXjrbwr96okR6Y=;
        b=Dljw5jozsqnBccvZDZBiJbFdUMIxU89qYUxYmB2sFmp4IpZVc2hfgObDSsxuwO4UMR
         Q6RZmosDKynA31I/ZnVW8XzmInEzW0XOf/pXOsb8DHZr5Nzo9EZwnpc/bswNj8uE/g90
         Chit9z6V8nRUOsplHKsEX0OkcyDh4zsg5DBxtJlbhbRtzUBpivC0jmWREmo2VT4es09Q
         DBljFn/dD/6rukPGpkiut5BZiIUh/fEkH7jsqr2WsiR/8OnuqPPvWWdbrO0xFdlNy0nh
         Ryy4TV/4YYIbAiFhcTm/e0pcKCQDCidnbeGZyTymZJnaqQSNc4/pnsULjce8jWMKAKON
         j7Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=W6EUYiqjbThAGB97XzJsl7LDwbgwXrXjrbwr96okR6Y=;
        b=2YC5nPjO242eP89YHwEEFC0YTj0x5ngv9oQwblvU6rdM3NG3dv9eN4hLeXvL28Y6Nm
         gRKxX5f7uovR9s9BV8NJ3WpDSGYQhGuIKwLLDp1Vvn5sdioMFIBQ2c/BEyDz/iZoydb9
         qxBARNrbZVOAE++IMPb2yVbDT2hBrXZe5/sSijPeFfcKOLTyG2xXZUfhCTNgNr09qfgK
         QBrQ5RJld2FZSoGJevvC3pnRLjpOZyhBdn4AzKIz5GJEPqsgnVY/eHdRqXCmB8yYHCYv
         bZN0iMDXODhxs5g76jcMGwf3LhfhrlHGoql+DVGSAQoIFcHVKyZDsKVORo+AmzKmFdmT
         Ey/A==
X-Gm-Message-State: AOAM533CRHKqpQ6vpc46AE5dXM0huwnOK5OyczLdC/dJwtNqbD8/8Aiz
        hoKCaRMCSBJXeUMtO1CQ7a0PyECcAJxNAA==
X-Google-Smtp-Source: ABdhPJzb6abw/+QABBHdKyRfEbH5733ZqwAN7l2x3e2UoHd90GaO+A5gTQXhB54pSCM6xQDxd/dgVQ==
X-Received: by 2002:adf:b19c:: with SMTP id q28mr1136198wra.348.1634755203588;
        Wed, 20 Oct 2021 11:40:03 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id d8sm2813835wrv.80.2021.10.20.11.40.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Oct 2021 11:40:02 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?q?=C3=98ystein=20Walle?= <oystwa@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 2/8] generate-cmdlist.sh: trivial whitespace change
Date:   Wed, 20 Oct 2021 20:39:53 +0200
Message-Id: <patch-2.8-5e8fef90e42-20211020T183533Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.1.1338.g20da966911a
In-Reply-To: <cover-0.8-00000000000-20211020T183533Z-avarab@gmail.com>
References: <YNqBtrXzUlJiuc7y@coredump.intra.peff.net> <cover-0.8-00000000000-20211020T183533Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This makes a subsequent diff smaller, and won't leave us with this
syntax nit at the end.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 generate-cmdlist.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/generate-cmdlist.sh b/generate-cmdlist.sh
index 9dbbb08e70a..5114f46680a 100755
--- a/generate-cmdlist.sh
+++ b/generate-cmdlist.sh
@@ -10,7 +10,7 @@ command_list () {
 }
 
 get_categories () {
-	tr ' ' '\012'|
+	tr ' ' '\012' |
 	grep -v '^$' |
 	sort |
 	uniq
-- 
2.33.1.1338.g20da966911a

