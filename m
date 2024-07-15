Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 101CF1E890
	for <git@vger.kernel.org>; Mon, 15 Jul 2024 23:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721087694; cv=none; b=iLRTbSk5jQGAcdS6ng6zLWxsOHLUW5uW+6Kw822zfYCKGXrtKNeXs6wh75YrOdkALa0jqDgPxDEOoK45bcNtmA/wESkn4sWgkelBwxkm0WkwvWEuRGdxIrO+iWxLdAfKpXyAV7z+C7wHMqvBnLLWlOxC7EqEGLs/OUwctox/uPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721087694; c=relaxed/simple;
	bh=inemMpZiJasTrfcQsaPOvj7GdMCJKwTOYkZTmKWhf+4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LpHcc8sZWetC04Ou/GhWb58IM48pzgY8TI7VHzivlzzniz5+KoJ+ZX/mhnyS8sXJNeopAJJXQsTP36SFfqzoc8hvwCKLMnk4bnrwweAAs6U2HknCW1kbdg+H/NM6JI2WMag1cgRD9XahteDaWW64cbQhUWdWhXViGqIDCCOWw2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=wotags2E; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="wotags2E"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 6717E25CA9;
	Mon, 15 Jul 2024 19:54:52 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=inemMpZiJasT
	rfcQsaPOvj7GdMCJKwTOYkZTmKWhf+4=; b=wotags2EG7mOs5sgwgHywEA//13V
	YXCWT5KYgrUWom0YMp0onIdSOnNQdvh6xdGz50n/q8RS+0AMaPj6Zy+wEOYW9NuQ
	BlEuLYspaeqEWIr7A8bIMRky0ISKeARmwNcZQYhC7bfjahwoU32h/HX8XL+bG1wZ
	omAs3Upa7xOu+JE=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 5F74725CA8;
	Mon, 15 Jul 2024 19:54:52 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 7987325CA7;
	Mon, 15 Jul 2024 19:54:47 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>
Cc: Git List <git@vger.kernel.org>,  Dragan Simic <dsimic@manjaro.org>,
  Jeff King <peff@peff.net>,  Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v3 4/4] add-patch: render hunks through the pager
In-Reply-To: <1dc9ebad-768b-4c1a-8a58-8a7a5d24d49e@gmail.com>
 (=?utf-8?Q?=22Rub=C3=A9n?= Justo"'s
	message of "Mon, 15 Jul 2024 01:04:18 +0900")
References: <2653fb37-c8a8-49b1-a804-4be6654a2cad@gmail.com>
	<ebcba08f-3fbb-4130-93eb-d0e62bfe0a8a@gmail.com>
	<efa98aec-f117-4cfe-a7c2-e8c0adbdb399@gmail.com>
	<1dc9ebad-768b-4c1a-8a58-8a7a5d24d49e@gmail.com>
Date: Mon, 15 Jul 2024 16:54:45 -0700
Message-ID: <xmqqttgqyzwa.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 9DEBD8A0-4305-11EF-8499-DFF1FEA446E2-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable

Rub=C3=A9n Justo <rjusto@gmail.com> writes:

> +test_expect_success TTY 'P does not break if pager ends unexpectedly' =
'
> +	test_when_finished "rm -f huge_file; git reset" &&
> +	printf "\n%2500000s" Y >huge_file &&
> +	git add -N huge_file &&
> +	test_write_lines P q | GIT_PAGER=3D"head -n 1" test_terminal git add =
-p >actual
> +'

Somehow this is dying with signal 11?

  https://github.com/git/git/actions/runs/9944800531/job/27471636926#step=
:5:1108

I know there is a v4 that has a small update here, but in case that
this still is relevant and the removed rediraction to ">actual" did
not magically fixed it...

Thanks.

