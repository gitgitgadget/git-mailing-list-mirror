Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85FAFC433EF
	for <git@archiver.kernel.org>; Mon, 27 Jun 2022 18:06:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240110AbiF0SGi (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Jun 2022 14:06:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236927AbiF0SGh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Jun 2022 14:06:37 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7776ADEEA
        for <git@vger.kernel.org>; Mon, 27 Jun 2022 11:06:36 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id x1-20020a17090abc8100b001ec7f8a51f5so13301237pjr.0
        for <git@vger.kernel.org>; Mon, 27 Jun 2022 11:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uh9gefa5yaw5HNx6mIGED0a6jCZn9xN6O1Zy0PCdrYM=;
        b=Kvdc2MN23ps4n5ZxX5YZ/TTzIP84vq5WyiHyewjiU8MsZxqd+7F5D6DETqr0BIJDUw
         Ugrnn+dWyCHsoUo/1hW789NHNw31/O59re+OPTq4yCOCJ/vhdQFRHwtMHXjdEBeaATOs
         sOpuJXyRyxIH1SnCaSGd7y2Fvu7MwYcfb1ZvQw+r0TWfX4gKVCf5Qm87m6yDVDzTNBcw
         wJGnNP1pg7JSRDpXUEIK7OexLw43W4AIvNl7mYimSY+oRbm9Jbjd7Bxa5l2gSgiubBbP
         IOzlDnW9iSmEKlU1b4micuGWbtLWp0bB7/FRGd8Xyqe8RNd7dUbyycqonynXdIv53EYv
         xFUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uh9gefa5yaw5HNx6mIGED0a6jCZn9xN6O1Zy0PCdrYM=;
        b=fCB74XbKJsuRZV/z6/h8wA3jo/k5iiXxCWAp9xVh31yopuVnMTHrUgx2h+hGKSuq1C
         1TuzpPf1FT1iHMMnAfKDRmzKPX+GGXXthYTvetixAYl3zv9Mp4M+xnxJKTrxtsZvxWSO
         S5xycqMY+O9MLxhaAvj8fSY6vYQ1RJHewFK8GsjME6mieni0Gco8uxd9JIwrQTNuylgT
         E/QQIq42F1ZmcMZ3mBezGkf1vGsx+4imPvrQNWyrXyMaTZDUltA3h3r9e4lUlLiqGltM
         BnADtHVkTFOhcUhvd1BCmv0jfhFJW1rzj6QjIZPfDhV9Q5VOucnR1TN4HXj1wzAKE5Hl
         uvag==
X-Gm-Message-State: AJIora/114hz1N4QrwM9DS8H/MNzlrdjA/NWAxXXVjiI2AxrAjXL4B9o
        z+q8cAnon5th+tKtKCkd1rY=
X-Google-Smtp-Source: AGRyM1s5RXcxQIMUFaRWf6OfbTzY/09Kr1QWHOYPnOh+GPEbHJiHq2xbaDVQb2ZxP/Gy+xMTsZOHpQ==
X-Received: by 2002:a17:90b:3557:b0:1ec:cd27:1ca9 with SMTP id lt23-20020a17090b355700b001eccd271ca9mr22108661pjb.148.1656353195820;
        Mon, 27 Jun 2022 11:06:35 -0700 (PDT)
Received: from localhost.localdomain ([202.142.80.81])
        by smtp.gmail.com with ESMTPSA id jf3-20020a170903268300b0016a17e5fc6esm7554039plb.104.2022.06.27.11.06.33
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 27 Jun 2022 11:06:35 -0700 (PDT)
From:   Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>,
        Git <git@vger.kernel.org>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v2 4/6] pack-bitmap: prepare to read lookup table
Date:   Mon, 27 Jun 2022 23:36:18 +0530
Message-Id: <20220627180618.16291-1-chakrabortyabhradeep79@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cebad3da-5779-5908-15d5-63d4c590c20b@github.com>
References: <cebad3da-5779-5908-15d5-63d4c590c20b@github.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <derrickstolee@github.com> wrote:

> I didn't check the previous patches, but your sign-off should be the
> last line of the message. (You are singing off on all previous content,
> and any later content is not covered by your sign-off.)

Ohhh, got it. I didn't know about it before.

> nit: This alignment should use four spaces at the end so the second phrase
> matches the start of the previous phrase. Like this:
>
>		if (flags & BITMAP_OPT_LOOKUP_TABLE &&
>		    git_env_bool("GIT_TEST_READ_COMMIT_TABLE", 1)) {
>
> Perhaps it looked right in your editor because it renders tabs as 4 spaces
> instead of 8 spaces.

I don't know why but my editor sometimes do some weird things for alignments.
I generally use VS Code. But for alignment related problems, sometimes I have
to use vi editor.

> Here, we _do_ want to keep the st_mult(). Is the st_add() still necessary? It
> seems this is a leftover from the previous version that had the 4-byte flag
> data.
>
> We set table_size to zero above. We could drop that initialization and instead
> have this after the "size_t triplet_sz" definition:
>
>			size_t table_size = st_mult(ntohl(header->entry_count),
>						    triplet_sz));

Yes, you're right. Will update.

> I expected something different: binary search on the triplets where the comparison is
> made by looking up the OID from the [multi-]pack-index and comparing that OID to the
> commit OID we are looking for.
>
> I'm not convinced that the binary search I had in mind is meaningfully faster than
> what you've implemented here, so I'm happy to leave it as you have it. We can investigate
> if that full search on the pack-index matters at all (it probably doesn't).

Good idea! Thanks!

> While there is potential that this is wasteful, it's probably not that huge,
> so we can start with the "maximum XOR depth" and then reconsider a smaller
> allocation in the future.

Ok.

> We should consider ensuring that also "size < bitmap_git->entry_count".
> Better yet, create an xor_positions_alloc variable that is initialized
> to the entry_count value.
>
> "size" should probably be xor_positions_nr.
> 
> > +			xor_positions[size++] = xor_pos;
> > +			triplet = bitmap_get_triplet(bitmap_git, xor_pos);
> > +			xor_pos = triplet_get_xor_pos(triplet);
> > +		}
> 
> (at this point, "if (xor_positions_nr >= xor_positions_alloc)", then error
> out since the file must be malformed with an XOR loop.)

Got it.

> Since we are storing the bitmap here as we "pop" the stack, should we be
> looking for a stored bitmap while pushing to the stack in the previous loop?
> That would save time when using multiple bitmaps with common XOR bases.

Yeah, I also am thinking about it. Will make a try.

Thanks :)
