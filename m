Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4E9EB1F4C0
	for <e@80x24.org>; Fri, 11 Oct 2019 21:04:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726982AbfJKVEi (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Oct 2019 17:04:38 -0400
Received: from mail-pg1-f202.google.com ([209.85.215.202]:51744 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726603AbfJKVEi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Oct 2019 17:04:38 -0400
Received: by mail-pg1-f202.google.com with SMTP id u30so3945339pgl.18
        for <git@vger.kernel.org>; Fri, 11 Oct 2019 14:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=gD3ngcTuYqUTGK29t9GNqz2h+lNfnNYeWm2E0ywNIUM=;
        b=LiIJmxmZYylOkjj9ERb99Sqk4xB0a28PStUnFn+3NX/FJB7cZ4gy1k3IfSXu0gBu7W
         ivoy1mJlE2j5TiS6N5ufgUlN5nG9QQ8XUTml58cKlH9CxOjAsWYSBlT2ljS3LOVlsONM
         ar84clPtxQoelLT+QmuIKq07GwftdmoW3NRWqZIrodwAd3bDukcMuhofutAz6aT//3it
         G9GrPUsBeoWgAbayYQS93heSo3OLVHS2QvEGAfH5r61sSjTJIwINNOlcff8G89kE0tnM
         rOulrQlUVzVUzXPBIhFBVhlS0XYZ4MvzDNMI8TDo0hESHXJR8C/ePhFW99GzeitgxxME
         aoTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=gD3ngcTuYqUTGK29t9GNqz2h+lNfnNYeWm2E0ywNIUM=;
        b=Sd4C+t680IjlHg/lURiaZBwkMewLniloHh8GJo6BEtTK925/n5i9xtUBNQbLwhlLO+
         kG3+M5xsKC3zC6+BKBgWLDs1yCu/iS2oCnYznqGYtu7Ybp/EfUQWJ75b89lmxbiQ/IRp
         AjzV4NatR/4oqpWVHhVf4ldSoG9ZAdSYDaV4CpoPcQIgc6oBs9OdyB85h+t6m+J6iu4x
         0/SBxFsxgiW0bPWjVQqGznU4PWa2/AymCwiAj1Hpnb29azkJVEcf13mqrdoiBQN4YnrZ
         o2G+jPcUhM8GFdGTDDY8OY+9OYpK8zWEOwGg6QfQXV+N2PgdfQ7ipl+zbQvKViOsJ+KI
         +i4w==
X-Gm-Message-State: APjAAAV+tbxpYQC/zsrMcsO57rVtvDw2/w6OFgVb1VperA6WHCZAD0O+
        f1XNoxIkDF9/Lh80bIiaF1mEHmr11+j1VH6CDWaW
X-Google-Smtp-Source: APXvYqyGGkjZULzw25pvRskeGoBfB3IHze89tEcRf03f0ksQWKfmq6iTxOjfZiik6yTak8+IuDWeyxBcIQfY9Ai/xlwP
X-Received: by 2002:a63:2d43:: with SMTP id t64mr18774312pgt.428.1570827877277;
 Fri, 11 Oct 2019 14:04:37 -0700 (PDT)
Date:   Fri, 11 Oct 2019 14:04:34 -0700
In-Reply-To: <20191011180125.GA20601@sigill.intra.peff.net>
Message-Id: <20191011210434.140296-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <20191011180125.GA20601@sigill.intra.peff.net>
X-Mailer: git-send-email 2.23.0.700.g56cf767bdb-goog
Subject: Re: [RFC PATCH 10/10] pack-objects: improve partial packfile reuse
From:   Jonathan Tan <jonathantanmy@google.com>
To:     peff@peff.net
Cc:     jonathantanmy@google.com, christian.couder@gmail.com,
        git@vger.kernel.org, gitster@pobox.com, chriscool@tuxfamily.org,
        ramsay@ramsayjones.plus.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> > This makes sense - offsets may be different when we omit objects from
> > the packfile. I think this can be computed by calculating the number of
> > zero bits between the current object's index and the nth object prior
> > (where n is the offset) in the bitmap resulting from
> > reuse_partial_packfile_from_bitmap() above, thus eliminating the need
> > for this array, but I haven't tested it.
> 
> You need to know not just the number of zero bits, but the accumulated
> offset due to those missing objects. So you'd end up having to walk over
> the revindex for that set of objects. This array is basically caching
> those accumulated offsets (for the parts we _do_ include) so we don't
> have to compute them repeatedly.

Ah...yes. For some reason I thought that the offset was a number of
objects, but it is actually a number of bytes. The patch makes sense
now.

> There's also a more subtle issue with entry sizes; see below.

Good point.

> > > @@ -1002,6 +1132,10 @@ static int have_duplicate_entry(const struct object_id *oid,
> > >  {
> > >  	struct object_entry *entry;
> > >  
> > > +	if (reuse_packfile_bitmap &&
> > > +	    bitmap_walk_contains(bitmap_git, reuse_packfile_bitmap, oid))
> > > +		return 1;
> > 
> > Hmm...why did we previously not need to check the reuse information, but
> > we do now? I gave the code a cursory glance but couldn't find the
> > answer.
> 
> I think the original code may simply have been buggy and nobody noticed.
> Here's what I wrote when this line was added in our fork:

[snip explanation]

Thanks - I'll also take a look if I have time.

> Thanks for looking at it. I still have to take a careful pass over the
> whole split, but I've tried to at least answer your questions in the
> meantime.

Thanks for your responses. Also thanks to Christian for splitting it in
the first place, making it easier to review.
