From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] git remote update: New option --prune (-p)
Date: Thu, 2 Apr 2009 12:32:13 -0400
Message-ID: <20090402163213.GA28261@coredump.intra.peff.net>
References: <20090402123823.GA1756@pvv.org> <9b18b3110904020634i17633645ue4ba91701ea243a1@mail.gmail.com> <20090402134414.GB26699@coredump.intra.peff.net> <9b18b3110904020717h3a0d4b34h7f4b2b83527e6743@mail.gmail.com> <20090402143112.GA26974@coredump.intra.peff.net> <9b18b3110904020907i23f246aelccc2a0770acc2574@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Finn Arne Gangstad <finnag@pvv.org>, git@vger.kernel.org,
	gitster@pobox.com
To: demerphq <demerphq@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 02 18:34:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LpPrh-0002xE-Lj
	for gcvg-git-2@gmane.org; Thu, 02 Apr 2009 18:34:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762575AbZDBQca (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Apr 2009 12:32:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761715AbZDBQc3
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Apr 2009 12:32:29 -0400
Received: from peff.net ([208.65.91.99]:47962 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760436AbZDBQc2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Apr 2009 12:32:28 -0400
Received: (qmail 27158 invoked by uid 107); 2 Apr 2009 16:32:44 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 02 Apr 2009 12:32:44 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 02 Apr 2009 12:32:13 -0400
Content-Disposition: inline
In-Reply-To: <9b18b3110904020907i23f246aelccc2a0770acc2574@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115476>

On Thu, Apr 02, 2009 at 06:07:33PM +0200, demerphq wrote:

> Er, personally i find that documentation pretty cryptic. And when i
> check git config for group, i see this:
> 
>        remotes.<group>
>            The list of remotes which are fetched by "git remote update
>            <group>". See git-remote(1).

Yeah, this should probably say "separated by space" or whatever (I
actually don't even know). I would assume it contains the remote name; I
can't imagine what other thing it would include. But it wouldn't hurt to
make that more explicit.

I'm sure a documentation patch would be welcome.

>        remote.<name>.skipDefaultUpdate
>            If true, this remote will be skipped by default when updating using
>            the update subcommand of git-remote(1).
>
> Neither of which really explain groups, how to define them properly,
> (the list is separated by what? and includes the remote name?) or
> whether there are implicit groups. I mean, it seems logical that if
> you can have user defined groups that there are some built in ones
> too, like "all" and "none" or perhaps groups defined by transport
> "http" or "git" for instance.

I think what is confusing is that there is exactly one implicit group,
and it is "the default group", which contains every remote that doesn't
have skipDefaultUpdate set. You refer to the "default group" by not
mentioning any group.

So no, there aren't other implicit groups (AFAIK).

You can propose implicit groups, but I think they would have to have a
compelling use case over simply creating them manually. To avoid
conflict with groups people have already defined, they would only be
used if no remotes.$whatever config existed.

I think having "git remote update foo" fall back to a group containing
only the remote "foo" when "remotes.foo" does not exist makes sense.
I'm not sure that "none", "http", or "git" is all that useful in
practice (the only thing I can think of for the latter two is that you
might use "git" versus "http" depending on restrictive firewall
settings).

You could give the unnamed "default group" a name (like "all"), but then
you risk conflict with existing "remotes.all". And in this case, it is
hard to remain backwards compatible: "git remote update" will do
something different now in the case that the user has configured
remotes.all.

-Peff
