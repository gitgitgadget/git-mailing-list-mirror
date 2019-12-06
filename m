Return-Path: <SRS0=yMBz=Z4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E599C2D0B1
	for <git@archiver.kernel.org>; Fri,  6 Dec 2019 10:52:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7A4E2245C
	for <git@archiver.kernel.org>; Fri,  6 Dec 2019 10:52:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DUTX0j37"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726242AbfLFKwh (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Dec 2019 05:52:37 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:32963 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726950AbfLFKwf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Dec 2019 05:52:35 -0500
Received: by mail-wr1-f67.google.com with SMTP id b6so7288158wrq.0
        for <git@vger.kernel.org>; Fri, 06 Dec 2019 02:52:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=yxlaoGzVdbvByxUvKx/Loweb3sGOhi9nI5IKCSlo7Bg=;
        b=DUTX0j37/LR5hxi51lHc3kwrV1VQBbgGzATF20u3SsFl+Tow6wAzyAi+A0d6gUmDGt
         iRX5D4E/HttdpU5vExaRuVt8H0TlcDWKMxWdI6+hNAdgxAVePgNEzCNdaO01uAgZzAy8
         KdKSfrxEMmaMSvulTUwL2rkD+q5uJeRXd/T8W50E5XS63WFGtHGbjcYavKgd5dHxuA/a
         TlOT0zR21EkOSHmydG1hT/a6tSbu6vIAlF4sqwZ8WOa35G2bXwbCpujAXjxBSUs+TcmO
         iY6smThL/Y2vUdEm9vhZSPWZBOfb5zM46tyYohbNLz21a5wkmlE3AflkaILjMxRacDSf
         5dLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=yxlaoGzVdbvByxUvKx/Loweb3sGOhi9nI5IKCSlo7Bg=;
        b=LIa2fMlywVos0LwbV3B0sbU6J3EvIQMSmQMk8sFE6hAHskbhl543x9r4+2HU7QnKh4
         1NTsw8leWUTpwflMYCCq4uzWNVe6caeDqa5yOUIBm5jw8ii+c+rhv86dB78ONA4yRdvu
         shXuTlZGgvrYFwzq+BkUwp/QQCosEvkBBcLnWWZhY3VbUyNOK+5MyFfjbMzgjq6OR4g7
         3xXJfQbRNcdoASL6C7mDdHRAJegHkWc9DzgSZ2ZQjNH+hqC2pxKS7sCmESxp3RVa6rjk
         G1iE/pwU1snipm8gkUClh5Bky5P6vAYWiZzx1d2Fk30BVElyPAXCnPZHM98+9o/Nzw0l
         2jsA==
X-Gm-Message-State: APjAAAXtmMGUHPppJI6RfPV0ON5kMEf3R5vx4D8GpestzOrrnsyEAOnq
        p9sGA4OyZP6+B7Hvh7I5XUk80s9f
X-Google-Smtp-Source: APXvYqzDFxlXlC85+ZSYWaoXo/VYt6dDI04INXei6OFF7+RkQmTuJWoO4nKnGCrVG2QtsreUuq2syw==
X-Received: by 2002:adf:9e92:: with SMTP id a18mr14957050wrf.34.1575629553166;
        Fri, 06 Dec 2019 02:52:33 -0800 (PST)
Received: from [192.168.2.240] (host-92-22-0-192.as13285.net. [92.22.0.192])
        by smtp.gmail.com with ESMTPSA id z18sm2961033wmf.21.2019.12.06.02.52.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Dec 2019 02:52:32 -0800 (PST)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 2/2] rebase: find --fork-point with full ref
To:     Denton Liu <liu.denton@gmail.com>, Alex Torok <alext9@gmail.com>
Cc:     git@vger.kernel.org
References: <20191205225322.5529-1-alext9@gmail.com>
 <20191205235704.31385-1-alext9@gmail.com>
 <20191205235704.31385-3-alext9@gmail.com>
 <20191206014828.GB16183@generichostname>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <e898ad43-5649-8f4c-7c93-fab09197fc92@gmail.com>
Date:   Fri, 6 Dec 2019 10:52:31 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <20191206014828.GB16183@generichostname>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Alex

Thanks for working on this

On 06/12/2019 01:48, Denton Liu wrote:
> Hi Alex,
> 
> On Thu, Dec 05, 2019 at 06:57:04PM -0500, Alex Torok wrote:
>> rebase --fork-point needs to look up the full ref name before calling
>> get_fork_point in the same manner that merge-base --fork-point does.
>>
>> Signed-off-by: Alex Torok <alext9@gmail.com>
>> ---
>>   builtin/rebase.c             | 4 +++-
>>   t/t3431-rebase-fork-point.sh | 1 +
>>   2 files changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/builtin/rebase.c b/builtin/rebase.c
>> index e755087b0f..821994f676 100644
>> --- a/builtin/rebase.c
>> +++ b/builtin/rebase.c
>> @@ -1980,8 +1980,10 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>>   		struct commit *head =
>>   			lookup_commit_reference(the_repository,
>>   						&options.orig_head);
>> +		char * full_name;
> 
> nit: * should be attached to the variable name.

I think you also need to free it once you've called get_fork_point() as 
well.

> 
>> +		dwim_ref_or_die(options.upstream_name, strlen(options.upstream_name), &full_name);
> 
> Also, thinking about this more, would it be possible to put the dwim_ref
> logic into get_fork_point() directly? There are currently only these two
> callers so I suspect it should be fine and it'll result in cleaner
> logic.

If you do that then it would be better to use error() rather than die() 
in get_fork_point() and return an error to the caller as we try to avoid 
adding code to libgit that dies. This lets the caller handle any cleanup 
that they need to before exiting.

Best Wishes

Phillip

> 
> We could also squash it down into one patch.
> 
>>   		options.restrict_revision =
>> -			get_fork_point(options.upstream_name, head);
>> +			get_fork_point(full_name, head);
>>   	}
>>   
>>   	if (repo_read_index(the_repository) < 0)
>> diff --git a/t/t3431-rebase-fork-point.sh b/t/t3431-rebase-fork-point.sh
>> index 78851b9a2a..6ecdae918e 100755
>> --- a/t/t3431-rebase-fork-point.sh
>> +++ b/t/t3431-rebase-fork-point.sh
>> @@ -49,6 +49,7 @@ test_rebase 'G F C D B A' --no-fork-point --onto D
>>   test_rebase 'G F C B A' --no-fork-point --keep-base
>>   test_rebase 'G F E D B A' --fork-point refs/heads/master
>>   test_rebase 'G F D B A' --fork-point --onto D refs/heads/master
>> +test_rebase 'G F D B A' --fork-point --onto D master
> 
> It's not obvious why this was failing in the first place. Perhaps we
> could document it better in the commit message?
> 
> Maybe something like:
> 
> 	We used to pass in the upstream_name directly into the
> 	get_fork_point() machinery. However, get_fork_point() was
> 	expecting a fully qualified ref name even though most users use
> 	the short name for branches. This resulted in `--fork-point` not
> 	working as expected since, without the full ref name, the reflog
> 	lookup would fail and it would behave as if we weren't passing
> 	in `--fork-point` at all.
> 
> Also, I'm not why this test case in particular that was duplicated (and
> not the one above) given that the first three `--fork-point` test cases
> fail without the change to rebase. Perhaps we want to duplicate all
> "refs/heads/master" tests with a corresponding "master" test?
> 
> Thanks,
> 
> Denton
> 
>>   test_rebase 'G F B A' --fork-point --keep-base refs/heads/master
>>   test_rebase 'G F C E D B A' refs/heads/master
>>   test_rebase 'G F C D B A' --onto D refs/heads/master
>> -- 
>> 2.17.1
>>
