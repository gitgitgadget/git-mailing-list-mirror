Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EC3781F8CF
	for <e@80x24.org>; Fri,  9 Jun 2017 22:04:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751725AbdFIWEs (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Jun 2017 18:04:48 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:35559 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751713AbdFIWEp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Jun 2017 18:04:45 -0400
Received: by mail-qt0-f195.google.com with SMTP id x58so17989794qtc.2
        for <git@vger.kernel.org>; Fri, 09 Jun 2017 15:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=jGfrCOuR2oFS/+TlRbBheMO7yihZHBWM1bQnjzKvlFk=;
        b=N+OSnTgdsZHb1tvFzzzz/flwrFDiPTARUHkxIgXFmdsdYhJIgnOXmKCjNyJjPSAsZk
         vmwp7+/UfofOMj+FrAl+2OEOpMxCcpTADe3TdhSR6UKSAe0fsrUV9OQDFw+NvOwVJM4d
         WCHAO6FcgCyh2hlxKc9MH7mNKtWNSXQF3hDGTTlpcGLxf86rvZopOXoqVJ9YEyiP39Zg
         4fpGuGQGcTDP0BUgY1qa5CDWpCvG9X45+xcJdjrVIRqKBexzzlKd97mrOgRNs4AtSBqq
         U/dsdDLU6sRWKhgmV7n5U8CDyeQXe9lqSb+FS128lgLKb5KUIqwahPVtis8RmQaWahrj
         Pbdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=jGfrCOuR2oFS/+TlRbBheMO7yihZHBWM1bQnjzKvlFk=;
        b=nO1iaPqupdUGFMxqPI6qKrp8xbt/GGh1pj3LVvFCWtwyAexFJKZr9RZ70xWfTqSamB
         UZ1MUvqOpZfsWEOy1XtlAB5zwRFbifE3kQHZ6HIvW3Ek1aAJSHcggd/IJxsXXUhD2mko
         eFxgWqy+fqBYx/tXjx+AITIgjjYZlplwM6FxU4qYTt1xztCzgE/Xj7zBlaFa19fvX1Gg
         Jr7+HL+U/PRnPq+UfAhrL3BmQvZhCEMYlbZNL73qQFlXaUTfhi0P5o4GkE/mzZlxcOBo
         tnqaG4EaNlsFuiRvUGo2epkw55nEGy8I8ScpaoT2oz8rr513kXcUEbPJ+Wec0SnaFVxc
         utAg==
X-Gm-Message-State: AODbwcCpER0P6mAGhWhfu8o0PJooHnyBhu7Q+NoD/hFWYdOz7tu4xtG6
        tL4HVE/Lv4/cikCu8f8=
X-Received: by 10.200.47.97 with SMTP id k30mr34225666qta.11.1497045879272;
        Fri, 09 Jun 2017 15:04:39 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id j65sm1523444qkf.38.2017.06.09.15.04.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Jun 2017 15:04:38 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Brandon Williams <bmwill@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 1/2] git-compat-util: add a FREEZ() wrapper around free(ptr); ptr = NULL
Date:   Fri,  9 Jun 2017 22:04:19 +0000
Message-Id: <20170609220420.4910-2-avarab@gmail.com>
X-Mailer: git-send-email 2.13.1.508.gb3defc5cc
In-Reply-To: <20170609220420.4910-1-avarab@gmail.com>
References: <20170609220420.4910-1-avarab@gmail.com>
In-Reply-To: <20170609085346.19974-1-avarab@gmail.com>
References: <20170609085346.19974-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a FREEZ() wrapper marco for the common pattern of freeing a
pointer and assigning NULL to it right afterwards.

The implementation is similar to the (currently unused) XDL_PTRFREE
macro in xdiff/xmacros.h added in commit 3443546f6e ("Use a *real*
built-in diff generator", 2006-03-24). The only difference is that
free() is called unconditionally, see [1].

1. <alpine.DEB.2.20.1608301948310.129229@virtualbox>
   (http://public-inbox.org/git/alpine.DEB.2.20.1608301948310.129229@virtualbox/)

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 git-compat-util.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/git-compat-util.h b/git-compat-util.h
index 4b7dcf21ad..ba2d0c8c80 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -805,6 +805,12 @@ extern int xmkstemp_mode(char *template, int mode);
 extern char *xgetcwd(void);
 extern FILE *fopen_for_writing(const char *path);
 
+/*
+ * FREEZ(ptr) is like free(ptr) followed by ptr = NULL. Note that ptr
+ * is used twice, so don't pass e.g. ptr++.
+ */
+#define FREEZ(p) do { free(p); (p) = NULL; } while (0)
+
 #define ALLOC_ARRAY(x, alloc) (x) = xmalloc(st_mult(sizeof(*(x)), (alloc)))
 #define REALLOC_ARRAY(x, alloc) (x) = xrealloc((x), st_mult(sizeof(*(x)), (alloc)))
 
-- 
2.13.1.508.gb3defc5cc

