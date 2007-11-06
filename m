From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: [PATCH 4/4] Implement git commit and status as a builtin
	commands.
Date: Tue, 6 Nov 2007 18:08:13 +0100
Message-ID: <20071106170813.GA27100@atjola.homenet>
References: <1194017589-4669-1-git-send-email-krh@redhat.com> <1194017589-4669-2-git-send-email-krh@redhat.com> <1194017589-4669-3-git-send-email-krh@redhat.com> <1194017589-4669-4-git-send-email-krh@redhat.com> <20071103150637.GA11172@atjola.homenet> <1194289073.13968.16.camel@hinata.boston.redhat.com> <20071105192347.GA29997@atjola.homenet> <Pine.LNX.4.64.0711052317170.4362@racer.site> <20071106065941.GA6423@atjola.homenet> <1194367619.20020.9.camel@hinata.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Kristian =?iso-8859-1?Q?H=F8gsberg?= <krh@redhat.com>
X-From: git-owner@vger.kernel.org Tue Nov 06 18:09:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IpRuo-00031f-Ga
	for gcvg-git-2@gmane.org; Tue, 06 Nov 2007 18:08:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753235AbXKFRIR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 6 Nov 2007 12:08:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753459AbXKFRIR
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Nov 2007 12:08:17 -0500
Received: from mail.gmx.net ([213.165.64.20]:52823 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753247AbXKFRIQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Nov 2007 12:08:16 -0500
Received: (qmail invoked by alias); 06 Nov 2007 17:08:15 -0000
Received: from i577BB83C.versanet.de (EHLO localhost) [87.123.184.60]
  by mail.gmx.net (mp012) with SMTP; 06 Nov 2007 18:08:15 +0100
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX1+Jdmw4qjCJEjxKHlPhNk4RnpmJdXtOXq0s+4vCXM
	67jASMhoWb15Y/
Content-Disposition: inline
In-Reply-To: <1194367619.20020.9.camel@hinata.boston.redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63689>

On 2007.11.06 11:46:59 -0500, Kristian H=F8gsberg wrote:
> On Tue, 2007-11-06 at 07:59 +0100, Bj=F6rn Steinbrink wrote:
> ...
> > Note though, that Kristian had a similar check at the end of his em=
ail,
> > that included "only" (but lacked the bool conversion). The original
> > reason why I thought that it would be better was that for example
> > "git commit --all --only foo" didn't care about "only" at all. But =
that
> > actually was because the --all + paths usage check was broken. So t=
he
> > fixed version actually refuses to use accept that, but with a (IMHO=
) not
> > so good error message:
> >=20
> > $ git commit -a -o file
> > Paths with -a does not make sense.
> >=20
> > Given that some people are used to just pass -a all the time, they =
might
> > just automatically pass it together with -o. And I think that we
> > actually want to tell them that -a + -o makes no sense instead. Jus=
t
> > like we do for -a + -i, which is kind of the complementary usage er=
ror.
> >=20
> > So I'd go for a correct version of Kristian's suggestion:
> >=20
> > if (!!also + !!only + !!all + !!interactive > 1)
> > 	die("Only one of --include/--only/--all/--interactive can be used.=
");
>=20
> Good points, I will use that in the next version of the patch.  Just =
a
> note about the !! idiom (which I can't stand, fwiw): my version just
> added the variables, which were all integers, initialized to zero and
> incremented by the option parser when it sees the corresponding optio=
n.
> So what I had would work too, with the extra check that:
>=20
>   $ git commit -a -a
>=20
> etc would give the error
>=20
>   Only one of --include/--only/--all/--interactive can be used.
>=20
> which is acutally accurate.

Hm, why? The user used only one of them. The error message does not say
that you cannot pass the same one multiple times. And I don't think tha=
t
passing the same boolean flag twice should be treated as an usage error
either. There's no contradiction in wanting all files and, well, all
files to be committed.

Sidenote: The "or mask" stuff in the option parser would probably
prevent you from catching "-a -a" anyway, because the flag becomes trul=
y
boolean ;-)

Bj=F6rn
