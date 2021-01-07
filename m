Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 047ECC433E6
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 14:35:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D37F423355
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 14:35:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728956AbhAGOfW (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Jan 2021 09:35:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728498AbhAGOfS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jan 2021 09:35:18 -0500
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0213BC0612F4
        for <git@vger.kernel.org>; Thu,  7 Jan 2021 06:34:38 -0800 (PST)
Received: by mail-io1-xd2e.google.com with SMTP id t8so6325988iov.8
        for <git@vger.kernel.org>; Thu, 07 Jan 2021 06:34:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7IpSLN1qT2Sh4mcSOiGa5d97eUCJOSI4FyRfg48s/Rc=;
        b=r0HBjBiq2gUsMUxrj8bkooVH0vMg1CpDhaogxvVnKH39m8buG/vOwByY3NwD8wv9HC
         TOL9wCvsMsjgM8+X8nRIXEQnqE4jokjlpyuzSER7d2dav6VRmaOpk8U0WOCjn3ZKBNSy
         MfAnipATj0tcv+zl9a3iTx0EA0XWIv1EXZDh14GWgbYagRgPGj5wQM7ERffUa7gcV+rO
         ZIP6XfQ68hiXlcr37lFAm0fiIr3Sk5yInzY3jhJm4TQAAk5fZPm7g1q5CArJp3sPMcnr
         NJtuGkM1f/cn1XW/IJMDgFb0LTIZGhlzef0dPdrba09Uurq7OlLsmK+lSY4ArIx3zw3q
         JhHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7IpSLN1qT2Sh4mcSOiGa5d97eUCJOSI4FyRfg48s/Rc=;
        b=ObVlEstQICUh+dmbtKimpqO2/9CDw0GjVVcMfjc776XgTk/XHFOKuWdH4sSlfbwvpL
         ZcE5rRd76gGOkk5Dry3quzHDql4Fl6bw6hvzj8JlRZskBgCyMm3fMUC0spdANsHqQhln
         /tIkPH8beEZTPveIdI1qwuAcSMkYeB5mvTPKkpk/Iiidy/F8WASHKAL1GmHaR8pR8cEk
         c5wLzcsAVruETTLUNFadM2PQA0Hbjsm2QqIdZ3IBEMxe+NOrSOEP7T4kuoYerKKgVj/m
         BejVRBSul5nIhOrU6AJLdzqxpO5fGRuUidkDA/zp/41N5LVKIr4FX6HOOk4/npIh2jbZ
         YXBA==
X-Gm-Message-State: AOAM531vjK7lcXOF0bX0jq+GW3d7XXjProCgjSxi0KNwoodyE88N8eOF
        jSqAxlxA1sEtY+8hkavxL74pi9IQZYdtL/wa
X-Google-Smtp-Source: ABdhPJzHvNxcfuM5BWrtFlIjcWFClrXZHACq3j34/DdcVaXAv0NVg7+o1F1Qaixid8dWs3mANxB3vw==
X-Received: by 2002:a6b:b205:: with SMTP id b5mr1480324iof.190.1610030077397;
        Thu, 07 Jan 2021 06:34:37 -0800 (PST)
Received: from [192.168.1.127] ([192.222.216.4])
        by smtp.gmail.com with ESMTPSA id a7sm4686943iln.0.2021.01.07.06.34.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Jan 2021 06:34:36 -0800 (PST)
Subject: Re: git-bugreport-2021-01-06-1209.txt (git can't deal with special
 characters)
To:     "Randall S. Becker" <rsbecker@nexbridge.com>,
        'Daniel Troger' <random_n0body@icloud.com>,
        =?UTF-8?Q?=27Torsten_B=c3=b6gershausen=27?= <tboegi@web.de>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
References: <20210106214737.qwlp4jvg3x2voafs@tb-raspi4>
 <A342FAE0-A363-4280-848C-162F38C22C8E@icloud.com>
 <002601d6e480$c193bd00$44bb3700$@nexbridge.com>
From:   Philippe Blain <levraiphilippeblain@gmail.com>
Message-ID: <ffe0a3ae-780d-95ae-524d-7b029eda21ee@gmail.com>
Date:   Thu, 7 Jan 2021 09:34:35 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <002601d6e480$c193bd00$44bb3700$@nexbridge.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi everyone,

Le 2021-01-06 à 18:07, Randall S. Becker a écrit :
> On January 6, 2021 5:22 PM, Daniel Troger wrote:
>> Hi, maybe this helps you reproduce. I think I should have committed before
>> doing the second changes but I still got the error message and the two
>> names for one folder:
>>
>> me@iMac:/tmp$ mkdir git_bug
>> me@iMac:/tmp$ cd git_bug
>> me@iMac:/tmp/git_bug$ git init
>> hint: Using 'master' as the name for the initial branch. This default branch
>> name
>> hint: is subject to change. To configure the initial branch name to use in all
>> hint: of your new repositories, which will suppress this warning, call:
>> hint:
>> hint: 	git config --global init.defaultBranch <name>
>> hint:
>> hint: Names commonly chosen instead of 'master' are 'main', 'trunk' and
>> hint: 'development'. The just-created branch can be renamed via this
>> command:
>> hint:
>> hint: 	git branch -m <name>
>> Initialized empty Git repository in /private/tmp/git_bug/.git/
>> me@iMac:/tmp/git_bug$ ls -la total 8
>> drwxr-xr-x   4 daniel  wheel   128 Jan  6 23:13 .
>> drwxrwxrwt  27 root    wheel   864 Jan  6 23:13 ..
>> drwxr-xr-x   9 daniel  wheel   288 Jan  6 23:12 .git
>> -rw-r--r--@  1 daniel  staff  1283 Jan  6 23:13 paulbrunngård-springyard.zip
>> me@iMac:/tmp/git_bug$ unzip paulbrunngård-springyard.zip
>> Archive:  paulbrunngård-springyard.zip
>>     creating: paulbrunnga??rd-springyard/
>>    inflating: paulbrunnga??rd-springyard/.DS_Store
>>     creating: __MACOSX/
>>     creating: __MACOSX/paulbrunnga??rd-springyard/
>>    inflating: __MACOSX/paulbrunnga??rd-springyard/._.DS_Store
>>   extracting: paulbrunnga??rd-springyard/empty me@iMac:/tmp/git_bug$ rm
>> -rf __MACOSX/ *.zip me@iMac:/tmp/git_bug$ ls -la total 0
>> drwxr-xr-x   4 daniel  wheel  128 Jan  6 23:15 .
>> drwxrwxrwt  27 root    wheel  864 Jan  6 23:13 ..
>> drwxr-xr-x   9 daniel  wheel  288 Jan  6 23:15 .git
>> drwxr-xr-x@  4 daniel  wheel  128 Jan  6 12:20 paulbrunngård-springyard
>> me@iMac:/tmp/git_bug$ cd paulbrunngård-springyard/
>> me@iMac:/tmp/git_bug/paulbrunngård-springyard$ nano empty
>> me@iMac:/tmp/git_bug/paulbrunngård-springyard$ cat empty Initial
>> content me@iMac:/tmp/git_bug/paulbrunngård-springyard$ git add empty
>> me@iMac:/tmp/git_bug/paulbrunngård-springyard$ nano empty
>> me@iMac:/tmp/git_bug/paulbrunngård-springyard$ cat empty Initial
>> content
>>
>>
>> Line I want to keep
>>
>> Line I want gone
>> me@iMac:/tmp/git_bug/paulbrunngård-springyard$ git restore -p .
>> BUG: pathspec.c:495: error initializing pathspec_item Cannot close git diff-
>> index --cached --numstat --summary
>> 4b825dc642cb6eb9a060e54bf8d69288fbee4904 --
>> :(,prefix:27)paulbrunngård-springyard/ () at
>> /usr/local/Cellar/git/2.30.0/libexec/git-core/git-add--interactive line 183.
>> me@iMac:/tmp/git_bug/paulbrunngård-springyard$ cd ..
>> me@iMac:/tmp/git_bug$ git status
>> On branch master
>>
>> No commits yet
>>
>> Changes to be committed:
>>    (use "git rm --cached <file>..." to unstage)
>> 	new file:   "paulbrunnga\314\212rd-springyard/empty"
>>
>> Changes not staged for commit:
>>    (use "git add <file>..." to update what will be committed)
>>    (use "git restore <file>..." to discard changes in working directory)
>> 	modified:   "paulbrunnga\314\212rd-springyard/empty"
>>
>> Untracked files:
>>    (use "git add <file>..." to include in what will be committed)
>> 	.DS_Store
>> 	"paulbrunng\303\245rd-springyard/"
>>
>> me@iMac:/tmp/git_bug$
> 
> Is it possible that the å character is coming from a UTF-16 encoding and is not representable in UTF-8? I'm wondering whether the name has a double-byte representation where one of the bytes is null, resulting in a truncated file name coming from readdir(). The file name would not be representable on some platforms that do not support UTF-16 path names.

I don't think that's the case (the angstrom is present in UTF-8 [1]).
I think it's another UTF-8 precomposed/decomposed bug. As far as I
was able to test it happens as soon as you have a precomposed character
in the folder name. I observed the same behaviour with a folder named
"folderü", for example. I also tried 'git -c add.interactive.usebuiltin restore -p .'
to see if the new experimental builtin add-interactive has the same problem,
and it does (though the error is less verbose).

Anyway as you show with 'git status', it's not just 'git add -p' that is
faulty, it's deeper than that, I would say.

Cheers,

Philippe.

[1] https://en.wikipedia.org/wiki/%C3%85#On_computers
