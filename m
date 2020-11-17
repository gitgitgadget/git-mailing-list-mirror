Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8859C63777
	for <git@archiver.kernel.org>; Tue, 17 Nov 2020 01:07:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7857A2468B
	for <git@archiver.kernel.org>; Tue, 17 Nov 2020 01:07:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oqpDnfcU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730418AbgKQBHR (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Nov 2020 20:07:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726156AbgKQBHP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Nov 2020 20:07:15 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E27CC0613CF
        for <git@vger.kernel.org>; Mon, 16 Nov 2020 17:07:15 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id y7so15823377pfq.11
        for <git@vger.kernel.org>; Mon, 16 Nov 2020 17:07:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=CP24UyRkRWP7U7L7B8D6Y7tbPIy/kW1tNLypDYTJJFU=;
        b=oqpDnfcUdWnKAG8Cnd/HEmW43cIq/S3PhmelDzJJGjcFvFN1vnx5Fw12DINvl5jxbb
         hkwsemYXXyZGBEFKmK0BfP+sPyh6XNOhet7571IR5oYfqHB96ob4Y1syFeB2Nxoc+4jT
         W4ZJ2GMHcGWpbpQdREgb+cw5+zAsRW0YVbo1tKlp5auhSo6uI+c/kijhxvcVO/WsCLWy
         7LRU9Hu2SpJm1/K6U1sMoLqP5KdYamt982GUSvwVsiI5mHBWxyKRk/HYhRjmANtNbGN/
         QUV45mHIeqfFbyLeGeNu0WboHyp1O4wDEaYXotA098ekF1sU6wRmDryjktnXu5WNC2/n
         5LDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CP24UyRkRWP7U7L7B8D6Y7tbPIy/kW1tNLypDYTJJFU=;
        b=nqB8YWAwj00QDFX6668Q/sO1vP/PsKzFwzz5fKtx0GbZpibofiiySv99WWCVLRY5R0
         4Ae/4qyT2lG4PsFacfRnW32wDhzl80Fr5jdfKTCsweNy5fzrQCevGcH9CRmTeFfLmArF
         /8J5KtrrxJfPMtsg8KS4euqcDJSbzqsHOgaFdo0Vmi8CqpRBwfQIJnwUxTYRXLdR9A7r
         XspGBXVFeJL25LpFhQDelPdBDDQA5ex9i0xLnmC1R+Kvexo/ChEYvl/TxZKSSaFJMvq2
         SHCzfb/wNCo+WAAUfclhp4RC+iXfql2o+WGZD/HqPiDv6S17a6KJJ/TH0WSFvjNic/Aa
         1wCA==
X-Gm-Message-State: AOAM5301be2f6ieTHzuldMWKD4kKacTmxtf23Z3GhgjSTS86ZHrNjaHp
        9YAWqms5Tjxa5BXAdTc3rmvjtA==
X-Google-Smtp-Source: ABdhPJyJ4PWKyEeeHFhJRpcznhXkv6gHproVl51iVlEWpt0CqjgzdbRg0TSOf1renta8pUb8hl0t0Q==
X-Received: by 2002:a63:c945:: with SMTP id y5mr1548889pgg.118.1605575234849;
        Mon, 16 Nov 2020 17:07:14 -0800 (PST)
Received: from google.com ([2620:15c:2ce:0:1ea0:b8ff:fe77:f690])
        by smtp.gmail.com with ESMTPSA id x18sm18428827pfi.206.2020.11.16.17.07.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 17:07:14 -0800 (PST)
Date:   Mon, 16 Nov 2020 17:07:09 -0800
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee <stolee@gmail.com>, git@vger.kernel.org
Subject: Re: ds/maintenance-part-3 (was Re: What's cooking in git.git (Nov
 2020, #02; Mon, 9))
Message-ID: <20201117010709.GB15562@google.com>
References: <xmqq7dqu9jwh.fsf@gitster.c.googlers.com>
 <d0123439-236c-1a62-294b-a3373465eadb@gmail.com>
 <20201116235642.GA15562@google.com>
 <xmqqh7po7r3w.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqh7po7r3w.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 16, 2020 at 04:40:35PM -0800, Junio C Hamano wrote:
> 
> Emily Shaffer <emilyshaffer@google.com> writes:
> 
> > Because 'git maintenance unregister' spins a child process to call 'git
> > config --unset maintenance.repo <cwd>', it actually fails if "cwd"
> > contains a POSIX regular expression special character:
> >
> >   git config [<file-option>] --unset name [value_regex]
> 
> Good find.  And it is even worse that value_regex uses ERE, not BRE,
> which means even an otherwise innocuous letter like '+' cannot be
> used without quoting.

I should have mentioned in the first letter than Jonathan Nieder was the
one who made the jump from "this is breaking in the buildbot but not
locally" to regular expression metachars. Credit where it's due.

> 
> > You can demo it for yourself like so:
> >
> >   git init repro+for+maintenance
> >   git maintenance register
> >   git maintenance unregister
> >   echo $?	# returns '5'
> >   git config --list --global
> >
> > I see two paths forward:
> >
> 
> 0. Quote the value_regex properly, instead of blindly using a value
>    that comes from the environment.
> 
> > 1. Teach 'git config' to learn either which regex parser to use
> > (including fixed), or at least to learn "value isn't a regex", or
> >
> > 2. Don't spin a child process in 'git maintenance [un]register' and
> > instead just call the config API.
> 
> > I'd suggest #2. The config API is very nice, and seems to have a simple
> > way to add or remove configs to your global file in just a couple of
> > lines. If there's a reason why it's not simpler to do it that way, it's
> > my fault for missing the review :)
> 
> My short-to-mid-term preference is to do #1 to allow a value to be
> spelled literally (i.e. remove entry with _this_ value, and add this
> one instead), and optionally do #2 as an optimization that is not
> essential.  I do not offhand know how you can make #2 alone fly
> without doing some form of #1, as I think the same value_regex that
> ought to be ERE to specify entries to be replaced needs to be used
> under the cover even if you use "config API" anyway.

Ah, right you are - I had figured the regex parsing was done earlier,
but it indeed looks to happen in
config.c:git_config_set_multivar_in_file_gently. Thanks.

 - Emily
