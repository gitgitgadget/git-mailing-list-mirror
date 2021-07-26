Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68A98C4338F
	for <git@archiver.kernel.org>; Mon, 26 Jul 2021 18:23:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 445A260C51
	for <git@archiver.kernel.org>; Mon, 26 Jul 2021 18:23:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231603AbhGZRmz (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Jul 2021 13:42:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbhGZRmy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Jul 2021 13:42:54 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A078C061757
        for <git@vger.kernel.org>; Mon, 26 Jul 2021 11:23:23 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id u15so12980226iol.13
        for <git@vger.kernel.org>; Mon, 26 Jul 2021 11:23:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6nybRqoMvz3TbRj5Sbe3bABdhmhvCu76PZ7CpGRk/bc=;
        b=dE7Nq1CRoTVS0yB6jJZY/gC1TdGja3sT9P/mFHt9zYMBC36P8ms40TCLgAAUoyH7Go
         mfJ6dXmxkHJ3BDkulFnXc37O1991nVEeV2Ne5BsYtvhibcTDAHjN3VAukcvTFDhPpC8J
         zgJrRCXk3HdFys10RS6e6+ep+3Ii9wnztJl2eqRphYspa0UgBXU1GpI9KXlOVKWRbQAv
         gtlx1QAI1N2hIqKLC0tPtvrz1Dgcr7Zp8HYel+wXg3ixBbTsrZwtAyoKXSjnZzxFEF0q
         paqtsslf51GF6Per6P4vE1G8j+iB3C+7nPFMOl5gLmWqzt/pYsIkx1fXO9eqWaIUW/lv
         ZeHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6nybRqoMvz3TbRj5Sbe3bABdhmhvCu76PZ7CpGRk/bc=;
        b=j1pk28bNLiO1f1WWW5RJA+NxhsmDP6+KjGtQdXrs3Bvo8cISZTLt90Wbw2FMggnjBR
         7Six2IDLlXexuic3yBX6mfPQEPbN0mx/Ef8JP5AlFsEbDP1QU+h/o0brj3ojJTRqhVBY
         6O2JxL9/SpOC2soGs/dgPumtGAXUwEtZZYsk9Ht1Nn0UNAJm0DlcME91lcQ85Ky0P+vn
         tonQj2SrDeHmTC/vWLPLV1o7LiKG9swTjvnjTBApnAoRBme8lA9vVP22qwaTsUXe8DlC
         PwmE2F3kX/Jih/8tZ+pyFD9sCeIYtkZjYKMqWEb3O0iQ2/CDjGRDQoG2QTJCPQF8lw/k
         VbHQ==
X-Gm-Message-State: AOAM532oXG+b/aZLzmueWKJYO0Yg3X/g4LFpT0DMtm9jbbKNDHXSfQhu
        gr8mAjSS97v55NB+bUyJm8cJSw==
X-Google-Smtp-Source: ABdhPJxrHKJ7MgWmMnbLuvGwWmLF9DIvcKONTsNGjjSO1igSDXQaUuetJ/T/8qKJrY2BYgW4LYP35g==
X-Received: by 2002:a6b:c812:: with SMTP id y18mr11747268iof.3.1627323802545;
        Mon, 26 Jul 2021 11:23:22 -0700 (PDT)
Received: from localhost ([2600:1700:d843:8f:18ae:76f8:f6b8:4b88])
        by smtp.gmail.com with ESMTPSA id w21sm329829iol.52.2021.07.26.11.23.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jul 2021 11:23:21 -0700 (PDT)
Date:   Mon, 26 Jul 2021 14:23:21 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, dstolee@microsoft.com, gitster@pobox.com,
        jonathantanmy@google.com
Subject: Re: [PATCH v2 14/24] pack-bitmap: write multi-pack bitmaps
Message-ID: <YP79mSWIfJWtIw2B@nand.local>
References: <cover.1617991824.git.me@ttaylorr.com>
 <cover.1624314293.git.me@ttaylorr.com>
 <a8cec2463d0993b1118abdd31cb6c9e88a32e0c4.1624314293.git.me@ttaylorr.com>
 <YPgObwXjt/tzAJvV@coredump.intra.peff.net>
 <YP77DiffrCrxunvg@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YP77DiffrCrxunvg@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 26, 2021 at 02:12:30PM -0400, Taylor Blau wrote:
> So we do have to keep it open there. Which makes me wonder how this
> could possibly work on Windows, because holding the MIDX open will make
> the commit_lock_file() definitely fail. But it seems OK in the
> Windows-based CI runs?
>
> Puzzled.

The below should do the trick; it'll keep the MIDX open just long enough
to generate a bitmap (if one was requested), but will close any
handle(s) on an existing MIDX right before we move the temporary file
into place.

It has the added benefit of making that hunk about destroying stale
references to packs be unnecessary.

Watching the Actions run here to see how this runs on Windows:

    https://github.com/ttaylorr/git/actions/runs/1068457013

Below is the patch.

--- >8 ---

commit c7b7ce0ebc793e311072929772a2d352600f3d54
Author: Taylor Blau <me@ttaylorr.com>
Date:   Mon Jul 26 14:17:27 2021 -0400

    fixup! pack-bitmap: write multi-pack bitmaps

diff --git a/midx.c b/midx.c
index 76c94a0df2..297627f992 100644
--- a/midx.c
+++ b/midx.c
@@ -1358,6 +1358,8 @@ static int write_midx_internal(const char *object_dir, struct multi_pack_index *
 		}
 	}

+	close_midx(ctx.m);
+
 	commit_lock_file(&lk);

 	clear_midx_files_ext(the_repository, ".bitmap", midx_hash);
@@ -1368,15 +1370,6 @@ static int write_midx_internal(const char *object_dir, struct multi_pack_index *
 		if (ctx.info[i].p) {
 			close_pack(ctx.info[i].p);
 			free(ctx.info[i].p);
-			if (ctx.m) {
-				/*
-				 * Destroy a stale reference to the pack in
-				 * 'ctx.m'.
-				 */
-				uint32_t orig = ctx.info[i].orig_pack_int_id;
-				if (orig < ctx.m->num_packs)
-					ctx.m->packs[orig] = NULL;
-			}
 		}
 		free(ctx.info[i].pack_name);
 	}
@@ -1386,7 +1379,6 @@ static int write_midx_internal(const char *object_dir, struct multi_pack_index *
 	free(ctx.pack_perm);
 	free(ctx.pack_order);
 	free(midx_name);
-	close_midx(ctx.m);

 	return result;
 }
