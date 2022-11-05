Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C2C3C4332F
	for <git@archiver.kernel.org>; Sat,  5 Nov 2022 00:29:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbiKEA33 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Nov 2022 20:29:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbiKEA32 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Nov 2022 20:29:28 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ECB5B84E
        for <git@vger.kernel.org>; Fri,  4 Nov 2022 17:29:27 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id g13so3432651ile.0
        for <git@vger.kernel.org>; Fri, 04 Nov 2022 17:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2or69NhL6Dkjs1IovpiZjpBDKOCSyTQIE4+tREU47hE=;
        b=JBmmCwvmNJmwB3DNWW9VHCr2ysDKS+mGOo/2ongEQ2ChOYaIbRDGOXSPvGi9674GI4
         ovZnM4ajnZ3bKAiLNdXv/ct8idJ1WYjGNnpwFOKkbPadvgv9TKGg8G0dlHuF/8sIkfnz
         q9/saXYBvZM7GOMSUmdnc3RDaq76PoxIPqjsX592qCTC0qxqrwT9hRWQWhP9JYz3YTlk
         zRtWfPSPqixrFJZHnAmrmp34cJVwYAm5kSd4XOuAX7xj968gAwl1kynL6Z5HiTi/unRI
         +aXLBVQ09LCZAF4rP6+l2fVFYKjEGlDFVlG6HvXiGhPALuQ/pHiJdukX9CTHrbLdf2op
         egTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2or69NhL6Dkjs1IovpiZjpBDKOCSyTQIE4+tREU47hE=;
        b=HP6vb1X+5Gyu6rMZE9pLO8Slvsm/sn9SELivwzHo0up7eIONuHtOp1vqBYA2HG/UqT
         KMKGgvbjc6RqATV3X7XZjtRuThxzhin+A9eNquh23/SqBN+iIaDfELrb8F7ZHk0pcZhu
         R3lhs2x5uZHvRCqjyunHPDTmFL3GPZ/82jM9OVfJgbWd80aMyC+JRhn1avUTzgXBQmGz
         Hy1S9WdEpJZ3KzJ9U/jK3SbD2ag8G+fIWv4iXZCg/syjEV05808gjXZlSdTR92kt1eUO
         Rdk6vMwVQoawG46fxzqg5l+T6DLHTW+qS96IaVzfhfZwJ8Lsh9LybM2VpCCDH695av6a
         iXIw==
X-Gm-Message-State: ACrzQf1Vf/b+TrLX/og+43E3gtSfgkqumhxuofBrGWe3ThHGommVNFrH
        AjvEPGzr5qtJuDIL5ix4e1XHbgL58yPWdSCJvlg=
X-Google-Smtp-Source: AMsMyM79snW63WTLfV8vYmxmukUh5LErzYoCY8NTAfScPGC8K4N5Frh8iWnmM+6B+0z9Rn2VdjU2SA==
X-Received: by 2002:a92:2e0e:0:b0:300:a037:caf9 with SMTP id v14-20020a922e0e000000b00300a037caf9mr20107995ile.63.1667608166768;
        Fri, 04 Nov 2022 17:29:26 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id d65-20020a026244000000b00356744215f6sm173699jac.47.2022.11.04.17.29.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 17:29:26 -0700 (PDT)
Date:   Fri, 4 Nov 2022 20:29:25 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Anh Le via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Timothy Jones <timothy@canva.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Taylor Blau <me@ttaylorr.com>, Anh Le <anh@canva.com>
Subject: Re: [PATCH v4 0/2] index: add trace2 region for clear skip worktree
Message-ID: <Y2WuZfur3iorHxdt@nand.local>
References: <pull.1368.v3.git.git.1667177791591.gitgitgadget@gmail.com>
 <pull.1368.v4.git.git.1667516701.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.1368.v4.git.git.1667516701.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 03, 2022 at 11:04:59PM +0000, Anh Le via GitGitGadget wrote:
> In large repository using sparse checkout, checking whether a file marked
> with skip worktree is present on disk and its skip worktree bit should be
> cleared can take a considerable amount of time. Add a trace2 region to
> surface this information.
>
> Anh Le (2):
>   index: add trace2 region for clear skip worktree
>   index: raise a bug if the index is materialised more than once
>
>  sparse-index.c | 30 ++++++++++++++++++++++++------
>  1 file changed, 24 insertions(+), 6 deletions(-)

This version is looking good. Thanks, will queue.


Thanks,
Taylor
