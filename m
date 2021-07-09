Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF023C07E99
	for <git@archiver.kernel.org>; Fri,  9 Jul 2021 21:18:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3D63613B7
	for <git@archiver.kernel.org>; Fri,  9 Jul 2021 21:18:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbhGIVVS (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Jul 2021 17:21:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbhGIVVS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Jul 2021 17:21:18 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D8FCC0613DD
        for <git@vger.kernel.org>; Fri,  9 Jul 2021 14:18:34 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id h18so2959815qkl.10
        for <git@vger.kernel.org>; Fri, 09 Jul 2021 14:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:cc:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7sNQGEYP+QWv71h9aSF10niPMo3bLlsyBm0aEoHkej4=;
        b=LkzFYpgnMiMg36lMp/WGkrx3NU54CHfa84MhwWLBeb1DMqgmqPWJjjDVvlWB+mviqE
         ZAgXTRIT9Xm2RxnPaO1O57gkDKNHG2dYEQP1pK+9ocmwzcpplMvDhsCmYaFGDqUd4GgK
         JX0feTgX3KPXoJdOVL82PiDsROp21zSZAcv2XEWL/ciyf2gfi+MkAhrkvWi8zKFkVhg1
         kRCx7hl/uUrLj/hDESIeP+ntXPzEaWf03asY2a/QrpqeXaWBNRPsIv3IFh2TqC1l9JFX
         uu1QhHFIr3vBAXb1GQ5CIewkzztsDAw42ptv1G5iOUkHswGN58VpcENvLStg2v9qkAfD
         OfNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:cc:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7sNQGEYP+QWv71h9aSF10niPMo3bLlsyBm0aEoHkej4=;
        b=AxfN+pQZN0h/Q7gT7bzPph+C5Tj6n8q4QZTn66ub0Z3yy4qhbovRjb0dWrZtf2oIN+
         TmaSloUVCwvnjf45EjmNnzwjt946GaOuH2wq23SmgF5pV5auHSmO81zrUMmdhzZxhK37
         tzdZ8Ja4gwQFI54lD2+RKgZG9vvtprURlFApoGmvSvCvJr38T7zgzKqk1aNKp4drzzwa
         Iiin/Xb3nvcvwnMsE3EAhN/viWc7I7r0PxnJn7ERdkHyIK1ad8bvkNA/K33vXMsyDFsG
         UH9MAelVlqNCyJpofAoKkf/uKfJzj4EyfkR6ur4yKPxJ4awGRu27dbBJbW5hFshkcoBi
         wrsg==
X-Gm-Message-State: AOAM533HjMzXxIU+oljXM9Ax+EdnenIfT5Gtb63P9XuMVzIZhNpVVBCT
        7JvrH3zrt+ctaLK+281vXOw=
X-Google-Smtp-Source: ABdhPJwwl0vYHFU2U8sCf/5tLSd1Q/X+y8R+sqViE2CZIoyAnjOOq3+DQCZW1Qm1+cy5Mp48IqZyaA==
X-Received: by 2002:a37:6c04:: with SMTP id h4mr41470472qkc.182.1625865513244;
        Fri, 09 Jul 2021 14:18:33 -0700 (PDT)
Received: from [192.168.1.127] ([192.222.216.4])
        by smtp.gmail.com with ESMTPSA id y24sm3236710qkj.4.2021.07.09.14.18.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Jul 2021 14:18:32 -0700 (PDT)
Subject: Re: Bug with branches/merges in submodules
To:     Mel Dafert <mel@dafert.at>, git@vger.kernel.org
References: <E9E32A45-DA88-47CB-B7F9-F01F9BEC394C@dafert.at>
From:   Philippe Blain <levraiphilippeblain@gmail.com>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Ping Yin <pkufranky@gmail.com>
Message-ID: <b519a79a-5e35-bb40-71d3-0fb3c65320d7@gmail.com>
Date:   Fri, 9 Jul 2021 17:18:31 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <E9E32A45-DA88-47CB-B7F9-F01F9BEC394C@dafert.at>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Mel!

Thanks for writing in! Responses inline below.

Le 2021-07-07 à 09:13, Mel Dafert a écrit :
> Hello,
> I ran into a bug where commits are omitted from `git submodule summary`
> and friends when the submodule contains merge commits.
> Originally using 2.30.2, I can also reproduce this with a fresh build on the
> `next` branch (see attached bugreport).
> I would assume that this is not intentional, however I cannot find any relevant
> information on this.

You are right that the doc seems to be quiet about that [1], [2].


> Feel free to contact me for extra details.
> Best regards,
> Mel
> 

> Thank you for filling out a Git bug report!
> Please answer the following questions to help us understand your issue.
> 
> What did you do before the bug happened? (Steps to reproduce your issue)
> Set up a submodule that has branches/merge commits:
> ```bash
> # create repository "child"
> mkdir child-repo
> cd child-repo
> git init
> touch initial.txt
> git add initial.txt
> git commit -m "initial child"
> cd ..
> # create repository "parent"
> mkdir parent
> cd parent
> git init
> # add submodule "child" to repository "parent"
> git submodule add ../child-repo/ child
> git commit -am "initial parent"
> cd child
> # make two commits in separate branches in "child"
> git switch -c "secondary"
> touch s1.txt
> git add s1.txt
> git commit -m "s1"
> git switch master
> touch m1.txt
> git add m1.txt
> git commit -m "m1"
> # merge branch "secondary" into "master" in "child" - this creates a merge commit
> git merge secondary --no-edit
> cd ..
> ```
> Run `git diff --submodule=log` inside the "parent" repository.
> 
> What did you expect to happen? (Expected behavior)
> `git diff --submodule=log` should show all three commits added to the "child"
> submodule:
> ```
> Submodule child XXXXXXX..YYYYYYY
>> Merge branch 'secondary'
>> m1
>> s1
> ```
> 
> What happened instead? (Actual behavior)
> `git diff --submodule=log` only shows commits from one ancestor of the merge
> commit:
> ```
> Submodule child XXXXXXX..YYYYYYY
>> Merge branch 'secondary'
>> m1
> ```
> 
> What's different between what you expected and what actually happened?
> All the commits added to the "secondary" branch are missing in
> `git diff --submodule=log`.
> 
> Anything else you want to add:
> The commit range shown by `git diff --submodule=log` is correct:
> `cd child; git log XXXXXXX..YYYYYYY` shows the correct list of commits.
> 
> This bug also affects `git submodule summary`, and `git show --submodule=log`
> after the changes have been committed.

Thanks for the reproducer. The behaviour for 'git log/show/diff' is due this line [3]
and the behaviour for 'git submodule summary' to these lines [4] [5].

For 'git diff' and friends, it goes back to the addition of the '--submodule=log'
option in 752c0c2492 (Add the --submodule option to the diff option family, 2009-10-19).
(authored CC'ed). The use of '--first-parent' was discussed on the list
when this was implemented [6]. I did not read the whole thing.

For 'git submodule summary', it goes back to the addition of the subcommand
in 1cb639e6b0 (git-submodule summary: show commit summary, 2008-03-11). (author also CC'ed).
The justification of the use of '--first-parent' was not really discussed
as far as I could tell [7].


I personnally think it would be a good addition to be able to choose
if yes or no '--first-parent' should be used.

Cheers,

Philippe.


[1] https://git-scm.com/docs/git-submodule#Documentation/git-submodule.txt-summary--cached--files-n--summary-limitltngtcommit--ltpathgt82308203
[2] https://git-scm.com/docs/git-diff#Documentation/git-diff.txt---submoduleltformatgt
[3] https://github.com/git/git/blob/d486ca60a51c9cb1fe068803c3f540724e95e83a/submodule.c#L453
[4] https://github.com/git/git/blob/d486ca60a51c9cb1fe068803c3f540724e95e83a/builtin/submodule--helper.c#L1020-L1021
[5] https://github.com/git/git/blob/d486ca60a51c9cb1fe068803c3f540724e95e83a/builtin/submodule--helper.c#L1117-L1118
[6] https://lore.kernel.org/git/67a884457aeaead275612be10902a80726b2a7db.1254668669u.git.johannes.schindelin@gmx.de/t/#u
[7] https://lore.kernel.org/git/?q=f%3Ayin+s%3A%280+submodule+summary+NOT%3ARe+%29+
