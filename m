Received: from siwi.pair.com (siwi.pair.com [209.68.5.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 255C31BC35
	for <git@vger.kernel.org>; Wed,  6 Mar 2024 22:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.68.5.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709765680; cv=none; b=DXhdqZEWw0OhuM+4P4353pQSMHKRkrjUMURorxdIRQSHNllPGA43025GKti1GHtYvan3XvgtjosSy697Kk9lbrusD/dYnNFgcWAXCFIG07/9wtbItW2nz+rykAjt78beiEWTt+xJ4WCmTXNf+lCZF2b8VnoP2n/HqPxHD0UEz+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709765680; c=relaxed/simple;
	bh=gLd1nPPMWevGMhMYoNdKgRGlUPtWYJqy/rhkv1xsbSE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YV7/D6C0VbYf1FAgmk+F5lQieYl/a+7i91lLvlBfcgew6oZQzJQrPoMXr7w18LlKxFZoVVQM7W/AMQYGuzi3QSVNrohxcyD5Dq+Nppz3XQmJAJ0x9E3DcYa+hbs6QC+g7CPhwRpFTjDCN8WwPgHZwyDkcAZ9qKKd1BOUnR3Q4Yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jeffhostetler.com; spf=fail smtp.mailfrom=jeffhostetler.com; arc=none smtp.client-ip=209.68.5.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jeffhostetler.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=jeffhostetler.com
Received: from siwi.pair.com (localhost [127.0.0.1])
	by siwi.pair.com (Postfix) with ESMTP id D8702CA1263;
	Wed,  6 Mar 2024 17:54:36 -0500 (EST)
Received: from [IPV6:2600:1700:840:e768:5828:3c94:9fae:77dc] (unknown [IPv6:2600:1700:840:e768:5828:3c94:9fae:77dc])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by siwi.pair.com (Postfix) with ESMTPSA id 9C552CC83D0;
	Wed,  6 Mar 2024 17:54:36 -0500 (EST)
Message-ID: <f1c1847f-49fa-5573-55f4-7cca401df401@jeffhostetler.com>
Date: Wed, 6 Mar 2024 17:54:36 -0500
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH 4/4] trace2: remove unneeded calls to generate 'def_param'
 set
Content-Language: en-US
To: Junio C Hamano <gitster@pobox.com>, Josh Steadmon <steadmon@google.com>
Cc: Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org, Jeff Hostetler <jeffhostetler@github.com>
References: <pull.1679.git.1709566808.gitgitgadget@gmail.com>
 <e8528715ebf97c12622c2e73f914ab4228a0927c.1709566808.git.gitgitgadget@gmail.com>
 <ZejkVOVQBZhLVfHW@google.com> <xmqqwmqfowfo.fsf@gitster.g>
From: Jeff Hostetler <git@jeffhostetler.com>
In-Reply-To: <xmqqwmqfowfo.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: mailmunge 3.11 on 209.68.5.199



On 3/6/24 4:57 PM, Junio C Hamano wrote:
> Josh Steadmon <steadmon@google.com> writes:
> 
>> On 2024.03.04 15:40, Jeff Hostetler via GitGitGadget wrote:
>>> From: Jeff Hostetler <jeffhostetler@github.com>
>>>
>>> Now that "trace2_cmd_name()" implicitly calls "trace2_cmd_list_config()"
>>> and "trace2_cmd_list_env_vars()", we don't need to explicitly call them.
>>>
>>> Signed-off-by: Jeff Hostetler <jeffhostetler@github.com>
>>> ---
>>>   git.c | 6 ------
>>>   1 file changed, 6 deletions(-)
>>>
>>> diff --git a/git.c b/git.c
>>> index 7068a184b0a..a769d72ab8f 100644
>>> --- a/git.c
>>> +++ b/git.c
>>> @@ -373,8 +373,6 @@ static int handle_alias(int *argcp, const char ***argv)
>>>   			strvec_pushv(&child.args, (*argv) + 1);
>>>   
>>>   			trace2_cmd_alias(alias_command, child.args.v);
>>> -			trace2_cmd_list_config();
>>> -			trace2_cmd_list_env_vars();
>>>   			trace2_cmd_name("_run_shell_alias_");
>>>   
>>>   			ret = run_command(&child);
>>> @@ -411,8 +409,6 @@ static int handle_alias(int *argcp, const char ***argv)
>>>   		COPY_ARRAY(new_argv + count, *argv + 1, *argcp);
>>>   
>>>   		trace2_cmd_alias(alias_command, new_argv);
>>> -		trace2_cmd_list_config();
>>> -		trace2_cmd_list_env_vars();
>>>   
>>>   		*argv = new_argv;
>>>   		*argcp += count - 1;
>>> @@ -462,8 +458,6 @@ static int run_builtin(struct cmd_struct *p, int argc, const char **argv)
>>>   
>>>   	trace_argv_printf(argv, "trace: built-in: git");
>>>   	trace2_cmd_name(p->cmd);
>>> -	trace2_cmd_list_config();
>>> -	trace2_cmd_list_env_vars();
>>>   
>>>   	validate_cache_entries(the_repository->index);
>>>   	status = p->fn(argc, argv, prefix);
>>> -- 
>>> gitgitgadget
>>>
>>
>> I'd personally prefer to see this squashed into Patch 3, but I don't
>> feel too strongly about it. Either way, the series LGTM.
>>
>> Reviewed-by: Josh Steadmon <steadmon@google.com>
> 
> Let's see what JeffH says about this.  I agree with you that making
> some stuff redundant in [Patch 3/4] and fixing the redundancy in
> this step does feel somewhat roundabout way of doing this.
> 
> Thanks.
> 

Sure we can merge them.  That's fine.  I can send a V4 or if you want
to just squash them together that's fine.

Jeff
