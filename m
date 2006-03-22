From: Shawn Pearce <spearce@spearce.org>
Subject: Re: Cloning from sites with 404 overridden
Date: Tue, 21 Mar 2006 22:12:00 -0500
Message-ID: <20060322031200.GB17954@spearce.org>
References: <20060322025921.1722.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 22 04:12:59 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FLtlf-0004u0-Ri
	for gcvg-git@gmane.org; Wed, 22 Mar 2006 04:12:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750710AbWCVDMF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 21 Mar 2006 22:12:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750707AbWCVDMF
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Mar 2006 22:12:05 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:58063 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S1750710AbWCVDME (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Mar 2006 22:12:04 -0500
Received: from cpe-72-226-60-173.nycap.res.rr.com ([72.226.60.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1FLtlH-0000Ax-Dt; Tue, 21 Mar 2006 22:11:51 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id D175A20FBB9; Tue, 21 Mar 2006 22:12:00 -0500 (EST)
To: linux@horizon.com
Content-Disposition: inline
In-Reply-To: <20060322025921.1722.qmail@science.horizon.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17798>

'0' x 40.  :-) There's some places already in the GIT source
which would have ``issues'' if they got an object with this hash.
Not sure if it is actually an entirely impossible hash or just one
that is highly improbable.

My own website has this problem and its because I'm using WordPress
to handle all URLs on the site; I haven't yet found a way to
configure WordPress to return a proper 404 when the URL can't be
mapped to something on the server.  Note that 404 status codes can
in fact return pretty HTML content for the user, and many websites
do this and many browsers display that pretty HTML.  But a bot can
then also recognize the status code and DTRT.

The webservers are just plain broken, mine included.  I think the
best option is to delay corrupt object reporting to the end of
the download process if you get only one corrupt object and that
corrupt object was actually attainable from a pack.  And in this
case its just a minor warning:

	Warning: The server appears to not return proper HTTP status
	codes on missing files.  The files were found in one or
	more packs so the download is OK, but the server administrator
	should really fix their server.  If you know the server
	administrator you might want to prod them to do so.

But that's already been suggested and I thought someone worked up
a patch based on that idea?  If not I could try to do so since my
own damn server has the problem.  :-)

linux@horizon.com wrote:
> If someone feels ambitious, you can detect this condition automatically
> by searching for a file that you know won't be there and seeing if you
> get a 404 response to that.
> 
> To avoid punishing good servers, it would be nice to defer the test
> until reciving the first corrupted object.
> 
> I'm not sure what the best "object that's not supposed to be there" is.
> It could just be a random hash, or would a malformed object file name
> be better?  Any fixed name has a finite chance of being created by
> someone somewhere, but generating 160-bit random numbers is a PITA on
> non-freenix platforms.
> 
> 
> (As an aside, I suspect this is all caused by Microsoft's "friendly HTML
> error messages" invention.)

-- 
Shawn.
