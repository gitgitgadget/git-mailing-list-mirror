Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E1B573177
	for <git@vger.kernel.org>; Thu, 25 Jan 2024 16:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706200108; cv=none; b=iCjOhn4GSOgaWjr+ImhM6Vo6OhBT4G1qK30Tyuuyx2WGPVWi1+ziSulutiIDbwfVfGDM20izR9FOFUruwtdkzyIgEsNf8AO2wpBhQYbZUD0FoTgAvdvlLuTuDK+G5ju9aZpZxRBJkCmWNe1Qp5K/MQOHheLey+unPtUeWd9SJaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706200108; c=relaxed/simple;
	bh=oKtA7mtxy3op/9dFRrVppRb0iNw3ZPE9ABjmLFJKV1k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IIYRRpoSPcfvXxhoE3np+QxGv+5pTejZf4uRb3iTcmDCdMvr8sVvbQvcgd6hKjZfE92FUUtuwFX2NjqFqH/t4XMni4yZLh86Ubi7cK+I1pouzbSf2zpalH1OPM4JTo0qdvPzfxuZh4nTx+jpOJaLNm6DrTb9kZX/mOKMUjW2nHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=VnW8ZQ3N; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="VnW8ZQ3N"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 8A13A23343;
	Thu, 25 Jan 2024 11:28:26 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=oKtA7mtxy3op/9dFRrVppRb0iNw3ZPE9ABjmLF
	JKV1k=; b=VnW8ZQ3NhV809xreksGkMo/5+SZJ1BIyG6iG2KQtYzOvt7Bm+vceQ/
	nai0AFXTVbxLYvckBuKYu/iFoYDlY5rzAEzcEW9bhnDdigdsd3BUVn2XkO+DXIMy
	EBs2H1GZGXrvQJYOAGLIBf/cLhO+srFptttZtZf2W9fe0k76AKnKs=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 8024F23342;
	Thu, 25 Jan 2024 11:28:26 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 066F923341;
	Thu, 25 Jan 2024 11:28:22 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org,  ps@pks.im,  phillip.wood123@gmail.com
Subject: Re: [PATCH v2 1/4] refs: introduce `is_pseudoref()` and `is_headref()`
In-Reply-To: <CAOLa=ZQxMZo2Y6x6GmVw=df_xS4tkF4D1_tZOeLb7jL5d5bKXA@mail.gmail.com>
	(Karthik Nayak's message of "Thu, 25 Jan 2024 16:20:15 +0000")
References: <20240119142705.139374-1-karthik.188@gmail.com>
	<20240124152726.124873-1-karthik.188@gmail.com>
	<20240124152726.124873-2-karthik.188@gmail.com>
	<xmqqfrymeega.fsf@gitster.g>
	<CAOLa=ZQxMZo2Y6x6GmVw=df_xS4tkF4D1_tZOeLb7jL5d5bKXA@mail.gmail.com>
Date: Thu, 25 Jan 2024 08:28:21 -0800
Message-ID: <xmqqa5otxtqy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 C214408A-BB9E-11EE-98EE-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Karthik Nayak <karthik.188@gmail.com> writes:

>>> +int is_headref(struct ref_store *refs, const char *refname)
>>> +{
>>> +	if (!strcmp(refname, "HEAD"))
>>> +		return refs_ref_exists(refs, refname);
>>
>> Given that "git for-each-ref refs/remotes" does not show
>> "refs/remotes/origin/HEAD" in the output when we do not have the
>> remote-tracking branch that symref points at, we probably do want
>> to omit "HEAD" from the output when the HEAD symref points at an
>> unborn branch.  If refs_ref_exists() says "no, it does not exist"
>> in such a case, we are perfectly fine with this code.
>>
>> We do not have to worry about the unborn state for pseudorefs
>> because they would never be symbolic.  But that in turn makes me
>> suspect that the check done with refs_ref_exists() in the
>> is_pseudoref() helper is a bit too lenient by allowing it to be a
>> symbolic ref.  Shouldn't we be using a check based on
>> read_ref_full(), like we did in another topic recently [*]?
>>
>>
>> [Reference]
>>
>>  * https://lore.kernel.org/git/xmqqzfxa9usx.fsf@gitster.g/
>>
>
> Thanks, this makes sense and the link is helpful. I'll do something
> similar, but since HEAD can be a symref, I'll drop the
> `RESOLVE_REF_NO_RECURSE` flag and only use `RESOLVE_REF_READING`.

Just to make sure there is no misunderstanding, I think how
is_headref() does what it does in the patch is perfectly fine,
including its use of refs_ref_exists().  The side I was referring to
with "in turn makes me suspect" is the other helper function that
will never have to deal with a symref.  Use of refs_ref_exists() in
that function is too loose.

