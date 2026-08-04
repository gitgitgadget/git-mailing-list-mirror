Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEA0443BDDC
	for <git@vger.kernel.org>; Tue,  4 Aug 2026 21:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785879924; cv=none; b=ry0HsgxHt99o/4VkoX1zlVCLNC1QYJBO+RNtYf53J8x11FMVi4VgZgi8Bmhe8oJmS5+9jERsOtB96vvmWj45RQur/qQok9I7MKuc+FXLqXmjPl2mmD529w9hfITv45apF7j03kJ+76smm4jx1BTPUeaGinTdIbEioHsj9BCayAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785879924; c=relaxed/simple;
	bh=VyGDqQQCApgsFo8Y50s2It15Bizlon2V8F6JOuawzIY=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=GXmH0IATcAuV1ZEOKqNwxCIyy+uuI0PA0bbvLQuSjOBwdxt8BNDWJOjk/uXBBvxfqDPxwxEqzzkV39YmescJnwIAT675GDzX1B7Sgn4ZkFYzhrG9c5LOv/mtoaaUNfJ8+wDw8Ekm9xIJQOmQAz6DyiR/dFUwPhEtxT84CYnDQjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-67-183.cpe.net.cable.rogers.com [99.228.67.183])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 674LjJZv2046582
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 4 Aug 2026 21:45:20 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'D. Ben Knoble'" <ben.knoble@gmail.com>
Cc: <git@vger.kernel.org>
References: <017e01dd2441$476839f0$d638add0$@nexbridge.com> <CALnO6CD+LmWNffptqp4bsoJQaq7Ah8VaKHjTTu6m-Zfm2uN+9w@mail.gmail.com>
In-Reply-To: <CALnO6CD+LmWNffptqp4bsoJQaq7Ah8VaKHjTTu6m-Zfm2uN+9w@mail.gmail.com>
Subject: RE: Question on textconv
Date: Tue, 4 Aug 2026 17:45:13 -0400
Organization: Nexbridge Inc.
Message-ID: <01ac01dd245a$8b64f990$a22eecb0$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQEL8od3IO0EK4noYmQoL95xPMrCFgIrJzLhuB90UlA=
X-Antivirus: Norton (VPS 260804-10, 8/4/2026), Outbound message
X-Antivirus-Status: Clean

On August 4, 2026 4:53 PM, D. Ben Knoble wrote:
> On Tue, Aug 4, 2026 at 2:52=E2=80=AFPM <rsbecker@nexbridge.com> wrote:
> >
> > I experienced a change in how textconv works since about 2.50 and it
> > is hard to get past. I would appreciate advice:
> >
> > When I define an external binary textconv, roughly like:
> >
> > .gitattributes:
> > simple binary diff=3Denscr
> >
> > .gitconfig
> > [diff "enscr"]
> >         textconv =3D run -debug ../../enscribe-conv --verbose
> >         binary =3D true
> >
> > The supplied file going to the textconv program looks like
> > /tmp/git-blob-GFtIhK/simple and is always empty regardless of the =
file
> > contents.
>=20
> That's strange. Over here (2.53.0), I get the temp file, but it has =
the expected
> contents.
>=20
> (For example, I can debug a bit by using the shell form 'textconv =3D
> "f() { echo $@; cat $@; <stuff>; }; f"'. NB those $@ need quoted in =
production, but
> for my little test case that was more hassle than it was worth. We can =
also see the
> invocation using GIT_TRACE2=3D1.)
>=20
> This was true for me even after setting "binary =3D true" in the diff =
driver block, which
> I thought was a bit unusual.
>=20
> > When there is only one file named simple in the repository I can =
find
> > it, but otherwise any ambiguity in the name makes textconv =
processing
> > impractical. Somewhere prior to this I was supplied with the actual
> > file in the working index instead of a temp file.
> >
> > Am I missing something?
> >
> > Thanks,
> > Randall
>=20
> I'm not sure :/

Curiously, I get this only on binary files. It is almost as if leading =
nulls is causing an issue.
If I try on a text file or an ELF format file, the above works - ELF =
does not begin with a NULL.

