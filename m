Return-Path: <SRS0=EOdt=3U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 020ACC2D0DB
	for <git@archiver.kernel.org>; Fri, 31 Jan 2020 18:04:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB61021734
	for <git@archiver.kernel.org>; Fri, 31 Jan 2020 18:04:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NLdRid4n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727080AbgAaSES (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 31 Jan 2020 13:04:18 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51269 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726712AbgAaSER (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Jan 2020 13:04:17 -0500
Received: by mail-wm1-f67.google.com with SMTP id t23so8966219wmi.1
        for <git@vger.kernel.org>; Fri, 31 Jan 2020 10:04:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0UT75oKRdAEkWzyWZ51dVhnPVQZp2Z7eAeK6wiKwk5c=;
        b=NLdRid4nZntW1DZv9oKQK8s+RPlqPbcuYkAGpK3mmphGK2jlCu2QDe55zugrq0VoPg
         9cC7r4LzbHOpE5BV0kzLxgDn9YenacNAfs71v04hawcMnvs8NDlQU9UlsajgWI4j7Tt9
         y9nMZBIFBxAUercTeRqLyP30hLy0MfozWkKrWxEiLCoutNcL9S3JYzXNYce5EVWyrYhC
         E3hUpVgAaDaL03X6MLS2TQGbSGvBMC6YlrV28tAw7eUYbwZYn1GiRGUEPmB1GCOu7QjB
         jmgfYPep6l2uGFdKkHkJ0J66g9U8APNFlQmwXQeB6q6gShIN+2gDPQQnZ+GWX2bkxph7
         oP8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0UT75oKRdAEkWzyWZ51dVhnPVQZp2Z7eAeK6wiKwk5c=;
        b=QTotTCeMqJZCkt0RHSStMKMBL2g/N1Ya93/7CBDPy3BUGnsm2PCjKJb0tILAx0waSo
         Q5K9Fc44hRfql2Z4DPqMvuCjdzLKgx4jrt2PSVpa93Zbo2ivGFKwvuSFcGKG4S6AIE39
         iKfHEQRB9Y4Lgt5Pt3UosT1Nkay1MDoyUiddG0knF1g/FyhFRH6km95SFnGs7TPWmB8z
         5//vDhenk5lxcQsyTJCO+N2vbeLvSQ63VjoniRTdH0Hv9+PpjsJpGimqxa0FIG1l8jov
         CyqGL/UAX7NpFQy98gX96HsCRHi5oU3RCLie3+7WA6X4MNyceBfVm04/Av0XWINW5hf/
         VjPQ==
X-Gm-Message-State: APjAAAVJiJ/SG6+BbJvjP7izH/DA59oSw7hNSAX76K35tznQF+OoMRd5
        KlUeXrNEC2k9TjvVlc/861fJ1eTI
X-Google-Smtp-Source: APXvYqyHkmzLfxM/BbqBkJ05RLXVcZf84kn0rb10amw7M9UJozYl3V0zGYA+fJTJSkLTPi3yVxxCDw==
X-Received: by 2002:a05:600c:1007:: with SMTP id c7mr13151154wmc.158.1580493853722;
        Fri, 31 Jan 2020 10:04:13 -0800 (PST)
Received: from szeder.dev (x4db61755.dyn.telefonica.de. [77.182.23.85])
        by smtp.gmail.com with ESMTPSA id b17sm13147844wrp.49.2020.01.31.10.04.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 Jan 2020 10:04:12 -0800 (PST)
Date:   Fri, 31 Jan 2020 19:04:09 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Martin Melka <martin.melka@gmail.com>,
        Samuel Lijin <sxlijin@gmail.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 3/6] dir: fix confusion based on variable tense
Message-ID: <20200131180409.GI10482@szeder.dev>
References: <pull.700.git.git.1580335424.gitgitgadget@gmail.com>
 <e6d21228d126d62fafdde185c180f9f5ba64c458.1580335424.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e6d21228d126d62fafdde185c180f9f5ba64c458.1580335424.git.gitgitgadget@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 29, 2020 at 10:03:40PM +0000, Elijah Newren via GitGitGadget wrote:
> From: Elijah Newren <newren@gmail.com>
> 
> Despite having contributed several fixes in this area, I have for months
> (years?) assumed that the "exclude" variable was a directive; this
> caused me to think of it as a different mode we operate in and left me
> confused as I tried to build up a mental model around why we'd need such
> a directive.  I mostly tried to ignore it while focusing on the pieces I
> was trying to understand.
> 
> Then I finally traced this variable all back to a call to is_excluded(),
> meaning it was actually functioning as an adjective.  In particular, it
> was a checked property ("Does this path match a rule in .gitignore?"),
> rather than a mode passed in from the caller.  Change the variable name
> to match the part of speech used by the function called to define it,
> which will hopefully make these bits of code slightly clearer to the
> next reader.

Slightly related questions: Does 'excluded' always mean ignored?  Or
is it possible for a file to be excluded but for some other reason
than being ignored?

I'm never really sure, and of course it doesn't help that we have both
'.gitignore' and '.git/info/exclude' files and conditions like:

> +		if (excluded &&
> +		    (dir->flags & DIR_SHOW_IGNORED_TOO) &&
> +		    (dir->flags & DIR_SHOW_IGNORED_TOO_MODE_MATCHING)) {

