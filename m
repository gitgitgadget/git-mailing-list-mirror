Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDDAC199B4
	for <git@vger.kernel.org>; Sat, 16 Mar 2024 16:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710607581; cv=none; b=e9WyZa1MUBuEagzazuz+u5dI9ASHRMLrX1vl+eA8s362Vx/rtBF2JpKghCge0rM0xfhP75MVVFpbszQtR9A+ViL7kPokX8QzIsephlHP0K5oCmDvjqkdHkPhEzQkk0qeXB6OGnNwepKwX3Wj+UNYWpQjmah3Ojzv5A4kTQSQLqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710607581; c=relaxed/simple;
	bh=uggq21kanaJ8rjJQTCV7wbHGOUH4qfamrCMyFwekQN8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IH5q5PaMu/F1nsJ4MitiH0dzlX41RZxrGlfZcWurdkPftMKHsMyM8/VKAuScuZpwiETShcXeIW+ha7vei8PAAQDNN4+/8NMcpsaAz79c1rB1LGg+6VV1odMjSuKgstLNe86vebih0tptH/GF25JAitU0jzbImStwkGt9UaemK48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iencinas.com; spf=pass smtp.mailfrom=iencinas.com; dkim=pass (2048-bit key) header.d=iencinas.com header.i=@iencinas.com header.b=wWIt725J; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iencinas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iencinas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iencinas.com header.i=@iencinas.com header.b="wWIt725J"
Message-ID: <f20a342c-d6e2-47da-95cf-b61d9dd282c8@iencinas.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iencinas.com;
	s=key1; t=1710607573;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eiwKRw27v7nk17Tck8kvMOW4WDhgbhtBj4rosiUrelE=;
	b=wWIt725JuAQQQj1Bp7bn25gc0a1552sgZf3RikrQJQL56feKQFWf4cMGU4LgbJa0e9gqND
	OfVNF7FJeSWCE1Xn0YIiIhgY31qOMKXjq15dTwzLC23KW1LJ6//3Mb8MmhMi32wA+A91ay
	Lo7gJdEywOaORWKePk+rtp2Y3t/fAk+xxcDB971An49mcROEycvpqtleOXkXDgVt5F0dhD
	hxtqvYzAJ/U6M6ZLUvbbEtqf9qbnE5K/pGt2lJ3Ot0Tc7i+enAxA1AkyEZKnEnfe5ioHTK
	PxS9Lyy/NyLroTLZPtSEl/DNrTSgk2LSqOzb8UoQ/LiNhklSvNpkdCnVLLxDtQ==
Date: Sat, 16 Mar 2024 17:46:09 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 1/1] config: learn the "hostname:" includeIf condition
Content-Language: en-US
To: Taylor Blau <me@ttaylorr.com>
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
References: <20240307205006.467443-1-ignacio@iencinas.com>
 <20240309181828.45496-1-ignacio@iencinas.com>
 <20240309181828.45496-2-ignacio@iencinas.com>
 <20240316065737.GA544929@coredump.intra.peff.net>
 <857e512c-d6d8-4bad-9eb5-5ca233a1c884@iencinas.com>
 <ZfXCJAsACzKLndNm@nand.local>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ignacio Encinas Rubio <ignacio@iencinas.com>
In-Reply-To: <ZfXCJAsACzKLndNm@nand.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 16/3/24 17:00, Taylor Blau wrote:
> On Sat, Mar 16, 2024 at 12:19:44PM +0100, Ignacio Encinas Rubio wrote:
>>
>>
>> On 16/3/24 7:57, Jeff King wrote:
>>> On Sat, Mar 09, 2024 at 07:18:28PM +0100, Ignacio Encinas wrote:
>>>
>>>> diff --git a/Documentation/config.txt b/Documentation/config.txt
>>>> index e3a74dd1c19d..9a22fd260935 100644
>>>> --- a/Documentation/config.txt
>>>> +++ b/Documentation/config.txt
>>>> @@ -186,6 +186,11 @@ As for the naming of this keyword, it is for forwards compatibility with
>>>>  a naming scheme that supports more variable-based include conditions,
>>>>  but currently Git only supports the exact keyword described above.
>>>>
>>>> +`hostname`::
>>>> +	The data that follows the keyword `hostname:` is taken to be a
>>>> +	pattern with standard globbing wildcards. If the current
>>>> +	hostname matches the pattern, the include condition is met.
>>>
>>> Do we need to define "hostname" in more detail here? Specifically, I'm
>>> wondering whether the result will be a FQDN or not (i.e., the output of
>>> "hostname" vs "hostname -f"). Looking at the code I think it will just
>>> be the short name returned. That's probably OK, but it may be worth
>>> documenting.
>>
>> Thanks for pointing it out. I agree that it should be further clarified.
>>
>> Indeed, I was referring to the short name reported by gethostname(2),
>> which should agree with "hostname". What do you think about
>>
>> diff --git a/Documentation/config.txt b/Documentation/config.txt
>> index 9a22fd260935..268a9fab7be0 100644
>> --- a/Documentation/config.txt
>> +++ b/Documentation/config.txt
>> @@ -189,7 +189,8 @@ but currently Git only supports the exact keyword described above.
>>  `hostname`::
>>         The data that follows the keyword `hostname:` is taken to be a
>>         pattern with standard globbing wildcards. If the current
>> -       hostname matches the pattern, the include condition is met.
>> +       hostname (output of gethostname(2)) matches the
> 
> Hmm. gethostname(2)'s manual page isn't overly specific on the details
> here, either.
> 
> I admittedly don't love the idea of documenting this implementation
> detail (that is, that we are calling gethostname() and using its output
> to compare against). I think it's fine to say instead, "the short
> hostname", and leave it at that.

I agree it isn't too descriptive, but the reason I chose to do it was
because this doesn't seem thoroughly documented anywhere:

hostname(1):

  hostname will print the name of the system as returned by the gethostname(2) function.

       -s, --short
              Display the short host name. This is the host name cut at the first dot.

I have only superficial knowledge about the terminology, but from what I
have read, it seems like we're actually reading the "nodename" (see
uname(2)), which shouldn't but can contain dots ".", which "hostname -s"
will trim, but "hostname" won't.

After seeing all this and the huge potential for confusing everybody, I
chose the easy way out.

I'm ok with saying "short hostname" but I'm not terribly happy with it
as it won't match "hostname -s" if "nodename" has dots (it will always
match "hostname" from what I have seen in the hostname source code from
the debian package which I assume everyone uses).

Do you think this is worth worrying about? Or people with "nodename"s
making "hostname" and "hostname --short" disagree should know that by
short hostname we mean "hostname" and not "hostname --short".

I might be missing something, but I somehow find all of this pretty
confusing.

> Alternatively, you could say "If the machine's short hostname (as
> opposed to a fully-qualified hostname, as returned by `hostname -f`)
> matches the pattern [...]".
> 
> I think I have a vague preference towards the latter.
> Thanks,
> Taylor

Thank you for the review!
