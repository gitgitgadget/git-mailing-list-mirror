Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1CA331F453
	for <e@80x24.org>; Wed, 31 Oct 2018 03:05:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728857AbeJaMBn (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Oct 2018 08:01:43 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38464 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728157AbeJaMBn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Oct 2018 08:01:43 -0400
Received: by mail-wr1-f66.google.com with SMTP id d10-v6so14789016wrs.5
        for <git@vger.kernel.org>; Tue, 30 Oct 2018 20:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=Pgt+H/KZIidSb5YA4v6mZ14Xw8oJ2n+wCqziLGzKKsM=;
        b=jm48pYo6cPZHHl2goCJN9cWkP31ihA/PEsRDi6yOJ1lxHP3E4ZrCOOFaYEFlvJ2oi1
         yqnAT7Q+gqEUMuSFdLM3M3EVBojboQn/0ffTjPibv+HDwzJtTSU5yEGC99gpr082ZNUd
         DcGkzkVtx1rp0jXhGWyLp8TF8m5P2MIn28g/X6vL7SLTDxiGNiGw6u20mhDwgTNyXsgC
         ndgQLbRZCcDvYdXJ/U7HOGsVF1uh3bLV2nPJSUA38thHyYFqZpxE5hlKxabULVMSoWtC
         5HH0Nli9BPZRKoOYiEr/4IDzruJr5i3XkjUwUNibRwI93Yp+HQsh4/uCtHwUl3BTNn2S
         wHPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=Pgt+H/KZIidSb5YA4v6mZ14Xw8oJ2n+wCqziLGzKKsM=;
        b=YNwfgU+y5EdxNTsoKS+4PzVa0beifVcjqB4tERZNdiTlr7SS4kH1a4f6V3OOcHYag2
         QCj8F53SRDO3qFc9lJ2dUXeRxLW/yhSWgiPwxShB4uXx0hEQcK3O/IPbFPPEFp7JitDT
         YZAT5fUjEVL3z3iEI7qjYZFFY9vBU7/t7uf9lFl1h7lDvI+mS91cigHiVwU/TPSgTon/
         OJlKzhrTZkmHDKya18yYCERz9BJE2zcWq9fpDEH5bAP+MnREZT+fKiEJyKKlM0HdV6aX
         lBeRWlDZ9XSQz0Bexjm3EYH5s0dY64PijpM3YLs28B8+v19RcH7PxcRT6Lpd3kX/qY3A
         O6BA==
X-Gm-Message-State: AGRZ1gJg1S4TQSM1gl+QnAQOQvVg0kTwvryG9Bd5LBpesncO5Q5d4arJ
        lpxzNQGkeoP04c1KekRtUw0=
X-Google-Smtp-Source: AJdET5epzMGzp7km6QUDD9BtGceihX108v+FFz8BIMVkwKzZOvpLMIKgGnnkH7sSwvHOOZ7z9PqGuw==
X-Received: by 2002:adf:f00a:: with SMTP id j10-v6mr967944wro.170.1540955135494;
        Tue, 30 Oct 2018 20:05:35 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id 60-v6sm19238024wra.35.2018.10.30.20.05.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 30 Oct 2018 20:05:34 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net, newren@gmail.com
Subject: Re: [PATCH 0/3] Make add_missing_tags() linear
References: <pull.60.git.gitgitgadget@gmail.com>
Date:   Wed, 31 Oct 2018 12:05:33 +0900
In-Reply-To: <pull.60.git.gitgitgadget@gmail.com> (Derrick Stolee via
        GitGitGadget's message of "Tue, 30 Oct 2018 07:16:02 -0700 (PDT)")
Message-ID: <xmqq7ehyzugy.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Add a new method in commit-reach.c called get_reachable_subset() which does
> a many-to-many reachability test. Starting at the 'from' commits, walk until
> the generation is below the smallest generation in the 'to' commits, or all
> 'to' commits have been discovered. This performs only one commit walk for
> the entire add_missing_tags() method, giving linear performance in the worst
> case.

;-)

I think in_merge_bases_many() was an attempt to do one half of this
(i.e. it checks only one 'to' against main 'from' to see if any of
them reach).  I wonder why we didn't extend it to multiple 'to' back
when we invented it.

In any case, good to see this code optimized.

Thanks.
