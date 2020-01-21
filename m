Return-Path: <SRS0=4+BP=3K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92C86C32771
	for <git@archiver.kernel.org>; Tue, 21 Jan 2020 00:57:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E9532253D
	for <git@archiver.kernel.org>; Tue, 21 Jan 2020 00:57:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iWtodh9o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728827AbgAUA5q (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Jan 2020 19:57:46 -0500
Received: from mail-yb1-f196.google.com ([209.85.219.196]:46469 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727009AbgAUA5q (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Jan 2020 19:57:46 -0500
Received: by mail-yb1-f196.google.com with SMTP id p129so594176ybc.13
        for <git@vger.kernel.org>; Mon, 20 Jan 2020 16:57:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+dc8sersxvx2vJVY7JprUanWQ5oCfhzJasr9l5/8IiU=;
        b=iWtodh9oYM5riOhoUUiIfx/bqz8b3FHJ6sarFQLXQ6CJXjB4cfTAKZdrGA45/rO5rF
         fedA4+VzesH5nS7W4pTL4/rK8n/S5QGr+p3yAQeYHBLq6s87bqg8+rMk5mXkQ3/ilCHv
         NA3V9WmskjMGcxvSr+ZqQYXyKSIxrTRjlrYUiZHM4fu6P8+f9SudftmpImX1QG8URagn
         HomHmi7b8bvTs2rdDT6CrfGqPSBV3pHiy0F5bXfJE0LEK5XWv8ttV9x9V8897cOTZUz4
         UWTWPgfAXEsUCRbZxMFl3utBw+531OAodGtmr46uA8O/XeYsY6K7mkKryEy9coqIf0Om
         s/6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+dc8sersxvx2vJVY7JprUanWQ5oCfhzJasr9l5/8IiU=;
        b=JZp1Zk8bd0Ae6uid/T9f8wjT23a/53+7p9p1pJRV+879I5hsIEnVXMLTFfWa249RHg
         QIFfUNsXnzllQ+IK9q/lvXgLh8i+yp+FbKf71zRbAjGNKkNZMHn8eY+1Prua00YiKUd8
         NGYxIJ9DX4lhoXGKuBSwm7vkMR1tN/kJboOFJll4tfrExqaFeI9BLLhQDyYSNvj+NrcM
         hAkOIm17dRLHDUitjpvFm8ySsxqIjQF/+fwrs0DiqA8PFyo/GQgwPqVonyxbOK51jRI2
         5YYATEgo4lVMkqxpBgCd/EwH8zp46apcPVz9BG7UwA4uuIPtKhUR/YmFDQTdc1c1CLyD
         L2lQ==
X-Gm-Message-State: APjAAAVQPpR62Ro+PrNsOOK+oPowLqmRq2S/kYYu59CBeMYAAOOFCCb1
        8q3IsxusfaYb5qoT9rj4IRnfkmSQVbA=
X-Google-Smtp-Source: APXvYqxQJonzQuvDI8Dbqbjq8kf1c6BHCCaxCJqsWsMmhfDseycI+pOlt3yZjSy46we0Yvne+yKAzw==
X-Received: by 2002:a5b:54c:: with SMTP id r12mr1962560ybp.70.1579568265194;
        Mon, 20 Jan 2020 16:57:45 -0800 (PST)
Received: from [192.168.1.83] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id t206sm8967390ywe.62.2020.01.20.16.57.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jan 2020 16:57:44 -0800 (PST)
Subject: Re: [PATCH] fetch: add --no-update-remote-refs
To:     Jeff King <peff@peff.net>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, jrnieder@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.532.git.1579274939431.gitgitgadget@gmail.com>
 <20200117192016.GB11358@coredump.intra.peff.net>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <4e444a99-6785-1d11-d8cf-87903c3b3760@gmail.com>
Date:   Mon, 20 Jan 2020 19:57:43 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:72.0) Gecko/20100101
 Thunderbird/72.0
MIME-Version: 1.0
In-Reply-To: <20200117192016.GB11358@coredump.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/17/2020 2:20 PM, Jeff King wrote:
> On Fri, Jan 17, 2020 at 03:28:59PM +0000, Derrick Stolee via GitGitGadget wrote:
>> Add a --[no-]update-remote-refs option to 'git fetch' which defaults
>> to the existing behavior of updating the remote refs. This allows
>> a user to run
>>
>>   git fetch <remote> --no-update-remote-refs +refs/heads/*:refs/hidden/*
>>
>> to populate a custom ref space and download a pack of the new
>> reachable objects. This kind of call allows a few things to happen:
> But I think there's already a way to do that: the --refmap option added
> by c5558f80c3 (fetch: allow explicit --refmap to override configuration,
> 2014-05-29). Using an empty refmap like:
> 
>   git fetch --refmap= <remote> refs/heads/*:refs/hidden/*
> 
> should do what you want. It suppresses the use of the configured
> refspecs, so we don't find any opportunistic mappings to make.

You're absolutely right. There are details at [1].

The tricky thing is that the documentation makes it look like you
need a value there, and if you supply a value without a refspec
argument, an error is given:

$ git fetch origin --refmap="+refs/heads/*:refs/hidden/origin/*"
fatal: --refmap option is only meaningful with command-line refspec(s).

I think I'll follow up with a documentation patch to point out
that an empty --refmap value will ignore the configured refspec
and rely only on the provided refspec argument.

Thanks!
-Stolee

[1] https://git-scm.com/docs/git-fetch#_configured_remote_tracking_branches_a_id_crtb_a
