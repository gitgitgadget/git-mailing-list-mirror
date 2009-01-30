From: Jeff King <peff@peff.net>
Subject: Re: What's cooking in git.git (Jan 2009, #07; Wed, 28)
Date: Thu, 29 Jan 2009 23:59:16 -0500
Message-ID: <20090130045916.GC18655@coredump.intra.peff.net>
References: <7vwscej26i.fsf@gitster.siamese.dyndns.org> <20090129035138.GC11836@coredump.intra.peff.net> <bd6139dc0901290327u572cc30ci9dc719c912fbf875@mail.gmail.com> <20090129113735.GA6505@coredump.intra.peff.net> <351A6988-32EB-473F-B6E5-8FBB38D91F88@ai.rug.nl> <20090129114834.GA10792@coredump.intra.peff.net> <20090129120455.GD3027@denkbrett.schottelius.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Pieter de Bie <pdebie@ai.rug.nl>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Nico -telmich- Schottelius <nico-linux-git@schottelius.org>
X-From: git-owner@vger.kernel.org Fri Jan 30 06:00:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSlUh-00072q-OL
	for gcvg-git-2@gmane.org; Fri, 30 Jan 2009 06:00:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754918AbZA3E7U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Jan 2009 23:59:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751914AbZA3E7T
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Jan 2009 23:59:19 -0500
Received: from peff.net ([208.65.91.99]:36208 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751489AbZA3E7T (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Jan 2009 23:59:19 -0500
Received: (qmail 27048 invoked by uid 107); 30 Jan 2009 04:59:28 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 29 Jan 2009 23:59:28 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 29 Jan 2009 23:59:16 -0500
Content-Disposition: inline
In-Reply-To: <20090129120455.GD3027@denkbrett.schottelius.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107771>

On Thu, Jan 29, 2009 at 01:04:55PM +0100, Nico -telmich- Schottelius wrote:

> I must confess, as a user I would like to do
> 
> 1. create local repo
> 
> 2. create a remote
> 
> 3. push it
> 
> I don't care about creating empty repos somewhere:
> My aim is to publish my work, that's it.

I think people have asked for that before, too. The fundamental problem
is that we don't necessarily know how to create the remote repo, or even
have permissions to do so.

If your transport is vanilla ssh, then in theory we could turn
"host:path.git" into "ssh host 'GIT_DIR=path.git git init'". But for
other transports we are out of luck. And for hosting sites like github,
we are out of luck, as you use the web interface to make a new repo.

>   1.2. When creating a new repo, it would be helpful if I can directly add a
>        description: git init [description] would be nice to have

I don't think there is any fundamental reason not to allow more setup of
internal .git/* files through 'init'. In most cases, you could just as
easily "echo description >.git/description" afterwards, but it might be
slightly more convenient if you are ssh'ing to do it all in one shot.

>   2.1. I (as a user) understand that I need to create a remote where I have to
>        push to. It would be helpful to specify --track-this/--merge-this to
>        have it automatically connected to the current branch

  git remote add -t master origin $URL ?

>   3.1.  I would really like to see something like git push
>         --create[-if-not-exists]. This makes sense for me, but could also
>         be a global configuration option (push.autocreate = true|false).

I think this would be better as a feature of "git remote". I.e.:

  git remote add --create -t master origin $URL

but again, we can only sanely do creation magic in a subset of cases.
Which is why I think nobody has implemented it so far.

-Peff
