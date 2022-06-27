Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 275FBC433EF
	for <git@archiver.kernel.org>; Mon, 27 Jun 2022 15:48:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237674AbiF0Pss (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Jun 2022 11:48:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239289AbiF0Psa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Jun 2022 11:48:30 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F204818B34
        for <git@vger.kernel.org>; Mon, 27 Jun 2022 08:48:28 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id q4so15275148qvq.8
        for <git@vger.kernel.org>; Mon, 27 Jun 2022 08:48:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=rf3t0gAtQye0JfWkPkDaJ93degleWbOYEMiFy7BCaC0=;
        b=CDGE1QFW3GNwRT9Zw8Scw5szY83JYfyWvlLzFziPT/R3N3v3AJgM1LAsh334pSL02U
         opVy917le3ARouCjasQD3efmzDD8AdjhYJxbVFX5B2BxmtwgCIgX+O7wvK+bBMkg9CHP
         CG61CHz05zK/2dkS14xacmdNTxZ+RVkoaz9xoyUBryN7FkcnPTe9Wuu1RCxD+qiwf/a2
         8MFCPYlxpkPOatBZt0YKwVi5bMINSmLpo9AIdqKMM1x/aQdk9oGiIgapI6DgSJuoowkL
         04NpuCPaGfcOGsWrVh0SSlzGrD3GxXsnWNuLC+Q0Bmuf7GIBhUFqNAbsNgBy8Ylb1bb7
         Q5vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rf3t0gAtQye0JfWkPkDaJ93degleWbOYEMiFy7BCaC0=;
        b=I7Trv/Vr5W6ZT9g1pNUZGXvMNO5e1wQ22hIOIJfmmoclaUOmSQcAcNcJmgnm/JRFKZ
         ms/njNn88CiOBlLqtKLgXJiWoJZlKBsjdFhSQZOdMfn2BLh3pYBBWa/hUIINbGPSFaxV
         yi/f43uDms4a7l3O60qf0U+W57wEVzAwFWO3XoEywnE3CE6iKn3N1Ls4y9KVA9gNcHzz
         kz4n8w8y3k4U0DgMtf5rMzDMDZaWBsBZ5ZyHqjQpRksgN12Ogtl8kV5lZWRzSKjt03Es
         QlUsX3yhmSwWaB53xkMbusYlbI0pvmH0N5uDia4GeYVlIXLTN4T+MMhaumWGa3AdAB8o
         6aFw==
X-Gm-Message-State: AJIora8+9R2aa1WOrLrjXokWfJPS7gO+uVXSRS96spacogeFEGhmTPGl
        7REEXD+tbNRu5zZRxfv+ap8GiQ==
X-Google-Smtp-Source: AGRyM1sO1Kfa2JnnUVUWhOxzZFpSXCufhyUUUgLMZ3T6acqHR4MB1GkF9yj47SrMVaRf6W+mvqtgDQ==
X-Received: by 2002:a05:622a:1994:b0:304:f463:148c with SMTP id u20-20020a05622a199400b00304f463148cmr9664356qtc.358.1656344908069;
        Mon, 27 Jun 2022 08:48:28 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id x11-20020a05620a448b00b006a768c699adsm9386995qkp.125.2022.06.27.08.48.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 08:48:27 -0700 (PDT)
Date:   Mon, 27 Jun 2022 11:48:26 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Abhradeep Chakraborty via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Kaartic Sivaram <kaartic.sivaraam@gmail.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Subject: Re: [PATCH v2 1/6] Documentation/technical: describe bitmap lookup
 table extension
Message-ID: <YrnRSv64nppGldF2@nand.local>
References: <pull.1266.git.1655728395.gitgitgadget@gmail.com>
 <pull.1266.v2.git.1656249017.gitgitgadget@gmail.com>
 <4d11be66cfa2cd667df56ab9260903a37900bd4c.1656249017.git.gitgitgadget@gmail.com>
 <b2c947c6-b33b-066e-a578-65f769ef4f75@github.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b2c947c6-b33b-066e-a578-65f769ef4f75@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 27, 2022 at 10:18:51AM -0400, Derrick Stolee wrote:
> On 6/26/2022 9:10 AM, Abhradeep Chakraborty via GitGitGadget wrote:
> > +			triplets. The format and meaning of the table is described
> > +			below.
> > ++
> > +NOTE: This xor_offset is different from the bitmap's xor_offset.
> > +Bitmap's xor_offset is relative i.e. it tells how many bitmaps we have
> > +to go back from the current bitmap. Lookup table's xor_offset tells the
> > +position of the triplet in the list whose bitmap the current commit's
> > +bitmap have to xor with.
>
> I found this difficult to parse. Here is an attempt at a rewording. Please
> let me know if I misunderstood something when reading your version:
>
>   NOTE: The xor_offset stored in the BITMAP_OPT_LOOKUP_TABLE is different
>   from the xor_offset used in the bitmap data table. The xor_offset in this
>   table indicates the row number within this table of the commit whose
>   bitmap is used for the XOR computation with the current commit's stored
>   bitmap to create the proper logical reachability bitmap.
>
> This does make me think that "xor_offset" should really be "xor_row" or
> something like that.

To be fair, I found Stolee's version equally difficult to parse. I
wonder if something like the following would be clearer:

    NOTE: Unlike the xor_offset used to compress an individual bitmap,
    this value stores an *absolute* index into the lookup table, not a
    location relative to the current entry.

> > +For a `.bitmap` containing `nr_entries` reachability bitmaps, the table
> > +contains a list of `nr_entries` <commit pos, offset, xor offset> triplets.
> > +The content of i'th triplet is -
> > +
> > +	* {empty}
> > +	commit pos (4 byte integer, network byte order): ::
> > +	It stores the object position of the commit (in the midx or pack index)
> > +	to which the i'th bitmap in the bitmap entries belongs.
>
> Ok, we are saving some space here, but relying on looking into the pack-index
> or multi-pack-index to get the actual commit OID.
>
> Since this is sorted by the order that stores the bitmaps, binary search will
> no longer work on this list (unless we enforce that on the rest of the bitmap
> file). I am going to expect that you parse this table into a hashmap in order
> to allow fast commit lookups. I'll keep an eye out for that implementation.

The main purpose of this series is to avoid having to construct such a
table ahead of time. This is more or less akin to what the existing
implementation already does in load_bitmap_entries_v1(), though that
function has to read (but not decompress!) all bitmaps.

But I disagree that this isn't binary searchable. The object positions
are in MIDX or pack .idx order, so they are sorted lexicographically.
The comparator implementation could either take as its key an object_id,
and then convert each of the "commit pos" fields themselves to
object_ids and call oidcmp().

Or we could go the other way (as it looks like Abhradeep did in a later
patch) and convert the key's object_id into the index or MIDX-relative
position, and search for that.

> > +	* {empty}
> > +	offset (8 byte integer, network byte order): ::
> > +	The offset from which that commit's bitmap can be read.
> > +
> > +	* {empty}
> > +	xor offset (4 byte integer, network byte order): ::
> > +	It holds the position of the triplet with whose bitmap the
> > +	current bitmap need to xor. If the current triplet's bitmap
> > +	do not have any xor bitmap, it defaults to 0xffffffff.
>
> This last sentence seems backward. Perhaps:
>
>   If the value is 0xffffffff, then the current bitmap has no xor bitmap.

Perhaps even more concisely:

    The position of a triplet whose bitmap is used to compress this one,
    or 0xffffffff if no such bitmap exists.

Thanks,
Taylor
