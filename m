Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABB6D13C9DE
	for <git@vger.kernel.org>; Wed, 24 Apr 2024 21:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713993952; cv=none; b=Ro6gLSDv8UImme2QoexXCYrdx2vS+y3iZRAPLkv1unSyaqpwQ18IP55WIUSSUUFPZ0Pyaom2WagOFmDk7ymnCERwZN7NJseLooyLz9oxLeKVaqt8kKhAoG2vS5VAhLNHlpOQJaKbbaL8xEVEZarAJFHtRmtN+WSSmVB2uuyqUxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713993952; c=relaxed/simple;
	bh=OnRs2GQaJZ8IX2G1mt/NngqUsNHt+iyW/7cyUMih5IY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iHcsnnelnGB+VqNA/VlrBMkAusMmwNSB6MnwByk3gXp6K5KAaCQAT2xyEiZC8D0mMUW5wSTGCMTa7cn9iypF20M+IExVjSFSFgC66AT9eZu+XHD1z2ouSXe3+Lda5MhAhpEYZMNSHlmXPl1WOippDKvBxCo0BGp+YcORUKjITN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=VBPY4g+P; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="VBPY4g+P"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 1B1F81CA8A;
	Wed, 24 Apr 2024 17:25:50 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=OnRs2GQaJZ8IX2G1mt/NngqUsNHt+iyW/7cyUM
	ih5IY=; b=VBPY4g+Pj3Z7hJCJsCDwqXKHTumWadygpSlSRbBdY7f8kz7vQJeTze
	oou1DENjdPgriTZwGx2kPU7mF+m6SCzroqD2v7DJ/wKvlHuJkm/inbbEJ8KFEiVo
	gYwG5okOMNP251ILB8GgXpva9JMcTliviJgGvbVIBCjOO7CSDf2uY=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 134F61CA89;
	Wed, 24 Apr 2024 17:25:50 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.120.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 611C91CA88;
	Wed, 24 Apr 2024 17:25:46 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Josh Steadmon <steadmon@google.com>
Cc: git@vger.kernel.org,  peff@peff.net
Subject: Re: [PATCH v4 6/7] t/Makefile: run unit tests alongside shell tests
In-Reply-To: <0e32de1afe9cbab02c5d3476a0fc2a1ba0151dcf.1713985716.git.steadmon@google.com>
	(Josh Steadmon's message of "Wed, 24 Apr 2024 12:14:12 -0700")
References: <cover.1705443632.git.steadmon@google.com>
	<cover.1713985716.git.steadmon@google.com>
	<0e32de1afe9cbab02c5d3476a0fc2a1ba0151dcf.1713985716.git.steadmon@google.com>
Date: Wed, 24 Apr 2024 14:25:44 -0700
Message-ID: <xmqqo79yxxk7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 36BC733E-0281-11EF-B626-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Josh Steadmon <steadmon@google.com> writes:

> +case "$1" in
> +*.sh)
> +	if test -z "${TEST_SHELL_PATH+set}" ; then
> +		echo "ERROR: TEST_SHELL_PATH is not set" >&2

Style.

As an empty string is not a reasonable value for this variable (and
you do not quote ${TEST_SHELL_PATH} when you use it in "exec" below),

	if test -z "${TEST_SHELL_PATH:+set}"
	then
		echo >&2 "ERROR: TEST_SHELL_PATH is not set or empty"

may be what we want here.

> +		exit 1
> +	fi
> +	exec ${TEST_SHELL_PATH} "$@"
> +	;;
> +*)
> +	exec "$@"
> +	;;
> +esac

Other than that, the update in this iteration looks reasonable to
me.

Thanks.
