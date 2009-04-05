From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: Running 'git pull' from an unnamed branch
Date: Mon, 6 Apr 2009 00:08:55 +0200
Message-ID: <20090405220855.GA20356@atjola.homenet>
References: <3f4fd2640904051433u199587c3wc9bf080d138944e7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: Reece Dunn <msclrhd@googlemail.com>
X-From: git-owner@vger.kernel.org Mon Apr 06 00:10:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LqaXv-000695-2r
	for gcvg-git-2@gmane.org; Mon, 06 Apr 2009 00:10:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753741AbZDEWJA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 5 Apr 2009 18:09:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752966AbZDEWI7
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Apr 2009 18:08:59 -0400
Received: from mail.gmx.net ([213.165.64.20]:48771 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752318AbZDEWI7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Apr 2009 18:08:59 -0400
Received: (qmail invoked by alias); 05 Apr 2009 22:08:56 -0000
Received: from i59F56377.versanet.de (EHLO atjola.local) [89.245.99.119]
  by mail.gmx.net (mp067) with SMTP; 06 Apr 2009 00:08:56 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX1/ySdVqN17y0a61MPec1dKD5ijlByiffqIpZ7E+5y
	ZI6uB07tXBH4Mk
Content-Disposition: inline
In-Reply-To: <3f4fd2640904051433u199587c3wc9bf080d138944e7@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115725>

On 2009.04.05 22:33:57 +0100, Reece Dunn wrote:
> $ git pull
> You asked me to pull without telling me which branch you
> want to merge with, and 'branch..merge' in
> your configuration file does not tell me either.  Please
> name which branch you want to merge on the command line and
> try again (e.g. 'git pull <repository> <refspec>').
> See git-pull(1) for details on the refspec.
>=20
> If you often merge with the same branch, you may want to
> configure the following variables in your configuration
> file:
>=20
>     branch..remote =3D <nickname>
>     branch..merge =3D <remote-ref>
>     remote.<nickname>.url =3D <url>
>     remote.<nickname>.fetch =3D <refspec>
>=20
> See git-config(1) for details.
>=20
> $ git branch
> * (no branch)
>   master
>=20
> Running `git checkout master && git pull` fixed the above issue. The
> patch below improves the error message for users that are in this
> state.

It doesn't "fix" anything, you're simply doing something different.

"git pull" while on a detached HEAD can't work, there are no defaults
that could be used. But e.g. "git pull origin master" would do, fetchin=
g
"master" from "origin" and merging it to the commit you have checked
out.

Your "git checkout master && git pull" does something else. It uses the
configured pull defaults for "master" to fetch something and merge it t=
o
"master".

> Also, is "branch..remote" valid? Should this be "branch.remote"?

That's a bug, but it should not be branch.remote. The config setting is
branch.<name>.remote. As you were on a detached HEAD, there is no
"<name>", and the code that generates the error message doesn't handle
that correctly. I'd even say that in this case, the whole "If you often
merge ..." part makes no sense at all, you simply can't setup pull
defaults for a detached HEAD.

> +	echo "You may not be on a branch. In this case, you need to move"
> +	echo "onto the branch you want to pull to (usually master):"

Hm? Neither do you really need to move to a branch, nor is "master"
really _that_ special that it is warranted to recommend checking it
out... IMHO.

Bj=F6rn
