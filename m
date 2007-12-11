From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Building git-1.5.3.7 on HP-UX 11.00
Date: Tue, 11 Dec 2007 03:54:40 -0500
Message-ID: <20071211085440.GK14735@spearce.org>
References: <20071204140326.14d9e7a0@pc09.procura.nl> <Pine.LNX.4.64.0712041439590.27959@racer.site> <20071204150102.7f3ec3e9@pc09.procura.nl> <47556EE2.6040105@op5.se> <20071204152240.6cb6018e@pc09.procura.nl> <Pine.LNX.4.64.0712041536180.27959@racer.site> <20071204155655.053f4fb4@pc09.procura.nl> <7vve7e49or.fsf@gitster.siamese.dyndns.org> <20071210145123.7c34af6d@pc09.procura.nl> <7vfxy9fxh3.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "H.Merijn Brand" <h.m.brand@xs4all.nl>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Andreas Ericsson <ae@op5.se>, git@vger.kernel.org,
	Sam Vilain <sam@vilain.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 11 09:55:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J20tT-0000UP-Gz
	for gcvg-git-2@gmane.org; Tue, 11 Dec 2007 09:55:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751923AbXLKIyt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Dec 2007 03:54:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751866AbXLKIyt
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Dec 2007 03:54:49 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:52520 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751816AbXLKIys (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Dec 2007 03:54:48 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1J20sy-0000ya-R7; Tue, 11 Dec 2007 03:54:40 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 71EDD20FBAE; Tue, 11 Dec 2007 03:54:40 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <7vfxy9fxh3.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67826>

Junio C Hamano <gitster@pobox.com> wrote:
> "H.Merijn Brand" <h.m.brand@xs4all.nl> writes:
> 
> > 3 I am willing to believe that HP_UX' vsnprintf () is broken, or
> >   at least does not conform to the expectations in the GNU world,
> >   but chickening out like the way strbuf_addf () does is maybe a
> >   bit too rude, so I forced a minimum of 64bytes available. That
> >   fixes a lot!
> >
> >   but it still breaks t4013 :(
> 
> I think Shawn had something similar for Solaris, and if it is a small
> cost to help portability, it does not feel so bad.

My Solaris change is already in your tree; on Solaris vnsprintf
will return -1 if the input buffer we gave it had a length of 0.
This can happen at odd times, depending on what is already in the
strbuf and how its buffer is. :)

The fix for Solaris turned out to be just make sure there is at
least 1 byte in the buffer before calling vsnprintf().
 
> > + git-index-pack -o tmp.idx test-2-7f8ead892057e78576c0329a70cc83afb113f117.pack
> > fatal: serious inflate inconsistency
> 
> That sounds like a broken zlib X-<.

I think this is actually a broken pread().  Its been reported
multiple times by different people on HP-UX.  Compiling with
NO_PREAD=1 resolves the issues for everyone who has tried it.

Jakub asked me for an autoconf test to look for this sort of
breakage in pread(), I have yet to come up with a theory for
what sort of breakage HP-UX is showing us here, let alone write
a test for it.

-- 
Shawn.
