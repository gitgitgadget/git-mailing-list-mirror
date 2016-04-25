From: Jeff King <peff@peff.net>
Subject: Re: [RFC] How to pass Git config command line instructions to
 Submodule commands?
Date: Mon, 25 Apr 2016 17:24:50 -0400
Message-ID: <20160425212449.GA7636@sigill.intra.peff.net>
References: <60724588-B06E-47E8-9302-8709C4601826@gmail.com>
 <CAGZ79kYmAr-O6_Jw2KO9eZEfZQ+_WBiERF=nhOYLJCZpUjSSyA@mail.gmail.com>
 <CA+P7+xoaqNF+uBHVnD2QR7j-=0Hyvd-scTc_vOdV+etC0VS9jA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Stefan Beller <sbeller@google.com>,
	Lars Schneider <larsxschneider@gmail.com>,
	Git Users <git@vger.kernel.org>
To: Jacob Keller <jacob.keller@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 25 23:25:02 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1auo03-0001pt-BF
	for gcvg-git-2@plane.gmane.org; Mon, 25 Apr 2016 23:24:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965093AbcDYVYy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Apr 2016 17:24:54 -0400
Received: from cloud.peff.net ([50.56.180.127]:56098 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S964906AbcDYVYx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Apr 2016 17:24:53 -0400
Received: (qmail 8924 invoked by uid 102); 25 Apr 2016 21:24:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 25 Apr 2016 17:24:52 -0400
Received: (qmail 6369 invoked by uid 107); 25 Apr 2016 21:24:53 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 25 Apr 2016 17:24:53 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 25 Apr 2016 17:24:50 -0400
Content-Disposition: inline
In-Reply-To: <CA+P7+xoaqNF+uBHVnD2QR7j-=0Hyvd-scTc_vOdV+etC0VS9jA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292563>

On Mon, Apr 25, 2016 at 01:59:03PM -0700, Jacob Keller wrote:

> >> However, I noticed that git config command line instructions such as
> >> "-c filter.lfs.smudge=" are not passed to Git submodule operations. Thus
> >> this does not work as expected:
> >>
> >>     git -c filter.lfs.smudge= -c filter.lfs.required=false clone --recursive <url> <path>
> >
> > I have cc'd Jacob Keller, who authored origin/jk/submodule-c-credential,
> > which does work in that area (deciding which config option to pass down
> > into the submodule commands).
> >
> 
> This is a tricky question. The problem is that some configurations are
> obviously not intended to go into the submodules, but determining how
> is somewhat troublesome. There was some discussion on this previous
> thread when we added support for credential options to pass through.

Right. I think it may be reasonable to pass through filter.* in the
whitelist.  They are not activated without a matching .gitattributes
entry in the repository (and people would generally configure them in
their user-level ~/.gitconfig for that reason).

It does mean that somebody would be stuck who really wanted to run the
smudge filter in their local repo, but for some reason not in the
subrepos. I am trying to think of a case in which that might be
security-relevant if you didn't trust the sub-repos[1]. But I really
don't see it. The filter is arbitrary code, but that's specified by the
user; we're just feeding it possibly untrusted blobs.

-Peff
