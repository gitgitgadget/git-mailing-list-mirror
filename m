Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95B7CC433EF
	for <git@archiver.kernel.org>; Thu, 14 Oct 2021 18:52:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78CCF60F36
	for <git@archiver.kernel.org>; Thu, 14 Oct 2021 18:52:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231549AbhJNSyz (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Oct 2021 14:54:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230488AbhJNSyy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Oct 2021 14:54:54 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABEF3C061570
        for <git@vger.kernel.org>; Thu, 14 Oct 2021 11:52:49 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id g14so6281608pfm.1
        for <git@vger.kernel.org>; Thu, 14 Oct 2021 11:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Y5VEsKsNxJDr/ykIzvrPOrgMp/FL7l1dOXsPBtqa5po=;
        b=p7bE+IdHNM/bKABfiw/liy9Z2nRWS7bzQZNOcJdpw8ZcyHgxvN+5nB7TjnhaNq4gkY
         LHqO9FVQGf9lu2sVI5iXn3H1zWmPt25xch4Rxdnj869XYhdJFFGHCnC1kn4VDjpyk4mU
         Th7dqIibpNH5ftDHIppwTeZmI2dtSxZTE3KRiKUkC05As3dRZvhZiaCn10OPYWoagYgO
         mz72mPCCcvpXs+kMiQdGIgIPiSsno/GaQ7zhL/Heue34XZH0n+erfymaLdXstu1LRqU0
         +3ToA8+8Sk9Cfqs9mj02+lg6tvPb6ND6BESRYPmhkZO4QkQTzb47MzPS5/8fnaMlRPXW
         Tywg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Y5VEsKsNxJDr/ykIzvrPOrgMp/FL7l1dOXsPBtqa5po=;
        b=DDa2atFAcbeVrrmGeCVp5T3Jg5kXfkv0oJTxWoWSulKekwdYPMLSNYEiZ13If33hOR
         n9BzvTrJamO+kENpoXX0S5mfDd8ur49EzT7R80I9YkhrdTD9teG2myOtHQzDNrVmlfE4
         OYd94r5gNnjIdQEr7oCN0DCFGvYlpTCnBs4hf8S1tJ1/AfCaR25S32HqWMIXmzfZ6io5
         W4Cv4O8VRQg+mKK/+3sHXjf7Esm9d3vB5921egLcY4ahjA1BDb94QjljU8QrWW57s1yT
         sL11FIW3p1ZxwVQPSyQBEUkNro0MNOeNUpkShPUjvaEGfP+ocRNs4HhawugnkArVVXEW
         cBTw==
X-Gm-Message-State: AOAM5330j14RGVF2Jef4FeHrsa15tnQ/DQOSUNcWkq8DBOdlkVTGNhQQ
        U7ZQjl2eSiAN+FbwGnYj6O/zaQ==
X-Google-Smtp-Source: ABdhPJxI9RVoPsCExTvTiko+mpvewmDUGH20HyiBOBJnv6WS2LzUWHk+HM03nl+jQmOv5S/1ksbBgQ==
X-Received: by 2002:a05:6a00:1944:b0:438:d002:6e35 with SMTP id s4-20020a056a00194400b00438d0026e35mr7070054pfk.20.1634237568884;
        Thu, 14 Oct 2021 11:52:48 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:e9ae:673a:ec5:a064])
        by smtp.gmail.com with ESMTPSA id h22sm3033409pfc.116.2021.10.14.11.52.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Oct 2021 11:52:48 -0700 (PDT)
Date:   Thu, 14 Oct 2021 11:52:42 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org, Albert Cui <albertcui@google.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH v3 0/4] cache parent project's gitdir in submodules
Message-ID: <YWh8ej9rWnxCBCKJ@google.com>
References: <20210819200953.2105230-1-emilyshaffer@google.com>
 <f5197594-550f-3bd8-2d22-c9e1b3e161fd@gmail.com>
 <YWcquctPsrRm964k@google.com>
 <461f5fa8-42a4-b9a0-b223-7f97b764efd0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <461f5fa8-42a4-b9a0-b223-7f97b764efd0@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 14, 2021 at 01:12:11PM -0400, Derrick Stolee wrote:
> 
> On 10/13/2021 2:51 PM, Emily Shaffer wrote:
> > On Thu, Aug 19, 2021 at 09:09:46PM -0400, Derrick Stolee wrote:
> >> but I do have some concerns that
> >> we have not covered all the cases that could lead to the relative path
> >> needing an update, such as a 'git checkout' across commits in the super-
> >> project which moves a submodule.
> >>
> >> Leading more to my confusion is that I thought 'git submodule update'
> >> was the way to move a submodule, but that does not appear to be the case.
> >> I used 'git mv' to move a submodule and that correctly updated the
> >> .gitmodules file, but did not run any 'git submodule' subcommands (based
> >> on GIT_TRACE2_PERF=1).
> > 
> > During a live review a few weeks ago it was pointed out, I forget by
> > who, that this whole series would make a lot more sense if it was
> > treated as the path from the submodule's gitdir to the superproject's
> > gitdir. I think this would also fix your 'git mv' example here, as the
> > submodule gitdir would not change.
> 
> I think that's a great way to deliver similar functionality without
> the issues I was thinking about.
> 
> >> You mention in an earlier cover letter that this config does not need to
> >> exist, but it seems to me that if it exists it needs to be correct for us
> >> to depend on it for future features. I'm not convinced that we can rely
> >> on it as-written, but you might be able to convince me by pointing out
> >> why these submodule movements are safe.
> > 
> > Yeah, that is a good point, and I wonder how to be defensive about
> > this... Maybe it makes sense to BUG() if we don't find the
> > superproject's gitdir from this config? Maybe it makes sense to warn
> > (asking users to 'git submodule update') and erase the incorrect config
> > line?
> 
> I think we can complain with something like a die() if the config points
> to data that doesn't make sense (not a .git directory), but a BUG() is
> too heavy-handed because it can just be a user modifying their config
> file incorrectly.

Ok. Having re-thought since the other day, I think I will skip the
wrapper for this reroll and instead propose it in a series that actually
uses this pointer (so, the shared submodule-and-superproject config), if
it looks like we'd want one. I expect doing that work in the context of
a caller will make the correct behavior a little more clear - in the
context of this series I'm not totally sure what we'd want to do.

> 
> I'm happy to shut down a process because a user messed with config
> incorrectly. Since your proposed change allows operations like 'git mv'
> to move submodules without needing to change this config, I'm much
> happier with the design. It becomes impossible for the config to get
> out of sync unless the user does something outside of a Git command.

Thanks for pulling the context back up here. I appreciate it. Like I
mentioned in reply to your comment on v4, look for a reroll in the next
30 minutes or so (assuming the CI passes ok).

 - Emily
