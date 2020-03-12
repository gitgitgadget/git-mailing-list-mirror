Return-Path: <SRS0=YYoh=45=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D79EC10DCE
	for <git@archiver.kernel.org>; Thu, 12 Mar 2020 21:30:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1419A20724
	for <git@archiver.kernel.org>; Thu, 12 Mar 2020 21:30:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726514AbgCLVap (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Mar 2020 17:30:45 -0400
Received: from cloud.peff.net ([104.130.231.41]:38418 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726246AbgCLVap (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Mar 2020 17:30:45 -0400
Received: (qmail 14756 invoked by uid 109); 12 Mar 2020 21:30:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 12 Mar 2020 21:30:45 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2447 invoked by uid 111); 12 Mar 2020 21:40:09 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 12 Mar 2020 17:40:09 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 12 Mar 2020 17:30:44 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>, stolee@gmail.com,
        git@vger.kernel.org, christian.couder@gmail.com
Subject: Re: [Question] Is extensions.partialClone defunct?
Message-ID: <20200312213044.GC872402@coredump.intra.peff.net>
References: <5981c317-4b39-de15-810b-a781aa79189d@gmail.com>
 <20200312170714.180996-1-jonathantanmy@google.com>
 <20200312175151.GB120942@google.com>
 <20200312210954.GA13644@syl.local>
 <xmqqsgide0i3.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqsgide0i3.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 12, 2020 at 02:17:40PM -0700, Junio C Hamano wrote:

> Taylor Blau <me@ttaylorr.com> writes:
> 
> > On Thu, Mar 12, 2020 at 10:51:51AM -0700, Jonathan Nieder wrote:
> >> Jonathan Tan wrote:
> >> > Derrick Stolee wrote:
> >>
> >> >> but it appears that we rely on the "remote.<name>.promisor = true"
> >> >> setting instead of this extension.
> >> >
> >> > Hmm...besides giving the name of the promisor remote, the
> >> > extensions.partialClone setting is there to prevent old versions of Git
> >> > (that do not know this extension) from manipulating the repo.
> >
> > Manipulating it how?
> 
> Presumably if the version of Git does not assume that sometimes
> missing objects are OK, its "fsck" and "repack" would become very
> upset when a repository lacks very many objects because the version
> of Git that created it assumes they can be lazily fetched, no?

Yes (or even just "git log", which will barf when it hits a needed
object). Unlike some other extensions, I don't think that case would be
_dangerous_ (i.e., for any case where it matters the old version is
likely to abort, thinking it's seeing corruption, rather than writing
out a subtly wrong result).

But it is certainly more pleasant for the user to see "we don't support
the partialClone extension" than a spew of "missing object" messages.

-Peff
