Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D283CCA47E
	for <git@archiver.kernel.org>; Fri,  3 Jun 2022 18:40:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347047AbiFCSkQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Jun 2022 14:40:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347200AbiFCSjG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Jun 2022 14:39:06 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AFA613F49
        for <git@vger.kernel.org>; Fri,  3 Jun 2022 11:38:13 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id f7-20020a1c3807000000b0039c1a10507fso4755897wma.1
        for <git@vger.kernel.org>; Fri, 03 Jun 2022 11:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Hkdc787LRpHpSDso7keEmdNGwBBbmtxF/p+XO/zhR1w=;
        b=i1zV5Du3c0+0a3Rg/dL4v8aqvDIsJusxPFhH3B5wGRd5jCuSH9IynduEYz4/sLYo0J
         gcH/hYvI6iHlvui6Dc6Z06zztLeulPRICodPnuH2X699MOw2T2nUJGsZJ9qB3SwuFJTr
         6nYzCPs56/SjY3V+Xpkb4DyaaYq9l1nKrESFQOxGgwdS3PiXi27CQDBhJJjiwyLQKyR0
         I0eKWnwzFvegm9HVXICikZ/IkrChhohaqyq8sskSyFMmxEZxp1C0pFGUYNm6yNRMFxqQ
         QksZT2Hjsd+FdsgCrLlR7vYGPuj07Pf0galRPmnnK/D/+PfaaP/omjZoUhWHpTNq41vo
         dYPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Hkdc787LRpHpSDso7keEmdNGwBBbmtxF/p+XO/zhR1w=;
        b=bPVMk6czXlCtEPtaDYjSVXjTZMKbDlLlAr6wEC6D9zKaGGGInjto8rv3s0hLFvsWzy
         ynNWATaz92LtIN4mhyNBrYfCT7qVw3RrX25CSxTxWDiGivGcB3JmHPZQgN1iRDuVncpI
         ihPTGyCR7eUNw86ATKq0KAgNR5ePdYz/m1w/0kP4fZEeX5uYm1T3JIDdFP/Nv5Oz9X40
         f5N/pgnLCxTiCvW55V/zV+5nYHns3tWSIFuZbfPcNC4g+Ny/4SI8pQJ5Ahdmf53RAjsN
         8FFitv4dCe5FsM5sDtplhF4FUjhhTflxI+mXVGG+s2ktVFNGuiMs/dE21FLLjXtG0HzM
         4mzA==
X-Gm-Message-State: AOAM532t0qiSEVYRtOdVcPU012kif/eZxS+LJbjdhtvBjGfgMB70rInu
        06l0iuLaQqw9DmOVOw6zGaMUcGUxI8dNXg==
X-Google-Smtp-Source: ABdhPJzqQIuQHMKwlWDxE16uTmI/b4AsAZ6cKrBgDvPicvWZQ9cIxUnQ4/B/gj6pWCxCWUPgYthkww==
X-Received: by 2002:a05:600c:a03:b0:395:bc75:61eb with SMTP id z3-20020a05600c0a0300b00395bc7561ebmr9952755wmp.46.1654281491921;
        Fri, 03 Jun 2022 11:38:11 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id y5-20020adff6c5000000b0020c5253d926sm8232636wrp.114.2022.06.03.11.38.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jun 2022 11:38:11 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Jinoh Kang <luke1337@theori.io>,
        Phillip Wood <phillip.wood@talktalk.net>,
        Glen Choo <chooglen@google.com>, Paul Tan <pyokagan@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Karthik Nayak <karthik.188@gmail.com>,
        Jeff Smith <whydoubt@gmail.com>, Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC PATCH 12/15] pack.h: wrap write_*file*() functions
Date:   Fri,  3 Jun 2022 20:37:49 +0200
Message-Id: <RFC-patch-12.15-9f0f515ed3a-20220603T183608Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.1.1124.g577fa9c2ebd
In-Reply-To: <RFC-cover-00.15-00000000000-20220603T183608Z-avarab@gmail.com>
References: <RFC-cover-00.15-00000000000-20220603T183608Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Whitespace-wrap some overly long write_*file*() lines in preparation
for changing their signatures in a subsequent commit. I named the
"opts" argument to "write_idx_file()" while I was at it for
consistency.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 pack.h | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/pack.h b/pack.h
index b22bfc4a18e..802c047efe6 100644
--- a/pack.h
+++ b/pack.h
@@ -81,7 +81,10 @@ struct progress;
 /* Note, the data argument could be NULL if object type is blob */
 typedef int (*verify_fn)(const struct object_id *, enum object_type, unsigned long, void*, int*);
 
-const char *write_idx_file(const char *index_name, struct pack_idx_entry **objects, int nr_objects, const struct pack_idx_option *, const unsigned char *sha1);
+const char *write_idx_file(const char *index_name,
+			   struct pack_idx_entry **objects, int nr_objects,
+			   const struct pack_idx_option *opts,
+			   const unsigned char *sha1);
 int check_pack_crc(struct packed_git *p, struct pack_window **w_curs, off_t offset, off_t len, unsigned int nr);
 int verify_pack_index(struct packed_git *);
 int verify_pack(struct repository *, struct packed_git *, verify_fn fn, struct progress *, uint32_t);
@@ -93,8 +96,14 @@ struct ref;
 
 void write_promisor_file(const char *promisor_name, struct ref **sought, int nr_sought);
 
-const char *write_rev_file(const char *rev_name, struct pack_idx_entry **objects, uint32_t nr_objects, const unsigned char *hash, unsigned flags);
-const char *write_rev_file_order(const char *rev_name, uint32_t *pack_order, uint32_t nr_objects, const unsigned char *hash, unsigned flags);
+const char *write_rev_file(const char *rev_name,
+			   struct pack_idx_entry **objects,
+			   uint32_t nr_objects,
+			   const unsigned char *hash, unsigned flags);
+const char *write_rev_file_order(const char *rev_name, uint32_t *pack_order,
+				 uint32_t nr_objects,
+				 const unsigned char *hash,
+				 unsigned flags);
 
 /*
  * The "hdr" output buffer should be at least this big, which will handle sizes
-- 
2.36.1.1124.g577fa9c2ebd

