Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DA8021F462
	for <e@80x24.org>; Mon, 20 May 2019 23:04:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726703AbfETXEW (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 May 2019 19:04:22 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:64343 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726384AbfETXEV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 May 2019 19:04:21 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C29C1657B5;
        Mon, 20 May 2019 19:04:19 -0400 (EDT)
        (envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
        :cc:subject:in-reply-to:message-id:references:mime-version
        :content-type; s=sasl; bh=zlwnVOOPARAhNMk6yZKsaUZDecA=; b=Xb3lRy
        ONbeGF+ByC49BILQx0YVZMDvD6zwRKGASMg8EbagyGidC2hvEhrqywRs+nmCFA6Y
        8BGqLTECxUFbmrpeBhD/GR/36q3+U9JSmeRbpksIfgpFhqWBeFDahFnxg3Comafw
        AO6C6cgVa5rZcro8CPUutmiNnLrl3EOxm9QWM=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id BAEC4657B4;
        Mon, 20 May 2019 19:04:19 -0400 (EDT)
        (envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=fluxnic.net;
 h=date:from:to:cc:subject:in-reply-to:message-id:references:mime-version:content-type; s=2016-12.pbsmtp; bh=kiUCoprI77i2zk7WaSnGF2eD7qVmZj9ucGBLDz0pld0=; b=dHzOFEAKW1LWBB4mZkoQ34El+lZzJVf9K/v0VR4n/r0XshAaeZtP6g0WO0tMvXdvPZR5STLRk3b2yZBV4zxPwx2s52WzTWPL9arkJHpBUDnwsT3r1Kvp0gO2Je184jZtNtZd4TkAbzbKPNU6SX4m1cTReXZPe3BO1e9x2HDQdEI=
Received: from yoda.home (unknown [70.82.130.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id B1641657B3;
        Mon, 20 May 2019 19:04:16 -0400 (EDT)
        (envelope-from nico@fluxnic.net)
Received: from xanadu.home (xanadu.home [192.168.2.2])
        by yoda.home (Postfix) with ESMTPSA id D0DDB2DA01F4;
        Mon, 20 May 2019 19:04:14 -0400 (EDT)
Date:   Mon, 20 May 2019 19:04:14 -0400 (EDT)
From:   Nicolas Pitre <nico@fluxnic.net>
To:     Duy Nguyen <pclouds@gmail.com>
cc:     Jeff King <peff@peff.net>, Jonathan Tan <jonathantanmy@google.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 2/2] index-pack: prefetch missing REF_DELTA bases
In-Reply-To: <CACsJy8AkhKX57RYL1Z+HZHqKbAKKOcLoRkgwg8bSnk+DW2+Nmg@mail.gmail.com>
Message-ID: <nycvar.YSQ.7.76.1905201803520.1558@knanqh.ubzr>
References: <20190516214257.GD10787@sigill.intra.peff.net> <20190516231509.253998-1-jonathantanmy@google.com> <20190517010950.GA30146@sigill.intra.peff.net> <20190517012234.GA31027@sigill.intra.peff.net> <20190517043939.GA12063@sigill.intra.peff.net>
 <CACsJy8CNyug3wvZ+6ts1nzgWyPF1JqC0LceP-HzMHjqvCr2Ugw@mail.gmail.com> <20190517085509.GA20039@sigill.intra.peff.net> <CACsJy8AkhKX57RYL1Z+HZHqKbAKKOcLoRkgwg8bSnk+DW2+Nmg@mail.gmail.com>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Pobox-Relay-ID: 9798AC00-7B53-11E9-92ED-B0405B776F7B-78420484!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, 18 May 2019, Duy Nguyen wrote:

> On Fri, May 17, 2019 at 3:55 PM Jeff King <peff@peff.net> wrote:
> >
> > On Fri, May 17, 2019 at 02:20:42PM +0700, Duy Nguyen wrote:
> >
> > > On Fri, May 17, 2019 at 12:35 PM Jeff King <peff@peff.net> wrote:
> > > > As it turns out, index-pack does not handle these complicated cases at
> > > > all! In the final fix_unresolved_deltas(), we are only looking for thin
> > > > deltas, and anything that was not yet resolved is assumed to be a thin
> > > > object. In many of these cases we _could_ resolve them if we tried
> > > > harder. But that is good news for us because it means that these
> > > > expectations about delta relationships are already there, and the
> > > > pre-fetch done by your patch should always be 100% correct and
> > > > efficient.
> > >
> > > Is it worth keeping some of these notes in the "third pass" comment
> > > block in index-pack.c to help future readers?
> >
> > Perhaps. I started on the patch below, but I had trouble in the commit
> > message. I couldn't find the part of the code that explains why we would
> > never produce this combination, though empirically we do not.

Good question indeed.

> That still has some value even if your commit ends up with a question
> mark. There's not much to dig out of 636171cb80 (make index-pack able
> to complete thin packs., 2006-10-25). Adding Nico, maybe he still
> remembers...

What about this comment in fix_unresolved_deltas():

        /*
         * Since many unresolved deltas may well be themselves base objects
         * for more unresolved deltas, we really want to include the
         * smallest number of base objects that would cover as much delta
         * as possible by picking the
         * trunc deltas first, allowing for other deltas to resolve without
         * additional base objects.  Since most base objects are to be found
         * before deltas depending on them, a good heuristic is to start
         * resolving deltas in the same order as their position in the pack.
         */

Doesn't that cover it?

In pack-objects, another comment says:

 * Depth value does not matter - find_deltas() will
 * never consider reused delta as the base object to
 * deltify other objects against, in order to avoid
 * circular deltas.

Sorry if I'm not of any help here. Although I used to have my brain 
wrapped around this code pretty tightly, it's been quite a while, and 
the code did change as well since then.


Nicolas
