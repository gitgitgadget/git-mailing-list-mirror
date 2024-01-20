Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0C6510798
	for <git@vger.kernel.org>; Sat, 20 Jan 2024 17:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705771538; cv=none; b=rcgB8OTvJJYff8scQdFFTKCMTOn/r2emqC4WO0pCnTckWdT653o8fm6iPIna7B6/Y6cxifaddcSmggeHbQQfKD0jDssi1cZo8yJNyqbzqwnV3WrplKQnxSkBwwT6IZrSOFlrmlk223mAXB+Yy9uRsEWIRVmYRhQ1tOeaEeSwXbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705771538; c=relaxed/simple;
	bh=NKTd36ejnvajIma7+AofgRIadTryx6Ow4OHFnQSRc8A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CA3JTARmPd8DGx0+ixuwvgVlT0Xrd9XHzw/xUsYT++87PRoKUO0ipgdReMGezzyqq9I9teifal/HokSnr2rRol6/iVQRQeIQdKWC2Ru1TH5QOOVj04zhu4f+B1NDP5Tk8+n0DmfVJJCHVLSL0NKw2rlB/yBmFlxtzp7xtLRPJRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=NqP+JMg1; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="NqP+JMg1"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 360412573C;
	Sat, 20 Jan 2024 12:25:36 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=NKTd36ejnvajIma7+AofgRIadTryx6Ow4OHFnQ
	SRc8A=; b=NqP+JMg1fs2Mq+M0LompU1S5e+pOAOselZyUCOusjObsMmsBhUO8SK
	/jz0ZM6OHnz3FO08/GpanPqs2W1xMDKPVkefeSEYgQPiWZa8nz5rMhpq6MEKiESL
	mO5Q5TS+J11u5YnMAy20cARh96+FMcngcYnMMyS3UFUmX51s8L59M=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 2F7DD2573B;
	Sat, 20 Jan 2024 12:25:36 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 8259525739;
	Sat, 20 Jan 2024 12:25:30 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Antonin Delpeuch <antonin@delpeuch.eu>
Cc: Antonin Delpeuch via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org
Subject: Re: [PATCH v3] merge-ll: expose revision names to custom drivers
In-Reply-To: <386c0318-0138-47c9-9e7f-d1004277226c@delpeuch.eu> (Antonin
	Delpeuch's message of "Fri, 19 Jan 2024 21:02:35 +0100")
References: <pull.1648.v2.git.git.1705592581272.gitgitgadget@gmail.com>
	<pull.1648.v3.git.git.1705615794307.gitgitgadget@gmail.com>
	<386c0318-0138-47c9-9e7f-d1004277226c@delpeuch.eu>
Date: Sat, 20 Jan 2024 09:25:29 -0800
Message-ID: <xmqqy1cjgbna.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 E8F7F69A-B7B8-11EE-A21C-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Antonin Delpeuch <antonin@delpeuch.eu> writes:

> After more testing (combining custom merge drivers with rerere) I
> realized that my patch can lead to a segmentation error. Many
> apologies for not having caught that earlier!

Ah, understandable.  The 3-way merge machinery may not even have to
work on commit objects (it can merge two trees, using another tree
as the "common ancestor" tree, just fine).

And in such a case, it is perfectly possible there is no "human
readable name"; all there is may be a tree object name.

> On 18/01/2024 23:09, Antonin Delpeuch via GitGitGadget wrote:
>> @@ -222,6 +222,12 @@ static enum ll_merge_result ll_ext_merge(const struct ll_merge_driver *fn,
>>   			strbuf_addf(&cmd, "%d", marker_size);
>>   		else if (skip_prefix(format, "P", &format))
>>   			sq_quote_buf(&cmd, path);
>> +		else if (skip_prefix(format, "S", &format))
>> +			sq_quote_buf(&cmd, orig_name);
>> +		else if (skip_prefix(format, "X", &format))
>> +			sq_quote_buf(&cmd, name1);
>> +		else if (skip_prefix(format, "Y", &format))
>> +			sq_quote_buf(&cmd, name2);
>
> The "orig_name", "name1" and "name2" pointers can be NULL at this
> stage. This can happen when the merge is invoked from rerere, to
> resolve a conflict using a previous resolution.

	sq_quote_buf(&cmd, name1 ? name1 : "(ours)");

or something like that, perhaps.

