Received: from mail-08.mail-europe.com (mail-08.mail-europe.com [57.129.93.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB0151C69D
	for <git@vger.kernel.org>; Sun,  4 Jan 2026 10:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.129.93.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767522815; cv=none; b=sptAx4FeJzhc8LgyMeoMTj2hz5B+KM8CTLI83KfJr1m9ej6mtys6dR1jufNCCt3k4jCIxkvmFcYLAfPoyC2ouaSvguCChlxyznxg/KZv4TXjUOHD6itbatX8BmptMcFHBaME/UAgPHjJ4MejPk3JldMUdtVXkY/7hIyG93YedyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767522815; c=relaxed/simple;
	bh=+rpw0n7bb+age8cmSsmIhJqLjFAeefaOF3UZWoUYu7U=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rGnKyBNn6RiTL47ng4AWSH1rSI5KlT4yrSnqTIpG6dAIr/sNUWmWLWXriLeWg6FECYVEHbD4SU+9gwfVMLMyY7vT3SqWyK0RNZHq49neWBi3Tp05tcDtwZCKFsB2sMw6a5ZaDvchzcdKW5ZAmwcHoxNkFNdN65Epk2tFFmP+jzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=c057OcHF; arc=none smtp.client-ip=57.129.93.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="c057OcHF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1767522796; x=1767781996;
	bh=+rpw0n7bb+age8cmSsmIhJqLjFAeefaOF3UZWoUYu7U=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=c057OcHF6+eykr46R1ZSQrKIThupMLRQrlRnq7BP7Yd4e7r3Giy2DfWahZWp/Lk5q
	 yhCuIIr6qKaGJH3dTyRWDMqGIwJRfawQBo+GGeYET4hnyVkCDqRo+7NzmaTRfkcN4H
	 JaDOD1lPpxNfL5b8Z8EfZBbWZOLULHjckQPmP+vzu2Em7BC89/A4Y08X/U46L/RxlM
	 tqFbdgHtGOsG/ogTbE0b556qZDhxRWrNGxLPS/0nd2i9/Qw3VJugqq9nyZT6qJGLbd
	 Cw+jVNmc/l8UekOTETLlXDx4JdDPxqKW6F+JwmtMfWWdXLHI5mP9Oyxim+a3GCG+vK
	 5E/iriv3V4r7w==
Date: Sun, 04 Jan 2026 10:33:12 +0000
To: Junio C Hamano <gitster@pobox.com>
From: Tsahi Elkayam <Tsahi.Elkayam@protonmail.com>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>, "ps@pks.im" <ps@pks.im>
Subject: Re: [PATCH] reftable/iter: fix undefined behavior in indexed_table_ref_iter_next
Message-ID: <aHbWlZCRqQoHJ3jf12sxAyC7dEuzxCJ82PCtxH1RLcE23XSa7n8jl3yyoJ382TZ45H4pTuewB4WR72yL_zVzadotQ8UIVOBXpIkld45Ieew=@protonmail.com>
In-Reply-To: <W6v12kkhI_qyFV03jZJriHkrs5pYt8tHCD4ve0bWxikUYAGasvwwWDV3Df67dM2ttRh49EECD_Ph84NbtpxE1Opv-Z03UcE7vtbMjsYhfWs=@protonmail.com>
References: <Q0zfHYp-_TO2h_5PXPG9KjHwpMKIf2o2u2dsaoAjIsScmA3W6t7IvqIEeLfM7auEFIQyazlNnA3MGAuS4AANF0yfEBJAjkU1bWp-NH9m89U=@protonmail.com> <xmqqy0menlc3.fsf@gitster.g> <W6v12kkhI_qyFV03jZJriHkrs5pYt8tHCD4ve0bWxikUYAGasvwwWDV3Df67dM2ttRh49EECD_Ph84NbtpxE1Opv-Z03UcE7vtbMjsYhfWs=@protonmail.com>
Feedback-ID: 35521663:user:proton
X-Pm-Message-ID: b5d4ba3a0126abd32fe27b734de1c8f2cf592159
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Junio,

Thank you very much for your feedback. It is a great honor for me to receiv=
e a response from you.

I apologize for the formatting issues in my previous email. I am a new deve=
loper and still learning the community's workflow. English is not my native=
 language, and I mistakenly added indentation when composing the email, whi=
ch I now realize corrupted the patch.

I will send a corrected Version 2 (v2) of the patch shortly, ensuring that =
the format is preserved correctly.

Thank you for your patience and for the "lesson learned."

Best regards, Tsahi




Sent with Proton Mail secure email.

On Sunday, January 4th, 2026 at 12:22 PM, Tsahi Elkayam <Tsahi.Elkayam@prot=
onmail.com> wrote:

>=20
>=20
> So I did messed up
> sorry lesson learned
> but still...
> wow very exciting
>=20
>=20
> Sent from Proton Mail for iOS.
>=20
> -------- Original Message --------
> On Sunday, 01/04/26 at 04:49 Junio C Hamano gitster@pobox.com wrote:
>=20
> Tsahi Elkayam Tsahi.Elkayam@protonmail.com writes:
>=20
> > The indexed_table_ref_iter_next() function accesses ref->value.val2
> > without first checking the ref's value_type. This is undefined behavior
> > when the ref is not of type REFTABLE_REF_VAL2.
> >=20
> > The correct pattern is already used in filtering_ref_iterator_next()
> > which checks value_type before accessing the appropriate union member.
> > Apply the same pattern here:
> >=20
> > - Check for REFTABLE_REF_VAL2 before accessing val2 members
> > - Add missing check for REFTABLE_REF_VAL1 to handle single-value refs
> >=20
> > This was marked with a "/* BUG */" comment indicating the issue was
> > known but not yet fixed.
> >=20
> > Signed-off-by: Tsahi Elkayam Tsahi.Elkayam@protonmail.com
> > ---
> > reftable/iter.c | 13 ++++++++-----
> > 1 file changed, 8 insertions(+), 5 deletions(-)
> >=20
> > diff --git a/reftable/iter.c b/reftable/iter.c
> > index 2ecc52b336..2eee65bb1e 100644
> > --- a/reftable/iter.c
> > +++ b/reftable/iter.c
>=20
>=20
> What are these lines with two-whitespace indent about? When sending
> a patch purely for discussion (because the actual change may be iffy
> or dangerous), we sometimes deliberately corrupt the patch not to
> apply mechanically, but this patch does not seem to be such a
> "request for discussion" patch.
