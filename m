From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: [PATCH v2] tests: add initial bash completion tests
Date: Tue, 17 Apr 2012 12:22:15 +0200
Message-ID: <20120417102215.GA22778@goldbirke>
References: <1334181423-4391-1-git-send-email-felipe.contreras@gmail.com>
	<20120417003100.GB2299@goldbirke>
	<CAMP44s1CTCPThri6mq0NTvD27WTEiwLTfhHCw+nD+8YwApwL=g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>, Jeff King <peff@peff.net>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 17 12:22:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SK5YY-0000py-Tt
	for gcvg-git-2@plane.gmane.org; Tue, 17 Apr 2012 12:22:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752969Ab2DQKWd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 17 Apr 2012 06:22:33 -0400
Received: from moutng.kundenserver.de ([212.227.126.171]:54512 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752874Ab2DQKWb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Apr 2012 06:22:31 -0400
Received: from localhost6.localdomain6 (p5B1306D0.dip0.t-ipconnect.de [91.19.6.208])
	by mrelayeu.kundenserver.de (node=mreu1) with ESMTP (Nemesis)
	id 0MXkot-1So2jn0oyd-00WGQA; Tue, 17 Apr 2012 12:22:16 +0200
Content-Disposition: inline
In-Reply-To: <CAMP44s1CTCPThri6mq0NTvD27WTEiwLTfhHCw+nD+8YwApwL=g@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Provags-ID: V02:K0:wZTeduLKBnTRaWdgfcOvZev+qPfiPeaF9nDC0D6FkDv
 ylXeLHxOoUpdGosqSHoYvJ/H4lUsGzIlji5AQ3pMesqypNiPOO
 zWHmV1awSf/VHU8JAKQS2eg9L7yVOZF4SxSoYxn/A0zwI6zCSb
 dweQik63PHBss0xxuBZLHJFhdkvIf8sDutjiBfwaYDiZyRgMfA
 XQu9a/pVuPHovqmK3E7P4ECTAfjPGKm7+Jx2oo0h+iYK4Q+Fab
 FfY2dg0HuolYcl4tOq66n9fHm3F5xlDIm2Ak+sAZXz6ymp4xCh
 y+PEyHWd9mJS2Qhv+XuXjil0K8eBA9tFTgwy3n/8C4xQJqKK17
 Z7UPSXj10ChSnck7FIaQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195749>

On Tue, Apr 17, 2012 at 09:32:29AM +0300, Felipe Contreras wrote:
> On Tue, Apr 17, 2012 at 3:31 AM, SZEDER G=E1bor <szeder@fzi.de> wrote=
:
> > Hi,
> >
> >
> > I picked up Stephen Boyd's two-patch series[1] to use parse-options=
 to
> > generate options for git commands, and the following test promply
> > failed (taken from 5c293a6b (tests: add initial bash completion tes=
ts,
> > 2012-04-12)):
> >
> > test_expect_success 'double dash "git checkout"' '
> > =A0 =A0 =A0 =A0sed -e "s/Z$//" >expected <<-\EOF &&
> > =A0 =A0 =A0 =A0--quiet Z
> > =A0 =A0 =A0 =A0--ours Z
> > =A0 =A0 =A0 =A0--theirs Z
> > =A0 =A0 =A0 =A0--track Z
> > =A0 =A0 =A0 =A0--no-track Z
> > =A0 =A0 =A0 =A0--merge Z
> > =A0 =A0 =A0 =A0--conflict=3D
> > =A0 =A0 =A0 =A0--orphan Z
> > =A0 =A0 =A0 =A0--patch Z
> > =A0 =A0 =A0 =A0EOF
> > =A0 =A0 =A0 =A0test_completion "git checkout --"
> > '
> >
> > Not surprising, the completion script doesn't know about many 'git
> > checkout' long options. =A0So whenever 'git checkout' learns a new =
long
> > option, this list must be updated. =A0This won't be more work than =
the
> > update of the completion script, so this is probably OK.
> >
> > But it got me thinking about what do we actually want to test here?
> > Whether the completion script returns the right long options in a
> > specific order upon 'git checkout --<TAB>'? =A0Or whether _git() wo=
rks
> > properly and invokes the right command-specific completion function=
?
> > Or whether regular options get a trailing space while options
> > expecting an argument don't? =A0Or is this sort of an integration t=
est
> > and basically all of the above?
>=20
> I don't think the order is relevant, just that all the options are
> there,=20

The order of options is not relevant in the completion script, because
Bash will sort them alphabetically anyway.  But it is relevant in the
test: it fails if the order is changed either in the completion script
or in the test.

> and the ones with arguments have a =3D in there, and the ones
> that don't, a space.

Couldn't we check that better with a test or two for __gitcomp()?

If a test for __gitcomp() fails, we would immediately have a fairly
good idea where to look for the cause of the breakage.  However, if
this 'double dash "git checkout"' test fails, there are a bunch of
other things that can possibly cause the failure.

Patch comes in a minute.

Best,
G=E1bor
