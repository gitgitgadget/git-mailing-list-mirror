Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7367C0015E
	for <git@archiver.kernel.org>; Fri, 14 Jul 2023 00:55:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232662AbjGNAy7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Jul 2023 20:54:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230151AbjGNAy6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jul 2023 20:54:58 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B6D21BEB
        for <git@vger.kernel.org>; Thu, 13 Jul 2023 17:54:57 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id 3f1490d57ef6-cae0ad435b6so1316056276.0
        for <git@vger.kernel.org>; Thu, 13 Jul 2023 17:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1689296096; x=1691888096;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=txOihDaFwNsbEDc3nsfKTIFCk9iHgolEsZUvvPZilaM=;
        b=DQijAVG+JQxY0+ept3XVF+5A8NDJ9sDjHYx0ZTixEfVOg1v+RxDHhsvMkjlLsxO4yT
         EBwMOSRMLWxetqCsapX2zwLztmcvwG4zppXCtUPlzjbhoRc4v/kkbZB+W6hRsc/5Vax1
         gGta5ogwcXEgsDAGfYgUGA0om42lyY0oITV2C+q/DsKx3OVj0s7ACTCQ4Lm7XjY4YM7W
         IeQqXvpJGVNs2dc1YNDQk/W+OeNyrjZYooc2DCHG3U2SKDlVGJhF7YaZaFRuaw/AKigd
         Iz0EEudQWSeXtbLeBMjG/kAZLXiCqlF9bnl7rz9ATb2lELZvVBOBy7PA79LA3GBTwwGq
         fHZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689296096; x=1691888096;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=txOihDaFwNsbEDc3nsfKTIFCk9iHgolEsZUvvPZilaM=;
        b=f8kwOT9mubIzX4dxkUy5UnRLaZz88VArUKbpJY/Qj+y+2vz9qqv90r2segns8ppvTy
         2IUthn4fhqCKXM65yOSCw+p0PYWt3QX2lWxe9WGHcgix2SGBnk3VtY5aV3/rBwvDmhPn
         gvRZESYs3PALwZACcqRPtCoLo7pIgb2RlTWVzwXg8FvoFa72oW5by5uLvnOSB7Z3jUsv
         OWumeWS7LAjmjfVEODvmFlGHd26/39UWSp1wnOACRW50CnKmqM5pXV7yNSjYvG5mY/u7
         LImTF7KzIFQG+ghyBXS6OXCJ24IgMsq9BFZO+ThvnmyF8Jzm+B7wV4zN9KIH9xNHIFIr
         /EDQ==
X-Gm-Message-State: ABy/qLag0JKfTGXXNac5hCTMhx5sA8QKlFn0fBnVN0OgtFjIbArZu3ix
        +txLxq/4Ub1vk+cZMlJbbeCB0A==
X-Google-Smtp-Source: APBJJlELDmD9ela6iLqJDhksxYekAWLFb7JhXQvknupCYUhaK28RfS/qYNMCLmGqT1zdU4x7U2Z8bQ==
X-Received: by 2002:a25:ad1f:0:b0:c3e:2a69:7937 with SMTP id y31-20020a25ad1f000000b00c3e2a697937mr3008122ybi.22.1689296096599;
        Thu, 13 Jul 2023 17:54:56 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id b5-20020a056902030500b00c389676f3a2sm1565668ybs.40.2023.07.13.17.54.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 17:54:55 -0700 (PDT)
Date:   Thu, 13 Jul 2023 20:54:54 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Victoria Dye <vdye@github.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH 02/20] packfile.c: prevent overflow in `load_idx()`
Message-ID: <ZLCc3mRbdXPllpAp@nand.local>
References: <cover.1689205042.git.me@ttaylorr.com>
 <d6902cd9e7f7f2a6b8044c8fb782a28c23e15600.1689205042.git.me@ttaylorr.com>
 <5d2cf09f-34c7-9a88-bab2-8bf348dd13bb@gmail.com>
 <ZLAJNbIBFUPHYhlt@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZLAJNbIBFUPHYhlt@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 13, 2023 at 10:24:53AM -0400, Taylor Blau wrote:
> On Thu, Jul 13, 2023 at 09:21:55AM +0100, Phillip Wood wrote:
> > p->crc_offset is a uint32_t so we're still prone to truncation here unless
> > we change the crc_offset member of struct packed_git to be a size_t. I
> > haven't checked if the other users of crc_offset would need adjusting if we
> > change its type.
>
> Thanks for spotting. Luckily, this should be a straightforward change:

Here's a replacement patch which changes the type of `crc_offset`. If
there end up being other review comments, I'll fold this into the next
round.

--- 8< ---
Subject: [PATCH] packfile.c: prevent overflow in `load_idx()`

Prevent an overflow when locating a pack's CRC offset when the number
of packed items is greater than 2^32-1/hashsz by guarding the
computation with an `st_mult()`.

Note that to avoid truncating the result, the `crc_offset` member must
itself become a `size_t`. The only usage of this variable (besides the
assignment in `load_idx()`) is in `read_v2_anomalous_offsets()` in the
index-pack code. There we use the `crc_offset` as a pointer offset, so
we are already equipped to handle the type change.

Helped-by: Phillip Wood <phillip.wood@dunelm.org.uk>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 object-store-ll.h | 2 +-
 packfile.c        | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/object-store-ll.h b/object-store-ll.h
index e8f22cdb1b..26a3895c82 100644
--- a/object-store-ll.h
+++ b/object-store-ll.h
@@ -106,7 +106,7 @@ struct packed_git {
 	const void *index_data;
 	size_t index_size;
 	uint32_t num_objects;
-	uint32_t crc_offset;
+	size_t crc_offset;
 	struct oidset bad_objects;
 	int index_version;
 	time_t mtime;
diff --git a/packfile.c b/packfile.c
index 89220f0e03..70acf1694b 100644
--- a/packfile.c
+++ b/packfile.c
@@ -186,7 +186,7 @@ int load_idx(const char *path, const unsigned int hashsz, void *idx_map,
 		     */
 		    (sizeof(off_t) <= 4))
 			return error("pack too large for current definition of off_t in %s", path);
-		p->crc_offset = 8 + 4 * 256 + nr * hashsz;
+		p->crc_offset = st_add(8 + 4 * 256, st_mult(nr, hashsz));
 	}

 	p->index_version = version;
--
2.41.0.329.g0a1adfae833
--- >8 ---

Thanks,
Taylor
