Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 050AB20334
	for <git@vger.kernel.org>; Mon, 18 Mar 2024 04:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710736758; cv=none; b=U8nyoFpqhW8ivPxFHOpVWXb3V6eV3gnhObbW4wGhiBhRrdxB2ZDY057Hh3Rm+vSnwczkj5/15y4fHbqoJwHcDpHvBZJ1DoagVNADnSwz/u4cA/dUB1d8lApsrpm7BkXjlDR1bzjU5d/WCBZtD+uGOj7dsAWHv4itCvNmcBI/zko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710736758; c=relaxed/simple;
	bh=ikZQYAjAV1HB+iuKVh9mj1MEjWBy8CA+ftLfGdrHQJQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MPsY68c5MXEJGF76YgyCfVsDYtRLysqzptSXLPbjxl3zRg8QSgQk2qCBfATGSaoXxo6wchY6k8Ykz8BPgf6jaJbB6fdE1eh70BkHKvJAHXMijzBz9gOIMB9BZIj+XDMbV1SgjHTi2u4RNApLCfE8rypwS8DG2a1lLidNnDE4yyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=V27YBjek; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="V27YBjek"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 7B35C2979E;
	Mon, 18 Mar 2024 00:39:16 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=ikZQYAjAV1HB+iuKVh9mj1MEjWBy8CA+ftLfGd
	rHQJQ=; b=V27YBjekiekvse72o768vcQoq+L3qpqbwLnncocUZ5sMxVQWBVX7LF
	TfoY9AKwbP4pnNZo2ED5gVOpcI/YGP7947SrfTL4sbhwzmjFQh5ZHATyS5OVv+hb
	1a2RI4eU0e/4jmxT/HtMyTOFopAPy52TbxsQ4Bm+nwxS8hg790/tk=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 739662979D;
	Mon, 18 Mar 2024 00:39:16 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.185.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 1A86E2979C;
	Mon, 18 Mar 2024 00:39:13 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Peter Hutterer <peter.hutterer@who-t.net>
Cc: git@vger.kernel.org,  David Heidelberg <david@ixit.cz>,  Phillip Wood
 <phillip.wood123@gmail.com>,  Dragan Simic <dsimic@manjaro.org>
Subject: Re: [PATCH v5] diff: add diff.srcPrefix and diff.dstPrefix
 configuration variables
In-Reply-To: <20240318034957.GA2935525@quokka> (Peter Hutterer's message of
	"Mon, 18 Mar 2024 13:49:57 +1000")
References: <20240315055448.GA2253326@quokka> <xmqqy1ajqvkb.fsf@gitster.g>
	<xmqq8r2ioh19.fsf@gitster.g> <20240318034957.GA2935525@quokka>
Date: Sun, 17 Mar 2024 21:39:11 -0700
Message-ID: <xmqqplvskvbk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 783F3E30-E4E1-11EE-90F7-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Peter Hutterer <peter.hutterer@who-t.net> writes:

> On Fri, Mar 15, 2024 at 10:57:22PM -0700, Junio C Hamano wrote:
>> Junio C Hamano <gitster@pobox.com> writes:
>> 
>> > I am tempted to queue v4 with the z/ -> y/ fix from this round,
>> > without any other changes from v4 to v5.
>> 
>> So, that is what I did before I pushed out today's integration
>> result.  I however have an "after the dust settles" clean-up patch
>> on top (not committed yet), which I am sending out for review.
>> 
>> ------- >8 -------------- >8 -------------- >8 --------
>> Subject: diff.*Prefix: use camelCase in the doc and test titles
>> 
>> We added documentation for diff.srcPrefix and diff.dstPrefix with
>> their names properly camelCased, but the diff.noPrefix is listed
>> there in all lowercase.  Also these configuration variables, both
>> existing ones and the {src,dst}Prefix we recently added, were
>> spelled in all lowercase in the tests in t4013.
>> 
>> Now we are done with the main change, clean these up.
>> 
>> Signed-off-by: Junio C Hamano <gitster@pobox.com>
>
> Reviewed-by: Peter Hutterer <peter.hutterer@who-t.net>
>
> And thanks for merging the patch!
>
> Cheers,
>   Peter

Thanks.
