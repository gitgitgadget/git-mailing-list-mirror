Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A6CD40DFC5
	for <git@vger.kernel.org>; Tue, 10 Mar 2026 14:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773152410; cv=pass; b=uNT07mBURWK5iHs3wvF2oReiU+Ml2Ti6tkKU55gq/tULRIZAuInrcAH9Y/U3uEBp+PCLgiSHmHW22TC4JHQRSkP6zMKLvuGuCja23B6P6HJizgBj8o55vPWUBSWL4oX8s0Pq4leJMZeYpzaCZpb6V2vwBx+Gu+BHRyB4uwujcZs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773152410; c=relaxed/simple;
	bh=98EyrTWNnxGhPBMH5j8Xah3R8Q6BaF3KUOn0G20PhaY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HlErzHqIJrX30AecHFtfeI/McJcH7QZIfgBUodGmMGwNXX8AdBsBe/Bw74Q4TRN+gouK+yGImshQY7grY+3ZKQ5/p8FDzzE+nFtu30yBHo1RYyHfP1rtCAi/erRPgCOB9dS7bH2bPvLRY2zhyHAufj1RlF9WglVaV/mpGaqxY6Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=WXypE5tQ; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="WXypE5tQ"
ARC-Seal: i=1; a=rsa-sha256; t=1773152392; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=iyyAXXX22GBK2AWgg+GvYDBSdX9Gwv7eNpn7ksxW6qvvnQP2cH3Qgy0xbBRrBP9M5g+9AZ/Vr+tKzXlS74BPwOYZYPB7KTthqunH5HNcRlB1Do24mIoF5Me5bheXFfUmCDt5pcS2IzkM4c34ucqfKoX0YFU+Cg5yIA9qvHRzE1w=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1773152392; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=5ozJc2cPYJqR625pcRfZUirXG8dtqapPm3XVnBNg/NI=; 
	b=Lfs8LGz3Io/xDChRpCLbXKyd4IduwmcyOv2DUZoT1vczUD8i/NWccMoqWDrCZ6pZMZWHn7HvglU8yjVTaLlQGf+lYXtSBfvG2Zhbi+OXAWq+AMtXDOD4iVqXPjjajg+fASL+HI/55k1B3ofRVuRdfC8wyCAbWsD1h8RwST3x3bI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773152392;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:In-Reply-To:References:Date:Date:Message-ID:MIME-Version:Content-Type:Message-Id:Reply-To;
	bh=5ozJc2cPYJqR625pcRfZUirXG8dtqapPm3XVnBNg/NI=;
	b=WXypE5tQOxYWl0dpre82wVm/cxsVoSHikY+8yQhgJYSdnU69xNa3C299l/3E5hIF
	Di9t7xwc9ZkgqA5qFGPadg9uNBjwSHLib5lDlfvO8UJ6Cg8VgS673lNHAPRW4K6UM/I
	KmksO4/hwFMIZu+Equv3KGkqqlxz8UKYMGg1mfzg=
Received: by mx.zohomail.com with SMTPS id 1773152390545309.5974812620143;
	Tue, 10 Mar 2026 07:19:50 -0700 (PDT)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>, Patrick
 Steinhardt <ps@pks.im>, "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH 08/10] hook: refactor hook_config_cache from strmap to
 named struct
In-Reply-To: <xmqqtsuo3bru.fsf@gitster.g>
References: <20260309005416.2760030-1-adrian.ratiu@collabora.com>
 <20260309005416.2760030-9-adrian.ratiu@collabora.com>
 <xmqqtsuo3bru.fsf@gitster.g>
Date: Tue, 10 Mar 2026 16:19:47 +0200
Message-ID: <87h5qng41o.fsf@gentoo.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ZohoMailClient: External

On Mon, 09 Mar 2026, Junio C Hamano <gitster@pobox.com> wrote:
> Adrian Ratiu <adrian.ratiu@collabora.com> writes:
>
>> Replace the raw `struct strmap *hook_config_cache` in `struct repository`
>> with a `struct hook_config_cache` which wraps the strmap in a named field.
>>
>> Replace the bare `char *command` util pointer stored in each string_list
>> item with a heap-allocated `struct hook_config_cache_entry` that carries
>> that command string.
>>
>> This is just a refactoring with no behavior changes, to give the cache
>> struct room to grow so it can carry the additional hook metadata we'll
>> be adding in the following commits.
>>
>> Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
>> ---
>>  hook.c       | 61 +++++++++++++++++++++++++++++++++-------------------
>>  hook.h       | 10 ++++++++-
>>  repository.h |  3 ++-
>>  3 files changed, 50 insertions(+), 24 deletions(-)
>
> Hmph, so originally we pointed directly at a "struct strmap"
> instance from inside a "struct repository", and the strmap mapped a
> hook's event name to the command to run, which is a raw "char *".
>
> In order to future expand the attribute we keep track of for each
> hook beyond a simple string, we replace the "char *" with a pointer
> to "struct hook_config_cache_entry".  That part makes quite a lot of
> sense.
>
> However, I'm less convinced about the value of wrapping the `strmap`
> itself in a new `struct hook_config_cache`. Since the "growth" in
> later patches happens entirely within the entry struct, this top-level
> wrapper feels like unnecessary boilerplate that adds an extra layer of
> indirection without a clear benefit. It might be better to keep the
> cache as a bare `strmap` and only introduce the entry struct.

Yes, I think this can work and is also simpler.

Will do in v2, thanks for the suggestion!
