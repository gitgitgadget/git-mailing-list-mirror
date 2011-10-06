From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: Git Bug report
Date: Thu, 6 Oct 2011 02:33:18 +0200
Message-ID: <20111006003318.GA9015@goldbirke>
References: <1317763443.17036.15.camel@skyplex> <20111005072235.GA12600@kolya>
	<7vlisz8jur.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Fredrik Gustafsson <iveqy@iveqy.com>,
	Federico Lucifredi <federico@canonical.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 06 02:33:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RBbtv-0002uy-CN
	for gcvg-git-2@lo.gmane.org; Thu, 06 Oct 2011 02:33:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935455Ab1JFAdV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 5 Oct 2011 20:33:21 -0400
Received: from moutng.kundenserver.de ([212.227.17.10]:54864 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757843Ab1JFAdV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Oct 2011 20:33:21 -0400
Received: from localhost6.localdomain6 (p5B131283.dip0.t-ipconnect.de [91.19.18.131])
	by mrelayeu.kundenserver.de (node=mreu4) with ESMTP (Nemesis)
	id 0LvLjr-1R3OO51cDj-010gBM; Thu, 06 Oct 2011 02:33:18 +0200
Content-Disposition: inline
In-Reply-To: <7vlisz8jur.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Provags-ID: V02:K0:zMKCqVXrV5pUOy93olA14NMU3/2/569RT51RN+QpYiD
 hCDgBjipgoHSxCq5TDYbiKk3QQV5jU40H1C/U3yc3IqAOYXu0t
 i9coeU4QJ8BQWKcIk3YsnVoO2adajxCfGeTEohfw2iowoD0uvw
 Cu8wKwMY2NFFJbmh4sEdkxtsxBsbDGmtoUU/xQjjVexbMxL98i
 boszXxLJgpeDimdbd0tppd1bgL9qd/IZVp5nZuVmuJm/V1MtIa
 bKENeleCfvMVJsicON/82aanouAvEBxpw3G59UHnXWES0dB6et
 70OMu0FulI/qdGM+R0lLb7AWQcSMSOXPEBExMypsgAmLdjh1Ia
 jUDdJXaNjwq09fYb59HU=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182906>

On Wed, Oct 05, 2011 at 09:49:00AM -0700, Junio C Hamano wrote:
> Fredrik Gustafsson <iveqy@iveqy.com> writes:
>=20
> > On Tue, Oct 04, 2011 at 05:24:03PM -0400, Federico Lucifredi wrote:
> >>  Found a minor bug in git today - the error message reported is no=
t
> >> correct when trying to access a repo that is not accessible
> >> permission-wise:
> >>=20
> >> > federico@skyplex:/etc$ git log
> >> > fatal: Not a git repository (or any of the parent directories): =
=2Egit
> >>=20
> >> with correct access permissions, everything works as expected.
> >
> > So if:
> > .git/ is a directory with not enought permissions.
> > ../.git/ is a directory with enought permissions.
> >
> > git would today use ../.git. You suggest that git instead would die
> > because a .git/ exists? (I'm not saying this is wrong or right).
>=20
> For that matter, if you have .git/ that is a directory but is not a
> repository, and ../.git/ that is, the same situation would arise. I d=
o not
> think we should die because .git/ is not a git repository. I do not k=
now
> if we should even warn about it.

And what about unreadable .git files?

~/tmp/git/outside$ git init
Initialized empty Git repository in /home/szeder/tmp/git/outside/.git/
~/tmp/git/outside$ mkdir inside repo
~/tmp/git/outside$ cd inside/
~/tmp/git/outside/inside$ git init --separate-git-dir=3D../repo
Initialized empty Git repository in /home/szeder/tmp/git/outside/repo/
~/tmp/git/outside/inside$ git rev-parse --git-dir
/home/szeder/tmp/git/outside/repo
~/tmp/git/outside/inside$ chmod a-r .git
~/tmp/git/outside/inside$ git rev-parse --git-dir
fatal: Error opening '.git': Permission denied

Or a non-gitfile .git file?

~/tmp/git/outside/inside$ chmod a+r .git
~/tmp/git/outside/inside$ echo foo >.git
~/tmp/git/outside/inside$ git rev-parse --git-dir
fatal: Invalid gitfile format: .git

Shouldn't these also be ignored?


Best,
G=E1bor
