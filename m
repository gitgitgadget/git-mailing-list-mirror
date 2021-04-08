Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FB4AC433B4
	for <git@archiver.kernel.org>; Thu,  8 Apr 2021 15:04:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 76B55610F9
	for <git@archiver.kernel.org>; Thu,  8 Apr 2021 15:04:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232039AbhDHPEw (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Apr 2021 11:04:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231866AbhDHPEr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Apr 2021 11:04:47 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F17DC061760
        for <git@vger.kernel.org>; Thu,  8 Apr 2021 08:04:34 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id r22so2809431edq.9
        for <git@vger.kernel.org>; Thu, 08 Apr 2021 08:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GRRkyuS62ZqQMWQ8IsjuEQ2HYCe6NZPijV+7kz69Mp8=;
        b=uI3CBf5Tgg11Cz2WAdWkgwoTwExyL7DBqrQDJmS7u2IFmj8S3Z+ILusdJorvVJR0wr
         iojtmr1Ccg8jFrKFofItTmmQSVeirbwuztgv3H8khSYZZH4tDjJ9ovAvHCGY9HGMhObX
         CCsb+4EFZiIJvSb4lMIkm9EouIdXXmnk02STBqfk/xkSAG+uM4MAy3BhEsbCOIPRyEZ/
         D56N9VcRuyeb016C/zQ/AJO1bbs0Ssj79Bae3ERAzX8kvgf6e0ces6W/x1dgvk29njPT
         0Gx5ygeiXh4eIOOktWxSxNaRS11mv8QZgGkjYM4HI/xUXE5aeUE+AfSLsW+Z5KlbmSBg
         Wjig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GRRkyuS62ZqQMWQ8IsjuEQ2HYCe6NZPijV+7kz69Mp8=;
        b=KhlMAdjxFZSAd15cLJT6ehGWR3CMQdfwDFAHjCvQnj5VMctUgUP1JiOJ8Es0WBFEyj
         AVbhMwpHTp2o3/y2DF9k37Sm9NcOEER/Qz4mi4vUJS8qDFA/XXh3+xRbm0tDsxhse47l
         66RKj17pU+IZdj1+3Hrcaf5MIhnLzoIS1eR/bFYSLRDUpBjgnDqfYS42jfBAkTZSdB6G
         zqYPIKXdLOnWMB6H83EmH5UMnAUbk70CdK/gEndiGrqFY24nHTX9EuugNE+W18ZZ/Nlv
         4ppoXYl+5SFzHcC3als61jqCq0gGrI3jp9+V44AVDxQvFfb9lq3zRI6FmBXakXI+ECLF
         8lLA==
X-Gm-Message-State: AOAM531httwQRVjDL5jNGG9fXciOWxdONt4qwkQMTGpedGOnczcBVqzx
        YJV8888ttpGHrzYShcUay/5CEzxQQnycEQ==
X-Google-Smtp-Source: ABdhPJx/zHJmtIcoeA/aIk9/VtD2+w7pfbbTZXcaV4ZRQD9NbYGG+3L0CQ3WFnAzLxld5EjNRGI1DQ==
X-Received: by 2002:a05:6402:2744:: with SMTP id z4mr12033758edd.347.1617894272474;
        Thu, 08 Apr 2021 08:04:32 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id h25sm2479253ejx.105.2021.04.08.08.04.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Apr 2021 08:04:31 -0700 (PDT)
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
Subject: [PATCH v5 0/9] userdiff: refactor + test improvements
Date:   Thu,  8 Apr 2021 17:04:15 +0200
Message-Id: <cover-00.10-0000000000-20210408T145833Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.527.g9b8f7de2547
In-Reply-To: <cover-00.11-00000000000-20210324T014604Z-avarab@gmail.com>
References: <cover-00.11-00000000000-20210324T014604Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As noted in v3[1] this is the start of some wider userdiff test
improvements.

Since v3 I've ejected the parse_bool() change at the start of the
series. I split that into another series[2]:

This one applies on master, and doesn't conflict with the tiny
unrelated change in userdiff.c done in that series either textually or
semantically.

Changes since v3:

 * Jeff and Junio suggested refactoring the userdiff.c callback
   facility. I've done that using some union of their suggetions, I
   think it's easier to read this time around.

   Basically, the "for each userdiff" callback doesn't take a "I want
   this type", that's now handled in the user callback, which
   simplifies things a lot.

 * Other minor changes related to the above, e.g. renaming the CB
   struct per Jeff's suggestion.

 * I found that the "list-custom-drivers" I'd added for completeness
   to the helper didn't work, I needed to setup the .git dir and
   config in the helper. That's now done, and the tests check that the
   helper does the right thing.

1. https://lore.kernel.org/git/20210224195129.4004-1-avarab@gmail.com/
2. https://lore.kernel.org/git/cover-0.6-0000000000-20210408T133125Z-avarab@gmail.com/

Ævar Arnfjörð Bjarmason (9):
  userdiff style: re-order drivers in alphabetical order
  userdiff style: declare patterns with consistent style
  userdiff style: normalize pascal regex declaration
  userdiff: add and use for_each_userdiff_driver()
  userdiff tests: explicitly test "default" pattern
  userdiff tests: list builtin drivers via test-tool
  userdiff: remove support for "broken" tests
  blame tests: don't rely on t/t4018/ directory
  blame tests: simplify userdiff driver test

 Makefile                 |   1 +
 t/annotate-tests.sh      |  34 ++++----
 t/helper/test-tool.c     |   1 +
 t/helper/test-tool.h     |   1 +
 t/helper/test-userdiff.c |  46 +++++++++++
 t/t4018-diff-funcname.sh |  53 +++++-------
 t/t4018/README           |   3 -
 userdiff.c               | 169 ++++++++++++++++++++++++++-------------
 userdiff.h               |  13 +++
 9 files changed, 213 insertions(+), 108 deletions(-)
 create mode 100644 t/helper/test-userdiff.c

Range-diff:
 1:  fb7346cd29 <  -:  ---------- userdiff: refactor away the parse_bool() function
 2:  149387155b =  1:  2f7a7b2897 userdiff style: re-order drivers in alphabetical order
 3:  faf1a824f0 =  2:  22e48f33b6 userdiff style: declare patterns with consistent style
 4:  1e9ddcd1a9 =  3:  dff2aa0d38 userdiff style: normalize pascal regex declaration
 5:  64ea5e8443 !  4:  1a3a61e389 userdiff: add and use for_each_userdiff_driver()
    @@ userdiff.c: static struct userdiff_driver driver_false = {
      };
      
     -static struct userdiff_driver *userdiff_find_by_namelen(const char *k, size_t len)
    -+struct for_each_userdiff_driver_cb {
    -+	const char *k;
    ++struct find_by_namelen_data {
    ++	const char *name;
     +	size_t len;
     +	struct userdiff_driver *driver;
     +};
    @@ userdiff.c: static struct userdiff_driver driver_false = {
     -		struct userdiff_driver *drv = builtin_drivers + i;
     -		if (!strncmp(drv->name, k, len) && !drv->name[len])
     -			return drv;
    -+	struct for_each_userdiff_driver_cb *cb_data = priv;
    ++	struct find_by_namelen_data *cb_data = priv;
     +
    -+	if (!strncmp(driver->name, cb_data->k, cb_data->len) &&
    ++	if (!strncmp(driver->name, cb_data->name, cb_data->len) &&
     +	    !driver->name[cb_data->len]) {
     +		cb_data->driver = driver;
    -+		return -1; /* found it! */
    ++		return 1; /* tell the caller to stop iterating */
      	}
     -	return NULL;
     +	return 0;
     +}
     +
    -+static struct userdiff_driver *userdiff_find_by_namelen(const char *k, size_t len)
    ++static struct userdiff_driver *userdiff_find_by_namelen(const char *name, size_t len)
     +{
    -+	struct for_each_userdiff_driver_cb udcbdata = { .k = k, .len = len, .driver = NULL };
    -+
    -+	for_each_userdiff_driver(userdiff_find_by_namelen_cb,
    -+				 USERDIFF_DRIVER_TYPE_UNSPECIFIED, &udcbdata);
    ++	struct find_by_namelen_data udcbdata = {
    ++		.name = name,
    ++		.len = len,
    ++	};
    ++	for_each_userdiff_driver(userdiff_find_by_namelen_cb, &udcbdata);
     +	return udcbdata.driver;
      }
      
    @@ userdiff.c: struct userdiff_driver *userdiff_get_textconv(struct repository *r,
      	return driver;
      }
     +
    -+int for_each_userdiff_driver(each_userdiff_driver_fn fn,
    -+			     enum userdiff_driver_type type, void *cb_data)
    ++static int for_each_userdiff_driver_list(each_userdiff_driver_fn fn,
    ++					 enum userdiff_driver_type type, void *cb_data,
    ++					 struct userdiff_driver *drv,
    ++					 int drv_size)
     +{
    -+	int i, ret;
    -+	if (type & (USERDIFF_DRIVER_TYPE_UNSPECIFIED | USERDIFF_DRIVER_TYPE_CUSTOM)) {
    -+
    -+		for (i = 0; i < ndrivers; i++) {
    -+			struct userdiff_driver *drv = drivers + i;
    -+			ret = fn(drv, USERDIFF_DRIVER_TYPE_CUSTOM, cb_data);
    -+			if (ret)
    -+				return ret;
    -+		}
    ++	int i;
    ++	int ret;
    ++	for (i = 0; i < drv_size; i++) {
    ++		struct userdiff_driver *item = drv + i;
    ++		if ((ret = fn(item, type, cb_data)))
    ++			return ret;
     +	}
    -+	if (type & (USERDIFF_DRIVER_TYPE_UNSPECIFIED | USERDIFF_DRIVER_TYPE_BUILTIN)) {
    ++	return 0;
    ++}
    ++
    ++int for_each_userdiff_driver(each_userdiff_driver_fn fn, void *cb_data)
    ++{
    ++	int ret;
    ++
    ++	ret = for_each_userdiff_driver_list(fn, USERDIFF_DRIVER_TYPE_CUSTOM,
    ++					    cb_data, drivers, ndrivers);
    ++	if (ret)
    ++		return ret;
    ++
    ++	ret = for_each_userdiff_driver_list(fn, USERDIFF_DRIVER_TYPE_BUILTIN,
    ++					    cb_data, builtin_drivers,
    ++					    ARRAY_SIZE(builtin_drivers));
    ++	if (ret)
    ++		return ret;
     +
    -+		for (i = 0; i < ARRAY_SIZE(builtin_drivers); i++) {
    -+			struct userdiff_driver *drv = builtin_drivers + i;
    -+			ret = fn(drv, USERDIFF_DRIVER_TYPE_BUILTIN, cb_data);
    -+			if (ret)
    -+				return ret;
    -+		}
    -+	}
     +	return 0;
     +}
     
    @@ userdiff.h: struct userdiff_driver {
      	int textconv_want_cache;
      };
     +enum userdiff_driver_type {
    -+	USERDIFF_DRIVER_TYPE_UNSPECIFIED = 1<<0,
    -+	USERDIFF_DRIVER_TYPE_BUILTIN = 1<<1,
    -+	USERDIFF_DRIVER_TYPE_CUSTOM = 1<<2,
    ++	USERDIFF_DRIVER_TYPE_BUILTIN = 1<<0,
    ++	USERDIFF_DRIVER_TYPE_CUSTOM = 1<<1,
     +};
     +typedef int (*each_userdiff_driver_fn)(struct userdiff_driver *,
     +				       enum userdiff_driver_type, void *);
    @@ userdiff.h: struct userdiff_driver *userdiff_find_by_path(struct index_state *is
      					      struct userdiff_driver *driver);
      
     +/*
    -+ * Iterate over each driver of type userdiff_driver_type, or
    -+ * USERDIFF_DRIVER_TYPE_UNSPECIFIED for all of them. Return non-zero
    -+ * to exit from the loop.
    ++ * Iterate over all userdiff drivers. The userdiff_driver_type
    ++ * argument to each_userdiff_driver_fn indicates their type. Return
    ++ * non-zero to exit early from the loop.
     + */
    -+int for_each_userdiff_driver(each_userdiff_driver_fn,
    -+			     enum userdiff_driver_type, void *);
    ++int for_each_userdiff_driver(each_userdiff_driver_fn, void *);
     +
      #endif /* USERDIFF */
 6:  862f6ab5d6 =  5:  3eb7abd121 userdiff tests: explicitly test "default" pattern
 7:  22a07591b7 !  6:  e90758a978 userdiff tests: list builtin drivers via test-tool
    @@ t/helper/test-userdiff.c (new)
     +#include "test-tool.h"
     +#include "cache.h"
     +#include "userdiff.h"
    ++#include "config.h"
     +
     +static int driver_cb(struct userdiff_driver *driver,
     +		     enum userdiff_driver_type type, void *priv)
     +{
    -+	if (driver->funcname.pattern)
    ++	enum userdiff_driver_type *want_type = priv;
    ++	if (type & *want_type && driver->funcname.pattern)
     +		puts(driver->name);
     +	return 0;
     +}
     +
    -+static int list_what(enum userdiff_driver_type type)
    ++static int cmd__userdiff_config(const char *var, const char *value, void *cb)
     +{
    -+	return for_each_userdiff_driver(driver_cb, type, NULL);
    ++	if (userdiff_config(var, value) < 0)
    ++		return -1;
    ++	return 0;
     +}
     +
     +int cmd__userdiff(int argc, const char **argv)
     +{
    ++	enum userdiff_driver_type want = 0;
     +	if (argc != 2)
     +		return 1;
     +
     +	if (!strcmp(argv[1], "list-drivers"))
    -+		return list_what(USERDIFF_DRIVER_TYPE_UNSPECIFIED);
    ++		want = (USERDIFF_DRIVER_TYPE_BUILTIN |
    ++			USERDIFF_DRIVER_TYPE_CUSTOM);
     +	else if (!strcmp(argv[1], "list-builtin-drivers"))
    -+		return list_what(USERDIFF_DRIVER_TYPE_BUILTIN);
    ++		want = USERDIFF_DRIVER_TYPE_BUILTIN;
     +	else if (!strcmp(argv[1], "list-custom-drivers"))
    -+		return list_what(USERDIFF_DRIVER_TYPE_CUSTOM);
    ++		want = USERDIFF_DRIVER_TYPE_CUSTOM;
     +	else
     +		return error("unknown argument %s", argv[1]);
    ++
    ++	if (want & USERDIFF_DRIVER_TYPE_CUSTOM) {
    ++		setup_git_directory();
    ++		git_config(cmd__userdiff_config, NULL);
    ++	}
    ++
    ++	for_each_userdiff_driver(driver_cb, &want);
    ++
    ++	return 0;
     +}
     
      ## t/t4018-diff-funcname.sh ##
    -@@ t/t4018-diff-funcname.sh: test_description='Test custom diff function name patterns'
    - . ./test-lib.sh
    +@@ t/t4018-diff-funcname.sh: test_expect_success 'setup' '
    + 	echo B >B.java
    + '
      
    - test_expect_success 'setup' '
    ++test_expect_success 'setup: test-tool userdiff' '
     +	# Make sure additions to builtin_drivers are sorted
     +	test_when_finished "rm builtin-drivers.sorted" &&
     +	test-tool userdiff list-builtin-drivers >builtin-drivers &&
    @@ t/t4018-diff-funcname.sh: test_description='Test custom diff function name patte
     +	sort <builtin-drivers >builtin-drivers.sorted &&
     +	test_cmp builtin-drivers.sorted builtin-drivers &&
     +
    - 	# a non-trivial custom pattern
    - 	git config diff.custom1.funcname "!static
    - !String
    -@@ t/t4018-diff-funcname.sh: test_expect_success 'setup' '
    - '
    - 
    ++	# Ditto, but "custom" requires the .git directory and config
    ++	# to be setup and read.
    ++	test_when_finished "rm custom-drivers.sorted" &&
    ++	test-tool userdiff list-custom-drivers >custom-drivers &&
    ++	test_file_not_empty custom-drivers &&
    ++	sort <custom-drivers >custom-drivers.sorted &&
    ++	test_cmp custom-drivers.sorted custom-drivers
    ++'
    ++
      diffpatterns="
     -	ada
     -	bash
    @@ t/t4018-diff-funcname.sh: test_expect_success 'setup' '
     -	rust
     -	tex
     -	default
    +-	custom1
    +-	custom2
    +-	custom3
     +	$(cat builtin-drivers)
    - 	custom1
    - 	custom2
    - 	custom3
    ++	$(cat custom-drivers)
    + "
    + 
    + for p in $diffpatterns
 8:  7755db9501 =  7:  04bce275ab userdiff: remove support for "broken" tests
 9:  4e0b4b42e1 =  8:  3583078715 blame tests: don't rely on t/t4018/ directory
10:  ce98c61bf4 =  9:  548673260b blame tests: simplify userdiff driver test
-- 
2.31.1.527.g9b8f7de2547

