Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C544C43334
	for <git@archiver.kernel.org>; Tue, 21 Jun 2022 11:52:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350111AbiFULwl (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Jun 2022 07:52:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348880AbiFULwk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Jun 2022 07:52:40 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAC3F2AC66
        for <git@vger.kernel.org>; Tue, 21 Jun 2022 04:52:38 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id cv13so10129928pjb.4
        for <git@vger.kernel.org>; Tue, 21 Jun 2022 04:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qbIbQRqI54/pO2BEvTvxXVMnnbgpDJZu/+UQphrNEBM=;
        b=XOowqEi1hF5dVFxKtpw0BJdDW021q3DNPfDqb+XUr6LuAIUSbg9Ga/jXQDlG+S8TTT
         YG1VDj/KMHjupcSviRTM4M7389hcUTyTF89DX0Hnfc7BR4ZTmPebPIILsITIVshyIqHd
         Gi3cLdkstIw6TvBJfJ7s6hSXCCzv3Dq3k31XS5wLgzLtW1rglCe0wXlgr8xT+HPMlzKe
         fJpBzru7A9kJVZrmzwkx/OmWMdlx5/D1GbNaxx7rj2CP3gZCiQXVjm73IHqaUgjReSOm
         BmHc0nNOVDEM6miqOWe1pzPI+MGrJQpD9LJ0voDK9uk/AXdzuaNyUUyXpmPp5rr1uXDS
         yY9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qbIbQRqI54/pO2BEvTvxXVMnnbgpDJZu/+UQphrNEBM=;
        b=b2aMG86LTa6SAZ6jY8t1BYBZuSqlmohK3o5whsM1RSGijIa4ARYyf/2udP9JkczbSF
         YYA7+d3INIW2WbQhacwaV4h4nOjbmN+aFQs+v4mrp2ztstEYmCIUPLlHdjVmBNy4uZNT
         IxCVZkFCArd2dBjsWh2si+yhhcsb82gfWDsA1xuauaN+oGRQOiOtmLVjydhp/le05Xyp
         qx2vUpmAiu2GsRx6647nZmobOvA2paeSrS1FdXSiJAW4WGjdt+tL3i7q/3AzrdUJnEtl
         vbEYFZa+fyRsE3dI4CxWuexJksqvrhew66+2tYmNB7KNXtxpm+RxYk+gh32tKNw/JwOl
         kH4Q==
X-Gm-Message-State: AJIora+OzQWlYG0H3yXvfNON5Nynpr4eYF5ZrKqxGNjI2zmZ0Vn5ywUU
        kQoD0upyr3GpI+WRWTiuUt7IUVbhLrQ=
X-Google-Smtp-Source: AGRyM1sC1Drwkc1x5kBHzmAM8HbuJ3XgV/ZrTlKDtNVcgsSviyMHYNRSacI14ugE95DtI8GjfX63jQ==
X-Received: by 2002:a17:90b:4ac1:b0:1e6:7c82:9aee with SMTP id mh1-20020a17090b4ac100b001e67c829aeemr42964006pjb.234.1655812358184;
        Tue, 21 Jun 2022 04:52:38 -0700 (PDT)
Received: from localhost.localdomain ([202.142.80.189])
        by smtp.gmail.com with ESMTPSA id bo9-20020a056a000e8900b0051bbe085f16sm10785240pfb.104.2022.06.21.04.52.34
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 21 Jun 2022 04:52:37 -0700 (PDT)
From:   Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>,
        Git <git@vger.kernel.org>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 2/6] pack-bitmap: prepare to read lookup table extension
Date:   Tue, 21 Jun 2022 17:22:12 +0530
Message-Id: <20220621115212.22383-1-chakrabortyabhradeep79@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <YrDvaMHz9DnjBqLs@nand.local>
References: <YrDvaMHz9DnjBqLs@nand.local>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> wrote:

> What is the purpose of the GIT_READ_COMMIT_TABLE environment variable? I
> assume that it's to make it easier to run tests (especially performance
> ones) with and without access to the lookup table. If so, we should
> document that (lightly) in the commit message, and rename this to be
> GIT_TEST_READ_COMMIT_TABLE to indicate that it shouldn't be used outside
> of tests.

This is mainly for testing, GIT_TEST_READ_COMMIT_TABLE is perfect.


> All makes sense. Some light documentation might help explain what this
> comparator function is used for (the bsearch() call below in
> bitmap_table_lookup()), although I suspect that this function will get
> slightly more complicated if you pack the table contents as I suggest,
> in which case more documentation will definitely help.

Ok.

> Interesting; this is a point that I forgot about from the original
> patch. xor_pos is an index (not an offset) into the list of commits in
> the table of contents in the order appear in that table. We should be
> clear about (a) what that order is, and (b) that xor_pos is an index
> into that order.

This is exactly what I said in my first reply. I made a mistake here.
(1) As xor_pos is relative to the current bitmap, it depends on the bitmap
entry order. These two order are not same. One is ordered by date, another
is lexicographically ordered. I will fix it.

> Yeah. The problem here is that we can't record every commit that
> _doesn't_ have a bitmap every time we return NULL from one of these
> queries, since there are arbitrarily many such commits that don't have
> bitmaps.
>
> We could approximate it using a Bloom filter or something, and much of
> that code is already written and could be interesting to try and reuse.
> But I wonder if we could get by with something simpler, though, which
> would cause us to load all bitmaps from the lookup table after a fixed
> number of cache misses (at which point we should force ourselves to load
> everything and just read everything out of a single O(1) lookup in the
> stored bitmap table).
>
> That may or may not be a good idea, and the threshold will probably be
> highly dependent on the system. So it may not even be worth it, but I
> think it's an interesting area to experiemnt in and think a little more
> about.

Now I got the point. I wonder what if we leave it as it is. How much will
it affect the code?

> How does this commit_pos work again? I confess I have forgetten since I
> wrote some of this code a while ago... :-).

It is using recursive strategy. The first call to `stored_bitmap_for_commit`
function do not have `pos_hint`. So, it uses `bitmap_table_lookup` to find
the commit position in the list and makes a call to `lazy_bitmap_for_commit`
function. This function gets the offset and xor-offset using the commit id's
position in the list. If xor-offset exists, it is using this xor-offset to
get the xor-bitmap by calling `stored_bitmap_for_commit` again. But this time
`pos_hint` is xor-offset. This goes on till the last non-xor bitmap has found.

As I said before, xor-offset should be an absolute value to make it work
correctly.

> Should we print this regardless of whether or not there is a lookup
> table? We should be able to learn the entry count either way.

No, this is necessary. "Bitmap v1 test (%d entries loaded)" means
all the bitmap entries has been loaded. It is basically for 
`load_bitmap_entries_bitmap_v1` function which loads all the bitmaps
One by one. But if there is a lookup table, `prepare_bitmap_git`
function will not load every entries and thus printing the above
line is wrong.

Thanks :)
