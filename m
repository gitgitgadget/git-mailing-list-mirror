From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: [PATCH 2/5] completion: fix args of run_completion() test helper
Date: Fri, 28 Sep 2012 20:38:40 +0200
Message-ID: <20120928183840.GB10719@goldbirke>
References: <20120928100530.GL10144@goldbirke>
 <1348826975-2225-1-git-send-email-szeder@ira.uka.de>
 <1348826975-2225-2-git-send-email-szeder@ira.uka.de>
 <7vehlmm3ca.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 28 20:38:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1THfSf-0001pT-8R
	for gcvg-git-2@plane.gmane.org; Fri, 28 Sep 2012 20:38:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758471Ab2I1Sio convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 28 Sep 2012 14:38:44 -0400
Received: from moutng.kundenserver.de ([212.227.126.186]:60927 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758297Ab2I1Sin (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Sep 2012 14:38:43 -0400
Received: from localhost6.localdomain6 (p5B130716.dip0.t-ipconnect.de [91.19.7.22])
	by mrelayeu.kundenserver.de (node=mreu3) with ESMTP (Nemesis)
	id 0MaPym-1T2BwX2TvM-00JssA; Fri, 28 Sep 2012 20:38:42 +0200
Content-Disposition: inline
In-Reply-To: <7vehlmm3ca.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Provags-ID: V02:K0:45RYTEZnb2Z0oi1fSOo2LlIqkpmWm8l+t72P9X21tK6
 eaHcWaowI4SDbEKVWKFfh4u3VWlyVfr0E1WWO6jpsSsafBTsjZ
 TNib83dqLrPdaQsMj2+wzFB90sp3E4mdxvydQHGRB/Hzl6Ksey
 +gx7xdkuvOmXiAtFeO9IHxmeAhSbhFQ1Ng6axlmE7qYE0OaVZS
 2B3WHrIFyjzK8og+2uRD6D7ey8oBGrq2WQrdtzK3RG7YjpqwJS
 6YEXewyScXL0sgykwylVNS8E7FQbnKWNc9fkxX9RvRBzK/+Kb5
 RTjF2imIAeV4noSv5CmiogVOZfXEq7BggE7vUVrtQf80yDL+AA
 8FO7j05WuEN+cK8CJrkw=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206594>

On Fri, Sep 28, 2012 at 11:04:05AM -0700, Junio C Hamano wrote:
> SZEDER G=E1bor <szeder@ira.uka.de> writes:
>=20
> > To simulate the the user hit 'git <TAB>, one of the completion test=
s

s/the the/that the/

> > sets up the rather strange command line
> >
> >   git ""
> >
> > i.e. the second word on the command line consists of two double
> > quotes.  However, this is not what happens for real, because after
> > 'git <TAB>' the second word on the command line is just an empty
> > string.  Luckily, the test works nevertheless.
> >
> > Fix this by passing the command line to run_completion() as separat=
e
> > words.
> >
> > Signed-off-by: SZEDER G=E1bor <szeder@ira.uka.de>
> > ---
> >  t/t9902-completion.sh | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
> > index e7657537..f5e68834 100755
> > --- a/t/t9902-completion.sh
> > +++ b/t/t9902-completion.sh
> > @@ -49,7 +49,7 @@ run_completion ()
> >  {
> >  	local -a COMPREPLY _words
> >  	local _cword
> > -	_words=3D( $1 )
> > +	_words=3D( "$@" )
> >  	(( _cword =3D ${#_words[@]} - 1 ))
> >  	__git_wrap__git_main && print_comp
> >  }
> > @@ -57,7 +57,7 @@ run_completion ()
> >  test_completion ()
> >  {
> >  	test $# -gt 1 && echo "$2" > expected
> > -	run_completion "$@" &&
> > +	run_completion $1 &&
> >  	test_cmp expected out
> >  }
>=20
> I can understand the other three hunks, but this one is fishy.
> Shouldn't "$1" be inside a pair of dq?  I.e.
>=20
> 	+	run_completion "$1" &&

No.  $1 holds all words on the command line.  If it was between a pair
of dq, then the whole command line would be passed to the completion
script as a single word.


> > =20
> > @@ -147,7 +147,7 @@ test_expect_success '__gitcomp - suffix' '
> >  '
> > =20
> >  test_expect_success 'basic' '
> > -	run_completion "git \"\"" &&
> > +	run_completion git "" &&
> >  	# built-in
> >  	grep -q "^add \$" out &&
> >  	# script
> > @@ -155,7 +155,7 @@ test_expect_success 'basic' '
> >  	# plumbing
> >  	! grep -q "^ls-files \$" out &&
> > =20
> > -	run_completion "git f" &&
> > +	run_completion git f &&
> >  	! grep -q -v "^f" out
> >  '
