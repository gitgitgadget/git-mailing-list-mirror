Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF747C7EE23
	for <git@archiver.kernel.org>; Wed,  7 Jun 2023 22:58:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233205AbjFGW6i (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Jun 2023 18:58:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232375AbjFGW6Z (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Jun 2023 18:58:25 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E0192695
        for <git@vger.kernel.org>; Wed,  7 Jun 2023 15:58:17 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id 3f1490d57ef6-ba1815e12efso44631276.3
        for <git@vger.kernel.org>; Wed, 07 Jun 2023 15:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1686178696; x=1688770696;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZPXEDPGsAtwP4lFHhTzDEpTv7yIl04B4I1tw1+GHTqI=;
        b=chjuUCZCf1cIqTa0KcQGrIGbYSx57uvAhQJgIXxQYvBK9Set/x2GmWQY5ukL1KOvXx
         2x+cV/OSXGQStASqKdfnCR/UAxtrtjst63RKk0XCZ9gYFyqDnsX19vItjqPujCNPcl5o
         V+nxeeEKlRNryTfibGh56EO5V3q26efNQZFfVVRpE6JzB6JcpwQH43NzfzO+mjhAdUU2
         BCSDVI4QTG6YlqSCI7CCVISedfSsGzB+t/x0KdTIISZqDvJgbVAgxcHUGGtD2XOIXGxM
         kI7T+TlYwD0RepqfKAPHgtRK05TIGUw0HHUJ0xrDHbIrpVC86Q6D44RoubmG6RsS53ZQ
         88xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686178696; x=1688770696;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZPXEDPGsAtwP4lFHhTzDEpTv7yIl04B4I1tw1+GHTqI=;
        b=UgLs70JHrko9bH0w7sVefFsshKFc10TnifX82N7gZFFykeIT4kn5RTUDa1M8V1SZCa
         AbG+R/5R1911oz+x6jiA2XewFb64PssOG+BKf036grA0v2WoUBkCvq59C9mA1pRn/4/D
         7mhLLMbN3S8eP3nnrRmFLAESNQiaOonMmLK+AWF26SE6gI8eXpFOg0MPO4xXgxaYTYtv
         43vBgukBqfL6Qrg/JJOYmUUv5PhA3W98BL6C6Da9Yh7Yk7CCTDOnwVzIS66W4fjz0AQy
         zg0K2Tk02I+1otlCa1/sLYGWKvcAalydhccOANf8e7s0ZKnfOrHJ1Rxx+I3rPrXTm/K2
         YTSg==
X-Gm-Message-State: AC+VfDwGv7iESF9RvxzeFH2eWNrW/YKJ9MtY1ViFDUxnp73tDgl1BAso
        nBX8+kN+TmOIUbu6SkkYqjbrTB98w84ohnvrCO9X6KL9
X-Google-Smtp-Source: ACHHUZ5tjmHqbSy+2jR1+2wDgZAxV9teXFipnJfYlbXJ7XY3qH+/Ah7xByQaN+zppJzA14Qzu10C1g==
X-Received: by 2002:a0d:dd46:0:b0:568:be91:c2c0 with SMTP id g67-20020a0ddd46000000b00568be91c2c0mr7298604ywe.6.1686178696060;
        Wed, 07 Jun 2023 15:58:16 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id x62-20020a814a41000000b0054f80928ea4sm5020235ywa.140.2023.06.07.15.58.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 15:58:15 -0700 (PDT)
Date:   Wed, 7 Jun 2023 18:58:12 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Chris Torek <chris.torek@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>
Subject: [PATCH v5 1/2] reachable.c: extract `obj_is_recent()`
Message-ID: <38c4c4a17fc71dd301bbdbf6c9515fcd75053478.1686178684.git.me@ttaylorr.com>
References: <cover.1683847221.git.me@ttaylorr.com>
 <cover.1686178684.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1686178684.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When enumerating objects in order to add recent ones (i.e. those whose
mtime is strictly newer than the cutoff) as tips of a reachability
traversal, `add_recent_object()` discards objects which do not meet the
recency criteria.

The subsequent commit will make checking whether or not an object is
recent also consult the list of hooks in `pack.recentHook`. Isolate this
check in its own function to keep the additional complexity outside of
`add_recent_object()`.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 reachable.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/reachable.c b/reachable.c
index 55bb114353..7a42da5d39 100644
--- a/reachable.c
+++ b/reachable.c
@@ -69,6 +69,12 @@ struct recent_data {
 	int ignore_in_core_kept_packs;
 };
 
+static int obj_is_recent(const struct object_id *oid, timestamp_t mtime,
+			 struct recent_data *data)
+{
+	return mtime > data->timestamp;
+}
+
 static void add_recent_object(const struct object_id *oid,
 			      struct packed_git *pack,
 			      off_t offset,
@@ -78,7 +84,7 @@ static void add_recent_object(const struct object_id *oid,
 	struct object *obj;
 	enum object_type type;
 
-	if (mtime <= data->timestamp)
+	if (!obj_is_recent(oid, mtime, data))
 		return;
 
 	/*
-- 
2.41.0.2.gaaae24b3a6.dirty

