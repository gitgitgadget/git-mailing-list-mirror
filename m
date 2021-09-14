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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B82DC433EF
	for <git@archiver.kernel.org>; Tue, 14 Sep 2021 03:39:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55D6A60F26
	for <git@archiver.kernel.org>; Tue, 14 Sep 2021 03:39:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238757AbhINDkG (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Sep 2021 23:40:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238591AbhINDkF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Sep 2021 23:40:05 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8983DC061760
        for <git@vger.kernel.org>; Mon, 13 Sep 2021 20:38:48 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id g16so17826432wrb.3
        for <git@vger.kernel.org>; Mon, 13 Sep 2021 20:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=7X2vP95Nrih2/ZYF5MeQkFO3N7Ybz8M6MMt6amHXYUA=;
        b=ZUMw+c4bVODbvvJ6t9dCxmWJU8Fa/Zp1z6WIdLx1dJyphtQnSIQw6D8d1EKHrxD6ng
         yJGs+ZXPZoJunZnuNeICj5yWJ69juB46Q8uEm5YFw6bK0vuuHBv0NnnqsgKPfpWvBLxS
         zD5u2+OCqa7i2aBBMVj1FDVUEhEWYHpcDyjF8qYyN2AwljTh0/PhgtAsdifD+yZvGVlf
         biq7d6D/D59fkBhgwPDmZIDcP0jTxQUS9UkT9y//535yH/YD1dPnja0gSDA81ZtmhLCz
         yo18FB9TcxBS/WxGY7cvge5XoTPZe/Z5j3MsVUzBV7vf9aqrIbkV3kQALRj8YJZnw7bJ
         Ig9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=7X2vP95Nrih2/ZYF5MeQkFO3N7Ybz8M6MMt6amHXYUA=;
        b=SFdsMU3m5rvKQwjbXFMwAu228AdjeQ4De0UH8JLYeTsDYiYC00+z5IYJVw/N6IBxF2
         q2buCdKPhhgycRFuJEX6BWz/zdwvXoz1/D0+S9nlazKIcCFFRtnsRIovZoyoTLCKNvH3
         fjtLDNruG7XxuYnir/09Epquptsuu0mVJU5Duxcf8guMP3liZW/6/mIPuKVDCzGx4mMT
         fZtQPEam1NSH2Jj5FeICfOO/tCfmE6d0GCov93dbMPQlApHu4GKMgtm7JUJtUJ1kEkr2
         EW6/Evs8aaiMs96cYxjlaaJBaccffRoKQ+ETvAX5DRPWLWWEw0tcu+Abzqu/vbxvjkRa
         p6fg==
X-Gm-Message-State: AOAM533fqtT2Emqo0d/Dvok848Qpj6htSE2vhtoduq+bxwLIRnOuwx65
        sn7/jjQmZi+D7ABoialWYlosGhgifV8=
X-Google-Smtp-Source: ABdhPJyN3q/cU0MEu7HPoinrvS2c3yz0n9+3Nwdubdbj9RdutKE5DvxykPPn472jUMLNA7kZy4MkSw==
X-Received: by 2002:adf:e485:: with SMTP id i5mr15875243wrm.22.1631590727182;
        Mon, 13 Sep 2021 20:38:47 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o2sm9696421wrh.13.2021.09.13.20.38.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Sep 2021 20:38:46 -0700 (PDT)
Message-Id: <d5893e28df152ce9b843d4709ed9349156633b3d.1631590725.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1076.v3.git.git.1631590725.gitgitgadget@gmail.com>
References: <pull.1076.v2.git.git.1630108177.gitgitgadget@gmail.com>
        <pull.1076.v3.git.git.1631590725.gitgitgadget@gmail.com>
From:   "Neeraj Singh via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 14 Sep 2021 03:38:40 +0000
Subject: [PATCH v3 1/6] bulk-checkin: rename 'state' variable and separate
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

