From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: [PATCH 4/4] Implement git commit and status as a builtin
	commands.
Date: Mon, 5 Nov 2007 20:23:47 +0100
Message-ID: <20071105192347.GA29997@atjola.homenet>
References: <1194017589-4669-1-git-send-email-krh@redhat.com> <1194017589-4669-2-git-send-email-krh@redhat.com> <1194017589-4669-3-git-send-email-krh@redhat.com> <1194017589-4669-4-git-send-email-krh@redhat.com> <20071103150637.GA11172@atjola.homenet> <1194289073.13968.16.camel@hinata.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Kristian =?iso-8859-1?Q?H=F8gsberg?= <krh@redhat.com>
X-From: git-owner@vger.kernel.org Mon Nov 05 20:24:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ip7YU-0004X2-F6
	for gcvg-git-2@gmane.org; Mon, 05 Nov 2007 20:24:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754383AbXKETX5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 5 Nov 2007 14:23:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754223AbXKETX4
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Nov 2007 14:23:56 -0500
Received: from mail.gmx.net ([213.165.64.20]:46790 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753793AbXKETXz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Nov 2007 14:23:55 -0500
Received: (qmail invoked by alias); 05 Nov 2007 19:23:49 -0000
Received: from i577BBDA2.versanet.de (EHLO localhost) [87.123.189.162]
  by mail.gmx.net (mp002) with SMTP; 05 Nov 2007 20:23:49 +0100
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX19aCRxgKHBa6bD/LSvlAZ2RZZLJA4eBGss8cz1W9G
	H0eby2mwmklXPp
Content-Disposition: inline
In-Reply-To: <1194289073.13968.16.camel@hinata.boston.redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63539>

On 2007.11.05 13:57:53 -0500, Kristian H=F8gsberg wrote:
> On Sat, 2007-11-03 at 16:06 +0100, Bj=F6rn Steinbrink wrote:
> > On 2007.11.02 11:33:09 -0400, Kristian H=F8gsberg wrote:
> > > +	if (all && interactive)
> > > +		die("Cannot use -a, --interactive or -i at the same time.");
> >=20
> > Shouldn't that be "if (all && (interactive || also))"?

Ah, damn. I (obviously) misread the error message as:
	foo and (bar or bar2)

IOW "and" instead of the first comma.

Actually it should be:
	if ((all && (interactive || also)) || (interactive && also))

(or whatever more simple version you come up with)

> The shell script just has
>=20
> case "$all,$interactive,$also,$#" in
> *t,*t,*)
>         die "Cannot use -a, --interactive or -i at the same time." ;;
>=20
> which doesn't seem to care about the value of $also.  As far as I
> understand git commit, it doesn't make sense to pass any of -a, -i, -=
o
> or --interactive at the same time so I guess I could join the checks

Note that there are only two commas. The asterisks catch everything and
$# won't be "t", so that catches anything with at least two t's.

Also note, that the two checks after that one in git-commit.sh as of th=
e
current master (140dd77a5cb2e61dcb942e245a2474fae95e42a5) are broken
(I'll send a patch in a separate mail).

>         if (also && only)
>                 die("Only one of --include/--only can be used.");
>         if (all && interactive)
>                 die("Cannot use -a, --interactive or -i at the same
> time.");
>=20
> into something like
>=20
> 	if (also + only + all + interactive > 1)             =20
> 		die("Only one of --include/--only/--all/--interactive can be used."=
);
>=20
> Does that sound right?

--include is not in the manpage, and I only glanced over git-commit.sh,
but yeah, at least to me, that sounds right.

Bj=F6rn
