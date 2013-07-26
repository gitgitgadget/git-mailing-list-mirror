From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] commit: correct advice about aborting a cherry-pick
Date: Fri, 26 Jul 2013 19:19:02 -0400
Message-ID: <20130726231902.GA1674@sigill.intra.peff.net>
References: <1374862320-22637-1-git-send-email-artagnon@gmail.com>
 <20130726191631.GD29799@sigill.intra.peff.net>
 <CALkWK0=qYF=r+Ocb1Z1E=Oteau=AAXR7wnKakt-8Cejwz6Usrg@mail.gmail.com>
 <20130726212438.GA1388@sigill.intra.peff.net>
 <20130726213705.GJ14690@google.com>
 <20130726214036.GB1388@sigill.intra.peff.net>
 <20130726224359.GA3928@sigill.intra.peff.net>
 <20130726230527.GA12968@sigill.intra.peff.net>
 <20130726230857.GK14690@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 27 01:19:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V2rI1-0008WU-FF
	for gcvg-git-2@plane.gmane.org; Sat, 27 Jul 2013 01:19:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760389Ab3GZXTH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Jul 2013 19:19:07 -0400
Received: from cloud.peff.net ([50.56.180.127]:33320 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760365Ab3GZXTE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jul 2013 19:19:04 -0400
Received: (qmail 14770 invoked by uid 102); 26 Jul 2013 23:19:04 -0000
Received: from c-98-244-76-202.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (98.244.76.202)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 26 Jul 2013 18:19:04 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 26 Jul 2013 19:19:02 -0400
Content-Disposition: inline
In-Reply-To: <20130726230857.GK14690@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231217>

On Fri, Jul 26, 2013 at 04:08:57PM -0700, Jonathan Nieder wrote:

> Jeff King wrote:
> 
> > --- a/builtin/commit.c
> > +++ b/builtin/commit.c
> > @@ -63,8 +63,14 @@ N_("The previous cherry-pick is now empty, possibly due to conflict resolution.\
> >  "If you wish to commit it anyway, use:\n"
> >  "\n"
> >  "    git commit --allow-empty\n"
> > +"\n");
> > +static const char empty_cherry_pick_advice_skip_single[] =
> > +N_("Otherwise, please use 'git reset'\n");
> > +static const char empty_cherry_pick_advice_skip_multi[] =
> > +N_("If you wish to skip this commit, use:\n"
> >  "\n"
> > -"Otherwise, please use 'git reset'\n");
> > +"    git reset && git cherry-pick --continue\n"
> > +"\n");
> 
> Hmm, wouldn't it be more consistent to either say
> 
> 	If you wish to commit it anyway, use
> 
> 		git commit --allow-empty && git cherry-pick --continue
> 
> 	If you wish to skip this commit, use
> 
> 		git reset && git cherry-pick --continue

Good point. Clearly the original assumed that you knew to "cherry-pick
--continue", since it is needed (and omitted) in both cases. And perhaps
most people do, but certainly the lack of mentioning it confused both me
and Ram about whether the "git reset" advice was meant to skip or abort.

> Or
> 
> 	If you wish to commit it anyway, use
> 
> 		git commit --allow-empty
> 	
> 	If you wish to skip this commit, use
> 
> 		git reset
> 
> 	Then "git cherry-pick --continue" will resume cherry-picking
> 	the remaining commits.

I like this one better.

You could _almost_ just use the top bit for the single-commit case, but
I hesitate to use the word "skip" in that case. Right now the
single-commit case does not need to make the distinction between "skip
this, and there is nothing else to do" and "abort the operation",
because they are the same thing.  Whichever way the user thinks about it
is OK.

-Peff
