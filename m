Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 62D031F405
	for <e@80x24.org>; Thu, 20 Dec 2018 16:25:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732985AbeLTQZU (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Dec 2018 11:25:20 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39236 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731218AbeLTQZU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Dec 2018 11:25:20 -0500
Received: by mail-wr1-f67.google.com with SMTP id t27so2386317wra.6
        for <git@vger.kernel.org>; Thu, 20 Dec 2018 08:25:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IOOnjInSQ8h/sMXWMzAYngEaadKBr3J51feInAOp6p0=;
        b=KH4RzryS209qI35WL9Q/6n9L46nW1GQDvCqVjYJ80h1LctwRl13L4sM8scbKamOgTd
         tcSZBgaMQCUCVYveysfuY0cgq+NLdx4VvhD92fEwsF3J/bVsudr+Xa1tJgXmKSpWtk3C
         xUvYAcqfu8pRJtae+sCqm6wXgXYj82ee50wdieO+Lf4J/JymKNBXiH/lfI6D4AyblzDs
         iBYt6yBhhyAgyTSu9dVdMueuHId/O//JWcc2wHX6vWKVWr2EhARYjlkgvp556HY9zbGY
         BZXkhY5I+5AfsT19NRoy/fH7jw5bq2oP81OWMJEe687twdrq0nEAlV5xVKZ2RuGyinp4
         qoPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IOOnjInSQ8h/sMXWMzAYngEaadKBr3J51feInAOp6p0=;
        b=IEOTzgYrcqkAUV4nUTZ0sai+9t9v/D5dEiLoeossg/LHJ3rl2+SPruGODelt/Nau/J
         Z7/7qmalv7t6/eDqmeCCq1Pi1u1ul7P62QSXWQRzlOkuvTgK0w6+JlqqTactEgF6BCqZ
         oHVyuI3RB4LALdSjKD3D7jkSV2awqaS0SXMPU47emcyPGHvefgmOZoQlouyf0WhQQ8cm
         JUgHLSLkrB00t5zU5h6dLE9+4DBv2sTHn3sIOE3eGmyh44oGyBcFo44qvoQOup+mk47V
         CGXFBUd7uf5LKqgUkCU3vsCSteAYQvECRJHSNrtEDFbSeQG1ahqOUuw9xc/4TgzMbOI/
         uywQ==
X-Gm-Message-State: AA+aEWbPBl5xGnFy6yNGqeoJLwqkLpguaDvWe6QdoSWZEnKF5lwKr+iA
        gkRV2m0o+duTCeNLxAcKSFY=
X-Google-Smtp-Source: AFSGD/XKO8RvGgsp8XGtB+Y5oMwKsPR24adcHFCOb7HbxALvE6SsmRpy7hSIm1i7V2b3njW1QlZxTA==
X-Received: by 2002:a5d:50c5:: with SMTP id f5mr22167234wrt.37.1545323117572;
        Thu, 20 Dec 2018 08:25:17 -0800 (PST)
Received: from localhost.localdomain (x4db1e5de.dyn.telefonica.de. [77.177.229.222])
        by smtp.gmail.com with ESMTPSA id 200sm8980566wmw.31.2018.12.20.08.25.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 20 Dec 2018 08:25:17 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 1/5] compat/obstack: fix -Wcast-function-type warnings
Date:   Thu, 20 Dec 2018 17:24:48 +0100
Message-Id: <20181220162452.17732-2-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.20.1.151.gec613c4b75
In-Reply-To: <20181220162452.17732-1-szeder.dev@gmail.com>
References: <20181220162452.17732-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When building Git with GCC 8.2.0 (at least from Homebrew on macOS,
DEVELOPER flags enabled) one is greeted with a screenful of compiler
errors:

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
how we use it) or two parameters.  Presumably to reduce memory
footprint, a single field is used to store the function pointer for
both signatures, and then it's casted to the appropriate signature
when the function pointer is accessed.  These casts between function
pointers with different number of parameters are what trigger those
compiler errors.

Modify 'struct obstack' to use unions to store function pointers with
different signatures, and then use the union member with the
appropriate signature when accessing these function pointers.  This
eliminates the need for those casts, and thus avoids this compiler
error.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 compat/obstack.c | 17 +++++++++--------
 compat/obstack.h | 18 +++++++++++-------
 2 files changed, 20 insertions(+), 15 deletions(-)

diff --git a/compat/obstack.c b/compat/obstack.c
index 4d1d95beeb..dd9504c684 100644
--- a/compat/obstack.c
+++ b/compat/obstack.c
@@ -112,15 +112,15 @@ compat_symbol (libc, _obstack_compat, _obstack, GLIBC_2_0);
 
 # define CALL_CHUNKFUN(h, size) \
   (((h) -> use_extra_arg) \
-   ? (*(h)->chunkfun) ((h)->extra_arg, (size)) \
-   : (*(struct _obstack_chunk *(*) (long)) (h)->chunkfun) ((size)))
+   ? (*(h)->chunkfun.fn_extra_arg) ((h)->extra_arg, (size)) \
+   : (*(h)->chunkfun.fn) ((size)))
 
 # define CALL_FREEFUN(h, old_chunk) \
   do { \
     if ((h) -> use_extra_arg) \
-      (*(h)->freefun) ((h)->extra_arg, (old_chunk)); \
+      (*(h)->freefun.fn_extra_arg) ((h)->extra_arg, (old_chunk)); \
     else \
-      (*(void (*) (void *)) (h)->freefun) ((old_chunk)); \
+      (*(h)->freefun.fn) ((old_chunk)); \
   } while (0)
 
 
@@ -159,8 +159,8 @@ _obstack_begin (struct obstack *h,
       size = 4096 - extra;
     }
 
-  h->chunkfun = (struct _obstack_chunk * (*)(void *, long)) chunkfun;
-  h->freefun = (void (*) (void *, struct _obstack_chunk *)) freefun;
+  h->chunkfun.fn = chunkfun;
+  h->freefun.fn = freefun;
   h->chunk_size = size;
   h->alignment_mask = alignment - 1;
   h->use_extra_arg = 0;
@@ -206,8 +206,9 @@ _obstack_begin_1 (struct obstack *h, int size, int alignment,
       size = 4096 - extra;
     }
 
-  h->chunkfun = (struct _obstack_chunk * (*)(void *,long)) chunkfun;
-  h->freefun = (void (*) (void *, struct _obstack_chunk *)) freefun;
+  h->chunkfun.fn_extra_arg = (struct _obstack_chunk * (*)(void *,long)) chunkfun;
+  h->freefun.fn_extra_arg = (void (*) (void *, struct _obstack_chunk *)) freefun;
+
   h->chunk_size = size;
   h->alignment_mask = alignment - 1;
   h->extra_arg = arg;
diff --git a/compat/obstack.h b/compat/obstack.h
index 6bc24b7644..0f9b2232a9 100644
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
+    struct _obstack_chunk *(*fn_extra_arg) (void *, long);
+    void *(*fn) (long);
+  } chunkfun;
+  union {
+    void (*fn_extra_arg) (void *, struct _obstack_chunk *);
+    void (*fn) (void *);
+  } freefun;
   void *extra_arg;		/* first arg for chunk alloc/dealloc funcs */
   unsigned use_extra_arg:1;	/* chunk alloc/dealloc funcs take extra arg */
   unsigned maybe_empty_object:1;/* There is a possibility that the current
@@ -235,10 +239,10 @@ extern void (*obstack_alloc_failed_handler) (void);
 		    (void (*) (void *, void *)) (freefun), (arg))
 
 #define obstack_chunkfun(h, newchunkfun) \
-  ((h) -> chunkfun = (struct _obstack_chunk *(*)(void *, long)) (newchunkfun))
+  ((h)->chunkfun.fn_extra_arg = (struct _obstack_chunk *(*)(void *, long)) (newchunkfun))
 
 #define obstack_freefun(h, newfreefun) \
-  ((h) -> freefun = (void (*)(void *, struct _obstack_chunk *)) (newfreefun))
+  ((h)->freefun.fn_extra_arg = (void (*)(void *, struct _obstack_chunk *)) (newfreefun))
 
 #define obstack_1grow_fast(h,achar) (*((h)->next_free)++ = (achar))
 
-- 
2.20.1.151.gec613c4b75

