Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B30E315F41C
	for <git@vger.kernel.org>; Wed, 24 Apr 2024 15:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713974292; cv=none; b=dRqwf/Wh2srzg683TR98PHk9XMi6rSOiB+cI8dVblwzeFq/+zHlIellNTIa+OEsO0NGRYtRsks+1uLolqnRInNTAELtEGsl/TQsgy3pFhbiI7SzQqop9FSUxMHjE3GAduTs9+6COWe6oGeJ+IvDdx5KG/wsK0gC3nK4E60yWZtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713974292; c=relaxed/simple;
	bh=dCs3+V4y1JKJFeuxActjLCVTUpOMdAmk6lUfwF7uTMU=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=CxN9K5FUPwnPwsXwSanyXJ6jTNeJpi70lIGMPmZCkUlLpdhwMWOL+yKhkJMeRDo+MiAtvxcRgpDBF5UgZS//Ai5Ljrq1x7JDuJHKhpugkNneBwzV/E3zl5n77E2QggEsyry2lxxn/F5aqXHZy5mWqC7qy3/LMKmj3rERQMGjr70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=AJbT+LQe; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="AJbT+LQe"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1713974286;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I8o8agMNA/EErPxs9mvL4U4KLXelhUPayh2Ej25m5JM=;
	b=AJbT+LQeJx+V56zJwTGRH84tkUflKdOqEjOqDW1YmhwmJ2Xh2uAv/+eNL5BolYomz2dkIi
	YJC34mta2nbZc6K69jUh61wH1Nywx/gFVvL8Xefb0oL5DEirtf4SWOtFwuavHjYoUrP5n2
	JyULK9i3L+Nbm88DxA/df2BUfLW56DSeF7Z5cW0N01w+kwKJEpyzWzOjydIY+s474aIUb0
	SlUoE3K2TVFY/La9aUPUFkrGHUSjgAo5c526v6vn3G1D3lblGc1x7O4vfbRhDZMPFLxMbc
	eDjvl9qNolOId31PHdcgUAcI5vsTAwTH7aWgaY0wNrPWK35NOzr7A4tDyWp3dw==
Date: Wed, 24 Apr 2024 17:58:06 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: phillip.wood@dunelm.org.uk
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH v4 2/2] format-patch: "--rfc=-(WIP)" appends to produce
 [PATCH (WIP)]
In-Reply-To: <aa628eba-1545-47ac-9773-8aff47ca4adf@gmail.com>
References: <20240421185915.1031590-1-gitster@pobox.com>
 <20240423175234.170434-1-gitster@pobox.com>
 <20240423175234.170434-3-gitster@pobox.com>
 <aa628eba-1545-47ac-9773-8aff47ca4adf@gmail.com>
Message-ID: <ff5003c369c5247ad1a0b3a51d1581db@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Phillip,

On 2024-04-24 12:16, Phillip Wood wrote:
> On 23/04/2024 18:52, Junio C Hamano wrote:
>> In the previous step, the "--rfc" option of "format-patch" learned
>> to take an optional string value to prepend to the subject prefix,
>> so that --rfc=WIP can give "[WIP PATCH]".
>> 
>> There may be cases in which the extra string wants to come after the
>> subject prefix.  Extend the mechanism to allow "--rfc=-(WIP)" [*] to
>> signal that the extra string is to be appended instead of getting
>> prepended, resulting in "[PATCH (WIP)]".
>> 
>> In the documentation, discourage (ab)using "--rfc=-RFC" to say
>> "[PATCH RFC]" just to be different, when "[RFC PATCH]" is the norm.
>> 
>> [Footnote]
>> 
>>   * The syntax takes inspiration from Perl's open syntax that opens
>>     pipes "open fh, '|-', 'cmd'", where the dash signals "the other
>>     stuff comes here".
> 
> I'm not convinced this is a good idea as I'm not sure how adding "RFC"
> at the end of the subject prefix makes the world better than just
> having at the start of the prefix and I find using "-" to do that
> quite confusing.

Please, read my earlier responses [1][2] to see why does this
feature actually make the world a bit better.  To sum it up, just
as there's bit rot, there's also English grammar rot, which we
shouldn't embrace or promote.

[1] 
https://lore.kernel.org/git/f9aae9692493e4b722ce9f38de73c810@manjaro.org/
[2] 
https://lore.kernel.org/git/115acd1529d9529ef5bb095c074ad83d@manjaro.org/

>> Signed-off-by: Junio C Hamano <gitster@pobox.com>
>> ---
>>   Documentation/git-format-patch.txt | 6 ++++++
>>   builtin/log.c                      | 8 ++++++--
>>   t/t4014-format-patch.sh            | 9 +++++++++
>>   3 files changed, 21 insertions(+), 2 deletions(-)
>> 
>> diff --git a/Documentation/git-format-patch.txt 
>> b/Documentation/git-format-patch.txt
>> index e553810b1e..369af2c4a7 100644
>> --- a/Documentation/git-format-patch.txt
>> +++ b/Documentation/git-format-patch.txt
>> @@ -247,6 +247,12 @@ RFC means "Request For Comments"; use this when 
>> sending
>>   an experimental patch for discussion rather than application.
>>   "--rfc=WIP" may also be a useful way to indicate that a patch
>>   is not complete yet ("WIP" stands for "Work In Progress").
>> ++
>> +If the convention of the receiving community for a particular extra
>> +string is to have it _after_ the subject prefix, the string _<rfc>_
>> +can be prefixed with a dash ("`-`") to signal that the the rest of
>> +the _<rfc>_ string should be appended to the subject prefix instead,
>> +e.g., `--rfc='-(WIP)'` results in "PATCH (WIP)".
>>     -v <n>::
>>   --reroll-count=<n>::
>> diff --git a/builtin/log.c b/builtin/log.c
>> index 97ca885b33..4750e480e6 100644
>> --- a/builtin/log.c
>> +++ b/builtin/log.c
>> @@ -2065,8 +2065,12 @@ int cmd_format_patch(int argc, const char 
>> **argv, const char *prefix)
>>   	if (cover_from_description_arg)
>>   		cover_from_description_mode = 
>> parse_cover_from_description(cover_from_description_arg);
>>   -	if (rfc && rfc[0])
>> -		strbuf_insertf(&sprefix, 0, "%s ", rfc);
>> +	if (rfc && rfc[0]) {
>> +		if (rfc[0] == '-')
>> +			strbuf_addf(&sprefix, " %s", rfc + 1);
>> +		else
>> +			strbuf_insertf(&sprefix, 0, "%s ", rfc);
>> +	}
>>     	if (reroll_count) {
>>   		strbuf_addf(&sprefix, " v%s", reroll_count);
>> diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
>> index 645c4189f9..fcbde15b16 100755
>> --- a/t/t4014-format-patch.sh
>> +++ b/t/t4014-format-patch.sh
>> @@ -1394,6 +1394,15 @@ test_expect_success '--rfc=WIP and --rfc=' '
>>   	test_cmp expect-raw actual
>>   '
>>   +test_expect_success '--rfc=-(WIP) appends' '
>> +	cat >expect <<-\EOF &&
>> +	Subject: [PATCH (WIP) 1/1] header with . in it
>> +	EOF
>> +	git format-patch -n -1 --stdout --rfc="-(WIP)" >patch &&
>> +	grep "^Subject:" patch >actual &&
>> +	test_cmp expect actual
>> +'
>> +
>>   test_expect_success '--rfc does not overwrite prefix' '
>>   	cat >expect <<-\EOF &&
>>   	Subject: [RFC PATCH foobar 1/1] header with . in it
