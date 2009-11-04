From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [RFC/PATCH 0/3] use '--bisect-refs' as bisect rev machinery option
Date: Wed, 4 Nov 2009 22:26:25 +0100
Message-ID: <200911042226.25599.chriscool@tuxfamily.org>
References: <20091104034312.4545.2176.chriscool@tuxfamily.org> <alpine.LFD.2.01.0911041033530.31845@localhost.localdomain> <7veioegko3.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@linux-foundation.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 04 22:24:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N5nLQ-00044k-U4
	for gcvg-git-2@lo.gmane.org; Wed, 04 Nov 2009 22:24:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758196AbZKDVYT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Nov 2009 16:24:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758176AbZKDVYS
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Nov 2009 16:24:18 -0500
Received: from smtp3-g21.free.fr ([212.27.42.3]:57295 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758196AbZKDVYR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Nov 2009 16:24:17 -0500
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id A179881815F;
	Wed,  4 Nov 2009 22:24:16 +0100 (CET)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 5994981810F;
	Wed,  4 Nov 2009 22:24:13 +0100 (CET)
User-Agent: KMail/1.9.9
In-Reply-To: <7veioegko3.fsf@alter.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132151>

On Wednesday 04 November 2009, Junio C Hamano wrote:
> Linus Torvalds <torvalds@linux-foundation.org> writes:
> > On Wed, 4 Nov 2009, Linus Torvalds wrote:
> >> Yes, it is a behavioral change, but is it a bad one?
> >
> > .. and perhaps we could introduce --bisect-refs as the "old behavior"
> > of '--bisect' to git rev-list?
> >
> > I kind of suspect that it is unlikely that people are using 'git
> > rev-list --bisect' while _inside_ a bisection, but then wanting to
> > bisect someting that is outside the set of commits we're currently
> > actively bisecting.
> >
> > But maybe I'm wrong.
>
> Maybe I'm wrong too, but I do not think that is plausible that people are
> doing nested bisection that way.  It is probably a useful thing to do,
> but if somebody has thought of doing so we would have at least seen a
> request to add a way to tell "git-bisect" what names to use to record the
> good/bad set of commits under to make their implementation easier.  I
> haven't, and I take it an indication that it is very implausible that
> such scripts by people exist to be broken by this change.
>
> I was more worried about people who reinvented the wheel and are using
> their own git-bisect.sh derivative.  It probably was forked from the
> version that still used 'git rev-list --bisect", manually feeding good
> and bad set of commits to it from the command line.  But then what they
> are feeding would be the same as the new --bisect option implicitly gives
> them anyway, so there won't be a regression either.

I don't remember exactly when, but at one time some people talked about 
parallelizing bisection. The idea was that if it takes a long time to test 
one commit but you can test many commits at the same time (for example on 
different machines), then you can bisect faster by testing at the same time 
the current commit that git bisect checked out for you and for example the 
commit that git bisect would give you if the current commit is bad and the 
commit it would give you if the current commit is good.

So to do that you would use "git bisect start ..." and then you could use:

$ git rev-list --bisect HEAD --not $GOOD_COMMITS

to get the commit that you would have to test if the current commit is bad 
and:

$ git rev-list --bisect  $BAD --not $GOOD_COMMITS HEAD

to get the commit that you would have to test if the current commit is good.

Ok, perhaps nobody is doing that.

And yes I agree that it would be probably better to have --bisect be the 
name of the revision machinery option and --bisect-refs or perhaps another 
name like --bisect-compute be the name of the special option to "git 
rev-list".

But perhaps we can introduce --bisect-compute to do the same thing 
that --bisect currently does and deprecate --bisect with a warning and then 
a few versions later remove it and after a few more versions 
introduce --bisect to do the same as --bisect-refs.

Best regards,
Christian.
