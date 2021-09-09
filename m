Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24FA1C433F5
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 23:24:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09CE1610E8
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 23:24:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349658AbhIIXZs (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Sep 2021 19:25:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349580AbhIIXZo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Sep 2021 19:25:44 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95185C061575
        for <git@vger.kernel.org>; Thu,  9 Sep 2021 16:24:34 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id v16so80683ilo.10
        for <git@vger.kernel.org>; Thu, 09 Sep 2021 16:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Mzrow7ycQLXalkEw2wrFECFsQ3V8XGkViNlR9HvpOsc=;
        b=m3MEHk7ucS3iQLiEYvsXeUAj5YvCLqlSKzOA7p2pLczHqv7eBhIhQEUDxVZOyBjF63
         r4ZRSwU16MLQwS33uS2Jj7neBS0pFIcRiBQ7N9leQmoaL86VWRUJAWKb0QjhAWjf9P8b
         lr7ZyFV4ieqPzpNfvAgibZfYb3u0Mo8c+LkNndXCbTNOLmhQ9F7qR6Pt06LT68K6gx/c
         vXPCNoO5ocA5nN5bSRITaZzL2lfvwkt8loc6FsmWKKgPddBxgDJGZSa3/qiRERT/bpZ9
         2r0JOwd+7qWljJx13JM3fKpQwWHUyIONmsFGVY/n4prggDFidMBA8V3cXoZs3Xq7p/hN
         oXoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Mzrow7ycQLXalkEw2wrFECFsQ3V8XGkViNlR9HvpOsc=;
        b=IEG0IoX3UdqVhyWaACRHPpcdPW4XiriJw6IhMm8CRJrpoLlcEoHz/g3tU1DyMkdZoF
         n+9REzUOjCrt9F4izAihCyHwUBCy0B6USb1y82hivLra8ckzAye70FLNK+sAGzTeILbH
         e4fVuOPyHXmvVUlKOh2Mkb1Wu5EvZTnviizuSwP/PuwvcHmkuNznrmhC/IjnF/EnOy9G
         lo0iFGGkkuv7y25C+MXewXw404fJaQIxXCDwvMYfFRi8TgWH60twBNpxzM81Qlb88Oc5
         BxhoAkMs0nlrGzbS83On/kn5iDgZimE5dpTNi2qgJoaf3x7MIEP9VBl83mCsQizmYs9i
         tQLw==
X-Gm-Message-State: AOAM530jX01IICGW8sPZ/QJMiOhnhv4oZsDYEVC55XZsXz7zQjNdRSNA
        Z83fPFrxXtTXTZ76ejTks3+6yokaHOQm10PB
X-Google-Smtp-Source: ABdhPJzbQa0y4bjdDvK1awPhTfKA8TXBird6fF701AtwRTPhzZsBMSAQxRg9D66UDgxpiXoQUxMoBg==
X-Received: by 2002:a92:6b0a:: with SMTP id g10mr4039724ilc.27.1631229873865;
        Thu, 09 Sep 2021 16:24:33 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id s7sm1584005ioc.42.2021.09.09.16.24.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Sep 2021 16:24:33 -0700 (PDT)
Date:   Thu, 9 Sep 2021 19:24:32 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, gitster@pobox.com
Subject: [PATCH v2 2/9] bulk-checkin.c: store checksum directly
Message-ID: <c46d3c29b44969beafc2bd27d33aa088eda0d4d6.1631228928.git.me@ttaylorr.com>
References: <cover.1631157880.git.me@ttaylorr.com>
 <cover.1631228928.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1631228928.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

finish_bulk_checkin() stores the checksum from finalize_hashfile() by
writing to the `hash` member of `struct object_id`, but that hash has
nothing to do with an object id (it's just a convenient location that
happens to be sized correctly).

Store the hash directly in an unsigned char array. This behaves the same
as writing to the `hash` member, but makes the intent clearer (and
avoids allocating an extra four bytes for the `algo` member of `struct
object_id`). It likewise prevents the possibility of a segfault when
reading `algo` (e.g., by calling `oid_to_hex()`) if it is uninitialized.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 bulk-checkin.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/bulk-checkin.c b/bulk-checkin.c
index b023d9959a..6283bc8bd9 100644
--- a/bulk-checkin.c
+++ b/bulk-checkin.c
@@ -25,7 +25,7 @@ static struct bulk_checkin_state {
 
 static void finish_bulk_checkin(struct bulk_checkin_state *state)
 {
-	struct object_id oid;
+	unsigned char hash[GIT_MAX_RAWSZ];
 	struct strbuf packname = STRBUF_INIT;
 	int i;
 
@@ -37,11 +37,11 @@ static void finish_bulk_checkin(struct bulk_checkin_state *state)
 		unlink(state->pack_tmp_name);
 		goto clear_exit;
 	} else if (state->nr_written == 1) {
-		finalize_hashfile(state->f, oid.hash, CSUM_HASH_IN_STREAM | CSUM_FSYNC | CSUM_CLOSE);
+		finalize_hashfile(state->f, hash, CSUM_HASH_IN_STREAM | CSUM_FSYNC | CSUM_CLOSE);
 	} else {
-		int fd = finalize_hashfile(state->f, oid.hash, 0);
-		fixup_pack_header_footer(fd, oid.hash, state->pack_tmp_name,
-					 state->nr_written, oid.hash,
+		int fd = finalize_hashfile(state->f, hash, 0);
+		fixup_pack_header_footer(fd, hash, state->pack_tmp_name,
+					 state->nr_written, hash,
 					 state->offset);
 		close(fd);
 	}
@@ -49,7 +49,7 @@ static void finish_bulk_checkin(struct bulk_checkin_state *state)
 	strbuf_addf(&packname, "%s/pack/pack-", get_object_directory());
 	finish_tmp_packfile(&packname, state->pack_tmp_name,
 			    state->written, state->nr_written,
-			    &state->pack_idx_opts, oid.hash);
+			    &state->pack_idx_opts, hash);
 	for (i = 0; i < state->nr_written; i++)
 		free(state->written[i]);
 
-- 
2.33.0.96.g73915697e6

