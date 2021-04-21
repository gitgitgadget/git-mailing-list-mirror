Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC5C1C433ED
	for <git@archiver.kernel.org>; Wed, 21 Apr 2021 02:27:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A43FA61411
	for <git@archiver.kernel.org>; Wed, 21 Apr 2021 02:27:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234646AbhDUC1z (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Apr 2021 22:27:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234049AbhDUC1z (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Apr 2021 22:27:55 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C4FCC06174A
        for <git@vger.kernel.org>; Tue, 20 Apr 2021 19:27:23 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id z2so4561312qkb.9
        for <git@vger.kernel.org>; Tue, 20 Apr 2021 19:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=KuWJkTIG8uMcv669I3f6u5NBgeXGewzJDC/NA0puMQA=;
        b=N3PbjHQnuYFc+5XfSFSJn6PEePdVOk1VlYjn62zqflK4pREvWBdq97A43BVqGHMS+P
         mMwe302nDq0WiPIF/jg+OoySk5iMp37KnNkcXrpW0Bx0oDxKyJXaf3sb+2PAAxKv2TLO
         V4tYomVG2EALX05iQ3Y2nvvXfzEMLJk8SWcGB0GPPNGpcE5gzva9DKa0I+Lu8UlQXTHd
         21kZrlYa2g0s/neuX9QfV6aQghmGlI1/hH/OgHdOzFdjqTdO4A0SCiv2gc/pG5C0T9fZ
         opw4d6QRqnH19LZ1NlnPKIq+n+Vw+ptlfB1qbY0mxGU3K1q1YDfhxTgJlD0/sMkG99u4
         KrMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KuWJkTIG8uMcv669I3f6u5NBgeXGewzJDC/NA0puMQA=;
        b=fVKBUnrAG6QjHdgHOG2B8L/zzOSQF4a5xKOfYnJOdNtdUAmhWzSN+AHfREcp94Hhk4
         TJseeemk86ZQ0ZFeYJnsLYL9B8iA3Q/xeY+EHqeDYWmK9wllDaGCBuCIJVwELLoOrofi
         rx1XQ5l5Q2blheVHSCt7txc8RpIxTgjJYy6MnKavpe1HEwznqwIePVa67/I/n0+xzm8p
         QE48ILp7XoRm8zHinJAf/LgbX/0+t5VjVU6ZEnSRvo3hDw1/4KXiLOETtmvwq8D7x2BH
         UIOJhgKNwznHrb/026NvTTMJmIZDAX2uVWSiqmJoUKJsxv71g4wzvmz1Sk02/3Wvl9QY
         2TVw==
X-Gm-Message-State: AOAM530dR0Bx9S3pLrZAek1N6LmFp8N65+HqUXEausH8qaf0NryVkxH1
        eZgNdOolMbOPkaInKdez+wg=
X-Google-Smtp-Source: ABdhPJz8TJqx/Jzq5AD1auYA/Cl+I9XALdiROnexLyEDsK8dhhimfSwXNiuvER2nfCrI6Rl9/VtgNw==
X-Received: by 2002:a37:6705:: with SMTP id b5mr9272421qkc.378.1618972042296;
        Tue, 20 Apr 2021 19:27:22 -0700 (PDT)
Received: from [192.168.1.127] ([192.222.216.4])
        by smtp.gmail.com with ESMTPSA id q26sm589569qtr.7.2021.04.20.19.27.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Apr 2021 19:27:21 -0700 (PDT)
Subject: Re: RFC/Discussion - Submodule UX Improvements
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org, avarab@gmail.com, jrnieder@gmail.com,
        albertcui@google.com, gitster@pobox.com, matheus.bernardino@usp.br
References: <YHofmWcIAidkvJiD@google.com>
 <0fc5c0f7-52f7-fb36-f654-ff5223a8809b@gmail.com>
 <YH9drebF84mx2t5r@google.com>
From:   Philippe Blain <levraiphilippeblain@gmail.com>
Message-ID: <a8ac4042-a0dd-47eb-8419-7b7d19da7cec@gmail.com>
Date:   Tue, 20 Apr 2021 22:27:19 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <YH9drebF84mx2t5r@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



Le 2021-04-20 à 19:03, Emily Shaffer a écrit :

>>> When it's time to update their local repo, the user can do so as with a
>>> single-repo project. First they can 'git checkout main && git pull' (or 'git
>>> pull -r'); Git will first checkout the branches associated with main in each
>>> submodule, then fetch and merge/rebase in each submodule appropriately.
>>
>> What if some submodule does not use the same branch name for their primary integration branch?
>> Sometimes as a superproject using another project as a submodule, you do not
>> control that...
> 
> Yeah, you're right that that's an important consideration - "how can I
> teach my superproject to default to a different branch than the name of
> the superproject's current branch?" I wonder whether the branch config
> in .gitmodules (or an equivalent in superproject's .git/config) would
> make sense to try and use here?

I think it depends on the workflow. Re-reading the above, I would definitely *not* want
'git pull --recurse-submodules' in the superproject to go into each submodule
and do 'git pull' there ! Because maybe some submodule introduced breaking changes
in its API or something and I do not want to deal with that now; I just want to update my tree
with the latest changes *to the superproject* (and maybe to the submodules *if* they
were updated by the superproject, but not if they were updated in the submodule upstream project).
For me, 'git pull --recurse-submodules'
has mostly the right behaviour today, except what does not work (doing something useful
when both sides record changes to the submodule pointer).


> 
>> Also, usually tracking info is only set
>> automatically when using the form 'git checkout -b new-branch upstream/master' or
>> the like. Do you also propose that 'git checkout -b new-branch', by itself, should
>> automatically set tracking info ?
> 
> Yes - that is an approach that we want to explore, to solve the general
> push/fetch remote+branch problem.

Yeah, it would be nice if the triangular workflow capabilities of Git would be expanded
(if I understand correctly that's what you are hinting at here). My personal TODO list
for that has the following items (just dumping that here in case it's useful to someone):

# improve UI/UX around 'branch.pushRemote' and 'remote.pushDefault'
- git branch --verbose could show difference with @{push} in addition to / instead of @{upstream}
- git status "
- git prompt "
- add config branch.<name>.pushBranch (or pushRef)
- add 'git branch --set-push-to remote/name' to set branch.name.pushRemote and branch.name.pushRef
- add 'git push -p <remote> <branch>' to set 'branch.name.pushRemote' and 'branch.name.pushRef' (and warn if push.default is not 'current') OR:
- allow 'branch.pushRemote' and 'remote.pushDefault' to work if push.default=simple
- reword push.default section in git-config  (very unclear)

https://lore.kernel.org/git/87d0q72du2.fsf@javad.com/t/#u
https://lore.kernel.org/git/20130607124146.GF28668@sociomantic.com/t/#u


Cheers,

Philippe.
