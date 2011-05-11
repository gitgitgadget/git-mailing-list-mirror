From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: [BUG] Autocompletion fails with "bash: words: bad array subscript"
Date: Wed, 11 May 2011 23:09:41 +0200
Message-ID: <20110511210941.GC31029@goldbirke>
References: <BANLkTi=nOUEp_J+2dkZZp=HvER-eAdG9eg@mail.gmail.com>
	<20110510203101.GG14456@sigill.intra.peff.net>
	<20110510203943.GH14456@sigill.intra.peff.net>
	<BANLkTi=0r_hCgt3wh4EkRqS6gnCyyKrY2g@mail.gmail.com>
	<20110510210116.GA25224@sigill.intra.peff.net>
	<BANLkTin9=7y+2eqUgo_ObcYeGs3TQ7YMGw@mail.gmail.com>
	<20110510211016.GB26231@sigill.intra.peff.net>
	<20110510223935.GA31029@goldbirke> <20110510234552.GG1994@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>,
	Jeff King <peff@peff.net>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Git List <git@vger.kernel.org>,
	"Shawn O. Pearce" <gsoc@spearce.org>,
	Stephen Boyd <bebarino@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 11 23:10:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QKGfY-0004Sw-Ha
	for gcvg-git-2@lo.gmane.org; Wed, 11 May 2011 23:10:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756245Ab1EKVJq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 May 2011 17:09:46 -0400
Received: from moutng.kundenserver.de ([212.227.126.187]:64385 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756239Ab1EKVJo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 May 2011 17:09:44 -0400
Received: from localhost6.localdomain6 (p5B1306CF.dip0.t-ipconnect.de [91.19.6.207])
	by mrelayeu.kundenserver.de (node=mreu1) with ESMTP (Nemesis)
	id 0MM2YK-1QNXuk0Kia-007luw; Wed, 11 May 2011 23:09:42 +0200
Content-Disposition: inline
In-Reply-To: <20110510234552.GG1994@elie>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Provags-ID: V02:K0:61PAikKb5YX9gCcoJ7b/UkHZrK1JLeg2PNhyyVEhsXh
 kRbGvV87hc3c36kN8gWT/z6H2qiwI9Oo55pa18Hn1XF9J65mJV
 kN3MFrqqhvVCU18PWuwUlNVePkRbMEsOPBFc3y7jTDXqdvwnyP
 PGMk0DBFlcHsZFqgJ26jvSz+B44A6rcx2poUJDK8ArYVyA2Ewg
 1YGbGhZAcFYd8hT8uhX5w==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173428>

Hi,


On Tue, May 10, 2011 at 06:45:52PM -0500, Jonathan Nieder wrote:
> SZEDER G=E1bor wrote:
> > So the bug is definitely not git-related.  The fix would be a check
> > along the lines of the first two hunks of the patch I just sent out=
=2E
>=20
> FWIW it looks like the bash-completion lib adopted a different fix
> recently: see [1] (_init_completion: Indicate that completion should
> not continue if cword =3D=3D 0, 2011-05-02).
>=20
> [1] http://git.debian.org/?p=3Dbash-completion/bash-completion.git;a=3D=
commitdiff;h=3D457dbf6061eea5f2d1e3bccacf1691265f7321cc

That doesn't fix the issue at hand.  _init_completion() invokes
_get_comp_words_by_ref() before that check to set all variables [1],
which will in turn try to access the -1th element of the array when
setting $prev, producing the same error.


Best,
G=E1bor


[1]: http://git.debian.org/?p=3Dbash-completion/bash-completion.git;a=3D=
blob;f=3Dbash_completion;h=3De88e2fc8cd97f2a43173b45a1448451bb53e55ab;h=
b=3D457dbf6061eea5f2d1e3bccacf1691265f7321cc#l708
