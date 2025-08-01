Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE498223707
	for <git@vger.kernel.org>; Fri,  1 Aug 2025 11:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754048284; cv=none; b=Y8NlA5ie9Ekd2wbdsI6E1OTGwpw4OAk0LRAg5fyZy43UvGMlD7CUj+ljnTaS67p+02yOR4wea+bJ+Bnsvl4NAAy9LqwttMlpY4FLJmjCr2fWXRmE1bHZLdg8sYp9VhCmprP9RR3kc27glXJk33pBMVcHawwgRBfv7eEis0FwrwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754048284; c=relaxed/simple;
	bh=9W0l4hj858BxOJElhQkxxedruFfPHXGsjWEywBFafHQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CUl1XW1Awh8rr8qHLoANIWuANZDTTFjrj5q2wsXjckwpbLIl3Eu5vYFd+wTXDW8+rKWOojP1WQ8inwEb4m8u1HtteWE+F86KzEHIdW8Kn6cFeH255Q1REIoD0uFajUpBtjxD50OD0/VsSQRXfVh/AAjskjVkFD4he3uoeZscBGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=Mk4MH8LK; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="Mk4MH8LK"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1754048276;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+wzVE1mKpUoDaAGIO3w1FdAEpbee01gNjxVf1c2kNTU=;
	b=Mk4MH8LKcN0q7KzJArQ0Py0wsKQl48sDDLhY2QBftO1uoxIuByhgiMZ38/RbZ+G6qpI5GJ
	dQH3EArzUC5crPQa3m4NTivHYhU/diKgC+noQLbZZmfwUVBXbHSA5Unnz1CTihRxngBELQ
	FEiuztPQJT0aElzyffJDgf/cdO1TgKY=
From: Toon Claes <toon@iotcl.com>
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, Justin Tobler
 <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>, SZEDER
 =?utf-8?Q?G=C3=A1bor?=
 <szeder.dev@gmail.com>, Jeff King <peff@peff.net>, Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>, Ben Knoble <ben.knoble@gmail.com>
Subject: Re: [PATCH v3 4/9] builtin/reflog: implement subcommand to write
 new entries
In-Reply-To: <20250729-pks-reflog-append-v3-4-9614d310f073@pks.im>
References: <20250729-pks-reflog-append-v3-0-9614d310f073@pks.im>
 <20250729-pks-reflog-append-v3-4-9614d310f073@pks.im>
Date: Fri, 01 Aug 2025 13:37:40 +0200
Message-ID: <87wm7nuvaz.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Patrick Steinhardt <ps@pks.im> writes:

> +test_expect_success 'abbreviated object IDs' '
> +	test_when_finished "rm -rf repo" &&
> +	git init repo &&
> +	(
> +		cd repo &&
> +		test_must_fail git reflog write refs/heads/something 12345 $ZERO_OID old-object-id 2>err &&

Is the object id rejected because it's short, or because there simply
doesn't exist an object that starts with `12345`? You're not really
testing the former, which you claim in the test name.

-- 
Cheers,
Toon
