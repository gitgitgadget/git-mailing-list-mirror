Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E67DC433E0
	for <git@archiver.kernel.org>; Thu, 11 Feb 2021 02:49:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B57A64DEE
	for <git@archiver.kernel.org>; Thu, 11 Feb 2021 02:49:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbhBKCtI (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Feb 2021 21:49:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229730AbhBKCtD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Feb 2021 21:49:03 -0500
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8F8EC06174A
        for <git@vger.kernel.org>; Wed, 10 Feb 2021 18:48:22 -0800 (PST)
Received: by mail-ot1-x335.google.com with SMTP id e4so3894527ote.5
        for <git@vger.kernel.org>; Wed, 10 Feb 2021 18:48:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5kznaSOzJSnRlKOJmKQvzccMPG0287kapbdMJ8fkLVI=;
        b=RarbVfG+Q1B6qI/1QlxRKtGbgdp/gGMM1foAN90CsJ07yI9ppfFjjrszLwd6bExNnV
         Px6JcCNRUWfNYRksoZPPHXsGFNFrsLd1NI22+vRvA3OIM50hgUyS30YQFhQIZxS3/A//
         EfchoajNC7zH1i4AxgJKFPn8F6i6x6tGag+Wr6OqoFrHnuNqRFR/WkRzW1qtAEenPmqY
         zhXHd4K5i4sVax6NlSEGWrvksatOulbuamUbmLo/svgHYqap5IlYJyYOs2z7od1RBSUC
         NOkJW9NS7fNo/3P9VHsI9KX4rty1VKE25m4yAn4T+/3fy3hCeT9rbO4MYA8A4WI6CGuL
         mAEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5kznaSOzJSnRlKOJmKQvzccMPG0287kapbdMJ8fkLVI=;
        b=qPX+LVrf9GVm+L8M0ML+y88mopMS+5kvPa53TZeFFVY/ztRhdVDJMoE8ap263rKrOJ
         OkXHzAiDnGakXDTSCj/JLyXIUOpwweQevoD0kisJFoKkbqYp5Rb9tbspqCb4O0MVb7QL
         ZD+Erl1zBRfBCLZR6nVGa6Yu7RlZCvqT0T6BdgMnnrazynviSqN3yGtHIuAHYIqrwTKK
         ekreRxmYPE9C/lbfokbZiO44axNlGfBfDgMCGjBtzdUq87SCSiwWbFKPsDFUoR/JyWFu
         aUb2zXjvjQfX+5jGTt7duVDulfs8o1U7NsvJSi3iHxQo4IEEE5en/CuW6INIRCO1i/MK
         qRWg==
X-Gm-Message-State: AOAM531qqpwRo06TgOCawBp1bXatJQroytlzM8cbzHiaxKuhuwMGjnu0
        gL8Fd7mC6ol0fhNuqkbH2E6YWHBWe8b3zA==
X-Google-Smtp-Source: ABdhPJzxtHipTxSbuc4yya1QgiUzJOH7eDwz3jZAN/UrEH7mY3a485ubAX8HiqAZGyz0I75bL7vFKg==
X-Received: by 2002:a9d:24c9:: with SMTP id z67mr4246431ota.273.1613011701895;
        Wed, 10 Feb 2021 18:48:21 -0800 (PST)
Received: from Derricks-MBP.attlocal.net ([2600:1700:e72:80a0:5030:63f6:1d3e:64d9])
        by smtp.gmail.com with ESMTPSA id h19sm374425oop.38.2021.02.10.18.48.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Feb 2021 18:48:21 -0800 (PST)
Subject: Re: [PATCH 6/9] Documentation/technical: describe multi-pack reverse
 indexes
To:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Cc:     dstolee@microsoft.com, gitster@pobox.com, peff@peff.net
References: <cover.1612998106.git.me@ttaylorr.com>
 <e64504bad6e181522946a8f234e12f569bede89e.1612998106.git.me@ttaylorr.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <320ef364-05ac-7d51-a6f9-770d32590766@gmail.com>
Date:   Wed, 10 Feb 2021 21:48:20 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <e64504bad6e181522946a8f234e12f569bede89e.1612998106.git.me@ttaylorr.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/10/21 6:03 PM, Taylor Blau wrote:> +Instead of mapping between offset, pack-, and index position, this

The "pack-," should be paired with "index-position" or drop the
hyphen in both cases. Perhaps just be explicit, especially since
"position" doesn't match with "offset":

  Instead  of mapping between pack offset, pack position, and index
  position, ...

> +reverse index maps between an object's position within the midx, and
> +that object's position within a pseudo-pack that the midx describes.

nit: use multi-pack-index or MIDX, not lower-case 'midx'.

> +Crucially, the objects' positions within this pseudo-pack are the same
> +as their bit positions in a multi-pack reachability bitmap.
> +
> +As a motivating example, consider the multi-pack reachability bitmap
> +(which does not yet exist, but is what we are building towards here). We
> +need each bit to correspond to an object covered by the midx, and we
> +need to be able to convert bit positions back to index positions (from
> +which we can get the oid, etc).

These paragraphs are awkward. Instead of operating in the hypothetical
world of reachability bitmaps, focus on the fact that bitmaps need
a bidirectional mapping between "bit position" and an object ID.

Here is an attempt to reword some of the context you are using here.
Feel free to take as much or as little as you want.

  The multi-pack-index stores the object IDs in lexicographical order
  (lex-order) to allow binary search. To allow compressible reachability
  bitmaps to pair with a multi-pack-index, a different ordering is
  required. When paired with a single packfile, the order used is the
  object order within the packfile (called the pack-order). Construct
  a "pseudo-pack" by concatenating all tracked packfiles in the
  multi-pack-index. We now need a mapping between the lex-order and the
  pseudo-pack-order.

> +One solution is to let each bit position in the index correspond to
> +the same position in the oid-sorted index stored by the midx. But
> +because oids are effectively random, there resulting reachability
> +bitmaps would have no locality, and thus compress poorly. (This is the
> +reason that single-pack bitmaps use the pack ordering, and not the .idx
> +ordering, for the same purpose.)
> +
> +So we'd like to define an ordering for the whole midx based around
> +pack ordering. We can think of it as a pseudo-pack created by the
> +concatenation of all of the packs in the midx. E.g., if we had a midx
> +with three packs (a, b, c), with 10, 15, and 20 objects respectively, we
> +can imagine an ordering of the objects like:
> +
> +    |a,0|a,1|...|a,9|b,0|b,1|...|b,14|c,0|c,1|...|c,19|
> +
> +where the ordering of the packs is defined by the midx's pack list,
> +and then the ordering of objects within each pack is the same as the
> +order in the actual packfile.
> +
> +Given the list of packs and their counts of objects, you can
> +na&iuml;vely reconstruct that pseudo-pack ordering (e.g., the object at
> +position 27 must be (c,1) because packs "a" and "b" consumed 25 of the
> +slots). But there's a catch. Objects may be duplicated between packs, in
> +which case the midx only stores one pointer to the object (and thus we'd
> +want only one slot in the bitmap).
> +
> +Callers could handle duplicates themselves by reading objects in order
> +of their bit-position, but that's linear in the number of objects, and
> +much too expensive for ordinary bitmap lookups. Building a reverse index
> +solves this, since it is the logical inverse of the index, and that
> +index has already removed duplicates. But, building a reverse index on
> +the fly can be expensive. Since we already have an on-disk format for
> +pack-based reverse indexes, let's reuse it for the midx's pseudo-pack,
> +too.
> +
> +Objects from the midx are ordered as follows to string together the
> +pseudo-pack. Let _pack(o)_ return the pack from which _o_ was selected
> +by the midx, and define an ordering of packs based on their numeric ID
> +(as stored by the midx). Let _offset(o)_ return the object offset of _o_
> +within _pack(o)_. Then, compare _o~1~_ and _o~2~_ as follows:
> +
> +  - If one of _pack(o~1~)_ and _pack(o~2~)_ is preferred and the other
> +    is not, then the preferred one sorts first.
> ++
> +(This is a detail that allows the midx bitmap to determine which
> +pack should be used by the pack-reuse mechanism, since it can ask
> +the midx for the pack containing the object at bit position 0).
> +
> +  - If _pack(o~1~) &ne; pack(o~2~)_, then sort the two objects in
> +    descending order based on the pack ID.
> +
> +  - Otherwise, _pack(o~1~) &equals; pack(o~2~)_, and the objects are
> +    sorted in pack-order (i.e., _o~1~_ sorts ahead of _o~2~_ exactly
> +    when _offset(o~1~) &lt; offset(o~2~)_).
> +
> +In short, a midx's pseudo-pack is the de-duplicated concatenation of
> +objects in packs stored by the midx, laid out in pack order, and the
> +packs arranged in midx order (with the preferred pack coming first).
> +
> +Finally, note that the midx's reverse index is not stored as a chunk in
> +the multi-pack-index itself. This is done because the reverse index
> +includes the checksum of the pack or midx to which it belongs, which
> +makes it impossible to write in the midx. To avoid races when rewriting
> +the midx, a midx reverse index includes the midx's checksum in its
> +filename (e.g., `multi-pack-index-xyz.rev`).

The rest of these details make sense and sufficiently motivate the
ordering, once the concept is clear.

Thanks,
-Stolee
