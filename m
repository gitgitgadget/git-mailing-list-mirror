Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AF8C12C55E
	for <git@vger.kernel.org>; Mon, 26 Feb 2024 16:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708964210; cv=none; b=JTrar1nYT8TqBiO9zj0fWau5Qoh6SJrKYte5RrwZ6NieVA6tpzJEVaP1+5Ft6GK2fuW0asiezLFVXavGyteTaEVc+M0d9MNVlFXkIdyTC4YXoXIcIP0EDVe0iR1emBeafHi25veVvqbmKJBY3d6BTBhGBjXCCJgcNHOi++ua/KA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708964210; c=relaxed/simple;
	bh=PKowNyQYvEJXOhjK0DJOrPJWXVNYddSqz1AGPwxcn60=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PQGWRXiucrsN66ZwAD8bZV4z5cfP8keK1ceUyi9h7udwfGHRBSWQDKpUrKYj2z7vY9ydAaH2Sa1onfHwwFWPRwbys9gukGxKzSzGW74gKkaG1I1lo2u8unIHXHkMow9GVvDpmjfwONIU+yYtrMec8CXFpyR0GTHOF6WooF+TZho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=EfBW8CYG; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="EfBW8CYG"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 687CB1D6C5;
	Mon, 26 Feb 2024 11:16:39 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=PKowNyQYvEJX
	OhjK0DJOrPJWXVNYddSqz1AGPwxcn60=; b=EfBW8CYGGccz1k4giK5Zl68NTcsc
	hWX3ElxTorlf22EFKaXYRZu00Z62SFTtEA73Ltfj9YFt3mVfRYuTSmrTqlALRIK/
	OPvkvnNjkL6TQBXFHDc6b94DGhBCASalHF0PuNlgBQc11yZg8VDNQ9HnHves9NTx
	XNJuwBVTqYw2RTY=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 6139C1D6C4;
	Mon, 26 Feb 2024 11:16:39 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.176.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id EC8261D6C3;
	Mon, 26 Feb 2024 11:16:35 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
Cc: "ZheNing Hu" <adlternative@gmail.com>,  "Christian Couder"
 <christian.couder@gmail.com>,  "Johannes Schindelin"
 <Johannes.Schindelin@gmx.de>,  "Git List" <git@vger.kernel.org>
Subject: Re: [Question] How to parse range-diff output
In-Reply-To: <11783b8e-472d-4b75-bb48-88138daf16ae@app.fastmail.com>
	(Kristoffer Haugsbakk's message of "Mon, 26 Feb 2024 14:16:06 +0100")
References: <CAOLTT8SQyBSWC=aqB2SRYmp3kR6RZ+L_-9yckWQf-X9rbzeNBw@mail.gmail.com>
	<11783b8e-472d-4b75-bb48-88138daf16ae@app.fastmail.com>
Date: Mon, 26 Feb 2024 08:16:34 -0800
Message-ID: <xmqqmsrnfbfh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 69DC2A08-D4C2-11EE-BC33-F515D2CDFF5E-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable

"Kristoffer Haugsbakk" <code@khaugsbakk.name> writes:

> On Mon, Feb 26, 2024, at 08:25, ZheNing Hu wrote:
>> Hi,
>>
>> I am currently looking to implement a service that provides a version
>> range comparison based on git range-diff. I can easily parse out
>> commit pair headers like "3: 0bf6289 ! 3: a076e88 dev5," but I am
>> unsure how to parse the details in the subsequent diff patch body.
>>
>> It is not a standard diff output where one can parse out the filename
>> from the diff header, It should be called a diff of diffs. We can see
>> various headers with file names such as "@@ File1 (new)", "## File2
>> (new) ##", or "@@ File3: function3" in different formats. This is
>> confusing. How should we correctly parse a range-diff patch, and do
>> you have any good suggestions?
>>
>> Thanks for any help.
>> --
>> ZheNing Hu
>
> Hi
>
> Note that =E2=80=9COutput Stability=E2=80=9D says that this output is n=
ot meant to be
> machine-readable. It=E2=80=99s for human consumption. It=E2=80=99s not =
textually stable.
>
> So a new version of Git might break your implementation without warning=
.

Good point.

In fact, those "##" things came long after the command was
introduced for exactly the purpose of helping human users to locate
which part of a "diff" the "diff of diff" is talking about, and the
output from the command has been unstable for the exact reason.

