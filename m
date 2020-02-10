Return-Path: <SRS0=dWK1=36=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBF1FC352A3
	for <git@archiver.kernel.org>; Mon, 10 Feb 2020 15:49:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 979DB20733
	for <git@archiver.kernel.org>; Mon, 10 Feb 2020 15:49:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BpLORpeY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727414AbgBJPtY (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Feb 2020 10:49:24 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:40118 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727120AbgBJPtY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Feb 2020 10:49:24 -0500
Received: by mail-qk1-f195.google.com with SMTP id b7so6941269qkl.7
        for <git@vger.kernel.org>; Mon, 10 Feb 2020 07:49:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=Lcj0p2vow5+k6VsTIBH9Hbd2YrhE2aDpWDbOkzCUeZ8=;
        b=BpLORpeYJBFNCIgWVafUJjax60D6AUxF2u2r16dTaohekhAvUhawB6f2iGjQddYcCW
         YKFNZr/saO8H7ErrExIHIOPG2mL6EIoqJ7XeR+RUSM+sc4RZDfdEOMIDIq1UhJwV+P1V
         vVhtYxyduCftnvZARIvr/0RVM90IINvDM4yuWmSlTUn0tydAqFSEH7/2rnkosQJO6CnZ
         HW+2u48xCOh1hGhS+acmmP1TkkuEokW4NlncrUAN1/FcdEK5R0sucjhERVcqGumuvGaH
         3yG+tK/b0HyfIc0KZGpC1pEK71HujuyrmcGUhyJsHdXXu68leYDEOFcCqs7oeBdyixiI
         GWyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=Lcj0p2vow5+k6VsTIBH9Hbd2YrhE2aDpWDbOkzCUeZ8=;
        b=SjUVBQhjpmGe03qgO4S0QDxYrvc4deJvHOJ4Lk9sBY87uX7367U/6YQinS0wIMWDcI
         25yf7PAv3it1Vu4+4zxa41feWtjr3ubXKAR0hBeAjGjTMrY57MD8VworBTtj1XsRJ72J
         tbTDTe/aYvJkH1QxU9kAuh+3SxxI2viYrPWckz68VdpOCnixvvEq5nt/nQNfWBZ6ZogX
         w0rSVwiIXMCfWLB02R3F7BrQCjo/VB6Rnau3IrnzrgFWUruq6j+h9gspIadtl4mNidys
         NWhGx7Y5WjQSe52XfjT3llfks4OJWBybv+chYsx750uvsUL2+yNeph+Kp/4esfaUw+Hj
         b15Q==
X-Gm-Message-State: APjAAAX2ypSJux0Gzo8qYjbL5ijdPg6vy8NP2ywwbMl/R/u+Vd5ZUAHf
        B4VSt3VoWQYw2bXLdHgxZbwYGBJZ/rU=
X-Google-Smtp-Source: APXvYqwAbLInJ65PY4UcTk6mMYfOmZZA0ie9l7MDFbu87YVH6srOb/nNieZjxQkQjAIA1IzFFLR1Kw==
X-Received: by 2002:a05:620a:2043:: with SMTP id d3mr1945132qka.279.1581349762872;
        Mon, 10 Feb 2020 07:49:22 -0800 (PST)
Received: from [10.10.31.126] ([24.229.121.34])
        by smtp.gmail.com with ESMTPSA id p8sm327392qtn.71.2020.02.10.07.49.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Feb 2020 07:49:22 -0800 (PST)
Subject: Re: [PATCH v3 1/5] git-p4: rewrite prompt to be Windows compatible
To:     Junio C Hamano <gitster@pobox.com>,
        Ben Keene via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org
References: <pull.698.v2.git.git.1580507895.gitgitgadget@gmail.com>
 <pull.698.v3.git.git.1581002149.gitgitgadget@gmail.com>
 <8881d76c46ce0af9a7e3c9e8d61c718beea24906.1581002149.git.gitgitgadget@gmail.com>
 <xmqqwo8zecro.fsf@gitster-ct.c.googlers.com>
From:   Ben Keene <seraphire@gmail.com>
Message-ID: <2e0d4859-a2d7-9882-4781-7ae67ec608f5@gmail.com>
Date:   Mon, 10 Feb 2020 10:49:21 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <xmqqwo8zecro.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On 2/6/2020 2:28 PM, Junio C Hamano wrote:
> "Ben Keene via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
>> From: Ben Keene <seraphire@gmail.com>
>>
>> The existing function prompt(prompt_text) does not work correctly when
>> run on Windows 10 bash terminal when launched from the sourcetree
>> GUI application. The stdout is not flushed properly so the prompt text
>> is not displayed to the user until the next flush of stdout, which is
>> quite confusing.
> Is that the bug in raw_input(prompt_text) used in the source, or is
> that the bug in your environment (whatever "the sourcetree GUI
> application" is)?  I cannot quite tell if this is butchering code
> that is perfectly working well for other people just to cope with a
> broken invoker that is what really needs fixing, or if it is working
> around a bug in raw_input().  If the former, the change is not what
> we want, and if the latter, the change should go to Python upstream,
> so either way, I am not sure if we want this patch without further
> information.
Sourcetree is a graphical UI for GIT maintained by Atlassian. It
invokes the git-bash.exe in the git for windows installation as
the shell interface. In this context, the raw_input() function
failed to work for me.  I do not know if I am unique in using
git-p4.py on a windows platform, but from what I could find online,
raw_input() does not flush stdout. (See
https://bugs.python.org/issue526382) From what I saw in response
to this problem, everyone suggested reading from stdin instead of
using raw_input. Though I can understand the hesitation for this
sort of change.
>
> Anybody on a similar platform have opinion on this?  I am OK as long
> as this change does *not* break the program in an environment that
> it is working fine, but that is not even clear.
>
>> Change this method by:
>> * Adding flush to stderr, stdout, and stdin
>> * Use readline from sys.stdin instead of raw_input.
>>
>> The existing strip().lower() are retained.
>>
>> Signed-off-by: Ben Keene <seraphire@gmail.com>
>> ---
>>   git-p4.py | 6 +++++-
>>   1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/git-p4.py b/git-p4.py
>> index 40d9e7c594..7d8a5ee788 100755
>> --- a/git-p4.py
>> +++ b/git-p4.py
>> @@ -175,7 +175,11 @@ def prompt(prompt_text):
>>       """
>>       choices = set(m.group(1) for m in re.finditer(r"\[(.)\]", prompt_text))
>>       while True:
>> -        response = raw_input(prompt_text).strip().lower()
>> +        sys.stderr.flush()
>> +        sys.stdout.write(prompt_text)
>> +        sys.stdout.flush()
> raw_input() is getting replace with input() in another series to
> bring us to Python3 compatible world, but because you are getting
> rid of its use, as long as the resulting code works with both
> Python2 and Python3, we are happy ;-)
>
>> +        sys.stdin.flush()
> What does it even mean to flush the input stream here?  At least in
> C, it is meaningless and causes an undefined behaviour.
The intent, was to clear out the input buffer before reading the
input, however, in a non-interactive mode, this would be undesirable.

I will remove the stdin.flush().


>
>> +        response=sys.stdin.readline().strip().lower()
>>           if not response:
>>               continue
>>           response = response[0]
> Thanks.
