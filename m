From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: [PATCH 2/5] completion: fix args of run_completion() test helper
Date: Fri, 28 Sep 2012 22:28:16 +0200
Message-ID: <20120928202816.GC10719@goldbirke>
References: <20120928100530.GL10144@goldbirke>
 <1348826975-2225-1-git-send-email-szeder@ira.uka.de>
 <1348826975-2225-2-git-send-email-szeder@ira.uka.de>
 <7vehlmm3ca.fsf@alter.siamese.dyndns.org>
 <20120928183840.GB10719@goldbirke>
 <7vzk4aj6ik.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 28 22:29:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1THhBf-0004BO-89
	for gcvg-git-2@plane.gmane.org; Fri, 28 Sep 2012 22:29:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1032676Ab2I1U20 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 28 Sep 2012 16:28:26 -0400
Received: from moutng.kundenserver.de ([212.227.17.10]:55663 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1032656Ab2I1U2U (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Sep 2012 16:28:20 -0400
Received: from localhost6.localdomain6 (p5B130716.dip0.t-ipconnect.de [91.19.7.22])
	by mrelayeu.kundenserver.de (node=mrbap2) with ESMTP (Nemesis)
	id 0MTNxP-1Sq2461AHf-00RxKI; Fri, 28 Sep 2012 22:28:17 +0200
Content-Disposition: inline
In-Reply-To: <7vzk4aj6ik.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Provags-ID: V02:K0:YVZM+QKNQghnjrg2DkGarQ5qRZzB5LfdvuLYegL7FJN
 RApYfVsKU9vL/MIMkM7Vr3mjk2Ho/HS/cDg0HN1i1HbZGhxHeg
 QFeM4Jqax1elcZalpfUcN5JLi/BOT5GH36SWWdekOYMGIV9NJ1
 pHhY431nirT52toO5bcemEYf/nfLmdz0+OQwuJsgjHDZuqlqoF
 Md5qqcyeN4VnpQvr8Fy8SwNiuXxUZx0Fyj7x8k/HP3f9zLN8nn
 +U/ltE9AJq3Lit3yZrUrROHyQDQ/2yff7g0E119W7+at+ZS/Pk
 dwJ8AxIF87JMU0diCefSIcFP5FplqZJSlFAdHa+uzyegBkIGii
 bR1hJ5zuO9wlai+7nkHYJfzHKnbe9NYYC52FvsuIF
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206608>

On Fri, Sep 28, 2012 at 12:23:47PM -0700, Junio C Hamano wrote:
> SZEDER G=E1bor <szeder@ira.uka.de> writes:
>=20
> > On Fri, Sep 28, 2012 at 11:04:05AM -0700, Junio C Hamano wrote:
> >> SZEDER G=E1bor <szeder@ira.uka.de> writes:
> >>=20
> >> > To simulate the the user hit 'git <TAB>, one of the completion t=
ests
> >
> > s/the the/that the/
> >
> >> > sets up the rather strange command line
> >> >
> >> >   git ""
> >> >
> >> > i.e. the second word on the command line consists of two double
> >> > quotes.  However, this is not what happens for real, because aft=
er
> >> > 'git <TAB>' the second word on the command line is just an empty
> >> > string.  Luckily, the test works nevertheless.
> >> >
> >> > Fix this by passing the command line to run_completion() as sepa=
rate
> >> > words.
> >> >
> >> > Signed-off-by: SZEDER G=E1bor <szeder@ira.uka.de>
> >> > ---
> >> >  t/t9902-completion.sh | 8 ++++----
> >> >  1 file changed, 4 insertions(+), 4 deletions(-)
> >> >
> >> > diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
> >> > index e7657537..f5e68834 100755
> >> > --- a/t/t9902-completion.sh
> >> > +++ b/t/t9902-completion.sh
> >> > @@ -49,7 +49,7 @@ run_completion ()
> >> >  {
> >> >  	local -a COMPREPLY _words
> >> >  	local _cword
> >> > -	_words=3D( $1 )
> >> > +	_words=3D( "$@" )
> >> >  	(( _cword =3D ${#_words[@]} - 1 ))
> >> >  	__git_wrap__git_main && print_comp
> >> >  }
> >> > @@ -57,7 +57,7 @@ run_completion ()
> >> >  test_completion ()
> >> >  {
> >> >  	test $# -gt 1 && echo "$2" > expected
> >> > -	run_completion "$@" &&
> >> > +	run_completion $1 &&
> >> >  	test_cmp expected out
> >> >  }
> >>=20
> >> I can understand the other three hunks, but this one is fishy.
> >> Shouldn't "$1" be inside a pair of dq?  I.e.
> >>=20
> >> 	+	run_completion "$1" &&
> >
> > No.  $1 holds all words on the command line.  If it was between a p=
air
> > of dq, then the whole command line would be passed to the completio=
n
> > script as a single word.
>=20
> And these "words" can be split at $IFS boundaries without any
> issues?  IOW, nobody would ever want to make words array in the
> run_completion function to ['git' 'foo bar' 'baz']?

Maybe we would, but making it work would be a separate fix.  You can't
do that with the current version either.
