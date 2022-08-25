Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F399AC28D13
	for <git@archiver.kernel.org>; Thu, 25 Aug 2022 14:36:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242192AbiHYOgj (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Aug 2022 10:36:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242094AbiHYOgb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Aug 2022 10:36:31 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 163F1AB4C3
        for <git@vger.kernel.org>; Thu, 25 Aug 2022 07:36:27 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id az27so4877237wrb.6
        for <git@vger.kernel.org>; Thu, 25 Aug 2022 07:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=8LT3wa/OX9D8faFizjEvyVbonccUPvwf6feJR3+miMQ=;
        b=PyRZhUUuONrs7NOzY6FS3I47mh8L7nOmSmE3dH5Dx8DsJwUpVFeoi1G8Pc6dkXe1jT
         /1sH8cBPauNiq7qEC1Opqx+1EbgzAOo5vb2DN8vVCumnfneYlpUiMyuR7Xw/BFDn/xlp
         vwCFH+1v76FA3SDDWfTqUgg3nsZr2R6rStwci8QNGw/8OBtk57U5Mdk650kOzbjtYdie
         wqbISOpIlhQMruNG6YojNr1xQ/JbYYakCdxK1J2cHoc8MD2w1HoA9Mv57sjj5enQnqlo
         c+cySTPSF2XWaKodofpBUlnbnmIrEY1eBT0QuI9sZ7+5JGv9x8bDE2Y5WDHgrQjYPu4H
         6ELg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=8LT3wa/OX9D8faFizjEvyVbonccUPvwf6feJR3+miMQ=;
        b=BYCC7+egau4Zk0+mqMQVRspS9pmrXeQelFUDeM/BIHUc9iuqFu93BK7k1IOQFz0rbX
         EwiLdjYm/mb88mtjmleX5FNQFzzqqfVMxJH4yqqxoa/8ULChHVqPzpQl4TrZCKz6NbTj
         em3NngIEToJy0OnoR37heIwsEksVbW8CTMvCl6mOCqkNsW83rQVmT5BuqxNXJ4JIQsFx
         goUATRt0YE2M43Qa10NLxsrlVUbw/ubPWNsTNPAxyvZ9+/27BFvcQiRZZtSPHq0ySOrh
         n5TvjPCll26ZWB+i1xR1jU0H3bkh4TaZCYHosztm2zVmIpFT3aTG/nQOQYqrCei1FWsN
         M1CA==
X-Gm-Message-State: ACgBeo2vS7GdXmi1NmZqPMwAAK4yTCK2FvROK4xgyMLcvRbY1HheUfZV
        c3tM3WjxvqOntUOBqeos0UhjDRj6V7HupQ==
X-Google-Smtp-Source: AA6agR5S9H4t/0rgQsSnSedby1Ypk8e5Q7NLbuoU0M+QGHb5FF1Or7FvJG/9270LgIhidFYKBx+sJA==
X-Received: by 2002:a05:6000:178f:b0:221:7dcb:7cbf with SMTP id e15-20020a056000178f00b002217dcb7cbfmr2570201wrg.58.1661438184846;
        Thu, 25 Aug 2022 07:36:24 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id m27-20020a056000181b00b0022549ac786asm14418027wrh.47.2022.08.25.07.36.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Aug 2022 07:36:24 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 4/5] cocci: make incremental compilation even faster
Date:   Thu, 25 Aug 2022 16:36:16 +0200
Message-Id: <patch-4.5-cda20790146-20220825T141212Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.2.1279.g64dec4e13cf
In-Reply-To: <cover-0.5-00000000000-20220825T141212Z-avarab@gmail.com>
References: <cover-0.5-00000000000-20220825T141212Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Make the incremental compilation of "make coccicheck" even faster, at
the cost of losing dependency discovery for a small whitelist of *.c
files which we can't create *.o files for.

This will break obscure edge cases since e.g.:

    time make -W block-sha1/sha1.h coccicheck

Would correctly re-build before, as block-sha1/sha1.c uses
block-sha1/sha1.h, but as it and these other
$(USE_TINY_FOUND_H_SOURCES) files depended on the union of all such
headers (and more, all of $(FOUND_H_SOURCES)) the above command would
take ~10 seconds before.

As noted in the preceding commit these obscure cases were broken
before the preceding commit fixed them. I think it makes sense to make
a correctness v.s. performance trade-off here. By doing this it
becomes viable to e.g. run "make coccicheck" in the same loop that
merges various topic branches down (along with "ccache" sped-up
compilation).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Makefile | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index a374204aaca..9410a587fc0 100644
--- a/Makefile
+++ b/Makefile
@@ -3160,6 +3160,16 @@ COCCICHECK_OK = $(COCCICHECK:%=.build/%.ok)
 COCCICHECK_PENDING_OK = $(COCCICHECK_PENDING:%=.build/%.ok)
 COCCI_TEST_RES = $(wildcard contrib/coccinelle/tests/*.res)
 
+USE_TINY_FOUND_H_SOURCES =
+USE_TINY_FOUND_H_SOURCES += compat/%
+USE_TINY_FOUND_H_SOURCES += block-sha1/%
+USE_TINY_FOUND_H_SOURCES += ppc/%
+
+TINY_FOUND_H_SOURCES =
+TINY_FOUND_H_SOURCES += cache.h
+TINY_FOUND_H_SOURCES += git-compat-util.h
+TINY_FOUND_H_SOURCES += strbuf.h
+
 .build/contrib/coccinelle/FOUND_H_SOURCES: $(FOUND_H_SOURCES)
 	$(call mkdir_p_parent_template)
 	$(QUIET_GEN) >$@
@@ -3171,7 +3181,7 @@ define cocci-rule
 # 2 = $(2)
 COCCI_$(1:contrib/coccinelle/%.cocci=%) += .build/$(1).patch/$(2)
 .build/$(1).patch/$(2): GIT-SPATCH-DEFINES
-.build/$(1).patch/$(2): $(if $(wildcard $(3)),$(3),.build/contrib/coccinelle/FOUND_H_SOURCES)
+.build/$(1).patch/$(2): $(if $(wildcard $(3)),$(3),$(if $(filter $(USE_TINY_FOUND_H_SOURCES),$(3)),$(TINY_FOUND_H_SOURCES),.build/contrib/coccinelle/FOUND_H_SOURCES))
 .build/$(1).patch/$(2): $(1)
 .build/$(1).patch/$(2): .build/$(1).patch/% : %
 	$$(call mkdir_p_parent_template)
-- 
2.37.2.1279.g64dec4e13cf

