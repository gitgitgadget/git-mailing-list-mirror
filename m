Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B93B6C433E0
	for <git@archiver.kernel.org>; Wed,  3 Feb 2021 01:49:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7154064E27
	for <git@archiver.kernel.org>; Wed,  3 Feb 2021 01:49:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229883AbhBCBtk (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Feb 2021 20:49:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbhBCBti (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Feb 2021 20:49:38 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2008DC06174A
        for <git@vger.kernel.org>; Tue,  2 Feb 2021 17:48:58 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id b145so8827320pfb.4
        for <git@vger.kernel.org>; Tue, 02 Feb 2021 17:48:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qmUc1GeJR645+13qu2dxQ8aKvpaiBeTHmmYEPb6GLzc=;
        b=Lrnu7tFhSwn+BYORuZNHDuJSKD8vEO3YMr/6P/JhnIRK0m8eohQ4rnXaFW5idyof2w
         Z7Od6k8eUrVaxWq5fIiwYIPzUPeDNSJ7NX+vGyYG2UPxBT4fXarIu9HVj/hTZ3FMQsll
         ESHijtspNhuy6RJhhQaYvDfepaz1wqYY4hDbngcMXAydEivwWLQJzWhsBpFtbEEJXxTG
         vQ8y9CrQieA0tBe9r2v4gZABWOWMk9KZIsNJo4GWW69taT41opSAEkKBqXiFA1AK88AD
         bs5pUJOntGcC1w7DxU5VEysspavHxe4yQQn9R+MjTPL3evYhdxpexArcPumQbVJzCd69
         X9rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qmUc1GeJR645+13qu2dxQ8aKvpaiBeTHmmYEPb6GLzc=;
        b=Xh0L8p/m6ZzE97aipQrpaiB0gAGy400Wps6qnrYSkFPT455uSZiXpZzXTKvjd8C3eo
         OLKGTjaYGzcU/HO+nY6s+rIAirh0nOZNvZsXu+R/mfSwadd/dbIX5+PzjUruxvPLBYZo
         QZ/bCFJrML5YKVQrbW75LzGd+Rldkkv4BviqrwqDou50nT7CXTq+EvI/tSBf6jMhKa+u
         x+/w8iB07LyALy2haNA2LgDIDH5UPbHAwXyYcrBOEywk1VxfEjsiV3FBSuNlU5ZgwlE+
         eYzSuiHtuMqDknjc557HndFjE/B7D+DGFcv2X0iLqkO4yR3vnU0A11zu/wSMa+pAkOWH
         O0cw==
X-Gm-Message-State: AOAM533pKbhlC0UilwLvIYrlj5uTHghwbQxQPXOexsI81pkerrRl9Dqn
        ZOafdG7/4MUdxDaBMfbHj1U=
X-Google-Smtp-Source: ABdhPJzrbb9tFzgM42mQZnnHYljviS34fy1avPbAomkjpOUvZTfo/U+L8zgSv3sZ3xZ8ycaxLJLprg==
X-Received: by 2002:a62:2acf:0:b029:1bf:e549:fa4f with SMTP id q198-20020a622acf0000b02901bfe549fa4fmr764483pfq.69.1612316937575;
        Tue, 02 Feb 2021 17:48:57 -0800 (PST)
Received: from google.com ([2620:15c:2ce:200:1c0e:cb1e:4abc:4be8])
        by smtp.gmail.com with ESMTPSA id t6sm228686pfe.177.2021.02.02.17.48.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Feb 2021 17:48:56 -0800 (PST)
Date:   Tue, 2 Feb 2021 17:48:54 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, me@ttaylorr.com, peff@peff.net,
        gitster@pobox.com, abhishekkumar8222@gmail.com,
        Taylor Blau <ttaylorr@github.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v2 2/6] commit-graph: always parse before
 commit_graph_data_at()
Message-ID: <YBoBBie2t1EhcLAN@google.com>
References: <pull.850.git.1612199707.gitgitgadget@gmail.com>
 <pull.850.v2.git.1612234883.gitgitgadget@gmail.com>
 <454b183b9ba502da7f40dc36aaa95cc3d12b5c2f.1612234883.git.gitgitgadget@gmail.com>
 <YBn3fxFe978Up5Ly@google.com>
 <1dab0bf0-9a7f-370a-c807-25d67ac7a0a0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1dab0bf0-9a7f-370a-c807-25d67ac7a0a0@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Derrick Stolee wrote:
> On 2/2/2021 8:08 PM, Jonathan Nieder wrote:

>> At Google, we're running into a commit-graph issue that appears to
>> have also arrived as part of this last week's rollout.  This one is a
>> bit worse --- it is reproducible for affected users and stops them
>> from being able to do day-to-day development:
>
> You're shipping 'next' widely? I appreciate the extra eyes on
> early bits, so we can find more issues and get them resolved.

Yes.  Changes in 'next' have already gotten all the vetting via code
review that they're going to get; the difference between changes in
'next' and 'master' is that the latter have had some production
exposure among users of 'next' with the ability to get help from a
local expert, roll back quickly when there's a problem, and so on.  I
recommend that anyone with an installation with that ability use
'next', to improve the quality of code that ultimately is released
from 'master'.

It also helps us get the chance to use our experience to affect the
direction of a topic before it's too late.

[...]
>> We have some examples of repositories that were corrupted this way,
>> but we didn't catch them in the act of corruption --- it started
>> happening to several users with this release so we immediately rolled
>> back.
>
> It is definitely related to the split commit-graph during the
> upgrade scenario. Your verify output shows that you are using
> the --split option heavily (possibly with fetch.writeCommitGraph?
> or are you using 'git maintenance run --task=commit-graph'?)

Yep, the splits come from fetch.writeCommitGraph.

[...]
>> - what is the recommended way to recover from this state?  "git fsck"
>>   shows the repositories to have no problems.  "git help commit-graph"
>>   doesn't show a command for users to use; is
>>   `rm -fr .git/objects/info/commit-graphs/` the recommended recovery
>>   command?
>
> That, followed by `git commit-graph write --reachable [--changed-paths]`
> depending on what they want.

Can we package this as something more user-friendly?  E.g.

	git commit-graph clear
	git commit-graph write --reachable

If that makes sense to you, I'm happy to send a patch (or to review
one if someone else gets to it first).  I'm mostly asking to find out
whether this matches your idea of what the UI should be like.

>> - is there configuration or a patch we can roll out to help affected
>>   users recover from this state?
>
> If you are willing, then take v2 of this series and follow through by
> clearing the commit-graph files of affected users. Note that you can
> be proactive using `git commit-graph verify` to see who needs rewrites.

Does this mean we should change the BUG error message to help affected
users discover how they can recover for themselves (for example, using
commands like the above)?

Also, should "git fsck" call "git commit-graph verify" to make the
latter more discoverable?

Thanks,
Jonathan
