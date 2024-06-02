Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 933315BAD7
	for <git@vger.kernel.org>; Sun,  2 Jun 2024 17:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717350417; cv=none; b=aAcwVboavItfj/9yUMTuqCywun/hfnzCRU/LWS7UR15ptQvcIZabgGNt0SASo1fccJOcUjeQ+QnWmZoziV9rSC5ekho12avFjqDznRDfzByadHkudc5wmCFHCKKCTIsEadMAar7OFm2YL3OdCNdc8XIYOOphj5OQUn9eqm9dRgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717350417; c=relaxed/simple;
	bh=gDJ+HvBnxb8lCFal6z2+NW9JW7mp5UqWtceTLfxU5ps=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=BATJdYnh5Risy/LwKMkzXFPr8PHnUWBY9TV+14jGgzvuKCrGSsFm6KJocSNKfmd2jRQGb4VX2qW3UKmeNAzhJmlvLIGCQwRGlkll5DWx75UI1tqJ+1J8nSHS1+/5OH4iUXrvbruPey68RdheYJLPvGTd24YC2LP0m1cNOrE7jCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=m3HT7pNO; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="m3HT7pNO"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1717350413;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6vDj2uoy/025Lq/l1WE6mNVLfB+HxnSSW+53mBxbftA=;
	b=m3HT7pNOAS2iDFAJoiUo0Qtrqz495X0AoIW4c6Vt3DXcSnx75kMjwFWIwg2Nv39Db+db1P
	//u9olH5M82Rw7xNP1P514wPCp5DOtMtJtS/fUH3fdPtPbbivCg5/ncSghsn37v8l01Hao
	pRvIHScZVfiTZTZirY87Rw5y6Ure6jZAgBlqITZEVaaXC/pzNMAi+UMNyzPqjiXv79aXaU
	eBgFo8tq+C6UFPUrXuX8d/McwrhpK2Q5KpKQlVWDJ3E3bSYBOJOj0lQoDVbUEl6saif3Hs
	zqSzBwr9OGvZha31uLFEf9SgP4PCvMfvBOAJWE5wHC1VcwvX8dijhEzvE17mAA==
Date: Sun, 02 Jun 2024 19:46:53 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Junio C Hamano <gitster@pobox.com>
Cc: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>, Git List
 <git@vger.kernel.org>, Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 0/6] use the pager in 'add -p'
In-Reply-To: <xmqqwmn79u98.fsf@gitster.g>
References: <1d0cb55c-5f32-419a-b593-d5f0969a51fd@gmail.com>
 <199072a9-a3fb-4c8d-b867-b0717a10bacc@gmail.com>
 <b7e24b08-40a1-4b18-89f6-e25ab96facaf@gmail.com>
 <xmqqwmn79u98.fsf@gitster.g>
Message-ID: <ec2ca25486b84615e30dbeb83ec47310@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Junio,

On 2024-06-02 18:36, Junio C Hamano wrote:
> A possibility is to phrase it like so:
> 
>     | - pipe the current hunk to the program (or "%s" by default)
> 
> and fill %s with the program you'd use if not given, i.e. initially
> the value of the GIT_PAGER but updated to the last used program
> after the user uses "|<program>" form to specify one.

The value of GIT_PAGER (or the <program>) can be a rather long string,
so it would have to be stripped down to the base command, but it would
be rather error-prone and the printed information would become much less
informative that way.
