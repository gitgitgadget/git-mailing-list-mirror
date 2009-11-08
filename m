From: Jeff King <peff@peff.net>
Subject: Re: Strange behavior (possible bug) using bash command subsitution
 with "git branch"
Date: Sun, 8 Nov 2009 18:03:00 -0500
Message-ID: <20091108230300.GB17129@coredump.intra.peff.net>
References: <C71C822C.22429%kate@ning.com>
 <20091108224955.GA14095@atjola.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Kate Ebneter <kate@ning.com>, git@vger.kernel.org
To: =?utf-8?B?QmrDtnJu?= Steinbrink <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Mon Nov 09 00:03:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N7Gn0-0006Cn-IG
	for gcvg-git-2@lo.gmane.org; Mon, 09 Nov 2009 00:03:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755707AbZKHXDI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 Nov 2009 18:03:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755695AbZKHXDH
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Nov 2009 18:03:07 -0500
Received: from peff.net ([208.65.91.99]:45811 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755255AbZKHXDH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Nov 2009 18:03:07 -0500
Received: (qmail 23821 invoked by uid 107); 8 Nov 2009 23:06:57 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sun, 08 Nov 2009 18:06:57 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 08 Nov 2009 18:03:00 -0500
Content-Disposition: inline
In-Reply-To: <20091108224955.GA14095@atjola.homenet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132427>

On Sun, Nov 08, 2009 at 11:49:55PM +0100, Bj=C3=B6rn Steinbrink wrote:

> > I ran into a weird situation while working on a script, which is be=
st
> > described with a little snippet from my gitosis-admin repository:
> >=20
> >     $ git branch
> >     * master
>      ^^^
>=20
> >     $ branch=3D$(git branch)
> >     $ echo $branch
> >     gitosis.conf keydir master
>=20
> Your shell expands the *, thus echo sees all the things in the curren=
t
> directory. Use 'echo "$branch"' and you'll see what you expected.

And more to the point, this is just one reason why one should use
for-each-ref when scripting (the other is that git-branch's output is
considered porcelain, and is not guaranteed to remain stable). E.g.:

  git for-each-ref --format=3D'%(refname:short)' refs/heads/

would produce the output the original poster wanted.

-Peff
