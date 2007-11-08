From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: git rebase --skip
Date: Thu, 8 Nov 2007 11:24:12 +0100
Message-ID: <20071108102412.GA31187@atjola.homenet>
References: <20071107222105.GA31666@glandium.org> <20071108032308.GA5638@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Mike Hommey <mh@glandium.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Nov 08 11:24:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iq4Yq-00015N-Aw
	for gcvg-git-2@gmane.org; Thu, 08 Nov 2007 11:24:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753946AbXKHKYR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 8 Nov 2007 05:24:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753005AbXKHKYR
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Nov 2007 05:24:17 -0500
Received: from mail.gmx.net ([213.165.64.20]:38719 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753473AbXKHKYQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Nov 2007 05:24:16 -0500
Received: (qmail invoked by alias); 08 Nov 2007 10:24:14 -0000
Received: from i577B8015.versanet.de (EHLO localhost) [87.123.128.21]
  by mail.gmx.net (mp012) with SMTP; 08 Nov 2007 11:24:14 +0100
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX1/ghHQWhYDgmLqHqS2tMp4Yg40vHM1n2sZQxWAu+B
	vlRtwEC99Q2wkx
Content-Disposition: inline
In-Reply-To: <20071108032308.GA5638@sigill.intra.peff.net>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63991>

On 2007.11.07 22:23:10 -0500, Jeff King wrote:
> On Wed, Nov 07, 2007 at 11:21:05PM +0100, Mike Hommey wrote:
>=20
> > I use git-rebase quite regularly, and I haven't used git-rebase --s=
kip
> > after a failed merge without first resetting the working tree. I wa=
s
> > wondering if it wouldn't make sense to automatically do the reset w=
hen
> > running git-rebase --skip.
>=20
> I have often been annoyed by this behavior, too, and I can't think of
> any situation where you _wouldn't_ want the reset to happen.  But I
> would be more comfortable hearing confirmation from others that they
> can't think of such a situation.

Let's take this history:

      C---D---E topic
     /
    A---B master

You then do:
git rebase master topic

Now D causes conflicts, because B did a similar change, but not quite
the same, maybe having a bug. So you want to keep parts of D, but it's
no longer the same commit semantically and the original commit message
would be bogus. So you resolve the conflicts and do:

git commit
git rebase --skip

Because you replaced D with a new different commit, instead of really
just rebasing it. With plain --continue, you'd have to go back and fix
the commit message once the rebase is complete. And --continue after th=
e
commit is a no-go, too, because rebase will complain that there's
nothing left to produce the rebased D commit.

And now imagine that you forget to commit but instead just --skip.
Ouch, all the work is lost, time to restart the rebase. With the curren=
t
behaviour, rebase won't just throw away your stuff.

Bj=F6rn
