Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97202482EF
	for <git@vger.kernel.org>; Mon,  4 Mar 2024 16:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709569704; cv=none; b=loYcM2UDmUNSQCnJ0UjxHW4Ny5AuqBDzfc5zsX9EnJctMcKp15RLWAJM+KO1icWagn9ljNALxZVPOkVaBHEurd7LeVJ/jxP65oo9B0jiHJZ2mxj6GGw5KH9crP4vUXQHbg8GlhYuYGkCH5P3SO0CDeoPqIzh+PBp/DO1UXMgbOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709569704; c=relaxed/simple;
	bh=LFBQs4+QoFxrDhYsugIa4plYHZy+f13M8RJ8wjpeTIs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jm/rRysvrDUhNfnGM64lh2grHJLpq4oXN58cBtqscw1Wrji9Y0Cet7dSVIgZuWq7WgbUqwYNSXL8WJW9fc7OfCfR0akw0DegYP/xNNX7qxbxTzTtMod5W8mkyWXISRIDYs1seuZ9r3jDCC4XiRdwBKBL79FwBDHbZ1W/TsTO7Vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=dsw/OrzM; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="dsw/OrzM"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 17DE3351F7;
	Mon,  4 Mar 2024 11:28:22 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=LFBQs4+QoFxrDhYsugIa4plYHZy+f13M8RJ8wj
	peTIs=; b=dsw/OrzMmdeg7BPAp14RUtiwXnKAS4++WJ2DinVCmY3oqVVwMxdpSG
	5KTzm52P6nRMT1qZirMglcCxjr0LsqKbxaZtjaDgqVq4iL2KwyRMQk32GTBqMzgl
	xk79+sQa0JxyPpT8SgUoJvCKZW4v0yyb1GnE428X3ohdLgdmgIGKs=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 10CC9351F6;
	Mon,  4 Mar 2024 11:28:22 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.176.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id AAAA2351F5;
	Mon,  4 Mar 2024 11:28:18 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Karthik Nayak <karthik.188@gmail.com>,  git@vger.kernel.org,  Mike
 Hommey <mh@glandium.org>
Subject: Re: [PATCH 1/2] refs/reftable: don't fail empty transactions in
 repo without HEAD
In-Reply-To: <ZeVtuqEAelfiA2J9@tanuki> (Patrick Steinhardt's message of "Mon,
	4 Mar 2024 07:44:10 +0100")
References: <cover.1709041721.git.ps@pks.im>
	<95be968e10bd02c64448786e690bbefe5c082577.1709041721.git.ps@pks.im>
	<CAOLa=ZSycN0iYbBP-rXKW5=tNJLaSd0q8+Vm=CzNfsP2nR0sJg@mail.gmail.com>
	<ZeVtuqEAelfiA2J9@tanuki>
Date: Mon, 04 Mar 2024 08:28:17 -0800
Message-ID: <xmqq5xy2rmfy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 359C6F1E-DA44-11EE-9C20-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

>> > Now there is a very particular edge case in this situation: when
>> > preparing an empty ref transacton, we end up returning whatever value
>> > `read_ref_without_reload()` returned to the caller. Under normal
>> > conditions this would be fine: "HEAD" should usually exist, and thus the
>> > function would return `0`. But if "HEAD" doesn't exist, the function
>> > returns a positive value which we end up returning to the caller.
>> >
>> > Fix this bug by resetting the return code to `0` and add a test.

So this _will_ surface as a bug when the other change in the series
is applied, but it nevertheless is worth fixing independently of the
other one, because ...

>> > @@ -821,6 +821,7 @@ static int reftable_be_transaction_prepare(struct ref_store *ref_store,
>> >  				      &head_referent, &head_type);
>> >  	if (ret < 0)
>> >  		goto done;
>> > +	ret = 0;

... after "if the refs->err records an error already, skip
everything we do and return to the caller", we should take the
ownership of what we return (which will be in "ret") from now on.

So the current code uses "ret" as an uninitialized variable, even
not technically so because it is "initialized" to "refs->err"
upfront, and this is like a fix of uninitialized variable use.

>> So this is not really a problem in this function, it's more of that
>> `refs.c:ref_transaction_prepare` checks if `ret` is non-zero.
>
> Well, yes. I'd claim that it is a problem in this function because it
> returns positive even though the transaction was prepared successfully.
>
>> Nit: would be nice to have a comment about why overriding this value is
>> ok.
>
> True.

Yup.  It seems we will see a v2 for updating the test code as well,
so I'll assume that you'd explain this as an independent fix (as
well as a required preliminary fix for the other one).

Thanks, both.
