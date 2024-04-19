Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FB7B130A7A
	for <git@vger.kernel.org>; Fri, 19 Apr 2024 16:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713542610; cv=none; b=fFpiUgudPRbOkmqEd7sllteWLT/5taUJHGd34A8IujvvZXzyNm5E7FJnJmdvD2Cj6nAJpwHYbZZjfqBIOO4VCjAB1Ymp469SEc2GS8rBA+62ciqee9rdNgGdqLpGLxSXKfSiz1tbvwsRmizLkYpo4BbvvzLg+pymfS1CXkTwuRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713542610; c=relaxed/simple;
	bh=3+x1NaS6pgr7dDcGTbg9/b5HBWiwh1hufOQOZh6FQa4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dEu+0VHgwV32bUyqdoO0SMhryFDW98ik/cIFhD3DW7K5J7XNui6/RFrOW5SS0DgG0dKH9CKZexifc9De/dyqvfwmkeupMQDqVoNm5CNX9o/aDeE6K3GqvEcI9Z9D1J6jCOIHh5VJMNxeo+mh2G4alSOEMavkHVUdg/oU/24yAig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=hy4747kU; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="hy4747kU"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 7B3361EEB83;
	Fri, 19 Apr 2024 12:03:22 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=3+x1NaS6pgr7dDcGTbg9/b5HBWiwh1hufOQOZh
	6FQa4=; b=hy4747kUPEAXiCe7DvnCosXgKimDPCfgXnxqUHyzrdR5HlFEVgU6dF
	FdAIk4y+KCgpb8IgqjS6hTmmoZ+Ay3iMGfP234FyyE56mOpNBoQIp9dCsqyNJH+o
	f0yr/+KnBx8yGZh9S3wavCntaZ57rIHx61Ki6SAcKvOE8lvSlmcck=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 701D41EEB82;
	Fri, 19 Apr 2024 12:03:22 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.229.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id CA25F1EEB80;
	Fri, 19 Apr 2024 12:03:21 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Eric Sunshine <sunshine@sunshineco.com>,  Johannes
 Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 1/2] for-each-repo: optionally keep going on an error
In-Reply-To: <ZiHyGFRPm_pwdGgC@tanuki> (Patrick Steinhardt's message of "Fri,
	19 Apr 2024 06:24:56 +0200")
References: <pull.1719.git.1713342535.gitgitgadget@gmail.com>
	<pull.1719.v2.git.1713444783.gitgitgadget@gmail.com>
	<abd796894c857fc9ad96b9942089474df01f0506.1713444783.git.gitgitgadget@gmail.com>
	<ZiHyGFRPm_pwdGgC@tanuki>
Date: Fri, 19 Apr 2024 09:03:20 -0700
Message-ID: <xmqqy199l4qf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 58698D9C-FE66-11EE-8300-25B3960A682E-77302942!pb-smtp2.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> On Thu, Apr 18, 2024 at 12:53:02PM +0000, Johannes Schindelin via GitGitGadget wrote:
>> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> [snip]
>> @@ -55,8 +58,9 @@ int cmd_for_each_repo(int argc, const char **argv, const char *prefix)
>>  	else if (err)
>>  		return 0;
>>  
>> -	for (i = 0; !result && i < values->nr; i++)
>> -		result = run_command_on_repo(values->items[i].string, argc, argv);
>> +	for (i = 0; (keep_going || !result) && i < values->nr; i++)
>> +		if (run_command_on_repo(values->items[i].string, argc, argv))
>> +			result = 1;
>
> One thing that made me stop and think is whether the change in behaviour
> here may negatively impact some usecases. Before this change we would
> error out with the return code returned by the command that we have ran
> in repositories. It makes total sense that we don't do that anymore with
> `--keep-going`, because the result would likely be useless as all we
> could do was to OR the result codes with each other.
>
> But do we maybe want to make this conditional on whether or not the
> `--keep-going` flag is set? So something like this:
>
> ```
> for (i = 0; (keep_going || !result) && i < values->nr; i++) {
> 	int ret = run_command_on_repo(values->items[i].string, argc, argv);
> 	if (ret)
> 		result = keep_going ? 1 : ret;
> }
> ```

You mean that it could be a regression that we lose the raw return
value from run_command_on_repo() when !keep_going?

 - git.c:handle_builtin() does exit(run_builtin(builtin, argc, argv));
   In this case, builtin is set to cmd_for_each_repo.

 - cmd_for_each_repo does "return result" at its end.

 - result comes from run_command_on_repo(), which returns the value
   returned by run_command().

 - run_command() returns -1 for "not found".

So if run_command() failed due to missing command, we would have
exited with 255 (= (unsigned)(-1) & 0xFF), but with this change we
would now exit with 1.

Passing anything outside 0..255 to exit(3) is a bad manners, and but
this does change behaviour.  Hmmm.




