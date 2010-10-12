From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 3/3] bisect: check for mandatory argument of 'bisect replay'
Date: Tue, 12 Oct 2010 04:56:35 +0200
Message-ID: <201010120456.35411.chriscool@tuxfamily.org>
References: <1286747338-8521-1-git-send-email-szeder@ira.uka.de> <1286747338-8521-3-git-send-email-szeder@ira.uka.de> <201010120435.11903.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: SZEDER =?utf-8?q?G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Tue Oct 12 04:56:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P5V2o-0004XE-2a
	for gcvg-git-2@lo.gmane.org; Tue, 12 Oct 2010 04:56:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754677Ab0JLC4o convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 11 Oct 2010 22:56:44 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:57971 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752477Ab0JLC4n convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 11 Oct 2010 22:56:43 -0400
Received: from style.localnet (unknown [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 281FEA61C9;
	Tue, 12 Oct 2010 04:56:36 +0200 (CEST)
User-Agent: KMail/1.13.2 (Linux/2.6.32-24-generic; KDE/4.4.2; x86_64; ; )
In-Reply-To: <201010120435.11903.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158818>

On Tuesday 12 October 2010 04:35:11 Christian Couder wrote:
> On Sunday 10 October 2010 23:48:58 SZEDER G=C3=A1bor wrote:
> > 'git bisect replay' has a mandatory logfile argument, but the curre=
nt
> > implementation doesn't check whether the user has specified one.  W=
hen
> > the user omits the logfile argument, this leads to the following
> >=20
> > unhelpful error message:
> >   cannot read  for replaying
> >=20
> > So, check for the mandatory argument first, and provide a more
> > meaningful error message when it is omitted.
> >=20
> > Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
> > ---
> >=20
> >  git-bisect.sh |    1 +
> >  1 files changed, 1 insertions(+), 0 deletions(-)
> >=20
> > diff --git a/git-bisect.sh b/git-bisect.sh
> > index 68fcff6..c21e33c 100755
> > --- a/git-bisect.sh
> > +++ b/git-bisect.sh
> > @@ -343,6 +343,7 @@ bisect_clean_state() {
> >=20
> >  }
> > =20
> >  bisect_replay () {
> >=20
> > +	test "$#" -eq 1 || die "No logfile given"
> >=20
> >  	test -r "$1" || die "cannot read $1 for replaying"
> >  	bisect_reset
> >  	while read git bisect command rev
>=20
> While at it perhaps you could do something like:
>=20
> bisect_replay () {
> +	test "$#" -lt 1 || die "No logfile given"
> +	test "$#" -gt 1 || die "Too many argument. Please give only one log=
file."
>  	test -r "$1" || die "cannot read $1 for replaying"
>  	bisect_reset
>  	while read git bisect command rev

I mean:

bisect_replay () {
+	test "$#" -lt 1 && die "No logfile given"
+	test "$#" -gt 1 && die "Too many argument. Please give only one logfi=
le."
 	test -r "$1" || die "cannot read $1 for replaying"
 	bisect_reset
 	while read git bisect command rev

Sorry!

Best regards,
Christian.
