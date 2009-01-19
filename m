From: Adeodato =?utf-8?B?U2ltw7M=?= <dato@net.com.org.es>
Subject: Re: [PATCH/RFC] shortlog: add option to group together different
	names/emails of an author
Date: Mon, 19 Jan 2009 14:43:46 +0100
Message-ID: <20090119134346.GA27509@chistera.yi.org>
References: <1231600589-11811-1-git-send-email-dato@net.com.org.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 19 14:45:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LOuRJ-0004SK-Lv
	for gcvg-git-2@gmane.org; Mon, 19 Jan 2009 14:45:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752869AbZASNnx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 19 Jan 2009 08:43:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752806AbZASNnx
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Jan 2009 08:43:53 -0500
Received: from 226.Red-80-25-139.staticIP.rima-tde.net ([80.25.139.226]:2436
	"EHLO etc.inittab.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752475AbZASNnw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Jan 2009 08:43:52 -0500
Received: from chistera.yi.org (unknown [192.168.254.34])
	by etc.inittab.org (Postfix) with ESMTP id 3FDA8801C0E4
	for <git@vger.kernel.org>; Mon, 19 Jan 2009 14:43:50 +0100 (CET)
Received: from userid 1000 by justin with local (Exim 4.69) 
	  id 1LOuPr-0007BK-Bq
	  for git@vger.kernel.org; Mon, 19 Jan 2009 14:43:47 +0100
Content-Disposition: inline
In-Reply-To: <1231600589-11811-1-git-send-email-dato@net.com.org.es>
X-No-CC: Please respect my Mail-Followup-To header
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106358>

Ping? I realize this may be seen as a big patch dropped out of the blue=
,
but I would very much like to hear some comments on at least the featur=
e
itself, which should not take more than reading the commit message.
(Hints as to what to do to get people to comment on the code also
welcome, of course.)

--- Adeodato Sim=C3=B3 [Sat, 10 Jan 2009 16:16:29 +0100]:

> It's common for repositories to contain commits with different spelli=
ngs of
> an author name, or different email addresses. The shortlog command tr=
ies to
> alleviate this by using .mailmap files. However, maintaining a .mailm=
ap file
> up to date is a manual process, and it does not help when shortlog is
> invoked with the -e option and different email addresses for an autho=
r are
> involved.

> This commit introduces a -j/--join-uids option that uses a very dumb =
logic
> to detect different spellings and addresses of a same author. In part=
icular,
> it just joins commits when either the name or the address had been
> previously seen, attaching the commit to that previous id. In other w=
ords,
> these three ids will be joined:

>     Author: Joe Developer <joe@example.com>
>     Author: Joe R. Developer <joe_r@example.com>
>     Author: Joe R. Developer <joe@example.com>

> but only because of the third spelling. The first two alone would be =
left
> separate. When the names and addresses are printed, the most common s=
pelling
> and address are used.

> Incidentally, there is f817546 in git.git which has this author infor=
mation:

>     Author: Wincent Colaiuta <gitster@pobox.com>

> Which makes all of Wincent's commits to be assigned to Junio with -j.=
 This
> is easily fixed with an entry for gitster@pobox.com in .mailmap, whic=
h this
> commit includes. (And then, only f817546 is be assigned to Junio.)

> Signed-off-by: Adeodato Sim=C3=B3 <dato@net.com.org.es>
> ---
> This is my scratching of my own itch: I was used to `bzr author-stats=
`,
> which is equivalent to `git shortlog -jsne`. I realize -sn comes clos=
e,
> but I like having the email address listed. Please let me know what y=
ou
> think.

> Tests and a mention in git-shortlog.txt are missing. That'll come nex=
t
> when/if I'm told this has a chance of inclusion. :-)

> The code is valgrind'ed. I'm not completely confident, though, bugs w=
ill
> not be hiding in corner cases. Also, I don't see any appreciable
> slowdown with this version in git.git, particularly not between the
> current git-shortlog and this new when run without -j (not when run w=
ith
> -j either, but that's less critical).

> This patch applies on top of my as/maint-shortlog-cleanup branch.

>  .mailmap           |    1 +
>  builtin-shortlog.c |  280 ++++++++++++++++++++++++++++++++++++++++++=
+++-------
>  shortlog.h         |   14 ++-
>  3 files changed, 256 insertions(+), 39 deletions(-)

--=20
Adeodato Sim=C3=B3                                     dato at net.com.=
org.es
Debian Developer                                  adeodato at debian.or=
g
=20
Don't be irreplaceable, if you can't be replaced, you can't be promoted=
=2E
