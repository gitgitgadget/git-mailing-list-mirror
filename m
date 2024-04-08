Received: from eggs.gnu.org (eggs.gnu.org [209.51.188.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5501B1DA5E
	for <git@vger.kernel.org>; Mon,  8 Apr 2024 23:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.51.188.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712618661; cv=none; b=B2ZQmib/9Q/CLa+uCNnLZ/zu9kWrufeGK5yUpQD2tHpErW1zDjSEGblASBB+/6cKheWA3ibQPIITHmvbKPf9dMI79BY/f+J1fgX/qPe4S9gxfVZ6D9yh4zTdj9a0qst75yfsXw1UVlJW+wSHT/AECBj+eNc36IhUzXO/V1MHZTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712618661; c=relaxed/simple;
	bh=WCaYJUg3Ngv2nbCN5ZuX7+Yfr+XqD3jCJs5ZKTx9MnY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EcWllRP6zPkpGZGbUVghM2KkGo6BVtlGR4z0hnQKRmoto0YvPHsO8nXf1ZHfprEg/3V0LQ4vSJnB4AqIWC9svt1eixN11lqide0eMCfDw4SHCkXvd9SveQ0gAaUCwaT6fuTBTvOso85bJaPJpBLkB/zKWZ8QLh30SGvOHiUFgpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gnu.org; spf=pass smtp.mailfrom=gnu.org; dkim=pass (2048-bit key) header.d=gnu.org header.i=@gnu.org header.b=IjqJUqHV; arc=none smtp.client-ip=209.51.188.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gnu.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gnu.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gnu.org header.i=@gnu.org header.b="IjqJUqHV"
Received: from fencepost.gnu.org ([2001:470:142:3::e])
	by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.90_1)
	(envelope-from <psmith@gnu.org>)
	id 1rtyLZ-000841-Lp; Mon, 08 Apr 2024 19:24:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=gnu.org;
	s=fencepost-gnu-org; h=MIME-Version:References:In-Reply-To:Date:To:From:
	Subject; bh=Z2k7h9yMiX4lVFUzJuo7wrkPXir6mZTycb72pSSZnhk=; b=IjqJUqHVVj65fjz5b
	y6if2GGKdnyowezMK1pBCLiFtL/sNJnBt21zbaVHKok/EcmA58O6Uh8XPW3a7EJdzvhCgSYpz0FY5
	6TYwOuuaCTJt1RothK6yP2yrrp7/arOUYt0k9CjsykF2nwJqfIzU+KQ88lD8g1gRKD24lgyKfR7+9
	6Z4NSk7t9SULAXLl2+1RJimJezd7UOghvwUhyMmtpc94Rp/tdFCrYmnDA0gTtypyVB9SEpkUXCwya
	QgKPBbeioXn4O2Eg+w3dhDVFXPmU8ghxY8nDWM3p0NviDhAPVjp9ICkj6uxAURFDY8E3FAFJdqRiu
	VmUqzNWEwVH0hMrWA==;
Message-ID: <606990048585347654f3b4b187ec27f4dc1b85e3.camel@gnu.org>
Subject: Re: [PATCH] Makefile(s): avoid recipe prefix in conditional
 statements
From: Paul Smith <psmith@gnu.org>
Reply-To: psmith@gnu.org
To: Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Dario Gjorgjevski <dario.gjorgjevski@gmail.com>, 
 Jeff King <peff@peff.net>
Date: Mon, 08 Apr 2024 19:24:16 -0400
In-Reply-To: <xmqqle5n8rcr.fsf@gitster.g>
References: 
	<CAJm4QYOxn_s8ktJiC6ju2j4OyEYaM2ay7Ca--ZWFWa7APVnTbA@mail.gmail.com>
	 <9d14c08ca6cc06cdf8fb4ba33d2470053dca3966.1712591504.git.me@ttaylorr.com>
	 <xmqqle5n8rcr.fsf@gitster.g>
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

On Mon, 2024-04-08 at 14:41 -0700, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>=20
> > When a conditional word (ifeq, ifneq, ifdef, etc.) is preceded by
> > one or
> > more tab characters, replace each tab character with 8 space
> > characters
> > with the following:
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0 find . -type f -not -path './.git/*' -name Mak=
efile -or -name
> > '*.mak' |
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 xargs perl -i -pe '
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s/(\t+)(ifn?eq|ifn?def=
|else|endif)/" " x (length($1) * 8)
> > . $2/ge unless /\\$/
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 '
>=20
> Yuck, it means auto indenting Makefile and its pieces almost
> impossible X-<.=C2=A0 I'll take the patch as there is no way to revert
> the change to GNU make, though.

I am considering whether to turn this error into a warning, for the
next release only, since it seems to be causing problems.  I have not
decided for sure yet since the change is needed to avoid a very real
parsing error (see the Savannah bug for details) which then could not
be fixed in this release.

Just to note that this usage clearly contravenes the documentation,
which states that preprocessor statement lines cannot begin with a TAB.
It was a bug that this was allowed by the GNU Make parser.

I understand that in many projects (Linux, probably Git :)) if the
documentation and behavior disagreed then the documentation would be
changed, not the behavior.

I'd love to do that as well but unfortunately there's just no way to
get coherent behavior out of GNU Make if this TAB prefix is allowed.=20
If the original authors of GNU Make had followed the lead of the BSD
make folks (or C) and used some reserved character to introduce
preprocessor statements (BSD make uses ".if"/".else" etc. which would
work) then we wouldn't be in this predicament.  But make's parser is so
ad hoc that it's impossible to fix issues like this in a completely
backward-compatible manner.

I know that the coding style in some projects is to use TAB for each
level of indentation, but I do not think it's possible to extend that
same coding style from C into makefiles.  In makefiles, a TAB is not
just whitespace it's a meaningful token and has to be reserved for use
only in places where that meaning is required: to introduce a recipe
line.  Hopefully everyone's editors have the concept of separate modes
for different types of files, with different indentation styles for
each.

My personal recommendation is that you do not take this patch as-is,
and instead request a patch that converts every TAB character that
indents a GNU Make preprocessor statement into TWO spaces rather than
8.  Or even THREE spaces (to avoid indentation that matches a TAB in
width which could cause visual confusion).  However of course that's up
to you all.


If you wanted to make an even bigger change, which might save some
hair-pulling down the road but is a very serious decision, you could
introduce the use of the .RECIPEPREFIX [1] variable to change the
recipe prefix from TAB to some other character (as it should have been
when make was created back in the 1970's).

.RECIPEPREFIX was introduced in GNU Make 3.82, which was released in
2010 FYI.


Again, apologies for the churn... :(


[1] https://www.gnu.org/software/make/manual/html_node/Special-Variables.ht=
ml#index-_002eRECIPEPREFIX-_0028change-the-recipe-prefix-character_0029
