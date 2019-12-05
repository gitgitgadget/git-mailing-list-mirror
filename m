Return-Path: <SRS0=7IA6=Z3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEA2EC43603
	for <git@archiver.kernel.org>; Thu,  5 Dec 2019 16:32:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADF7520801
	for <git@archiver.kernel.org>; Thu,  5 Dec 2019 16:32:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VWFwx5qH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729430AbfLEQcW (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Dec 2019 11:32:22 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:45476 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729022AbfLEQcV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Dec 2019 11:32:21 -0500
Received: by mail-qk1-f194.google.com with SMTP id x1so3800632qkl.12
        for <git@vger.kernel.org>; Thu, 05 Dec 2019 08:32:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=Vxu5EDdr1RMP44qYFQR/QDSbATfJGQUDuIX8GPVoTWE=;
        b=VWFwx5qHaPmq7EzjQTjh/M3c8UuGbJWVuP3nzdomkvmT2Sm5xZHT8agkynGUyLVECK
         z2a4nCDRNO8bRMuD3XfAme416hfw+QKKN955SGxWvuu/dyl034zLt2s2HjsEyRwnHGj3
         nVw2ZINp8Sryr+boOFk5ZhnWbR/DW2ehAw5R+6DzPNKF4CYgHM+y0ALO357l4kCzrnQS
         3W0IL/NdtywBRvmQ1TLmIRuaXtOx5hJPHELp7gdQbvu7MIIEdpmd2Oi664psBrEyOZut
         K1CcB7n48t0BloxKS9X49xnQgiaUrJ+sqSFqMioBcrfItdJpf9tOfdUEo/SvtAF9JrYq
         78hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=Vxu5EDdr1RMP44qYFQR/QDSbATfJGQUDuIX8GPVoTWE=;
        b=CdRejFRkV8I+98coua81fRFA/3JWb8h72YAgA12hpeWxj9pJC2USvGgsd4bTgfkl4J
         0W0T0gGAosOKMOQhIntAml+mB1mn4vCCYK21G/t/auWhIdhnehhSnw8osB+edBzlFkNO
         uBWDo7eU/FA6p+UtGTMwzMocNMouPWTU5bF4QfLG3mXNXnHB6zmW8e4ijqmFd7eJZXnc
         1QTaUjvoHGj1YyWw1bkluF8ljpY0j9B9tn01nPGK7TybwqTowN47+gABYTLVOCE6drd2
         79mkSfPo/ZLyMZrPCKQ/T2QSmkOHNWCsuMMqHVXjEHkuiK9sJmMUcIhWheiyH9DV7A/G
         RckA==
X-Gm-Message-State: APjAAAVSZ7HFBI9f73lIsB6OevIZnX9U9ty4sovAP9STfzmkqG0YsOZI
        Nt4wpLmqPfxXXJLiQ7IGd20=
X-Google-Smtp-Source: APXvYqxbl5+mXQpGQ1mzfbrA99WbS75Jg69IK7grQNxVYyZgqOuDc4TbHptcMN5/qDAL/Ro72+Wrug==
X-Received: by 2002:a37:b601:: with SMTP id g1mr9296996qkf.114.1575563540311;
        Thu, 05 Dec 2019 08:32:20 -0800 (PST)
Received: from [10.10.31.126] ([24.229.121.34])
        by smtp.gmail.com with ESMTPSA id s44sm5371475qts.22.2019.12.05.08.32.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Dec 2019 08:32:19 -0800 (PST)
Subject: Re: [PATCH v4 01/11] git-p4: select p4 binary by operating-system
To:     Denton Liu <liu.denton@gmail.com>,
        Ben Keene via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
References: <pull.463.v3.git.1575313336.gitgitgadget@gmail.com>
 <pull.463.v4.git.1575498577.gitgitgadget@gmail.com>
 <40124269933691796ef57fd8df50f9e740d103b1.1575498577.git.gitgitgadget@gmail.com>
 <20191205101935.GA315203@generichostname>
From:   Ben Keene <seraphire@gmail.com>
Message-ID: <d5f5bbc6-64aa-f2ce-6975-7ba7d5e90154@gmail.com>
Date:   Thu, 5 Dec 2019 11:32:19 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191205101935.GA315203@generichostname>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On 12/5/2019 5:19 AM, Denton Liu wrote:
> Hi Ben,
>
> First of all, as a note to you and possibly others, I don't have much
> (read: any) experience with git-p4. I do have experience with Python and
> how git.git generally does things so I'll be reviewing from that
> perspective.
>
> On Wed, Dec 04, 2019 at 10:29:27PM +0000, Ben Keene via GitGitGadget wrote:
>> From: Ben Keene <seraphire@gmail.com>
>>
>> Depending on the version of GIT and Python installed, the perforce program (p4) may not resolve on Windows without the program extension.
> Nit: "GIT" should be written as "Git" when referring to the whole
> project and "git" when referring to the command. Never in all-caps.
>
> Also, please wrap your paragraphs at 72 characters. I'll say it once
> here but it applies to your whole series.


Got it. I'll update all my commit messages to fit within this space.  I 
didn't realize
they didn't word wrap properly. (I'm using a GUI tool to manage this.)


>> Check the operating system (platform.system) and if it is reporting that it is Windows, use the full filename of "p4.exe" instead of "p4"
>>
>> The original code unconditionally used "p4" as the binary filename.
> As a rule of thumb, we want to state the problem first before we state
> what we did (and why). I'd move this paragraph up.
>
>> This change is Python2 and Python3 compatible.
>>
>> Thanks to: Junio C Hamano <gitster@pobox.com> and  Denton Liu <liu.denton@gmail.com> for patiently explaining proper format for my submissions.
> I appreciate the credit but I don't think it's necessary. At _most_, you
> could include the
>
> 	Helped-by: Junio C Hamano <gitster@pobox.com>
> 	Helped-by: Denton Liu <liu.denton@gmail.com>
>
> tags before your signoff but I don't think we've done anything to
> warrant it.


Thank you, I'll keep that in mind for the next submission!


>> Signed-off-by: Ben Keene <seraphire@gmail.com>
>> (cherry picked from commit 9a3a5c4e6d29dbef670072a9605c7a82b3729434)
> You should remove this line in all of your commits. The referenced
> commit isn't public so the information isn't very useful. Also, try to
> not include anything after your signoff so if this hypothetically were
> useful information, you'd include it before your signoff.
>
> If it's information that's ephemerally useful for current reviewers but
> not for future readers of your commit in the log message, you can
> include it after the three hyphens...


I'll look to pull these out before I update my submission.


>> ---
> like this and it won't be included as part of the log message.
>
>>   git-p4.py | 6 +++++-
>>   1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/git-p4.py b/git-p4.py
>> index 60c73b6a37..b2ffbc057b 100755
>> --- a/git-p4.py
>> +++ b/git-p4.py
>> @@ -75,7 +75,11 @@ def p4_build_cmd(cmd):
>>       location. It means that hooking into the environment, or other configuration
>>       can be done more easily.
>>       """
>> -    real_cmd = ["p4"]
>> +    # Look for the P4 binary
> I don't think this comment is necessary as the code itself is pretty
> self-explanatory.
>
>> +    if (platform.system() == "Windows"):
>> +        real_cmd = ["p4.exe"]
> You have trailing whitespace here. Try to run `git diff --check` before
> committing to ensure that you have no whitespace errors.
>
> Thanks,
>
> Denton
>
>> +    else:
>> +        real_cmd = ["p4"]
>>   
>>       user = gitConfig("git-p4.user")
>>       if len(user) > 0:
>> -- 
>> gitgitgadget
>>
