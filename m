From: =?UTF-8?Q?J=C3=B6rg?= Sommer <joerg@alea.gnuu.de>
Subject: Re: [PATCH 2/2] Fix t3404 assumption that `wc -l` does not use
 whitespace.
Date: Mon, 28 Apr 2008 11:40:00 +0000 (UTC)
Message-ID: <slrng1bdsf.25r.joerg@alea.gnuu.de>
References: <20080427151610.GB57955@Hermes.local>
 <alpine.DEB.1.00.0804271620440.16320@eeepc-johanness>
 <7vej8rgq62.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0804281112500.2949@eeepc-johanness>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 28 14:53:21 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JqSqq-0001jP-Ay
	for gcvg-git-2@gmane.org; Mon, 28 Apr 2008 14:53:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765806AbYD1MwP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 Apr 2008 08:52:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763309AbYD1MwO
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Apr 2008 08:52:14 -0400
Received: from banki.eumelnet.de ([83.246.114.63]:4893 "EHLO uucp.gnuu.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932427AbYD1MwJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2008 08:52:09 -0400
Received: by uucp.gnuu.de (Postfix, from userid 10)
	id 90900488033; Mon, 28 Apr 2008 14:52:07 +0200 (CEST)
Received: from news by alea.gnuu.de with local (Exim 4.63)
	(envelope-from <news@alea.gnuu.de>)
	id 1JqRiC-000400-CM
	for git@vger.kernel.org; Mon, 28 Apr 2008 13:40:00 +0200
Path: not-for-mail
Newsgroups: local.mailinglist.git
X-Trace: alea.gnuu.de 1209382800 15374 192.168.0.5 (28 Apr 2008 11:40:00 GMT)
X-Complaints-To: usenet@alea.gnuu.de
User-Agent: slrn/pre0.9.9-102 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80529>

Hi,

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> On Sun, 27 Apr 2008, Junio C Hamano wrote:
>
>> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>>=20
>> > ...  It did not help that I hated the fact that that series change=
d=20
>> > the original design without even understanding it.
>>=20
>> Care to elaborate on this point further?  I do not get it.
>
> The original implementation of -p was modeled closely after filter-br=
anch,=20
> in that it created a subdirectory (dotest/rewritten) containing the n=
ew=20
> commit names for those commits that were rewritten.

But that wasn't the way rebase -i works. You had to jump in before
pick_one does anything which clearly shows you did something different
from the default way.

> Now, whenever a commit was picked, the parents would be looked up in=20
> dotest/rewritten, and replaced with the rewritten name (or left uncha=
nged=20
> if they were not rewritten).

This approach doesn't work when you change the order of commits.
Take the commit A, B and C in this order and reorder them to A C B:
1. pick A, A^ was not rewritten, nothing changed, A stays the same
2. pick C, C^ was not rewritten, nothing changed, C stays the same
3. pick B, B^ was not rewritten, nothing changed, B stays the same

Depending on your handling of the new tip of the branch you loose C or,
as your code did, nothing changed, because you made the assumption the
new HEAD is the rewritten old HEAD.

> Basically, the output of rebase -i -p is ugly now, because you have _=
two_=20
> ways of specifying things,

> I have the feeling that I have to repeat my point again, so that it i=
s not=20
> ignored -- again.  Maybe an example would help:
>
> -- snip --
> pick abcdefg This is the first commit to be picked
> reset cdefghij
> pick zyxwvux A commit in a side-branch
> merge recursive abcdefg
> -- snap --
>
> I am convinced that this syntax does not need much explanation.

But above you said this syntax + mark is =E2=80=9Cugly=E2=80=9D. Strang=
e.

> A patch implementing a syntax like this would have won my unilateral=20
> approval

I doubt this. You refused any changes to your idea and your code from t=
he
beginning. You didn't answer questions and doesn't take part on the
discussion [1] about the new syntax.

Bye, J=C3=B6rg.

[1] <7vabkoufzq.fsf@gitster.siamese.dyndns.org>
--=20
Es gibt nichts sch=C3=B6neres als dem Schweigen eines Dummkopfes zuzuh=C3=
=B6ren.
   	       		      	  	        (Helmut Quatlinger)
