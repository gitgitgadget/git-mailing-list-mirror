Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C6CC4D8A9
	for <git@vger.kernel.org>; Fri, 26 Jul 2024 18:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722019125; cv=none; b=dWk4usSFx95mrH8wtQj4dCnlACXbK0GrrVFlzth0dUY5ow85ECvVUnWtmtRuWs1B1PvewbhYZNEJZXJcBSZ2Vb0qXQVJsMTZybhnkD/ItDGmF/wkPe9QSRvsBxS5n9WbRacBxDLiTIaCA/Z8AsSu4U4+92vkzq3qsvE3HSClZQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722019125; c=relaxed/simple;
	bh=C3yHHinXrDgdFNqJ8HrXPlw4nf+qLfmYQrDR1Cz0zNM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uz6W2z4dpO/uanzrYMjaeLN0KX9zjfNVNsDuNYXsYKDAFkKW+yEjlvH11dLIAtjYyISLvcvLz4Ro/ysy5a+2CCsEMYvIVNvlmV1YBYEAeM9gM8mpssk7r++DA5/FMVYl4PR+fxFKAv8wqYWEfO9nxEbKg5wuTt9hPP+i9Xgp74c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=nFsFh6l1; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="nFsFh6l1"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 0D9C527C9E;
	Fri, 26 Jul 2024 14:38:44 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=C3yHHinXrDgdFNqJ8HrXPlw4nf+qLfmYQrDR1C
	z0zNM=; b=nFsFh6l1lCN/3V+gqwwyZgl6p++kLiLd7OiG3d6yfQLMPunb9JPIQq
	MW2Ds2im49mO46JxN1qbPmuVDs0vC971t1gmkiSTQqFDy64HCv4w4ZuBieHSzNWT
	Veq7lhIHCYPLJeyZQUH5mjwMTNicnogTgKEwN/11mKRPouM8el3vQ=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 0537927C9D;
	Fri, 26 Jul 2024 14:38:44 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 89FDC27C99;
	Fri, 26 Jul 2024 14:38:40 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <ericsunshine@charter.net>
Cc: git@vger.kernel.org,  =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>,
  Phillip Wood
 <phillip.wood123@gmail.com>,  Kyle Lippincott <spectral@google.com>,  Eric
 Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 0/5] improve one-shot variable detection with shell
 function
In-Reply-To: <20240726081522.28015-1-ericsunshine@charter.net> (Eric
	Sunshine's message of "Fri, 26 Jul 2024 04:15:17 -0400")
References: <20240722065915.80760-1-ericsunshine@charter.net>
	<20240726081522.28015-1-ericsunshine@charter.net>
Date: Fri, 26 Jul 2024 11:38:39 -0700
Message-ID: <xmqq34nwuhg0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 474A99EC-4B7E-11EF-965E-92D9AF168FA5-77302942!pb-smtp20.pobox.com

Eric Sunshine <ericsunshine@charter.net> writes:

>     @@ t/t3430-rebase-merges.sh: test_expect_success 'refuse to merge ancestors of HEAD
>       	git checkout --orphan unrelated &&
>      -	(GIT_AUTHOR_NAME="Parsnip" GIT_AUTHOR_EMAIL="root@example.com" \
>      -	 test_commit second-root) &&
>     -+	test_env GIT_AUTHOR_NAME="Parsnip" GIT_AUTHOR_EMAIL="root@example.com" \
>     -+		test_commit second-root &&
>     ++	test_commit --author "Parsnip <root@example.com>" second-root &&

Very pleasing to the eyes.

>     @@ t/check-non-portable-shell.pl: sub err {
>       		err q(quote "$val" in 'local var=$val');
>      -	/^\s*([A-Z0-9_]+=(\w*|(["']).*?\3)\s+)+(\w+)/ and exists($func{$4}) and
>      +	/\b([A-Z0-9_]+=(\w*|(["']).*?\3)\s+)+(\w+)/ and !/test_env.+=/ and exists($func{$4}) and
>     - 		err '"FOO=bar shell_func" assignment extends beyond "shell_func"';
>     + 		err '"FOO=bar shell_func" is not portable (use test_env FOO=bar shell_func)';

OK.

Thanks.  Will queue.
