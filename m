Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7687168C7
	for <git@vger.kernel.org>; Fri, 26 Jul 2024 15:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722007552; cv=none; b=GOOx1QMU8+Z5tXAkxPbOTxBUupDHesXdRjEkXuO1REcp6yvyU1xWqgCZjaMwIx/CUbLBXkqxtHuYpPptlrP8e/s8wkZnehkd5/Xd4M3QCQ6ej63JOpzTQlSnucZVU+DlvgtZPRlvGoE3BpjWeN60eSIddObfr0DI/KfPJ2jQB8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722007552; c=relaxed/simple;
	bh=CNLUx9LEQYr5efQh+GhMi/zbcrr/X8zWb7Z+cV+DoLc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sW65wqdzJ2IWnMfRxrUiSD478fD1kFYIVJ7j5mj6UgAbuMOoBNxZqxx8z9p8YA4WuYE4QzQ/rMZRpBefwidl8gnBST9IKwnDTNfU0dpL7EGnlcNmgBjLh23hd3zkEyao5T8tHXaMBrfYAtYG6/im6leosg+hz/Xjy40pusAz1eI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=s2Jf+UkL; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="s2Jf+UkL"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 9AFD1345C8;
	Fri, 26 Jul 2024 11:25:45 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=CNLUx9LEQYr5efQh+GhMi/zbcrr/X8zWb7Z+cV
	+DoLc=; b=s2Jf+UkLZLfvX4ca8MMITRf3NXbUpEjtLRUqPuP9BJMyEqML8pWkyc
	l76vi0b+jHVcbOYxGFPpe8mtOtBRsfHoi5/8W2ZwvaPcCvfv9A9Qrn1eEk738RAW
	Y+lWcYRqYcd6UheV4luaYczd8xfoCaSeU+uheNEnFZvjgsVGupD8I=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 930CF345C7;
	Fri, 26 Jul 2024 11:25:45 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 24F16345C6;
	Fri, 26 Jul 2024 11:25:42 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: Toon Claes <toon@iotcl.com>,  git@vger.kernel.org
Subject: Re: [PATCH v2 2/3] transport: introduce
 transport_has_remote_bundle_uri()
In-Reply-To: <CAOLa=ZTuM9XsroDKizvtOB0d1mJ4t8ffi6_bMuX+R8qzUEW6Rw@mail.gmail.com>
	(Karthik Nayak's message of "Fri, 26 Jul 2024 01:58:21 -0700")
References: <20240722080705.2614195-1-toon@iotcl.com>
	<20240724144957.3033840-1-toon@iotcl.com>
	<20240724144957.3033840-3-toon@iotcl.com>
	<CAOLa=ZTuM9XsroDKizvtOB0d1mJ4t8ffi6_bMuX+R8qzUEW6Rw@mail.gmail.com>
Date: Fri, 26 Jul 2024 08:25:40 -0700
Message-ID: <xmqq5xssyy2z.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 5204C5D0-4B63-11EF-A5B2-9625FCCAB05B-77302942!pb-smtp21.pobox.com

Karthik Nayak <karthik.188@gmail.com> writes:

>> diff --git a/transport.c b/transport.c
>> index 12cc5b4d96..1a7d86fa40 100644
>> --- a/transport.c
>> +++ b/transport.c
>> @@ -1536,7 +1536,7 @@ int transport_fetch_refs(struct transport *transport, struct ref *refs)
>>  	return rc;
>>  }
>>
>> -int transport_get_remote_bundle_uri(struct transport *transport)
>> +static int transport_get_remote_bundle_uri(struct transport *transport)
>>
>
> Why make it static?

The reason is rather well described in the proposed log message, I
think.

>> + * bundle URI(s) are received from the server.
>> + * Populates "struct transport"'s "bundles" and "got_remote_bundle_uri".
>>   */
>> -int transport_get_remote_bundle_uri(struct transport *transport);
>> +int transport_has_remote_bundle_uri(struct transport *transport);
>>
>
> Shouldn't this now be renamed to `transport_has_bundle_uri`? Earlier, we
> were 'getting' bundle URIs from the remote. Now, we are abstracting that
> away and simply asking, 'do we have bundle URIs'.

A good question.
