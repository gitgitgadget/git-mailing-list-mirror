Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EB5A1AC895
	for <git@vger.kernel.org>; Tue, 24 Sep 2024 17:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727199916; cv=none; b=ZtJD4kHB+JLhEsMWzvKsY7A35DONbRW4ITVjhdxjXoyhiD1bf2CLHDRlxaJ7QDJYrMs27KUEAICbKjA42d7Igvo/ng89XeSQVLUl1uoj0ILkoEfOSmIgLoN2IBlrDLYmqQCeeyipVRZOIdvjK6UV6tGvadxhNy6WcTjcuoOIhbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727199916; c=relaxed/simple;
	bh=lx9D4CBxWbBfazUnktYBlElMKDIW8yr9VMc/dDPix0Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=u7gvreHYdu6n0pVGWgNJ9Nvm18KpA7sew7tEW54We01wGJQGXRYdB03UKQ6OoCudAX3fq/Qr540myTb4DXb438+nir2Yg5cbLAWAdwmZQO+xNeKx30HWRjXg0Do5ONm0Q7Ec9O9QjN9YDx1ZDn63UrhGdX9pG/4f+BIQvhUl5mE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=hgQ6hKw6; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="hgQ6hKw6"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id CBEA436D16;
	Tue, 24 Sep 2024 13:45:12 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=lx9D4CBxWbBfazUnktYBlElMKDIW8yr9VMc/dD
	Pix0Q=; b=hgQ6hKw6JKQ5g4s/auAk0Xd0gpDFxeFjRIclGKGaHwyzxLhC3gX8zK
	GvKAWF+/8pJ+1yNkWlHbavkps1Eh3VQgka+XT8yZIj1I65kKsZHFz9A8pjn5KRe8
	Nj065lT4N9EFWKHo1mvUuiFEiwV7dml3ZOHk4FQDyFCdi512uTMmg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C1CC136D15;
	Tue, 24 Sep 2024 13:45:12 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1242636D14;
	Tue, 24 Sep 2024 13:45:12 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: shejialuo <shejialuo@gmail.com>
Cc: John Cai via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  John Cai <johncai86@gmail.com>
Subject: Re: [PATCH 1/4] git: pass in repo for RUN_SETUP_GENTLY
In-Reply-To: <ZvLZqIe8rpGZTU0C@ArchLinux> (shejialuo@gmail.com's message of
	"Tue, 24 Sep 2024 23:24:24 +0800")
References: <pull.1788.git.git.1727185364.gitgitgadget@gmail.com>
	<eceb2d835be7168081d6eeffbce57bba89b5f423.1727185364.git.gitgitgadget@gmail.com>
	<ZvLZqIe8rpGZTU0C@ArchLinux>
Date: Tue, 24 Sep 2024 10:45:10 -0700
Message-ID: <xmqqr099t07t.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 BFAB5AE6-7A9C-11EF-A1A1-2BAEEB2EC81B-77302942!pb-smtp1.pobox.com

shejialuo <shejialuo@gmail.com> writes:

> On Tue, Sep 24, 2024 at 01:42:41PM +0000, John Cai via GitGitGadget wrote:
>
> [snip]
>
>> diff --git a/git.c b/git.c
>> index 2fbea24ec92..e31b52dcc50 100644
>> --- a/git.c
>> +++ b/git.c
>> @@ -480,7 +480,10 @@ static int run_builtin(struct cmd_struct *p, int argc, const char **argv, struct
>>  	trace2_cmd_name(p->cmd);
>
> This line is a little long, we may clean this in this patch.
>
>>  
>>  	validate_cache_entries(repo->index);
>> -	status = p->fn(argc, argv, prefix, (p->option & RUN_SETUP)? repo : NULL);
>> +	status = p->fn(argc,
>> +		       argv,
>> +		       prefix,
>> +		       ((p->option & RUN_SETUP) || (p->option & RUN_SETUP_GENTLY))? repo : NULL);
>
> This reads so strange, could we create a new variable here?
>
> Small problems, don't worth a reroll.

If it is so annoying to make your reading hiccup, it is not small at
all.  One argument per line is so strange, and one plausible fix
would be

	status = p->fn(argc, argv, prefix,
        	       (p->option & (RUN_SETUP|RUN_SETUP_GENTLY))
		       ? repo : NULL);

Thanks.
