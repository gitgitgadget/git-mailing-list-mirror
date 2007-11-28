From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/3] cvsimport: use show-ref to support packed refs
Date: Wed, 28 Nov 2007 17:43:13 -0500
Message-ID: <20071128224313.GB13298@coredump.intra.peff.net>
References: <20071128185504.GA11236@coredump.intra.peff.net> <20071128185611.GB11320@coredump.intra.peff.net> <Pine.LNX.4.64.0711281916140.27959@racer.site> <20071128194423.GB11396@coredump.intra.peff.net> <7v4pf63t7y.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Emanuele Giaquinta <e.giaquinta@glauco.it>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 28 23:43:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IxVd1-0004i0-MK
	for gcvg-git-2@gmane.org; Wed, 28 Nov 2007 23:43:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756579AbXK1WnQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Nov 2007 17:43:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755427AbXK1WnQ
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Nov 2007 17:43:16 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4407 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754218AbXK1WnQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Nov 2007 17:43:16 -0500
Received: (qmail 14805 invoked by uid 111); 28 Nov 2007 22:43:14 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Wed, 28 Nov 2007 17:43:14 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 28 Nov 2007 17:43:13 -0500
Content-Disposition: inline
In-Reply-To: <7v4pf63t7y.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66446>

On Wed, Nov 28, 2007 at 02:23:13PM -0800, Junio C Hamano wrote:

> > +	if ($branch eq $opt_o && !$index{branch} &&
> > +		!get_headref("$remote/$branch")) {
> > +	my $parent = get_headref("$remote/$last_branch");
> > +		if (my $sha1 = get_headref("$remote/$mparent")) {
> 
> So the definition of get_headref() is to always take everything under
> but not including "refs/"?  IOW, the tip of the master branch is asked
> with get_headref("heads/master")?

No, the $remote variable is "refs/remotes/origin" or "refs/heads". See
the old version of get_headref, which actually looked up
"$git_dir/$remote/$branch".

> I think show-ref can easily be confused by its tail matching behaviour,
> and is a bad command to use in a context like this.  To be safe, I think
> get_headref() should be:
> 
> 	sub get_headref {
>         	my ($it) = (@_);
>                 my $r = `git-rev-parse --verify "refs/$it"`;
> 		return undef unless $? == 0;
> 		chomp $r;
> 		return $r;
> 	}

I have no comment on which is the best command to use (you would know
much better than I), but adding "refs/" is wrong.

-Peff
