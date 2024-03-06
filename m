Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C179D19E
	for <git@vger.kernel.org>; Wed,  6 Mar 2024 00:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709686183; cv=none; b=RSKSQPxtrZoJ5PfhWBOy15oO9C83SipwQ5yZEx6krtKt/cSpZik0rE3WrJLvZG5+oUOURjM5WsxQPwsFnCNPKIlzIUxudEw5rKbc4XBmOGFjACn7yR7e/WDhGcTgSAxys1CPL9wEiiKHPSVs+gqRfuzOoSSImhtQou93IGnxzQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709686183; c=relaxed/simple;
	bh=4h8ST3tvA1WHT+OU6ibgPUIGJbgEST2fM+I3es3g5+Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=d7kqdxZGrWkjfcynW1qJnYkoit/jYwiTeRpk4Z66V5pQXAqfcK0tI8Jh2w2odNdYJbYRRJflIwqHl4RH8Bckl846HYFQ5t5YBXC0zK4CBPxd8/OvHKgC7WAUQBQZ+DuCJLC3VkUGrXj9Z03EpPSfLzQLWXBqKS6V4mGNhxKefaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=dZX3JjDB; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="dZX3JjDB"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 271BA1D182B;
	Tue,  5 Mar 2024 19:49:40 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=4h8ST3tvA1WHT+OU6ibgPUIGJbgEST2fM+I3es
	3g5+Y=; b=dZX3JjDBhS3V5p81hATk0TMIf/YeoqWecG/7Og8oSqFj1A38+Za7/P
	DWvI/L00kUcr+kSZzX/3kEcjvuVEpw4Ba3SFOqacSy/UncJRRlooE73ebMy+4Tdg
	DZSJranNILvGHLgCV0rUmepaN5z616PV79TTOJ5Rb1WLkI4GP0bJs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 1E46E1D182A;
	Tue,  5 Mar 2024 19:49:40 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.185.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8DD791D1829;
	Tue,  5 Mar 2024 19:49:39 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Beat Bolli" <bb@drbeat.li>
Cc: git@vger.kernel.org,  Beat Bolli <dev+git@drbeat.li>
Subject: Re: [PATCH 09/22] t/t4*: avoid redundant uses of cat
In-Reply-To: <20240305212533.12947-10-dev+git@drbeat.li> (Beat Bolli's message
	of "Tue, 5 Mar 2024 22:25:08 +0100")
References: <20240305212533.12947-1-dev+git@drbeat.li>
	<20240305212533.12947-10-dev+git@drbeat.li>
Date: Tue, 05 Mar 2024 16:49:38 -0800
Message-ID: <xmqqo7bsw5el.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 69A0B1E8-DB53-11EE-95EF-25B3960A682E-77302942!pb-smtp2.pobox.com

"Beat Bolli" <bb@drbeat.li> writes:

> @@ -786,7 +786,7 @@ test_expect_success 'am takes patches from a Pine mailbox' '
>  	rm -fr .git/rebase-apply &&
>  	git reset --hard &&
>  	git checkout first &&
> -	cat pine patch1 | git am &&
> +	git am pine patch1 &&
>  	test_path_is_missing .git/rebase-apply &&
>  	git diff --exit-code main^..HEAD
>  '

I am not so certain about this one.

We can say "sed can read from the file listed on the command line,
or it can read from its standard input, so we can use whichever is
convenient for us", as we are not in the business of testing "sed"
that is supplied by the system.

On the other hand, the ability of "git am" to read either from the
files listed on the command line or from the standard input is not a
given.  It is one of the many aspects of how "git am" behaves that
we are testing.  By changing a test that feeds the contents of the
mailboxes from the standard input to instead have the command read
these mailbox files listed on the command line, this changes what
gets tested.

All other changes in the file look good to me.

Thanks.
