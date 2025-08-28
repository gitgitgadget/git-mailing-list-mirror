Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40F752E0910
	for <git@vger.kernel.org>; Thu, 28 Aug 2025 09:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756375129; cv=none; b=ssR/OS2CaMtay4/0Mk27Ytm05N3wf7FmT+gpawXb3I591r/7SDnpl9qzm6+CNbQVu/vDXKwFCNxIJ5ZyOMIRDGcuvwkLU153HV2mUVZnyA5QmXo0yZRbSY8Z9SdbLx4N+tODrX8c61Sf9IHuKTmYuHMmuURM0oXxzMjvQxFGojo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756375129; c=relaxed/simple;
	bh=Ni9VBl4gOYfANj18+GJHOYM2XMLup9JfYZLYixtHEmA=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=lYtmIaGtzKfGzlqnZum/5YwYjrybUamfxHewlyVrgr1gSfgiDCNE6ojmhBb7k6h6KbYYm2233cNbUNWbLfMOrXss0OIhrBWkkRovQJ4ItfeXNa6c4AW7H651cFrJDOqCCKZgWmZBF8LFsDY2yQp6w0YA19Ii14OA85gQa1k9B1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=PGHd3A/i; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="PGHd3A/i"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1756375120; x=1756979920;
	i=johannes.schindelin@gmx.de;
	bh=upa0IK+t/9kV28IAUL8TutCUbTjwChGokfilecLkySM=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=PGHd3A/iKDNI6cvvoYzZ2EvRfKMdXiJZrVwNkoxn+gzzu0ZLs5L0u82qpdwH80pH
	 T2pDA9BOij4C4KW1MZMVYtO4n+Haq3WwS3lY6GYMmtFierutiS69CDEHmCH6W5ZxS
	 TXrT4PBospw9FU55eBtqRHZi5wxfM5QWkwzPlTT5rl4SKvbLf2MFilEaECGUr+/jn
	 al/BV91mwXm8Mif941o0Mo3QyafngWlbc+aVXyAundBh8yeI5OTpfQu8xbhCf3QxD
	 1AZr7Fe5/pTdv7yXY3gKsPPjspHL1+PXOMQPnZ96wnNum8L9IPOw+bcSxElUh4ux5
	 R2qIR2sLXXaSksvHjA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([213.196.213.26]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MlNtP-1uDFS139m1-00ksm3; Thu, 28
 Aug 2025 11:58:40 +0200
Date: Thu, 28 Aug 2025 11:58:38 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Patrick Steinhardt <ps@pks.im>
cc: git@vger.kernel.org, Jeff King <peff@peff.net>, 
    Junio C Hamano <gitster@pobox.com>, 
    Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v4 03/10] github: adapt containerized jobs to be
 rootless
In-Reply-To: <20250110-b4-pks-ci-fixes-v4-3-6e4613446080@pks.im>
Message-ID: <e45b9487-b3ae-ed85-fd07-c92cfbf47cbb@gmx.de>
References: <20250110-b4-pks-ci-fixes-v4-0-6e4613446080@pks.im> <20250110-b4-pks-ci-fixes-v4-3-6e4613446080@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:RagGeVhvHW5M3ipa+8bP8TQxghteUuu9Yo6XgukReP7aXK6+KcG
 j41plyELDwuoj8UfnEadGSc28aTckgnokp5QggKmDxp9qBNVtPh9z7q2hwz7zeEz6WUnq78
 j7aTUO7V2A14uPpil+6TKtUjMG20YHHxOdCEpRtwYI7d0pRCaiCPyn9iVkTX1j5KsPumbb+
 Drv54moIPdTZPnkuwniQg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:TrWOuOnkhbE=;qElrZKtvziq8egZgoaj6gC2lCmf
 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
 8mUS6fKOqfKSBEwG65/i3ubkP5/MIe5Q==
Content-Transfer-Encoding: quoted-printable

Hi Patrick,

On Fri, 10 Jan 2025, Patrick Steinhardt wrote:

> diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
> index 900be9957a23fcaa64e1aefd0c8638c5f84b7997..b02f5873a540b458d38e7951=
b4ee3d5ca598ae23 100644
> --- a/.github/workflows/main.yml
> +++ b/.github/workflows/main.yml
> @@ -371,10 +371,12 @@ jobs:
>        run: apt -q update && apt -q -y install libc6-amd64 lib64stdc++6
>      - uses: actions/checkout@v4
>      - run: ci/install-dependencies.sh
> -    - run: ci/run-build-and-tests.sh
> +    - run: useradd builder --create-home
> +    - run: chown -R builder .
> +    - run: sudo --preserve-env --set-home --user=3Dbuilder ci/run-build=
-and-tests.sh

I am afraid that this is not enough. Sure, it works as long as the tests
are passing, but the entire point of running the tests is to catch _and
debug_ when they are failing. Otherwise a lot of money and effort could be
saved simply by deleting those tests.

When the tests are failing, the detailed test logs are supposed to be
shown, but as I noticed most recently in
https://github.com/microsoft/git/actions/runs/17278881863/job/49042596457?=
pr=3D787#step:9:1933
there is a fatal error that prevents them from being shown let alone
uploaded:

  [...]
  Test Summary Report
  -------------------
  t5799-gvfs-helper.sh                             (Wstat: 256 Tests: 36 F=
ailed: 1)
    Failed test:  25
    Non-zero exit status: 1
  Files=3D1040, Tests=3D31137, 543 wallclock secs ( 8.01 usr  2.16 sys + 6=
11.98 cusr 1100.12 csys =3D 1722.27 CPU)
  Result: FAIL
  make[1]: *** [Makefile:78: prove] Error 1
  ++ cat exit.status
  make[1]: Leaving directory '/__w/git/git/t'
  make: *** [Makefile:3362: test] Error 2
  + res=3D2
  + rm exit.status
  + end_group 'Run tests'
  + test -n t
  + set +x
  ci/lib.sh: line 221: /__w/_temp/_runner_file_commands/set_env_cca39642-c=
c57-484c-b7d4-27bbd4dc8260: Permission denied
  Error: Process completed with exit code 1.

This error causes the next two steps to be skipped, the one that is
supposed to show the detailed test logs, and the one to upload the failed
tests' directories, precluding any further attempt at debugging the test
failures. Even the part of that step that is supposed to show the failed
_test case's_ logs, as a last resort, fails to show anything because it is
skipped because of that error, too.

Due to various reasons, I cannot investigate this any further. At the same
time, I suspect that you need some hack like adding the `builder` user to
some group that has write access to `/__w/_temp/` (which is most likely a
Docker volume that maps to the host's `$RUNNER_TEMP` or some such, and
therefore a `chmod` is unlikely to work, or it might lead to unintended
consequences in later steps of thw workflow) to allow the logic to perform
as desired.

Ciao,
Johannes

>      - name: print test failures
>        if: failure() && env.FAILED_TEST_ARTIFACTS !=3D ''
> -      run: ci/print-test-failures.sh
> +      run: sudo --preserve-env --set-home --user=3Dbuilder ci/print-tes=
t-failures.sh
>      - name: Upload failed tests' directories
>        if: failure() && env.FAILED_TEST_ARTIFACTS !=3D ''
>        uses: actions/upload-artifact@v4
> diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
> index d1cb9fa8785388b3674fcea4dd682abc0725c968..ecb5b9d36c20d3e7e96148ac=
628a96c62642c308 100755
> --- a/ci/install-dependencies.sh
> +++ b/ci/install-dependencies.sh
> @@ -31,7 +31,7 @@ alpine-*)
>  	;;
>  fedora-*|almalinux-*)
>  	dnf -yq update >/dev/null &&
> -	dnf -yq install make gcc findutils diffutils perl python3 gettext zlib=
-devel expat-devel openssl-devel curl-devel pcre2-devel >/dev/null
> +	dnf -yq install shadow-utils sudo make gcc findutils diffutils perl py=
thon3 gettext zlib-devel expat-devel openssl-devel curl-devel pcre2-devel =
>/dev/null
>  	;;
>  ubuntu-*|ubuntu32-*|debian-*)
>  	# Required so that apt doesn't wait for user input on certain packages=
.
>=20
> --=20
> 2.48.0.rc2.279.g1de40edade.dirty
>=20
>=20
>=20
