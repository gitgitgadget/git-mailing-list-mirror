From: Kevin Ballard <kevin@sb.org>
Subject: Re: [PATCH] attr: support quoting pathname patterns in C style
Date: Tue, 9 Nov 2010 16:27:26 -0800
Message-ID: <3E6FDAC8-9CA6-455E-8C08-319C3955947D@sb.org>
References: <AANLkTinNctmWpshBeSTzZRm6+EJ=Cjdpoaj4Aon+52_b@mail.gmail.com> <1288878944-14066-1-git-send-email-pclouds@gmail.com> <7vvd4bu2pl.fsf@alter.siamese.dyndns.org> <15C4C111-824D-4657-B034-A1BE1DAD50D4@sb.org> <7v8w13r756.fsf@alter.siamese.dyndns.org> <626BD1B6-4DDF-457F-B430-F15C891710E2@sb.org> <7vpquejb26.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc_Duy?= 
	<pclouds@gmail.com>, git@vger.kernel.org,
	Marc Strapetz <marc.strapetz@syntevo.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 10 01:27:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PFyXK-0003pn-Vx
	for gcvg-git-2@lo.gmane.org; Wed, 10 Nov 2010 01:27:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752156Ab0KJA1e convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 9 Nov 2010 19:27:34 -0500
Received: from mail-pz0-f46.google.com ([209.85.210.46]:55539 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752037Ab0KJA1d convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 9 Nov 2010 19:27:33 -0500
Received: by pzk28 with SMTP id 28so11992pzk.19
        for <git@vger.kernel.org>; Tue, 09 Nov 2010 16:27:33 -0800 (PST)
Received: by 10.143.35.4 with SMTP id n4mr6831974wfj.268.1289348852684;
        Tue, 09 Nov 2010 16:27:32 -0800 (PST)
Received: from [10.8.0.89] ([69.170.160.74])
        by mx.google.com with ESMTPS id p8sm21918wff.16.2010.11.09.16.27.29
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 09 Nov 2010 16:27:31 -0800 (PST)
In-Reply-To: <7vpquejb26.fsf@alter.siamese.dyndns.org>
X-Mailer: Apple Mail (2.1081)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161113>

On Nov 9, 2010, at 4:07 PM, Junio C Hamano wrote:

> Kevin Ballard <kevin@sb.org> writes:
>=20
>> Basically what I'm trying to say is, we already break one particular
>> "rather rare" setup.
>=20
> Let's try again.  One particular "rather rare" setup never worked.  A=
s it
> is "rather rare", we do not really care that deeply to make that work=
=2E
> Another particular "rather rare" setup used to work.  Even though we =
do
> not really care that deeply to keep it working, is it worth breaking =
it?

My feeling is yes. My suspicion is that paths that begin with a dq are =
extremely
rare, and ones that have custom git attributes set on them are rarer st=
ill.
I would rather make the change to support an unambiguous format to spec=
ify
any possible path and simply apologize if anyone is actually hit by thi=
s.

>> ... I would love to come up with a solution that supports both setup=
s,
>> but I don't know if one exists outside of using a config variable to
>> control whether git attribute patterns support quoting (a solution I=
 am
>> not particularly fond of for this case).
>=20
> Controlling this with a config would be a disaster.  It would mean th=
at
> the same version of updated git would interpret the same .gitattribut=
es
> file differently, and the situation will continue forever.

Precisely why I was not fond of this suggestion.

> Compared to
> that, the idea J6t brought up would be far easier to swallow.  Older
> vintage of git will misbehave on "rather rare" paths upon seeing a cq=
uoted
> pattern (i.e. the pattern will not match the intended paths, and will
> instead match "rather rare" paths that begin with dq) but that is no =
worse
> than what we already have.  And newer vintages of git will interpret =
the
> attribute file written with that magic exactly the same way everywher=
e,
> regardless of the configuration setting.
>=20
> Having said all that, I actually am in favor of using cquote.  It wou=
ld
> have been what we should have done in the first place.

Agreed.

> My preference is to admit that we made a mistake of not using cquote =
when
> we originally introduced .gitattributes, clearly state that the versi=
on of
> git with this new backward incompatible feature will _break_ rare exi=
sting
> setups if they had paths whose name begin with a dq and applied attri=
butes
> to them, and use cquote unconditionally, perhaps with a version bump.
>=20
> I just didn't like the tone of saying "Nobody would have used such an
> insane path anyway so we don't care".  I am Ok if our message is "Sor=
ry,
> this release would break if you used to rely on this; we think it is
> unlikely and are hoping that most of you won't be affected".

Also agreed. I never meant to imply that we didn't care about paths beg=
inning
with a dq, I just thought it was unlikely enough that I would never run=
 into
someone using such a path ;)

In any case, I just took a look at Nguy=E1=BB=85n's patch and it looks =
good to me.

-Kevin Ballard
