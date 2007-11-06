From: Kristian =?ISO-8859-1?Q?H=F8gsberg?= <krh@redhat.com>
Subject: Re: [PATCH 4/4] Implement git commit and status as a builtin
	commands.
Date: Tue, 06 Nov 2007 11:46:59 -0500
Message-ID: <1194367619.20020.9.camel@hinata.boston.redhat.com>
References: <1194017589-4669-1-git-send-email-krh@redhat.com>
	 <1194017589-4669-2-git-send-email-krh@redhat.com>
	 <1194017589-4669-3-git-send-email-krh@redhat.com>
	 <1194017589-4669-4-git-send-email-krh@redhat.com>
	 <20071103150637.GA11172@atjola.homenet>
	 <1194289073.13968.16.camel@hinata.boston.redhat.com>
	 <20071105192347.GA29997@atjola.homenet>
	 <Pine.LNX.4.64.0711052317170.4362@racer.site>
	 <20071106065941.GA6423@atjola.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: =?ISO-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Tue Nov 06 17:48:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IpRbS-0003uC-LQ
	for gcvg-git-2@gmane.org; Tue, 06 Nov 2007 17:48:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754274AbXKFQrl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 6 Nov 2007 11:47:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754118AbXKFQrl
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Nov 2007 11:47:41 -0500
Received: from mx1.redhat.com ([66.187.233.31]:36305 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754076AbXKFQrj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Nov 2007 11:47:39 -0500
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.8/8.13.1) with ESMTP id lA6Gl5PS008845;
	Tue, 6 Nov 2007 11:47:05 -0500
Received: from pobox.corp.redhat.com (pobox.corp.redhat.com [10.11.255.20])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id lA6Gl5oi022095;
	Tue, 6 Nov 2007 11:47:05 -0500
Received: from [192.168.1.101] (dhcp83-9.boston.redhat.com [172.16.83.9])
	by pobox.corp.redhat.com (8.13.1/8.13.1) with ESMTP id lA6Gl4P4021745;
	Tue, 6 Nov 2007 11:47:04 -0500
In-Reply-To: <20071106065941.GA6423@atjola.homenet>
X-Mailer: Evolution 2.11.90 (2.11.90-4.fc8) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63686>

On Tue, 2007-11-06 at 07:59 +0100, Bj=C3=B6rn Steinbrink wrote:
=2E..
> Note though, that Kristian had a similar check at the end of his emai=
l,
> that included "only" (but lacked the bool conversion). The original
> reason why I thought that it would be better was that for example
> "git commit --all --only foo" didn't care about "only" at all. But th=
at
> actually was because the --all + paths usage check was broken. So the
> fixed version actually refuses to use accept that, but with a (IMHO) =
not
> so good error message:
>=20
> $ git commit -a -o file
> Paths with -a does not make sense.
>=20
> Given that some people are used to just pass -a all the time, they mi=
ght
> just automatically pass it together with -o. And I think that we
> actually want to tell them that -a + -o makes no sense instead. Just
> like we do for -a + -i, which is kind of the complementary usage erro=
r.
>=20
> So I'd go for a correct version of Kristian's suggestion:
>=20
> if (!!also + !!only + !!all + !!interactive > 1)
> 	die("Only one of --include/--only/--all/--interactive can be used.")=
;

Good points, I will use that in the next version of the patch.  Just a
note about the !! idiom (which I can't stand, fwiw): my version just
added the variables, which were all integers, initialized to zero and
incremented by the option parser when it sees the corresponding option.
So what I had would work too, with the extra check that:

  $ git commit -a -a

etc would give the error

  Only one of --include/--only/--all/--interactive can be used.

which is acutally accurate.

cheers,
Kristian
