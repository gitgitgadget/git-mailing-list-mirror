Return-Path: <SRS0=p769=6V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1736EC54E4B
	for <git@archiver.kernel.org>; Thu,  7 May 2020 13:18:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E54F4208D6
	for <git@archiver.kernel.org>; Thu,  7 May 2020 13:17:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JY5mcsdc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726930AbgEGNR5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 May 2020 09:17:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726904AbgEGNRx (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 7 May 2020 09:17:53 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07000C05BD43
        for <git@vger.kernel.org>; Thu,  7 May 2020 06:17:52 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id h9so6373721wrt.0
        for <git@vger.kernel.org>; Thu, 07 May 2020 06:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=SAG3CfsdYn6lQEMHACFgXhSN7DUoYtsea9kTn51wM78=;
        b=JY5mcsdcDyKYRXgkS6qQeZ8HDczPeqKTmUqj2bPwp8jMXrAcYi1/hoxslPKL6y3Jbb
         1L+KjmEN/x+tqA86Pv4uiPkTF/KOz37HKIeAowJF2wh+OLQUMhr3UQSqoFiGvSDG44Yi
         HLZ/ZNrZHIa68KVgLeqaXwEhkpyzOS87p/4K+aylQsiXPL6tegClfIhFU1yLVIJEDM83
         5gXxHQhDo/C5wYrHhDeGUMSxhnVh6N9JTalHd3aMiA6PCiY/fV3ZpSGyu/sQazUWYth9
         9ar7WXlU36op5oLYlC9TizeiH3P6vFEPz/I+1uwxDgqWfp7G8ZXW2L+qwu2ZLgW9K0q5
         PAkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=SAG3CfsdYn6lQEMHACFgXhSN7DUoYtsea9kTn51wM78=;
        b=cClqfmuoEuDvqKEr3DhJWKcggl8CW5r1JBC8TVDcSkOpXllh5CKTuXv37VmeGEnNZF
         7w4JL1Pz+Z+9ry5XDXui+j3K6/pKhxcJe0oUhGwxIqmoNZL2a7uF1BFeQlD3HvVCiD0v
         YEAmGhWzpClfyLTNjOOuyOX5qqgQ/NkAXf9O20QQCbhjw3VcaGUnHHb0XfCGvPOGEa2A
         1hcZfPPJGrb3M+oh1MsH1ZRmZVKosmg1oFpfzoP1NFO1thhBYBC9I5XlgJd0B6Z0KQih
         200wSu8CCE8ILugclkhRde1JO19ejuKaYd2LQtfEbgLoh3BLVzfxoIztQoQFy8g+UwfW
         QoaQ==
X-Gm-Message-State: AGi0PuY2nkhA7u17sRAjRXjH4BVrITmSRBozdBREAY3I8iH6pNuD2t6C
        987/Dtyj0MoI3YJQEXKPa9/ohhLD
X-Google-Smtp-Source: APiQypJ/kxRjUnMpsoRiULQzAk3SK6FBr2eZgu0Pgp6pPfo/khxv3kXnl5NVw5l3qEdIh59rpBzklw==
X-Received: by 2002:a5d:54c4:: with SMTP id x4mr16694332wrv.73.1588857470620;
        Thu, 07 May 2020 06:17:50 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b82sm8447462wmh.1.2020.05.07.06.17.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2020 06:17:50 -0700 (PDT)
Message-Id: <5392cb7a1065fae766b6ef3c6f59728263ec6342.1588857462.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.627.git.1588857462.gitgitgadget@gmail.com>
References: <pull.627.git.1588857462.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 07 May 2020 13:17:41 +0000
Subject: [PATCH 09/10] Makefile: disable GETTEXT when 'po' is missing
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     newren@gmaill.com, peff@peff.net, me@ttaylorr.com,
        jrnieder@gmail.com, Derrick Stolee <dstolee@microsoft.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

As an effort to promote "dogfooding" the sparse-checkout feature within
the Git codebase, it is helpful to explore which portions of the
codebase are optional.

The NO_GETTEXT build variable can disable the translation libraries.
The test suite then uses the NO_GETTEXT environment variable to disable
the GETTEXT prerequisite for some tests.

The 'po' directory contains translations for strings in the Git
codebase. While this stores extremely important data for Git users, the
data is not typically used by Git contributors in their daily work.
Thus, it could be removed from the working directory using
sparse-checkout.

However, doing such a removal causes some tests to fail. Part of the
failures are related to the GETTEXT prerequisite being enabled when it
probably should not be. The other part is that some tests in
t0200-gettext-basic.sh depend on the existence of files in the po
directory.

In test-lib, disable the GETTEXT prerequisite when the po directory does
not exist, then add the GETTEXT prerequisite to these tests that use
files in that directory.

In Makefile, define NO_GETTEXT when the po directory does not exist.
This is necessary for "make install" to work correctly.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Makefile                 | 9 ++++++++-
 t/lib-gettext.sh         | 1 -
 t/t0200-gettext-basic.sh | 6 +++---
 t/test-lib.sh            | 7 ++++++-
 4 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/Makefile b/Makefile
index 70760d315cb..38c2d54349a 100644
--- a/Makefile
+++ b/Makefile
@@ -72,7 +72,8 @@ all::
 #
 # Define NO_GETTEXT if you don't want Git output to be translated.
 # A translated Git requires GNU libintl or another gettext implementation,
-# plus libintl-perl at runtime.
+# plus libintl-perl at runtime. This will also be defined if the 'po'
+# directory is missing.
 #
 # Define USE_GETTEXT_SCHEME and set it to 'fallthrough', if you don't trust
 # the installed gettext translation of the shell scripts output.
@@ -1861,6 +1862,12 @@ ifeq ($(TCLTK_PATH),)
 NO_TCLTK = NoThanks
 endif
 
+ifndef NO_GETTEXT
+	ifeq ($(ls po),)
+		NO_GETTEXT = NoThanks
+	endif
+endif
+
 ifndef NO_TCLTK
 	ifeq ($(ls git-gui),)
 		NO_TCLTK = NoThanks
diff --git a/t/lib-gettext.sh b/t/lib-gettext.sh
index 2139b427ca1..beeb45a1387 100644
--- a/t/lib-gettext.sh
+++ b/t/lib-gettext.sh
@@ -7,7 +7,6 @@
 . ./test-lib.sh
 
 GIT_TEXTDOMAINDIR="$GIT_BUILD_DIR/po/build/locale"
-GIT_PO_PATH="$GIT_BUILD_DIR/po"
 export GIT_TEXTDOMAINDIR GIT_PO_PATH
 
 if test -n "$GIT_TEST_INSTALLED"
diff --git a/t/t0200-gettext-basic.sh b/t/t0200-gettext-basic.sh
index 8853d8afb92..0f6bc941cbb 100755
--- a/t/t0200-gettext-basic.sh
+++ b/t/t0200-gettext-basic.sh
@@ -15,17 +15,17 @@ test_expect_success 'sanity: $TEXTDOMAIN is git' '
     test $TEXTDOMAIN = "git"
 '
 
-test_expect_success 'xgettext sanity: Perl _() strings are not extracted' '
+test_expect_success GETTEXT 'xgettext sanity: Perl _() strings are not extracted' '
     ! grep "A Perl string xgettext will not get" "$GIT_PO_PATH"/is.po
 '
 
-test_expect_success 'xgettext sanity: Comment extraction with --add-comments' '
+test_expect_success GETTEXT 'xgettext sanity: Comment extraction with --add-comments' '
     grep "TRANSLATORS: This is a test" "$TEST_DIRECTORY"/t0200/* | wc -l >expect &&
     grep "TRANSLATORS: This is a test" "$GIT_PO_PATH"/is.po  | wc -l >actual &&
     test_cmp expect actual
 '
 
-test_expect_success 'xgettext sanity: Comment extraction with --add-comments stops at statements' '
+test_expect_success  GETTEXT 'xgettext sanity: Comment extraction with --add-comments stops at statements' '
     ! grep "This is a phony" "$GIT_PO_PATH"/is.po &&
     ! grep "the above comment" "$GIT_PO_PATH"/is.po
 '
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 0ea1e5a05ed..ca22d23f0d2 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1474,7 +1474,12 @@ test -z "$NO_PYTHON" && test_set_prereq PYTHON
 test -n "$USE_LIBPCRE1$USE_LIBPCRE2" && test_set_prereq PCRE
 test -n "$USE_LIBPCRE1" && test_set_prereq LIBPCRE1
 test -n "$USE_LIBPCRE2" && test_set_prereq LIBPCRE2
-test -z "$NO_GETTEXT" && test_set_prereq GETTEXT
+
+GIT_PO_PATH="$GIT_BUILD_DIR/po"
+if test -d "$GIT_PO_PATH"
+then
+	test -z "$NO_GETTEXT" && test_set_prereq GETTEXT
+fi
 
 if test -n "$GIT_TEST_GETTEXT_POISON_ORIG"
 then
-- 
gitgitgadget

