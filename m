Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F10076AB5
	for <git@vger.kernel.org>; Tue, 31 Oct 2023 04:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="HPvxrxIQ"
Received: from mail.manjaro.org (mail.manjaro.org [IPv6:2a01:4f8:c0c:51f3::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EBB19E
	for <git@vger.kernel.org>; Mon, 30 Oct 2023 21:54:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1698728071;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=muOZnwSShYJIiLPcGKHBKQqsgvB8BbMRtsaMNWBKic8=;
	b=HPvxrxIQ2+gxz9ATpWnwuotievwho5sIr8Cn3qZqgdLH9qLDSmS+o8pmjlF8lREunB243A
	PymUGuFH16TLKP098806gUOqNXXKBxsTK+0KcvZ0L4wrDrn+3mlkzD74Ek1uyHAL+5on/J
	ouBSCLNFhMCrCC5qcIx/TFTNUDCMxN3DcX8Js5t1ycRqx0a4KR8QdTdnHSYslMuxfnW35f
	bNNT7rsLiSFI2g3ey/rEACVg+zI+MM/DCqbTZOoUNzY+uHCsKy5iPpnkv2mkQNqj05Iaoq
	hBpEjb24m9ukGhsfdsN3zbUWf++NfCTLFG1aKXKIqmeZ0mGObYqbQQ5Oaltodg==
Date: Tue, 31 Oct 2023 05:54:31 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Junio C Hamano <gitster@pobox.com>
Cc: Hugo Sales <hugo@hsal.es>, git@vger.kernel.org, Derrick Stolee
 <derrickstolee@github.com>, Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
Subject: Re: [PATCH 0/3] Add `-p' option to `git-mv', inspired by `mkdir'
In-Reply-To: <xmqqlebj4dnt.fsf@gitster.g>
References: <20231009233458.1371351-1-hugo@hsal.es>
 <xmqq1qe3wbt1.fsf@gitster.g>
 <1384513657.119681.1697027599941@office.mailbox.org>
 <xmqqlebj4dnt.fsf@gitster.g>
Message-ID: <ffbb04b363938e4a487906134ce4f3c6@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2023-10-31 05:30, Junio C Hamano wrote:
> Hugo Sales <hugo@hsal.es> writes:
> 
>>> Both are plausible, and "mkdir -p" does not have such a nasty
>>> ambiguity.  That is what makes me unsure about the new feature
>>> (again, either with required "-p" or with implied "-p").
>> 
>> I think the ambiguity is resolved by the inclusion of lack thereof
>> of a trailing `/`.
> 
> The question is not if we can come up with a rule that the user can
> use to disambiguate.  It is if the user will find that such a rule
> is a naturally acceptable way to disambiguate.
> 
> When both of
> 
>     git mv file there/exists/such/a/directory
>     git mv file there/exists/such/a/directory/
> 
> create "there/exists/such/a/directory/file" and removes "file", with
> or without a trailing slash, "you should add a slash if you want a
> directory, and otherwise you should not add a slash" is a rather
> arbitrary rule.  Let's not go there.  I still view the downside more
> grave than having to occasionally do "mkdir".

Please note that the above-described git-mv operation succeeds with no 
trailing slash if "there/exists/such/a/directory" doesn't already exist 
as a directory, and creates "there/exists/such/a/directory" as a file.  
With the trailing slash, the git-mv operation succeeds only if 
"there/exists/such/a/directory" already exists as a directory, and fails 
otherwise.

A quite similar ambiguity exists in cp(1) in mv(1), which is also 
resolved by the use of the trailing slash character.  However, I've 
encountered only one person aware of that disambiguation, and in cp(1) 
only, but in the "I always include the trailing slash" way, without 
actually understanding it fully.  Maybe I need to encounter more people, 
I don't know.
