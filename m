Received: from siwi.pair.com (siwi.pair.com [209.68.5.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC66344C94
	for <git@vger.kernel.org>; Tue, 20 Feb 2024 19:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.68.5.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708456241; cv=none; b=ReyYIisk1QOSrjzMH8Nd46RmtQ26rZtobkpxEpefWOAq0K7Qu172FcfYIwCwyvoHlzgSptAfKcyF+tCLfVJb0rL5e6Y9wDniVi5Il6ca9wu5FZrjLyhwb4xkjM+tE9POxGhA+lN+Nketjv5bnBOlXypq6NPq0hfZ62DfvYcv74E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708456241; c=relaxed/simple;
	bh=n62kom2KSkI4eZoxdlYGKJ+U8kvzzDCdD31myM186d4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JIz0rw253YclPh9NFMhnN2DmfWQCKumKLG2FL14uXLuV/ciHcmphnidmhQBJ8e36hPC1juL+U6xEquebWgL0RlU4CdLQeC3UAiS1G2kVfSY7O8hw7gLp248P+fHIveRsYPqeY3TlDpZE+HxBB4f+z8NVbaoT7Ovjs0dG3GMrS0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jeffhostetler.com; spf=fail smtp.mailfrom=jeffhostetler.com; arc=none smtp.client-ip=209.68.5.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jeffhostetler.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=jeffhostetler.com
Received: from siwi.pair.com (localhost [127.0.0.1])
	by siwi.pair.com (Postfix) with ESMTP id CD04CCA1256;
	Tue, 20 Feb 2024 14:10:38 -0500 (EST)
Received: from [IPV6:2600:1700:840:e768:61e9:e43c:2400:ab1c] (unknown [IPv6:2600:1700:840:e768:61e9:e43c:2400:ab1c])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by siwi.pair.com (Postfix) with ESMTPSA id 914EACC83B5;
	Tue, 20 Feb 2024 14:10:38 -0500 (EST)
Message-ID: <3ffd638e-d2e1-ab39-e44f-84d2c58d8126@jeffhostetler.com>
Date: Tue, 20 Feb 2024 14:10:38 -0500
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH 06/12] fsmonitor: clarify handling of directory events in
 callback
Content-Language: en-US
To: Patrick Steinhardt <ps@pks.im>,
 Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Jeff Hostetler <jeffhostetler@github.com>
References: <pull.1662.git.1707857541.gitgitgadget@gmail.com>
 <5b6f8bd1fe7b6c742b25a5a1ed95b528f352215e.1707857541.git.gitgitgadget@gmail.com>
 <Zc3aKSR53Ew4ImMP@tanuki>
From: Jeff Hostetler <git@jeffhostetler.com>
In-Reply-To: <Zc3aKSR53Ew4ImMP@tanuki>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: mailmunge 3.11 on 209.68.5.199



On 2/15/24 4:32 AM, Patrick Steinhardt wrote:
> On Tue, Feb 13, 2024 at 08:52:15PM +0000, Jeff Hostetler via GitGitGadget wrote:
>> From: Jeff Hostetler <jeffhostetler@github.com>
>>
>> Signed-off-by: Jeff Hostetler <jeffhostetler@github.com>
>> ---
>>   fsmonitor.c | 47 +++++++++++++++++++++++++++++++++--------------
>>   1 file changed, 33 insertions(+), 14 deletions(-)
>>
>> diff --git a/fsmonitor.c b/fsmonitor.c
>> index 614270fa5e8..754fe20cfd0 100644
>> --- a/fsmonitor.c
>> +++ b/fsmonitor.c
>> @@ -219,24 +219,40 @@ static void fsmonitor_refresh_callback_unqualified(
...
>> +static int fsmonitor_refresh_callback_slash(
>>   	struct index_state *istate, const char *name, int len, int pos)
>>   {
>>   	int i;
>> +	int nr_in_cone = 0;
> 
> Should we return `size_t` instead of `int`?
> 
> Patrick

yeah, I can fix all of the return values to be 'size_t' since
that is new functionality and not colliding with the existing
usages for 'i' and 'pos' that I mentioned in a response on a
previous thread.

Thanks
Jeff

