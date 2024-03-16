Received: from mail-gateway-shared03.cyon.net (mail-gateway-shared03.cyon.net [194.126.200.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3DD6EAE5
	for <git@vger.kernel.org>; Sat, 16 Mar 2024 10:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.126.200.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710583795; cv=none; b=jDePRbgudylaxLoRk/PRdwMw4LOHjBPfTLAvBa+c8SelD4AjiyCHX9bc55+CwFAlBSolqglaP9Ic+WCnKIZOn8x316OoJvR3hpR8jOpbZqSoOjr2AbDdDvnUzIfsi75nr7ExLiF4Uq7aT6jbPeX9B44utKRWeEBr/HK0+LLNWnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710583795; c=relaxed/simple;
	bh=r7o7ncGHrkkTrdkAOZP8rMrFGRFjvwxWGuBZFgqZ3ZY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tV+8rsj5M14YXbhBDexDKSBUaKfJirBKdJy3kwVr7qHaxDtv4XEqjJ1fo2BW5J6Bo+MfF6Gbl36oJC3XbxZUcWnCpm5i7j085+8/oFss35oQFeP537BWY4PVbUlMlpoW++HAH2TQ1kGVFuHMDVvMHUQl/QFTMMmMcj8ZKGNOlhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=drbeat.li; spf=pass smtp.mailfrom=drbeat.li; arc=none smtp.client-ip=194.126.200.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=drbeat.li
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=drbeat.li
Received: from s019.cyon.net ([149.126.4.28])
	by mail-gateway-shared03.cyon.net with esmtpsa (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
	(Exim)
	(envelope-from <dev+git@drbeat.li>)
	id 1rlQz6-000000001fA-3YNm
	for git@vger.kernel.org;
	Sat, 16 Mar 2024 11:09:49 +0100
Received: from [10.20.10.230] (port=59148 helo=mail.cyon.ch)
	by s019.cyon.net with esmtpa (Exim 4.96.2)
	(envelope-from <dev+git@drbeat.li>)
	id 1rlQz5-00C6fu-2N;
	Sat, 16 Mar 2024 11:09:47 +0100
Message-ID: <5aacb015-c01a-4c6f-8e37-931581aa71b6@drbeat.li>
Date: Sat, 16 Mar 2024 11:09:47 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 16/22] t/t3*: merge a "grep | awk" pipeline
Content-Language: de-CH
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
References: <20240305212533.12947-1-dev+git@drbeat.li>
 <20240315194620.10713-1-dev+git@drbeat.li>
 <20240315194620.10713-17-dev+git@drbeat.li> <ZfT6xxBnQs6ppYB2@nand.local>
From: Beat Bolli <dev+git@drbeat.li>
In-Reply-To: <ZfT6xxBnQs6ppYB2@nand.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - s019.cyon.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - drbeat.li
X-Get-Message-Sender-Via: s019.cyon.net: authenticated_id: ig@drbeat.li
X-Authenticated-Sender: s019.cyon.net: ig@drbeat.li

On 16.03.24 02:49, Taylor Blau wrote:
> On Fri, Mar 15, 2024 at 08:46:13PM +0100, Beat Bolli wrote:
>> Signed-off-by: Beat Bolli <dev+git@drbeat.li>
>> ---
>>   t/t3920-crlf-messages.sh | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/t/t3920-crlf-messages.sh b/t/t3920-crlf-messages.sh
>> index 5eed640a6825..50ae222f0842 100755
>> --- a/t/t3920-crlf-messages.sh
>> +++ b/t/t3920-crlf-messages.sh
>> @@ -97,7 +97,7 @@ test_expect_success 'branch: --verbose works with messages using CRLF' '
>>   	git branch -v >tmp &&
>>   	# Remove first two columns, and the line for the currently checked out branch
>>   	current=$(git branch --show-current) &&
>> -	grep -v $current <tmp | awk "{\$1=\$2=\"\"}1"  >actual &&
>> +	awk "/$current/ { next } { \$1 = \$2 = \"\" } 1" <tmp >actual &&
> 
> I think that using `next` here is fine to ignore lines that match
> `$current`, but the canonical approach would probably be using the
> `!` operator instead to negate the match, like so:
> 
>      awk "!/$current/ { \$1 = \$2 = \"\" } 1" <tmp >actual &&
> 
> Not worth a reroll, of course, just something that I noticed while
> reading.

Except it's not the same :-) This was actually my first try, but then I 
realized that awk continues to evaluate patterns and actions until the 
end of the script. The "1" at the end is the "always true" pattern that 
causes the default action "print $0" to run.

So the "next" is needed to discard the current line.

Having said this,

     awk "!/$current/ { \$1 = \$2 = \"\"; print \$0 }" <tmp >actual &&

would work, and it would also remove the obscure flow detailed above.


Regards, Beat
