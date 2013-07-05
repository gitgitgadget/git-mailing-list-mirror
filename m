From: Alexey Shumkin <alex.crezoff@gmail.com>
Subject: Re: [PATCH v9 4/5] t6006: add two more tests for the case
 i18n.commitEncoding is not set
Date: Fri, 5 Jul 2013 11:46:44 +0400
Message-ID: <20130705074644.GA32072@ashu.dyn1.rarus.ru>
References: <cover.1372939482.git.Alex.Crezoff@gmail.com>
 <d1e6681bea4a69d4774b09e4cb776f4cd6e6dcc9.1372939482.git.Alex.Crezoff@gmail.com>
 <7vk3l5a3nh.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, John Keeping <john@keeping.me.uk>,
	Johannes Sixt <j.sixt@viscovery.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 05 09:47:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uv0jH-0005r3-QG
	for gcvg-git-2@plane.gmane.org; Fri, 05 Jul 2013 09:46:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932264Ab3GEHqv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 5 Jul 2013 03:46:51 -0400
Received: from mail-lb0-f169.google.com ([209.85.217.169]:37439 "EHLO
	mail-lb0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932201Ab3GEHqu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jul 2013 03:46:50 -0400
Received: by mail-lb0-f169.google.com with SMTP id d10so1813539lbj.0
        for <git@vger.kernel.org>; Fri, 05 Jul 2013 00:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=4aLtr1XiRIobc/xo3y/+3tfjjH3IRL3Gh2VJOJMtWB8=;
        b=k0j25NnhZE9WNKNPEfw1fFvBDYwbaNXTs/ipwfEYRYa8gsvU+9sCROfL/4fDTHQd8a
         /yI9BnGr3f3nrP97ScrTkpXh0YE7ZB7N31N+hbInxBFYA3lyEyXV4WXMjpDgxZ1HnPG+
         lEpfeEygz58WufyOJHMYLTjPm+VO5pnNX1bDm70BBgzGJY/iGHqNDn3HbnBchsXK1EU7
         wcxg4Yw5hDWheKrsrS17qxVfyNBcS5zv7Kt+YKKY/8cntGkMTulKXFLAzA1XoZBMc7aY
         HXpFK/pnWjQ+RgtRSuomMFcTj8+ESpv9asKkfg0sBBckSzEsa/EdcqrEAhPxQjj+rZEG
         fXgA==
X-Received: by 10.152.44.170 with SMTP id f10mr4370778lam.68.1373010408175;
        Fri, 05 Jul 2013 00:46:48 -0700 (PDT)
Received: from localhost ([85.21.218.130])
        by mx.google.com with ESMTPSA id w9sm2461246lbk.7.2013.07.05.00.46.46
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 05 Jul 2013 00:46:47 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vk3l5a3nh.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229632>

On Fri, Jul 05, 2013 at 12:04:34AM -0700, Junio C Hamano wrote:
> Alexey Shumkin <alex.crezoff@gmail.com> writes:
>=20
> > +test_format complex-body %b <<EOF
> > +commit $head3
> > +This commit message is much longer than the others,
> > +and it will be encoded in iso8859-1. We should therefore
> > +include an iso8859 character: =C2=A1bueno!
>=20
> This is not such a good idea, as the resulting file will be in mixed
> encoding (it already has a line with non-ascii that is in UTF-8),
> and many editors would not like such a file.
I agree, there was issues when I edited that file
>=20
> Perhaps we should update test_format so that we can feed a quoted
> input, e.g.
>=20
>     +include an iso8859-1 character: <A1>bueno!
>=20
> or something?
We could use this file whole in UTF-8 but just make a conversion of
expected output as it's done a few lines above with a commit message
(stored to a file 'commit-msg' before the test 'setup complex body').
    +iconv -f utf-8 -t iso8859-1 > commit-msg <<EOF
    +Test printing of complex bodies
We can even use content of that file (as far as it's kept untouched
between that tests)

>=20
> > +commit $head2
> > +commit $head1
> > +EOF
> > +
> > +# Git uses i18n.commitEncoding if no i18n.logOutputEncoding set
> > +# so unset i18n.commitEncoding to test encoding conversion
> > +git config --unset i18n.commitEncoding
> > +
> > +test_format complex-subject-commitencoding-unset %s <<EOF
> > +commit $head3
> > +Test printing of complex bodies
> > +commit $head2
> >  $changed
> >  commit $head1
> >  $added
> >  EOF
> > =20
> > -test_format complex-body %b <<EOF
> > +test_format complex-body-commitencoding-unset %b <<EOF
> >  commit $head3
> >  This commit message is much longer than the others,
> >  and it will be encoded in iso8859-1. We should therefore

--=20
Alexey Shumkin
