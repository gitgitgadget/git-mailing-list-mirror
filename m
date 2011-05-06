From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH v2] status: display "doing what" information in git status
Date: Fri, 6 May 2011 19:40:53 +0200
Message-ID: <20110506174053.GB2872@madism.org>
References: <7vr58c4sip.fsf@alter.siamese.dyndns.org>
 <1304667535-4787-1-git-send-email-madcoder@debian.org>
 <m3oc3guogs.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Git ML <git@vger.kernel.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 06 19:41:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QIP1Q-0004BM-Ih
	for gcvg-git-2@lo.gmane.org; Fri, 06 May 2011 19:41:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756567Ab1EFRk4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 6 May 2011 13:40:56 -0400
Received: from pan.madism.org ([88.191.52.104]:54692 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755417Ab1EFRkz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 May 2011 13:40:55 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id A19AA51ACE;
	Fri,  6 May 2011 19:40:54 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id B96C92B0E2; Fri,  6 May 2011 19:40:53 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <m3oc3guogs.fsf@localhost.localdomain>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172995>

On Fri, May 06, 2011 at 03:13:55AM -0700, Jakub Narebski wrote:
> Pierre Habouzit <madcoder@debian.org> writes:
> > If we have an ongoing operation then:
> > - if we are on a branch it displays:
> >   # On branch $branch ($what_is_ongoing)
> >   #   ($ongoing_hint)
> > - if we are on a detached head it displays:
> >   # $what_is_ongoing (detached head)
> >   #   ($ongoing_hint)
> >
> > If we have no ongoing operation the git status does as before:
> > - if we are on a branch it displays:
> >   # On branch $branch
> > - if we are on a detached head it displays:
> >   # Not currently on any branch.
>
> Very nice to have such example in commit message.
>
> > Since the ongoing operation is usually something to be done with be=
fore
> > continuing with further git operations, the hint and ongoing operat=
ions
> > are displayed with the "WT_STATUS_NOBRANCH" color to be easy to spo=
t.
> >
> > Signed-off-by: Pierre Habouzit <madcoder@debian.org>
> > ---
> >  wt-status.c |  138 +++++++++++++++++++++++++++++++++++++++++++++++=
+++++------
> >  1 files changed, 123 insertions(+), 15 deletions(-)
>=20
> Could you please add some *tests* for this new feature? =20
>=20
> Don't forget to mark it with C_LOCALE_OUTPUT or use test_i18ncmp /
> / test_i18ngrep in tests.

=46rankly I sadly don't have the time to write them, which is a very ba=
d
excuse, this is a feature I wrote for $work and that I use and I though=
t
it would be nice to share.

Generating all the possible cases is just very long, and the test
framework changed too much since the last time I used it a few years ag=
o
and I abandoned after 10minutes not being able to make it work properly=
=2E

> > +static void wt_status_print_doingwhat(struct wt_status *s)
> > +{
> > +	const char *status_nobranch =3D color(WT_STATUS_NOBRANCH, s);
> > +	const char *branch_name =3D s->branch;
> > +	const char *advice =3D NULL;
> > +
> > +	const char * const rebase_advice =3D
> > +		_("use \"git rebase --abort\" to abort current rebase or proceed=
");
> > +	const char * const am_advice =3D
> > +		_("use \"git am --abort\" to abort current mailbox apply or proc=
eed");
> > +	const char * const merge_advice =3D
> > +		_("use \"git reset --hard\" to abort, or resolve conflicts and c=
ommit");
>=20
> Thanks for marking it up for i18n... though I am not sure if we shoul=
d
> use _() or N_() here...

It's _() you want to translate those. They are used through a
printf("  (%s)", ...) later that doesn't need i18n.
--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@d=
ebian.org
OOO                                                http://www.madism.or=
g
