Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DAF8248886
	for <git@vger.kernel.org>; Fri, 28 Nov 2025 18:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764355936; cv=none; b=O328OqnDTdZ8GvIcqI3bAXkN3bKlUcYZESshnv57ubx/yYYyHReWeyL6j6J6Kq7tt+RTPq/47hma8bQNbnf8iD47bR8lAV6/tfAfZemggk8ek90QPC7aDYcEosfqOuZN6D7WxXY1L4dTu8SV4MVCixAFjOq7JDQZST7F7LvL6fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764355936; c=relaxed/simple;
	bh=ymag+YrqTdK8y0dgFp8sqD3w7qsiUCmiMAI3LAlnHfA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=o2ocFj6HunDtgRzKGuARWAYIVZDfsYJ8u/PIzlD4aHV/iCiFMnLMir5NqVSRubIT9rk7hcs9pte1SIQc6Doim+hcGXZOBcdl67L6nol+fA8eC0XTHgHq8KCDN8ZEZgPQ/j9A4u/DJP4uqQsnUNA/QbuxrRfNh4gLG8Y7xcVAcd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=m7U9zyMT; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="m7U9zyMT"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1764355931;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=re7ao9XlBdUhZMCQ3ljL0k8nIGuH617pg6Z9UFO2DaY=;
	b=m7U9zyMThhVZ4HLsVYD+PhT/Nz8X4eTTXzYlTvKvAd9WpZMWpn33kcA/MIb+DSis6Kl68u
	JKriVN4abUNgWizmgXx1SLSEH/jDSCkrVUH6Ac+AFzzurbmtTe7yudV/8wO3VCPJoNA5K1
	NURgXDRVJlKuPd/PVeiGCBwajHE8UYo=
From: Toon Claes <toon@iotcl.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/3] last-modified: document option --max-depth
In-Reply-To: <xmqqldjsmv5p.fsf@gitster.g>
References: <20251126-toon-last-modified-zzzz-v1-0-608350df0caa@iotcl.com>
 <20251126-toon-last-modified-zzzz-v1-2-608350df0caa@iotcl.com>
 <xmqqldjsmv5p.fsf@gitster.g>
Date: Fri, 28 Nov 2025 19:51:51 +0100
Message-ID: <87qzti0z3s.fsf@iotcl.com>
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
>> Option --max-depth is supported by git-last-modified(1), because it was
>> added to the diff machinery in a1dfa5448d (diff: teach tree-diff a
>> max-depth parameter, 2025-08-07).
>>
>> This option is useful for everyday use of the git-last-modified(1)
>> command, so document it's existence in the man page and `-h` output.
>>
>> Signed-off-by: Toon Claes <toon@iotcl.com>
>> ---
>>  Documentation/git-last-modified.adoc |  9 ++++++++-
>>  builtin/last-modified.c              | 12 +++++++++++-
>>  2 files changed, 19 insertions(+), 2 deletions(-)
>
> Does this step pass t0450?
>
>     fixup! last-modified: document option --max-depth
>
> diff --git a/builtin/last-modified.c b/builtin/last-modified.c
> index ccb7ff66d4..857554e70d 100644
> --- a/builtin/last-modified.c
> +++ b/builtin/last-modified.c
> @@ -523,8 +523,8 @@ int cmd_last_modified(int argc, const char **argv, const char *prefix,
>  	struct last_modified lm = LAST_MODIFIED_INIT;
>  
>  	const char * const last_modified_usage[] = {
> -		N_("git last-modified [--recursive] [--show-trees] [--max-depth=<depth>] [-z] "
> -		   "[<revision-range>] [[--] <path>...]"),
> +		N_("git last-modified [--recursive] [--show-trees] [--max-depth=<depth>] [-z]\n"
> +		   "    [<revision-range>] [[--] <path>...]"),
>  		NULL
>  	};

Derp, I should have checked that. I knew it could be a problem, but by
the time I was about to send the patch I forgot. Sorry about that.

-- 
Cheers,
Toon
