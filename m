Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18C9B19CC20
	for <git@vger.kernel.org>; Mon, 23 Sep 2024 16:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727108078; cv=none; b=NAAAjhTsbTmWgqwGWP7DgN8L0w07LSdZNZkIjJaSCO28Pxt8TgP2f8EJxB3isz0PY7Rg3IkFe+M7OD0BhcDKeFvFYuu/hYEzQ6EX2AulIOCD/Btg6d7yboSpKiY4kDGlid1kWNHKDe3TVK5xDBh0lrEBMg7j/WSuyM2X/VVr1v4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727108078; c=relaxed/simple;
	bh=jhuizopgKmtkOYqee24ZWuyux5n9s21JVMEv/JqiqI0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BawHTAO84LTLJz3NyHjST1+39IwVgOs1ljuZFj28bCNihHTMK7ifAFv0JyNKyAdqgyJTdHcQI63NIsoTPFEoS9S4KWXLs96BHDLitp+UnqFsUy+K0JTZVWjKLU6JM6t9rUpq2QBcmnOjROS2utMMWbTWRQe+piqS20VBkOP1zM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=gcuOcAM1; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="gcuOcAM1"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id DE41E26A46;
	Mon, 23 Sep 2024 12:14:28 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=jhuizopgKmtkOYqee24ZWuyux5n9s21JVMEv/J
	qiqI0=; b=gcuOcAM16llXxt4ScghA2Q6D7ZLP5WSEcj8pke9fakS7pcFvmAwFTc
	VspHp+6hYMUgljwl9/D8eDOkHHOQHc9ueWLxVDiWfBlKr66xDCAtrJlhLt6Ult5E
	emcB3qbS3JEWjxQ5fdWdml0m/eFiH+OwSIwFG7c0gMJN3YbsbtNo0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id D2E7326A44;
	Mon, 23 Sep 2024 12:14:28 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1E96B26A42;
	Mon, 23 Sep 2024 12:14:28 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Derrick Stolee <stolee@gmail.com>
Cc: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  johannes.schindelin@gmx.de,  peff@peff.net,
  ps@pks.im,  me@ttaylorr.com,  johncai86@gmail.com,  newren@gmail.com
Subject: Re: [PATCH v2 5/6] p5313: add size comparison test
In-Reply-To: <24d266e4-4279-42fa-871e-c843ba6d4f5e@gmail.com> (Derrick
	Stolee's message of "Sun, 22 Sep 2024 21:50:07 -0400")
References: <pull.1785.git.1725890210.gitgitgadget@gmail.com>
	<pull.1785.v2.git.1726692381.gitgitgadget@gmail.com>
	<999b1d094241b0ba8d6924ac6976eafc64c7d4a6.1726692382.git.gitgitgadget@gmail.com>
	<xmqqcykz5mrg.fsf@gitster.g>
	<24d266e4-4279-42fa-871e-c843ba6d4f5e@gmail.com>
Date: Mon, 23 Sep 2024 09:14:25 -0700
Message-ID: <xmqq4j665ov2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 E86937AE-79C6-11EF-BB75-9B0F950A682E-77302942!pb-smtp2.pobox.com

Derrick Stolee <stolee@gmail.com> writes:

> On 9/19/24 5:58 PM, Junio C Hamano wrote:
>> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
>>>   t/perf/p5313-pack-objects.sh | 71 ++++++++++++++++++++++++++++++++++++
>>>   1 file changed, 71 insertions(+)
>>>   create mode 100755 t/perf/p5313-pack-objects.sh
>> "wc -c" -> "test_file_size" or "test-tool path-utils file-size"?
>
> Thanks. I was unfamiliar with those options.

I was, too ;-).  There are a few other test pieces that use "wc -c"
to count bytes, but it made me a bit nervous to use it to count
bytes in a binary file.

>  test_size 'repack size' '
> -	wc -c <.git/objects/pack/pack-*.pack
> +	pack=$(ls .git/objects/pack/pack-*.pack) &&
> +	test_file_size "$pack"
>  '

I am perfectly fine (and actually even prefer) to pay the cost to
fork "ls" here, but if you really wanted to avoid it, we could do
something like

	pack=$(
		set x .git/objects/pack/pack-*.pack &&
		test $# = 2 && echo "$2" || exit 1
	) &&
	test_file_size "$pack"

;-)

>  test_perf 'repack with --full-name-hash' '
> @@ -65,7 +66,8 @@ test_perf 'repack with --full-name-hash' '
>  '
>
>  test_size 'repack size with --full-name-hash' '
> -	wc -c <.git/objects/pack/pack-*.pack
> +	pack=$(ls .git/objects/pack/pack-*.pack) &&
> +	test_file_size "$pack"
>  '
>
>  test_done
