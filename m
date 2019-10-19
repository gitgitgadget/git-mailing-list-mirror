Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7ED121F4C0
	for <e@80x24.org>; Sat, 19 Oct 2019 10:35:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726008AbfJSKfy (ORCPT <rfc822;e@80x24.org>);
        Sat, 19 Oct 2019 06:35:54 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34527 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725940AbfJSKfy (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Oct 2019 06:35:54 -0400
Received: by mail-wr1-f66.google.com with SMTP id t16so3608875wrr.1
        for <git@vger.kernel.org>; Sat, 19 Oct 2019 03:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oK2HzqZ7FBuvcugKHc3SgF2RSQEtsp+Lq2fa+TU6eF4=;
        b=fumtNEiJ2e4xH1wBcBSiL2S3/GeV6g++FIiqFzyRrbhTTeXRwjrNDlHXZSjGcf21tq
         YC3frSwp1TQ1q+1jjcD0tkjiO4VPJuUWLVhhuuTrNHdYmnmkvd4x+b7wt5DdI9WW9D6L
         cGCP+LM2bFOq3rvSz/5dkgFs6QWK+GbqtkIhwxTgDIaunXFv23m4Duh7WvTA9/YgM6vQ
         bEVVqdOUtLoY92dovHxDZ4NBGCOdTezkUTYRNuR0KQHLfHQ2bKQd/Sx67Htwzbebn06u
         o27OhZUdt22nCtOASKgmENyuyPOBAgqJshUvyOJIYaHcp7d7PHY214Iv8BIqMqzPnW+a
         Yb1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oK2HzqZ7FBuvcugKHc3SgF2RSQEtsp+Lq2fa+TU6eF4=;
        b=BZFL0O65mmeVK/L7qb6pLyNRVKtuK/DmT2W8P5GM/bBpt+UcSQ1kjAoMm+zlrIcHcS
         wBWIhcmNd+qyts962DelZgA3AxCFE+PGv9u7OGMDe7JcoOQ0IbtbG/1/IPGbU8HlLA6O
         ijgGOJ4ODV12m7ToaLs9TAcwWYjhhHNm1YBDAwUtbe4LvGczD5WlsEp+40f3W94IfRyp
         AgcJ6UTc4xJQ8N+PSd9G3fNw1GuzR7r0SMnd+pyBEtaoikpk8uF4UFXqzNcE9vj0o/ov
         Uf4Arp1Aav6FS7ed8wne9Szqt3cutKsgDeIpKHBI2QDp9RwXeAdpbeDI0sOXw1Fe/lqC
         w9HQ==
X-Gm-Message-State: APjAAAWeCK8+TGNOZQVybQfaVJeZROopFP8d6l9bsfuYRrkLCp4OdUu6
        GJM9nwIWhleQYhZq+MsMJxAfKrZpBlf/PQ==
X-Google-Smtp-Source: APXvYqxEYKGDv83kUuTyuZ55B9Ky1YBAu7mNtXku6qaukSGhGmcDuKtr4eqo/Ttuo83UWKv8vwPGbw==
X-Received: by 2002:adf:f004:: with SMTP id j4mr12372879wro.68.1571481352293;
        Sat, 19 Oct 2019 03:35:52 -0700 (PDT)
Received: from localhost.localdomain ([80.214.68.206])
        by smtp.gmail.com with ESMTPSA id p68sm6383086wme.0.2019.10.19.03.35.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Oct 2019 03:35:51 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: [PATCH v2 2/9] packfile: expose get_delta_base()
Date:   Sat, 19 Oct 2019 12:35:24 +0200
Message-Id: <20191019103531.23274-3-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.24.0.rc0.9.gef620577e2
In-Reply-To: <20191019103531.23274-1-chriscool@tuxfamily.org>
References: <20191019103531.23274-1-chriscool@tuxfamily.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff King <peff@peff.net>

In a following commit get_delta_base() will be used outside
packfile.c, so let's make it non static and declare it in
packfile.h.

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 packfile.c | 10 +++++-----
 packfile.h |  3 +++
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/packfile.c b/packfile.c
index 355066de17..81e66847bf 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1173,11 +1173,11 @@ const struct packed_git *has_packed_and_bad(struct repository *r,
 	return NULL;
 }
 
-static off_t get_delta_base(struct packed_git *p,
-				    struct pack_window **w_curs,
-				    off_t *curpos,
-				    enum object_type type,
-				    off_t delta_obj_offset)
+off_t get_delta_base(struct packed_git *p,
+		     struct pack_window **w_curs,
+		     off_t *curpos,
+		     enum object_type type,
+		     off_t delta_obj_offset)
 {
 	unsigned char *base_info = use_pack(p, w_curs, *curpos, NULL);
 	off_t base_offset;
diff --git a/packfile.h b/packfile.h
index fc7904ec81..ec536a4ae5 100644
--- a/packfile.h
+++ b/packfile.h
@@ -151,6 +151,9 @@ void *unpack_entry(struct repository *r, struct packed_git *, off_t, enum object
 unsigned long unpack_object_header_buffer(const unsigned char *buf, unsigned long len, enum object_type *type, unsigned long *sizep);
 unsigned long get_size_from_delta(struct packed_git *, struct pack_window **, off_t);
 int unpack_object_header(struct packed_git *, struct pack_window **, off_t *, unsigned long *);
+off_t get_delta_base(struct packed_git *p, struct pack_window **w_curs,
+		     off_t *curpos, enum object_type type,
+		     off_t delta_obj_offset);
 
 void release_pack_memory(size_t);
 
-- 
2.24.0.rc0.9.gef620577e2

