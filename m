Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B3EBC2036B
	for <e@80x24.org>; Sat,  7 Oct 2017 21:55:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752710AbdJGVzv (ORCPT <rfc822;e@80x24.org>);
        Sat, 7 Oct 2017 17:55:51 -0400
Received: from cpanel2.indieserve.net ([199.212.143.6]:43717 "EHLO
        cpanel2.indieserve.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751823AbdJGVzv (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Oct 2017 17:55:51 -0400
Received: from cpec03f0ed08c7f-cm68b6fcf980b0.cpe.net.cable.rogers.com ([174.118.92.171]:34308 helo=localhost.localdomain)
        by cpanel2.indieserve.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <rpjday@crashcourse.ca>)
        id 1e0x4Y-0002TH-1w; Sat, 07 Oct 2017 17:55:50 -0400
Date:   Sat, 7 Oct 2017 17:55:48 -0400 (EDT)
From:   "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost.localdomain
To:     Paul Smith <paul@mad-scientist.net>
cc:     Git Mailing list <git@vger.kernel.org>
Subject: Re: "git rm" seems to do recursive removal even without "-r"
In-Reply-To: <1507412674.8322.4.camel@mad-scientist.net>
Message-ID: <alpine.LFD.2.21.1710071749240.16818@localhost.localdomain>
References: <alpine.LFD.2.21.1710071436140.14843@localhost.localdomain>  <20171007190402.GH3382@zaya.teonanacatl.net>  <alpine.LFD.2.21.1710071506210.15271@localhost.localdomain>  <20171007192902.ma4s47hn6edwldx5@sigill.intra.peff.net> 
 <alpine.LFD.2.21.1710071531090.15738@localhost.localdomain>  <20171007193805.a2mwzkweonb6ymdk@sigill.intra.peff.net>  <alpine.LFD.2.21.1710071541430.15964@localhost.localdomain> <1507412674.8322.4.camel@mad-scientist.net>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1946299407-1507413350=:16818"
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpanel2.indieserve.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - crashcourse.ca
X-Get-Message-Sender-Via: cpanel2.indieserve.net: authenticated_id: rpjday+crashcourse.ca/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: cpanel2.indieserve.net: rpjday@crashcourse.ca
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1946299407-1507413350=:16818
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Sat, 7 Oct 2017, Paul Smith wrote:

> On Sat, 2017-10-07 at 15:43 -0400, Robert P. J. Day wrote:
> >   it's been a long week, so take this in the spirit in which it is
> > intended ... i think the "git rm" command and its man page should be
> > printed out, run through a paper shredder, then set on fire. i can't
> > remember the last time i saw such a thoroughly badly-designed,
> > badly-documented and non-intuitive utility.
>
> "git rm" works the same way that the UNIX rm command has worked, for
> 40+ years now.  Very simple, very well designed, and very intuitive
> (IMO).
>
> The major difference is the ability to handle globbing patterns,
> which UNIX rm doesn't do.  Maybe the way this is implemented is a
> little confusing, although I just read the man page and it seemed
> pretty clear to me.

  um, wrong.

> If you don't use glob patterns (or more specifically if you let the
> shell handle glob patterns, which is how I always do it) then there
> is really nothing bizarre about "git rm".  Maybe you could be more
> precise in your criticism.

  ok, fine, let me explain why this command is a nightmarish
monstrosity. as i now understand, if i use an escaped wildcard
pattern, "git rm" will *automatically* (with no further guidance from
me, and no warning), operate recursively. so if, in the kernel source
tree, i ran:

  $ git rm \*.c

i would end up removing *all* 25,569 "*.c" files in the kernel source
repository.

  however, let's say i wanted to remove, recursively, all files with a
*precise* (non-globbed) name, such as "Makefile". so i, naively, run:

  $ git rm Makefile

guess what ... the lack of globbing means i remove only the single
Makefile at the top of the working directory.

  if that isn't an example of ridiculous, non-intuitive behaviour, i
don't know what is.

rday

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                        http://crashcourse.ca

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================

--8323328-1946299407-1507413350=:16818--
