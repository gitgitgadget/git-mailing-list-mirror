Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED0333CF5E
	for <git@vger.kernel.org>; Mon,  5 Aug 2024 15:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722873115; cv=none; b=mucP4lo7s32uHjCyzgiGIU9mPjZda61gGGgwteRi7l2NwD/rF3NVtQtiLGcsg5vQeWN4r+KsIseqJf/OvpMs1Ysf95MoOkzzaYdwtSWK7go6hN5sGQsa8FBgvizt+FHZ6Tj1rGbBs1omsXV8KAqfkXsW078UyhYqAJm8QJCVXyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722873115; c=relaxed/simple;
	bh=r8sP14bGIK8thlRTjKWN/qarUeiz0ZXHsk4DA0mc3Xc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nCFKNzRqXr2rJJ5qJumiaqi0jljf+fffpkulKVXPErexVSYPIGNiyW3ne+sCt2hUZPoEitlBGyts9dagN1NhRGbhgl5Et3t7UEaA4KEo8cJkejR/RXC3s6zPZhjjz2xeWL01FOht5uGuYhgnTXvipt553m9qQvISi6uovHuKX/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=TAsc8p+R; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="TAsc8p+R"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id DB2EA35A86;
	Mon,  5 Aug 2024 11:51:52 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=r8sP14bGIK8t
	hlRTjKWN/qarUeiz0ZXHsk4DA0mc3Xc=; b=TAsc8p+RJmfIrbMFTRD1WfN6Q/cI
	aG2Ki3rnlGEmF3rCu54jClkRoBpZvqhtl6Xzb+Y3yCEuRvGX8OS3eg/o7rjYDZHq
	pPyR9122bvDXD7oAzVuB3D/TSvTjbW0ba5nzAkFQ5xqFPRDT18mpJ+boiAHV6KO+
	Yu9c9RacQ2AJ6XE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D164635A85;
	Mon,  5 Aug 2024 11:51:52 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 42A5835A84;
	Mon,  5 Aug 2024 11:51:52 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: Kyle Lippincott via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Kyle Lippincott
 <spectral@google.com>
Subject: Re: [PATCH v2 2/3] strbuf: set errno to 0 after strbuf_getcwd
In-Reply-To: <CAPig+cTmzk7AN2x8-WCK_T5-_G7Wd-akB2++_4HFEbT67Rnc8A@mail.gmail.com>
	(Eric Sunshine's message of "Fri, 2 Aug 2024 17:54:08 -0400")
References: <pull.1756.git.git.1722571853.gitgitgadget@gmail.com>
	<pull.1756.v2.git.git.1722632287.gitgitgadget@gmail.com>
	<0ed09e9abb85e73a80d044c1ddaed303517752ac.1722632287.git.gitgitgadget@gmail.com>
	<xmqqv80ia9wf.fsf@gitster.g>
	<CAPig+cTmzk7AN2x8-WCK_T5-_G7Wd-akB2++_4HFEbT67Rnc8A@mail.gmail.com>
Date: Mon, 05 Aug 2024 08:51:50 -0700
Message-ID: <xmqqv80f3r3d.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 A203CE50-5342-11EF-BBA3-2BAEEB2EC81B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Fri, Aug 2, 2024 at 5:32=E2=80=AFPM Junio C Hamano <gitster@pobox.co=
m> wrote:
>> > [...]
>> > Set `errno =3D 0;` prior to exiting from `strbuf_getcwd` successfull=
y.
>> > This matches the behavior in functions like `run_transaction_hook`
>> > (refs.c:2176) and `read_ref_internal` (refs/files-backend.c:564).
>>
>> I am still uneasy to see this unconditional clearing, which looks
>> more like spreading the bad practice from two places you identified
>> than following good behaviour modelled after these two places.
>>
>> But I'll let it pass.
>>
>> As long as our programmers understand that across strbuf_getcwd(),
>> errno will *not* be preserved, even if the function returns success,
>> it would be OK.  As the usual convention around errno is that a
>> successful call would leave errno intact, not clear it to 0, it
>> would make it a bit harder to learn our API for newcomers, though.
>
> For what it's worth, I share your misgivings about this change and
> consider the suggestion[*] to make it save/restore `errno` upon
> success more sensible. It would also be a welcome change to see the
> function documentation in strbuf.h updated to mention that it follows
> the usual convention of leaving `errno` untouched upon success and
> clobbered upon error.
>
> [*]: https://lore.kernel.org/git/xmqqv80jeza5.fsf@gitster.g/

Yup, of course save/restore would be safer, and probably easier to
reason about for many people.

Thanks.
