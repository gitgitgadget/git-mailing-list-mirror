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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23781C432BE
	for <git@archiver.kernel.org>; Wed,  1 Sep 2021 11:25:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A70960F21
	for <git@archiver.kernel.org>; Wed,  1 Sep 2021 11:25:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243219AbhIAL0x (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Sep 2021 07:26:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238659AbhIAL0w (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Sep 2021 07:26:52 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A2E9C061575
        for <git@vger.kernel.org>; Wed,  1 Sep 2021 04:25:56 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id u16so3959145wrn.5
        for <git@vger.kernel.org>; Wed, 01 Sep 2021 04:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=K3R45HHuNQv3RN0b9l0XZdqEhEayKR5c5v5gcTeGcQw=;
        b=sK5NDZivPcPXoZ+UmpXtn0S060ThKrAU6ndKBOJDFkcB1NOgESFnHNuDxldNjuxPTn
         m9FcUgjOql10tFZeXHyJUkOcmjwxp5tvVijQ0gBXl98llSYxzk/8g4xNOGqp+gPmcRdj
         RGkmI/HjFdr/InGWNDNrOzY4vUHvE1WNEb01ZgrV5LkvOuZ2MxLzvpCSJWAHxi/D4SG4
         MAn04GrLo0oaMF4HChQJIBR0e6lUDDLxH7iOrnE72lRkxfAgg0BnrT8frF73jLjEwzL2
         p00uQbxiDMVRA8LMz7Iar8kNAgSspK9qI9xp7k9TWHCa1aWwBGmd10scANirDaf8+ulG
         60pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=K3R45HHuNQv3RN0b9l0XZdqEhEayKR5c5v5gcTeGcQw=;
        b=QobRTM5k4+2wwqxkUGpiu6vO2rQR+P2vseNfKV1vQVdGEMqQMdeStsAh8nSDZY6V4L
         5euUJcxzKqrgob8wio20MghV+DXZPzb80Jjck3vkWZwGqHgGmlQ9jf7SzobZ95+kFlKR
         oMRQUszqMmSj7aVwACiv4oU2wuDUnHZuMR9FL396/o46YsZOUbFes2YBx/jp2DRCU9fr
         xbGObc5ygCp0isyPxiM0wCC5ujUfhJzD5vDslLZOJlob5V57zccOA2JOsgdHDHqZ4Dju
         0kKV1ofxHAX70t/Dm8v2gIvb3UBBSFss7dLaP1YH78YbiLwFQhJxkGAu//zziifLnfng
         mqCA==
X-Gm-Message-State: AOAM531W/coX65v0tNn7VRtIkmL9ONkzyDV/u9okw0QzRqw7cSg0pHVt
        RJqyeiOnngZrx0MWSA/z1QZyXo2GSHDgOQ==
X-Google-Smtp-Source: ABdhPJzILzyQO6wo2g7RmTCZpk9qQ0YozCn2j9UCgKtBxzSlL1PEM3zWUFqgiWn2ED1xzXQjRUynpQ==
X-Received: by 2002:adf:80eb:: with SMTP id 98mr30090123wrl.348.1630495554552;
        Wed, 01 Sep 2021 04:25:54 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id f23sm5028743wmc.3.2021.09.01.04.25.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Sep 2021 04:25:54 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Carlo Arenas <carenas@gmail.com>, phillip.wood@dunelm.org.uk,
        mackyle@gmail.com, sunshine@sunshineco.com,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH] gettext: remove optional non-standard parens in N_() definition
Date:   Wed,  1 Sep 2021 13:25:52 +0200
Message-Id: <patch-1.1-d24f1df5d49-20210901T112248Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.807.gf14ecf9c2e9
In-Reply-To: <YS9RieTeJSFmd6M7@coredump.intra.peff.net>
References: <YS9RieTeJSFmd6M7@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove the USE_PARENS_AROUND_GETTEXT_N compile-time option which was
meant to catch an inadvertent mistakes which is too obscure to
maintain this facility.

The backstory of how USE_PARENS_AROUND_GETTEXT_N came about is: When I
added the N_() macro in 65784830366 (i18n: add no-op _() and N_()
wrappers, 2011-02-22) it was defined as:

    #define N_(msgid) (msgid)

This is non-standard C, as was noticed and fixed in 642f85faab2 (i18n:
avoid parenthesized string as array initializer,
2011-04-07). I.e. this needed to be defined as:

    #define N_(msgid) msgid

Then in e62cd35a3e8 (i18n: log: mark parseopt strings for translation,
2012-08-20) when "builtin_log_usage" was marked for translation the
string concatenation the string concatenation for passing to usage()
added in 1c370ea4e51 (Show usage string for 'git log -h', 'git show
-h' and 'git diff -h', 2009-08-06) was faithfully preserved:

-       "git log [<options>] [<since>..<until>] [[--] <path>...]\n"
-       "   or: git show [options] <object>...",
+       N_("git log [<options>] [<since>..<until>] [[--] <path>...]\n")
+       N_("   or: git show [options] <object>..."),

This was then fixed to be the expected array of usage strings in
e66dc0cc4b1 (log.c: fix translation markings, 2015-01-06) rather than
a string with multiple "\n"-delimited usage strings, and finally in
290c8e7a3fe (gettext.h: add parentheses around N_ expansion if
supported, 2015-01-11) USE_PARENS_AROUND_GETTEXT_N was added to ensure
this mistake didn't happen again.

I think that even if this was a N_()-specific issue this
USE_PARENS_AROUND_GETTEXT_N facility wouldn't be worth it, the issue
would be too rare to worry about.

But I also think that 290c8e7a3fe which introduced
USE_PARENS_AROUND_GETTEXT_N misattributed the problem. The issue
wasn't with the N_() macro added in e62cd35a3e8, but that before the
N_() macro existed in the codebase the initial migration to
parse_options() in 1c370ea4e51 continued passsing in a "\n"-delimited
string, when the new API it was migrating to supported and expected
the passing of an array.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---

On Wed, Sep 01 2021, Jeff King wrote:

> On Wed, Sep 01, 2021 at 02:19:37AM -0700, Carlo Marcelo Arenas Belón wrote:
>
>> first patch was suggested[1] by Peff, so hopefully my commit message
>> and his assumed SoB are still worth not mixing it with patch 2 (which
>> has a slight different but related focus and touches the same files)
>> but since it is no longer a single patch, lets go wild.
>
> My SoB is fine there (though really Ævar did the actual thinking; I just
> deleted a lot of lines in vim :) ).
>
> Patch 2 looks good to me, though I kind of wonder if it is even worth
> having an option to turn it off.
>
>> patches 3 and 4 are optional and mostly for RFC, so that a solution
>> to any possible issue that the retiring of USE_PARENS_AROUND_GETTEXT_N
>> are addressed.
>
> IMHO the issue it is trying to find is not worth the inevitable problems
> that hacky perl parsing of C will cause (both false positives and
> negatives). Not a statement on your perl code, but just based on
> previous experience.
>
> So I'd probably take the first two patches, and leave the others.

I came up with this after reading your
<YS7c3169x5Wk4PlA@coredump.intra.peff.net> (the patch content is the
same) but before seeing that Carlo had beaten me to it here in
<20210901091941.34886-1-carenas@gmail.com> upthread.

I don't care how this lands exactly, but thin (eye of the beholder and
all that) that the commit message above is better. Carlo: Feel free to
steal it partially or entirely, I also made this a "PATCH" instead of
"RFC PATCH" in case Junio feels like queuing this, then you could
build your DEVOPTS=pedantic by default here on top.

 Makefile          | 20 +-------------------
 config.mak.dev    |  2 --
 gettext.h         | 24 ------------------------
 git-compat-util.h |  4 ----
 4 files changed, 1 insertion(+), 49 deletions(-)

diff --git a/Makefile b/Makefile
index d1feab008fc..4936e234bc1 100644
--- a/Makefile
+++ b/Makefile
@@ -409,15 +409,6 @@ all::
 # Define NEEDS_LIBRT if your platform requires linking with librt (glibc version
 # before 2.17) for clock_gettime and CLOCK_MONOTONIC.
 #
-# Define USE_PARENS_AROUND_GETTEXT_N to "yes" if your compiler happily
-# compiles the following initialization:
-#
-#   static const char s[] = ("FOO");
-#
-# and define it to "no" if you need to remove the parentheses () around the
-# constant.  The default is "auto", which means to use parentheses if your
-# compiler is detected to support it.
-#
 # Define HAVE_BSD_SYSCTL if your platform has a BSD-compatible sysctl function.
 #
 # Define HAVE_GETDELIM if your system has the getdelim() function.
@@ -497,8 +488,7 @@ all::
 #
 #    pedantic:
 #
-#        Enable -pedantic compilation. This also disables
-#        USE_PARENS_AROUND_GETTEXT_N to produce only relevant warnings.
+#        Enable -pedantic compilation.
 
 GIT-VERSION-FILE: FORCE
 	@$(SHELL_PATH) ./GIT-VERSION-GEN
@@ -1347,14 +1337,6 @@ ifneq (,$(SOCKLEN_T))
 	BASIC_CFLAGS += -Dsocklen_t=$(SOCKLEN_T)
 endif
 
-ifeq (yes,$(USE_PARENS_AROUND_GETTEXT_N))
-	BASIC_CFLAGS += -DUSE_PARENS_AROUND_GETTEXT_N=1
-else
-ifeq (no,$(USE_PARENS_AROUND_GETTEXT_N))
-	BASIC_CFLAGS += -DUSE_PARENS_AROUND_GETTEXT_N=0
-endif
-endif
-
 ifeq ($(uname_S),Darwin)
 	ifndef NO_FINK
 		ifeq ($(shell test -d /sw/lib && echo y),y)
diff --git a/config.mak.dev b/config.mak.dev
index 022fb582180..41d6345bc0a 100644
--- a/config.mak.dev
+++ b/config.mak.dev
@@ -4,8 +4,6 @@ SPARSE_FLAGS += -Wsparse-error
 endif
 ifneq ($(filter pedantic,$(DEVOPTS)),)
 DEVELOPER_CFLAGS += -pedantic
-# don't warn for each N_ use
-DEVELOPER_CFLAGS += -DUSE_PARENS_AROUND_GETTEXT_N=0
 endif
 DEVELOPER_CFLAGS += -Wall
 DEVELOPER_CFLAGS += -Wdeclaration-after-statement
diff --git a/gettext.h b/gettext.h
index c8b34fd6122..d209911ebb8 100644
--- a/gettext.h
+++ b/gettext.h
@@ -55,31 +55,7 @@ const char *Q_(const char *msgid, const char *plu, unsigned long n)
 }
 
 /* Mark msgid for translation but do not translate it. */
-#if !USE_PARENS_AROUND_GETTEXT_N
 #define N_(msgid) msgid
-#else
-/*
- * Strictly speaking, this will lead to invalid C when
- * used this way:
- *	static const char s[] = N_("FOO");
- * which will expand to
- *	static const char s[] = ("FOO");
- * and in valid C, the initializer on the right hand side must
- * be without the parentheses.  But many compilers do accept it
- * as a language extension and it will allow us to catch mistakes
- * like:
- *	static const char *msgs[] = {
- *		N_("one")
- *		N_("two"),
- *		N_("three"),
- *		NULL
- *	};
- * (notice the missing comma on one of the lines) by forcing
- * a compilation error, because parenthesised ("one") ("two")
- * will not get silently turned into ("onetwo").
- */
-#define N_(msgid) (msgid)
-#endif
 
 const char *get_preferred_languages(void);
 int is_utf8_locale(void);
diff --git a/git-compat-util.h b/git-compat-util.h
index b46605300ab..ddc65ff61d9 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -1253,10 +1253,6 @@ int warn_on_fopen_errors(const char *path);
  */
 int open_nofollow(const char *path, int flags);
 
-#if !defined(USE_PARENS_AROUND_GETTEXT_N) && defined(__GNUC__)
-#define USE_PARENS_AROUND_GETTEXT_N 1
-#endif
-
 #ifndef SHELL_PATH
 # define SHELL_PATH "/bin/sh"
 #endif
-- 
2.33.0.807.gf14ecf9c2e9

