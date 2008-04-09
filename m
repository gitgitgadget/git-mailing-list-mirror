From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: git annoyances
Date: Wed, 9 Apr 2008 12:41:25 +0200
Message-ID: <20080409104125.GA16607@atjola.homenet>
References: <20080409101428.GA2637@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
X-From: git-owner@vger.kernel.org Wed Apr 09 12:42:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JjXkr-00045s-Dd
	for gcvg-git-2@gmane.org; Wed, 09 Apr 2008 12:42:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753022AbYDIKl3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 Apr 2008 06:41:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753021AbYDIKl3
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Apr 2008 06:41:29 -0400
Received: from mail.gmx.net ([213.165.64.20]:41505 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752898AbYDIKl3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Apr 2008 06:41:29 -0400
Received: (qmail invoked by alias); 09 Apr 2008 10:41:26 -0000
Received: from i577BA362.versanet.de (EHLO atjola.local) [87.123.163.98]
  by mail.gmx.net (mp012) with SMTP; 09 Apr 2008 12:41:26 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX18oKzZQrY0o45GDA/kEBfkpi6VJyk6KQ6zBU/5bgs
	fqk2LRR9jsGdA4
Content-Disposition: inline
In-Reply-To: <20080409101428.GA2637@elte.hu>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79100>

On 2008.04.09 12:14:28 +0200, Ingo Molnar wrote:
>=20
> i just had a rather annoying session with git - here's the dump and=20
> commentary, in case anyone is interested in usability fineprint.
>=20
> it was with git-core-1.5.4.3-2.fc8 - so if it's all fixed/improved in=
=20
> 1.5.5, or if this is blatant user error for which i deserve to be=20
> punished then my apologies!
>=20
> usually i just have a single git repo that tracks everything=20
> interesting, but this time i did something i rarely do: i tried to me=
rge=20
> one local tree of mine into another local tree of mine. So i had no=20
> commands (or even concepts) cached in my short-term memory that would=
=20
> achieve this goal, i just tried the commands that i thought to be=20
> 'obvious', without applying much (or any) IQ to those commands:
>=20
>  $ cd linux-2.6-sched-devel.git
>=20
>  $ git-remote add ~/linux-2.6-x86.git
>=20
>  $ git-remote show x86
>   * remote x86
>     URL: /home/mingo/linux-2.6-x86.git
>   New remote branches (next fetch will store in remotes/x86)
                         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

I gues that's key here. The remote was added, but you don't actually
have fetched the branches yet. Thus the merge fails, but the pull with
the correct syntax succeeded, because it does a fetch first.

>   base for-akpm for-linus latest master testing
>=20
>  $ git-merge x86/latest
>  x86/latest - not something we can merge
>=20
>  #
>  # ho hum. Not something 'we' can merge. Do i care? :-) There's no=20
>  # actionable reference given to the user about how to resolve this=20
>  # problem. So i kept on trying:
>  #

No branch, no merge ;-)

>  $ git-fetch x86/latest
>  fatal: 'x86/latest': unable to chdir or not a git archive
>  fatal: The remote end hung up unexpectedly
>=20
>  $ git-pull x86/latest
>  fatal: 'x86/latest': unable to chdir or not a git archive
>  fatal: The remote end hung up unexpectedly
>=20
>  #
>  # hm. two fatal messages, suggesting that there's something really=20
>  # wrong while there's nothing wrong.
>  #

The syntax is "git pull <repository> <refspec>"

So you're trying to fetch/pull from a repository in "x86/latest", that
path doesn't exist and that is pretty fatal as you cannot fetch/pull
from a repository that doesn't exist.

> what got me going after experimenting around some more was this exact=
=20
> command:
>=20
>  $ git-pull x86 latest
>=20
> (that fetch+merge went problem-free.)

Yeah, correct syntax and pull does the fetch for you.

> also, the first natural thing i did was to just type:
>=20
>  $ git-merge ~/linux-2.6-x86.git/
>=20
> which i naively assumed would sort things out for me and provide some=
=20
> reasonable default behavior - but instead it just gave an annoyingly=20
> unhelpful error message:
>=20
>  /home/mingo/linux-2.6-x86.git/ - not something we can merge

AFAIK merge cannot handle stuff that's outside your repo. To merge stuf=
f
from another repo without adding a remote, you have to use pull (or
manually do the fetch+merge dance), ie.:

git pull ~/linux-2.6-x86.git latest

should do.

Bj=F6rn
