Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 115A51FAFB
	for <e@80x24.org>; Thu,  6 Apr 2017 22:48:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752423AbdDFWsK (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Apr 2017 18:48:10 -0400
Received: from mail-pg0-f43.google.com ([74.125.83.43]:36618 "EHLO
        mail-pg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751593AbdDFWsI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Apr 2017 18:48:08 -0400
Received: by mail-pg0-f43.google.com with SMTP id g2so47495107pge.3
        for <git@vger.kernel.org>; Thu, 06 Apr 2017 15:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ahdOYFNKpCHMB5YRvfEEpnv6ryF8d/yTV0KNi1oHzF0=;
        b=dZ6sAdtg0/OImf+M3uq67kVjRjLZ45RiSeCjxzzLm1ymQE0ZidNQ4hEJ5r8SURSufm
         USOq3Hz9wHir9Q1+i4GCU/tQdEILE5FzTjyHd9BoFwF92R3L1n/HtE9RYMd9etPzYgHu
         NSppgFfl8kjoau71dARC8Lqsl/ZhH4aqXR8fltlyAoGYzpNPEcxOFANxeKeIOqBUWTYA
         K4rSJ720orxXRpve7nriqSAo2q+2IDKsxJDwHAo4a2TtbX7Auj0Nq7ZEqjmxUFBokk4c
         G32RuqK4l7CocWYzb2lvrWK5FR32NzyaRw6/sInWmMbjfdiFoOdoroB6Pqp7UVtxUJA7
         BbLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ahdOYFNKpCHMB5YRvfEEpnv6ryF8d/yTV0KNi1oHzF0=;
        b=sOZs6o23Oy2G4HMJpisHDX1FchnDirfQQL5pLLCRKhrmrSR/Wf/TQPFpe6Bao9rcFq
         9AWzItoJKQ7+0IziAPC6tB4rp9xYiy/JHhmeKzsFiYqgdlz/M1n1wtzjd1rqEfaC64kg
         1PDIngQsCtA0DVrANCxVT9eqA26uEClUYo0YCsrmCsIHfpRfBe87JP2hacc/0Kg8JKdI
         8Gul91DqtZC6KsR8Lv7M84CK0VUsfT9KNdqg2gpCCXeOY+rknGoijnJ6MFUdbXgsNw/b
         BuxCin1RJVtJ8C9jNx4cxkrVpf0W8f7pvuyxAsXscSI3nWPLSj6Ek4NjjsZKtD0uQHIq
         o5vA==
X-Gm-Message-State: AFeK/H1snKhLpeUBQ+seSqC44780zk1Si9dv3o4uxIuEYKRmP3nIiEiRUiVBVkheFlbOjLsjIZbP+fO7ic9ETomT
X-Received: by 10.84.248.74 with SMTP id e10mr7641201pln.76.1491518888124;
 Thu, 06 Apr 2017 15:48:08 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.186.196 with HTTP; Thu, 6 Apr 2017 15:48:07 -0700 (PDT)
In-Reply-To: <20170406203732.47714-2-git@jeffhostetler.com>
References: <20170406203732.47714-1-git@jeffhostetler.com> <20170406203732.47714-2-git@jeffhostetler.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 6 Apr 2017 15:48:07 -0700
Message-ID: <CAGZ79kafbRQo2Of0H162ue5YzL7uA2PDu=sTy0=cEOejGTJhyw@mail.gmail.com>
Subject: Re: [PATCH v1] unpack-trees: avoid duplicate ODB lookups during checkout
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Jeff Hostetler <jeffhost@microsoft.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 6, 2017 at 1:37 PM,  <git@jeffhostetler.com> wrote:
> From: Jeff Hostetler <jeffhost@microsoft.com>
>
> Teach traverse_trees_recursive() to not do redundant ODB
> lookups when both directories refer to the same OID.

And the reason for this is that omitting the second lookup
saves time, i.e. a lookup in the ODB of a sufficiently large
repo is slow.

My kneejerk line of thinking:
* yes, it sounds good to reduce the number of ODB accesses.
* But if we consider ODB lookups to be slow and we perform
  a structured access, how about a cache in front of the ODB?
* We already have that! (sort of..) 9a414486d9 (lookup_object:
  prioritize recently found objects, 2013-05-01)
* Instead of improving the caching, maybe change the
  size of the problem: We could keep the objects of different types
  in different hash-tables.

object.c has its own hash table, I presume for historical and
performance reasons, this would be split up to multiple hash
tables.

Additionally to "object *lookup_object(*sha1)", we'd have
a function

"object *lookup_object(*sha1, enum object_type hint)"
which looks into the correct the hash table.

If you were to call just  lookup_object with no hint, then you'd
look into all the different tables (I guess there is a preferrable
order in which to look, haven't thought about that).

>
> In operations such as read-tree, checkout, and merge when
> the differences between the commits are relatively small,
> there will likely be many directories that have the same
> SHA-1.  In these cases we can avoid hitting the ODB multiple
> times for the same SHA-1.

This would explain partially why there was such a good
performance boost in the referenced commit above as we
implicitly lookup the same object multiple times.

Peff is really into getting this part faster, c.f.
https://public-inbox.org/git/20160914235547.h3n2otje2hec6u7k@sigill.intra.peff.net/

> TODO This change is a first attempt to test that by comparing
> TODO the hashes of name[i] and name[i-i] and simply copying
> TODO the tree-descriptor data.  I was thinking of the n=2
> TODO case here.  We may want to extend this to the n=3 case.

>
> ================
> On the Windows repo (500K trees, 3.1M files, 450MB index),
> this reduced the overall time by 0.75 seconds when cycling
> between 2 commits with a single file difference.
>
> (avg) before: 22.699
> (avg) after:  21.955
> ===============

So it shaves off 4% of the time needed. it doesn't sound like a
break through, but I guess these small patches add up. :)

>         for (i = 0; i < n; i++, dirmask >>= 1) {
> -               const unsigned char *sha1 = NULL;
> -               if (dirmask & 1)
> -                       sha1 = names[i].oid->hash;
> -               buf[i] = fill_tree_descriptor(t+i, sha1);
> +               if (i > 0 && (dirmask & 1) && names[i].oid && names[i-1].oid &&
> +                       !hashcmp(names[i].oid->hash, names[i-1].oid->hash)) {

Why do we need to check for dirmask & 1 here?
This ought to be covered by the hashcmp already IIUC.
So maybe we can pull out the
                         if (dirmask & 1)
                                 sha1 = names[i].oid->hash;
out of the else when dropping that dirmask check?


Thanks,
Stefan
