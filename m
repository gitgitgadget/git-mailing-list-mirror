Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13FD32FCE0D
	for <git@vger.kernel.org>; Thu, 17 Jul 2025 16:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752769903; cv=none; b=a3W6UoHlNAe6T/R/GCuqBfQPKLRMq7avuPfy2oJ/cUak0vupav7q1HbE5BXI3AAqlr2YeN/G3WAMSJL8yR65lq+V4P0J4IR4livO4PcA+UBh+UP0RQbVAmjXlPygkDX0rv3Y5o69idA7tu8ynPe+qniGD8G4TupnayFXDAGbvsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752769903; c=relaxed/simple;
	bh=HMYEmOoeiWiN+kGdUQkTcCAZNJZxUN4fhJVJw4x5VEg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Nx9W7fzkZft4tVMzE+4oEfMyzyo5I4Th6pPe05zTu9XK5/dABMT14KGtqN/b5Q1exQoiWAkEvcPJjnIYmlNvJ+HqgJRQgGaJiRBA1EnOf53G23jzokZYkSNZkDcIMU0dkX0ZdU2Rqr6p0cyKWWcHXKR0GE6UdxwVXO/6VJz4Scw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=C+H03ECP; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="C+H03ECP"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1752769897;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=d4KyCDQteUq7UwNXN6CCjBjWhgOrnkdSltkFewiKw04=;
	b=C+H03ECPGW+9LhVVtKHPEhZqx0MC34U+o6QldVNLpZtgCb9qIc1DzoFIBKne7tuT2v70LO
	hk8OOAhVqQgjSlGe1s3tVaHQpk1STGgJr+SpCUG1SD2wmnVV2shJLVp98C+6GPda4Wzw4j
	0mxXPMOsC9ttF0DHtMyNIb7WRclIzqE=
From: Toon Claes <toon@iotcl.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>, Derrick Stolee <stolee@gmail.com>,
 Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v5 5/6] last-modified: support --extended format
In-Reply-To: <xmqqldooazig.fsf@gitster.g>
References: <20250630-toon-new-blame-tree-v3-0-3516025dc3bc@iotcl.com>
 <20250716133518.1788126-5-toon@iotcl.com> <xmqqldooazig.fsf@gitster.g>
Date: Thu, 17 Jul 2025 18:31:28 +0200
Message-ID: <87v7nqixsv.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Junio C Hamano <gitster@pobox.com> writes:

> Toon Claes <toon@iotcl.com> writes:
>
>> +OUTPUT
>> +------
>> +
>> +The default format prints for each path:
>> +
>> +	<oid> TAB <path> LF
>> +
>> +When the commit is at boundary, it's prefixed with a caret `^`.
>> +
>> +Or when option `-z` is given:
>> +
>> +	<oid> TAB <path> NUL
>> +
>> +When `--extended` is provided, the output will be in the format:
>> +
>> +	path SP <path> LF
>> +	commit SP <oid> LF
>> +	tree SP <tree> LF
>> +	parent SP <parent> LF
>> +	author SP <author> LF
>> +	    <message>
>> +
>> +Each line of the commit message is indented with four spaces.
>> +
>> +Unless together with `--extended` option `-z` is given, then the output is:
>
> "If" would probably have been more readable.
>
> I can see why you wrote "Unless" here, i.e.
>
>     We indent by four spaces.
>     Unless you use "-z" and "--extended" together, that is.
>
> but I do not think it is a good idea to use such a construct here.
> The reason why I do not think you want to phrase it that way is
> because the next block that illustrates what happens when "-z" and
> "--extended" are used together has more differences than just a mere
> "is the message indented?" single bit.  Unlike "--extended" without
> "-z" that uniformly use LF as inter-item separator, some items are
> NUL terminated while others are LF terminated.
>
>> +	path SP <path> NUL
>> +	commit SP <oid> LF
>> +	tree SP <tree> LF
>> +	parent SP <parent> LF
>> +	author SP <author> LF
>> +	<message>
>> +
>> +In this situation the commit message is not indented.
>> +
>> +A path containing SP or special characters is enclosed in double-quotes in the C
>> +style as needed, unless option `-z` is provided.
>
> Another thing I find the above output description somewhat lacking
> is that, while it is clear how each output entry ends when
> "--extended" is not given (i.e. it shows what terminates each output
> entry.  The output is one entry per path and either LF or NUL
> terminates an entry), the description of "--extended", with or
> without "-z" is silent about how the reader program is expected to
> notice when the message ends.
>
> Without "-z" and indented, the end of the <message> part if either
> EOF or any unindented line, whichever comes earlier, I presume?

That's the idea.

> I
> am planning to teach pretty_print_commit() to stop indenting an
> empty line by 4 spaces, by the way---non-"-z" format needs to be
> designed to withstand such a change.

It kind of is. A new entry should start with "path " (no leading space).

> How would this extended format gain more fields in the future?  A
> free-text <message> has to be at the end?  What if we later need to
> add another free-text thing (e.g., notes ttached to the commit that
> is responsible for that latest state of the path)?

Ahha, you mean a future field that's multi-line? I assume we'd indent
those lines, but I agree it would make parsing harder.

> I suspect that
> you'd want an explicit tag (perhaps "message SP <message>") so that
> the log message does not have to be anything special among others.

The idea was to have the output compatible with the git-cat-file(1)
output. That would then no longe be the case. That's also why you see
mixed use of NUL and LF delimited fields in "-z" mode.

> In any case, the above considerations need to be documented.

Yeah, that's worth elaborating on.

> With "-z", a message body can begin with "path ", so you'd need to
> arrange some terminator (like NUL) after the message body anyway.

That should be the case, but it seems I missed that in the docs.

> Unless your format is "we tell about one path and then always exit",
> that is, but that is probably not what we want.
>
> Thanks.

Thanks for this feedback. I've submitted this patch on top mainly to
gather some feedback, and this is really valuable. I think in the next
version of this series I'm gonna leave out this patch because there are
too many loose ends, and I think in our product we can easily integrate
git-last-modified(1) if it only supports the single-line output format.

-- 
Cheers,
Toon
