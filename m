From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] builtin-branch: highlight current remote branches with
	an asterisk
Date: Tue, 10 Feb 2009 06:19:07 -0500
Message-ID: <20090210111907.GD12089@coredump.intra.peff.net>
References: <1234222326-55818-1-git-send-email-jaysoffian@gmail.com> <20090210075214.GC1320@atjola.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jay Soffian <jaysoffian@gmail.com>, git@vger.kernel.org,
	gitster@pobox.com
To: =?utf-8?B?QmrDtnJu?= Steinbrink <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Tue Feb 10 12:20:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWqfN-0005Ou-IB
	for gcvg-git-2@gmane.org; Tue, 10 Feb 2009 12:20:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752750AbZBJLTM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 10 Feb 2009 06:19:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751726AbZBJLTL
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Feb 2009 06:19:11 -0500
Received: from peff.net ([208.65.91.99]:38637 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750887AbZBJLTK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Feb 2009 06:19:10 -0500
Received: (qmail 12395 invoked by uid 107); 10 Feb 2009 11:19:25 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 10 Feb 2009 06:19:25 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 10 Feb 2009 06:19:07 -0500
Content-Disposition: inline
In-Reply-To: <20090210075214.GC1320@atjola.homenet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109208>

[let me answer your email in reverse order, which will hopefully make
more sense when reading]

On Tue, Feb 10, 2009 at 08:52:14AM +0100, Bj=C3=B6rn Steinbrink wrote:

> still don't really see what I'd use it for. From what I've heard, som=
e
> people just consider origin/HEAD a clone artifact without much use, a=
nd
> so far, I think I agree. But maybe there's more to it?

The ref "origin" will resolve to "refs/remotes/origin/HEAD", if it
exists. So you can use it as a shorthand for "origin/master" (or
whatever branch is most interesting to you on the remote).

> If the <name>/HEAD symref would be created for all remotes and would =
get
> updated, that would at least make the marker more meaningful, but I

It has been noted in the past that it should _not_ be automatically
updated, since it is really about "what is the user's preference for th=
e
'most interesting' branch in this remote". And we don't want to
overwrite some preference that they specified.

So I think it makes sense to:

  - if it doesn't exist, set it up based on the remote's HEAD. Clone
    already does this, but "git remote add -f" should probably do it,
    too. I'm not sure if every fetch should do it.

  - give the user some nice interface (probably via "git remote") to
    move the pointer around (right now, it is "git symbolic-ref
    refs/remotes/$remote/HEAD refs/remotes/$remote/$branch").

  - give the user some nice interface to re-fetch the remote HEAD and
    update refs/remotes/$remote/HEAD with it. Probably as an option to
    the "git remote" invocation above.

-Peff
