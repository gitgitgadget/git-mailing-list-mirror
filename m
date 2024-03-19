Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 445F744C9E
	for <git@vger.kernel.org>; Tue, 19 Mar 2024 05:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710827272; cv=none; b=jw+oUNdnxMg0FJx5R0dMn+ZpSUab8kwYJGogktWhG+1erET2SZXZRx84zGTei70aoMPzEfbgkhK1UE9MWnaKatmeRsJSGTR+bgbhrmxMi0YyobfFD5sFuWhht8P+whBH/NjIZsdd6NgeCxWY/4VVata6dD8+4Y5G8q9s4t1AgWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710827272; c=relaxed/simple;
	bh=lrDaXu7RMkuxzXs/Wzwz6USJ+Db1mCG819qHjGYFHMQ=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=G+D7LHfo69AgV3rrXX8TdfDrnKPeH6CjXDveLqscduPKAMUrhxEmJCW6zAoi4RlzGKSb1XXTiWHWXCDBSXmSYjqASLdg21t/FXZ7gl1Cl9qp45tEjn2TJ4GcDKmOOrVx1cdQLL2n8qMZZh6dM6oFCaky15AvuImYPYXNUsXFxkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=u4kG+5AD; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="u4kG+5AD"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1710827268;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7xheJV+sKuHHhhSL53jHML/qiTkoPNL+6HoP+FJMEtA=;
	b=u4kG+5ADRVaOM46Skqv+V7cGEm9/MSYJT5sB3pjZQUnNVl53rwWQU+6xWn9pRS52Z8Qdnc
	1XOoehP+m/mMUcGMI7RZnNYGKQCKzjGCJCZHX19daz5VsAbg7FtivdeKAzbaZsDSplhRNq
	Y8Azq5TRg3shq6xm6S8gi3Owo0VkFfauGk3Orm2T/+CINGqiMJ2Bd9M9DztP4Hiz4kqQZn
	edxsx7VV8Jkx8nAx8581HIgnThyxvRXLThl5mwNkOhZYLUHZ5Blnq7qdiGhLRc4tZXIm78
	Ee/Kvzoa4EZPQ4/YvPdM6tbCjiWRLHa7bKsPzkvm7jD2KgrUe9bB1x8xQZLPXA==
Date: Tue, 19 Mar 2024 06:47:48 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 4/5] grep: introduce new config option to include
 untracked files
In-Reply-To: <xmqqr0g7rqag.fsf@gitster.g>
References: <cover.1710781235.git.dsimic@manjaro.org>
 <9f70eeb4f04a874a2036e1d8c61f3b7ec130663a.1710781235.git.dsimic@manjaro.org>
 <xmqqr0g7rqag.fsf@gitster.g>
Message-ID: <923c5f84c44a195d6ba08503e28851af@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-03-19 01:58, Junio C Hamano wrote:
> Dragan Simic <dsimic@manjaro.org> writes:
>> Add new configuration option grep.includeUntracked that enables 
>> --untracked
>> option by default.  This pretty much follows the logic established by 
>> the
>> already existing configuration option grep.fallbackToNoIndex, while 
>> also
>> respecting the dependencies of the --untracked option.
>> 
>> Also add a few automated tests to the t7810, to cover the new 
>> configuration
> 
> Do we have any non-automated tests in t7810?

Good point, will be removed in the v2, if we get there.  Tying 
"automated"
to "test" is just an old habit of mine.

>> option by replicating the already existing tests for --untracked.
>> 
>> Signed-off-by: Dragan Simic <dsimic@manjaro.org>
>> ---
>>  builtin/grep.c  | 3 +++
>>  t/t7810-grep.sh | 9 +++++++++
>>  2 files changed, 12 insertions(+)
>> 
>> diff --git a/builtin/grep.c b/builtin/grep.c
>> index af89c8b5cb19..71d94126fb6e 100644
>> --- a/builtin/grep.c
>> +++ b/builtin/grep.c
>> @@ -1041,6 +1041,9 @@ int cmd_grep(int argc, const char **argv, const 
>> char *prefix)
>>  		the_repository->settings.command_requires_full_index = 0;
>>  	}
>> 
>> +	if (use_index && !cached)
>> +		git_config_get_bool("grep.includeuntracked", &untracked);
> 
> Can this ever return an error?  E.g.
> 
> 	[grep] includeuntracked = "not really"
> 
> How badly would setting this configuration variable break third
> party tools that assume their "git grep" invocation without the
> "--untracked" option would not yield hits from untracked files?

After a brief inspection of the code in cache.c, git_config_get_bool()
always returns either 0 or 1, so we should be fine.  Thus, any
strangeness in a configuration file would end up not enabling
this option.

As I already explained in my earlier response, [1] I think that
the usability of this option outweighs the possible issues it may
cause to some users.

[1] 
https://lore.kernel.org/git/c68a6d94bb02e5d9aa2f81bee022baa8@manjaro.org/
