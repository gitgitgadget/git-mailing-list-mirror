Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93A82134BA
	for <git@vger.kernel.org>; Tue,  6 Feb 2024 18:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707244611; cv=none; b=hEyiVeI/OY0OK64Ei8N+Lwq2G8G445MBPn2uw3j/y90N4GLy2ro35CPZoVHWDFKjVl4YCJgxyBHSEGGfvK89zWEo4RTE+Tq/RwILUUnp/1w8h5vGUz7fU45s9XK59JQ0/l2QhX4cnehS6oQ6ar2dNQgfz5dUOcy2Sbh1tXje5dU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707244611; c=relaxed/simple;
	bh=eZqrEJAIE3ZBSZZspEjhBjbU2TzYIyObBAH6W2SOIL0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lW6wm8uDZL/tC0GWngoFZchHebdb6Cs4OWMOp157v0R/IzBhxzTNrQSWETkFB3nOjwWguFblLaIvN9J30ctwi9BEdBMPjN4UoqIbbk8nsoFJ306VSIaAdPhlYbtGQv7AFDZ4eE0prKfnRFrRkYi1P98ITmNsKd5dI7CxxxcKDoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=ZwmDPjvw; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ZwmDPjvw"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id CD6DB24505;
	Tue,  6 Feb 2024 13:36:49 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=eZqrEJAIE3ZBSZZspEjhBjbU2TzYIyObBAH6W2
	SOIL0=; b=ZwmDPjvwaR1dy1DLqcXz7muzGf0JEZvXG9D2m0P1+NgZ3fQ67KDO7W
	pZJfketpj5KIVrsKY52Ujw8DhaXkRGakQQFQ/rAnqcqIDarrNBrug0Ac7G6+EpFe
	QvCcOXWz+OFZ2hMTDcRt1QAkXNmbfvGGYPvYFDgUFwUQdvOmfQwgo=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id C66F524504;
	Tue,  6 Feb 2024 13:36:49 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 73B57244FF;
	Tue,  6 Feb 2024 13:36:46 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] Always check the return value of `repo_read_object_file()`
In-Reply-To: <CAOLa=ZQOALZRNqp7dDH0qDWoHwo6_3G8VgVuMbb3C20UdJ4C5A@mail.gmail.com>
	(Karthik Nayak's message of "Mon, 5 Feb 2024 08:10:06 -0800")
References: <pull.1650.git.1707143753726.gitgitgadget@gmail.com>
	<CAOLa=ZQOALZRNqp7dDH0qDWoHwo6_3G8VgVuMbb3C20UdJ4C5A@mail.gmail.com>
Date: Tue, 06 Feb 2024 10:36:44 -0800
Message-ID: <xmqq8r3xign7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 AEA68484-C51E-11EE-A689-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Karthik Nayak <karthik.188@gmail.com> writes:

> Hello,
>
> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com> writes:
>> diff --git a/bisect.c b/bisect.c
>> index f1273c787d9..f75e50c3397 100644
>> --- a/bisect.c
>> +++ b/bisect.c
>> @@ -158,6 +158,9 @@ static void show_list(const char *debug, int counted, int nr,
>>  		const char *subject_start;
>>  		int subject_len;
>>
>> +		if (!buf)
>> +			die(_("unable to read %s"), oid_to_hex(&commit->object.oid));
>> +
>
> Nit: We know that `repo_read_object_file()` fails on corrupt objects, so
> this means that this is only happening when the object doesn't exist. I
> wonder if it makes more sense to replace "unable to read %s" which is a
> little ambiguous with something like "object %q doesn't exist".

I am not sure if that is a good move in the longer run.  We may
"fix" the called function to return NULL to allow callers to deal
with errors from object corruption better, at which time between
"doesn't exist" and "unable to read", the latter becomes far closer
to what actually happened (it is debatable if a corrupt thing really
exists in the first place, too).

> Otherwise, the patch looks good, thanks!

I haven't read the remainder of the patch, but to me this hunk looks
OK.

Thanks.
