Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18352E574
	for <git@vger.kernel.org>; Thu, 23 May 2024 15:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716479131; cv=none; b=RQsUBInmXHr38wK0s3TAU4cyfPCPd7DW449vow2mK+Vyqr51OeqD+2qcHYgNqBlrSqtyt6NpkcIpmN5TjzyUfyqdoGAa6Zi8fFBZCV/+zzPifI77HCp7SJHllikAuiGgzgR1fI10b4K/d6Hq5Hs4sGQfExNgo7iIiKnXTsPeAYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716479131; c=relaxed/simple;
	bh=gPzKYKqQMdZ033Q3z5jEKd3ybsw/AU36VbL+mSgDWAk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=b3zhObMwVJSTdMfuxjezy2Jq23xxiE/0kV95rjkTlUhkZm7O9SbjZ6h48ZtL/ZfCT6kC4c+hTA61cozvmjV2zmRZzITo767JRUC/0eIMQWN6pcTEYZNjrOdmYjG8XOLwqn+HPI60WrNcq2IaWod5dtcFn05wgbLynvIHyv9dSs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=RoxivxRZ; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="RoxivxRZ"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 549B620B9D;
	Thu, 23 May 2024 11:45:29 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=gPzKYKqQMdZ033Q3z5jEKd3ybsw/AU36VbL+mS
	gDWAk=; b=RoxivxRZ36mhOQm8ButiUjl6MgTBuYRok35PZEKEPm1wRqlSPVMYtZ
	ib/h+IXfDh3nL+vbGBjdaDnLQrY32kodFdUsr3SObNvGg4MtY1N7xbr/ANnRYoLl
	x+Glp++rV1WqgiooBVIkftSEZZD4fDXadrbqoTSD38tjXjW4Jc3fU=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 4C8A920B9B;
	Thu, 23 May 2024 11:45:29 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id E619120B96;
	Thu, 23 May 2024 11:45:25 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Taylor Blau <me@ttaylorr.com>,  git@vger.kernel.org,  Elijah Newren
 <newren@gmail.com>,  Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v3 25/30] t/test-lib-functions.sh: support `--date` in
 `test_commit_bulk()`
In-Reply-To: <20240523104224.GD1308330@coredump.intra.peff.net> (Jeff King's
	message of "Thu, 23 May 2024 06:42:24 -0400")
References: <cover.1710972293.git.me@ttaylorr.com>
	<cover.1716318088.git.me@ttaylorr.com>
	<890f6c4b9deb9e3bf02aa180c7ad4ced7f7b6a80.1716318089.git.me@ttaylorr.com>
	<20240523104224.GD1308330@coredump.intra.peff.net>
Date: Thu, 23 May 2024 08:45:24 -0700
Message-ID: <xmqqfru8wmzv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 792CF3A0-191B-11EF-BAE3-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Jeff King <peff@peff.net> writes:

> On Tue, May 21, 2024 at 03:02:59PM -0400, Taylor Blau wrote:
>
>> diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
>> index 862d80c9748..16fd585e34b 100644
>> --- a/t/test-lib-functions.sh
>> +++ b/t/test-lib-functions.sh
>> @@ -458,6 +458,7 @@ test_commit_bulk () {
>>  	indir=.
>>  	ref=HEAD
>>  	n=1
>> +	notick=
>>  	message='commit %s'
>>  	filename='%s.t'
>>  	contents='content %s'
>> @@ -488,6 +489,12 @@ test_commit_bulk () {
>>  			filename="${1#--*=}-%s.t"
>>  			contents="${1#--*=} %s"
>>  			;;
>> +		--date)
>> +			notick=yes
>> +			GIT_COMMITTER_DATE="$2"
>> +			GIT_AUTHOR_DATE="$2"
>> +			shift
>> +			;;
>
> This gives all of the bulk commits the same date. Which is kind of
> unrealistic.

Yeah, giving this helper function a "--notick" option, without
adding this "--date" option, is a better design, I suspect.

The callers Taylor expected to use --date can set the _DATE
variables and pass "--notick", and callers that want the same
timestamp without caring which exact timestamp can just pass
"--notick" without futzing with _DATE variables.

Thanks.
