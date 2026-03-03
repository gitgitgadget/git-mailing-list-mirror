Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E40035E943
	for <git@vger.kernel.org>; Tue,  3 Mar 2026 12:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772542090; cv=pass; b=C5EK4MoCWnIamrmkeTZAahQS3DXXTtPhqbrtzFShmrp74Azekog5Vqp9BP0pPcTs1WHL0GrNjub9TgO4bpLXCsFh2VZ4lCtyESFo9+L/InF6ULexvQLLD9ALKApA7tecb+CkEACME208G7jFtsgSOpCLJtUspqpDFD4cFnSeT5w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772542090; c=relaxed/simple;
	bh=uKo5pDGyW3oB/+dCHVtJC8LHIZEFumRaRdv5y6SMYQ8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=m1i0B/P4WvMY+/VDSOFfhxEHeNbeCC2hAlgpSRD6U3gqWHFZym1LTA0tw2LxzzWKF3fmsss/Asuur7fSya6jI/ZCHjiXOlx0AQ5bxem2v+YUB1K+oc8OP5pUfQhYiviUnBp14ccRvTuYb2fqHHCosK5XJS2azx5r2NtkpRCQQbw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=bq5S65Gy; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="bq5S65Gy"
ARC-Seal: i=1; a=rsa-sha256; t=1772542077; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=eg5Mg1I28Z6b+lPNS/TdgFrWeTCcW6F4+qqMvNwxmBZBkekf0yiDL0EZDGVqcr09TpCyhCYijaOxx8irp0CU0eOQv826JRnD7lC0xoJkcx0BPiKNGSOVxNw9hJzwVjJYkybmKU3XLxXWDmqdahNNTtCdDeP6uuOABcPI7bGa1GQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1772542077; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=IbQ4D3T0HQtkx/0JsChVkYJhLLjqtmrLw1/UGBafFzY=; 
	b=Y/axG9IuQzPFctaRe9EXrjAigZKFJTFT9n9Hlz+/mqZ+4ec5+jRspee9Cz0ktHfIgkPmJyUAtyMkzTJucUwX7EPoEXfZwUaFqppeCALc7sgdJMpb8WS6h+ICuQhPXOSclc92xyb4CiKsbr5e+2rR09t6172Hv9rXwa7JMgPEKfk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1772542077;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:In-Reply-To:References:Date:Date:Message-ID:MIME-Version:Content-Type:Message-Id:Reply-To;
	bh=IbQ4D3T0HQtkx/0JsChVkYJhLLjqtmrLw1/UGBafFzY=;
	b=bq5S65Gyoq33SeA+Nf38vX/+/pHBlKAIcHJmdBWeEANA/xhOJ3qwAEYTdmswAFYI
	5MQMtAcuMWXscD1b219l6ZoOkgp/UUq5XIoFKhMQiKs3Pg5WDrrwnd9FJPLKaFDxJsp
	fGT8ZJhhttOqeS3rMT6cmvgBnZxwpOK8boD8FUGQ=
Received: by mx.zohomail.com with SMTPS id 1772542074750920.0980723375684;
	Tue, 3 Mar 2026 04:47:54 -0800 (PST)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>, Emily Shaffer
 <emilyshaffer@google.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/1] builtin/receive-pack: avoid spinning no-op sideband
 async threads
In-Reply-To: <xmqq4imxzz90.fsf@gitster.g>
References: <20260302191704.1814567-1-adrian.ratiu@collabora.com>
 <20260302191704.1814567-2-adrian.ratiu@collabora.com>
 <xmqq4imxzz90.fsf@gitster.g>
Date: Tue, 03 Mar 2026 14:47:50 +0200
Message-ID: <87342hoz9l.fsf@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ZohoMailClient: External

On Mon, 02 Mar 2026, Junio C Hamano <gitster@pobox.com> wrote:
>> @@ -1674,6 +1680,9 @@ static void run_update_post_hook(struct command *commands)
>>  	int sideband_async_started = 0;
>>  	int saved_stderr = -1;
>>  
>> +	if (!hook_exists(the_repository, "post-update"))
>> +		return;
>> +
>>  	for (cmd = commands; cmd; cmd = cmd->next) {
>>  		if (cmd->error_string || cmd->did_not_exist)
>>  			continue;
>
> Ditto for "post-update".
>
> Will queue with the following change squashed in.

Thank you Junio, much appreciated!
