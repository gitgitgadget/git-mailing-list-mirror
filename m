From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: [PATCH v3] completion: add new _GIT_complete helper
Date: Mon, 7 May 2012 01:32:35 +0200
Message-ID: <20120506233235.GN2164@goldbirke>
References: <1336231400-6878-1-git-send-email-felipe.contreras@gmail.com>
	<20120506111425.GJ2164@goldbirke>
	<CAMP44s3xwgsfjZA6r+bydu-5r1nEO5cGc=wcDSr+WdwunTtpwg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 07 01:32:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SRAwd-0003Ep-N8
	for gcvg-git-2@plane.gmane.org; Mon, 07 May 2012 01:32:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754681Ab2EFXcs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 6 May 2012 19:32:48 -0400
Received: from moutng.kundenserver.de ([212.227.126.186]:59050 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754338Ab2EFXcr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 May 2012 19:32:47 -0400
Received: from localhost6.localdomain6 (p5B130CE2.dip0.t-ipconnect.de [91.19.12.226])
	by mrelayeu.kundenserver.de (node=mreu3) with ESMTP (Nemesis)
	id 0M3q7C-1S9EPt23us-00rlpO; Mon, 07 May 2012 01:32:39 +0200
Content-Disposition: inline
In-Reply-To: <CAMP44s3xwgsfjZA6r+bydu-5r1nEO5cGc=wcDSr+WdwunTtpwg@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Provags-ID: V02:K0:7xuhQk3+D7klJLEoaCkSCLJqG2FnCG524bQ9C1hfbhr
 kpyEjxXWPCVXspFifWH+Ur/BtXia24r4FDhF0YCYcm+ZlVMdV3
 eRPMzLAj0a9FKgb71Nbq3+Ujh9XKuhzvnswr0H+VAc5sQkydYm
 T77wqrDdfUNpvN+xXUoR8HWz5X4wsAzCqrNoam6EX1toNN1PPA
 PoOYyp7dzSGWQtaK6YgJUws7/wuiTguy0NzvQq3POI5M1yu5wh
 Tn/s4IFrNNpCZlgHf+Wp3XFz9PH3Pf4/Hds4t23+YaXKFZrnIy
 /mD/yIZ7mw3cQOIqyeTzTMj/iBMf5kvLougTpL2/eOhKVArydr
 zCczUOfWiB0Hyyjidlro=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197221>

Hi,


On Sun, May 06, 2012 at 10:37:06PM +0200, Felipe Contreras wrote:
> On Sun, May 6, 2012 at 1:14 PM, SZEDER G=E1bor <szeder@ira.uka.de> wr=
ote:
> > On Sat, May 05, 2012 at 05:23:20PM +0200, Felipe Contreras wrote:
> >> This simplifies the completions, and makes it easier to define ali=
ases:
> >>
> >> =A0_GIT_complete gf git_fetch
> >
> > So, 'gf' is an alias for 'git fetch', for which the user would like=
 to
> > use the completion for 'git fetch', right? =A0But that completion
> > function is caled _git_fetch(), so the underscore prefix is missing
> > here.
>=20
> No, it's not missing:
>=20
>        local name=3D"${2-$1}"
>        eval "$(typeset -f __git_func_wrap | sed -e "s/__git_func/_$na=
me/")"
>        complete -o bashdefault -o default -o nospace -F _${name}_wrap
> $1 2>/dev/null \
>                || complete -o default -o nospace -F _${name}_wrap $1
>=20
> See how we add '_' before $name?

Indeed, the '_' is added before $name no less than three times.  How
could I have missed that?! ;)  It would be better to do it once and be
done with it.

> There's not point in burdening the
> user with adding a prefix that will _always_ be there anyway.

I don't think it's that much of a burden.  The function is called
_git_fetch, use that as second argument

> > Besides, this example won't work, because the completion for 'git
> > fetch' uses __git_complete_remote_or_refspec(), which in turn relie=
s
> > on finding out the name of the git command from the word on the
> > command line, and it won't be able to do that from 'gf'.
>=20
> That's irrelevant, it's an example;=20

It's relevant; if you give an example, then at least that example
should work properly, don't you think?

> replace with another command that
> doesn't use 'words', and it would work.

That it doesn't work has nothing to do with $words.  The problem is tha=
t
__git_complete_remote_or_refspec() expects to find the git command in
${words[1]}, but in case of an alias it can't.

> > I remember we discussed this in an earlier round, and you even
> > suggested a possible fix (passing the command name as argument to
> > __git_complete_remote_or_refspec()). =A0I think that's the right th=
ing
> > to do here.
>=20
> Yeah, but I suggested that in order to avoid the eval and the typeset
> that I require for future future patches, but it turns out it's still
> needed anyway, so my suggestion is to have a 'cmd' variable that
> stores the command; __git_func_wrap would take the responsibility of
> doing that.

Well, now I suggest to do that to fix
__git_complete_remote_or_refspec(), because that seems to be the
easiest, cleanest, and fastest solution.

> >> + =A0 =A0 __git_func "$@"
> >
> > What is this "$@" for and why? =A0None of the _git_<cmd>() function=
s
> > take any arguments, nor does _git() and _gitk(), and AFAICT Bash wo=
n't
> > pass any either.
>=20
> bash's complete passes 3 arguments.

Oh, indeed; the first argument is the command name, the second is the
current word, and the third is the previous word.  All these are
available in our completion functions as ${words[0]}, $cur, and $prev,
respectively.

> They might not be used, but it
> doesn't hurt to pass them either.

They _are_ not used, so passing them has no benefit either.  I would
rather stick to using $cur and $prev than $2 and $3.


Best,
G=E1bor
