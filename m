Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2FF515D0
	for <git@vger.kernel.org>; Sat, 20 Jan 2024 22:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705790962; cv=none; b=EfYpUsUEVuS7yIYEKyH500cXNeaXfv6aoW0gym9PBhCV5QOmc3Zo/VXry1nPGkH9Wz75nBjbOPEM3nOIFrTQxOD6TXxXaz1iw/WK80UR/5k25ut/TIkoJOn0l5JZMLYjrALLLrT2w3QuuDhfQjqxEAbcXhDpLPl/KICro8hpONU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705790962; c=relaxed/simple;
	bh=+EKolObrAtl+VOZr9YIwGgBCsMtWyj/BVhyo5wAmIA4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PakkyY+vhaCszKDbcTmrjkD8myVukphOkER/e9jBaAOzYMSzXMOqUQe78dvfCFQ8D3vYz/A5B9ekZZjCTHWlOPrKFL/MVOSfstfyQ8BIgjEUuLSjQfydiJkh5S8medYE7oaZN34Z0higDBAxEzOyeuBVZjUUX5UDZ8hPocTPtYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=wL3TtseN; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="wL3TtseN"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8E7F21DFAD7;
	Sat, 20 Jan 2024 17:49:13 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=+EKolObrAtl+VOZr9YIwGgBCsMtWyj/BVhyo5w
	AmIA4=; b=wL3TtseNHS30AHS0ScAe9du0f2CGGDQC/tUcCJV9726ajGDUa2AsFR
	RwOU3FgeAU71GmTWTvI0pEjQXHcbkYT0CstXoNM66RomDxGRKhIDd1p4PXXv6Nzx
	0sJeN0MiZOMy+cJPpqiwzu4heotJCXCTb8iPLyQ20posZ+VvkX6sw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 859171DFAD6;
	Sat, 20 Jan 2024 17:49:13 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id EB8DC1DFAD5;
	Sat, 20 Jan 2024 17:49:12 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Antonin Delpeuch via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Antonin Delpeuch <antonin@delpeuch.eu>
Subject: Re: [PATCH v3] merge-ll: expose revision names to custom drivers
In-Reply-To: <82624802-aa7f-4856-b819-9a2990b25a69@gmail.com> (Phillip Wood's
	message of "Sat, 20 Jan 2024 14:13:50 +0000")
References: <pull.1648.v2.git.git.1705592581272.gitgitgadget@gmail.com>
	<pull.1648.v3.git.git.1705615794307.gitgitgadget@gmail.com>
	<82624802-aa7f-4856-b819-9a2990b25a69@gmail.com>
Date: Sat, 20 Jan 2024 14:49:11 -0800
Message-ID: <xmqqcytvei3c.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 21A42CAC-B7E6-11EE-8702-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Phillip Wood <phillip.wood123@gmail.com> writes:

> Thanks for working on this, I think it is a useful improvement. I
> guess '%X' and '%Y' are no worse than the existing '%A' and '%B' but I
> do wonder if we want to take the opportunity to switch to more
> descriptive names for the various parameters passed to the custom
> merge strategy. We do do this by supporting %(label:ours) modeled
> after the format specifiers used by other commands such as "git log"
> and "git for-each-ref".

Perhaps.  Unlike the --format option these commands take, the
placeholders are never typed from the command line (they always are
taken from the configuration file), so mnemonic value longer version
gives over the current single-letter ones is not as valuable, while
making the total line length longer.  So I dunno.

>> [...]
>> +will be stored via placeholder `%P`. Additionally, the names of the
>> +common ancestor revision (`%S`), of the current revision (`%X`) and
>> +of the other branch (`%Y`) can also be supplied. Those are short > +revision names, optionally joined with the paths of the file in each
>> +revision. Those paths are only present if they differ and are separated
>> +from the revision by a colon.
>
> It might be simpler to just call these the "conflict marker labels"
> without tying ourselves to a particular format. Something like
>
>     The conflict labels to be used for the common ancestor, local head
>     and other head can be passed by using '%(label:base)',
>     '%(label:ours)' and '%(label:theirs) respectively.

Yeah, that sounds like a good improvement, even if we did not use
the longhand placeholders and replaced %(label:{base,ours,theirs})
with %S, %X, and %Y.

>> @@ -222,6 +222,12 @@ static enum ll_merge_result ll_ext_merge(const struct ll_merge_driver *fn,
>
> Not part of this patch but I noticed that we're passing the filenames
> for '%A' etc. unquoted which is a bit scary.
>
>>   			strbuf_addf(&cmd, "%d", marker_size);
>>   		else if (skip_prefix(format, "P", &format))
>>   			sq_quote_buf(&cmd, path);
>> +		else if (skip_prefix(format, "S", &format))
>> +			sq_quote_buf(&cmd, orig_name);
>
> I think you can avoid the SIGSEV problem you mentioned in your other
> email by changing this to
>
> 	sq_quote_buf(&cmd, orig_name ? orig_name, "");
>
> That would make sure the labels we pass match the ones used by the
> internal merge.

Makes sense.  That would be much better than using hardcoded string
"ours", "theirs", etc.
