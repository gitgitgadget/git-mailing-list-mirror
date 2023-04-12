Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCFBDC77B6E
	for <git@archiver.kernel.org>; Wed, 12 Apr 2023 18:39:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230040AbjDLSjA (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Apr 2023 14:39:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbjDLSil (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Apr 2023 14:38:41 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C527100
        for <git@vger.kernel.org>; Wed, 12 Apr 2023 11:37:58 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-54f6a796bd0so121261517b3.12
        for <git@vger.kernel.org>; Wed, 12 Apr 2023 11:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112; t=1681324675; x=1683916675;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YU+ctGmGBm++N6QPWokMXkaUnfBqV8r9ztUPsW2xGKQ=;
        b=td4qLwHvVtm44jkEQCJXo+t52+dMUT3I08LjeO2i4yYtbY5Ys4JARVzvbtTtSEGcqF
         GRgPc3zr6WyDV1XypUGE6JuCmvVxR/Oh7kcztAfBJklC4gQTL59yz3VSMnI84B2114g9
         GeVPRghpKOjNZcfZ3orC2/MV4j3TQkb28WZBI+UUPMPrbiJnDmm6CfaYSro5S7BM2d1J
         khQJkJHvsugtDT5QNYkaeGHQF1OmpdIrX4tpzBYm1xlNxdMelDC2vQ6ijhQKJgUOG8ff
         Xj/KEGsvHa4vdChmBDRmPhCLphI4/1H51DZ9O2QBwVp/PsfA0XofiL/OnEc5LnC9JSr4
         00PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681324675; x=1683916675;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YU+ctGmGBm++N6QPWokMXkaUnfBqV8r9ztUPsW2xGKQ=;
        b=H7o/lKsLV+UlgTjWcewe51pHv8YP6QrBDAK0+rsFh/wdymVTVpXnjyl6l0yhTjfdBD
         Hat2KnffRKfRpBQ8a3/kMQDMpdMbIB3Tg+gMUqvWKP+pTvLz2CMlbZAD4lVXH7NTo7MD
         V0J2K9SH++q9fWhLhC3lR4235X8vFC4xs4YoTKfPH/IKxwl5hSmCtWsPplV//fdXVMJJ
         Dx8ubBHn7X//uDmkzH/7QNxdNj9GUKePd0lCqC/s3crZgUUfnuVLRiFVT/ddHlxX0Sdw
         gba59a5047a4flneJQT6NjgSH+e79JOucSbEwYhRDJXpo9TIukhIBQx4cD95IWL5au1u
         WnKQ==
X-Gm-Message-State: AAQBX9dUDk3RHS5eQhqOpEbt/RLLK4bn83B9EFhyWFI9nhcLOVWkpe+n
        at+FQ1l64XrQkFC5HusqNFsK/vCGubWZ4RXgW6o/PA==
X-Google-Smtp-Source: AKy350Z+EYySZgMd/5CqPawFWm5kQhCQxVamiuDPZp+bgsQY3T2h2qi1883OrLFv32FRw4Gb5Pfaww==
X-Received: by 2002:a81:6f8b:0:b0:54f:9cd0:990 with SMTP id k133-20020a816f8b000000b0054f9cd00990mr2485072ywc.18.1681324675323;
        Wed, 12 Apr 2023 11:37:55 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id cm21-20020a05690c0c9500b00545c81c9f38sm295722ywb.115.2023.04.12.11.37.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 11:37:54 -0700 (PDT)
Date:   Wed, 12 Apr 2023 14:37:53 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org, peff@peff.net, dstolee@microsoft.com
Subject: Re: [PATCH v2 2/8] repack: fix trying to use preferred pack in
 alternates
Message-ID: <ZDb6gZycwTdsaB6o@nand.local>
References: <a07ed50feeec4bfc3e9736bf493b9876896bcdd2.1680606445.git.ps@pks.im>
 <cover.1681294715.git.ps@pks.im>
 <011b08f3b64f264e3abbe8b49ee5338c221badb9.1681294715.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <011b08f3b64f264e3abbe8b49ee5338c221badb9.1681294715.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 12, 2023 at 12:22:35PM +0200, Patrick Steinhardt wrote:
> When doing a geometric repack with multi-pack-indices, then we ask
> git-multi-pack-index(1) to use the largest packfile as the preferred
> pack. It can happen though that the largest packfile is not part of the
> main object database, but instead part of an alternate object database.
> The result is that git-multi-pack-index(1) will not be able to find the
> preferred pack and print a warning. It then falls back to use the first
> packfile that the multi-pack-index shall reference.
>
> Fix this bug by only considering packfiles as preferred pack that are
> local. This is the right thing to do given that a multi-pack-index
> should never reference packfiles borrowed from an alternate.
>
> While at it, rename the function `get_largest_active_packfile()` to
> `get_preferred_pack()` to better document its intent.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>

> @@ -464,7 +466,16 @@ static struct packed_git *get_largest_active_pack(struct pack_geometry *geometry
>  	}
>  	if (geometry->split == geometry->pack_nr)
>  		return NULL;
> -	return geometry->pack[geometry->pack_nr - 1];
> +
> +	for (i = geometry->pack_nr; i > 0; i--)
> +		/*
> +		 * A pack that is not local would never be included in a
> +		 * multi-pack index. We thus skip over any non-local packs.
> +		 */
> +		if (geometry->pack[i - 1]->pack_local)
> +			return geometry->pack[i - 1];
> +
> +	return NULL;
>  }

Looking good, we want to go through this list in reverse order, since
the packs are ordered largest to smallest. I think that you could
slightly rewrite the loop condition to avoid having to always access
`geometry->pack` at `i-1` instead of `i`, like so:

--- 8< ---
diff --git a/builtin/repack.c b/builtin/repack.c
index 9d36dc8b84..ba468ac44e 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -467,13 +467,15 @@ static struct packed_git *get_preferred_pack(struct pack_geometry *geometry)
 	if (geometry->split == geometry->pack_nr)
 		return NULL;

-	for (i = geometry->pack_nr; i > 0; i--)
+	for (i = geometry->pack_nr - 1; i >= 0; i--) {
 		/*
 		 * A pack that is not local would never be included in a
 		 * multi-pack index. We thus skip over any non-local packs.
 		 */
-		if (geometry->pack[i - 1]->pack_local)
-			return geometry->pack[i - 1];
+		struct packed_git *p = geometry->pack[i];
+		if (p->pack_local)
+			return p;
+	}

 	return NULL;
 }
--- >8 ---

but I'm not sure that the loop condition is quite right to begin with.
We don't want to iterate all the way down to the beginning of the pack
list, since some of those packs may be below the "split" line, IOW their
contents are going to be rolled up and the packs destroyed.

So I think the right loop condition would be:

    for (i = geometry->pack_nr - 1; i >= geometry->split; i--)

which I think makes the "if (geometry->split == geometry->pack_nr)"
condition above redundant with this loop, so you could probably drop
that.

I would definitely appreciate a second set of eye here. The pack *at*
the split line is considered frozen (IOW, we create a new pack
consisting of the packs in range [0, geometry->split), and leave the
packs in range [geometry->split, geometry->nr) alone).

So it should be fine to enter that loop when "i == geometry->split",
because it's OK to return that as a potential preferred pack.

> +test_expect_success '--geometric --write-midx with packfiles in main and alternate ODB' '
> +	test_when_finished "rm -fr shared member" &&

Looks familiar ;-).

> +	# Create a shared repository that will serve as the alternate object
> +	# database for the member linked to it. It has got some objects on its
> +	# own that are packed into a single packfile.
> +	git init shared &&
> +	test_commit -C shared common-object &&
> +	git -C shared repack -ad &&
> +
> +	# We create member so that its alternates file points to the shared
> +	# repository. We then create a commit in it so that git-repack(1) has
> +	# something to repack.
> +	# of the shared object database.
> +	git clone --shared shared member &&
> +	test_commit -C member unique-object &&
> +	git -C member repack --geometric=2 --write-midx 2>err &&
> +	test_must_be_empty err &&
> +
> +	# We should see that a new packfile was generated.
> +	find shared/.git/objects/pack -type f -name "*.pack" | sort >packs &&

Do we need a sort here? I don't think we rely on the order anywhere, and
it looks like we only care that there is a single entry.

If that's the case, I think we could replace the wc invocation here
with:

    test_line_count = 1 packs

> +	test $(wc -l <packs) = 1 &&
> +
> +	# We should also see a multi-pack-index. This multi-pack-index should
> +	# never refer to any packfiles in the alternate object database.
> +	# Consequentially, it should be valid even with the alternate ODB
> +	# deleted.
> +	rm -r shared &&
> +	git -C member multi-pack-index verify

To test this even more directly, I think that you could ensure that the
set of packs (which should just be the single entry found in "packs"
above) matches what we expect. That should look something like:

    test-tool read-midx member/.git/objects >packs.midx &&
    grep "^pack-.*\.idx$" packs.midx | sort >actual &&
    xargs -n 1 basename <packs | sort >expect
    test_cmp expect actual

Note that the read-midx test helper outputs packs with the "*.idx"
suffix, so you'd probably want to alter your find invocation a few lines
above accordingly, or rewrite it before writing into "actual".

Alternatively, since we expect there to be just a single pack here, I
think we could just as easily write something like:

    test-tool read-midx member/.git/objects >packs.midx &&
    grep "^pack-.*\.idx$" packs.midx >actual &&
    test_line_count = 1 actual &&
    grep $(cat actual) packs

though I slightly prefer the former since it is less brittle to changing
this test. Either way, though.

Thanks,
Taylor
