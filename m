From: Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
Subject: Re: [PATCH] push: Provide situational hints for non-fast-forward
 errors
Date: Wed, 14 Mar 2012 13:14:34 +0100
Message-ID: <20120314121434.GB28595@in.waw.pl>
References: <20120313232256.GA49626@democracyinaction.org>
 <7vobrzst7n.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, peff@peff.net
To: Junio C Hamano <gitster@pobox.com>,
	Christopher Tiwald <christiwald@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 14 13:14:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S7n6H-0000np-Qr
	for gcvg-git-2@plane.gmane.org; Wed, 14 Mar 2012 13:14:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757629Ab2CNMOh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Mar 2012 08:14:37 -0400
Received: from kawka.in.waw.pl ([178.63.212.103]:55749 "EHLO kawka.in.waw.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754372Ab2CNMOh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Mar 2012 08:14:37 -0400
Received: from zbyszek by kawka.in.waw.pl with local (Exim 4.72)
	(envelope-from <zbyszek@in.waw.pl>)
	id 1S7n6A-0007rW-Hi; Wed, 14 Mar 2012 13:14:34 +0100
Content-Disposition: inline
In-Reply-To: <7vobrzst7n.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193099>

On Tue, Mar 13, 2012 at 09:27:08PM -0700, Junio C Hamano wrote:
> Christopher Tiwald <christiwald@gmail.com> writes:
>  * I can see there are three kinds of advices, but I do not see why users
>    need to acknowledge that they understand them one by one with separate
>    advice configuration.  Isn't it better to have only one variable, "OK,
>    I know how to deal with a failed push due to non-fast-forward"?

Hi,

I think that having three different config keys for the three
different advices makes sense, because the advices will be displayed
at different times. E.g. the user starts with the simplest one-branch
workflow, triggers the first alternative, reads "pullBeforePush" and
then disables the hint. Then the team upgrades the workflow to use
several branches and the user triggers the second alternative. At this
point, git should hint to "useUpstream". If the user disabled all the
non-FF hints at the first advice, she would miss the second, different
one, later.

> > diff --git a/Documentation/config.txt b/Documentation/config.txt
> > index c081657..50d9249 100644
> > --- a/Documentation/config.txt
> > +++ b/Documentation/config.txt
> > @@ -158,6 +158,21 @@ advice.*::
> >  		Advice shown when you used linkgit:git-checkout[1] to
> >  		move to the detach HEAD state, to instruct how to create
> >  		a local branch after the fact.
> > +	pullBeforePush::
> > +		Advice shown when you ran linkgit:git-push[1] and pushed
> > +		a non-fast-forward update to HEAD, instructing you to
> > +		linkgit:git-pull[1] before pushing again.
> > +	useUpstream::
> > +		Advice to set 'push.default' to 'upstream' when you ran
> > +		linkgit:git-push[1] and pushed 'matching refs' by default
> > +		(i.e. you did not have any explicit refspec on the command
> > +		line, and no 'push.default' configuration was set) and it
> > +		resulted in a non-fast-forward error.
> > +	checkoutPullPush::
> > +		Advice shown when you ran linkgit:git-push[1] and pushed
> > +		a non-fast-forward update to a non-HEAD branch, instructing
> > +		you to checkout the branch and run linkgit:git-pull[1]
> > +		before pushing again.
> 
> I would prefer to see these consolidated into a single advice.pushNonFF
> variable, but I may be missing why it could be a good idea to allow them
> turned off selectively.

Zbyszek
