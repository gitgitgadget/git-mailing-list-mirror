Received: from siwi.pair.com (siwi.pair.com [209.68.5.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60200132461
	for <git@vger.kernel.org>; Mon, 26 Feb 2024 17:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.68.5.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708967562; cv=none; b=RpiH+G3mt+FPuuZ4ZVN5SgdRrZwjJuhUQx92off3HWKShyfXMK3wE/DXaKxB5kwA3kcd9ll9MxJjRI4TrdcmfyvM35rVuwbzUkf5RTp7Voe4/eATbq2gKUxXYSFyccvZLhLLUlO+z/lq94b146ZmvE4IImbGg+V57pk53NhLE94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708967562; c=relaxed/simple;
	bh=nxW1Q58Gn/oNvmKL+QRhpCbLRcR4ENUEulOU8j53Wqk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d16TrlDN7l4m8BUDFBmWmq8w54ssAGNuGXyG9fQhCUOk/xcZJmoc9BHcKPCy2Fs6BOIBRfSP+6BOMF2Cd5RNSXyRrDiS95eHG6mOZgtqneDNNtZzNM7xkRj8uRtWzCUfYtPv4evwtCGOB8uauen3eXI8YcIpGbuyNXEKprCNHdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jeffhostetler.com; spf=fail smtp.mailfrom=jeffhostetler.com; arc=none smtp.client-ip=209.68.5.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jeffhostetler.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=jeffhostetler.com
Received: from siwi.pair.com (localhost [127.0.0.1])
	by siwi.pair.com (Postfix) with ESMTP id 39243CA1291;
	Mon, 26 Feb 2024 12:12:32 -0500 (EST)
Received: from [IPV6:2600:1700:840:e768:b846:2f3e:cac1:b0eb] (unknown [IPv6:2600:1700:840:e768:b846:2f3e:cac1:b0eb])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by siwi.pair.com (Postfix) with ESMTPSA id EBED0CC83B7;
	Mon, 26 Feb 2024 12:12:31 -0500 (EST)
Message-ID: <e622183b-23ce-3aad-0918-9690d9ba4d56@jeffhostetler.com>
Date: Mon, 26 Feb 2024 12:12:31 -0500
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH v2 03/16] t7527: temporarily disable case-insensitive
 tests
Content-Language: en-US
To: Junio C Hamano <gitster@pobox.com>,
 Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>,
 Jeff Hostetler <jeffhostetler@github.com>
References: <pull.1662.git.1707857541.gitgitgadget@gmail.com>
 <pull.1662.v2.git.1708658300.gitgitgadget@gmail.com>
 <dad079ade7f8817f235d59c5339b82aecf4a17db.1708658300.git.gitgitgadget@gmail.com>
 <xmqqh6hz1tmx.fsf@gitster.g>
From: Jeff Hostetler <git@jeffhostetler.com>
In-Reply-To: <xmqqh6hz1tmx.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: mailmunge 3.11 on 209.68.5.199



On 2/23/24 3:17 AM, Junio C Hamano wrote:
> "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> From: Jeff Hostetler <jeffhostetler@github.com>
>>
>> Add non-existent "SKIPME" prereq to the case-insensitive tests.
>>
>> The previous commit added test cases to demonstrate an error where
>> FSMonitor can get confused on a case-insensitive file system when the
>> on-disk spelling of a file or directory is wrong.  Let's disable those
>> tests before we incrementally teach Git to properly recognize and
>> handle those types of problems (so that a bisect between here and the
>> final commit in this patch series won't throw a false alarm).
> 
> You talk about bisection, but hasn't the previous step already
> broken bisection without these SKIPME prerequisites?  IOW, shouldn't
> this step squashed into the previous?
> 
> Also, it is much more common to replace "test_expect_success" with
> "test_expect_failure" to indicate that the steps are broken.  Was
> there a reason why we choose to do it differently?

In step 2 I created test with individual step failures baked into
the "! grep -q" steps in the bottom of each test.  I didn't want a
failure in the 50-60 lines of setup code to cause a false alarm.
So the step 2 test "succeeds" by detecting that the output is
incomplete/wrong.

I wanted to use a "test_must_fail" on those individual grep lines
rather than a negated grep, but something complained about that
function only worked on "git" commands.

I added the SKIPME here in step 3 so that I could fix the series
in small steps and without worrying about which of the small steps
caused the file or directory case to stop being broken (which might
cause confusion if someone were bisecting in this part of the history.

Let me try again with the normal "test_expect_failure" in step 2,
drop step 3, and smash step 16 into step 14.  With the rearranging
that I did in V2, both directories and files should be fixed in the
same final step -- rather than in separate steps.

Thanks
Jeff


> 
>> Signed-off-by: Jeff Hostetler <jeffhostetler@github.com>
>> ---
>>   t/t7527-builtin-fsmonitor.sh | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/t/t7527-builtin-fsmonitor.sh b/t/t7527-builtin-fsmonitor.sh
>> index 3d21295f789..4acb547819c 100755
>> --- a/t/t7527-builtin-fsmonitor.sh
>> +++ b/t/t7527-builtin-fsmonitor.sh
>> @@ -1051,7 +1051,7 @@ test_expect_success 'split-index and FSMonitor work well together' '
>>   #
>>   # The setup is a little contrived.
>>   #
>> -test_expect_success CASE_INSENSITIVE_FS 'fsmonitor subdir case wrong on disk' '
>> +test_expect_success SKIPME,CASE_INSENSITIVE_FS 'fsmonitor subdir case wrong on disk' '
>>   	test_when_finished "stop_daemon_delete_repo subdir_case_wrong" &&
>>   
>>   	git init subdir_case_wrong &&
>> @@ -1128,7 +1128,7 @@ test_expect_success CASE_INSENSITIVE_FS 'fsmonitor subdir case wrong on disk' '
>>   	! grep -q " M dir1/dir2/dir3/file3" "$PWD/subdir_case_wrong.out"
>>   '
>>   
>> -test_expect_success CASE_INSENSITIVE_FS 'fsmonitor file case wrong on disk' '
>> +test_expect_success SKIPME,CASE_INSENSITIVE_FS 'fsmonitor file case wrong on disk' '
>>   	test_when_finished "stop_daemon_delete_repo file_case_wrong" &&
>>   
>>   	git init file_case_wrong &&
