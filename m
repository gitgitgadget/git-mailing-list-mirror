Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0764BC433DB
	for <git@archiver.kernel.org>; Thu, 14 Jan 2021 19:30:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C586A23B6C
	for <git@archiver.kernel.org>; Thu, 14 Jan 2021 19:30:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726501AbhANTa0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Jan 2021 14:30:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbhANTaZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Jan 2021 14:30:25 -0500
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FA01C0613D6
        for <git@vger.kernel.org>; Thu, 14 Jan 2021 11:29:29 -0800 (PST)
Received: by mail-qv1-xf2c.google.com with SMTP id h16so2854220qvu.8
        for <git@vger.kernel.org>; Thu, 14 Jan 2021 11:29:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=dPPOOBBx4hoKWn3R7/jF7p4Qelje70URlstRHEzEZIw=;
        b=XYLO2dpcPcws1zsX/dV86SBw2RO2oi37Wf+j8/rTwNPXaMnm9s5rXMyRG7z90a0U1r
         e8bXSOzhSigaXZy09o5MwrnJI6lseWvxcWrEbehtnb7WDirLGrD6MKWCWD8+B8HL8+Yb
         tY0efZJbIJ+O13fMc5QkzAeF87KlrzGz8KH3uv9oOiTyoWoabAIAO4bkMc5X/h5E6BDr
         pC+iNTW7sziTNEoM1yV9K5w1cdpeOvM4zGHgNC5MiIC5wmSqfHxHDFu7jtd0FMnDEY30
         BNrCeCx1aa4h5vYi/hGjs0kpJjqDoBv/VN2MyhcIViTEBWaVtLqtVCLA80psWguSvn2K
         wxrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dPPOOBBx4hoKWn3R7/jF7p4Qelje70URlstRHEzEZIw=;
        b=Sr8wBk3unK30bmCeWL9ILDeijKWdONaTGBbAYK9bsm8Zbke7sVoW9MAWHguNePf3FB
         fEvEGuLQjyWFU4L2k4gPj1etNQk9bBDIIYxXvHsNW5w1oYDZXSQiExKj+gFbeDX0oQoE
         ZLutJky5Lsm703v0F9/Cbf8kzUDdDgE50tEJwWo6hq+UAg1ej4khwCUptfQLAWEI6MQA
         ARgR+M8DtdjtJAJMYAGy1rkjR9cAFfvi3Igobr9vXQa2f3nOaUZbGrM5XTjtVvy8F0AS
         U1IX3fd1MLiUYcUDl1OiqBFCnZkY/2tBiMGQDQKPHDxeB3WipxPjruWSBu1MRZbyJSkv
         jJEQ==
X-Gm-Message-State: AOAM530V/MP+k66DUNRXFm1rZfh7/VH+GzZJtw6e39fPXq29bifbX7D5
        vqgBou+jwSxvggFrrPtzL9fHvTnaLEmn1g==
X-Google-Smtp-Source: ABdhPJzYpca66V/+m+OXRF+dpqjk6IAdM3fqCBBminRS5BmaQZZd4/rO3x1/nwY8kYLqPo72ILwTIw==
X-Received: by 2002:a05:6214:533:: with SMTP id x19mr8800404qvw.20.1610652568721;
        Thu, 14 Jan 2021 11:29:28 -0800 (PST)
Received: from [192.168.1.127] ([192.222.216.4])
        by smtp.gmail.com with ESMTPSA id h26sm3587374qtc.81.2021.01.14.11.29.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Jan 2021 11:29:28 -0800 (PST)
Subject: Re: add a blank line when a commit has no parent in log output?
To:     git@vger.kernel.org, Jason Pyeron <jpyeron@pdinc.us>
References: <191201d6eaa3$4b585fa0$e2091ee0$@pdinc.us>
From:   Philippe Blain <levraiphilippeblain@gmail.com>
Message-ID: <abc900c1-16cc-4ad4-4be3-c405924215cd@gmail.com>
Date:   Thu, 14 Jan 2021 14:29:27 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <191201d6eaa3$4b585fa0$e2091ee0$@pdinc.us>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jason,

Le 2021-01-14 à 13:30, Jason Pyeron a écrit :
> Take this git log --format="%C(auto) %h% ad%d% s%C(green)% aE" --graph --date=short
> 
> | | | *  5505e019c2 2014-07-09 initial xxxxxx@xxxx
> | | | *  3e658f4085 2019-09-10 (wiki/wip-citest, origin/wip-citest) Added defau
> | | | *  ad148aafe6 2019-09-10 Added default CI/CD Jenkinsfile (from f7daf088)
> 
> One might assume 5505e019c2 and 3e658f4085 are related. But git cat-file -p 5505e019c2
> tree 546c6b71f01e7fd086c8adb832518240b71a9075
> author sam swindell <xxxxxx@xxxx> 1404878701 -0400
> committer sam swindell <xxxxxx@xxxx> 1404878701 -0400
> 
> initial
> 
> 
> Is there a way to have it look like:
> 
> | | | *  5505e019c2 2014-07-09 initial xxxxxx@xxxx
> | | |
> | | | *  3e658f4085 2019-09-10 (wiki/wip-citest, origin/wip-citest) Added defau
> | | | *  ad148aafe6 2019-09-10 Added default CI/CD Jenkinsfile (from f7daf088)
> 
> Or
> 
> | | | #  5505e019c2 2014-07-09 initial xxxxxx@xxxx
> | | | *  3e658f4085 2019-09-10 (wiki/wip-citest, origin/wip-citest) Added defau
> | | | *  ad148aafe6 2019-09-10 Added default CI/CD Jenkinsfile (from f7daf088)
> 

If you remove '--graph', then you can add '--show-linear-break' [1]. Unfortunately
these two options do not work together. I think your suggestion to have the '*'
be changed to '#' for root commit is a great idea.

In the mean time, I use this trick:

     git log --date=short --format='%C(auto) %h% [%<(2,trunc)%p] ad%d% s%C(green)% aE'

This adds the abbreviated parent hashes (%p) but truncated to 2 characters ([2], [3]). So
the brackets will be empty for root commits.

Cheers,

Philippe.


[1] https://git-scm.com/docs/git-log#Documentation/git-log.txt---show-linear-breakltbarriergt
[2] https://git-scm.com/docs/git-log#Documentation/git-log.txt-empem
[3] https://git-scm.com/docs/git-log#Documentation/git-log.txt-emltltNgttruncltruncmtruncem
