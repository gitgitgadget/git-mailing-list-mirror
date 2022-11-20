Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51A5AC433FE
	for <git@archiver.kernel.org>; Sun, 20 Nov 2022 08:10:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229478AbiKTIKu (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 20 Nov 2022 03:10:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiKTIKt (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Nov 2022 03:10:49 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05F3F970A8
        for <git@vger.kernel.org>; Sun, 20 Nov 2022 00:10:47 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id x5so11530997wrt.7
        for <git@vger.kernel.org>; Sun, 20 Nov 2022 00:10:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F4kMzJ7guXYKmB2/0ii1ebF6LqIrYI3wNfHBNlDI034=;
        b=NAouC7HXPZMJFi3DUE2khQ34NevRbugjQzttGKcI7jOJumbnJB2dybiWHumhvvkHsR
         vwW48WKxbOeSSQWleDDRKjQ6/7p1q2q3wbLZikxhR5fQ2WIPZhhTBaWCZP3a7olNZ10h
         NY185VJ2efuTQISOsJZm11f7NiCkYgyH8x0dEcL4kVXVMMN01CwdRpSql0FlKRPdT3LY
         D/F66jLQBxMJX7CDevqFn4mZJUvUJY4FsVEI6VXC3y+kUgKkigZd0xWCynK4dlJkW1Cq
         2IaGVHerRt4xndVfIHGGP6WkrkBvQEHVLXtmv3UV20eNhpm7VDYk9b5V1sV+H8XJdS+J
         h75A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F4kMzJ7guXYKmB2/0ii1ebF6LqIrYI3wNfHBNlDI034=;
        b=khjoGPMYAjVJ/8f+4QZpskDhOEnncyTI7+yOFhSSu0Ycn0L5QOHVK0ZrnMNUn05C04
         Zcndj+WLGIve8jyKuM7yEbIS6kvaLVN0qCYkv4CQQsD0ontqfjs9hJ0/6VvjnHZH8uVc
         dM7h+qEQz3k8ToEBm8SY2EwEqqQ7IFipEqq1woHu7QyTrx22E/C729Ob2mxxED6jwUSC
         QoIny393abdHRKoDl89vazCskZ4LLQybvqrZFJTO1HmVw6V+OTCquiPn1F+H0AXOcMCT
         racs2W7ZTD5X1hG+7ViYAM+ZR5BISoVGZ9VofPbB5JZJICIKlJguKZ/hfY5bMH/z5WyI
         RbZg==
X-Gm-Message-State: ANoB5pk0ghRZ1yqYJ1CnzoPAcLB8g40TG9SWgWhqQkHDRaNLff+gnR7U
        X3Jbg4iOjb6u/xX8WPHSxr0=
X-Google-Smtp-Source: AA0mqf5BiLoxipo929MK/QUO6QFF7DKgz52OTMEfWT078RCc54RM66AsfMjKk+81CtJsNe2swpstqg==
X-Received: by 2002:a5d:4408:0:b0:236:b877:d24a with SMTP id z8-20020a5d4408000000b00236b877d24amr7929843wrq.162.1668931846360;
        Sun, 20 Nov 2022 00:10:46 -0800 (PST)
Received: from [192.168.2.52] (104.red-88-14-50.dynamicip.rima-tde.net. [88.14.50.104])
        by smtp.gmail.com with ESMTPSA id e18-20020a5d5952000000b00236883f2f5csm8059786wri.94.2022.11.20.00.10.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Nov 2022 00:10:45 -0800 (PST)
Subject: Re: [PATCH 1/2] branch: force-copy a branch to itself via @{-1} is a
 no-op
To:     Victoria Dye <vdye@github.com>, Git List <git@vger.kernel.org>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
References: <f0b2d46c-2e9c-2630-2870-8ed550dd1606@gmail.com>
 <db182322-1383-4311-8baa-c4a9aeed3b4d@gmail.com>
 <9125ea40-3078-2ca3-493c-56703144f37e@github.com>
From:   =?UTF-8?Q?Rub=c3=a9n_Justo?= <rjusto@gmail.com>
Message-ID: <519b4886-0bc8-9cc6-1c53-f2b0411c5193@gmail.com>
Date:   Sun, 20 Nov 2022 09:10:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <9125ea40-3078-2ca3-493c-56703144f37e@github.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On 17/11/22 23:18, Victoria Dye wrote:
> Rubén Justo wrote:
>> Since 52d59cc645 (branch: add a --copy (-c) option to go with --move
>> (-m), 2017-06-18) we can copy a branch to make a new branch with the
>> '-c' (copy) option or to overwrite an existing branch using the '-C'
>> (force copy) option.  A no-op possibility is considered when we are
>> asked to copy a branch to itself, to follow the same no-op introduced
>> for the rename (-M) operation in 3f59481e33 (branch: allow a no-op
>> "branch -M <current-branch> HEAD", 2011-11-25).  To check for this, in
>> 52d59cc645 we compared the branch names provided by the user, source
>> (HEAD if omitted) and destination, and a match is considered as this
>> no-op.
>>
>> Since ae5a6c3684 (checkout: implement "@{-N}" shortcut name for N-th
>> last branch, 2009-01-17) a branch can be specified using shortcuts like
>> @{-1}.  This allows this usage:
>>
>> 	$ git checkout -b test
>> 	$ git checkout -
>> 	$ git branch -C test test  # no-op
>> 	$ git branch -C test @{-1} # oops
>> 	$ git branch -C @{-1} test # oops
>>
>> As we are using the branch name provided by the user to do the
>> comparison, if one of the branches is provided using a shortcut we are
>> not going to have a match and a call to git_config_copy_section() will
>> happen.  This will make a duplicate of the configuration for that
>> branch, and with this progression the second call will produce four
>> copies of the configuration, and so on.
> 
> This is a clear explanation of what the issue is and why it's happening.
> 
>>
>> Let's use the interpreted branch name instead for this comparison.
>>
>> The rename operation is not affected.
>>
>> Signed-off-by: Rubén Justo <rjusto@gmail.com>
>> ---
>>  builtin/branch.c                      |  6 +++---
>>  t/t3204-branch-name-interpretation.sh | 10 ++++++++++
>>  2 files changed, 13 insertions(+), 3 deletions(-)
>>
>> diff --git a/builtin/branch.c b/builtin/branch.c
>> index 15be0c03ef..a35e174aae 100644
>> --- a/builtin/branch.c
>> +++ b/builtin/branch.c
>> @@ -584,13 +584,13 @@ static void copy_or_rename_branch(const char *oldname, const char *newname, int
>>  	strbuf_release(&logmsg);
>>  
>>  	strbuf_addf(&oldsection, "branch.%s", interpreted_oldname);
>> -	strbuf_release(&oldref);
>>  	strbuf_addf(&newsection, "branch.%s", interpreted_newname);
>> -	strbuf_release(&newref);
>>  	if (!copy && git_config_rename_section(oldsection.buf, newsection.buf) < 0)
>>  		die(_("Branch is renamed, but update of config-file failed"));
>> -	if (copy && strcmp(oldname, newname) && git_config_copy_section(oldsection.buf, newsection.buf) < 0)
>> +	if (copy && strcmp(interpreted_oldname, interpreted_newname) && git_config_copy_section(oldsection.buf, newsection.buf) < 0)
> 
> I double-checked that 'interpreted_oldname' and 'interpreted_newname' are
> always set (and not only when a shortcut name is used), and they are. So,
> this does exactly what you intend.
> 
>>  		die(_("Branch is copied, but update of config-file failed"));
>> +	strbuf_release(&oldref);
>> +	strbuf_release(&newref);
>>  	strbuf_release(&oldsection);
>>  	strbuf_release(&newsection);
>>  }
>> diff --git a/t/t3204-branch-name-interpretation.sh b/t/t3204-branch-name-interpretation.sh
>> index 793bf4d269..3399344f25 100755
>> --- a/t/t3204-branch-name-interpretation.sh
>> +++ b/t/t3204-branch-name-interpretation.sh
>> @@ -57,6 +57,16 @@ test_expect_success 'create branch with pseudo-qualified name' '
>>  	expect_branch refs/heads/refs/heads/qualified two
>>  '
>>  
>> +test_expect_success 'force-copy a branch to itself via @{-1} is no-op' '
>> +	git branch -t copiable main &&
>> +	git checkout copiable &&
>> +	git checkout - &&
>> +	git branch -C @{-1} copiable &&
>> +	git config --get-all branch.copiable.merge >actual &&
>> +	echo refs/heads/main >expect &&
>> +	test_cmp expect actual
>> +'
>> +
> 
> And the test is straightforward and demonstrates the fix. Thanks for the
> well-written patch, this looks good to me! 
> 

Thank you for reviewing this.
