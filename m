From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] git-svn: Fix termination issues for remote svn
 connections
Date: Thu, 5 Sep 2013 19:02:49 +0000
Message-ID: <20130905190249.GA1532@dcvr.yhbt.net>
References: <6970c0cab40c60195c8f042a3b930a0a.squirrel@83.236.132.106>
 <xmqqli3bhzop.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Uli Heller <uli.heller@daemons-point.com>, git@vger.kernel.org,
	"Kyle J. McKay" <mackyle@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 05 21:03:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VHepR-0006z7-Rj
	for gcvg-git-2@plane.gmane.org; Thu, 05 Sep 2013 21:02:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756907Ab3IETCu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Sep 2013 15:02:50 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:55113 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756894Ab3IETCt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Sep 2013 15:02:49 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 549371F6BD;
	Thu,  5 Sep 2013 19:02:49 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <xmqqli3bhzop.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233981>

Junio C Hamano <gitster@pobox.com> wrote:
> "Uli Heller" <uli.heller@daemons-point.com> writes:
> > Nevertheless, I think it makes sense to fix the issue within the
> > git perl module Ra.pm, too. The change frees the private copy of
> > the remote access object on termination which prevents the error
> > from happening.

> Thanks.  Please sign-off your patch.
> 
> I am Cc'ing Kyle McKay who apparently had some experience working
> with git-svn with newer svn that can only use serf, hoping that we
> can get an independent opinion/test just to be sure.  Also Cc'ed is
> Eric Wong who has been the official git-svn area expert, but I
> understand that Eric hasn't needed to use git-svn for quite a while,
> so it is perfectly fine if he does not have any comment on this one.
> 
> We may want to find a volunteer to move "git svn" forward as a new
> area expert (aka subsystem maintainer), by the way.

Correct, git-svn has the effect of being self-obsoleting.

I agree with adding a workaround for broken things, however
I suggest a code comment explaining why it is necessary.
The commit message is important, too, but might get harder to track
down if there's code movement/refactoring in the future.

> > +END {
> > +	$RA = undef;
> > +	$ra_invalid = 1;
> > +}
