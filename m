Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4701CC636C9
	for <git@archiver.kernel.org>; Sat, 17 Jul 2021 23:02:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F59B61108
	for <git@archiver.kernel.org>; Sat, 17 Jul 2021 23:02:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231238AbhGQXFY (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 17 Jul 2021 19:05:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230171AbhGQXFX (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Jul 2021 19:05:23 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DA1BC061762
        for <git@vger.kernel.org>; Sat, 17 Jul 2021 16:02:26 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id a80so1333518qkg.11
        for <git@vger.kernel.org>; Sat, 17 Jul 2021 16:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=TOJbUxe6mzebcDp6XPYn3QJxI4vVw+0/3ivvBBGXiz0=;
        b=scaUxAmf4+o/o84Yh71JD4K+alcXdKmD9BlqenBQv41DnG169niibFt4vAeFYlqdZR
         i6hxNjNciv/t2h4Vr5mHxN6Qjkv2MppJhTJk9iC+9MBDbV+EPhbM5fIykvo7W60JVsuD
         weZEj8SnIU/u/5A/JnFWF4dxYQr86UQ4Xse0wlllt5DS4LcbXYC/5pkhf0OMNWf9sC8g
         GbtEXr2+1+Awq1a4sa9jYA8fvU3W8h856aJ0z3ERd6mp943YqHXBi3V7KSxcJury3oXs
         FqBe0FeGlKrD7M32MAMBtM/u2AZJdOWPLU0S+QR78oDePx/F6JMzIbkp+SXq64VjjQqm
         PIZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TOJbUxe6mzebcDp6XPYn3QJxI4vVw+0/3ivvBBGXiz0=;
        b=plcqCpcqvlCXwLyNOIwH6tOvlJbDdowpZz4qVGBdHt8NQHGhNI2CSs77bo3sWk60Sw
         G/jawwg7OGuo7yOOBDCh0CN95fimsb+GjMSUO12KJOX2AfsaevSueI4BqxWyZ8ul25f2
         ZQNWcl+3tms67VroL1gWug9J3vIq86pgBvKtGX23m1Kg/sf6ljnkSxXMLkthYupzemsq
         v5bS5SNMhkdaJyUL27RsEBXLev3il4ohDssahv8VEZ+oJCgRefRlY4EH+0o6aHGki7+F
         ylOI2iBmfAgK6OekLjB1ub08G4jmdQlXxKGXtpRq7FhPHfp9N0pXRoj0wZ1cxtIrd8hd
         pcyA==
X-Gm-Message-State: AOAM530B80ZK5tHsc53MeiXS0ClDJLdJDqqE1T8VWD36Bm3nUL49zAXJ
        vANDrAYYQsA1aB3Cgg7DASM=
X-Google-Smtp-Source: ABdhPJway9pVnbHHhiXuYawMCqUv0Bd0J1NxQgG0CLsXTmTrL0zpf8w3wS06lZkWc1Tk5eyT1IEeHQ==
X-Received: by 2002:a05:620a:808:: with SMTP id s8mr17393798qks.399.1626562944429;
        Sat, 17 Jul 2021 16:02:24 -0700 (PDT)
Received: from [192.168.1.127] ([192.222.216.4])
        by smtp.gmail.com with ESMTPSA id 18sm6008090qkv.118.2021.07.17.16.02.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 Jul 2021 16:02:24 -0700 (PDT)
Subject: Re: Regression in 'git pull --rebase --autostash' since v2.32.0
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        Denton Liu <liu.denton@gmail.com>
References: <a0071549-73f6-9636-9279-3f01143a05de@gmail.com>
 <60f330c09ee05_25f220867@natae.notmuch>
From:   Philippe Blain <levraiphilippeblain@gmail.com>
Message-ID: <1329d238-e38a-7c8b-d468-500a0ae38bbb@gmail.com>
Date:   Sat, 17 Jul 2021 19:02:22 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <60f330c09ee05_25f220867@natae.notmuch>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Felipe,

Le 2021-07-17 à 15:34, Felipe Contreras a écrit :
> Hello,
> 
> Philippe Blain wrote:
>> Your recent clean-up of 'git pull --autostash' seems to unfortunately have made things
>> worse if the pull brings new files that conflict with existing untracked files,
>> which makes the pull abort,
>> and there are tracked files with modifications (so --autostash comes into play).
>>
>> Before your change, 'git pull --no-rebase --autostash' did *not* apply the autostash
>> after the pull failed, thus loosing modifications to tracked files (and it did not save the
>> stash entry !). 'git pull --rebase --autostash' correctly applied the autostash, but ended with
>> a strange "error: could not detach HEAD".
>>
>> After your change, both 'git pull --no-rebase --autostash' and 'git pull --rebase --autostash'
>> have the same buggy behaviour: they do not apply the autostash and do not save it in the stash list.
>>
>> I had already documented the old behaviour at [1]. Here, I copy my reproducer script
>> (save it as "script"):
> 
> I cannot reproduce this. In my case the reproducer script never puts
> anything in the stash list.

I tried again with GIT_CONFIG_GLOBAL=/dev/null on my end (and manually
setting GIT_AUTHOR_{NAME,EMAIL}) to be sure that my config was not playing
a role, and I still reproduce. Copying the output from my 1st email
(for --rebase, but it's the same thing for --no-rebase):


> ** ./script --rebase --autostash **
> 
> ~~~
> + git status
> On branch master
> Your branch is up to date with 'origin/master'.
> 
> Changes not staged for commit:
>   (use "git add <file>..." to update what will be committed)
>   (use "git restore <file>..." to discard changes in working directory)
>     modified:   file
> 
> Untracked files:
>   (use "git add <file>..." to include in what will be committed)
>     other
> 
> no changes added to commit (use "git add" and/or "git commit -a")
> + git pull --rebase --autostash
> remote: Enumerating objects: 4, done.
> remote: Counting objects: 100% (4/4), done.
> remote: Compressing objects: 100% (2/2), done.
> remote: Total 3 (delta 0), reused 0 (delta 0), pack-reused 0
> Unpacking objects: 100% (3/3), 283 bytes | 94.00 KiB/s, done.
> From /Users/Philippe/Code/GIT-devel/BUGS/ggg-759-pull-autotash-untracked/test
>    4ebab2f..fc7a169  master     -> origin/master
> Updating 4ebab2f..fc7a169
> Created autostash: cfd51b5
> error: The following untracked working tree files would be overwritten by merge:
>     other
> Please move or remove them before you merge.
> Aborting

Here is the bug: we should see "Applied autostash" after "Aborting". The 'git status'
below is to verify that the autostash was indeed not applied, and the
'git stash list' was to check if the autostash was at least available
in the stash list (it's not).

> + git status
> On branch master
> Your branch is behind 'origin/master' by 1 commit, and can be fast-forwarded.
>   (use "git pull" to update your local branch)
> 
> Untracked files:
>   (use "git add <file>..." to include in what will be committed)
>     other
> 
> nothing added to commit but untracked files present (use "git add" to track)
> + git stash list
> # empty!
> ~~~ 

Back to your reply:

> 
> Moreover, this is not an issue of `git pull`, but `git merge`.
> 
> I can reproduce the problem that the modifications are lost like this:
> 
>    git init test
>    (
>      cd test
>      date >> file
>      git add file
>      git commit -m 'add file'
>      date >> other
>      git add other
>      git commit -m 'add other'
>      git checkout -b topic @~
>      date >> other
>      date >> file
>      git status
>      git "$@" master
>      git status
>      git stash list
>    )
> 
> Running this with 'rebase --autostash' fails and nothing is put in the
> stash list, but the modifications to 'file' remain. I think this is the
> correct behavior.

Yes. We see the following output:

     Created autostash: 69775ee
     Applied autostash.
     Successfully rebased and updated refs/heads/topic.

The code correctly applied the autostash after the rebase, so it's
normal it's not kept in the stash list. I agree it's the correct behaviour.

> 
> But with 'merge --autostash' the modifications to 'file' are lost. That
> is a bug, and it's already present in v2.32.

That's also true. From what I understand it dates back to the introduction
of 'git merge --autostash'.

> 
> Do you agree?
> 

I agree that the bug with 'merge --autostash' was already present in v2.32.0.
But since your 340062243a (pull: cleanup autostash check, 2021-06-17),
'git pull --rebase --autostash' calls 'git merge --autostash' in the fast-forward
case, and so we hit the bug, which was not the case before since the fast-forward
merge shortcut was skipped if '--autostash' was given for 'git pull --rebase'.

The fix I suggested in [1] seems to fix both cases, but as I wrote there
it still leaves two code paths that might trigger the bug. I'm not familiar
at all with the code for these two code paths, so I'm not ready to send
a formal patch; I thought I'd send the diff anyway if you or Denton (or anyone
else) wants to start from there.

Thanks,

Philippe.

[1] https://lore.kernel.org/git/a0071549-73f6-9636-9279-3f01143a05de@gmail.com/T/#me6fd1cebbcbc91365bb1deff857c2fcf72db8d2d
