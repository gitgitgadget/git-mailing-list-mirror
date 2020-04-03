Return-Path: <SRS0=9X1Y=5T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB241C43331
	for <git@archiver.kernel.org>; Fri,  3 Apr 2020 20:04:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEDE120678
	for <git@archiver.kernel.org>; Fri,  3 Apr 2020 20:04:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="ClNAhLVk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727907AbgDCUEV (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Apr 2020 16:04:21 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:45984 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726460AbgDCUEU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Apr 2020 16:04:20 -0400
Received: by mail-pl1-f195.google.com with SMTP id t4so3148861plq.12
        for <git@vger.kernel.org>; Fri, 03 Apr 2020 13:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TGb4IpdBXr+O52sgNWG+EkPEbHFnolsjfah+hh3giWM=;
        b=ClNAhLVkPvtxKy3nVgRVmA4x5xAhZKbuBQ6OpHBG3X1za8dCXQ+D4j+9TzsxxiOv0Y
         /ANEs6bxGwxNuCXdzS/3zTksYW5hk8hwyl00b98nChfhj/t7vX53YQiDjkkGOJwrDmH0
         RXuzETxOO4z+Zd8w5+lWEe99zE1jsWWZSgZFlJdqBnCeZNHgjCeTFt85fbX5WkwIHs/2
         fbehsRqkZLjbyeOSDbkQF7ZZL1a+qtuOzxPSj0ZUY+skbYptbg/ifiXrZVw8VfFFuwup
         vr45djVMZSKKjfamZkAiOw2+KK4JW97pNvX31PE5A3iJ5y5td+F4LTjHLu7ONT7CikzW
         JiQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TGb4IpdBXr+O52sgNWG+EkPEbHFnolsjfah+hh3giWM=;
        b=UDjyeIuYkH1AqVbtNdJrxqRpTdlSOKqo+OE8FXYLQ/oiVBsYdSQs5p9YHEjX8TPFqz
         bWwYLAOnFvq09uPwkWcAGF5T/ARk+tm+n0ToNMgEWESVVtTmeCHNa8zVlvFGXHp7Golv
         RPS6xxvKprCywCEvN6T4qa5cOKJit6Z973M/1FeF6vtpKNRSsSk2OHtHhgHVNZTcMxgz
         zRAAjAi6pE+SQYft4EYKWhuMp/u6w36yk1zRKfgwzUszLojx9ZH0bON6NKLQN+Q7vaMY
         U+qis6Am5g1S5bP2gQQcIdv0vwufX4MIGP7h6VP3NMfbPhbzj97rMl63bzJ3vRWXRdbd
         SdDw==
X-Gm-Message-State: AGi0PubIuq9vHdvwl64f38g9d0lR3sRtW/a/fsqqYjNjUT9XrgVLXXiE
        01yr8iPN+nxfbglki8AgaSglaA==
X-Google-Smtp-Source: APiQypJ313Vi/JnpxxiJwKFVpZ/mAZzjIJHu57T4sdZ34nwEvy/Nk59Tz++dzqQqV2uncvxlQF6dRA==
X-Received: by 2002:a17:902:7046:: with SMTP id h6mr8956983plt.250.1585944259656;
        Fri, 03 Apr 2020 13:04:19 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id x13sm5573053pfj.185.2020.04.03.13.04.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2020 13:04:19 -0700 (PDT)
Date:   Fri, 3 Apr 2020 14:04:18 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Mar 2020, #10; Tue, 31)
Message-ID: <20200403200418.GA58491@syl.local>
References: <xmqq4ku46s8z.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq4ku46s8z.fsf@gitster.c.googlers.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Tue, Mar 31, 2020 at 04:04:28PM -0700, Junio C Hamano wrote:
> * tb/commit-graph-split-merge (2020-03-24) 3 commits
>   (merged to 'next' on 2020-03-31 at 2183baf09c)
>  + builtin/commit-graph.c: support '--input=graphed'
>  + builtin/commit-graph.c: introduce '--input=<source>'
>  + builtin/commit-graph.c: support '--split[=<strategy>]'
>
>  The code to write out the commit-graph has been taught a few
>  options to control if the resulting graph chains should be merged
>  or a single new incremental graph is created.
>
>  Will merge to 'master'.

I know that this series has been cooking for a while (and that I've
nagged you about merging it down to master), but I think I may ask you
to temporarily eject it until I can send some more patches on top.

In particular, I think that it may be worthwhile to get rid of
'--split=merge-all' and '--input=graphed' in favor of some new patches
that we've been using to introduce a '--split=replace' mode, which
discards the existing graph completely, but writes out a new length-1
incremental commit graph.

I'm not sure if there is general interest in a '--split=merge-all' or
'--input=graphed', and if there is I'd be happy to keep those patches
around, but we've found them to be less useful than the current options
that we're using.

I'll send the '--no-check-oids' patches separately, which I don't think
needs to hold this up.

Thanks,
Taylor
