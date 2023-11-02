Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A79D1DDCE
	for <git@vger.kernel.org>; Thu,  2 Nov 2023 23:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="G5Y5F2tT"
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B772E191
	for <git@vger.kernel.org>; Thu,  2 Nov 2023 16:45:13 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 260B930972;
	Thu,  2 Nov 2023 19:45:13 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=pFIR7ZgGt8PDHsClDd30/2WK0loq8o11W8dzlx
	SKY3c=; b=G5Y5F2tT3dwT85PpagmwwiDkhIL3M4pJ9ZsmvJuVy+L9d6T/TGx7AR
	G2MuIdWD8MmyO86WcZahOUMWuKy3gYDuaZsYndAyN/SrQisjuEL1kmA6sQtp1udI
	UP8tnXrVTucjP0PvtQkZ6Fe6zKrClzb658kRSIjiQhyPB/ZHbl1+A=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 09B3630971;
	Thu,  2 Nov 2023 19:45:13 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.67.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 0AEE83096C;
	Thu,  2 Nov 2023 19:45:05 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Joanna Wang <jojwang@google.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/1] attr: enable attr pathspec magic for git-add and
 git-stash
In-Reply-To: <xmqqil6jlu3m.fsf@gitster.g> (Junio C. Hamano's message of "Fri,
	03 Nov 2023 06:32:13 +0900")
References: <xmqqfs1ooil2.fsf@gitster.g>
	<20231102175316.2229631-1-jojwang@google.com>
	<xmqqil6jlu3m.fsf@gitster.g>
Date: Fri, 03 Nov 2023 08:45:04 +0900
Message-ID: <xmqq34xnlny7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 D9987A70-79D9-11EE-BE47-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Junio C Hamano <gitster@pobox.com> writes:

>> +	} else {
>> +		/* For an element in longhand form, we simply copy everything up to the final ')' */
>
> A comment that is a bit on the overly-long side.
>
>> +		int len = strchr(element, ')') - element;
>> +		strbuf_add(sb, element, len);

In practice, nobody sane would write a pathspec magic that is over
2GB in size, so this would not matter unless we are facing a
potential attacker, but as the third parameter strbuf_add() takes is
of type size_t, it would not hurt to define "len" as the same type
as well.

> Thanks for working on fixing this rather old bug.  I think we should
> have noticed when we added the support for the "attr" magic to the
> pathspec API.

