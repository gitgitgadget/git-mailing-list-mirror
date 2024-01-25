Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 050F113399E
	for <git@vger.kernel.org>; Thu, 25 Jan 2024 18:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706208907; cv=none; b=b5K7yMJGfP9Tdlm4tAQNU5R6cVlSRqmw1vy5OfFsZyQ20yQTpKqgJNBbRB4GnNz7h/pbO0Y5qY43pHUBwHjnja/WJRr+YADp/b+MIeykH1nKoIxTvnTqMMhS5i+czLUfXljLIMM2YYmNCjLE2M8tZJa9eB8k+eW+BXHlZFIBRS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706208907; c=relaxed/simple;
	bh=/HF7BQIqpombvRQUGzcm93JPo7U1OJ6xYF8bZIYKNiw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Hi1Okzdm/XCMdI8VOwdNq7uYWc72T9fa75X4PnFry8fefrWSJClR8rsCUF7UcP/wyKb6aozuHQ8lVH6YZ/4yEU0uO6UGgwCgzcSGP3kIwRqJAvZsVCGx9GV0K+XYurUG0KtSIQD1i967/AhDaJ5ZeM+4OzC9yhcqdN5MXmcn5Po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=vJl4XSaO; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="vJl4XSaO"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 8D5141C444A;
	Thu, 25 Jan 2024 13:55:04 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=/HF7BQIqpombvRQUGzcm93JPo7U1OJ6xYF8bZI
	YKNiw=; b=vJl4XSaOkQPCgNMvsrUWQFD2pQst3TIt8y8EJsPD44okOvtynsCEXC
	uvnN7GkbsX32Mw2m6CcX0lef18QwOOmvVL70dIgEbqh4v3Wk9to+v+ZQOg3i/rrw
	KjDeM5i7KKMcuSfCTcicronbQQ2HJMISh72T+6eD0b4YelqHCiNk4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 790B71C4449;
	Thu, 25 Jan 2024 13:55:04 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B02321C4446;
	Thu, 25 Jan 2024 13:55:03 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org,  Elijah Newren <newren@gmail.com>,
  =?utf-8?B?UmHDumwgTsO6w7Fleg==?= de
 Arenas Coronado <raulnac@gmail.com>
Subject: Re: [PATCH] ls-files: avoid the verb "deprecate" for individual
 options
In-Reply-To: <20240125180625.GA54488@coredump.intra.peff.net> (Jeff King's
	message of "Thu, 25 Jan 2024 13:06:25 -0500")
References: <xmqqjznybfp4.fsf@gitster.g>
	<20240125180625.GA54488@coredump.intra.peff.net>
Date: Thu, 25 Jan 2024 10:55:02 -0800
Message-ID: <xmqqfrylw8e1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 3FB5BB4A-BBB3-11EE-ACD1-25B3960A682E-77302942!pb-smtp2.pobox.com

Jeff King <peff@peff.net> writes:

> On Wed, Jan 24, 2024 at 01:10:31PM -0800, Junio C Hamano wrote:
>
>>  --exclude-per-directory=<file>::
>>  	Read additional exclude patterns that apply only to the
>> -	directory and its subdirectories in <file>.  Deprecated; use
>> -	--exclude-standard instead.
>> +	directory and its subdirectories in <file>.  If you are
>> +	trying to emulate the way Porcelain commands work, using
>> +	the `--exclude-standard` instead is easier and more
>> +	thorough.
>
> Sorry I missed this gramm-o before, but should be "the --exclude-standard
> option" or just "--exclude-standard".

Oops, certainly.
