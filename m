Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01199C433EF
	for <git@archiver.kernel.org>; Tue, 28 Jun 2022 09:00:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242888AbiF1JAL (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jun 2022 05:00:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232339AbiF1JAK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Jun 2022 05:00:10 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 515D7EB3
        for <git@vger.kernel.org>; Tue, 28 Jun 2022 02:00:09 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id x138so8743825pfc.3
        for <git@vger.kernel.org>; Tue, 28 Jun 2022 02:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vMF2z65KR6aMSYEGRkpTx8kVnFq9pw6R/JlbPmmlMAI=;
        b=Jm9XpDz9T+l3w9zaEsD+n63ADZD6vNoc5yukgfrUy2Hxw8+JWf07TgXPfNRW5WtIsZ
         kmZ+kgwxSbj8qsRws/oc4gDTJj24duM6S2ejQfu/DGSPavs1AbNy46xSGrToSPlnhGXV
         kERsQLVmV9SBX8I+kD8VtkVn4jDXt7AQpRzvzahBaj6hXGQPK97Kw+C46yzDLv4+xPzx
         qNG5X/Q60DiO0lTe9KsLjeq7ccD7KwJvoGtfzboLlxLwGeuDNLNdwvVscUAaOV666GwZ
         I2iGri4ahJaW4tmtF38WVW+PB/YY7dLi3Y4es59lLHGRb0pH2JWxCMM6IJaJiDOXKZIB
         hQIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vMF2z65KR6aMSYEGRkpTx8kVnFq9pw6R/JlbPmmlMAI=;
        b=Z8byVx+43zfTerqjkjBwfiXKTu42iShNT8htSkLs3WciuomHxgBI7oVp3IOPHPNHhE
         u+95WebExpwBYauXhp6eX3I5YQuajZ2FC6lbeczaMfZVoMFC4Ul3KGcfU+nZQx25612s
         1mYEEQ06FFgePNv25oBUSjEJxC/hJ3uqLfmrrLtN/LZKpILok1ZGJdW/5sNqKd1arhCS
         uViB3jxxJLCXRQueu9nJEgth+X60KyizAN5f+DE2E8zEtsUnYApHyDvg+MKVJuREeT2y
         u0cEzVCh3yOf9qgvrjQl/6mzKXBq3OMiIw1xhBUxfQGPeKWzgqQFLcSzLZDDS4cr0Dtr
         2FUQ==
X-Gm-Message-State: AJIora/+JPHMZ6A7PDHnsaLsFgxlZnZcVgLn1izNNSAVhmX6mGRircBR
        Wo5S8eb2CFEwkb0fvWu1iCo=
X-Google-Smtp-Source: AGRyM1vg7jVQyKtLV05mKmU3wK5+k9HqkwS3M606yuIJKuYr/v6RFuduBJQ+zUi8tQV0/jHqF1Rrgg==
X-Received: by 2002:aa7:9a88:0:b0:525:124f:5276 with SMTP id x8-20020aa79a88000000b00525124f5276mr3691563pfi.42.1656406808669;
        Tue, 28 Jun 2022 02:00:08 -0700 (PDT)
Received: from localhost.localdomain ([202.142.80.21])
        by smtp.gmail.com with ESMTPSA id g26-20020aa7819a000000b0052548b87bd1sm8812380pfi.46.2022.06.28.02.00.04
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 28 Jun 2022 02:00:08 -0700 (PDT)
From:   Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>,
        Git <git@vger.kernel.org>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v2 4/6] pack-bitmap: prepare to read lookup table
Date:   Tue, 28 Jun 2022 14:29:50 +0530
Message-Id: <20220628085950.19288-1-chakrabortyabhradeep79@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <Yrol2tY4emxmYh9n@nand.local>
References: <Yrol2tY4emxmYh9n@nand.local>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> wrote:

> ...exactly my thoughts, too. It's possible that it would be faster to
> key this search on the object_id "oid" above, and then convert each of
> the entries in the lookup table from a uint32_t into an object_id by
> calling nth_bitmap_object_oid() repeatedly.
>
> I *think* that what Abhradeep wrote here is going to be faster more
> often than not since it makes more efficient use of the page cache
> rather than switching between reads across different memory mapped
> regions at each point in the binary search.
>
> But of course that depends on a number of factors. Abhradeep: if you're
> up for it, I think it would be worth trying it both ways and seeing if
> one produces a meaningful speed-up or slow-down over the other. Like I
> said: my guess is that what you have now will be faster, but I don't
> have a clear sense that that is true without trying it both ways ;-).

Ok. Let me try both the ways. In my opinion, I think my version has
less searching and less computation. So, I want to stick with this
version. But I also like to try the other one once so that we can
get the best out of these two.

> I think starting off with a small array and then letting it grow
> according to alloc_nr() would be fine here, since it will grow more and
> more each time, so the amount of times we have to reallocate the buffer
> will tail off over time.

What should be the size of that array?

> If we were really concerned about it, we could treat the buffer as a
> static pointer and reuse it over time (making sure to clear out the
> portions of it we're going to reuse, or otherwise ensuring that we don't
> read old data). But I doubt it matters much either way in practice: the
> individual records are small (at just 4 bytes each) and entry_count is
> often less than 1,000, so I think this probably has a vanishingly small
> impact.

Before submitting it to the mailing list, I did use the ALLOC_GROW macro
function. But my version was worse than yours. For every iteration I was
reallocating the array to support `size+1` positions. But later I drop
the code as this might be very much expensive.

Then I wrote this code. As `table` array and `table_inv` array allocate
this size of arrays (though all the indices are used), I thought it
would not be a problem if I use an array of this size for a small amount
of time.

Honestly, I don't like to realloc arrays. Because as far as I can remember,
realloc allocates a new array internally and copies the items from the old
array to the new array. This irritates me.

But at the same time, it is also true that in most cases we might not need
this amount of space.

Thanks :)
