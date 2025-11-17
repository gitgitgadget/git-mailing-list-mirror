Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A5D9309DAB
	for <git@vger.kernel.org>; Mon, 17 Nov 2025 17:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763400652; cv=none; b=FNscCzcOfT/rw5TBZtJGjP8UxfNSMCQmdA0hZ7RWqymwTufldssoX8Co4TIwIfWy4LoRDWwTdOLRsh3VMDkCr0h92YDvmwZI4S7pTmy1nm3QRYwolp6TIEOvy7PAPz74cHxalobbDQWKaV5gvN6szhD9qWu6fkfWi/19OysVkxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763400652; c=relaxed/simple;
	bh=CDQUFSqBV9FGqjyJn1C1SOR7n0loVQzWm2XV7Hlp0Ok=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=TktfjEUcTmrZtdmLVekr+Ek3hDVfmA+KL9WYOJQgmZcVlon1XLWQXeQODqoSlV3LzxpcNy1GKmN1STSCDRsxg9HnpaGdEQBjdao9uEkbmDsC91+kv7PhrrwVXcq6PrO0rgfY1fcmN92q3twy1Ct7/6CvpPiV1Klo3m7WerEEZNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=oWPPqx3V; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="oWPPqx3V"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1763400635; x=1764005435;
	i=johannes.schindelin@gmx.de;
	bh=r+GrvHNP5hzRWSPh0CXOfdywga/JmLf98+CoD5GOZz8=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=oWPPqx3VRUZwF3NbMV2zhaPD8/N4RK6fnEHx+Z5QOTkrySpU+a0Wvn03C0rEnr7s
	 QEzu1vqZk1G06Sr3r2SZfm59bM1QqwVGSglSJYI+/Za/9IfCPgM4ckzqh6PbDeEqh
	 KF2foxSW41//jCZI9fxTJP1wdpLN1aV4PuPBCc15koTSglfgRAeRNRrtHCVpen2p1
	 VJJADmEDQBaONaxIwrDOt4wOc0iJvWaJESn58qwaW7VebXrvIJ4l/mbQjt5uSO1+G
	 R5xCy4Q905U6h9e4NKyBuL8RMiPScX2awKwdgucb/Oygd9IP1di6O1Y2hiSulj2Ca
	 73g5SoxhJ2YNnysBIA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([89.1.212.224]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N63Vi-1wE7bW3vbs-00w24l; Mon, 17
 Nov 2025 18:30:34 +0100
Date: Mon, 17 Nov 2025 18:30:33 +0100 (CET)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Patrick Steinhardt <ps@pks.im>
cc: git@vger.kernel.org, Jeff King <peff@peff.net>, 
    Junio C Hamano <gitster@pobox.com>, 
    Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v4 03/10] github: adapt containerized jobs to be
 rootless
In-Reply-To: <e45b9487-b3ae-ed85-fd07-c92cfbf47cbb@gmx.de>
Message-ID: <dda1d862-b5e2-9928-111c-fff519f6e00b@gmx.de>
References: <20250110-b4-pks-ci-fixes-v4-0-6e4613446080@pks.im> <20250110-b4-pks-ci-fixes-v4-3-6e4613446080@pks.im> <e45b9487-b3ae-ed85-fd07-c92cfbf47cbb@gmx.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:KOJMdd8V4EXbAmN2u7boLI8yNdyLOX79qrqB7J1K5fjrgmG9w9m
 wYmgOauglfHDlaMJV9dyFbJzq6HzaKBIGFy7HRnpyKjgx7vJTwKztkuqqJJatmA7kDRj5BK
 Geret+JBT6bBImcLXxmAw982PcSKTG/PAnKuxztjrHkR1JkWRpmS8v1E+kNH/IoCxzbmuJR
 LZJq5oVicNKCI+LWeB8xw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:HPiC97WaxAY=;711DOh3Zpr0+aQTY6cjijWkJsFC
 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
 aaAkLGBk=
Content-Transfer-Encoding: quoted-printable

Hi Patrick, me again,

On Thu, 28 Aug 2025, Johannes Schindelin wrote:

> On Fri, 10 Jan 2025, Patrick Steinhardt wrote:
>=20
> > diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
> > index 900be9957a23fcaa64e1aefd0c8638c5f84b7997..b02f5873a540b458d38e79=
51b4ee3d5ca598ae23 100644
> > --- a/.github/workflows/main.yml
> > +++ b/.github/workflows/main.yml
> > @@ -371,10 +371,12 @@ jobs:
> >        run: apt -q update && apt -q -y install libc6-amd64 lib64stdc++=
6
> >      - uses: actions/checkout@v4
> >      - run: ci/install-dependencies.sh
> > -    - run: ci/run-build-and-tests.sh
> > +    - run: useradd builder --create-home
> > +    - run: chown -R builder .
> > +    - run: sudo --preserve-env --set-home --user=3Dbuilder ci/run-bui=
ld-and-tests.sh
>=20
> I am afraid that this is not enough. Sure, it works as long as the tests
> are passing, but the entire point of running the tests is to catch _and
> debug_ when they are failing. Otherwise a lot of money and effort could =
be
> saved simply by deleting those tests.
>=20
> When the tests are failing, the detailed test logs are supposed to be
> shown, but as I noticed most recently in
> https://github.com/microsoft/git/actions/runs/17278881863/job/4904259645=
7?pr=3D787#step:9:1933
> there is a fatal error that prevents them from being shown let alone
> uploaded:
>=20
>   [...]
>   Test Summary Report
>   -------------------
>   t5799-gvfs-helper.sh                             (Wstat: 256 Tests: 36=
 Failed: 1)
>     Failed test:  25
>     Non-zero exit status: 1
>   Files=3D1040, Tests=3D31137, 543 wallclock secs ( 8.01 usr  2.16 sys +=
 611.98 cusr 1100.12 csys =3D 1722.27 CPU)
>   Result: FAIL
>   make[1]: *** [Makefile:78: prove] Error 1
>   ++ cat exit.status
>   make[1]: Leaving directory '/__w/git/git/t'
>   make: *** [Makefile:3362: test] Error 2
>   + res=3D2
>   + rm exit.status
>   + end_group 'Run tests'
>   + test -n t
>   + set +x
>   ci/lib.sh: line 221: /__w/_temp/_runner_file_commands/set_env_cca39642=
-cc57-484c-b7d4-27bbd4dc8260: Permission denied
>   Error: Process completed with exit code 1.
>=20
> This error causes the next two steps to be skipped, the one that is
> supposed to show the detailed test logs, and the one to upload the faile=
d
> tests' directories, precluding any further attempt at debugging the test
> failures. Even the part of that step that is supposed to show the failed
> _test case's_ logs, as a last resort, fails to show anything because it =
is
> skipped because of that error, too.
>=20
> Due to various reasons, I cannot investigate this any further. At the sa=
me
> time, I suspect that you need some hack like adding the `builder` user t=
o
> some group that has write access to `/__w/_temp/` (which is most likely =
a
> Docker volume that maps to the host's `$RUNNER_TEMP` or some such, and
> therefore a `chmod` is unlikely to work, or it might lead to unintended
> consequences in later steps of thw workflow) to allow the logic to perfo=
rm
> as desired.

I have contributed a patch for that via
https://lore.kernel.org/git/pull.2003.git.1763399064983.gitgitgadget@gmail=
.com/.
Unfortunately, I forgot to Cc: you, please accept my apologies for that
oversight.

Ciao,
Johannes
