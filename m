Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F72620C468
	for <git@vger.kernel.org>; Fri, 10 Jan 2025 09:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736501252; cv=none; b=RJbyqPwiaauOtOFYDgc+3hAmfWmWNFpAixdvjlvyEJD9i7tAHxSDgLCd46KTgOou0iGpiHh5LA6DBueCHqm9yGKtdNuhCcm87P+sm84yRR+GQIIEV5ZKKWKb1WoXMWslkbpQzj9lTHlvAuh3WyaVu5PKCMlthFY+yj5b1rfsysM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736501252; c=relaxed/simple;
	bh=AAj8o6Y2TShUgr8NyTMzT3xR8BLc5OlNjxZcLvCK8WM=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=IoJfhw5MeK17JZdVA7tqbPxwYVI37HUPFVtdtnZvzqaDmCgfkH1/A4vCnzciNxSLNOJZ0GCJEzG72IgKiQM9k2K/uZHDZVSoViU+4V6L63b29kq7GQjXg2OzXyWzQF7Ebj8j8DYrPsoKXca0bgYf7XWm/h9FPpfzKvVRIBpioJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=HzJoRWa+; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="HzJoRWa+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1736501247; x=1737106047;
	i=johannes.schindelin@gmx.de;
	bh=r4SfYAkMaWrhk4mDHs+6DVsymDQYk2Jv6lx8/AYUgX0=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=HzJoRWa++xSThktfFRGgJiLgM9pIFZb3URJS18LUIThraLvTxk2rH7qd1LFs5x+t
	 1yl+CET/1m9dAD0S8GbM+a6HV67mKTnYq0xyEFkJdSeCERzYacs4XhLyqvA6pRPfa
	 zzWfTexOCBvFU0ypsBYTJu9oHxd7mYNsJdYq2JVBdlUOSYodf5+CFoAM/JGv+NRqz
	 ki/qRzUDHsNQR4wMPdpJjZfFJ52i+wo9r6IXhFRZpjvtr9aHAhqWfD29ZD852VRw1
	 uFzCMjwKwfg9Zm430xb7XkOMh5Ji3WSJQkDaiMii3RigwHsZEQbwFUby1NMlrWmoA
	 bulazd+7xpz024EUkA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([89.1.213.189]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MRmjq-1tzESf2A9a-00Uch9; Fri, 10
 Jan 2025 10:27:23 +0100
Date: Fri, 10 Jan 2025 10:27:23 +0100 (CET)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Patrick Steinhardt <ps@pks.im>
cc: git@vger.kernel.org
Subject: Re: [PATCH] builtin/blame: fix out-of-bounds read with excessive
 `--abbrev`
In-Reply-To: <02ab59c0-a495-9f96-6323-af73cb483f38@gmx.de>
Message-ID: <48ca0114-124b-e3f5-af80-1e302bf9ce52@gmx.de>
References: <20250109-b4-pks-blame-truncate-hash-length-v1-1-9ad4bb09e059@pks.im> <c439fcaf-11af-7862-9c3c-18dc0842b57d@gmx.de> <Z3-vpLHvxoQCTjY1@pks.im> <02ab59c0-a495-9f96-6323-af73cb483f38@gmx.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:cZWkQKYRqs7OxlLCYe7SHz6/OTienaGjuk9LS2wj1YkvgliyZm+
 M4nw70DJgkcVWvZqJbY0O6E+lTnaMmSSfOyz/HvC35ocp4FCBV2SkMpMbrhvwQbozZjGeQf
 3zrAAGt3bZtdmj34sbIgA2u7pOGh4q0tBb7hNDcYZMxnUNHAefjXndGYuvnlVlAwsZ0++Im
 MoeLbokPDYf868PjZKStA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Xgw8j6lylrs=;RoLWHMuiNpZvmZ5T0iLu8YThLFk
 uLuPuNCWzWoWWqHDtZZA7pxg2ZNvBDz8YVaHBA7jNokfv4emqCUIF/VYyeXXV16dfbIw5ilZk
 thYUVcUtYqnOsm7jshnaLTJFbLf3VNrNeW+9UZYiblZ2gM05soGQv0Vf1eFluBHE15B0fOF0j
 G8jt/GLQoh9KOyFBS88Z2DilwtXnC98uC6EYJXVXk9li5OCLZFR6LSOrmLBD46KdbApR+sa/+
 S5IN27s4Jzmb1cRH15JL3aCM0i6huTrFsM0ZoQInzUfypi+3J6zxTYfBq13Bu9zu85a30naJh
 80bHTRuwsGMGL5v/KvD0PRy3GWg0pVMRSioYS68u9i3BBLYhyfKMIFiOya5tWNkF/DUEYj2Wb
 Duppo/qnqK3VxRMryTD8LnLIQEke2buKxVDtthLB1KpyBPuBJn17WMcBi2HsmltM7PqeS6LrA
 x3NgCOpN9U850IQXb2kinw5DeqaI/sOripV3DyB3iP9mpzdFQRxuyyxSIsO2lrsH+XoHIgo2Q
 YvXOccIyCq9axFlMC/5f+37GyDp46/3h8f4oMksPNVsYG8FkV1jKqUjiMwfqBGHZVAxLXg+uL
 TxCQJH+DxibLQLrUlkG8NdSo4jEvCGMlQ2KZRptNBhQRnmGGNDgxWoksuwiQbTcRR0FPF/c/w
 4wjeQ5YeHSmphm2Ebvu9zZqmE/ETTdstGEgVbA8MM9bhJ6V7qktVSNlbv0pJQ+7HKyHZqS/mB
 av1UGhw98Hye5uYZEFcvco0s0vI8R+FL6ya2YurtBcGa3AEpa0yI1GxtDk1XEfPKyzZ4Y7cvh
 +lWcJY177f2F7mxxw/So4es8gsOgpr6MPLvgu4DCduphN+5TZgbvXfoknj5FjfDcxWmoNY6CC
 xSrCT604Tkt7gUS1bdB5qcvWcsc3zOED8rRySLOiPETYEQ/b2qIQB+30N
Content-Transfer-Encoding: quoted-printable

Hi Patrick,

On Thu, 9 Jan 2025, Johannes Schindelin wrote:

> On Thu, 9 Jan 2025, Patrick Steinhardt wrote:
>
> > On Thu, Jan 09, 2025 at 11:49:43AM +0100, Johannes Schindelin wrote:
> > > > diff --git a/builtin/blame.c b/builtin/blame.c
> > > > index 867032e4c16878ffd56df8a73162b89ca4bd2694..ad91fe9e97f90625dd=
2708fbd44bf2dd24a337a6 100644
> > > > --- a/builtin/blame.c
> > > > +++ b/builtin/blame.c
> > > > @@ -475,6 +475,8 @@ static void emit_other(struct blame_scoreboard=
 *sb, struct blame_entry *ent, int
> > > >  		char ch;
> > > >  		size_t length =3D (opt & OUTPUT_LONG_OBJECT_NAME) ?
> > > >  			the_hash_algo->hexsz : (size_t) abbrev;
> > > > +		if (length > GIT_MAX_HEXSZ)
> > > > +			length =3D GIT_MAX_HEXSZ;
> > >
> > > This causes a subtle change of behavior because there are a couple o=
f
> > > conditional code blocks between this change and the `printf()` call
> > > decrease `length`, i.e. specifying values larger than the maximal he=
x size
> > > causes potentially-desirable, different behavior (and think about
> > > https://www.hyrumslaw.com/).
> >
> > Alternatively we can move this until after we have done the
> > subtractions. Then we don't have to do weird gymnastics.
>
> Or we can even avoid assiging a maximum altogether:
>
> 		if (length < GIT_MAX_HEXSZ)
> 			printf("%.*s", (int)length, hex);
> 		else
> 			printf("%s", hex);
>
> Or be more consistent with Git's source code style which often prefers
> ternaries, favoring succinctness over readability:
>
> 		printf("%.*s", (int)(length < GIT_MAX_HEXSZ ? length : GIT_MAX_HEXSZ),=
 hex);

Coverity noticed a problem with this approach, looking at
https://github.com/git/git/blob/v2.48.0-rc2/builtin/blame.c#L493:

				memset(hex, ' ', length);

If the `GIT_MAX_HEXSZ` guard is moved after this statement, then we can
easily overrun the `hex` buffer.

Ciao,
Johannes
