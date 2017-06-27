Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 58FF420401
	for <e@80x24.org>; Tue, 27 Jun 2017 20:34:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753320AbdF0UeE (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Jun 2017 16:34:04 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33128 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753127AbdF0UeE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Jun 2017 16:34:04 -0400
Received: by mail-wm0-f67.google.com with SMTP id j85so7893016wmj.0
        for <git@vger.kernel.org>; Tue, 27 Jun 2017 13:34:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=7GrH3HennQMGTVFX876NEQAKWlB2zQTH//nP9s1bXCU=;
        b=oQPR1rzAP62rawzve3WgJi3uF+Q4KOvu4XgHg7xyFNgWUDpejGsNssRNYK6dskK7AV
         yXqFHV2WmVpAtfsZbjg31I3oDbs0aKmV+QUuBdScaxwGeLphx58IgPcSEFgF58+xFDxV
         iSdO3FlhdgMxarXrwoKA/DYTBhJeTF+Edz1OrSQiiA49OSJ7CdcqHde3nbycirSb55Kx
         eAoAq2cq1MGPvNz3JusewW9qznO7J8DU/Dd9K6hSPbKZRiehHuYr5qlJa7I9reUjA2e0
         0khESrY6CfrKpwuLGnK0hu/OUAXKmEGEqrrlwGBNWC1zdlAy5MaVTDyYLuD0ZVP99uBN
         1RPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=7GrH3HennQMGTVFX876NEQAKWlB2zQTH//nP9s1bXCU=;
        b=MsLvxCvjQW1uiUaMGbJ77wdjK9t9E0UNehBcoNOvrrjdbefx08hoFvZo+jD++L/k61
         NcoN7GrWGAk8SGzDVuWxUpzZQjEx2rrdxne8MLl9UwXVu3m3eZCj16yF5bATffXWZ5Wo
         J3ZmMBoQuJGZlPk7ByLsbrs3apz/hMDytrUGnTgHd04wwNqoyzjl4JbCjWwtDnW78G5c
         CV5AjV987vRcLKeSvPmz2BVX1ELFW44SYHBYGG6Lm1NDYSBbDbrQDin2HhME8uQlQgaF
         kOpcQqR1wK6Vae5GrNBxwq5r8ckb9qE5Fdylp5wlC4JpxT2BzEmBVioi9Iy5S5v3CP3K
         gpIA==
X-Gm-Message-State: AKS2vOxzG7lxabQyEw51EMKmkjRwwbZzk7AYuNzZVEFiO93yLzLVDa2p
        os11zFXv7V9PRAgcFnE=
X-Received: by 10.80.179.76 with SMTP id r12mr5389529edd.1.1498595642171;
        Tue, 27 Jun 2017 13:34:02 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id a18sm104862edd.23.2017.06.27.13.34.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Jun 2017 13:34:01 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Michael Kebe <michael.kebe@gmail.com>,
        "Liam R . Howlett" <Liam.Howlett@Oracle.com>,
        Adam Dinwoodie <adam@dinwoodie.org>,
        Stefan Beller <sbeller@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 1/3] sha1dc: correct endian detection for Solaris (and others?)
Date:   Tue, 27 Jun 2017 20:33:46 +0000
Message-Id: <20170627203348.19827-2-avarab@gmail.com>
X-Mailer: git-send-email 2.13.1.611.g7e3b11ae1
In-Reply-To: <20170627203348.19827-1-avarab@gmail.com>
References: <20170627203348.19827-1-avarab@gmail.com>
In-Reply-To: <20170627121718.12078-1-avarab@gmail.com>
References: <20170627121718.12078-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Update sha1dc from my PR #36[1] which'll hopefully be integrated by
upstream soon.

This solves the Big Endian detection on Solaris reported against
v2.13.2[2], hopefully without any regressions.

See commit a0103914c2 ("sha1dc: update from upstream", 2017-05-20) and
6b851e536b ("sha1dc: update from upstream", 2017-06-06) for previous
attempts in the 2.13 series to address various compile-time feature
detection in this library.

1. https://github.com/cr-marcstevens/sha1collisiondetection/pull/36
   https://github.com/avar/sha1collisiondetection/commit/56ab30c4c998e1e7f3075705087a2f0c4c4202d7
2. <CAKKM46tHq13XiW5C8sux3=PZ1VHSu_npG8ExfWwcPD7rkZkyRQ@mail.gmail.com>
   (https://public-inbox.org/git/CAKKM46tHq13XiW5C8sux3=PZ1VHSu_npG8ExfWwcPD7rkZkyRQ@mail.gmail.com/)

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 sha1dc/sha1.c | 73 +++++++++++++++++++++++++++++++++++++++++++----------------
 1 file changed, 54 insertions(+), 19 deletions(-)

diff --git a/sha1dc/sha1.c b/sha1dc/sha1.c
index facea1bb56..1e7e30763e 100644
--- a/sha1dc/sha1.c
+++ b/sha1dc/sha1.c
@@ -23,6 +23,13 @@
 #include "sha1.h"
 #include "ubc_check.h"
 
+#if (defined(__amd64__) || defined(__amd64) || defined(__x86_64__) || defined(__x86_64) || \
+     defined(i386) || defined(__i386) || defined(__i386__) || defined(__i486__)  || \
+     defined(__i586__) || defined(__i686__) || defined(_M_IX86) || defined(__X86__) || \
+     defined(_X86_) || defined(__THW_INTEL__) || defined(__I86__) || defined(__INTEL__) || \
+     defined(__386) || defined(_M_X64) || defined(_M_AMD64))
+#define SHA1DC_ON_INTEL_LIKE_PROCESSOR
+#endif
 
 /*
    Because Little-Endian architectures are most common,
@@ -32,28 +39,63 @@
    If you are compiling on a big endian platform and your compiler does not define one of these,
    you will have to add whatever macros your tool chain defines to indicate Big-Endianness.
  */
-#ifdef SHA1DC_BIGENDIAN
-#undef SHA1DC_BIGENDIAN
+
+#if defined(__BYTE_ORDER__) && defined(__ORDER_BIG_ENDIAN__)
+/*
+ * Should detect Big Endian under GCC since at least 4.6.0 (gcc svn
+ * rev #165881). See
+ * https://gcc.gnu.org/onlinedocs/cpp/Common-Predefined-Macros.html
+ *
+ * This also works under clang since 3.2, it copied the GCC-ism. See
+ * clang.git's 3b198a97d2 ("Preprocessor: add __BYTE_ORDER__
+ * predefined macro", 2012-07-27)
+ */
+#if __BYTE_ORDER__ == __ORDER_BIG_ENDIAN__
+#define SHA1DC_BIGENDIAN
 #endif
 
-#if (defined(_BYTE_ORDER) || defined(__BYTE_ORDER) || defined(__BYTE_ORDER__))
+#else /* Not under GCC-alike */
 
-#if ((defined(_BYTE_ORDER) && (_BYTE_ORDER == _BIG_ENDIAN)) || \
-     (defined(__BYTE_ORDER) && (__BYTE_ORDER == __BIG_ENDIAN)) || \
-     (defined(__BYTE_ORDER__) && (__BYTE_ORDER__ == __BIG_ENDIAN__)) )
+#if defined(__BYTE_ORDER) && defined(__BIG_ENDIAN)
+/*
+ * Should detect Big Endian under glibc.git since 14245eb70e ("entered
+ * into RCS", 1992-11-25). Defined in <endian.h> which will have been
+ * brought in by standard headers. See glibc.git and
+ * https://sourceforge.net/p/predef/wiki/Endianness/
+ */
+#if __BYTE_ORDER == __BIG_ENDIAN
 #define SHA1DC_BIGENDIAN
 #endif
 
-#else
+#else /* Not under GCC-alike or glibc */
 
-#if (defined(_BIG_ENDIAN) || defined(__BIG_ENDIAN) || defined(__BIG_ENDIAN__) || \
-     defined(__ARMEB__) || defined(__THUMBEB__) || defined(__AARCH64EB__) || \
+#if (defined(__ARMEB__) || defined(__THUMBEB__) || defined(__AARCH64EB__) || \
      defined(__MIPSEB__) || defined(__MIPSEB) || defined(_MIPSEB) || \
      defined(__sparc))
+/*
+ * Should define Big Endian for a whitelist of known processors. See
+ * https://sourceforge.net/p/predef/wiki/Endianness/ and
+ * http://www.oracle.com/technetwork/server-storage/solaris/portingtosolaris-138514.html
+ */
 #define SHA1DC_BIGENDIAN
-#endif
 
-#endif
+#else /* Not under GCC-alike or glibc or <processor whitelist> */
+
+#if defined(SHA1DC_ON_INTEL_LIKE_PROCESSOR)
+/*
+ * As a last resort before we do anything else we're not 100% sure
+ * about below, we blacklist specific processors here. We could add
+ * more, see e.g. https://wiki.debian.org/ArchitectureSpecificsMemo
+ */
+#else /* Not under GCC-alike or glibc or <processor whitelist>  or <processor blacklist> */
+
+/* We do nothing more here for now */
+/*#error "Uncomment this to see if you fall through all the detection"*/
+
+#endif /* !SHA1DC_ON_INTEL_LIKE_PROCESSOR */
+#endif /* Big Endian under whitelist of processors */
+#endif /* Big Endian under glibc */
+#endif /* Big Endian under GCC-alike */
 
 #if (defined(SHA1DC_FORCE_LITTLEENDIAN) && defined(SHA1DC_BIGENDIAN))
 #undef SHA1DC_BIGENDIAN
@@ -63,15 +105,8 @@
 #endif
 /*ENDIANNESS SELECTION*/
 
-#if (defined SHA1DC_FORCE_UNALIGNED_ACCESS || \
-     defined(__amd64__) || defined(__amd64) || defined(__x86_64__) || defined(__x86_64) || \
-     defined(i386) || defined(__i386) || defined(__i386__) || defined(__i486__)  || \
-     defined(__i586__) || defined(__i686__) || defined(_M_IX86) || defined(__X86__) || \
-     defined(_X86_) || defined(__THW_INTEL__) || defined(__I86__) || defined(__INTEL__) || \
-     defined(__386) || defined(_M_X64) || defined(_M_AMD64))
-
+#if defined(SHA1DC_FORCE_UNALIGNED_ACCESS) || defined(SHA1DC_ON_INTEL_LIKE_PROCESSOR)
 #define SHA1DC_ALLOW_UNALIGNED_ACCESS
-
 #endif /*UNALIGNMENT DETECTION*/
 
 
-- 
2.13.1.611.g7e3b11ae1

