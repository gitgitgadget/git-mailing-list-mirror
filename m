From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: [PATCH v3] completion: add new _GIT_complete helper
Date: Sun, 6 May 2012 13:30:21 +0200
Message-ID: <20120506113021.GK2164@goldbirke>
References: <1336231400-6878-1-git-send-email-felipe.contreras@gmail.com>
	<20120506111425.GJ2164@goldbirke>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 06 13:31:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SQzgN-0002SO-Pf
	for gcvg-git-2@plane.gmane.org; Sun, 06 May 2012 13:31:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753340Ab2EFLam convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 6 May 2012 07:30:42 -0400
Received: from moutng.kundenserver.de ([212.227.126.187]:54331 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753306Ab2EFLal (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 May 2012 07:30:41 -0400
Received: from localhost6.localdomain6 (p5B130CE2.dip0.t-ipconnect.de [91.19.12.226])
	by mrelayeu.kundenserver.de (node=mrbap0) with ESMTP (Nemesis)
	id 0Lfpnu-1RpB1J1A2U-00pbCw; Sun, 06 May 2012 13:30:23 +0200
Content-Disposition: inline
In-Reply-To: <20120506111425.GJ2164@goldbirke>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Provags-ID: V02:K0:ekPf12M8MTPoltIAIhjJl3+oaE87D5LFoqyOQkFCsB9
 74tHBWyVag79gimLCom1Nm0zGpvNLbfSzu26LhU4ZzsTbZkzuS
 q9P8DELRzuk4VbAx8MJJaiMQr+woijy2gKScb/5EICyU6JzwjM
 c/Wa1s83cpzsFBjnX53IGw4edzoyAK1PPMo2a7wZp0ZwLQCNkd
 ouMOvyv2af1dthLmIzXcI/fZha5eoOSNKh0lSU4o8W+gnjfmlg
 nB2kQqDj3u/Hkuaho9wBVDPn6IU+It9uds5YqhujSqahEVYZ8L
 ZPZogCLitqIZG2qRDfbMnGR/SbqQZv7aV8CO3O0Mc7RFqBgad5
 t2kS3Zlm74x4baqw+nJw=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197169>

On Sun, May 06, 2012 at 01:14:25PM +0200, SZEDER G=E1bor wrote:
> On Sat, May 05, 2012 at 05:23:20PM +0200, Felipe Contreras wrote:
> > This simplifies the completions, and makes it easier to define alia=
ses:
> >=20
> >  _GIT_complete gf git_fetch
>=20
> So, 'gf' is an alias for 'git fetch', for which the user would like t=
o
> use the completion for 'git fetch', right?  But that completion
> function is caled _git_fetch(), so the underscore prefix is missing
> here.
>=20
> Besides, this example won't work, because the completion for 'git
> fetch' uses __git_complete_remote_or_refspec(), which in turn relies
> on finding out the name of the git command from the word on the
> command line, and it won't be able to do that from 'gf'.

I scanned the completion script for places where we iterate over the
words on the command line, i.e. for the pattern 'while.*\$cword'.

It seems that with the exception of __git_complete_remote_or_refspec()
all those places seem to be OK to be used with aliases.  They all
start the iteration at the first word on the command line ('git' or
'gf' being the nullth) so they will iterate over all relevant words in
case of aliases, too.  Perhaps this is a heritage of the dashed
commands; back then the completion script had to deal with 'git cmd'
and 'git-cmd', too.  __git_complete_remote_or_refspec() starts at the
second word, so that must be changed.


Best,
G=E1bor
