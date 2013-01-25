From: Alexey Shumkin <alex.crezoff@gmail.com>
Subject: Re: [PATCH v4 3/4] pretty: Add failing tests: user format ignores
 i18n.logOutputEncoding setting
Date: Fri, 25 Jan 2013 13:01:52 +0400
Message-ID: <20130125130152.63f7c14f@ashu.dyn1.rarus.ru>
References: <cover.1359018188.git.Alex.Crezoff@gmail.com>
	<6de583a2d281b1614c69d5e7b6f5c4495488f6a3.1359018188.git.Alex.Crezoff@gmail.com>
	<7vip6m9tvj.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 25 10:02:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TyfAx-0007fb-RL
	for gcvg-git-2@plane.gmane.org; Fri, 25 Jan 2013 10:02:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753300Ab3AYJB5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 25 Jan 2013 04:01:57 -0500
Received: from mail-lb0-f181.google.com ([209.85.217.181]:37618 "EHLO
	mail-lb0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751519Ab3AYJB4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 25 Jan 2013 04:01:56 -0500
Received: by mail-lb0-f181.google.com with SMTP id gm6so301497lbb.26
        for <git@vger.kernel.org>; Fri, 25 Jan 2013 01:01:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:in-reply-to
         :references:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=dlUf+PE2rQiGQHYiFhCNSiofRBnA3xgZmH7Bmy8brAk=;
        b=yhz51t6DCz6gq+whxIK3tENcpak7rWMwkCF85Kz485OpwAh3icxIRYy8Te2t56VQZa
         H+JuxMxKazF+doM91nDKAyd+G0zrQCrLS8vvQAMdVpLiStkOrBerWUbPCLdbak1frcjz
         fDQwFWZDlhKamO3TAUEmFu/AT/6tRc8UCq5+Tzlo+L1gPgLFYrn+DhbuSIZkUIcoQszS
         3aLIKvQs8Dqzsbln99+f1YaYySE0H+qRo47oAl4rxPEgJGgdZR4Mh5FncSUopSxoPvcj
         d42JnTGtFRh7W95ZU2Ltztcfm3he5E1FvRXpwG1EoQVc0z+QzAoh3SZtN746MzmxwlXe
         X6fg==
X-Received: by 10.152.104.36 with SMTP id gb4mr4526406lab.13.1359104514735;
        Fri, 25 Jan 2013 01:01:54 -0800 (PST)
Received: from ashu.dyn1.rarus.ru ([85.21.218.130])
        by mx.google.com with ESMTPS id gt13sm157047lab.14.2013.01.25.01.01.54
        (version=SSLv3 cipher=RC4-SHA bits=128/128);
        Fri, 25 Jan 2013 01:01:54 -0800 (PST)
In-Reply-To: <7vip6m9tvj.fsf@alter.siamese.dyndns.org>
X-Mailer: Claws Mail 3.9.0 (GTK+ 2.24.13; x86_64-redhat-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214519>

> Alexey Shumkin <alex.crezoff@gmail.com> writes:
>=20
> > diff --git a/t/t6006-rev-list-format.sh b/t/t6006-rev-list-format.s=
h
> > index c248509..4db43a4 100755
> > --- a/t/t6006-rev-list-format.sh
> > +++ b/t/t6006-rev-list-format.sh
> > ...
> > @@ -112,12 +133,12 @@ commit $head2
> >  commit $head1
> >  EOF
> > =20
> > -test_format raw-body %B <<'EOF'
> > -commit 131a310eb913d107dd3c09a65d1651175898735d
> > -changed foo
> > +test_format failure raw-body %B <<EOF
> > +commit $head2
> > +$changed
> > =20
> > -commit 86c75cfd708a0e5868dc876ed5b8bb66c80b4873
> > -added foo
> > +commit $head1
> > +$added
> > =20
> >  EOF
>=20
> It may have been easier to follow if you did this "Don't hardcode"
> as a separate preparatory patch, like your first two patches.
Yep, I missed that in my bunch of rebasing ;)

>=20
> > @@ -135,16 +156,16 @@ commit $head1
> >  foo
> >  EOF
> > =20
> > -cat >commit-msg <<'EOF'
> > +iconv -f utf-8 -t cp1251 > commit-msg <<EOF
> >  Test printing of complex bodies
> > =20
> >  This commit message is much longer than the others,
> > -and it will be encoded in iso8859-1. We should therefore
> > -include an iso8859 character: =C2=A1bueno!
> > +and it will be encoded in cp1251. We should therefore
> > +include an cp1251 character: =D1=82=D0=B0=D0=BA =D0=B2=D0=BE=D1=82=
!
> >  EOF
> > =20
> >  test_expect_success 'setup complex body' '
> > -	git config i18n.commitencoding iso8859-1 &&
> > +	git config i18n.commitencoding cp1251 &&
>=20
> What is going on here?
>=20
> Is this an example that shows that i18n.commitencoding works
> correctly with iso8859-1 but not with cp1251?
It show only that I speak and write Russian not Spanish ))
I'll revert back these changes.

>=20
> > diff --git a/t/t7102-reset.sh b/t/t7102-reset.sh
> > index cf492f4..699c824 100755
> > --- a/t/t7102-reset.sh
> > +++ b/t/t7102-reset.sh
> > ...
> > @@ -192,7 +214,7 @@ test_expect_success \
> >  	'changing files and redo the last commit should succeed' '
> >  	echo "3rd line 2nd file" >>secondfile &&
> >  	git commit -a -C ORIG_HEAD &&
> > -	check_changes 3d3b7be011a58ca0c179ae45d94e6c83c0b0cd0d &&
> > +	check_changes f06f78b8dd468c722952b77569dd0db212442c25 &&
> >  	test "$(git rev-parse ORIG_HEAD)" =3D \
> >  			$head5
> >  '
>=20
> This and remaining hunks to this script shows that it would be
> helped by the same love you gave to other scripts with your first
> two patches before you add the "non-unicode" tests, no?
Sorry, I haven't got you :-[ (it seems, my English is not good enough)
Do you mean "avoid hardcoded SHA-1"?
