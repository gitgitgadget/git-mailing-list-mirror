Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 602B21A08C6
	for <git@vger.kernel.org>; Tue,  1 Oct 2024 18:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727809144; cv=none; b=bvcu/ia99tP9p15pfP0OwlF0M9hhQyrxuLv/jxiG7u1p0U0NDt8Rmx0MpCermgPYyfdAJVRvyC1ELhPVk2PoAFbxIAkzIGW21Np9ju5HZSKVh0vnwYYGr6V+yVz2cPPQEr4C6unEM50f4qIe9UE9qnLNvehe2nTyKpt7CINXE64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727809144; c=relaxed/simple;
	bh=M2jJuKMXMUa1jOf3gqk8cVDqbwPVSd8xpMQRNnjtXWQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=AgCz3Gbp9U70u4Ap6hQUiVmSEKpls1o08jMeTSxZDXDazMh0JuEjL5DDkjR1Es6DKirMF+jNHEHXqJYbLWEcut3BwmUWAhOLO+UnFU/Bl5P5X5uBVxpF+cBGf9AnNt4DH5w6e+FKNO7GSntahclwnXDzRiTBsnRw9cRQhI0xkhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=hDbz34cO; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="hDbz34cO"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1727809136;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=M2jJuKMXMUa1jOf3gqk8cVDqbwPVSd8xpMQRNnjtXWQ=;
	b=hDbz34cOiAc+KsE1lU0uoLy0g7US2+Ot8qll6/pBVSSPb3is93FC+ymfh5eILW6CyJmRfi
	KAmmcu7QvbC2vDQQGMH6hwRS7/z2anb6sMrvv+H//clUqA9KbSjzJfF1slUYc1v6LeYW40
	ckHtvt54fsbhigscHisV6rYCY9Z47oU=
From: Toon Claes <toon@iotcl.com>
To: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Cc: Toon Claes <toon@iotcl.com>, git@vger.kernel.org
Subject: Re: [PATCH] bundle-uri: plug leak in unbundle_from_file()
In-Reply-To: <xmqqle0jmfpf.fsf@gitster.g>
References: <20240826083052.1542228-1-toon@iotcl.com>
 <ZsxQBEpfChQozhF7@tanuki> <xmqqle0jmfpf.fsf@gitster.g>
Date: Tue, 01 Oct 2024 20:58:41 +0200
Message-ID: <87ikubsl9a.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Junio C Hamano <gitster@pobox.com> writes:

> Thanks for reviewing carefully.
>
> Both of two callers of unbundle_from_file() are used as the
> condition of an if() statement, so unbundle() that signals an error
> with -1 wouldn't be a problem, I would think.

Hi Junio,

I've noticed this patch wasn't picked up yet. Is there anything you want
me to change and have me sent another version, or is it good to go in?

--
Toon
