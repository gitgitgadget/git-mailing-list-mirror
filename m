Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6636820248
	for <e@80x24.org>; Wed,  6 Mar 2019 20:53:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727189AbfCFUxC (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Mar 2019 15:53:02 -0500
Received: from smtp-31.italiaonline.it ([213.209.10.31]:54290 "EHLO libero.it"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726614AbfCFUxB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Mar 2019 15:53:01 -0500
Received: from DESKTOP-E4U7JCE ([158.148.73.124])
        by smtp-31.iol.local with ESMTPA
        id 1dX9hwCF9CH4t1dX9hoxJ7; Wed, 06 Mar 2019 21:53:00 +0100
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2014;
        t=1551905580; bh=90aNcPcEP0fZWBwIvQwxcdwai7f8PWiDC/jGyrr3S6U=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References;
        b=kUvYYopivLUJVgTeKwsswm2K5GIv30IGzkRlQsQw2PvSjxuXUUvKFDWeOBuYAzQ1C
         0QMw4OPE/dwrkZWsoJ8ZI2nRjWe8DdMvLmAc/yj/aWhvdUPKtsABawbSOpQWkj/xzv
         PNREO43FzRGaii16oBpE//C2QHHdn5YF7oscbTlsgkauQvEyKaq656sXgV4HtgL6wk
         diBK10xM6xzDIoY8SB4RyHUuYU3yy/rb+36hugp6nwHlowdgl1TcWeXi2nrfK323bg
         6QgtXupYakwF7v5oNQz+i3PEAv9/7uCKPMb6cv5F/NlcTCsGkdfj63CWRM475IeQGq
         HVhi8ott53fww==
X-CNFS-Analysis: v=2.3 cv=R4HS5uZX c=1 sm=1 tr=0
 a=lD+Fqu6e8C6S12qGMBovIw==:117 a=lD+Fqu6e8C6S12qGMBovIw==:17
 a=IkcTkHD0fZMA:10 a=Xu358wS_fqz-Vf5kd6IA:9 a=QEXdDO2ut3YA:10
Message-ID: <1551905579.1727.8.camel@libero.it>
Subject: Re: Can't build first git commit
From:   Fabio Aiuto <polinice83@libero.it>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Date:   Wed, 06 Mar 2019 21:52:59 +0100
In-Reply-To: <20190306200356.GB23315@sigill.intra.peff.net>
References: <1551729517.4092.1.camel@libero.it>
         <20190304204007.GA32691@sigill.intra.peff.net>
         <20190305191519.GA12791@sigill.intra.peff.net>
         <1551902320.1727.1.camel@libero.it>
         <20190306200356.GB23315@sigill.intra.peff.net>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfOjhO7j9qT/GawO/DvOmNCSa3yDeb0u8WCU/6jv8H3SV8Q4Xmqwtfej4rmjlUgBK9BdLT8TICZFO3ea1lyaaObg7Gx6KO9JxfiHruwXvvFjxrgcugDUE
 D0Lj1v8I5/JqXhhhHqzO+dst48WA0yzkAjp8jzjaQ5AQ/1RbuSzErs/RDwIjQ38Gq0ih1UkYtSzRYD7sJ6B+NbUlJkw5na8cyQs=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Found this error

Program received signal SIGSEGV, Segmentation fault.
0x00401628 in verify_hdr (hdr=0x0, size=32) at read-cache.c:192
192		if (hdr->signature != CACHE_SIGNATURE)

when tracing on line

static int verify_hdr(struct cache_header *hdr, unsigned long size)
{
	SHA_CTX c;
	unsigned char sha1[20];

	if (hdr->signature != CACHE_SIGNATURE)<--- this line

inside file read-cache.c
What's going on?

Il giorno mer, 06/03/2019 alle 15.03 -0500, Jeff King ha scritto:
> On Wed, Mar 06, 2019 at 08:58:40PM +0100, Fabio Aiuto wrote:
> 
> > Yes the fetch command wasn't written at that time, right? I didn't
> > understand why should be better to work with the git code from
> > github.
> > There's something I misunderstood?
> 
> I just mean that it is an interesting fact that modern Git and Git
> v1.0
> can still interact seamlessly over the network. I.e., you could still
> collaborate with somebody using an ancient version of Git (hopefully
> nobody is using v1.0, but logically it extends to all of the
> intermediate versions).
> 
> -Peff
