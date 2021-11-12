Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CB51C43217
	for <git@archiver.kernel.org>; Fri, 12 Nov 2021 21:49:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55E6360F70
	for <git@archiver.kernel.org>; Fri, 12 Nov 2021 21:49:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236006AbhKLVwX (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Nov 2021 16:52:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235953AbhKLVwO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Nov 2021 16:52:14 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7575C06122B
        for <git@vger.kernel.org>; Fri, 12 Nov 2021 13:49:19 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id d5so17907317wrc.1
        for <git@vger.kernel.org>; Fri, 12 Nov 2021 13:49:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xEJiBWFHSI9P56F7PPLXMo3n3X/3994AFRcJIHKkfDw=;
        b=h55w2isCT5yQjoCuGPn2cGniHahReinGrCbwX2zoLKlJ+H+1CcKReYVQ3iZ41BTvBy
         blCkEf7S6OdVeMhrLXDCJYankf8jaUOZuzRSbPh9tqN4UONBWSRX6bQQT42osQjM2NzJ
         4r6HAlaJGfeMob7bKgGyLCYfX1gwMFuZO6Ozh5DxlkvxxNNQDeZMK03zPNGPBfGG0ON5
         h6Rc9xTUZIQItcLKvxxI7yyU11FTI/PgO2wzM6X2bRq/2UN14KreuBrXbNsOHKla29Zw
         5j9tuZB582T8eYQyQyNsgSXxPnR5k4401B7tUM+0s33DTbfHvHJ+til0rcaixAVn8UHH
         5Hrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xEJiBWFHSI9P56F7PPLXMo3n3X/3994AFRcJIHKkfDw=;
        b=mbkmaj2JvPPBfnpOGw+SMwx1nInLZVS9DWTKkbw8PfVh43eyXur2aP3CfZKwabrVFV
         BRDteqq961P0tg8/pQhIhSLYZ1btnyYnVGFrHr+hq9fmBpDmBEiZPDhb6YCC7FSath/u
         rBzdRxyEtox9crAxeJ9NjjAou4/5dzGuM5QA9eJg/92oOAoddZjrMqwI4nBCE+SfQECH
         m6ng88wQEsGIl4vmK07Cyc3ZEnPD/f3pN5QyQSvCMSef5xIRi8417xNCPU0RFZeR3mX7
         R1hIfeuD7WvWjHgG02zkhrY/dUg6FTQFXUOda1zd8p2udcLiL8BxpkMPDl8+yMyBFC3c
         TmTA==
X-Gm-Message-State: AOAM530gPQ2Jho50U6hRv8QtWefqYeZEILwiowrYbYJIB3VV9xNEZBL0
        poVYE96+a6QOa+UzQHaS5GJyDV+UYdBteQ==
X-Google-Smtp-Source: ABdhPJxgxiZqqpMXc6cdHoNU1+pliLGJbJYPCmhtJqLWFvtXufMvFotOZ+Rcm3dsEs83FtnkWR5s1g==
X-Received: by 2002:a5d:6da5:: with SMTP id u5mr22922426wrs.374.1636753757918;
        Fri, 12 Nov 2021 13:49:17 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id h27sm14117189wmc.43.2021.11.12.13.49.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Nov 2021 13:49:17 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Jeff King <peff@peff.net>, Dan Jacques <dnj@google.com>,
        Eric Wong <e@80x24.org>, Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 12/18] Makefiles: add "shared.mak", move ".DELETE_ON_ERROR" to it
Date:   Fri, 12 Nov 2021 22:48:56 +0100
Message-Id: <patch-v2-12.18-656d02ab641-20211112T214150Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.0.rc2.795.g926201d1cc8
In-Reply-To: <cover-v2-00.18-00000000000-20211112T214150Z-avarab@gmail.com>
References: <cover-00.16-00000000000-20211106T205717Z-avarab@gmail.com> <cover-v2-00.18-00000000000-20211112T214150Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We have various behavior that's shared across our Makefiles, or that
really should be (e.g. via defined templates). Let's create a
top-level "shared.mak" to house those sorts of things, and start by
adding the ".DELETE_ON_ERROR" flag to it.

See my own 7b76d6bf221 (Makefile: add and use the ".DELETE_ON_ERROR"
flag, 2021-06-29) and db10fc6c09f (doc: simplify Makefile using
.DELETE_ON_ERROR, 2021-05-21) for the addition and use of the
".DELETE_ON_ERROR" flag.

This does have the potential downside that if e.g. templates/Makefile
would like to include this "shared.mak" in the future the semantics of
such a Makefile will change, but as noted in the above commits (and
GNU make's own documentation) any such change would be for the better,
so it's safe to do this.

This also doesn't introduce a bug by e.g. having this
".DELETE_ON_ERROR" flag only apply to this new shared.mak, Makefiles
have no such scoping semantics.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/Makefile |  6 +++---
 Makefile               | 13 +++----------
 shared.mak             |  9 +++++++++
 3 files changed, 15 insertions(+), 13 deletions(-)
 create mode 100644 shared.mak

diff --git a/Documentation/Makefile b/Documentation/Makefile
index ed656db2ae9..ba27456c86a 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -1,3 +1,6 @@
+# Import tree-wide shared Makefile behavior and libraries
+include ../shared.mak
+
 # Guard against environment variables
 MAN1_TXT =
 MAN5_TXT =
@@ -524,7 +527,4 @@ doc-l10n install-l10n::
 	$(MAKE) -C po $@
 endif
 
-# Delete the target file on error
-.DELETE_ON_ERROR:
-
 .PHONY: FORCE
diff --git a/Makefile b/Makefile
index 8205614c6ec..5ae7d012cfb 100644
--- a/Makefile
+++ b/Makefile
@@ -1,3 +1,6 @@
+# Import tree-wide shared Makefile behavior and libraries
+include shared.mak
+
 # The default target of this Makefile is...
 all::
 
@@ -2158,16 +2161,6 @@ shell_compatibility_test: please_set_SHELL_PATH_to_a_more_modern_shell
 strip: $(PROGRAMS) git$X
 	$(STRIP) $(STRIP_OPTS) $^
 
-### Flags affecting all rules
-
-# A GNU make extension since gmake 3.72 (released in late 1994) to
-# remove the target of rules if commands in those rules fail. The
-# default is to only do that if make itself receives a signal. Affects
-# all targets, see:
-#
-#    info make --index-search=.DELETE_ON_ERROR
-.DELETE_ON_ERROR:
-
 ### Target-specific flags and dependencies
 
 # The generic compilation pattern rule and automatically
diff --git a/shared.mak b/shared.mak
new file mode 100644
index 00000000000..0170bb397ae
--- /dev/null
+++ b/shared.mak
@@ -0,0 +1,9 @@
+### Flags affecting all rules
+
+# A GNU make extension since gmake 3.72 (released in late 1994) to
+# remove the target of rules if commands in those rules fail. The
+# default is to only do that if make itself receives a signal. Affects
+# all targets, see:
+#
+#    info make --index-search=.DELETE_ON_ERROR
+.DELETE_ON_ERROR:
-- 
2.34.0.rc2.795.g926201d1cc8

