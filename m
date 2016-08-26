Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9606B1FD99
	for <e@80x24.org>; Fri, 26 Aug 2016 12:03:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752161AbcHZMDX (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Aug 2016 08:03:23 -0400
Received: from mout.gmx.net ([212.227.17.20]:57414 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752014AbcHZMDW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Aug 2016 08:03:22 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0MRGvT-1bYb9z37Yl-00Ucdq; Fri, 26 Aug 2016 13:56:32
 +0200
Date:   Fri, 26 Aug 2016 13:56:30 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org
Subject: Re: [PATCH 03/15] sequencer: lib'ify do_pick_commit()
In-Reply-To: <xmqqh9a8lf9t.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1608261355470.4924@virtualbox>
References: <cover.1471968378.git.johannes.schindelin@gmx.de>        <92fdb70f3db157f8a3d2442d872e989d81c6756e.1471968378.git.johannes.schindelin@gmx.de> <xmqqh9a8lf9t.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:yEh3LJZsh7ScUZjTHefMmxdW6L7BW5ZXuIJRSg7HeR9xSq8xKJR
 cStCL8VRaBeu0JNLXG1EsaOZYz1InEqmrOzE+6tSa/qZG9Q7jPvZeT6LYjTmLa1xlTmvyBp
 H4i/va7yNOBvYxX4l+8TT9ZZwvqW2XTmclU07k/Zm6TaLJviAUlvgVPtKq3R53i+BocoDK4
 PFNmFIUSTNGWTLte7mNmQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:qGiQeWteL8c=:xS+BYvEB8gpQYQAUFbIHrf
 JwSfN8GMMfiAaj82dRcVJia/Su7T8uZept/AMI8ont/m+PBsZ9+jbYjYRSb8XCDWYRcV8lILz
 pwpH3TN0jO5cLYB+ekkZ9kI54Nj2V/NV0a9NZU1J1k/HosXrWT6RAz1Ew4+R7b2G47uFDqInI
 7BaYKAjjYTPTFaepI9RGSGwDsxxIwWVAwl36mpMoJFv4G13mmFma06C4dlJObhCsjMFDqq59V
 eM32c0bNkFW97AEIIZdRIob94MhZbQ74nIBWW5iHdO8gHiLkGuUm3q5jxxDt9FwRGuOeSyExF
 2CSvRvZPE271L67Wci0Pk4/ZYN4w79Ec+oqnrnIJkxxMxEgf4I/bjPpqlUMF6nmuSwfbmk3ba
 SbU9oaZn3UXXN2dh+KizXLY6SH8g23acnPr1oFutwKYwr1wrVCxVdTrWPuPwnc6zbYRoclbN5
 SCYBacZmwooGfPnDU4xfKympc5EKLlQXD05pZnjhUVCRzdUeIBsfQtLSXLhR6SzV33mvrVKdv
 XmsFuIXrQ1P5GJiSEzLBtVPRMQmyhundVVIuxXQI0WO1NUqM/0qBjVAAM0afyTebKLBMdEHvH
 JM8o/2SN1pvBZVNWX2JBH0kX/7MVIwUEJ2CHOtRXSYiF6nMge7HvhrLCnYzPgkPQdvuCjpwP4
 8ktzqaNx/7lMP8/ij4iBiOV0cU0VXrocMvgCcGexeNeMowIN+/jtNTbGpH/qaZkovL5jkItp3
 9MxjGy66+0AaYFETXgmemrzgwG8/EOe31FP7QYZdb1IJ5L39WP3xzzrHXi4jIodky2lAg+NXh
 KQewtXy
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Thu, 25 Aug 2016, Junio C Hamano wrote:

> >  		if (write_cache_as_tree(head, 0, NULL))
> > -			die (_("Your index file is unmerged."));
> > +			return error (_("Your index file is unmerged."));
> 
> While you are touching the line, it is a good idea to correct an
> obvious style error like this one.  "Do one thing and one thing well
> in a commit" is a good discipline, but it is absurd to take it to
> the extreme.

To be quite honest, I had to look *really* hard to see that space. It took
me literally 30 seconds to spot the style issue.

Fixed in v2,
Dscho
