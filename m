From: Jeff King <peff@peff.net>
Subject: Re: Weird behavior of shell variables in git aliases
Date: Tue, 22 Mar 2011 14:32:01 -0400
Message-ID: <20110322183201.GA22534@sigill.intra.peff.net>
References: <d9c38309-c433-476c-bba3-f2c5b7e94a89@k15g2000prk.googlegroups.com>
 <20110321215310.GA2122@sigill.intra.peff.net>
 <7v8vw8nmh2.fsf@alter.siamese.dyndns.org>
 <7v4o6wnlxm.fsf@alter.siamese.dyndns.org>
 <20110322111844.GA32446@sigill.intra.peff.net>
 <20110322132820.GA14559@sigill.intra.peff.net>
 <AANLkTin3fXkGaC5cTVny5adU=FusQV0WAcPHLUEeEzLi@mail.gmail.com>
 <20110322134358.GA19064@sigill.intra.peff.net>
 <7vfwqfkphn.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Lasse Makholm <lasse.makholm@gmail.com>,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Dun Peal <dunpealer@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 22 19:32:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q26NH-00083c-UT
	for gcvg-git-2@lo.gmane.org; Tue, 22 Mar 2011 19:32:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752862Ab1CVScG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Mar 2011 14:32:06 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:44391
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750757Ab1CVScE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Mar 2011 14:32:04 -0400
Received: (qmail 27142 invoked by uid 107); 22 Mar 2011 18:32:42 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 22 Mar 2011 14:32:42 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 22 Mar 2011 14:32:01 -0400
Content-Disposition: inline
In-Reply-To: <7vfwqfkphn.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169759>

On Tue, Mar 22, 2011 at 10:57:08AM -0700, Junio C Hamano wrote:

> The first addition is indeed a huge improvement.
> 
>     Note that any argument you pass when running aliases are simply
>     appended to the shell command.
> 
> The original didn't explicitly say it but it really should have.  The
> example that comes before it, "alias.new = !...", should be updated with
> an invocation that takes a parameter, perhaps like this:
> 
>     With this alias defined:
> 
> 	[alias] since = "!gitk --all --since"
> 
>     you can view commits in the last week with:
> 
>         $ git since 7.days
> 
>     because this expands to "gitk --all --since 7.days" by concatenating
>     the arguments supplied at runtime to the alias.
> 
> Then say that "Note ..." to stress that point.  The description at that
> point has become much better.
> 
> With that understanding already there,
> 
>     This means that "alias.foo = !echo $# args: $1, $2 and $3" will
>     not do what you expect.
> 
> is no longer true; nobody sane would expect that if you made them realize
> that "simply appended" already.  Just dropping that sentence would make
> the resulting text flow much better.

Agreed, your version is better.

>     If you want to refer to arguments given to the alias, you can
>     wrap it as a shell script, e.g.
> 
> 	[alias] reversed = "!sh -c 'echo $2 $1' -"
> 
>     or a shell function, e.g.
> 
> 	[alias] reversed = "!reversed() { echo $2 $1 } && reversed"
> 
>     and invoke it like so:
> 
> 	$ git reversed one two
>         two one
> 
> I personally think the former "sh -c <str> -" is the more traditional and
> well understood form (iow, an idiom) for people who breathe shells.

Yeah, that is probably true. One advantage of the function idiom is that
it doesn't happen inside single-quotes, so it's one less layer of
quoting to deal with. And of course it saves a shell invocation. So I
think mentioning both is reasonable.

> > +----------------------
> > +alias.foo = !echo $# args: $1, $2 and $3
> > +----------------------
> 
> While I totally agree with the formatting advice you gave here, we may
> want to avoid this notation; neither "git config alias.foo = !echo ..."
> nor writing "alias.foo = ..."  in .git/config file would work.

Yeah, I didn't even think about that, but you are right.

-Peff
