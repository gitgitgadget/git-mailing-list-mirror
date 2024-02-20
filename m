Received: from siwi.pair.com (siwi.pair.com [209.68.5.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAB0637142
	for <git@vger.kernel.org>; Tue, 20 Feb 2024 17:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.68.5.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708450821; cv=none; b=iSVsZPwEe+eHYNdwlV1ybc/N14y/gf0qYyhAHjFR6LUKyAjVGadb4cwSyB5MnsRlqDTeuKkneAgP0iKRAkqPzg2Q3YxxgNT67Mv1MWdn+DqueBYbMt5+crcGS4Yx72KWFbhuiUf8PyZ9C+WbZ5wqLg9nSrBQR7efPCmUACTvc4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708450821; c=relaxed/simple;
	bh=U1DmFBEZ76skUTrGbbcQBanJSgcVZ7BUTQLSW34JbvU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=om7Mf/Byg0yTi0uNs2AMhYLIdGjxiNzgO7gshWF49G12zo27ABu2nR8w8HOh3EepTiqu+t4aXWuje2EwEr+zOXGw8qbChf3cExchPzAqP308Id5aueX0YD0JzBQcyAz8R7ZPO6be3KXO93oRU8ao7w6Uiv6RGPNbqzCHbrzV5Yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jeffhostetler.com; spf=fail smtp.mailfrom=jeffhostetler.com; arc=none smtp.client-ip=209.68.5.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jeffhostetler.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=jeffhostetler.com
Received: from siwi.pair.com (localhost [127.0.0.1])
	by siwi.pair.com (Postfix) with ESMTP id 6369ACA1258;
	Tue, 20 Feb 2024 12:35:00 -0500 (EST)
Received: from [IPV6:2600:1700:840:e768:61e9:e43c:2400:ab1c] (unknown [IPv6:2600:1700:840:e768:61e9:e43c:2400:ab1c])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by siwi.pair.com (Postfix) with ESMTPSA id 27FCACC83B3;
	Tue, 20 Feb 2024 12:35:00 -0500 (EST)
Message-ID: <d40fada8-a3b6-1f41-2ce6-e0813f6ed26e@jeffhostetler.com>
Date: Tue, 20 Feb 2024 12:34:59 -0500
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH 01/12] sparse-index: pass string length to
 index_file_exists()
Content-Language: en-US
To: Junio C Hamano <gitster@pobox.com>,
 Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Jeff Hostetler <jeffhostetler@github.com>
References: <pull.1662.git.1707857541.gitgitgadget@gmail.com>
 <6f81e2e30609c70d4dcdbe9d4f11c4f6b5173c77.1707857541.git.gitgitgadget@gmail.com>
 <xmqqzfw410j8.fsf@gitster.g>
From: Jeff Hostetler <git@jeffhostetler.com>
In-Reply-To: <xmqqzfw410j8.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: mailmunge 3.11 on 209.68.5.199



On 2/13/24 5:07 PM, Junio C Hamano wrote:
> "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> From: Jeff Hostetler <jeffhostetler@github.com>
>>
>> The call to index_file_exists() in the loop in expand_to_path() passes
>> the wrong string length.  Let's fix that.
>>
>> The loop in expand_to_path() searches the name-hash for each
>> sub-directory prefix in the provided pathname. That is, by searching
>> for "dir1/" then "dir1/dir2/" then "dir1/dir2/dir3/" and so on until
>> it finds a cache-entry representing a sparse directory.
>>
>> The code creates "strbuf path_mutable" to contain the working pathname
>> and modifies the buffer in-place by temporarily replacing the character
>> following each successive "/" with NUL for the duration of the call to
>> index_file_exists().
>>
>> It does not update the strbuf.len during this substitution.
>>
>> Pass the patched length of the prefix path instead.
>>
>> Signed-off-by: Jeff Hostetler <jeffhostetler@github.com>
>> ---
> 
> This looked familiar, and it turns out that
> 
> https://lore.kernel.org/git/pull.1649.git.1706897095273.gitgitgadget@gmail.com/
> 
> has already been merged to 'master'.
> 
> 

Great, thanks!  I'll drop from the next version.

