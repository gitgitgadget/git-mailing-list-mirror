Return-Path: <SRS0=kv1d=5J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BED7C54FCE
	for <git@archiver.kernel.org>; Tue, 24 Mar 2020 22:33:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5C1F2078A
	for <git@archiver.kernel.org>; Tue, 24 Mar 2020 22:33:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728693AbgCXWdK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Mar 2020 18:33:10 -0400
Received: from cloud.peff.net ([104.130.231.41]:50046 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728673AbgCXWdJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Mar 2020 18:33:09 -0400
Received: (qmail 20116 invoked by uid 109); 24 Mar 2020 22:33:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 24 Mar 2020 22:33:09 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29678 invoked by uid 111); 24 Mar 2020 22:42:59 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 24 Mar 2020 18:42:59 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 24 Mar 2020 18:33:07 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 2/2] tests(gpg): increase verbosity to allow debugging
Message-ID: <20200324223307.GA648188@coredump.intra.peff.net>
References: <dd26cb05a37a54d9d245823772d33fe0daab8ffa.1584968990.git.gitgitgadget@gmail.com>
 <20200323173258.GA3977@coredump.intra.peff.net>
 <20200323180445.GA31401@coredump.intra.peff.net>
 <xmqq8sjq6fob.fsf@gitster.c.googlers.com>
 <20200323201547.GA35429@coredump.intra.peff.net>
 <xmqqzhc63gmd.fsf@gitster.c.googlers.com>
 <20200323213109.GA44297@coredump.intra.peff.net>
 <nycvar.QRO.7.76.6.2003242239300.46@tvgsbejvaqbjf.bet>
 <20200324220532.GA647727@coredump.intra.peff.net>
 <nycvar.QRO.7.76.6.2003242323120.46@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.2003242323120.46@tvgsbejvaqbjf.bet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 24, 2020 at 11:25:09PM +0100, Johannes Schindelin wrote:

> > Er, isn't that what my patch did? I'm fine if you have another approach
> > to present, but I'm worried we might be duplicating effort.
> 
> I missed that your second patch made `GPG` lazy, too.
> 
> My version is slightly different from yours, though: I do not insist on
> setting the environment variable `GNUPGHOME` only after the `mkdir`
> succeeds, as the `gpg --sign` later on might fail anyway, which means that
> we _already_ could end up with `GNUPGHOME` set and the prereq `GPG` _not_
> set.

Yes. That mkdir could also be pushed down into the GPG prereq for the
same reason. It's pretty unlikely the mkdir would fail, and I thought it
would be less confusing (in the off chance that anybody even looks at it
when GPG isn't set) if we had a GNUPGHOME that pointed to an _actual_
directory, instead of something that didn't exist.

But that's kind of an arbitrary cutoff. The GPG prereq is also importing
keys and other stuff, so the state of that directory when GPG isn't set
is undefined (but again, nobody's supposed to be looking at it, so...).

-Peff
