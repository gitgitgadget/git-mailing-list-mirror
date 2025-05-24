Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41EF3151990
	for <git@vger.kernel.org>; Sat, 24 May 2025 09:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748077729; cv=none; b=QDCjTXbEcECzz81cQ5uV+YopVjYp2o6lsNHDN+h88E6vFFDH95nEWFu8/m/mCaUVUoIAmZWugZLNlLi9WpZ8SCYcUBK7fQkTpZtNiGYLKhCxRDySVkgJYC4438TFhNVtEIrSfMMtvUPTYCF1Ali8/c4Q4Havldy/680R4cmxAOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748077729; c=relaxed/simple;
	bh=lDhXWe+F9GA1e0+mnreUoGhaQyZYIF2+CSs2X74lGcA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=nChSDkyzc9sVmZLgHmcSRk+zHBAnEUwzA8rjDcOOXlgyBpwS3hgPGSHKqYYC6u3+0OtaqS11zX/SQpfT0JfnsnaPTZpH+f5g8RU6BC6O5JTc9rlePYQXFveNmwoVmCo9cDurhCFd/ZU2DELPOS8MZQ9+YCOdymXYwrf1RgB+Pcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=krq6W5cz; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="krq6W5cz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1748077723; x=1748682523; i=l.s.r@web.de;
	bh=vlVk6hpipI9iZMnEtPakIfeMsRPIsqWKampPM1a1nMA=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=krq6W5czaEvAWfRG3LIRxn6NWGmSLXbXukV+cdwRV/RAHiiKZJeODOmEpD507cJ5
	 MBUG88s6HIokNIChQoRcLvTrbatd/U7ewoctFW5p6bhUF1xn0tcUIj8cKSobbAoAz
	 55x6ZLfqPMObkagk3BlAuiAJsg+cvRZyY1/wYVxqRcLNWQv3xtKePSGy+l30Pqrdr
	 YA3y+PbVcHOzV+hVDe1WSB8qC+nog+s4TJeC/qISisoLUBKURICavOfk+QJ6JuQyJ
	 szgTifE8EP8U7OA+q6N8oWwZwxl4gzmgCq6qi3i3Qa9mLelBwEx3JEy3rUtYEkk5e
	 V7OY5/+fNuwrA6Y3+Q==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.2.31] ([79.203.29.133]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MidHP-1uoo1s1LLr-00cPWX; Sat, 24
 May 2025 11:08:43 +0200
Message-ID: <a58bf04a-d9fc-4ecf-96a5-82d31ada510d@web.de>
Date: Sat, 24 May 2025 11:08:42 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Fix buffer underflow in xdl_build_script
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
To: Alex via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc: Alex <alexguo1023@gmail.com>, jinyaoguo <guo846@purdue.edu>
References: <pull.1976.git.git.1748033500935.gitgitgadget@gmail.com>
 <037b4612-ea92-45bf-bacb-ba66204f941e@web.de>
Content-Language: en-US
In-Reply-To: <037b4612-ea92-45bf-bacb-ba66204f941e@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ElETAzY8u4K7tbfH7unrqGStPruvT2oMxvdPhFGVc5UZTQ6vowU
 +AUlPQd98kFdkc52pC5CVGyiR0lNMC05BBSfdAlt2PEr0zDJ2vbqz/y/f9p112MZbGWRUG+
 AEWbd/azX+eMc2l0BBxYMVdElnF/rrdwy+UwP5io2xBs/prUSSlbs6/z3tWdRhimDM34SFr
 OCHR7/xTEEFp559/g/zMA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:/ROf8OUwWIM=;dVprhSusSlw3CPD/Vf1GfAHM3El
 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

Am 24.05.25 um 07:57 schrieb Ren=C3=83=C2=A9 Scharfe:
> Am 23.05.25 um 22:51 schrieb Alex via GitGitGadget:
>> From: jinyaoguo <guo846@purdue.edu>
>>
>> The loop in xdl_build_script used `i1 >=3D 0 || i2 >=3D 0`, causing
>> `i1` (or `i2`) to reach 0 and then access `rchg1[i1-1]` (or
>> `rchg2[i2-1]`), which underflows the buffer.
>> This commit adds explicit `i1 > 0` and `i2 > 0` checks around
>> those array accesses to prevent invalid negative indexing.
>=20
> xdl_prepare_ctx() in xdiff/xprepare.c allocates an extra entry at both
> ends for rchg arrays, so an index of -1 should be within the bounds. =20
>=20
> i1 and i2 are decreased in lockstep, though, so one of them can become
> smaller than -1 if nrec is different between the files.  And that's how
> this code run can indeed run off into the weeds.

Actually no, i1 can't seem to reach 0 without i2 also being 0 and vice
versa.  Or can it?  It makes sense that we reach the start of both
buffers at the same time if we walk backwards from the end, don't
misstep and have consistent rchg array contents, but I'm not sure.

Are you able to demonstrate any out-of-bounds access with e.g.,
Valgrind, AddressSanitizer or an assertion?

> Curiously, AddressSanitizer doesn't report anything, but if I add the
> following line after the outer for, I can trigger it to report a
> heap-buffer-overflow with e.g., git show 8613c2bb6c:
>=20
> 	if (i1 < 0 || i2 < 0) fprintf(stderr, "Oops: %ld %ld\n", i1, i2);

That's because I forgot to add braces.  D'oh!  I can't trigger any
out-of-bounds access or that Oops with them properly in place.  So I
let myself get fooled by a daring coding style. :-|

>=20
>>
>> Signed-off-by: Alex Guo <alexguo1023@gmail.com>
>> ---
>>     Fix buffer underflow in xdl_build_script
>>
>> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1=
976%2Fmugitya03%2Fbuf-1-v1
>> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1976=
/mugitya03/buf-1-v1
>> Pull-Request: https://github.com/git/git/pull/1976
>>
>>  xdiff/xdiffi.c | 7 ++++---
>>  1 file changed, 4 insertions(+), 3 deletions(-)
>>
>> diff --git a/xdiff/xdiffi.c b/xdiff/xdiffi.c
>> index 5a96e36dfbe..2e983965328 100644
>> --- a/xdiff/xdiffi.c
>> +++ b/xdiff/xdiffi.c
>> @@ -951,9 +951,10 @@ int xdl_build_script(xdfenv_t *xe, xdchange_t **xs=
cr) {
>>  	 * Trivial. Collects "groups" of changes and creates an edit script.

Trivial for Davide perhaps (libxdiff author), but not my mushy brain..

>>  	 */
>>  	for (i1 =3D xe->xdf1.nrec, i2 =3D xe->xdf2.nrec; i1 >=3D 0 || i2 >=3D=
 0; i1--, i2--)
>=20
> Should the || be a && instead?  From a birds-eye view I would assume we
> can stop scanning for changes when we exhaust (reach the top) of either
> side.  We just have to make sure everything from the other side is
> accounted for in the last added change.
>=20
>> -		if (rchg1[i1 - 1] || rchg2[i2 - 1]) {
>> -			for (l1 =3D i1; rchg1[i1 - 1]; i1--);
>> -			for (l2 =3D i2; rchg2[i2 - 1]; i2--);
>> +		if ((i1 > 0 && rchg1[i1 - 1]) ||
>> +			(i2 > 0 && rchg2[i2 - 1])) {
>> +			for (l1 =3D i1; i1 > 0 && rchg1[i1 - 1]; i1--);
>> +            for (l2 =3D i2; i2 > 0 && rchg2[i2 - 1]; i2--);
>=20
> Nit: The indentation of that line is off.
>=20
>> =20
>>  			if (!(xch =3D xdl_add_change(cscr, i1, i2, l1 - i1, l2 - i2))) {
>>  				xdl_free_script(cscr);
>>
>> base-commit: 8613c2bb6cd16ef530dc5dd74d3b818a1ccbf1c0
>=20
>=20

