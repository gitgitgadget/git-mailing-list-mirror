Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5654F202A5
	for <e@80x24.org>; Fri, 22 Sep 2017 23:35:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752220AbdIVXfh (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Sep 2017 19:35:37 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33853 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751763AbdIVXfe (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Sep 2017 19:35:34 -0400
Received: by mail-wm0-f68.google.com with SMTP id i131so2481485wma.1
        for <git@vger.kernel.org>; Fri, 22 Sep 2017 16:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NRd5ge4wGRMQW5ZeK22Q6SSBmZcEMDEtRWdEp218OvE=;
        b=JZUaKJI2PwI6d3dQ7KEjjiRG49viTbzHfdZGA+ibjIm0qxn5/EaSuSus8B5rSmr+JR
         1AfrMeNIwvjpZzDafUJSx7HvtZWRUiPUt/3fn8NXnzyhDTyHfAT5jUac2+3OVVhUqG9g
         N607SJdwiFKo2xWB7JwCbGxxbosb4lPFTKj+E17kQoPmXJeXqUpR3DP4SNer+C25eSq+
         8Gov3L+FhROxhaxqxCpcI77pQD5d3CKKZeQHE12Vr0KzbVnX747gKuHBA3CaV62GQ29v
         VBJ3QGZcCp9Xn5IO/XW9tt7u5ox3P46zbxIAycKxT7Diuhz9U00V0L2y6Uhk07EnyEz4
         z4zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NRd5ge4wGRMQW5ZeK22Q6SSBmZcEMDEtRWdEp218OvE=;
        b=LL1ZkiH/cz8QTMuNni7oXL4EZOnfi+9CdTRsoNPV+ZuRRApjX7+Llk51EPKJKCJQqC
         uuQunYOZk3RwpWN2J8lTf8pwFjIZZsr/9KpCqtDDtGWQdLQG6P1wvhp+qXuokXcm410A
         fmVZqKdoLfmfmfYgx5ge66Zs5k4DhIKrJ0wRDCsiKM0BDsjVvmXL2O1QA9OfhxtdtqF1
         +9x6kvo0Aw344VSBSkK2ceEhTjmA4SiWiLLN8u8kt1zXss/B1G+ATuHPfsFY4VtnItLK
         g7HmtHs597QMF4qNg2anljCBxDh9rVDom/XmjDZNRvfDNPI/GlzstDXDAUXhrmr7tr1v
         PROA==
X-Gm-Message-State: AHPjjUihyz/iRSVL3BQaUus1sLXibgoBSMHF8Y4UggFDeyEZNUNUxkAM
        /D0/cXosKmf37Li7kg0FSZKnTQ==
X-Google-Smtp-Source: AOwi7QATsLUg67TF9NvL5EL/H08srt2V+8ICTrBrW+5bb8n+jQ5uCbeBOFUua0RXiBtg7/ozO9SdBA==
X-Received: by 10.28.238.140 with SMTP id j12mr756682wmi.103.1506123332548;
        Fri, 22 Sep 2017 16:35:32 -0700 (PDT)
Received: from localhost.localdomain ([2a02:aa16:5782:c100:c938:fbb7:46f8:2405])
        by smtp.gmail.com with ESMTPSA id e77sm2071333wmf.27.2017.09.22.16.35.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 22 Sep 2017 16:35:31 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>
Subject: [PATCH v2 6/6] pack-bitmap[-write]: use `object_array_clear()`, don't leak
Date:   Sat, 23 Sep 2017 01:34:54 +0200
Message-Id: <30407fada0ee65ca61e5cc52b1dafc708ab90883.1506120292.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.14.1.727.g9ddaf86
In-Reply-To: <cover.1506120291.git.martin.agren@gmail.com>
References: <20170920200229.bc4yniz6otng2zyz@sigill.intra.peff.net> <cover.1506120291.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Instead of setting the fields of rev->pending to 0/NULL, thereby leaking
memory, call `object_array_clear(&rev->pending)`.

In pack-bitmap.c, we make copies of those fields as `pending_nr` and
`pending_e`. We never update the aliases and the original fields never
change, so the aliases are not really needed and just make it harder
than necessary to understand the code. While we're here, remove the
aliases to make the code easier to follow.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 pack-bitmap-write.c |  4 +---
 pack-bitmap.c       | 10 +++-------
 2 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/pack-bitmap-write.c b/pack-bitmap-write.c
index 8e47a96b3..a8df5ce2a 100644
--- a/pack-bitmap-write.c
+++ b/pack-bitmap-write.c
@@ -297,9 +297,7 @@ void bitmap_writer_build(struct packing_data *to_pack)
 
 			traverse_commit_list(&revs, show_commit, show_object, base);
 
-			revs.pending.nr = 0;
-			revs.pending.alloc = 0;
-			revs.pending.objects = NULL;
+			object_array_clear(&revs.pending);
 
 			stored->bitmap = bitmap_to_ewah(base);
 			need_reset = 0;
diff --git a/pack-bitmap.c b/pack-bitmap.c
index 327634cd7..0a49c1595 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -653,8 +653,6 @@ static int in_bitmapped_pack(struct object_list *roots)
 int prepare_bitmap_walk(struct rev_info *revs)
 {
 	unsigned int i;
-	unsigned int pending_nr = revs->pending.nr;
-	struct object_array_entry *pending_e = revs->pending.objects;
 
 	struct object_list *wants = NULL;
 	struct object_list *haves = NULL;
@@ -669,8 +667,8 @@ int prepare_bitmap_walk(struct rev_info *revs)
 			return -1;
 	}
 
-	for (i = 0; i < pending_nr; ++i) {
-		struct object *object = pending_e[i].item;
+	for (i = 0; i < revs->pending.nr; ++i) {
+		struct object *object = revs->pending.objects[i].item;
 
 		if (object->type == OBJ_NONE)
 			parse_object_or_die(&object->oid, NULL);
@@ -714,9 +712,7 @@ int prepare_bitmap_walk(struct rev_info *revs)
 	if (!bitmap_git.loaded && load_pack_bitmap() < 0)
 		return -1;
 
-	revs->pending.nr = 0;
-	revs->pending.alloc = 0;
-	revs->pending.objects = NULL;
+	object_array_clear(&revs->pending);
 
 	if (haves) {
 		revs->ignore_missing_links = 1;
-- 
2.14.1.727.g9ddaf86

