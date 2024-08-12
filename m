Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A96501876
	for <git@vger.kernel.org>; Mon, 12 Aug 2024 08:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723450553; cv=none; b=sULvSys5/X6ZavEQcRgQS9gUZxdTb3ygC1m62glBdWxJmIvlcXTZIVsxPhwIl4HTSDtCr6Wo2nDDbNqucCrfMmKeRYx3Bok1JFpOwOIT4qWChqbxmRiUoWEiEd/RwdYRUPGBpv/Wxe0pkhuhrhWJ4GCuS1dvNh0q9BsbpDX+IFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723450553; c=relaxed/simple;
	bh=b0ljPJuZdVKZaqaMbQS/A0S7ZHXFL11ArvU/7YqV5no=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qm6+l2tHy6J9lxG3yp33EXVdFIjJKN0SyhalKDoKHhMJ4F4RGi3cp+vapuFVB8eJ8x0LJXs3IZvR84bH3eoSwpGyYO48YSXdeqSfXO151HNLrIzogBrNs5lrGq5KJaKToHENSpp/RuucGIIMUQzqeOjIYlplyq1r8+X35ufaBvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=jXICcZbB; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="jXICcZbB"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 68F5B39439;
	Mon, 12 Aug 2024 04:15:45 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=b0ljPJuZdVKZ
	aqaMbQS/A0S7ZHXFL11ArvU/7YqV5no=; b=jXICcZbBShtaC/Cu9nAdsm327Xfj
	lXx3tqssXeZcAoaeOYOD3IDf9Dx7YuiKVveMI6ADzd8n+eTE54B3IadMaqemQn3A
	9UfWK+NjQZmxNmbPZfnttqPGGI1ehB4bT5DLCJPimW3TNcyiE9ty8SuWNgviBqKl
	+J1WYv2/iQbvpAc=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 61ED139438;
	Mon, 12 Aug 2024 04:15:45 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id E46BE39437;
	Mon, 12 Aug 2024 04:15:41 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: Dragan Simic <dsimic@manjaro.org>,  "Jason A. Donenfeld"
 <Jason@zx2c4.com>,  Josh Steadmon <steadmon@google.com>,
  git@vger.kernel.org,  calvinwan@google.com,  spectral@google.com,
  emilyshaffer@google.com,  emrass@google.com,  rsbecker@nexbridge.com,
  mh@glandium.org,  sandals@crustytoothpaste.net
Subject: Re: [PATCH v2 0/5] Introduce cgit-rs, a Rust wrapper around libgit.a
In-Reply-To: <CAPig+cSotr8CNZLy4xnm4qyJsuQsxjzsYMVU5sf3eeoEiE8aXg@mail.gmail.com>
	(Eric Sunshine's message of "Sun, 11 Aug 2024 19:03:08 -0400")
References: <cover.1723054623.git.steadmon@google.com>
	<cover.1723242556.git.steadmon@google.com>
	<Zrdn6QcnfmZhyEqJ@zx2c4.com>
	<6398d60387a6607398e4b8731363572e@manjaro.org>
	<CAPig+cSotr8CNZLy4xnm4qyJsuQsxjzsYMVU5sf3eeoEiE8aXg@mail.gmail.com>
Date: Mon, 12 Aug 2024 01:15:40 -0700
Message-ID: <xmqq5xs688cz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 10EA9304-5883-11EF-8FAC-E92ED1CD468F-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Sun, Aug 11, 2024 at 1:27=E2=80=AFPM Dragan Simic <dsimic@manjaro.or=
g> wrote:
>> On 2024-08-10 15:15, Jason A. Donenfeld wrote:
>> > Still the same name for v2? Cmon.
>>
>> Yeah, I was also surprised to see that.  This _isn't_ cgit.
>
> Josh addressed this point in the v2 cover letter by saying:
>
>     Known NEEDSWORK:
>     ...
>     * Bikeshed on the name

I do not quite consider it as as "addressed this point" to just slap
a NEEDSWORK label and doing nothing else, though.

The original iteration had this:

    * bikeshedding on the name (yes, really). There is an active, unrelat=
ed
      CGit project [4] that we only recently became aware of. We original=
ly
      took the name "cgit" because at $DAYJOB we sometimes refer to git.g=
it
      as "cgit" to distinguish it from jgit [5].

and then now they as well as reviewers all have seen the tentative
cgit name, saw the reaction it caused, and now know that not just
potentially confusing other project _exists_, but it does matter.

Reviewers already have spent some time on suggesting that "git" part
should not be "c"git, as well as "rs" part may better be "sys",
etc.?.  There should be _some_ response, even if it does not yet
propose a new name.

If it acknowledged that the time and knowledge reviewers gave the
topic were appreciated, e.g., "The proposers of this topic saw THIS
point and THAT point as a input that we WILL need to consider when
we decide on the name.  We acknowledge that the name "cgit-rs" is
not ideal and needs to be changed.  But we haven't reached any
concrete alternative name yet, so this round still uses the same
name", I'd call that "addressed this point", though.

But just a dismissing "Bikeshed on the name", as if they do not care
to be mistaken as saying "those who complain about the name are only
bikeshedding and not worth listening to"?

We should do better than that.

