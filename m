From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: [PATCH 1/2] reflog: make the 'show' subcommand really the default
Date: Thu, 22 Apr 2010 15:57:31 +0200
Message-ID: <20100422135731.GS4440@neumann>
References: <1271670750-30297-1-git-send-email-szeder@ira.uka.de>
	<7veiiblzn9.fsf@alter.siamese.dyndns.org>
	<20100420113736.GA22907@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Apr 22 15:58:02 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O4wul-00074q-L8
	for gcvg-git-2@lo.gmane.org; Thu, 22 Apr 2010 15:58:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755126Ab0DVN5i convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 22 Apr 2010 09:57:38 -0400
Received: from francis.fzi.de ([141.21.7.5]:59205 "EHLO exchange.fzi.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755105Ab0DVN5h (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Apr 2010 09:57:37 -0400
Received: from [127.0.1.1] ([141.21.4.196]) by exchange.fzi.de over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 22 Apr 2010 15:57:32 +0200
Content-Disposition: inline
In-Reply-To: <20100420113736.GA22907@coredump.intra.peff.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-OriginalArrivalTime: 22 Apr 2010 13:57:32.0451 (UTC) FILETIME=[C113BF30:01CAE223]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145529>

Hi,

On Tue, Apr 20, 2010 at 07:37:36AM -0400, Jeff King wrote:
> On Mon, Apr 19, 2010 at 05:46:02PM -0700, Junio C Hamano wrote:
>=20
> > I am not convinced that this is a good change.
> >=20
> > It may be that show/expire/delete happens to be the _only_ subcomma=
nds
> > today, but if we had this patch, the command will change the behavi=
our
> > when we add a new subcommand (the name of that subcommand may happe=
n to be
> > also a refname).
>=20
> I don't think it is that big a deal. Scripts should always use the
> explicit "git reflog show <ref>" form, which will remain safe. "git
> reflog <ref>" is handy for humans.
>=20
> That being said, we tried this same experiment with "git stash [show]
> <msg>" and ended up rejecting it. However, the main complaint with th=
at
> was the failure mode for typos. Typing "git stash sohw" would make a =
new
> stash.

I think you meant "git stash [save] <msg>" here, right?

http://thread.gmane.org/gmane.comp.version-control.git/63566/focus=3D63=
645

> In this case, typing "git reflog exipre" would get you:
>=20
>   fatal: ambiguous argument 'exipre': unknown revision or path not in
>   the working tree.
>   Use '--' to separate paths from revisions
>=20
> and you would repeat the command with the typo fixed, which is perhap=
s
> not as bad. And unlike stash, "show" is really the dominant command (=
I
> don't think I have ever manually used 'delete' or 'expire'), so it is
> more likely to be right than not.

If I understood Junio correctly, he is concerned about a different
case.

With my patch "git reflog foo" would show foo's reflog, assuming there
is a branch named "foo".  This is what people would expect according
to the documentation.  However, once we implement the subcommand
"foo", "git reflog foo" will no longer print foo's reflog but instead
will perform whatever the subcommand "foo" is supposed to do by
default, which might be difficult to recover from.

> The current behavior is also weirdly inconsistent:
>=20
>   git reflog ;# works, shows HEAD
>   git reflog -p ;# works, shows HEAD with -p
>   git reflog -p foo ;# works, shows foo with -p
>   git reflog foo ;# does not work
>=20
> I can see allowing the first two, but the fact that the third works a=
nd
> the fourth doesn't seems odd to me.

Indeed.  I tried to whip up a patch to fix the documentation to match
the current behaviour, but my first attempt failed because of these
inconsistencies.

> However, I personally "git log -g [--oneline]" to be
> much easier to remember to use and to type.

Just as sidenote:  I rarely use reflog, but then for me it's easier to
remember to "reflog" than "-g".  But even then I never remember "show"
for the first time, that's why I wrote this patch.


Best,
G=E1bor
