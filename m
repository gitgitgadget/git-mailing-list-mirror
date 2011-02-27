From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: What's cooking in git.git (Feb 2011, #05; Wed, 23)
Date: Sun, 27 Feb 2011 15:28:43 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1102271509540.1561@bonsai2>
References: <7v1v2y5o3p.fsf@alter.siamese.dyndns.org> <AANLkTinUtqJJHNyS9CxrC=VnS87v=GH=pOw9yr4r=pii@mail.gmail.com> <AANLkTimWy+W+rcZHsac_n--y9iMeaoO66CPZVbN1VBp2@mail.gmail.com> <20110225090544.GA3783@tugrik.mns.mnsspb.ru> <alpine.DEB.1.00.1102251208380.1561@bonsai2>
 <20110225192455.GA7130@tugrik.mns.mnsspb.ru> <alpine.DEB.1.00.1102252251140.15247@pacific.mpi-cbg.de> <20110226110740.GA3096@tugrik.mns.mnsspb.ru>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Erik Faye-Lund <kusmabite@gmail.com>,
	=?ISO-8859-15?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	msysGit <msysgit@googlegroups.com>
To: Kirill Smelkov <kirr@mns.spb.ru>
X-From: git-owner@vger.kernel.org Sun Feb 27 15:29:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PthcO-0005lD-9B
	for gcvg-git-2@lo.gmane.org; Sun, 27 Feb 2011 15:29:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752031Ab1B0O2u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Feb 2011 09:28:50 -0500
Received: from mailout-de.gmx.net ([213.165.64.23]:39342 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751955Ab1B0O2t (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Feb 2011 09:28:49 -0500
Received: (qmail invoked by alias); 27 Feb 2011 14:28:46 -0000
Received: from pD9EB2AFE.dip0.t-ipconnect.de (EHLO noname) [217.235.42.254]
  by mail.gmx.net (mp007) with SMTP; 27 Feb 2011 15:28:46 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+X+R8alcqXMVb64Ms7ZDG0KC2hAxxbyanAbvoRAm
	yhTzKP7T5XCVvr
X-X-Sender: gene099@bonsai2
In-Reply-To: <20110226110740.GA3096@tugrik.mns.mnsspb.ru>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168031>

Hi Kirill,

On Sat, 26 Feb 2011, Kirill Smelkov wrote:

> On Fri, Feb 25, 2011 at 10:54:40PM +0100, Johannes Schindelin wrote:
> > 
> > On Fri, 25 Feb 2011, Kirill Smelkov wrote:
> > 
> > > On Fri, Feb 25, 2011 at 12:11:59PM +0100, Johannes Schindelin wrote:
> > > 
> > > > Further, I think that my beloved Shift+Insert will no longer work 
> > > > with your [2].
> > > 
> > > Probably yes,
> > 
> > In my experiment after rebuilding msys-1.0.dll, it still works.
> 
> xser32.dll has nothing to do with msys - it's just a fake stub for
> sh.exe. Before testing, have you "patched" sh.exe the way it is done in
> my ks/xser32.dll
> (http://repo.or.cz/w/msysgit/kirr.git/commit/9d952c74a52f577b2d16d4e4a489541a8fa7fbbd)

Ah. I had to add -Wl,-kill-at to the LDFLAGS so it works. 

See the ks/xser32 branch (and the ks/msys branch) of msysgit.git.

> > The problem for now is that when I time /share/msysGit/run-tests.sh, 
> > there is hardly any gain from your patches:
> > 
> > Old:
> > 
> > 
> > real    18m1.031s
> > user    6m17.861s
> > sys     19m25.257s
> > 
> > New:
> > 
> > real    17m54.500s
> > user    6m12.319s
> > sys     19m28.567s
> 
> Did you patch sh.exe to link to xser32.dll instead of user32.dll?

Now I did, and the difference is quite noticable:

real    15m37.281s
user    5m6.934s
sys     15m53.911s

(Note that I did not spend time to increase the N, so there is no point in 
putting a percentage on the difference.)

I wonder whether we could patch sh.exe so it loads user32.dll _lazily_ 
rather than using the xser32.dll hack?

(This would also fix the issue that I can no longer use Shift+Insert to 
paste the clipboard into the Git Bash...)

> Also I can't say for sure (hope yet) how sh-intensitive git tests are, 
> but at least running configure for say gettext or whatever should be 
> visibly faster, at least on wine.

They are pretty intensive, as they are shell scripts all over the place in 
their own right. I fear, however, that the real problem (maybe not on 
WINE, but with real Windows) is that sh.exe needs to provide too many 
POSIX-like things when starting new processes.

I fear, further, that the only way to make things more efficient on 
Windows is to get rid of the many exec() calls and do more things 
in-process. (If this is true, JGit should kick msysGit's ass.) This would 
not apply to the test suite, though, which needs to stay a shell script 
suite.

But maybe I am wrong, and the performance is lost through memory 
management and filesystem interaction.

Ciao,
Dscho
