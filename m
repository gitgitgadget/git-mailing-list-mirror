From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: [PATCH 02/19] tests: add tests for the bash prompt functions
	in the completion script
Date: Wed, 9 May 2012 22:33:54 +0200
Message-ID: <20120509203354.GC6958@goldbirke>
References: <1336524290-30023-1-git-send-email-szeder@ira.uka.de>
	<1336524290-30023-3-git-send-email-szeder@ira.uka.de>
	<7vvck5ryl2.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 09 22:34:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SSDaB-0000JX-Nr
	for gcvg-git-2@plane.gmane.org; Wed, 09 May 2012 22:34:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761051Ab2EIUdz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 May 2012 16:33:55 -0400
Received: from moutng.kundenserver.de ([212.227.126.187]:52076 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755160Ab2EIUdz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 May 2012 16:33:55 -0400
Received: from localhost6.localdomain6 (p5B1303EC.dip0.t-ipconnect.de [91.19.3.236])
	by mrelayeu.kundenserver.de (node=mreu4) with ESMTP (Nemesis)
	id 0LxHg6-1S3I672LNa-016MtM; Wed, 09 May 2012 22:33:53 +0200
Content-Disposition: inline
In-Reply-To: <7vvck5ryl2.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Provags-ID: V02:K0:DW7Z7Pv8PBViAUZFfB7c0J62kFMZpc4nW9E4pOhagav
 wPcOnhrF4GHN4SFuYWeIc2vDVvOrkZykZTvAwnzB75rZbSFthr
 Sw+Qiexc4GA4ABJxwORXgZUlPpxtXvR6nKtYYOgOW0HwqbXZpv
 cNWz/LxJ773hgsPU+fS+PmSNmCG4ZYvh6VPOpyZKDN/xslKhdL
 Z4wZwVyLOdVMOuMXUQtNJ2X7dPeycFjX4+IZwKwdqpTRm4hPhq
 r0biM4LbrM7XJdzQtA8TEJoKFLoSThWAPSE6kQrVm3LUY3w/n3
 ZCZyLRmVdbWqcFiGKkOl9R0zgP5DTS+S470Tjs92OW0k0oNBm4
 ly9NRQF9XOPIG+ZkxkLI=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197510>

On Wed, May 09, 2012 at 11:36:25AM -0700, Junio C Hamano wrote:
> SZEDER G=E1bor <szeder@ira.uka.de> writes:
>=20
> > The tests cover the discovery of the '.git' directory in the __gitd=
ir()
> > function in different scenarios, and the prompt itself, i.e. branch
> > name, detached heads, operations (rebase, merge, cherry-pick, bisec=
t),
> > and status indicators (dirty, stash, untracked files; but not the
> > upstream status).
> >
> > Signed-off-by: SZEDER G=E1bor <szeder@ira.uka.de>
>=20
> Looks like a quite comprehensive tests around GIT_PS1_$MANY_DIFFERENT=
_STYLES
> (except that GIT_PS1_SHOWUPSTREAM seems to be missing); very nice.

I've mentioned in the commit message that "... status indicators ...
but not the upstream status".  I didn't wrote tests for that because
this series doesn't changes anything in the function producing the
upstream status indicator.

However, thinking about it now, this series, in particular patch 16
(bash prompt: display stash and upstream state even inside the
repository), does change the context in which that function might be
invoked, i.e. not only from the work tree but even from within the
repository.  I don't think that would break anything (famous last
words ;), because that function runs git config, rev-list, and log,
and AFAICT these commands should work in a repository just as well,
and the rest of the function is just preparing their arguments and
processing their output.

Anyway, it would be definitely better to have a test to show that it
indeed works from within a repository, but I didn't want to fiddle
with svn upstreams.  Perhaps patch 16 should leave the upstream status
indicator as it is until someone ;) writes tests for it; since that
function doesn't affect the main codepath and it involves several
subshells and git processes anyway, there is not that much to be
gained anyway.

> > +	echo 1 > file &&
>=20
> When you are going to re-roll to add the missing SHOWUPSTREAM test, i=
n
> addition to J6t's $PWD vs $(pwd) vs $TRASH_DIRECTORY fix, please fix =
these
> redirections to match the coding styles (i.e. "cmd >file" and "cmd <f=
ile",
> with SP before and without SP after redirection operators).

OK.

I just followed suit of the recently added t9902-completion.sh, which
uses SP on both sides of redirection operators.
