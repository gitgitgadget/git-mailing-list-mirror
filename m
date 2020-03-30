Return-Path: <SRS0=sJPh=5P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EF7FC43331
	for <git@archiver.kernel.org>; Mon, 30 Mar 2020 00:40:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE233206DB
	for <git@archiver.kernel.org>; Mon, 30 Mar 2020 00:40:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YNVyBb5Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727805AbgC3AkA (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 29 Mar 2020 20:40:00 -0400
Received: from mail-qk1-f178.google.com ([209.85.222.178]:46922 "EHLO
        mail-qk1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727612AbgC3AkA (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Mar 2020 20:40:00 -0400
Received: by mail-qk1-f178.google.com with SMTP id u4so17308746qkj.13
        for <git@vger.kernel.org>; Sun, 29 Mar 2020 17:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=64rS8eQXdPlA5JWW1uT7DonW71STDgLqmNPYVqgnsug=;
        b=YNVyBb5QeyVV3gtMppVwIYOhhAYjP87VNNwOMmjyMxiXs4F6oWwYcb5Vu8kc0qURsz
         BSd8UlQIlaSvi7S9e5WGWCp1tI/oOb2Ol8CEbwpkeRgMGGGqUw2or1mBmOAKsz54i/fE
         6S+ZLTkcOgG3nk7+EEHZG5Wzk0X9wdYbdFWKddyUzice6YQN/iEiVzyaf40bDEZ6hBjz
         IcfHYMtVlhjkXXGd0DgB29KqBlDDt1VV0xTEViUOxSQBWuDXAlZHnpuzdWl2As3lRTWM
         S/X+9tUt2M/dNSnNfiRbczCApYTOtA991QwaFpNoCTwakYp/A911VBvEAxkfeBpYNoox
         /QWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=64rS8eQXdPlA5JWW1uT7DonW71STDgLqmNPYVqgnsug=;
        b=fSdJfvUiZme1NLNBbdOTEETljh3thITfBfQEyS94YJSYWdbR4qvsaKeOK6ZjbZaMOc
         tjAYtvE7dOowmFwk0tCnlHpFuE2rACzJlGsvUz1o4LKfuWCc9j16t1rJeTCwArqWZRy7
         hI3okUs+jIwHnC9k+sqUqsgw23UGmTX3iYH6g8qyl2UJRJR5U0yVPdloUjHssP6cvxMt
         ddQWBCCGC2hxNc4rbS2CKRKmNzVAUHvW0yDpAxoYfZxLOWhu5AAz1cpeR3D2+AUpmu35
         S1nVAGvkMsvJle3gZXr4Y53P6Un2rln5zGG5l0YGsDrS9SXNqyUokKbTxolLwFDTDRJr
         oRqQ==
X-Gm-Message-State: ANhLgQ2yyxp59/ffbkiM2KpxNS4f2UULMSsxzJLYJ2dG8AhaUI3PjQPX
        XkUcphTJr/saPzF7Kq0u5bjGUc1U
X-Google-Smtp-Source: ADFU+vvJ9g4ZtBT8MfYmE+RpzX7BDJeELnimvqSBFTNraFGP3rDHZ8RcsQFUKAyLXAVYh56M9DkT0w==
X-Received: by 2002:a05:620a:1ed:: with SMTP id x13mr9638245qkn.70.1585528799099;
        Sun, 29 Mar 2020 17:39:59 -0700 (PDT)
Received: from ?IPv6:2600:1700:b00:7980:b167:ffec:b036:493e? ([2600:1700:b00:7980:b167:ffec:b036:493e])
        by smtp.gmail.com with ESMTPSA id 77sm9194470qkh.26.2020.03.29.17.39.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 Mar 2020 17:39:58 -0700 (PDT)
Subject: Re: What's cooking in git.git (Mar 2020, #09; Sun, 29)
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqqlfniakli.fsf@gitster.c.googlers.com>
From:   Garima Singh <garimasigit@gmail.com>
Message-ID: <6b61fec4-3334-8bfc-d4b8-3921e35cf6a6@gmail.com>
Date:   Sun, 29 Mar 2020 20:39:58 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <xmqqlfniakli.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/29/2020 5:59 PM, Junio C Hamano wrote:
> Here are the topics that have been cooking.  Commits prefixed with
> '-' are only in 'pu' (proposed updates) while commits prefixed with
> '+' are in 'next'.  The ones marked with '.' do not appear in any of
> the integration branches, but I am still holding onto them.
> 
> You can find the changes described here in the integration branches
> of the repositories listed at
> 
>     http://git-blame.blogspot.com/p/git-public-repositories.html
> --------------------------------------------------
> [Stalled]
> 
> * gs/commit-graph-path-filter (2020-02-12) 12 commits
>  - (bytesex breakage band-aid)
>  - commit-graph: add GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS test flag
>  - revision.c: use Bloom filters to speed up path based revision walks
>  - commit-graph: add --changed-paths option to write subcommand
>  - commit-graph: reuse existing Bloom filters during write.
>  - commit-graph: write Bloom filters to commit graph file
>  - commit-graph: examine commits by generation number
>  - commit-graph: examine changed-path objects in pack order
>  - commit-graph: compute Bloom filters for changed paths
>  - diff: halt tree-diff early after max_changes
>  - bloom: core Bloom filter implementation for changed paths
>  - commit-graph: use MAX_NUM_CHUNKS
> 
>  Introduce an extension to the commit-graph to make it efficient to
>  check for the paths that were modified at each commit using Bloom
>  filters.
> 
>  Expecting a reroll.
>  cf. <fdcbd793-57c2-f5ea-ccb9-cf34e911b669@gmail.com>
>  Breakage due to byte-order dependency reported.
> 

Hey Junio,

I just sent out v3 of this series. 
Thanks for the patience and letting this bake in pu. 

Hope you and everyone on here is staying safe and healthy in 
these trying times.

Cheers,
Garima Singh

