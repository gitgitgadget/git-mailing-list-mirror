Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFA3F1ABEB9
	for <git@vger.kernel.org>; Fri,  2 Aug 2024 21:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722633228; cv=none; b=XRjbcpe+PGTSs7UgZOEJ29ZCTiMxzlt2hTnSuIN5CVk9JIVJ1FjZv5uH6+w89pUKPafSHuIIxu/CGwi53MQ5zAIQbUg6Jz3fl5fEUdKpDYaQO/7H1U6Z3FqOYEpezJYqTk2rekl/R+4KHkiPBe7xdYv9WrUevj4V5iMB2m/5Pec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722633228; c=relaxed/simple;
	bh=tdygIN23cciKKVv0OgFCE/cHY5rH0SEGmZ528TsQ+g0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uXdvqw64zW5/hP4q2LIStiLcYhZn+LJyE5E1US62TPO8u0vjX99NUav3gHwr1dZ4JwK7+nThmra0clyybJ5+L4dxw3AOlsAMwl0fnXXSuv2nZt1NJO21p4zfGyoyfDMSJDkS4RKPXk12sChofM5I+R7T8ERCMe8yKB7X6x17RbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=ZWEgSBkV; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ZWEgSBkV"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 7E13B1C954;
	Fri,  2 Aug 2024 17:13:46 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=tdygIN23cciK
	KVv0OgFCE/cHY5rH0SEGmZ528TsQ+g0=; b=ZWEgSBkVMH3KBTfB3UaqFhc+9SR+
	cYiO/lvEPoO/DHOGImxJBuoPuYw9KZE8n3SWFHQSijMOxr7lEvOpEIHiX7ludQxa
	0aBDWFt1ucFjg7QS3kyjf1brcGChsqq7ZafE60iTk/5N205mIm20HW54hocYWKNj
	DdSqIXgzdDXQOyA=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 768EF1C953;
	Fri,  2 Aug 2024 17:13:46 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 7C0151C952;
	Fri,  2 Aug 2024 17:13:42 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Ryan Hendrickson <ryan.hendrickson@alum.mit.edu>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>
Subject: Re: [PATCH v5] http: do not ignore proxy path
In-Reply-To: <30733887-33d8-4049-7dc9-8bc9d0b106da@alum.mit.edu> (Ryan
	Hendrickson's message of "Fri, 2 Aug 2024 15:39:48 -0400 (EDT)")
References: <pull.1767.v4.git.1722489776279.gitgitgadget@gmail.com>
	<pull.1767.v5.git.1722576007398.gitgitgadget@gmail.com>
	<xmqq7ccygbx6.fsf@gitster.g>
	<2ba77de5-f103-c2f0-c009-71700c8a020d@alum.mit.edu>
	<xmqqv80idf52.fsf@gitster.g>
	<a0b916a4-8941-4c06-263d-0ae92dcaf29e@alum.mit.edu>
	<xmqqh6c2d8qt.fsf@gitster.g>
	<30733887-33d8-4049-7dc9-8bc9d0b106da@alum.mit.edu>
Date: Fri, 02 Aug 2024 14:13:40 -0700
Message-ID: <xmqqfrrmbpbv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 1892C0A2-5114-11EF-801F-9625FCCAB05B-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable

Ryan Hendrickson <ryan.hendrickson@alum.mit.edu> writes:

> At 2024-08-02 12:28-0700, Junio C Hamano <gitster@pobox.com> sent:
>
>>>>> Is this blocking feedback? This strikes me as speculative
>>>>> over-engineering
>>>>
>>>> No, it is loosening a pattern that is overly tight and as a side
>>>> effect shortening the line to more readable length ;-).
>>>
>>> Blocking or not?
>>
>> If we are updating anyway, that question is irrelevant, no?  This
>> version may hit 'seen' but until the next version comes it will not
>> advance to 'next'.
>
> I can't figure out what you mean by this so I am going to proceed as
> if you had simply said =E2=80=98non-blocking=E2=80=99.

It does not make much sense to ask if a suggestion is "blocking" or
"non-blocking".  If you respond with a reasonable explanation why
you do not want to take a suggestion, I may (or may not) say that
your reasoning makes sense.  IOW, making me say "it is blocking"
means you want to me to say that I won't listen to you no matter
what you say.  That is rarely be the case.

In this case, I do not think it makes sense to insist with -Fx that
the error message has the exact message.  And I do not think your
"strikes me as" qualifies as a "reasonable explanation".

