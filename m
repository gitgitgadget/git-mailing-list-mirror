Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 44A061F597
	for <e@80x24.org>; Sun, 22 Jul 2018 05:49:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727865AbeGVGo1 (ORCPT <rfc822;e@80x24.org>);
        Sun, 22 Jul 2018 02:44:27 -0400
Received: from mail-wr1-f54.google.com ([209.85.221.54]:37258 "EHLO
        mail-wr1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727780AbeGVGo0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Jul 2018 02:44:26 -0400
Received: by mail-wr1-f54.google.com with SMTP id q10-v6so14755943wrd.4
        for <git@vger.kernel.org>; Sat, 21 Jul 2018 22:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FtH2TgM+tnYo51oaokxYYWOFXNrsOzOP46mb91TfuoI=;
        b=m/wAr23qGoWdPI4fMPhMacLSNPFo2d6V/4TybIHPeMja0fnNdhx/89VuG43jihWaew
         dNaTabJk2yOUEq0SkThCFqa8Nlp1zuxOaZEpRmiAXnih36c4c78CcqPucWXUWgb/M9Ao
         dl/roJREsc2yBK/1tPWAVJLthMsmj8UOpXGXfGtZsPoovse2IYsVBvV6aPJjXSCzBfgB
         gLtk27LtM56yn/9cZ4gU0lflxQkpQYmAJY06GMLySLaD0X9sa5w+PM0iu09AWv8k/Jkv
         O/mmdCskn4usygsRcIH1/n5OMrlkWbu1suU8w4Wl9vfw0iscfJeky0luvxBnmv2uM+t8
         bvDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FtH2TgM+tnYo51oaokxYYWOFXNrsOzOP46mb91TfuoI=;
        b=N9Tsi9cqMIBOg6kP+54oF3UIllWJk4NaeXfGGdOHD/h+Ts2QZJzf5G8OXYciA09gzU
         iLe+jR+4rxrn5N7zt6CkqUvcOCp9KzBZ4n4Izoe9+wJWtYFtUPqLsuWH3ZXeGjzn4u+W
         bbouq44FwwKqREsF1B4QtB7PfLi57zpT6iQf6LmLwKfLIvYRej416JRFWBSeTq1ny8Og
         /aAbsxbjlzr7eodOOWnp7zn/VJXPNSgzspcnZa7v9k5b0dc8hpetI62gKwvbkwLXLGYA
         FLk1w73ZDkwJUefKE/FL1ZHc8xCqcddUF/15iyGr7P9Me9Fe6X3YLlaQg4qlqsJgD5PB
         uUcg==
X-Gm-Message-State: AOUpUlFUJ7WWpFTlZLUrGYgqwCkbDsUPbP8sZdEgOsGY6xiQsgqU1qwZ
        kcIdHmA+ySJVX7NYtlQa6po3Qzdv
X-Google-Smtp-Source: AAOMgpe3evYoJ4kMFhog0bdiTEy71X58efphU0Zn4zXW6cXA7dUsNWbNYhf//XcKdiTDqNiiaEn/cQ==
X-Received: by 2002:adf:ab14:: with SMTP id q20-v6mr5082370wrc.239.1532238538511;
        Sat, 21 Jul 2018 22:48:58 -0700 (PDT)
Received: from localhost.localdomain (188.10.112.78.rev.sfr.net. [78.112.10.188])
        by smtp.gmail.com with ESMTPSA id d102-v6sm10591856wma.10.2018.07.21.22.48.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Jul 2018 22:48:57 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [RFC PATCH 1/5] packfile: make get_delta_base() non static
Date:   Sun, 22 Jul 2018 07:48:32 +0200
Message-Id: <20180722054836.28935-2-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.18.0.237.gffdb1dbdaa
In-Reply-To: <20180722054836.28935-1-chriscool@tuxfamily.org>
References: <20180722054836.28935-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff King <peff@peff.net>

As get_delta_base() will be used outside 'packfile.c' in
a following commit, let's make it non static and let's
declare it in 'packfile.h'.

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 packfile.c | 10 +++++-----
 packfile.h |  3 +++
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/packfile.c b/packfile.c
index 7cd45aa4b2..4646bff5ff 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1037,11 +1037,11 @@ const struct packed_git *has_packed_and_bad(const unsigned char *sha1)
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
index cc7eaffe1b..30f0811382 100644
--- a/packfile.h
+++ b/packfile.h
@@ -125,6 +125,9 @@ extern void *unpack_entry(struct repository *r, struct packed_git *, off_t, enum
 extern unsigned long unpack_object_header_buffer(const unsigned char *buf, unsigned long len, enum object_type *type, unsigned long *sizep);
 extern unsigned long get_size_from_delta(struct packed_git *, struct pack_window **, off_t);
 extern int unpack_object_header(struct packed_git *, struct pack_window **, off_t *, unsigned long *);
+extern off_t get_delta_base(struct packed_git *p, struct pack_window **w_curs,
+			    off_t *curpos, enum object_type type,
+			    off_t delta_obj_offset);
 
 extern void release_pack_memory(size_t);
 
-- 
2.18.0.237.gffdb1dbdaa

