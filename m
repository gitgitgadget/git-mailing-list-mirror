Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44A0EC433EF
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 03:25:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22F9F61167
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 03:25:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350098AbhIID0H (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Sep 2021 23:26:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350097AbhIID0C (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Sep 2021 23:26:02 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4358C0613CF
        for <git@vger.kernel.org>; Wed,  8 Sep 2021 20:24:53 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id z2so545479iln.0
        for <git@vger.kernel.org>; Wed, 08 Sep 2021 20:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zRAm7wO8omCTI9xB/lMODQfTrHfmwinB1IrBpjhDdCU=;
        b=HsQWsDPv4QZf6auBYlO5MfQXidMIdIagsmnNOPLvWw8OzGvm2YIwzf6L2p/GKRAm+1
         SIdB84zaKhqp/wpJvKLgWZx4ooyxtMVzvmgT1RRT40dNN+By0KmL3YVrYaRH+IqxezHf
         YmDhTMadYuGs3lRF8D9KWwZG1u+8n2SChDP9CoWixGPgYm468qZU7bBlHa3/Gp4uE5X6
         jKA9GFXFTqjIGXRet1eO173FkSg44BKdwGvoiZwQyPVK/mM9IbB5pMkYBW3viG5xkiDd
         cAkuYC0yB4s/yi+A9SBy+W4LXOWPISuQlGM1EW/oZZLvQuIwVt5ynTdju8MEgR9M+DLN
         ZO1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zRAm7wO8omCTI9xB/lMODQfTrHfmwinB1IrBpjhDdCU=;
        b=mGPYroNeSfgIlV+DeqJ2iBGZZZ8K+lh+I+nwdW1KpKwHeHeb+A3kcIBfC5DDLqPsy0
         /BnFzc9gfaewetiSuyniGBRUzzTcLb3mB2cWFuEy2ewFpGAWl39p3LyuZzMdT4fnIZ+t
         QmrtKPMWMnlVNsm/WTyvmV/yKQTh5T8+wbRyzI/xEb6LkN/hCE/La6Q4dVlc34+tdl1D
         wG1mYzKITGzmqeIMkHRlPPmobMdeGU+U752fBxVMSXeErqO+ONc1Gk6C+Lqvy/pR1Mdi
         jL//vb/USPs3kCaL8ts8YwwM2B2Q1zFryXdkstc7oT/0nFbyn7d4B7RdhciQNkHtteyi
         R1oA==
X-Gm-Message-State: AOAM532LRCtASwnbweBAf3E5t5UwXGkueEx7ImsO8zKccJpCjzTCRJ+J
        wpJs9JVD8cPj0CBq+A9VJSuPhRmWRbGCAHbg
X-Google-Smtp-Source: ABdhPJwFQ0U5RHJUQu577e0exSuzO0ivC88a4Y1WynE9VveXe082SG8D2Ea75Wk4odwsnntKhxLLoA==
X-Received: by 2002:a05:6e02:ef4:: with SMTP id j20mr706967ilk.294.1631157892878;
        Wed, 08 Sep 2021 20:24:52 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id s18sm307275iov.53.2021.09.08.20.24.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Sep 2021 20:24:52 -0700 (PDT)
Date:   Wed, 8 Sep 2021 23:24:51 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, gitster@pobox.com
Subject: [PATCH 2/9] bulk-checkin.c: store checksum directly
Message-ID: <20b35ce0505d7bcc84b6fd68a33e0b6b1afa31e6.1631157880.git.me@ttaylorr.com>
References: <cover.1630461918.git.me@ttaylorr.com>
 <cover.1631157880.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1631157880.git.me@ttaylorr.com>
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
object_id`).

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

