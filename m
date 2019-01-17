Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 946E41F62E
	for <e@80x24.org>; Thu, 17 Jan 2019 01:29:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727781AbfAQB3g (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Jan 2019 20:29:36 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33006 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727769AbfAQB3f (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Jan 2019 20:29:35 -0500
Received: by mail-wr1-f67.google.com with SMTP id c14so9196007wrr.0
        for <git@vger.kernel.org>; Wed, 16 Jan 2019 17:29:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EaiOYU72uZSTowXDr/hjfGhGERRgKpNTraCkGbK2wnA=;
        b=KUeoay7kMzUL5gagT8cVp/DI7ldePJy1dIHi1/Uft5DxSN5pBqjo3hUMHF99wyQTro
         dJpxOyrjaTt2hjDrf5R2nCyQmwqil/SnsjIQyiWPJP9xLkPrjT4atU061jqgT2pKv06V
         mWynOCURmf4chKiD4k3N7seDZPdcqfFccySBj3VncrOC/e5wATy0MzaqP4DYG61nOMSQ
         NDk7GDkpcmDEyVyjzFdiCFxuMDTmd8lGTf/IcO7Un3iI3XlMkr4057KP/AVfbOTxEpf1
         ZUgxdfC3tRGX97Rd1qcU7UQutqcV3n3obL7rAYPBGbXKfSbiRBaH+xp3BT4POWpgN38B
         cV5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EaiOYU72uZSTowXDr/hjfGhGERRgKpNTraCkGbK2wnA=;
        b=h8+i2pFoLoaKTKC8ACCJ+rCOMr4M0kYKOe7wROu3MuPnQlYz3DGkL106XJJHcpoA17
         OO0Ny3P52oDUDIzin6e6zJ0I7S4Q8rVflm348XS5wL5biwBpN9tcVksvHYjtARBzWCxJ
         LKzf+j+LqGXQ1wzGECISMc9tr1spC702ezf7S8727eMe4yYkSZB0e3+YN8lXnPIOq6Db
         hQ+zFnf01dDWDS4ksIUVwndM20tPmwZkafq2U5x5nVDYGiNqpK74yY5EuyDmZR6ZZMTp
         xz3XHxY15eLUOclp9Dfm/cahJNl51lChHqF/RJ+rrsofbuCvMJyAN5Eau3BDee7KQ0wX
         +aIA==
X-Gm-Message-State: AJcUukeKgyKwjbC1y56It9C0v2w4ECDRqzcFRsi1rHiGznLW0ohiVMAb
        Lf74EXye1xKkGtIdJoho04k=
X-Google-Smtp-Source: ALg8bN73Aa0Ea2RJpHRAsRbtfOHCPvam3MK6+sO9889QBARfoLu0/O3xULgRu5hWVfOQv2wu8dExGQ==
X-Received: by 2002:adf:dfd1:: with SMTP id q17mr10246616wrn.27.1547688573404;
        Wed, 16 Jan 2019 17:29:33 -0800 (PST)
Received: from localhost.localdomain (x4db4a994.dyn.telefonica.de. [77.180.169.148])
        by smtp.gmail.com with ESMTPSA id y13sm36818272wme.2.2019.01.16.17.29.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 16 Jan 2019 17:29:32 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v2 1/5] compat/obstack: fix -Wcast-function-type warnings
Date:   Thu, 17 Jan 2019 02:29:09 +0100
Message-Id: <20190117012913.30562-2-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.20.1.499.gf60de1223c
In-Reply-To: <20190117012913.30562-1-szeder.dev@gmail.com>
References: <20181220162452.17732-1-szeder.dev@gmail.com>
 <20190117012913.30562-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

GCC 8 introduced the new -Wcast-function-type warning, which is
implied by -Wextra (which, in turn is enabled in our DEVELOPER flags).
When building Git with GCC 8 and this warning enabled on a non-glibc
platform [1], one is greeted with a screenful of compiler
warnings/errors:

  compat/obstack.c: In function '_obstack_begin':
  compat/obstack.c:162:17: error: cast between incompatible function types from 'void * (*)(long int)' to 'struct _obstack_chunk * (*)(void *, long int)' [-Werror=cast-function-type]
     h->chunkfun = (struct _obstack_chunk * (*)(void *, long)) chunkfun;
                   ^
  compat/obstack.c:163:16: error: cast between incompatible function types from 'void (*)(void *)' to 'void (*)(void *, struct _obstack_chunk *)' [-Werror=cast-function-type]
     h->freefun = (void (*) (void *, struct _obstack_chunk *)) freefun;
                  ^
  compat/obstack.c:116:8: error: cast between incompatible function types from 'struct _obstack_chunk * (*)(void *, long int)' to 'struct _obstack_chunk * (*)(long int)' [-Werror=cast-function-type]
      : (*(struct _obstack_chunk *(*) (long)) (h)->chunkfun) ((size)))
          ^
  compat/obstack.c:168:22: note: in expansion of macro 'CALL_CHUNKFUN'
     chunk = h->chunk = CALL_CHUNKFUN (h, h -> chunk_size);
                        ^~~~~~~~~~~~~
  <snip>

'struct obstack' stores pointers to two functions to allocate and free
"chunks", and depending on how obstack is used, these functions take
either one parameter (like standard malloc() and free() do; this is
how we use it in 'kwset.c') or two parameters.  Presumably to reduce
memory footprint, a single field is used to store the function pointer
for both signatures, and then it's casted to the appropriate signature
when the function pointer is accessed.  These casts between function
pointers with different number of parameters are what trigger those
compiler errors.

Modify 'struct obstack' to use unions to store function pointers with
different signatures, and then use the union member with the
appropriate signature when accessing these function pointers.  This
eliminates the need for those casts, and thus avoids this compiler
error.

[1] Compiling 'compat/obstack.c' on a platform with glibc is sort of
    a noop, see the comment before '#  define ELIDE_CODE', so this is
    not an issue on common Linux distros.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 compat/obstack.c | 17 +++++++++--------
 compat/obstack.h | 18 +++++++++++-------
 2 files changed, 20 insertions(+), 15 deletions(-)

diff --git a/compat/obstack.c b/compat/obstack.c
index 4d1d95beeb..27cd5c1ea1 100644
--- a/compat/obstack.c
+++ b/compat/obstack.c
@@ -112,15 +112,15 @@ compat_symbol (libc, _obstack_compat, _obstack, GLIBC_2_0);
 
 # define CALL_CHUNKFUN(h, size) \
   (((h) -> use_extra_arg) \
-   ? (*(h)->chunkfun) ((h)->extra_arg, (size)) \
-   : (*(struct _obstack_chunk *(*) (long)) (h)->chunkfun) ((size)))
+   ? (*(h)->chunkfun.extra) ((h)->extra_arg, (size)) \
+   : (*(h)->chunkfun.plain) ((size)))
 
 # define CALL_FREEFUN(h, old_chunk) \
   do { \
     if ((h) -> use_extra_arg) \
-      (*(h)->freefun) ((h)->extra_arg, (old_chunk)); \
+      (*(h)->freefun.extra) ((h)->extra_arg, (old_chunk)); \
     else \
-      (*(void (*) (void *)) (h)->freefun) ((old_chunk)); \
+      (*(h)->freefun.plain) ((old_chunk)); \
   } while (0)
 
 
@@ -159,8 +159,8 @@ _obstack_begin (struct obstack *h,
       size = 4096 - extra;
     }
 
-  h->chunkfun = (struct _obstack_chunk * (*)(void *, long)) chunkfun;
-  h->freefun = (void (*) (void *, struct _obstack_chunk *)) freefun;
+  h->chunkfun.plain = chunkfun;
+  h->freefun.plain = freefun;
   h->chunk_size = size;
   h->alignment_mask = alignment - 1;
   h->use_extra_arg = 0;
@@ -206,8 +206,9 @@ _obstack_begin_1 (struct obstack *h, int size, int alignment,
       size = 4096 - extra;
     }
 
-  h->chunkfun = (struct _obstack_chunk * (*)(void *,long)) chunkfun;
-  h->freefun = (void (*) (void *, struct _obstack_chunk *)) freefun;
+  h->chunkfun.extra = (struct _obstack_chunk * (*)(void *,long)) chunkfun;
+  h->freefun.extra = (void (*) (void *, struct _obstack_chunk *)) freefun;
+
   h->chunk_size = size;
   h->alignment_mask = alignment - 1;
   h->extra_arg = arg;
diff --git a/compat/obstack.h b/compat/obstack.h
index 6bc24b7644..ced94d0118 100644
--- a/compat/obstack.h
+++ b/compat/obstack.h
@@ -160,11 +160,15 @@ struct obstack		/* control current object in current chunk */
     void *tempptr;
   } temp;			/* Temporary for some macros.  */
   int   alignment_mask;		/* Mask of alignment for each object. */
-  /* These prototypes vary based on `use_extra_arg', and we use
-     casts to the prototypeless function type in all assignments,
-     but having prototypes here quiets -Wstrict-prototypes.  */
-  struct _obstack_chunk *(*chunkfun) (void *, long);
-  void (*freefun) (void *, struct _obstack_chunk *);
+  /* These prototypes vary based on `use_extra_arg'. */
+  union {
+    void *(*plain) (long);
+    struct _obstack_chunk *(*extra) (void *, long);
+  } chunkfun;
+  union {
+    void (*plain) (void *);
+    void (*extra) (void *, struct _obstack_chunk *);
+  } freefun;
   void *extra_arg;		/* first arg for chunk alloc/dealloc funcs */
   unsigned use_extra_arg:1;	/* chunk alloc/dealloc funcs take extra arg */
   unsigned maybe_empty_object:1;/* There is a possibility that the current
@@ -235,10 +239,10 @@ extern void (*obstack_alloc_failed_handler) (void);
 		    (void (*) (void *, void *)) (freefun), (arg))
 
 #define obstack_chunkfun(h, newchunkfun) \
-  ((h) -> chunkfun = (struct _obstack_chunk *(*)(void *, long)) (newchunkfun))
+  ((h)->chunkfun.extra = (struct _obstack_chunk *(*)(void *, long)) (newchunkfun))
 
 #define obstack_freefun(h, newfreefun) \
-  ((h) -> freefun = (void (*)(void *, struct _obstack_chunk *)) (newfreefun))
+  ((h)->freefun.extra = (void (*)(void *, struct _obstack_chunk *)) (newfreefun))
 
 #define obstack_1grow_fast(h,achar) (*((h)->next_free)++ = (achar))
 
-- 
2.20.1.499.gf60de1223c

