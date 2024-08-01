Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6854113C9A3
	for <git@vger.kernel.org>; Thu,  1 Aug 2024 16:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722531296; cv=none; b=ZF8g4Ll1ccZ226Sf5BtDcEPNpGlIaH1V+9h3doRqTp1I0RGw4S1OL5gx4+X3b6tKGfgImYh1xGn9FciJVNaaWssqvUBHDyqL1mG1p7gLcHRjwxWTZ+u7TPZCjVlCDCTyfzYPpr2kNTzZJt89hQedzbXgW+juokZnPI82jrQK+Ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722531296; c=relaxed/simple;
	bh=xo4byogv5Vq9ri4qn7QUaLttZ3F7did1OUgzHo2ZHgI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=c7iE9E812SMICduLDB1R1KHhwFZi44CDEeJC7f8zkNm1spLQZLKh2kdcgefcDr5SGdPyFDgEanLYUAOidbkB5vFN1HVtLdkkC830os3tPsd+m703oqH6EhomQsSscCGDDL5ama+dnSZjR9ujYQBo0Jkj8gaqmhvMOJYRecEEgXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=P0PmdL2Y; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="P0PmdL2Y"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 527B52AAD2;
	Thu,  1 Aug 2024 12:54:54 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=xo4byogv5Vq9ri4qn7QUaLttZ3F7did1OUgzHo
	2ZHgI=; b=P0PmdL2YYvGTG893For4CVt/SnAzY+UhkHnNORT4fzkxhz6I1KVDSo
	Zpbq2KWiwAGGU+VFGbzk5LNY9G5xKrY7QXlI2vp309QTSRDM153evEOoAW5RafYd
	DW60bV6p/C5lVzUXhBZcV9S7tELJ6zyYZDvsDwTEERpmnm/AAig40=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 4A46A2AAD1;
	Thu,  1 Aug 2024 12:54:54 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id AB6BF2AAD0;
	Thu,  1 Aug 2024 12:54:53 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Phillip Wood <phillip.wood123@gmail.com>,
  Kristoffer Haugsbakk <code@khaugsbakk.name>,  Jeff King <peff@peff.net>,
  Patrick Steinhardt <ps@pks.im>,  =?utf-8?Q?Jean-No=C3=ABl?= Avila
 <avila.jn@gmail.com>,
  Linus Arver <linusarver@gmail.com>,  John Cai <johncai86@gmail.com>
Subject: Re: [PATCH v2 3/3] ref-filter: populate symref from iterator
In-Reply-To: <xmqqwml0uqxi.fsf@gitster.g> (Junio C. Hamano's message of "Thu,
	01 Aug 2024 09:51:53 -0700")
References: <pull.1712.git.git.1717694800.gitgitgadget@gmail.com>
	<pull.1712.v2.git.git.1722524334.gitgitgadget@gmail.com>
	<3e147e7d850773f44b48d1b86e89aef1415a0ccd.1722524334.git.gitgitgadget@gmail.com>
	<xmqqwml0uqxi.fsf@gitster.g>
Date: Thu, 01 Aug 2024 09:54:52 -0700
Message-ID: <xmqqsevouqsj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 C6460A04-5026-11EF-AAAB-34EEED2EC81B-77302942!pb-smtp1.pobox.com

Junio C Hamano <gitster@pobox.com> writes:

>> @@ -2852,6 +2852,8 @@ static struct ref_array_item *apply_ref_filter(const char *refname, const struct
>>  	ref->commit = commit;
>>  	ref->flag = flag;
>>  	ref->kind = kind;
>> +	if (flag & REF_ISSYMREF)
>> +		ref->symref = xstrdup_or_null(referent);
>>  
>>  	return ref;
>>  }
>
> What is curious is that we do not lose any code from
> populate_value() with this change.
>
> Is that because of this piece of code near the beginning of it?
>
> 	CALLOC_ARRAY(ref->value, used_atom_cnt);
>
> 	if (need_symref && (ref->flag & REF_ISSYMREF) && !ref->symref) {
> 		ref->symref = refs_resolve_refdup(get_main_ref_store(the_repository),
> 						  ref->refname,
> 						  RESOLVE_REF_READING,
> 						  NULL, NULL);
> 		if (!ref->symref)
> 			ref->symref = xstrdup("");
> 	}
>
> That is, if we somehow know the value of ref->symref for a ref that
> is known to be a symbolic ref (and when we know we need symref
> information in the output), we do not bother calling refs_resolve
> here to obtain the value.

I forgot to ask the real question.  With your change in place, does
this "lazily fill ref->symref if it hasn't been discovered yet" code
still trigger?  Under what condition?  Or is this now a dead code?

Thanks.

