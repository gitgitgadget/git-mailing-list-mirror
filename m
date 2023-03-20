Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75107C6FD1D
	for <git@archiver.kernel.org>; Mon, 20 Mar 2023 20:03:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231139AbjCTUDZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Mar 2023 16:03:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230027AbjCTUDQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Mar 2023 16:03:16 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 779EE2056B
        for <git@vger.kernel.org>; Mon, 20 Mar 2023 13:02:51 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id h11so7074702ild.11
        for <git@vger.kernel.org>; Mon, 20 Mar 2023 13:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112; t=1679342570;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HTWs/PUt06EEBTz1ChEU6aISoFhv60JKfI/pIpQ5kl0=;
        b=BPVyBxz3AKwsDqbrcMNaUbZLVfoUTxWGzAaC8pKYzD2+8DT5a/RKDGXAK6QnuSQABA
         Vzp7AwWRz52irXpJM6jwguCKNJ0L4L+X46XK0HqbFSolmnDYOJDgt9n18YDHTtzR0YDu
         jmwLRXIJ4GxeK5eMNBHdOykX6E8yL1w+MqHHHUxhnO5qtdUKYvl3Nq8bNiWT8Zr3AUaN
         mVgzHAtW62Z40OqLu/zvCbor/0yj3TFh9RXg1edyiCz6MdwVCWWGV0bxFpwozWAMBWkT
         oZ6xKur9NVQbvY9+FdAVXBJZicE5qh/asXQOThuc1aoyvZsntZ0bpkaY6pGgEVYhW1UT
         J6eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679342570;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HTWs/PUt06EEBTz1ChEU6aISoFhv60JKfI/pIpQ5kl0=;
        b=FCHtfvCm+tKCq7N3VoBKgyjL/x5tV6WTq1YLo2GCmCiPgj0tx1PQN5i6vPPKKHuXyS
         u7g4FZ8WLJ75C4fhpZ+kPMKpp27cN7XG9M6x9qWufrMcrOxKml+d0QNAnYoS2S21B2b8
         H/U1DPlcfeu+hKedRJfGyXsnFkS739Aw2xEr0maRuJwxE58Tl4fDzsPunEKaejtGRV6m
         e9oo1QESZQNIq9+gyJmiGJfFywKwQzMYFtfw3yi7uwYp4Ybn5TzNyuYqaB4QHZnI2voj
         mqeDDKqcsQsW1lIO75/ZV+vsb3R8GMlkVpv3SB86Ws08/HQCnCKvW7RrM+9gY1U1/hMH
         pU5A==
X-Gm-Message-State: AO0yUKXhEcsLMEPwSp7ZnvNMXFG6q79QJBJcvht5nn5Ts2OyYluG83+w
        WsyBMaX6K1DLAgrMWD4XROdKuh5DCS1pLxfaejv1/Q==
X-Google-Smtp-Source: AK7set97PsWHhOZGaN0zcWID5koasmkLgNgqi8kkgwhMaWnFjAcwxB+W5pjSsW+PFzJeCOXOarxL7Q==
X-Received: by 2002:a92:d249:0:b0:315:9891:85d7 with SMTP id v9-20020a92d249000000b00315989185d7mr504026ilg.16.1679342570378;
        Mon, 20 Mar 2023 13:02:50 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id w20-20020a056e0213f400b00314201bcbdfsm3021683ilj.3.2023.03.20.13.02.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 13:02:50 -0700 (PDT)
Date:   Mon, 20 Mar 2023 16:02:49 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>,
        Jeff King <peff@peff.net>
Subject: [PATCH 4/6] pack-bitmap.c: factor out manual `map_pos` manipulation
Message-ID: <0decf13869df6216914044a560d94968126836f4.1679342296.git.me@ttaylorr.com>
References: <cover.1679342296.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1679342296.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The pack-bitmap internals use a combination of a `map` and `map_pos`
variable to keep a pointer to a memory mapped region of the `.bitmap`
file, as well as the position within that file, respectively.

Reads within the memory mapped region are meant to mimic file reads,
where each read adjusts the offset of the file descriptor accordingly.
This functionality is implemented by adjusting the `map_pos` variable
after each read.

Factor out a function similar to seek() which adjusts the `map_pos`
variable for us. Since the bitmap code only needs to adjust relative to
the beginning of the file as well as the current position, we do not
need to support any "whence" values outside of SEEK_SET and SEEK_CUR.

Extracting out this operation into a separate function allows us to add
some additional safety checks, such as ensuring that adding to `map_pos`
does not overflow `size_t`, and that the resulting `map_pos` value is
in bounds of the mapped region.

The subsequent commit will rewrite all manual manipulation of the
`map_pos` variable in terms of the new `bitmap_index_seek()`.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 pack-bitmap.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/pack-bitmap.c b/pack-bitmap.c
index 1d12f90ff9..fabcf01c14 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -134,6 +134,28 @@ static struct ewah_bitmap *lookup_stored_bitmap(struct stored_bitmap *st)
 	return composed;
 }
 
+static size_t bitmap_index_seek(struct bitmap_index *bitmap_git, size_t offset,
+				int whence)
+{
+	switch (whence) {
+	case SEEK_SET:
+		bitmap_git->map_pos = offset;
+		break;
+	case SEEK_CUR:
+		bitmap_git->map_pos = st_add(bitmap_git->map_pos, offset);
+		break;
+	default:
+		BUG("unhandled seek whence: %d", whence);
+	}
+
+	if (bitmap_git->map_pos >= bitmap_git->map_size)
+		BUG("bitmap position exceeds size (%"PRIuMAX" >= %"PRIuMAX")",
+		    (uintmax_t)bitmap_git->map_pos,
+		    (uintmax_t)bitmap_git->map_size);
+
+	return bitmap_git->map_pos;
+}
+
 /*
  * Read a bitmap from the current read position on the mmaped
  * index, and increase the read position accordingly
-- 
2.40.0.77.gd564125b3f

