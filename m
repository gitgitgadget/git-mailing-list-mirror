From: Alexey Shumkin <alex.crezoff@gmail.com>
Subject: Re: [PATCH v3 1/2] pretty: Add failing tests: user format ignores
 i18n.logOutputEncoding setting
Date: Wed, 21 Sep 2011 00:46:02 +0400
Message-ID: <20110921004602.3d59bed4@zappedws>
References: <7v1uvptjhr.fsf@alter.siamese.dyndns.org>
 <1316506892-6072-1-git-send-email-zapped@mail.ru>
 <7vaa9z6n9p.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 20 22:46:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R67Cr-0004Wq-0p
	for gcvg-git-2@lo.gmane.org; Tue, 20 Sep 2011 22:46:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751514Ab1ITUqM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 20 Sep 2011 16:46:12 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:40540 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751182Ab1ITUqK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 20 Sep 2011 16:46:10 -0400
Received: by wyg34 with SMTP id 34so873178wyg.19
        for <git@vger.kernel.org>; Tue, 20 Sep 2011 13:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer
         :mime-version:content-type:content-transfer-encoding;
        bh=WPND67G9ZhsvXbgqpF2aQHzrvPKtfrpGUyaluNisI2U=;
        b=tHkSwyjg2db4tj5eCz2wqV+mwsA4D7FnkcFX8B8S3EctcDuUy9MBh6wAs72LGRD6G4
         cQ0davPykZBcfGbaQsKNSB5DbF/pbNxM31aEf39azXP7ex98rZeUAGw3DyV8cfxnnMBZ
         JdcqjOWqBzNLUnSIGkoZYEckaqbi3zKIilsFU=
Received: by 10.227.11.81 with SMTP id s17mr1477185wbs.62.1316551569623;
        Tue, 20 Sep 2011 13:46:09 -0700 (PDT)
Received: from zappedws (ppp91-77-15-134.pppoe.mtu-net.ru. [91.77.15.134])
        by mx.google.com with ESMTPS id fd4sm4000945wbb.21.2011.09.20.13.46.08
        (version=SSLv3 cipher=OTHER);
        Tue, 20 Sep 2011 13:46:09 -0700 (PDT)
In-Reply-To: <7vaa9z6n9p.fsf@alter.siamese.dyndns.org>
X-Mailer: Claws Mail 3.7.9 (GTK+ 2.22.0; i386-redhat-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181796>

> Alexey Shumkin <zapped@mail.ru> writes:
>=20
> > diff --git a/t/t4041-diff-submodule-option.sh
> > b/t/t4041-diff-submodule-option.sh ...
> > @@ -48,28 +53,25 @@ head2=3D$(add_file sm1 foo3)
> > =20
> >  test_expect_success 'modified submodule(forward)' "
>=20
> As this is [PATCH 1/2], doesn't this patch make this test fail,
> calling for test_expect_failure here (and then later in 2/2 to be
> flipped back to test_expect_success)?
I did not know how is right.
AFAIK, XP way tells to write failing tests and then=20
patch/fix the code to pass them.

Here, As I understand now all tests must be successful
The difference is in expectation of failure or success.
Ok. I got it and I will reroll the patches.
>=20
> >  	git diff-index -p --submodule=3Dlog HEAD >actual &&
> > -	cat >expected <<-EOF &&
> > -Submodule sm1 $head1..$head2:
> > -  > Add foo3
> > -EOF
> > +	printf \"Submodule sm1 $head1..$head2:\n\
> > +  > Add foo3 ($added foo3)\n\
> > +\" > expected &&
> >  	test_cmp expected actual
> >  "
>=20
> Hmmm... why printf?  Is it worth to force reviewers wonder what would
> happen if any of these $variables happened to have "%" in them?  Are
> you benefiting from any printf features that you cannot achieve with
> the original cat?
This is a remained from v1 patch code. It is not required now.
I'll fix it. Thanks.=20

> This hunk and others throughout your patch that change cat with here
> doc into printf seem to make the tests less legible, at least to me.
>=20
> Perhaps like this instead, if the "flushed left" of the original
> looked ugly to your eyes?
No, the reason was not in "flushed left". And, BTW, this code generates
expected output that has predefined format...
>=20
> @@ -49,27 +54,25 @@ head2=3D$(add_file sm1 foo3)
>  test_expect_success 'modified submodule(forward)' "
>  	git diff-index -p --submodule=3Dlog HEAD >actual &&
>  	cat >expected <<-EOF &&
> -Submodule sm1 $head1..$head2:
> -  > Add foo3
> -EOF
> +	Submodule sm1 $head1..$head2:
> +	  > Add foo3 ($added foo3)
> +	EOF
>  	test_cmp expected actual
>  "
>=20
--=20
=D0=A1 =D1=83=D0=B2=D0=B0=D0=B6=D0=B5=D0=BD=D0=B8=D0=B5=D0=BC, =D0=90=D0=
=BB=D0=B5=D0=BA=D1=81=D0=B5=D0=B9 =D0=A8=D1=83=D0=BC=D0=BA=D0=B8=D0=BD
=D0=9F=D1=80=D0=BE=D0=B3=D1=80=D0=B0=D0=BC=D0=BC=D0=B8=D1=81=D1=82 =D0=BA=
=D0=BE=D0=BC=D0=BF=D0=B0=D0=BD=D0=B8=D0=B8 1=D0=A1-=D0=A0=D0=B0=D1=80=D1=
=83=D1=81
E-mail: ashu@rarus.ru
ICQ: 118001447
Jabber (GoogleTalk): ashu@rarus.ru
Skype: crezoff
