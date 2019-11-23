Return-Path: <SRS0=Rptp=ZP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04EF7C432C0
	for <git@archiver.kernel.org>; Sat, 23 Nov 2019 09:54:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B751020714
	for <git@archiver.kernel.org>; Sat, 23 Nov 2019 09:54:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bv0I6BHb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726463AbfKWJx5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 23 Nov 2019 04:53:57 -0500
Received: from mail-wr1-f45.google.com ([209.85.221.45]:41020 "EHLO
        mail-wr1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726141AbfKWJx5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Nov 2019 04:53:57 -0500
Received: by mail-wr1-f45.google.com with SMTP id b18so11531673wrj.8
        for <git@vger.kernel.org>; Sat, 23 Nov 2019 01:53:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=EcLRkBjQRA0fqIhFRUoLlv9FKE6I3cTI0SD+1aKLrS4=;
        b=bv0I6BHbgxMOx5b9tY6hJUPPr69brpUMz7yhtCIa/EUgWAPkSc244vCwWKCpHl74fy
         fXEwCUROMWx7pjw+VaXDw46jueT5t3lvf9e17P9XGLRDYPHPx03MOWCdwrZEnuQiw4hl
         dZzCY6edPWXjpnmNrgF3uZMg2lgWZ4VFNi2fuctBrR2yWD/Jx3LiK0oy1+jdmaHE5ju/
         zZ+8yRUdeJYBB2YfKU2g7MjvQ5ARAm9nLkGBhBAOLfp/Yy6IWWlPuru+J2xlX2hQyqao
         bHy5uEWvqIY97+tL3liekenl6BpAjvG6mRyhd8k2Of3FO7568TZkwuwG8H2EVa5PKLg3
         QahA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=EcLRkBjQRA0fqIhFRUoLlv9FKE6I3cTI0SD+1aKLrS4=;
        b=V4IHfhZc1YO4qZ3ymgACsazOjST5BtPLMSJM+8CNaEgD4ubAELTsNYkJVzRImBzRRe
         HZrKGUMZQw8Yu8LrFex6OghlwNb6vQS+Gatb9orIdHawaTToHTAU5RTz1o5m3gYhzw1h
         igoirT3HcUUen1R5Pv++M5TE1qfKADRorATIyHXQm8UQdisHTwJntqY9eiNIjEt+Gqgu
         yDXesjuCJGrj2Fq43UOBelKgZvIlsRfMWPHgKC8vVpEmvu4E6niXRgHtnvUzWvg1kL97
         uhx+JdKMz1w/YwsAkq6IAhFu9T0AFEerVmHPWDWBkHuYjBTvTU7JLO1LnxOwA5fB8P+p
         A4Ug==
X-Gm-Message-State: APjAAAXE2tEYSnK0e9rriIPIfCZQTHm5gmu0A7zsjQAc1ezXmA8NjRUe
        QsIpyPOLxg1J/1WWaM9xiK0=
X-Google-Smtp-Source: APXvYqwwo8iYWCbkh/g2n9FRgki64DLNvRhOJUFULSmNUTM4bcLbxiPm+hHyFJERTgDXf0Lq8Q5rPQ==
X-Received: by 2002:adf:b1cb:: with SMTP id r11mr22434852wra.246.1574502834010;
        Sat, 23 Nov 2019 01:53:54 -0800 (PST)
Received: from [192.168.2.240] (host-92-22-28-211.as13285.net. [92.22.28.211])
        by smtp.gmail.com with ESMTPSA id f6sm1570985wrr.15.2019.11.23.01.53.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 Nov 2019 01:53:53 -0800 (PST)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: git 2.24: git revert <commit1> <commit2> requires extra
 '--continue'?
To:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Brian Norris <briannorris@chromium.org>
Cc:     git@vger.kernel.org, Phillip Wood <phillip.wood@dunelm.org.uk>
References: <CA+ASDXNQ+9i-6uCNDwN46cnHJeciiqQSX5Z6EaqB9pbseQhVFw@mail.gmail.com>
 <20191123003454.GA23183@szeder.dev>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <e7c01e0f-8466-c2c5-b53a-a93f941dfb1c@gmail.com>
Date:   Sat, 23 Nov 2019 09:53:51 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <20191123003454.GA23183@szeder.dev>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Brian & Gábor

Thanks to Brian for reporting this and Gábor for bisecting and creating 
the tests.

On 23/11/2019 00:34, SZEDER Gábor wrote:
> On Fri, Nov 22, 2019 at 03:10:20PM -0800, Brian Norris wrote:
>> Hi! I'm using git 2.24 (or, a variant of that packaged my distro -- I
>> can try to build my own if this is deemed not reproducible), and I
>> feel like I've been seeing a regression here:
>>
>> Previously, when reverting multiple commits (with the default --edit
>> behavior), as soon as I'm done editing the first revert commit
>> message, the second revert commit pops up an editor, and I'm on my
>> way. Now, it seems to require an extra 'git revert --continue' prompt
>> in between, yet it doesn't actually recommend that. This is highly
>> confusing, and seemingly unnecessary.
> 
> Thanks for the report, this is indeed a regression in v2.24.0: it
> bisects down to a47ba3c777 (rebase -i: check for updated todo after
> squash and reword, 2019-08-19) [Cc'ing Phillip].  It's not specific to
> 'git revert', but with a slight variation affects 'git cherry-pick' as
> well.

Thanks, I suspect it's missing an 'if (is_rebase_i(opts))' I'll take a 
look later and come up with a fix

Best Wishes

Phillip

>> An annotated transcript provided below.
> 
> I transcribed your transcript into tests that can be run in our test
> framework and demonstrate this regression:
> 
>    --- >8 ---
> 
> #!/bin/sh
> 
> test_description='test'
> 
> . ./test-lib.sh
> 
> test_expect_success "Brian's revert regression" '
> 	test_create_repo revert &&
> 	(
> 		cd revert &&
> 
> 		echo 1 >file &&
> 		git add file &&
> 		git commit -m first &&
> 		echo 2 >file &&
> 		git commit -am second &&
> 		echo 3 >file &&
> 		git commit -am third &&
> 
> 		git checkout -b branch &&
> 
> 		git revert --edit HEAD HEAD^ &&
> 
> 		echo 1 >expect &&
> 		test_cmp expect file
> 	)
> '
> 
> test_expect_success "a variant of Brian's regression for cherry-pick" '
> 	test_create_repo cherry-pick &&
> 	(
> 		cd cherry-pick &&
> 
> 		echo 1 >file &&
> 		git add file &&
> 		git commit -m first &&
> 		echo 2 >file &&
> 		git commit -am second &&
> 		echo 3 >file &&
> 		git commit -am third &&
> 
> 		git checkout -b branch HEAD^^ &&
> 
> 		git cherry-pick --edit master^ master &&
> 
> 		echo 3 >expect &&
> 		test_cmp expect file
> 	)
> '
> 
> test_done
> 
>    ---  >8  ---
> 
> They both succeed on a47ba3c777's parent, but fail on a47ba3c777 when
> the 'git revert' or 'git cherry-pick' commands return with exit code 1
> after reverting/cherry-picking the first commit instead of processing
> the second commit:
> 
>    + git revert --edit HEAD HEAD^
>    [branch 88ea48c] Revert "third"
>     Author: A U Thor <author@example.com>
>     1 file changed, 1 insertion(+), 1 deletion(-)
>    On branch branch
>    Revert currently in progress.
>    
>    nothing to commit, working tree clean
>    error: last command exited with $?=1
>    not ok 1 - Brian's revert regression
> 
> 
> 
>    + git cherry-pick --edit master^ master
>    [branch 2cb3f74] second
>     Author: A U Thor <author@example.com>
>     Date: Sat Nov 23 00:17:32 2019 +0000
>     1 file changed, 1 insertion(+), 1 deletion(-)
>    On branch branch
>    Cherry-pick currently in progress.
>    
>    nothing to commit, working tree clean
>    The previous cherry-pick is now empty, possibly due to conflict
>    resolution.
>    If you wish to commit it anyway, use:
>    
>        git commit --allow-empty
>    
>    If you wish to skip this commit, use:
>    
>        git reset
>    
>    Then "git cherry-pick --continue" will resume cherry-picking
>    the remaining commits.
>    error: last command exited with $?=1
>    not ok 2 - a variant of Brian's regression for cherry-pick
> 
> 
> These test should probably be squeezed into
> 't3508-cherry-pick-many-commits.sh', but Friday has just turned into
> Saturday around here, so that's enough from me for now.
> 
> 
>> Note that none of this happens with --no-edit; my reverts happen
>> smoothly, with no extra need for --continue.
>>
>> Regards,
>> Brian
>>
>> $ mkdir tmp
>> $ cd tmp
>> /tmp$ git init
>> Initialized empty Git repository in [...]/tmp/.git/
>> /tmp$ touch foo
>> /tmp$ git add foo
>> /tmp$ echo bar >> foo
>> /tmp$ git commit -am baz
>> [master (root-commit) a388f78d9013] baz
>>   1 file changed, 1 insertion(+)
>>   create mode 100644 foo
>> /tmp$ echo pow >> foo
>> /tmp$ git commit -am whizzbang
>> [master 51753222dd9a] whizzbang
>>   1 file changed, 1 insertion(+)
>> /tmp$ echo pop >> foo
>> /tmp$ git commit -am nothing
>> [master 7153607b11e0] nothing
>>   1 file changed, 1 insertion(+)
>> /tmp$ git revert HEAD HEAD^
>> ## EDITOR pops up, as expected
>> [master 586469974ec2] Revert "nothing"
>>   1 file changed, 1 deletion(-)
>> On branch master
>> Revert currently in progress.
>>
>> nothing to commit, working tree clean
>> ## Unexpected, confusing pause? No prompt to '--continue'
>> /tmp$ git log --oneline
>> 586469974ec2 (HEAD -> master) Revert "nothing"
>> 7153607b11e0 nothing
>> 51753222dd9a whizzbang
>> a388f78d9013 baz
>> /tmp$ git status
>> On branch master
>> Revert currently in progress.
>>    (run "git revert --continue" to continue)
>>    (use "git revert --skip" to skip this patch)
>>    (use "git revert --abort" to cancel the revert operation)
>>
>> nothing to commit, working tree clean
>> /tmp$ git revert --continue
>> ## EDITOR pops up, as expected
>> [master b8dd23f61d07] Revert "whizzbang"
>>   1 file changed, 1 deletion(-)
>> On branch master
>> Revert currently in progress.
>>
>> nothing to commit, working tree clean
>> ## Unexpected state; both reverts happened, but revert is still in progress?
>> /tmp$ git log --oneline
>> b8dd23f61d07 (HEAD -> master) Revert "whizzbang"
>> 586469974ec2 Revert "nothing"
>> 7153607b11e0 nothing
>> 51753222dd9a whizzbang
>> a388f78d9013 baz
>> /tmp$ git status
>> On branch master
>> Revert currently in progress.
>>    (run "git revert --continue" to continue)
>>    (use "git revert --skip" to skip this patch)
>>    (use "git revert --abort" to cancel the revert operation)
>>
>> nothing to commit, working tree clean
>> ## OK...I'll run it one more time.
>> /tmp$ git revert --continue
>> /tmp$ git status
>> On branch master
>> nothing to commit, working tree clean
>> ## *Now* I'm done
>> /tmp$ git log --oneline
>> b8dd23f61d07 (HEAD -> master) Revert "whizzbang"
>> 586469974ec2 Revert "nothing"
>> 7153607b11e0 nothing
>> 51753222dd9a whizzbang
>> a388f78d9013 baz
