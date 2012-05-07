From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: [PATCH v3] completion: add new _GIT_complete helper
Date: Mon, 7 May 2012 11:22:13 +0200
Message-ID: <20120507092213.GO2164@goldbirke>
References: <1336231400-6878-1-git-send-email-felipe.contreras@gmail.com>
	<20120506111425.GJ2164@goldbirke>
	<CAMP44s3xwgsfjZA6r+bydu-5r1nEO5cGc=wcDSr+WdwunTtpwg@mail.gmail.com>
	<20120506233235.GN2164@goldbirke>
	<CAMP44s3q-X7W5qeu6LZzu13C6SfhEZy9i4AfJ9Sszcou52MsGw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 07 11:22:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SRK9E-0003hp-VA
	for gcvg-git-2@plane.gmane.org; Mon, 07 May 2012 11:22:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755896Ab2EGJWX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 7 May 2012 05:22:23 -0400
Received: from moutng.kundenserver.de ([212.227.126.187]:59738 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755739Ab2EGJWW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 May 2012 05:22:22 -0400
Received: from localhost6.localdomain6 (p5B13051B.dip0.t-ipconnect.de [91.19.5.27])
	by mrelayeu.kundenserver.de (node=mrbap1) with ESMTP (Nemesis)
	id 0MWQQM-1SgGmC12Mc-00Xhce; Mon, 07 May 2012 11:22:14 +0200
Content-Disposition: inline
In-Reply-To: <CAMP44s3q-X7W5qeu6LZzu13C6SfhEZy9i4AfJ9Sszcou52MsGw@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Provags-ID: V02:K0:iH26Sa+Ffct7aGn7laYU+OxJ40GB8T/7peXgkzu6iYC
 oWLtR0XFptSJEFn7o5Ch6Fvu2vjlq4ZsXdLBgPPuceqPpPNiaf
 M/WZX+pxI+uOjT+YUeaNJENU4EaGP6A8LAq6Scy//YxrSTuBTd
 8QxYD2196YhMTxTXDL5LoI+4B/YfHrZHQ/1Li0qAkD3X3BrGDn
 p5BO2EyqUnb7XSs92x91oc95gIzQq6xzfoAp3IO4st4/CcyLNn
 43n9cPk5+xwjxNZb7BMjcDLgK2fxkrLCHkLKlA4ogkOJGwE2Zl
 M/H5KBG+lvJvvDhQuTa3NGGSBDlXndP7KGkJE7J6EVEheTPxqV
 jzRlXdJd0mkOR0YsFeyk=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197246>

Hi,


On Mon, May 07, 2012 at 02:20:54AM +0200, Felipe Contreras wrote:
> In fact, it could be even simpler:
>=20
> _GIT_complete gf fetch

That would be even better; just need to take care of 'cherry-pick' and
the like.

> >> > Besides, this example won't work, because the completion for 'gi=
t
> >> > fetch' uses __git_complete_remote_or_refspec(), which in turn re=
lies
> >> > on finding out the name of the git command from the word on the
> >> > command line, and it won't be able to do that from 'gf'.

> It does work... on my branch.

I though the patch was supposed to be applied on git.git's master.  I
didn't know what else you had on your branch, obviously.

> If you have another example that works, feel free to suggest it

I played around with 'gb' as 'git branch' and 'gc' as 'git checkout',
they seemed to work properly, and they both use $words directly or
indirectly.  I suspect most of them Just Works, except those using
__git_complete_remote_or_refspec(), and _git_bundle() as you mention
below, and perhaps a few surprises we hadn't spotted yet.

> >> replace with another command that
> >> doesn't use 'words', and it would work.
> >
> > That it doesn't work has nothing to do with $words. =A0The problem =
is that
> > __git_complete_remote_or_refspec() expects to find the git command =
in
> > ${words[1]}, but in case of an alias it can't.
>=20
> ${words[1]} is part of $words.

The problem is not with $words per se, but with the '1'.

> And BTW, git bundle also fails similarly.

Indeed; using __git_find_on_cmdline() and checking which subcommand it
found, if any, would allow us to get rid of all numbers from that
function.

> Also BTW, git fetch is already broken anyway:
>=20
>  git --no-pager fetch <TAB>
>=20
> So don't blame my patch :)

Yeah, I know, but that's broken since "forever".  However, I think
that would be a separate, though related topic, because it's not
required to make completion for alias work.

> >> > I remember we discussed this in an earlier round, and you even
> >> > suggested a possible fix (passing the command name as argument t=
o
> >> > __git_complete_remote_or_refspec()). =A0I think that's the right=
 thing
> >> > to do here.

> That's not enough to make 'git fetch' work, try it.

As already mentioned it earlier in this thread, the iteration over
$words in __git_complete_remote_or_refspec() have to be fixed, too.

> >> >> + =A0 =A0 __git_func "$@"

> Sure, but it was just 4 more characters that didn't hurt anybody. You=
r
> version makes passing those arguments more difficult, so I see no nee=
d
> to try to implement that.

OK.  I doesn't hurt, but I think it's more important to avoid
fork()+exec() overheads than to pass arguments whose values are
readily available in other variables anyway.


G=E1bor
