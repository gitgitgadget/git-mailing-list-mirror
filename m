Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46FA6C4320A
	for <git@archiver.kernel.org>; Fri, 27 Aug 2021 23:49:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B94B60F91
	for <git@archiver.kernel.org>; Fri, 27 Aug 2021 23:49:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232628AbhH0Xue (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 Aug 2021 19:50:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232546AbhH0Xua (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Aug 2021 19:50:30 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF9FCC0613D9
        for <git@vger.kernel.org>; Fri, 27 Aug 2021 16:49:40 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id g18so5236225wrc.11
        for <git@vger.kernel.org>; Fri, 27 Aug 2021 16:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=7X2vP95Nrih2/ZYF5MeQkFO3N7Ybz8M6MMt6amHXYUA=;
        b=ROIPV3pSetfdE0UuaKDjco2qLyaOmwySA8tk2oHLXkk6kKZmSqpbTYedq9oTbCodHB
         HlD50AcMcNUcu7QDx9byfwZKY6vDlf4tSsolq6xDM3RSWXhbZGi3+uP0Tt55JZju3B8M
         ZmtI8kGvAeAi3fct2aP71eyB6Ioii/wuRT6jrCN8vlJEHLKerturaBx8QYXLhuXoz7wZ
         KLDKAv8sXEXn6p8SpOBhcBBFJL0aIbBb+xMOi1mjz3HN288ugGB44rk/2P6ZW8iuPH7t
         PPvZEmyQ/AYqxtvk3P8LamxGpfrt9lTdBC0zzFYcxKwCXz/nwhhLxl3fVUkb/UfWAa6s
         w/5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=7X2vP95Nrih2/ZYF5MeQkFO3N7Ybz8M6MMt6amHXYUA=;
        b=HV4CCVxp0/01gGqPfo1mG0vBzNWKp9N5fDyeKuxzxDt2KxyVqMAimuHyDMcyfBnWDW
         V7UnrdEsI3BVI+BEL0Iy+MhUgUvU36CS/GjK8f4GVzygAaty1DibecxvBdD5t+8sBRgX
         RBLA4Ff4OhzFPlPfynYZ9mKZ7q2CCcZE/w0iD71zBp5emBqHDImPZ7IdFjG+C8N/EPA4
         HfpT1Ax0PTB8EgK21FVudvXK8mij8B8mabexZbqsR0DF//JadhazhBtvbCZ4InEuu+B7
         4H+Hcuzbwu5GA2PSJ4nyTodXDWzTwxEIA54o9vIpHX4MXjur+tNDdWQqplwt1XeoMRvR
         lcWw==
X-Gm-Message-State: AOAM5321XAdA2Z4RdehsvFC/XcWVO8ScajEFFYoXdtYIX8mXKmxJPM4B
        zyosMNydr4fKZWO83uNG/Do+6OJ6DP8=
X-Google-Smtp-Source: ABdhPJxYTI7g5g7SDJrwJzVtstIlV2kXZaJsmy+k9NJqlU4vWMIVlu+xL+pTC2IHj2+NnQ3Sb0XMZg==
X-Received: by 2002:adf:c148:: with SMTP id w8mr5594934wre.317.1630108179523;
        Fri, 27 Aug 2021 16:49:39 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c13sm7697581wru.73.2021.08.27.16.49.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Aug 2021 16:49:39 -0700 (PDT)
Message-Id: <49f72800bfb9d23d5f42005f494a56bbabdf4aca.1630108177.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1076.v2.git.git.1630108177.gitgitgadget@gmail.com>
References: <pull.1076.git.git.1629856292.gitgitgadget@gmail.com>
        <pull.1076.v2.git.git.1630108177.gitgitgadget@gmail.com>
From:   "Neeraj Singh via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 27 Aug 2021 23:49:33 +0000
Subject: [PATCH v2 2/6] bulk-checkin: rename 'state' variable and separate
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
        <avarab@gmail.com>, "Neeraj K. Singh" <neerajsi@microsoft.com>,
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

