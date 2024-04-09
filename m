Received: from eggs.gnu.org (eggs.gnu.org [209.51.188.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42078370
	for <git@vger.kernel.org>; Tue,  9 Apr 2024 20:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.51.188.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712695513; cv=none; b=WEyj+G1EwvKk+eFGEi4H6en/o4w9eYdwBaW/+8zB2ydN8QRy58tV759TIwa8DQKy3MZiiKR2EwyYllv0GY0SFpEU6yc7kA+Zl6RmvfzlfgYm10jKSSsXmOEWON9zcFRH9FdM5m4o9LS0DAEITBJIZyZBSKHbJgjYLNH6hrmT7ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712695513; c=relaxed/simple;
	bh=A8+DXbnJhONagh9K5X+d2S13yruxGx/3r1tYVA9BZ48=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=f6nWQMq/LeFAw/cStybdTiO2azf8QxkYX9EqsSFHvpZYZ/l8OyGXnG2l3UgOjQPvPMEE1wxMGGn7b/BX7ldXAPvkmIhVBnEzQuGyL1ImwnDvwJ4TQlT9p83o/s2IrWT9kf5+UBZ0Cm6dlHyJN4XyifWM0PG66lDbkFurKhKx52w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gnu.org; spf=pass smtp.mailfrom=gnu.org; dkim=pass (2048-bit key) header.d=gnu.org header.i=@gnu.org header.b=NXC7G+vA; arc=none smtp.client-ip=209.51.188.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gnu.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gnu.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gnu.org header.i=@gnu.org header.b="NXC7G+vA"
Received: from fencepost.gnu.org ([2001:470:142:3::e])
	by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.90_1)
	(envelope-from <psmith@gnu.org>)
	id 1ruIL5-0007VR-Ks
	for git@vger.kernel.org; Tue, 09 Apr 2024 16:45:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=gnu.org;
	s=fencepost-gnu-org; h=MIME-Version:References:In-Reply-To:Date:To:From:
	Subject; bh=euKr6Rd62iLaEQK7KaRlAoV4ExN1QStsBaizk4vz9lw=; b=NXC7G+vAqMeacIkj+
	QZ3OpB3DpFBWeZYuZ/LpYHt8vbK11X9PGfPfpouY0wahOD6lw/59Uu0pv5zWNd1xtOWr2fjzRf+KZ
	0F+MwkpDzgNC2enhzCvX+WyuCP73xUGxLbThsByJYOtkvPJs6pPO0E5ViohK2PXw1tO19J+IJPYzx
	R703DJChQi48dxkRRRVGEot2i8u3UsD51X3TcmRZtIKGU73CInHLA8A+HWOU0cXy2DG7tU69E9LqH
	JeL4yua9PXbwBu/FF/6/ymqywhXlTVUK+oIHeEYfZoiSIVR1C83sqOjmsMU2N1kXUq5fvXuPQgr9m
	G/QmUauO5JOaEJ4DA==;
Message-ID: <daa51548ff2d0cfc4407bbdbe99223c84321a503.camel@gnu.org>
Subject: Re: [PATCH] Makefile(s): avoid recipe prefix in conditional
 statements
From: Paul Smith <psmith@gnu.org>
Reply-To: psmith@gnu.org
To: git@vger.kernel.org
Date: Tue, 09 Apr 2024 16:44:45 -0400
In-Reply-To: <20240409000414.GA1647304@coredump.intra.peff.net>
References: 
	<CAJm4QYOxn_s8ktJiC6ju2j4OyEYaM2ay7Ca--ZWFWa7APVnTbA@mail.gmail.com>
	 <9d14c08ca6cc06cdf8fb4ba33d2470053dca3966.1712591504.git.me@ttaylorr.com>
	 <xmqqle5n8rcr.fsf@gitster.g>
	 <606990048585347654f3b4b187ec27f4dc1b85e3.camel@gnu.org>
	 <20240409000414.GA1647304@coredump.intra.peff.net>
Organization: GNU's Not UNIX!
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.0 (by Flathub.org) 
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-04-08 at 20:04 -0400, Jeff King wrote:
> > .RECIPEPREFIX was introduced in GNU Make 3.82, which was released
> > in 2010 FYI.
>=20
> Unfortunately, that's too recent for us. :( We try to keep the GNU
> make dependency to 3.81, since that's the latest one Apple ships
> (because they're allergic to GPLv3).

I understand that position, for Git.  I hope you can understand that in
my position I have no interest in catering to Apple's ridiculous
corporate antics and can only shrug and say "oh well" :)

> I do find it curious that in:
>=20
> ifdef FOO
> =C2=A0SOME_VAR +=3D bar
> endif
>=20
> the tab is significant for "ifdef" but not for SOME_VAR (at least
> that is implied by Taylor's patch, which does not touch the bodies
> within the conditionals).

The handling of TAB in makefiles is actually more subtle than the
simple "if it starts with a TAB it's part of a recipe".  The full
statement is, "if it starts with a TAB _and is in a recipe context_
then it's part of a recipe".

A recipe context starts after a target is defined, and it ends only
when the first non-TAB-indented, non-comment line is parsed (or EOF).

The text above will work ONLY if the content BEFORE that text is not a
recipe.  If you add a recipe before that line, then the SOME_VAR +=3D bar
will suddenly be considered by make as part of that recipe and will be
an error when you run that recipe (since that's not valid shell
syntax).

So for example if you have:

  $ cat Makefile

  # set up the variable SOME_VAR
  ifndef TRUE
  <TAB>SOME_VAR =3D bar
  endif

  all: ; echo $(SOME_VAR)

This is fine.  But if you then modify your makefile like this:

  $ cat Makefile

  recurse: ; $(MAKE) -C subdir

  # set up the variable SOME_VAR
  ifndef TRUE
  <TAB>SOME_VAR =3D bar
  endif

  all: ; echo $(SOME_VAR)

It LOOKS fine but it's completely broken because the SOME_VAR
assignment now becomes part of the recipe for the recurse target.

   (Just to note, this is not due to a recent change in GNU Make, and
   in fact this is not even specific to GNU Make: all versions of make
   behave like this.)

So while the patch proposed here does not remove all TAB characters, my
best advice is that as a project you SHOULD consider pro-actively
removing all non-recipe-introducing TAB characters.  They are dangerous
and misleading, even outside of this ifdef kerfuffle.


All I can do is reiterate my original statement: it's a bad idea to
consider TAB characters as whitespace or "just indentation" AT ALL when
editing makefiles.  TABs are not whitespace.  They are meaningful
tokens, like "$" or "#", and should only ever be used in places where
that meaning is desired.  The fact that they look like indentation and
can be used in some other places as "just indentation" and kinda-sorta
work, is an accident waiting to happen if it's taken advantage of.
