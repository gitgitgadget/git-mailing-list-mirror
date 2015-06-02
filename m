From: Remi Galan Alfonso <remi.galan-alfonso@ensimag.grenoble-inp.fr>
Subject: Re: [PATCH/RFCv2 2/2] git rebase -i: warn about removed commits
Date: Tue, 2 Jun 2015 09:42:45 +0200 (CEST)
Message-ID: <53678876.5326.1433230965582.JavaMail.zimbra@ensimag.grenoble-inp.fr>
References: <1433159523-6596-1-git-send-email-remi.galan-alfonso@ensimag.grenoble-inp.fr> <1433159523-6596-2-git-send-email-remi.galan-alfonso@ensimag.grenoble-inp.fr> <CAPig+cRGT4qgCNgVi_x-==GKze7VUPVbVPGHYui7y5ZXie72Qw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>,
	Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>,
	Guillaume Pages <guillaume.pages@ensimag.grenoble-inp.fr>,
	Louis-Alexandre Stuber 
	<louis--alexandre.stuber@ensimag.grenoble-inp.fr>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Philip Oakley <philipoakley@iee.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue Jun 02 09:43:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yzgqf-0000A6-Qz
	for gcvg-git-2@plane.gmane.org; Tue, 02 Jun 2015 09:42:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752199AbbFBHms convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 2 Jun 2015 03:42:48 -0400
Received: from zm-etu-ensimag-2.grenet.fr ([130.190.244.118]:33201 "EHLO
	zm-etu-ensimag-2.grenet.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751455AbbFBHmq convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Tue, 2 Jun 2015 03:42:46 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id 9954C280F;
	Tue,  2 Jun 2015 09:42:44 +0200 (CEST)
Received: from zm-smtpout-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id t-YXRo1z3s3S; Tue,  2 Jun 2015 09:42:44 +0200 (CEST)
Received: from zm-int-mbx1.grenet.fr (zm-int-mbx1.grenet.fr [130.190.242.140])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id 84591278A;
	Tue,  2 Jun 2015 09:42:44 +0200 (CEST)
In-Reply-To: <CAPig+cRGT4qgCNgVi_x-==GKze7VUPVbVPGHYui7y5ZXie72Qw@mail.gmail.com>
X-Originating-IP: [130.190.242.137]
X-Mailer: Zimbra 8.0.9_GA_6191 (ZimbraWebClient - FF38 (Linux)/8.0.9_GA_6191)
Thread-Topic: git rebase -i: warn about removed commits
Thread-Index: RS9tfQk2TsXYa0ZCZG+eCH1AnKg93A==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270505>

Eric Sunshine <sunshine@sunshineco.com> writes:
> > +rebase.checkLevel::
> > +       If set to "warn", git rebase -i will print a warning if som=
e
> > +       commits are removed (i.e. a line was deleted) or if some
> > +       commits appear more than one time (e.g. the same commit is
> > +       picked twice), however the rebase will still proceed. If se=
t
>=20
> The cover letter says that v2 no longer checks for a duplicate,
> however, this documentation still mentions it.
>=20
> > +rebase.checkLevel::
> > +       If set to "warn" print warnings about removed commits and
> > +       duplicated commits in interactive mode. If set to "error"
>=20
> Same here.

I forgot to modify the documentation, really sorry about
that.
Corrected here.

Eric Sunshine <sunshine@sunshineco.com> writes:
> >  test_expect_success 'drop' '
> > -       git checkout master &&
> >         test_when_finished "git checkout master" &&
> >         git checkout -b dropBranchTest master &&
>=20
> This "cleanup" change might deserve its own patch (or at least a
> mention in the commit message).

I will rather move the this cleanup to the first part of this patch,
where the test was added (it should cause no problem, since the patch
is still in discussion), it makes more sense. I actually thought that
was what I did but seems like I was wrong.

I forgot to double check my patch this time, and it is showing, my
bad.

Eric Sunshine <sunshine@sunshineco.com> writes:
> > +test_expect_success 'rebase -i respects rebase.checkLevel' '
> > +       test_config rebase.checkLevel error &&
> > +       test_when_finished "git checkout master" &&
> > +       git checkout -b tmp2 master &&
> > +       set_fake_editor &&
> > +       test_must_fail env FAKE_LINES=3D"1 2 3 4" git rebase -i --r=
oot &&
> > +       test E =3D $(git cat-file commit HEAD | sed -ne \$p)
> > +'
>=20
> Shouldn't you also explicitly test "warn" and "ignore" modes?

I don't think testing "ignore" is really necessary since it
corresponds to the default behaviour, it is thus silently tested by
the other tests.
Either way, I will add a test for "warn".

R=C3=A9mi
