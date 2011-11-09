From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: [PATCH] completion: don't leak variable from the prompt into
	environment
Date: Wed, 9 Nov 2011 14:26:49 +0100
Message-ID: <20111109132649.GB2135@goldbirke>
References: <1320832970-26239-1-git-send-email-szeder@ira.uka.de>
	<7vd3d1widd.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <git@vger.kernel.org>, "Shawn O. Pearce" <spearce@spearce.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 09 14:27:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RO8BD-0004Zs-6E
	for gcvg-git-2@lo.gmane.org; Wed, 09 Nov 2011 14:27:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752121Ab1KIN06 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 Nov 2011 08:26:58 -0500
Received: from ex-e-2.perimeter.fzi.de ([141.21.8.251]:9817 "EHLO
	ex-e-2.perimeter.fzi.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752021Ab1KIN05 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Nov 2011 08:26:57 -0500
Received: from ex-ca-ht-1.fzi.de (141.21.32.98) by ex-e-2.perimeter.fzi.de
 (141.21.8.251) with Microsoft SMTP Server (TLS) id 14.1.339.1; Wed, 9 Nov
 2011 14:26:47 +0100
Received: from localhost6.localdomain6 (141.21.50.31) by ex-ca-ht-1.fzi.de
 (141.21.32.98) with Microsoft SMTP Server (TLS) id 14.1.339.1; Wed, 9 Nov
 2011 14:26:52 +0100
Content-Disposition: inline
In-Reply-To: <7vd3d1widd.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185157>

Hi,

On Wed, Nov 09, 2011 at 05:11:26AM -0800, Junio C Hamano wrote:
> SZEDER G=E1bor <szeder@ira.uka.de> writes:
>=20
> > Commit e5b8eebc (completion: fix issue with process substitution no=
t
> > working on Git for Windows, 2011-10-26) introduced a new variable i=
n
> > __git_ps1_show_upstream(), but didn't declare it as local to preven=
t
> > it from leaking into the environment.
> > ---
>=20
> Thanks; I'd consider this signed-off?

Oops, yeah, sorry.

Signed-off-by: SZEDER G=E1bor <szeder@ira.uka.de>


Just for the record:  I pointed this out when the patch was discussed
on the list, and proposed a better solution:

  http://thread.gmane.org/gmane.comp.version-control.git/184229/focus=3D=
184290

but apparently only after that patch was already merged.  Since we are
in -rc phase, this patch below chooses the less intrusive solution
(i.e. it declares the variable as local instead of eliminating it by
using the command substitution as here string).


G=E1bor


>=20
> >  contrib/completion/git-completion.bash |    2 +-
> >  1 files changed, 1 insertions(+), 1 deletions(-)
> >
> > diff --git a/contrib/completion/git-completion.bash b/contrib/compl=
etion/git-completion.bash
> > index b3571ab4..d18895b1 100755
> > --- a/contrib/completion/git-completion.bash
> > +++ b/contrib/completion/git-completion.bash
> > @@ -110,7 +110,7 @@ __git_ps1_show_upstream ()
> >  	local upstream=3Dgit legacy=3D"" verbose=3D""
> > =20
> >  	# get some config options from git-config
> > -	output=3D"$(git config -z --get-regexp '^(svn-remote\..*\.url|bas=
h\.showupstream)$' 2>/dev/null | tr '\0\n' '\n ')"
> > +	local output=3D"$(git config -z --get-regexp '^(svn-remote\..*\.u=
rl|bash\.showupstream)$' 2>/dev/null | tr '\0\n' '\n ')"
> >  	while read key value; do
> >  		case "$key" in
> >  		bash.showupstream)
