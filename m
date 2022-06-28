Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 310B2C43334
	for <git@archiver.kernel.org>; Tue, 28 Jun 2022 19:29:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232357AbiF1T31 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jun 2022 15:29:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232601AbiF1T2m (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Jun 2022 15:28:42 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 293171A81D
        for <git@vger.kernel.org>; Tue, 28 Jun 2022 12:26:12 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id n12so12948520pfq.0
        for <git@vger.kernel.org>; Tue, 28 Jun 2022 12:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IoDl6S2XMfZLn0FqkcPVB60AgaD4yXJO8fW62t3sXQE=;
        b=AWgm5VD26cRm7f75ZxYR5gUfgDkfpT5D1yBfx/9WA9Mxtcaf2NA1EBvNZS8Dh7uymZ
         UcuRcl7E3R+PiKcFlTPV1cz4ha/z8jFdjsObNi/7RWtVrovKsDQfoVybOYeyyywJ6DVf
         fJ2hiL7Vr8XbJzL7YK3VVX+HemShcOoQfxZ+H68OwAIZDh0Va1+n3AMzIk+oqlCI/8ic
         FKeSBZZDugFGiQfp7uh9asIvkhyeuDSiO+FOk3fv1AifMIYAEIkQKd4CH5i5WvP4ktwN
         AoBQKTpmbyXoLhSeqiWzaWBQ1ycruWnuZPzWj5u0AUNezlueOeFDw3iL5+BVDJ5DF3vU
         vAbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IoDl6S2XMfZLn0FqkcPVB60AgaD4yXJO8fW62t3sXQE=;
        b=KbgOSh+zbWsLPldCuDNebUA1ef5+75woW7amuMroKArVLqsjvB+WKH6BxYvXL/jiRe
         yECaBOM+ghfh+TMfLlpt8iRS+XL6SzATLPVv5DFh5WH3irGTENV/RlgGEAKJQ4eBJwFy
         h3HrZfoMCUU7n1PP/KkgCzEoZhm3BC1iDVmwfWnNzKZYj/4sHp0t/iHPIlFVSGrL+KQI
         0EAyxS6nSDWi12FE+nMq25zrpP+ePE6PeWG9depkbAr3clO8xLaoWus5sY5yJFW/aiPA
         Z1eeM7W+qmrJS1nx0Wb2EETjXZZxElFGtnN5UZD+COov2OkulDEW7CeaqCMLaZgAJ2CV
         3u9A==
X-Gm-Message-State: AJIora/HvYueN2iNwKQsVqmW978kiPX0tJ96o2YunJJPBzkP5zmkYUKs
        +ZVna62EydTMuVIbjU07jW0=
X-Google-Smtp-Source: AGRyM1tU4NTsJ/j6e3C24yCufPuFW+1/zrN1711cqDmawintVWbSpLX4DuIH4+O6OB690T9lVs2p4Q==
X-Received: by 2002:a63:a53:0:b0:411:1ba6:e5f with SMTP id z19-20020a630a53000000b004111ba60e5fmr7945211pgk.18.1656444371338;
        Tue, 28 Jun 2022 12:26:11 -0700 (PDT)
Received: from localhost.localdomain ([202.142.80.21])
        by smtp.gmail.com with ESMTPSA id c126-20020a621c84000000b005252defb016sm9858588pfc.122.2022.06.28.12.26.08
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 28 Jun 2022 12:26:10 -0700 (PDT)
From:   Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>,
        Git <git@vger.kernel.org>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v2 4/6] pack-bitmap: prepare to read lookup table extension
Date:   Wed, 29 Jun 2022 00:55:55 +0530
Message-Id: <20220628192555.23565-1-chakrabortyabhradeep79@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <YrojV5aYCzxXlV3c@nand.local>
References: <YrojV5aYCzxXlV3c@nand.local>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Ohh, sorry! Looks like I missed this comment!

Taylor Blau <me@ttaylorr.com> wrote:

> It may be worth replacing "within map" to "within the memory mapped
> region `map`" to make clear that this points somewhere within the mmap.

Ok.

> I should have commented on this in an earlier round, but I wonder what
> the behavior should be when we have BITMAP_OPT_LOOKUP_TABLE in our
> flags, but GIT_TEST_READ_COMMIT_TABLE is disabled.
>
> Right now, it doesn't matter, since there aren't any flags in bits above
> BITMAP_OPT_LOOKUP_TABLE. But in the future, if there was some
> BITMAP_OPT_FOO that was newer than BITMAP_OPT_LOOKUP_TABLE, we would
> want to be able to read it without needing to read the lookup table.
>
> At least, I think that should be true, though I would be interested to
> hear if anybody has a differing opinion there.

Oh right! I didn't think about it. In that case, we should still subtract
The table size from the last index_size. In that way, These sections will
Not be overlapped.

> And table_size here is going to start off at zero, so the outer st_add()
> call isn't necessary, either. This should instead be:
>
>     size_t table_size = st_mult(ntohl(header->entry_count),
>                                 sizeof(uint32_t) + sizeof(uint64_t) + sizeof(uint32_t));
>
> It might be nice to have triplet_sz #define'd somewhere else, since
> there are a handful of declarations in this patch that are all
> identical. Probably something like:
>
>     #define BITMAP_LOOKUP_TABLE_RECORD_WIDTH (sizeof(uint32_t) + sizeof(uint64_t) + sizeof(uin32_t))
>
> or even:
>
>     /*
>      * The width in bytes of a single record in the lookup table
>      * extension:
>      *
>      *   (commit_pos, offset, xor_pos)
>      *
>      * whose fields are 32-, 64-, and 32-bits wide, respectively.
>      */
>      #define BITMAP_LOOKUP_TABLE_RECORD_WIDTH (16)

Seems perfect to me.

> if we decide to still recognize the lookup table extension without
> *reading* from it when GIT_TEST_READ_COMMIT_TABLE is unset, I think we
> should do something like:
>
>     if (git_env_bool("GIT_TEST_READ_COMMIT_TABLE", 1))
>         index->table_lookup = (void *)(index_end - table_size);
>     index_end -= table_size;
>
> ...where the subtraction on index_end happens unconditionally.

Right. Thanks!

> I wonder if we could get rid of these functions altogether and return a
> small structure like:
>
>     struct bitmap_lookup_table_record {
>         uint32_t commit_pos;
>         uint64_t offset;
>         uint32_t xor_pos;
>     };
>
> or similar.

Ok.

> Hmm. This is a little tricky to read. Here we're expecting "va" to hold
> commit_pos from below, and "vb" to be a pointer at a lookup record.
> Everything here is right, though I wonder if a comment or two might
> clarify why one is "*(uint32_t *)va" and the other is "get_be32(vb)".

Sure. Will add comments.

> Nit: let's use the bitmap_is_midx() helper here instead of looking at
> bitamp_git->midx directly.

Ok.

> First thing is to convert the commit OID we're looking for into its
> position within the corresponding pack index or MIDX file so that we can
> use it as a search key to locate in the lookup table. If we didn't find
> anything, or the commit doesn't exist in our pack / MIDX, nothing to do.
>
> > +
> > +	offset = triplet_get_offset(triplet);
> > +	xor_pos = triplet_get_xor_pos(triplet);
>
> Otherwise, record its offset and XOR "offset".

Exactly!

> We already have to get the triplets in the loop above, and then we dig
> them back out here. Would it be easier to keep track of a list of
> pointers into the mmaped region instead of looking up these triplets
> each time?

Sure. It might be a good idea. Thanks.

> > +			commit_pos = get_be32(triplet);
> > +			offset_xor = triplet_get_offset(triplet);
> > +
> > +			if (nth_bitmap_object_oid(bitmap_git, &xor_oid, commit_pos) < 0) {
>
> Should it be an error if we can't look up the object's ID here? I'd
> think so.

I also am not sure about it. Morally, I think it is better to throw
An error here.

> Do we have a good way to make sure that we're testing this code in CI?
> It *seems* correct to me, but of course, we should have a computer check
> that this produces OK results, not a human ;).

My current test file changes should test this code. As for now, the lookup
Table is enabled by default, all the existing tests that include write and
read bitmaps uses this lookup table. So, all the test case scenarios should
Pass. So, I think it is being tested in CI. Do you have a good idea to test
It better?

> Hmm. I'm not sure I follow the purpose of tweaking
> GIT_TEST_READ_COMMIT_TABLE like this with setenv(). Are we trying to
> avoid reading the lookup table? If so, why? I'd rather avoid
> manipulating the environment directly like this, and instead have a
> function we could call to fault in all of the bitmaps (when a lookup
> table exists, otherwise do nothing).

The problem was that the `test-tool bitmap list-commit` command was
Not printing any commits (the error that I notified you before). It
is because of this function. As lookup table is enabled by default,
`prepare_bitmap_git` function doesn't load each bitmap entries and
thus the below code in this function doesn't provide the bitmapped
commit list (because Hashtable didn't generated).

        kh_foreach(bitmap_git->bitmaps, oid, value, {
		printf("%s\n", oid_to_hex(&oid));
	});

So, the simplest fix I found was this. Should I make a function then
(Which you suggested here)?

Thanks :)
