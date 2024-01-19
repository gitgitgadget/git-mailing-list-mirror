Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C6DF1D53A
	for <git@vger.kernel.org>; Fri, 19 Jan 2024 18:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705689371; cv=none; b=CSWqL2ohhUx7CvFYktMSmIQk9ne/3SzvvBlRjXi0vPWBjJkxdZ4gIu0DZ0BwMCkR5HDNE2bVZBrzCbfXGclqLkBfTKyqDentXlqyOSRIBQuXSJlTDRopDD4hGm+djS5vc87oITHgORW6rk9OWHBX9liyi/kgKdCiTlQNyuAGqjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705689371; c=relaxed/simple;
	bh=JOENo4AEdTSUidSpSMHMfVjxCgjKjO9G4DR0BZtG3xA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kfeYoaP4J4KbTklRxFwChFMfHAUOemqbnkOWKWPdgoJ6IL3SABLw7px2xSYAuD3gyMsyiUANHDNxydgFGA1AEPpz4nDfRLMX+9uVwQnMk78YeCOaygcSOxgI1+7b4xw7bW8+8LmIvtHL5Ufxgj0IEoAVrgE26vUoCrABybCnbUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=m95hhfO0; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="m95hhfO0"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5C81B1D5519;
	Fri, 19 Jan 2024 13:36:07 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=JOENo4AEdTSU
	idSpSMHMfVjxCgjKjO9G4DR0BZtG3xA=; b=m95hhfO0tRMjbzajU+A3QSy6mAjo
	Z39Mu8I06lUJ46DAWl3cHrjQw01PYmj5Gbn2SMGFHq8xqPyvmG308nkWtPV03e3W
	U97KhHrL6rpagr3/gOu6MLK7t8t1Z7b+PKnyizRZ3MVeN1Ef6l27/pEGI3anYB+1
	cYV/4EKaT62y7YA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 502311D5517;
	Fri, 19 Jan 2024 13:36:07 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9C0121D5516;
	Fri, 19 Jan 2024 13:36:06 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
Cc: "Patrick Steinhardt" <ps@pks.im>,  git@vger.kernel.org,
  stolee@gmail.com,  "Eric Sunshine" <sunshine@sunshineco.com>,  "Taylor
 Blau" <me@ttaylorr.com>
Subject: Re: [PATCH v2 3/4] config: factor out global config file retrieval
In-Reply-To: <7f0864ad-c846-42a6-8ddc-85d6be58a4ee@app.fastmail.com>
	(Kristoffer Haugsbakk's message of "Fri, 19 Jan 2024 08:40:51 +0100")
References: <cover.1697660181.git.code@khaugsbakk.name>
	<cover.1705267839.git.code@khaugsbakk.name>
	<32e5ec7d866ff8fd26554b325812c6e19cb65126.1705267839.git.code@khaugsbakk.name>
	<ZaoUOPsze7rhtT2M@tanuki>
	<7f0864ad-c846-42a6-8ddc-85d6be58a4ee@app.fastmail.com>
Date: Fri, 19 Jan 2024 10:36:05 -0800
Message-ID: <xmqq34utkw6i.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 9B78F28A-B6F9-11EE-B74C-78DCEB2EC81B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable

"Kristoffer Haugsbakk" <code@khaugsbakk.name> writes:

> On Fri, Jan 19, 2024, at 07:18, Patrick Steinhardt wrote:
>> But second, I think that the new function you introduce here has the
>> same issue as the old function that you refactored in the preceding
>> patch: `git_config_global()` isn't very descriptive, and it is also
>> inconsistent the new `git_config_global_paths()`. I'd propose to name
>> the new function something like `git_config_global_preferred_path()` o=
r
>> `git_config_global_path()`.
>
> The choice of `git_config_global` is mostly motivated by it working the
> same way as `git_config_system`:
>
> ```
> given_config_source.file =3D git_system_config();
> [=E2=80=A6]
> given_config_source.file =3D git_global_config();
> ```

I shared the above understanding with you, so I didn't find the name
"not very descriptive" during my review.  If only we had two more
functions that can replace our uses of repo_git_path(r, "config")
and repo_git_path(r, "config.worktree") [*] in the code, to obtain
the path to the repository local and worktree local configuration
files, the convention may have been more obvious.

    Side note: the worktree specific one is messier; there are code
    paths that use "%s/config.worktree" on gitdir as well---if we
    were to introduce helpers, we should catch and convert them, too.

> Your suggestion makes sense. But should `git_system_config` be renamed =
as
> well?

I do not mind including "path" in the names of these functions, but
I do agree that such renaming should be done consistently across the
family of functions (which we currently have only two members, but
still).

Thanks.
