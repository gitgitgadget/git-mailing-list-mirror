From: Alexander Strasser <eclipse7@gmx.net>
Subject: Re: [eclipse7@gmx.net: [PATCH] diff: Only count lines in
 show_shortstats()]
Date: Thu, 7 Jun 2012 22:04:34 +0200
Message-ID: <20120607200434.GA2965@akuma>
References: <20120607122149.GA3070@akuma>
 <4FD0FB75.4090906@in.waw.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>, mj@ucw.cz,
	Johannes Sixt <j.sixt@viscovery.net>
To: Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
X-From: git-owner@vger.kernel.org Thu Jun 07 22:04:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sciwp-0001gU-2r
	for gcvg-git-2@plane.gmane.org; Thu, 07 Jun 2012 22:04:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753161Ab2FGUEm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 7 Jun 2012 16:04:42 -0400
Received: from mailout-de.gmx.net ([213.165.64.22]:55179 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751112Ab2FGUEl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jun 2012 16:04:41 -0400
Received: (qmail invoked by alias); 07 Jun 2012 20:04:39 -0000
Received: from p5DC37EAC.dip.t-dialin.net (EHLO gmx.net) [93.195.126.172]
  by mail.gmx.net (mp070) with SMTP; 07 Jun 2012 22:04:39 +0200
X-Authenticated: #8251126
X-Provags-ID: V01U2FsdGVkX18mFD1SYqYmqDpVyC0bFKMoom+vT4edhK4TT/fqNh
	bpfGs9gTQnlbCT
Received: by gmx.net (sSMTP sendmail emulation); Thu, 07 Jun 2012 22:04:34 +0200
Mail-Followup-To: Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>, mj@ucw.cz,
	Johannes Sixt <j.sixt@viscovery.net>
Content-Disposition: inline
In-Reply-To: <4FD0FB75.4090906@in.waw.pl>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199444>

Hi,

Zbigniew J=C4=99drzejewski-Szmek wrote:
> On 06/07/2012 02:21 PM, Alexander Strasser wrote:
> >   could you have a look at the patch below? I submitted to it to th=
e
> > Git mailing list and you could probably comment there?
> Hi Alexander,
> sure, thanks for finding (and fixing) the bug.

  thank you very much for the review.

> >   I think I should have put you in CC. But I am not so sure about
> > Git patch submission policies.
> The policy is to CC everyone who might be interested, and also to add
> TO:gitster@pobox.com, if the patch is intended for merging, as yours =
is.
> So basically taking the address list from the discussion of e18872b
> would be the simplest and most effective choice.

  Ah, I see. I will try to do better next time. Thanks for the good
explanation.

> >   Do not mix byte and line counts. Binary files have byte counts;
> > skip them when accumulating line insertions/deletions.
> >=20
> >   The regression was introduced in e18872b.
> Yeah, it seems that the condition for !binary was lost in the refacto=
ring
> of the code.

  Yes, seems so. I was seeing changing line counts in GitStats output
compared to older and newer Git versions. I found the exact commit with
"git bisect" which was a big help.

> > Signed-off-by: Alexander Strasser <eclipse7@gmx.net>
> Small note: normally the paragraphs are not indented.

  Noted. I probably should have also dropped the () in the subject. Aft=
er
submitting I noticed this notation was not used in analog log messages.

[...]
> > --- a/t/t4012-diff-binary.sh
> > +++ b/t/t4012-diff-binary.sh
> > @@ -36,6 +36,14 @@ test_expect_success '"apply --stat" output for b=
inary file change' '
> >  	test_i18ncmp expected current
> >  '
> > =20
> > +cat > expected <<\EOF
> > + 4 files changed, 2 insertions(+), 2 deletions(-)
> > +EOF
> > +test_expect_success 'diff with --shortstat' '
> > +	git diff --shortstat >current &&
> > +	test_cmp expected current
> > +'
> > +
> The test is OK, and follows the style of surrounding tests, but curre=
nt
> style is slightly different:
> - no space after '>'
> - expected output is inlined if it is short
> - test_i18ncmp is used, even if the message is not yet i18n-ized
>=20
> Something like this:
> test_expect_success 'diff --shortstat output for binary file change' =
'
> 	echo " 4 files changed, 2 insertions(+), 2 deletions(-)" >expect &&
> 	git diff --shortstat >current &&
> 	test_i18ncmp expect current
> '

  Should I rewrite the test for this patch? Or should it be changed for=
 the
whole file at once?

[...]

  Alexander
