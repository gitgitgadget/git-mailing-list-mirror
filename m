Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF012C433FE
	for <git@archiver.kernel.org>; Fri, 22 Apr 2022 09:53:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446273AbiDVJ4j (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Apr 2022 05:56:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1446277AbiDVJ40 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Apr 2022 05:56:26 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86C6F53E24
        for <git@vger.kernel.org>; Fri, 22 Apr 2022 02:53:28 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id e2so3999543wrh.7
        for <git@vger.kernel.org>; Fri, 22 Apr 2022 02:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=274u9YaugV/Hqu0TaIZDvO+dOsahuSqOk80Eg04ak3s=;
        b=nWdEslWW2tGthCKEVCYp9vov7Ji7vzs2Oq0isx/4CEv9eAIDPs2n2B5Ao8T5YQWRK+
         frrZ9vZb6qUFqc+dagUVJqXwp8C+rhDqZPPFRWCAtnsaue5c8iLH3XLGLVwV8sBvhYB8
         pTj/f+y64ZjFLqWWhyEX3W6JtFBwWjn39uNgrqSGBA6RdUs9FdVGugOtzfl1h0gWYvh3
         KbEJe3+NFSHzBf1n4rZeVwBM/ts5x2XZ2k2dFQBK8hnPNWyqvDKYj173scdEq9PFYaYf
         f3ya3FTikhvOtSADWTDwV2RH4fVLV7PVkdfjmHtcCXefkFoOyMg6tOBcrpPaXVR8FDVW
         YYOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=274u9YaugV/Hqu0TaIZDvO+dOsahuSqOk80Eg04ak3s=;
        b=laap1fuiLB42LDl+lQ1kB09KsJ0qhgw32K84O1DcuCpXEqG4X0pVHNVVbUH0TIPuL7
         zvccnSEoBe//KCgFA5EL3LrKnpyP90XZPyJUwNi8Mnw3TmWBvXo6w3XuLfCvZ4orDWDM
         3Eyaj+fdv0DycKuetM+RXBdBuL7fEeXS79Y4ZRT4DPG8Z55d5cqFmmqLmVJhWxCkd3Hg
         U42qjhgI9fSyAkAEwei4nmDiwrIXXyPfN3HVg1ZdWJZnzbpaxjezmBQlnr/l/bA0THBb
         A3ovGJZXPeVWrjt8yF0ACpAB76KkOYccBIW2sbyOii/FsuO1sA1EouoTLXUJHIPDL/Z2
         BoZA==
X-Gm-Message-State: AOAM530e1WmvElRuIoI99qpUeMjKhKJD+sA0LcV9kBukx1NWNJUY2ihD
        JaMVqgjnV8nmDFmp5VnY2R10KBVlAT9IZg==
X-Google-Smtp-Source: ABdhPJyXWtpMTMyOm9mIivnlHkRYgLCmkhs4PpCiwVl7YlK2nT8bBSIJ4VimBLA6TF7l5UGpG9RLtg==
X-Received: by 2002:adf:fa86:0:b0:207:aadd:bff5 with SMTP id h6-20020adffa86000000b00207aaddbff5mr2934143wrr.469.1650621206897;
        Fri, 22 Apr 2022 02:53:26 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i6-20020adfa506000000b0020ac34ec647sm1365561wrb.110.2022.04.22.02.53.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 02:53:26 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Carlo Arenas <carenas@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 5/5] Makefile: use $(OBJECTS) instead of $(C_OBJ)
Date:   Fri, 22 Apr 2022 11:53:16 +0200
Message-Id: <patch-5.5-0575faebc30-20220422T094624Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.0.879.g56a83971f3f
In-Reply-To: <cover-0.5-00000000000-20220422T094624Z-avarab@gmail.com>
References: <cover-0.5-00000000000-20220422T094624Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the preceding commit $(C_OBJ) added in c373991375a (Makefile: list
generated object files in OBJECTS, 2010-01-26) became synonymous with
$(OBJECTS). Let's avoid the indirection and use the $(OBJECTS)
variable directly instead.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Makefile | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/Makefile b/Makefile
index 6f8272ae4a4..ff6bab134d2 100644
--- a/Makefile
+++ b/Makefile
@@ -2616,9 +2616,7 @@ missing_compdb_dir =
 compdb_args =
 endif
 
-C_OBJ = $(OBJECTS)
-
-$(C_OBJ): %.o: %.c GIT-CFLAGS $(missing_dep_dirs) $(missing_compdb_dir)
+$(OBJECTS): %.o: %.c GIT-CFLAGS $(missing_dep_dirs) $(missing_compdb_dir)
 	$(QUIET_CC)$(CC) -o $*.o -c $(dep_args) $(compdb_args) $(ALL_CFLAGS) $(EXTRA_CPPFLAGS) $<
 
 %.s: %.c GIT-CFLAGS FORCE
@@ -2764,7 +2762,7 @@ XGETTEXT_FLAGS_SH = $(XGETTEXT_FLAGS) --language=Shell \
 	--keyword=gettextln --keyword=eval_gettextln
 XGETTEXT_FLAGS_PERL = $(XGETTEXT_FLAGS) --language=Perl \
 	--keyword=__ --keyword=N__ --keyword="__n:1,2"
-LOCALIZED_C = $(C_OBJ:o=c) $(LIB_H) $(GENERATED_H)
+LOCALIZED_C = $(OBJECTS:o=c) $(LIB_H) $(GENERATED_H)
 LOCALIZED_SH = $(SCRIPT_SH)
 LOCALIZED_SH += git-sh-setup.sh
 LOCALIZED_PERL = $(SCRIPT_PERL)
@@ -3014,7 +3012,7 @@ t/helper/test-%$X: t/helper/test-%.o GIT-LDFLAGS $(GITLIBS) $(REFTABLE_TEST_LIB)
 check-sha1:: t/helper/test-tool$X
 	t/helper/test-sha1.sh
 
-SP_OBJ = $(patsubst %.o,%.sp,$(C_OBJ))
+SP_OBJ = $(patsubst %.o,%.sp,$(OBJECTS))
 
 $(SP_OBJ): %.sp: %.c %.o
 	$(QUIET_SP)cgcc -no-compile $(ALL_CFLAGS) $(EXTRA_CPPFLAGS) \
-- 
2.36.0.879.g56a83971f3f

