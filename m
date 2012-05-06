From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: [PATCH v3] completion: add new _GIT_complete helper
Date: Sun, 6 May 2012 13:36:22 +0200
Message-ID: <20120506113622.GL2164@goldbirke>
References: <1336231400-6878-1-git-send-email-felipe.contreras@gmail.com>
	<20120506111425.GJ2164@goldbirke> <20120506113021.GK2164@goldbirke>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 06 13:36:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SQzlO-00062m-LB
	for gcvg-git-2@plane.gmane.org; Sun, 06 May 2012 13:36:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753364Ab2EFLg0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 6 May 2012 07:36:26 -0400
Received: from moutng.kundenserver.de ([212.227.126.186]:60425 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753348Ab2EFLgZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 May 2012 07:36:25 -0400
Received: from localhost6.localdomain6 (p5B130CE2.dip0.t-ipconnect.de [91.19.12.226])
	by mrelayeu.kundenserver.de (node=mrbap2) with ESMTP (Nemesis)
	id 0Lr4bL-1Rw4mx1tmV-00dtli; Sun, 06 May 2012 13:36:24 +0200
Content-Disposition: inline
In-Reply-To: <20120506113021.GK2164@goldbirke>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Provags-ID: V02:K0:ibrN/2fH81ymdcg8JpWavRTonMjWjaUYmWHtQ7GS90R
 6gzc0fz8kOHWwFkEYXJlskYvMK10fpeb4rsFy8iCaU9uAgvSX0
 LxPjyQ6eecXZCfSSR0XmwCh3oTHHMAmomoH20WZhZPczmRyJQ/
 Gb/LCfhdeaoFEODjg+iBK17XRWTUkz0Hk+LLGgSbL9SU87PciC
 x0z1g/+DA/7ICaI67F9SzdCEnzPQBAVcKHIRQBB/8nSBvTdNzZ
 Tnf+e982XSLzDIrCBIGyb1n/nKrfdD/TtG1ZGoo8evRUvyIVn7
 BwUlwd1dVFK9JjSuR8AxOGnriGpARNQ9exok/PatJYiupEXpLj
 lvrG99Z251hFpRzU6OJs=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197170>

On Sun, May 06, 2012 at 01:30:21PM +0200, SZEDER G=E1bor wrote:
> On Sun, May 06, 2012 at 01:14:25PM +0200, SZEDER G=E1bor wrote:
> > On Sat, May 05, 2012 at 05:23:20PM +0200, Felipe Contreras wrote:
> > > This simplifies the completions, and makes it easier to define al=
iases:
> > >=20
> > >  _GIT_complete gf git_fetch
> >=20
> > So, 'gf' is an alias for 'git fetch', for which the user would like=
 to
> > use the completion for 'git fetch', right?  But that completion
> > function is caled _git_fetch(), so the underscore prefix is missing
> > here.
> >=20
> > Besides, this example won't work, because the completion for 'git
> > fetch' uses __git_complete_remote_or_refspec(), which in turn relie=
s
> > on finding out the name of the git command from the word on the
> > command line, and it won't be able to do that from 'gf'.
>=20
> I scanned the completion script for places where we iterate over the
> words on the command line, i.e. for the pattern 'while.*\$cword'.
>=20
> It seems that with the exception of __git_complete_remote_or_refspec(=
)
> all those places seem to be OK to be used with aliases.  They all
> start the iteration at the first word on the command line ('git' or
> 'gf' being the nullth) so they will iterate over all relevant words i=
n
> case of aliases, too.  Perhaps this is a heritage of the dashed
> commands; back then the completion script had to deal with 'git cmd'
> and 'git-cmd', too.  __git_complete_remote_or_refspec() starts at the
> second word, so that must be changed.

There is one more odd case, though: __git_config_get_set_variables()
iterates over the words on the command line backwards, i.e. starting
at the index $cword until the index of the word is greater than 1.
This means that the iteration will stop at the second word, so this
must be adjusted, too, just in case someone wants an alias for 'git
config'.
