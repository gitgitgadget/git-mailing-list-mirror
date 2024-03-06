Received: from mail-gateway-shared03.cyon.net (mail-gateway-shared03.cyon.net [194.126.200.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC27B2FB2
	for <git@vger.kernel.org>; Wed,  6 Mar 2024 21:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.126.200.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709759021; cv=none; b=LgT1lDY8mETfZguY/vMsuiRFkWrwLp8wTAUjQUl9RvUQx/teJL8aXGryzgHItKe+Oc/tqmBRQCLk6lhLNBtZyE4HGrVvYlazbmC/JA9m5QCJ7a10bvoHz2U9mqCogMWfzhb5LM3fSQVXCspgnfJlGDhgbW5kYotqOh6WKOk2tuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709759021; c=relaxed/simple;
	bh=EhyOo5N5QhawrPQo4HW4BEdikJ0dOor8dkm0CWna+Rs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iV5LhwXEQwy8Q5NoHyhgBmzQzwANnepux9jFAYGNvfEC/RY2kR4M4LK4+atrjwzGxa3TmjS+q4LhT6g2306m+EtztIaZabaTt6W/H1P7ogT61vH6EGEsSgU90HxLdTDnGxhNRaXk3jHiFBv0rmzBcOPUzcY6kteLyINEbcZTfi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=drbeat.li; spf=pass smtp.mailfrom=drbeat.li; arc=none smtp.client-ip=194.126.200.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=drbeat.li
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=drbeat.li
Received: from s019.cyon.net ([149.126.4.28])
	by mail-gateway-shared03.cyon.net with esmtpsa (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
	(Exim)
	(envelope-from <dev+git@drbeat.li>)
	id 1rhyLb-000000000A3-1lHo
	for git@vger.kernel.org;
	Wed, 06 Mar 2024 21:58:43 +0100
Received: from [10.20.10.231] (port=12664 helo=mail.cyon.ch)
	by s019.cyon.net with esmtpa (Exim 4.96.2)
	(envelope-from <dev+git@drbeat.li>)
	id 1rhyLa-006ZaS-0w;
	Wed, 06 Mar 2024 21:58:42 +0100
Message-ID: <b7cfeb02-eab6-4822-921f-89a00a66e4b0@drbeat.li>
Date: Wed, 6 Mar 2024 21:58:41 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/22] t/t4*: avoid redundant uses of cat
To: Eric Sunshine <sunshine@sunshineco.com>, Beat Bolli <bb@drbeat.li>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
References: <20240305212533.12947-1-dev+git@drbeat.li>
 <20240305212533.12947-10-dev+git@drbeat.li>
 <CAPig+cQ13SANfReDNxVRPmS2TbK+0ZU4mT6g1rw9kWJHzH-j2w@mail.gmail.com>
Content-Language: de-CH
From: Beat Bolli <dev+git@drbeat.li>
In-Reply-To: <CAPig+cQ13SANfReDNxVRPmS2TbK+0ZU4mT6g1rw9kWJHzH-j2w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - s019.cyon.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - drbeat.li
X-Get-Message-Sender-Via: s019.cyon.net: authenticated_id: ig@drbeat.li
X-Authenticated-Sender: s019.cyon.net: ig@drbeat.li

On 06.03.24 02:08, Eric Sunshine wrote:
> On Tue, Mar 5, 2024 at 4:31 PM Beat Bolli <bb@drbeat.li> wrote:
>> diff --git a/t/t4020-diff-external.sh b/t/t4020-diff-external.sh
>> @@ -232,7 +232,7 @@ keep_only_cr () {
>>   test_expect_success 'external diff with autocrlf = true' '
>>          test_config core.autocrlf true &&
>>          GIT_EXTERNAL_DIFF=./fake-diff.sh git diff &&
>> -       test $(wc -l < crlfed.txt) = $(cat crlfed.txt | keep_only_cr | wc -c)
>> +       test $(wc -l < crlfed.txt) = $(keep_only_cr <crlfed.txt | wc -c)
>>   '
> 
> Could also fix the style problem (drop whitespace after existing `<`
> operator) while here, but not at all worth a reroll.
> 
>> diff --git a/t/t4150-am.sh b/t/t4150-am.sh
>> @@ -786,7 +786,7 @@ test_expect_success 'am takes patches from a Pine mailbox' '
>>          git checkout first &&
>> -       cat pine patch1 | git am &&
>> +       git am pine patch1 &&
> 
> As with Junio, the semantic change made here concerned me.

I was even more on the fence about this hunk than the others, but then 
the test was about 'am takes patches from a Pine mailbox', not 
specifically about reading a Pine mailbox from stdin. But I can drop 
this hunk in v2.

Cheers, Beat
