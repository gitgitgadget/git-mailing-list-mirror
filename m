Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4942246788
	for <git@vger.kernel.org>; Wed, 25 Mar 2026 15:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774452941; cv=none; b=pXkbHnAzQKNqGzMut+aHBxPeDaq3NKAYQ+swjyAesZ1KxK7VAOichcjbroy0hCBkJ716TrTbOmzlnoRbYiZk5AInohpRpB1Y/D7mQX+RNn7Fsj43CaF9JYK2KcMlf44iqTvnBWROtnS0NGMQ2tPrUGOL76i93ryhiMHyfzuaC2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774452941; c=relaxed/simple;
	bh=7RSPQnd+b1stXiFBSp+dhLhRbbSrQyDJWs5o63et5p0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sHPXHIn0o28TVCj+iWOy18zuJAeOC2HlzXOJwJrOoXUkdVrap/gge7try5ztghfXv5TZ+igdOXTa4kY4KuXDjN0bNwoxm/9LhWSUoUpmD6/o6VKGn3beDchIrPlcxe+dfTOdKRvn3MgeOczqkSD64H+aDO8CRC0wlvDiu6XIcrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=JAXsZIwZ; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="JAXsZIwZ"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1774452937;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7RSPQnd+b1stXiFBSp+dhLhRbbSrQyDJWs5o63et5p0=;
	b=JAXsZIwZYqXU6fFq7mGtmMW9/H4kCwkE4nUGHmB/uLdRioM7kOHLp9rUUE8G/O/Z+Bgvlo
	+eRjcUHae4CS+45TCFwmB2R3fBlEY/dckU8+rNWkx0AN8TaoDIO9OSiLg97471KnzZC+Em
	J19sDvQ/TkVyijIBV4Mn0X+PwB7LuQk=
From: Toon Claes <toon@iotcl.com>
To: Ben Knoble <ben.knoble@gmail.com>, Christian Couder
 <christian.couder@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org, Elijah Newren
 <newren@gmail.com>
Subject: Re: Make git-replay(1) warn if revision-range isn't a range (was:
 Re: [PATCH v2] replay: support replaying down from root commit)
In-Reply-To: <E0A14573-BBE2-4ADF-989C-E5B2A7E3E166@gmail.com>
References: <CAP8UFD1zJXnsm7POK32GqEu4xSC+VO5mfzUpM-jn+Nr1qvzEFQ@mail.gmail.com>
 <E0A14573-BBE2-4ADF-989C-E5B2A7E3E166@gmail.com>
Date: Wed, 25 Mar 2026 16:35:32 +0100
Message-ID: <875x6j2a7v.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Migadu-Flow: FLOW_OUT

Ben Knoble <ben.knoble@gmail.com> writes:

>> The patch looks good to me, but I wonder if the docs should be updated
>> somehow, especially to try to avoid confusion in case users don't
>> properly specify a range.
>>=20
>> For example, before this, `git replay --onto main topic` would fail,
>> but emit "fatal: replaying down from root commit is not supported
>> yet!". This would likely help users understand that they might need to
>> properly specify a range like "main..topic" instead of 'topic".
>>=20
>> Now it would likely fail without any error message.
>
> Having used replay in a large monorepo where I juggle many branches
> (so rebasing another in-flight topic without otherwise interrupting my
> work is valuable), I=E2=80=99ve made this mistake a few times. Some way of
> handling it more gracefully would be appreciated: perhaps the root
> case is rare enough to warrant an option or confirmation prompt (when
> attached interactively)?

Yeah, there is definetily room for improvement here. But I consider that
outside the scope of this series and more like #leftoverbits.

--=20
Cheers,
Toon
