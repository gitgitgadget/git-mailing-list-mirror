From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 12/10] support pager.* for external commands
Date: Tue, 14 Feb 2012 14:13:40 -0500
Message-ID: <20120214191340.GC12072@sigill.intra.peff.net>
References: <20110818215820.GA7767@sigill.intra.peff.net>
 <20110818220132.GB7799@sigill.intra.peff.net>
 <CACBZZX596wnk2KE9QzUPMc=A6Mt8HbUs7F4rnAZbw1_RrcKHnw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Steffen Daode Nurpmeso <sdaoden@googlemail.com>,
	Ingo =?utf-8?Q?Br=C3=BCckl?= <ib@wupperonline.de>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 14 20:13:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RxNoz-0004gg-5n
	for gcvg-git-2@plane.gmane.org; Tue, 14 Feb 2012 20:13:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758431Ab2BNTNo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 14 Feb 2012 14:13:44 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:35795
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753215Ab2BNTNo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Feb 2012 14:13:44 -0500
Received: (qmail 9281 invoked by uid 107); 14 Feb 2012 19:20:54 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 14 Feb 2012 14:20:54 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 14 Feb 2012 14:13:40 -0500
Content-Disposition: inline
In-Reply-To: <CACBZZX596wnk2KE9QzUPMc=A6Mt8HbUs7F4rnAZbw1_RrcKHnw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190736>

On Sun, Feb 12, 2012 at 01:46:34AM +0100, =C3=86var Arnfj=C3=B6r=C3=B0 =
Bjarmason wrote:

> On Fri, Aug 19, 2011 at 00:01, Jeff King <peff@peff.net> wrote:
>=20
> > +test_expect_success TTY 'command-specific pager works for external=
 commands' '
> > + =C2=A0 =C2=A0 =C2=A0 sane_unset PAGER GIT_PAGER &&
> > + =C2=A0 =C2=A0 =C2=A0 echo "foo:initial" >expect &&
> > + =C2=A0 =C2=A0 =C2=A0 >actual &&
> > + =C2=A0 =C2=A0 =C2=A0 test_config pager.external "sed s/^/foo:/ >a=
ctual" &&
> > + =C2=A0 =C2=A0 =C2=A0 test_terminal git --exec-path=3D"`pwd`" exte=
rnal log --format=3D%s -1 &&
> > + =C2=A0 =C2=A0 =C2=A0 test_cmp expect actual
>=20
> For reasons that I haven't looked into using sed like that breaks
> under /usr/bin/ksh on Solaris. Just using:
>=20
>     sed -e \"s/^/foo:/\"
>=20
> Instead fixes it, it's not broken with /usr/xpg4/bin/sh, so it's some
> ksh peculiarity.
>=20
> The error it gives is:
>=20
>     sed s/^/foo:/ >actual: Not found
>=20
> Indicating that for some reason it's considering that whole "sed
> s/^/foo:/ >actual" string to be a single command.

Hrm. Is the problem on the git-executing side, or is it on the setting
up the config side?

Sadly (or perhaps not) I no longer have any Solaris machines to test on=
=2E
Can you confirm that "git config pager.external" looks OK inside that
test?  Can you confirm via GIT_TRACE=3D1 what is being sent to the shel=
l?

Also, it looks like we actually run commands internally from git using
"sh -c". So if it is the executing side that is wrong, I don't see how
/usr/bin/ksh would be involved at all (it would either be /bin/sh, or
/usr/xpg4/bin/sh if you have your PATH set).

-Peff
