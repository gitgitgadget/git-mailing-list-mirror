Return-Path: <SRS0=nsHh=4C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BB8FC35242
	for <git@archiver.kernel.org>; Fri, 14 Feb 2020 22:00:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEFB72081E
	for <git@archiver.kernel.org>; Fri, 14 Feb 2020 22:00:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OE2vFMVQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387502AbgBNWAL (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Feb 2020 17:00:11 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:38450 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728911AbgBNWAL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Feb 2020 17:00:11 -0500
Received: by mail-pg1-f195.google.com with SMTP id d6so5597991pgn.5
        for <git@vger.kernel.org>; Fri, 14 Feb 2020 14:00:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Z7tR/NR7dMlJ6sWV+2vubwy0/H73I+p0jtAEo2lWwH0=;
        b=OE2vFMVQ1jWLR1sG/C10Z+PXgJZ8rPvFfVnoGaoqnL8Se/mKzjSbadXSCq99KsVnux
         qp4t2gPzmSOy8CPDNwSPpNd8vPVDrLlYDu85SbEPm0GpjEn/vGuOL4JbxL1kM1ERsA3P
         Ncmy374WZOYzX/O03KZNq+Ktcf0acFZ7ZMZILg+0K8lQxEbWE30oneO5j9vkvGqTCnyk
         aW+0kpBH5328b35x2fimb5EuihBcvNco0vTKG72P5I6Pqh20o79S9soEcF1bTFt5CCl8
         EqYH5NxXgN8vY4lbrIUF9zhMq3y6Qmt0GsdyG/MhFcOw0YjDe9oCI8ZtzHJo1n5k1+l7
         oCUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Z7tR/NR7dMlJ6sWV+2vubwy0/H73I+p0jtAEo2lWwH0=;
        b=UqupsMqmYKdBGo9Scc219dqO5CiO95AQ9I36D/K/EGxjxSw2ZOu6ssxjGre3jzW6DA
         NNYHnSR1jlgnmydYdWtnekl1blNfZWSmAEMpCCJObR6gfX7tYP17ytMhfyCArnwRgDku
         wdqtUBayO1LSpce551/PDS3KlHt2SipCaZQv+w/0L2lbIysWfrZImE67FT9PjZ7vjvvx
         qAquoiHZ5WX0i6E0Sme+lTttlD0YLXd5Ng0XLh9TdOmELO2OT099qS4B0wPZrfdi2Q7q
         3NVv133pfAbkOAG7T1k6CaJTkPozQ7IuojGgqanesV1IOWznexWWTArQmbSWa5p4ESOk
         wqAA==
X-Gm-Message-State: APjAAAU8ebDxppZp87RmGBgayhiKsDmw60HNeeqDe3n2Q6F+ZX2+rdYG
        BlV8DD9NtYOjnMkOK2US5Ya7Ug==
X-Google-Smtp-Source: APXvYqxJWArdH3F0VRs4DiAGwM3qO0bKjRRv15BL1q6WBE16opjtIWBVYPFqHpQkyTPNPU0b87g8sw==
X-Received: by 2002:a62:5447:: with SMTP id i68mr5596398pfb.44.1581717609675;
        Fri, 14 Feb 2020 14:00:09 -0800 (PST)
Received: from google.com ([2620:15c:2ce:0:231c:11cc:aa0a:6dc5])
        by smtp.gmail.com with ESMTPSA id b98sm7837176pjc.16.2020.02.14.14.00.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2020 14:00:08 -0800 (PST)
Date:   Fri, 14 Feb 2020 14:00:03 -0800
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Martin =?iso-8859-1?Q?=C5gren?= <martin.agren@gmail.com>,
        Aaron Schrab <aaron@schrab.com>,
        Danh Doan <congdanhqx@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>,
        Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [PATCH v7 00/15] add git-bugreport tool
Message-ID: <20200214220003.GL190927@google.com>
References: <20200214015343.201946-1-emilyshaffer@google.com>
 <xmqqv9o9nkh3.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqv9o9nkh3.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 14, 2020 at 09:32:08AM -0800, Junio C Hamano wrote:
> Emily Shaffer <emilyshaffer@google.com> writes:
> 
> >    present(patch 9/15). This now uses POSIX character classes and {}
> >    notation instead of + and has been tested on OSX; I'd love to hear if
> 
> I'd rather not to see unnecessary uses of POSIX character classes.
> 
> The interdiff of this step between the previous and this round looks
> to me more like "I used it, just because POSIX says I *can* use it",
> not "I did so because I needed to do, and it should be OK on POSIX
> platforms."
> 
> Instead of overly long
> 
> 's/^\([^[:blank:]]*\)[[:blank:]]\{1,\}annotate:bugreport\[include\].* ::$/  "\1",/p'
> 
> just limiting ourselves to SP and saying
> 
> 's/^\([^ ]*\)  *annotate:bugreport\[include\].* ::$/  "\1",/p'
> 
> would keep the result much easier to read, I would think.

That's fine by me. I find the [[:syntax:]] extremely ugly, but I was
worried about whether that was more portable somehow. Your proposal
seems fine to me.

 - Emily
