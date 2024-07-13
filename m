Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C47BC1BC40
	for <git@vger.kernel.org>; Sat, 13 Jul 2024 15:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720885681; cv=none; b=tSiG08bRpGTwCiyF4Zp6XqxBmoXKa0i2nUAVK/JXFlhGEQbWF7kO+NZODEenIBZxMKcPIm0zJEuM0UFDXYBy1QayGeZGx2YtRlqia42Ugxw9f9RtxvmdhwCC9I6WqBOD5hh1HFTWmL8VwvWGNhviUKpgoZHLHVwsy3JxxgQfsN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720885681; c=relaxed/simple;
	bh=KtGBpfcSrxYIMGJAs4JOpgpyB+6ZdINvyxEfPb1vYsI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=D1vrFb3uFXMviDpzjNQTw78aIBEpt6432xejrFv7urCYFTC1reCcRL2+aPHOJ8vA18CrOCWXPbo7imEDH9mE4ZmLOqzXYd9kP+F9sZgB4GCFSEmR9IUUu2tIhw7em2SqudXtMpPm6KWE21T6xWjiMDSe+dJw2CEiwajbbyjxV5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=q8mzYdbN; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="q8mzYdbN"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7D1191CBDC;
	Sat, 13 Jul 2024 11:47:58 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=KtGBpfcSrxYIMGJAs4JOpgpyB+6ZdINvyxEfPb
	1vYsI=; b=q8mzYdbNeFnrzMPj+nghymjuMckL55X1FCUC0VC3nPOe2FLYFkQFI9
	eyJ+g6v29S9zKiLoZBQJnjsELnI2esCvn/arOgMZxk8mgesfYjI75FodSE+lFWwU
	UydQG4el97g4fhYVcWkPAyL2M6egN5U3EX7EotFP2Tv294WPeaf7Q=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 73D871CBDB;
	Sat, 13 Jul 2024 11:47:58 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D354B1CBDA;
	Sat, 13 Jul 2024 11:47:57 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: chriscool@tuxfamily.org,  git@vger.kernel.org,  jltobler@gmail.com,
  phillip.wood123@gmail.com
Subject: Re: [PATCH v3 6/8] ci: run style check on GitHub and GitLab
In-Reply-To: <20240713134518.773053-7-karthik.188@gmail.com> (Karthik Nayak's
	message of "Sat, 13 Jul 2024 15:45:16 +0200")
References: <20240711083043.1732288-1-karthik.188@gmail.com>
	<20240713134518.773053-1-karthik.188@gmail.com>
	<20240713134518.773053-7-karthik.188@gmail.com>
Date: Sat, 13 Jul 2024 08:47:56 -0700
Message-ID: <xmqqwmlpb8er.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 46CC3556-412F-11EF-AB74-5B6DE52EC81B-77302942!pb-smtp1.pobox.com

Karthik Nayak <karthik.188@gmail.com> writes:

> +  # Since $CI_MERGE_REQUEST_TARGET_BRANCH_SHA is only defined for merged
> +  # pipelines, we fallback to $CI_MERGE_REQUEST_DIFF_BASE_SHA, which should
> +  # be defined in all pipelines.
> +  script:
> +    - |
> +      if test -n "$CI_MERGE_REQUEST_TARGET_BRANCH_SHA"
> +      then
> +        ./ci/run-style-check.sh "$CI_MERGE_REQUEST_TARGET_BRANCH_SHA"
> +      elif test -n "$CI_MERGE_REQUEST_DIFF_BASE_SHA"
> +      then
> +        ./ci/run-style-check.sh "$CI_MERGE_REQUEST_DIFF_BASE_SHA"
> +      else
> +        echo "CI_MERGE_REQUEST_DIFF_BASE_SHA should always exist!"; exit 1
> +      fi

This is fine but we may want to reduce the repetition of the long path
to the script, e.g., by doing something like

	if test -n "$CI_MERGE_REQUEST_TARGET_BRANCH_SHA"
	then
		R=$CI_MERGE_REQUEST_TARGET_BRANCH_SHA
	elif test -n "$CI_MERGE_REQUEST_DIFF_BASE_SHA"
	then
		R="$CI_MERGE_REQUEST_DIFF_BASE_SHA"
	fi

	if test -z "$R"
	then
		echo "CI_MERGE_REQUEST_DIFF_BASE_SHA should always exist!"
		exit 1
	fi
	./ci/run-style-check.sh "$R"

in a separate "after the dust settles" clean-up #leftoverbits topic.
We could replace the first 7 lines with a single-liner

	R=${CI_MERGE_REQUEST_TARGET_BRANCH_SHA-${CI_MERGE_REQUEST_DIFF_BASE_SHA?}}

if we wanted to, but all of that will be mere clean-up changes.
