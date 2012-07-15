From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] fast-import: catch deletion of non-existent file in input
Date: Sun, 15 Jul 2012 13:11:51 -0500
Message-ID: <20120715181151.GA1986@burratino>
References: <87ehogrham.fsf@bitburger.home.felix>
 <20120712210138.GA15283@sigill.intra.peff.net>
 <m2pq80uj56.fsf@igel.home>
 <20120713130246.GB2553@sigill.intra.peff.net>
 <m2hatbvkyh.fsf@igel.home>
 <20120715102300.GA28667@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andreas Schwab <schwab@linux-m68k.org>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	David Barr <davidbarr@google.com>,
	Felix Natter <fnatter@gmx.net>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Jul 15 20:12:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SqTJJ-0004oA-OV
	for gcvg-git-2@plane.gmane.org; Sun, 15 Jul 2012 20:12:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751000Ab2GOSMG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Jul 2012 14:12:06 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:46199 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750698Ab2GOSMD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Jul 2012 14:12:03 -0400
Received: by yhmm54 with SMTP id m54so4823099yhm.19
        for <git@vger.kernel.org>; Sun, 15 Jul 2012 11:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=xHSclP7K1o0g5iBuNo8QHOi4f1s4usfAFadxpeuJLTc=;
        b=h0Lr1/8igKeBmN8mDsX+QFkUrFRyAzmQDRio/MbQ69n4k4LL1zHExfm4wcYjdQUUIX
         wLy5OHiRdFaLad70QWg2QpWzUCBmlr1iouRE7Pfi/WZYptrLHK7eeYSAtf5CRob8v4Bu
         CaC63QUxasr1CNVgXyzyCe93JpZCEHIhu0pB/gbJSU9i/p4GS+vOjc8OdQEOSCSNjmmH
         J3q/TGRryRiPMhqanq+RYZ+GfMsW13dCzc83N+uhRd/24sCaZKi2U1T9wOty62MXGYYE
         Yhq6fkuUecAa+Qe55Y5Mf7O4mEAqFrX3rbWCqlUUasnLlJG2P2xOBPjQyFiOjuAn1wcs
         gebw==
Received: by 10.50.149.225 with SMTP id ud1mr3584365igb.74.1342375921623;
        Sun, 15 Jul 2012 11:12:01 -0700 (PDT)
Received: from burratino (cl-1372.chi-02.us.sixxs.net. [2001:4978:f:55b::2])
        by mx.google.com with ESMTPS id wp10sm14587893igb.6.2012.07.15.11.12.00
        (version=SSLv3 cipher=OTHER);
        Sun, 15 Jul 2012 11:12:00 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20120715102300.GA28667@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201482>

Hi,

Jeff King wrote:

> Subject: fast-import: catch deletion of non-existent file in input
[...]
> We silently ignored the bogus "D foo" directive, and the
> resulting tree incorrectly contained "bar". With this patch,
> we notice the bogus input and die.

This breaks svn-fe, which relies on the existing semantics when asked
to copy an empty directory.

That's my fault because we never check that in the testsuite, but I
also wouldn't be surprised if other importers were relying on the same
thing.

Any API break this big without a justification along the lines

	We can be confident that no existing importer uses this
	construct because ...

_needs_ to be guarded by a new "feature" to be safe for existing
importers.

Let's repeat that for emphasis: API breaks in fast-import not guarded
with a new "feature" type are not ok.

Sorry,
Jonathan
