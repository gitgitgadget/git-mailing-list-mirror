From: Alexey Shumkin <alex.crezoff@gmail.com>
Subject: Re: [PATCH v2 1/2] t4205, t6006: Add failing tests for the case when
 i18n.logOutputEncoding is set
Date: Sat, 17 May 2014 12:52:03 +0400
Message-ID: <20140517085203.GA27165@dell-note>
References: <cover.1400254654.git.Alex.Crezoff@gmail.com>
 <c4c360c3e6760128ae1326b7463da7130b01a7e9.1400254654.git.Alex.Crezoff@gmail.com>
 <xmqqfvk9a797.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 17 10:52:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WlaLp-0006WX-Ab
	for gcvg-git-2@plane.gmane.org; Sat, 17 May 2014 10:52:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932155AbaEQIwK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 17 May 2014 04:52:10 -0400
Received: from mail-lb0-f176.google.com ([209.85.217.176]:61760 "EHLO
	mail-lb0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932145AbaEQIwI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 May 2014 04:52:08 -0400
Received: by mail-lb0-f176.google.com with SMTP id p9so2654925lbv.35
        for <git@vger.kernel.org>; Sat, 17 May 2014 01:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=bwk5mgBdXsUVTz/Vw36Cuo4DGSuISge/oJtCbsKZG1Y=;
        b=SXTlxQc95krFwgzgBKvHXYFbGTEzGEk3MFCEYpvJ+Hl7FkhIV10jEfHHvGoADq4bZj
         l0cEA+KIwNljx45jgdgNVbhmCsdRF7Bi6yR9dzHc8QRptyLw8EeIl03TBmnkzJdjvI+h
         HVaKZtDkxTkGo/KgXw8MMFQIsyT9g6BBpKnYxdndxFNi9CnPWjuQ1j8588vsHbu6F+wU
         VX7PwuGRvN2T61wKRgjvDbGR2Cj69ZOU4NhCPf7pwjY2r0jaqib4MH/+gmUiuREv6zXr
         kOD0IgBuyA/JVhPbqavmkBFgCbfmc3TMTE0v5pjmBmK0QqNFM1jKkH3MG479uD0W8+hS
         x+uw==
X-Received: by 10.112.149.36 with SMTP id tx4mr756256lbb.59.1400316726225;
        Sat, 17 May 2014 01:52:06 -0700 (PDT)
Received: from localhost (ppp91-77-211-246.pppoe.mtu-net.ru. [91.77.211.246])
        by mx.google.com with ESMTPSA id bx3sm10895109lbd.20.2014.05.17.01.52.04
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 17 May 2014 01:52:05 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <xmqqfvk9a797.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249460>

On Fri, May 16, 2014 at 11:49:40AM -0700, Junio C Hamano wrote:
> Alexey Shumkin <alex.crezoff@gmail.com> writes:
>=20
> > Pretty format string %<(N,[ml]trunc)>%s truncates subject to a give=
n
> > length with an appropriate padding. This works for non-ASCII texts =
when
> > i18n.logOutputEncoding is UTF-8 only (independently of a printed co=
mmit
> > message encoding) but does not work when i18n.logOutputEncoding is =
NOT
> > UTF-8.
> >
> > There were no breakages as far as were no tests for the case
> > when both a commit message and logOutputEncoding are not UTF-8.
> >
> > Add failing tests for that which will be fixed in the next patch.
> >
> > Signed-off-by: Alexey Shumkin <Alex.Crezoff@gmail.com>
> > Reviewed-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> > ---
> >  t/t4205-log-pretty-formats.sh | 169 ++++++++++++++++++++++++++++++=
++++++++++++
> >  t/t6006-rev-list-format.sh    |  75 ++++++++++++++++++-
> >  2 files changed, 242 insertions(+), 2 deletions(-)
> >
> > diff --git a/t/t4205-log-pretty-formats.sh b/t/t4205-log-pretty-for=
mats.sh
> > index 2a6278b..6791e0d 100755
> > --- a/t/t4205-log-pretty-formats.sh
> > +++ b/t/t4205-log-pretty-formats.sh
> > @@ -153,6 +153,19 @@ EOF
> >  	test_cmp expected actual
> >  '
> > =20
> > +test_expect_success 'left alignment formatting. i18n.logOutputEnco=
ding' '
> > +	git -c i18n.logOutputEncoding=3Diso8859-1 log --pretty=3D"format:=
%<(40)%s" >actual &&
> > +	# complete the incomplete line at the end
> > +	echo >>actual &&
>=20
> Would it change the meaning of the test if you used tformat: instead
> of format: (or --format=3D"%<(40)%s")?  If it doesn't, it would make
> it unnecessary to append an extra LF and explain why you do so.
Well, actually, I just copied previous tests and added
i18n.logOutputEncoding.

But as I can see in the code - no, tformat will not change the meaning.
so, may be there is a reason to change that (initial) tests from format
to tformat first? And then add mine new.
>=20
> > +	qz_to_tab_space <<EOF | iconv -f utf-8 -t iso8859-1 >expected &&
>=20
> It is minor but many existing uses of iconv in our tests spell these
> as UTF-8 and ISO8859-1 in uppercase.  I vaguely recall there was a
> portability concern to favor the ones that are used in existing
> tests, but probably it no longer matters (I see you added the
> lowercase one with de6029a2 mid last year), so I am fine if these
> stay lowercase.
I've grep'ed for lowercase iso8859-1 in test, and found almost all of
them is code added by me.
Grep for uppercase gives more results. I can refactor that first for
uniformity.
>=20
> > +	git -c i18n.logOutputEncoding=3Diso8859-1 log --pretty=3D"format:=
%<(1)%s" >actual &&
> > +	# complete the incomplete line at the end
> > +	echo >>actual &&
>=20
> Likewise for all the other "--pretty=3Dformat:" followed by an echo.
the same copy-paste-modify.

>=20
> Thanks.

--=20
Alexey Shumkin
