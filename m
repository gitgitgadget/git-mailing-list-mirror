Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8423C47092
	for <git@archiver.kernel.org>; Sun, 30 May 2021 16:28:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8461D60240
	for <git@archiver.kernel.org>; Sun, 30 May 2021 16:28:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbhE3QaC (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 30 May 2021 12:30:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbhE3QaB (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 May 2021 12:30:01 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 764A5C061574
        for <git@vger.kernel.org>; Sun, 30 May 2021 09:28:22 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id j9so10632593edt.6
        for <git@vger.kernel.org>; Sun, 30 May 2021 09:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=SsRlDif4invu69UQvoiolhTawil8aoWiOuy7ngskl9o=;
        b=IzUibS7vGL38Oy4HR+Z3UbmvGjpZomwPvA35tECO1qDWhl22E66YPtEFOl96nJY8Po
         07diXYSK8AomhuK2s++y/t7S7b43p5jmVQmPBkZONYVuA53SckTRt+TLojPesZXECYJD
         O11AHFFpGspe8Gxk9C7XKS3YTfKJv3bIk9WZ03pmMI3/k5H8xi9wMzkuq7a8x9W+oAf4
         VoLnhoPyg617lKjXTVqh97O8rAvVCwgyIkuK/p86elBOxRfXw3+//SjHrWhwxG0G2nHZ
         ZqgsnbBYw4e7+T2tWE3qvluDE98RzieYt1iTqEomLJKsimgVEoUmwHZXxFCiXBW9k8xn
         OwMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SsRlDif4invu69UQvoiolhTawil8aoWiOuy7ngskl9o=;
        b=DRwReVhAw9vUTXRfK9FVOvvilkk6X6TwkniliTVddSYfhtAF7YpNoZMOH4BLKc9VOf
         1Kij9lI0F07z9C+dMz9vRQBwEnR690/P8SeiNwwfdYit1t+a14HXdzzBqz42syRVADs5
         3q2eZFtCMhk6gh1LEUf+qLpN/8rlvCWd5GrTdOXOS0CXdfiIGMp0NvinQQp60jOBPBH/
         jAl3zopY2jlWgxYBPE33rBhs9vvilo8RQ6Mfjr1H9Zq/0YKIoIwgX2Sql0PYk6R2lVJK
         7M2Ru3lsExdISKdd3DrbwrIlzoKmxN4O/f7qgrsEx6H4Ovm6pQ0eZAlTXaP40wzAj24Q
         KaQQ==
X-Gm-Message-State: AOAM531wnJiTSaOO1lxi7aZbgrGQPdp1YyF3KxPD4ATZbWyZeuM+FKiv
        CJxIWzIM+3fyrojCXoo+5NRSe5pOP/Y=
X-Google-Smtp-Source: ABdhPJxFs7sbIt7JhLpTrv+qJn90C+p3QODIky9rJE+nBiRy17OPSTESfP+TLfF/WzcM+a9/ysHAqA==
X-Received: by 2002:a05:6402:176b:: with SMTP id da11mr21792222edb.234.1622392101074;
        Sun, 30 May 2021 09:28:21 -0700 (PDT)
Received: from ?IPv6:2a02:8388:e002:8cf0:25d1:fff3:8887:500f? (2a02-8388-e002-8cf0-25d1-fff3-8887-500f.cable.dynamic.v6.surfer.at. [2a02:8388:e002:8cf0:25d1:fff3:8887:500f])
        by smtp.googlemail.com with ESMTPSA id t9sm5882474edf.70.2021.05.30.09.28.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 May 2021 09:28:20 -0700 (PDT)
Subject: Re: git push default doesn't make sense
To:     Felipe Contreras <felipe.contreras@gmail.com>,
        Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
References: <3b9bc214-a30a-ba49-af96-7eeaf37b7bbd@gmail.com>
 <fcf30899-8e64-5417-f478-14d6aca72544@gmail.com>
 <CABPp-BEeqqGwN3=MbWCYnsyryBm3WoaX5GZyXTWy18UiYUT4zg@mail.gmail.com>
 <f9f38d42-2b93-0d3b-798b-4c6f44eb111d@gmail.com>
 <287483ba-d682-6d04-23fa-22c33ab70376@gmail.com>
 <60b15cd2c4136_2183bc20893@natae.notmuch>
From:   Mathias Kunter <mathiaskunter@gmail.com>
Message-ID: <d9e212fa-4c6a-f6ce-eab0-8073a65e96fd@gmail.com>
Date:   Sun, 30 May 2021 18:28:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <60b15cd2c4136_2183bc20893@natae.notmuch>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: de-AT
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 28.05.21 um 23:12 schrieb Felipe Contreras:

> Cloning automatically sets up an upstream branch for "master", and
> therore it passes the safety check of `push.default=simple`, and that is
> much more dangerous than pushing any other branch.
> 
> Why do we barf with "fix-1", but not "master"? Doesn't make sense.
> 
> This is what we want:
> 
> 	if (centralized &&
> 		(branch->merge_nr && branch->merge && branch->remote_name))
> 	{
> 		if (branch->merge_nr != 1)
> 			die(_("The current branch %s has multiple upstream branches, "
> 			    "refusing to push."), branch->name);
> 
> 		/* Additional safety */
> 		if (strcmp(branch->refname, branch->merge[0]->src))
> 			die_push_simple(branch, remote);
> 	}
> 	refspec_appendf(&rs, "%s:%s", branch->refname, branch->refname);
> 
> 
> In other words: `simple` should be the same as `current`, except when
> there's an upstream branch configured *and* the destination branch has a
> different name.

I guess so. In particular, as a simple git user, I'd expect the 
following to work out of the box, without having to manually adjust the 
configuration settings:

   git clone ssh://originUrl .
   git checkout -b myBranch
   git push           # expected push to origin/myBranch, but fails
   git push origin    # expected push to origin/myBranch, but fails
   git remote add myRemote ssh://myRemoteUrl
   git push myRemote  # expected push to myRemote/myBranch - works

Will your provided patch fix these failing push commands?
