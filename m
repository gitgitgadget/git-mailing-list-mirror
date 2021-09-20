Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26076C433F5
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 02:20:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E81D60F9D
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 02:20:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbhIUCVr (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Sep 2021 22:21:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236462AbhIUBuT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Sep 2021 21:50:19 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 211E0C051776
        for <git@vger.kernel.org>; Mon, 20 Sep 2021 15:15:15 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id q26so33701096wrc.7
        for <git@vger.kernel.org>; Mon, 20 Sep 2021 15:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=7X2vP95Nrih2/ZYF5MeQkFO3N7Ybz8M6MMt6amHXYUA=;
        b=iAG9Y6qlP1M3v0XVHmM7/d3UxxtW2TDLbfnVrtgAmQruYz7BmhChA8F0XMzGVZ9e8G
         f4pegY4V++H0vvRH39G8MRIk1w8d/JcGndxnw1wwJ+1IIX2i8jczx3yv+L3DZhefU8BV
         5I89oghoJBxESRjMf+iBfVcwmMm1Q1qt5LYT+1BI1bSykO5J/Hmr0PBhELYE8VdT7/f7
         Due1GLhelPZvzjmMebwh3BfXwMYWWdpHD/znPdi8udobnNsem5Y+wZC5/AhxoP5VKZ2f
         EC61pXCLGGNzfuQbfzGmOltxD77svwSvCr+lOjvsnUmN8HQfEkGwAHVCQnkE+ZIv3gSC
         cwVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=7X2vP95Nrih2/ZYF5MeQkFO3N7Ybz8M6MMt6amHXYUA=;
        b=lU6KRUhVFhOQDXC+3xjdGHCRZGBWoSjJ+bk0kZ3n7wiDPQE0bdw1cEFOM8O2+CK9+m
         uJlPFaP2uSuswwTjZzX43odTr7A7yoMRSP7QzTOoMJaF/Ie4EJvGCWazJRqxn3lZUmiw
         Saf8/IPvIMq7a5Np2TI81OiAAjB69GiUXEfBD/nEnGObaZhos6KGVFQTQljUm2RjwjR9
         OZSYLmfjF+x2h7p4yIlKF9Ai42eP8gSxgnNvwS9yRR9TeK+CSL92oieW42XwqbBM9q8K
         LKp4ofi+IjF2J8Z4XmeyBEpHV3GllNExp/xpe8LcBUtbObYDdkJZqRpx2UkwvMy+GnPX
         Y1Dg==
X-Gm-Message-State: AOAM533ZcTseddmEBs+bOA3ND9MF9BbnL1Cnx0bmGTIuLHeVkyjpCH5V
        SwJFZXqtedvBVrGjNpol9B1MORi1BJQ=
X-Google-Smtp-Source: ABdhPJyGqpYoEy1IjZtxF9PEx0Mq+wSvht3Lek9u/N4Y47tgdCJVjTGDYdBayQ/spkN1IVronKN/BA==
X-Received: by 2002:a1c:7906:: with SMTP id l6mr1215086wme.78.1632176113733;
        Mon, 20 Sep 2021 15:15:13 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l2sm1163232wmi.1.2021.09.20.15.15.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Sep 2021 15:15:13 -0700 (PDT)
Message-Id: <d5893e28df152ce9b843d4709ed9349156633b3d.1632176111.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1076.v4.git.git.1632176111.gitgitgadget@gmail.com>
References: <pull.1076.v3.git.git.1631590725.gitgitgadget@gmail.com>
        <pull.1076.v4.git.git.1632176111.gitgitgadget@gmail.com>
From:   "Neeraj Singh via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 20 Sep 2021 22:15:06 +0000
Subject: [PATCH v4 1/6] bulk-checkin: rename 'state' variable and separate
 'plugged' boolean
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Neeraj-Personal <nksingh85@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Christoph Hellwig <hch@lst.de>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, "Randall S. Becker" <rsbecker@nexbridge.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        "Neeraj K. Singh" <neerajsi@microsoft.com>,
        Neeraj Singh <neerajsi@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Neeraj Singh <neerajsi@microsoft.com>

Preparation for adding bulk-fsync to the bulk-checkin.c infrastructure.

* Rename 'state' variable to 'bulk_checkin_state', since we will later
  be adding 'bulk_fsync_state'.  This also makes the variable easier to
  find in the debugger, since the name is more unique.

* Move the 'plugged' data member of 'bulk_checkin_state' into a separate
  static variable. Doing this avoids resetting the variable in
  finish_bulk_checkin when zeroing the 'bulk_checkin_state'. As-is, we
  seem to unintentionally disable the plugging functionality the first
  time a new packfile must be created due to packfile size limits. While
  disabling the plugging state only results in suboptimal behavior for
  the current code, it would be fatal for the bulk-fsync functionality
  later in this patch series.

Signed-off-by: Neeraj Singh <neerajsi@microsoft.com>
---
 bulk-checkin.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/bulk-checkin.c b/bulk-checkin.c
index b023d9959aa..f117d62c908 100644
--- a/bulk-checkin.c
+++ b/bulk-checkin.c
@@ -10,9 +10,9 @@
 #include "packfile.h"
 #include "object-store.h"
 
-static struct bulk_checkin_state {
-	unsigned plugged:1;
+static int bulk_checkin_plugged;
 
+static struct bulk_checkin_state {
 	char *pack_tmp_name;
 	struct hashfile *f;
 	off_t offset;
@@ -21,7 +21,7 @@ static struct bulk_checkin_state {
 	struct pack_idx_entry **written;
 	uint32_t alloc_written;
 	uint32_t nr_written;
-} state;
+} bulk_checkin_state;
 
 static void finish_bulk_checkin(struct bulk_checkin_state *state)
 {
@@ -260,21 +260,23 @@ int index_bulk_checkin(struct object_id *oid,
 		       int fd, size_t size, enum object_type type,
 		       const char *path, unsigned flags)
 {
-	int status = deflate_to_pack(&state, oid, fd, size, type,
+	int status = deflate_to_pack(&bulk_checkin_state, oid, fd, size, type,
 				     path, flags);
-	if (!state.plugged)
-		finish_bulk_checkin(&state);
+	if (!bulk_checkin_plugged)
+		finish_bulk_checkin(&bulk_checkin_state);
 	return status;
 }
 
 void plug_bulk_checkin(void)
 {
-	state.plugged = 1;
+	assert(!bulk_checkin_plugged);
+	bulk_checkin_plugged = 1;
 }
 
 void unplug_bulk_checkin(void)
 {
-	state.plugged = 0;
-	if (state.f)
-		finish_bulk_checkin(&state);
+	assert(bulk_checkin_plugged);
+	bulk_checkin_plugged = 0;
+	if (bulk_checkin_state.f)
+		finish_bulk_checkin(&bulk_checkin_state);
 }
-- 
gitgitgadget

