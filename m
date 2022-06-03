Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F808CCA473
	for <git@archiver.kernel.org>; Fri,  3 Jun 2022 18:36:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347791AbiFCSgQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Jun 2022 14:36:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347276AbiFCSgJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Jun 2022 14:36:09 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A3021DA55
        for <git@vger.kernel.org>; Fri,  3 Jun 2022 11:27:39 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id el14so6141961qvb.7
        for <git@vger.kernel.org>; Fri, 03 Jun 2022 11:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QagQqN+W8cW6MzJFDRoVwECWvcy/gaCKgL4cjJJQsX4=;
        b=zFE9Zbh3K2YoderGjEVPWirjkwjiSFkQj0xEhexNBtCX/QQIQxDqkvyHmZqGrN77Qo
         ZMtC+M4N8fW0fwkddV11ScMgNQQ1agIOkRGJN/WWjOeCUseqB6sFMwuJ14V3KHwUhYET
         vTa34/tqwQtN7eATJkXfJK7fpR1ncaYauEiM7Mi+pj3CUowMJ/k60HgVO2B/RBt2WTcG
         zLevXBpe6mESMMq4ngI2AN5Gwe3CGdfeocp7xOsjrRsSZMlskrU27FDK9CTWOlNmYPD6
         ebZioQZcLGauqvlNwApkTCWSO9djeFQd/UVCKC4uvmloHvJqkIBTOuz4Nj3hlzlFAFy0
         KOyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QagQqN+W8cW6MzJFDRoVwECWvcy/gaCKgL4cjJJQsX4=;
        b=UIXFmvWJtZm4AB7K7gQN/h4w/4xjbOgGQfi2psnsji1Q2dPoWC4XMIdUxCzziZYq6X
         zHI+5U88BwPIe30bIOVBd6dj7Z8jQqj4vCD9xb+tQRRgb87K7cLdxFBBPij4gIaqRxVB
         qrpnM3bZTGlWnScdWkfr3/suZLelLwXGz+glmVzqN5bFkR/ZWmP+c8jhbvgr3dgp6Tve
         ZSIQ3WVuxpfQmk5f++eipvO7693TTON+Lh/EhfTct4eYnLLFCL/dQj+hx5mGRSgnDp7Q
         2XCoI5j2NVeEnTFZISETccHmRJ4qAx5WzzIuH8CprlS0R6/Kq2crK726q6RrcmcR/Vwf
         mw1w==
X-Gm-Message-State: AOAM533UFgLOYPyBBGYG6gt1T0YvRToCyuTNl0Gz1xfALt6jENaVKL3T
        MdSdgREGYkt62SK3EvRj+lqetg==
X-Google-Smtp-Source: ABdhPJz8CGOPFnUaAl00myJZhbPjKgk3yAc/Bop0usFtRc4wu0nsu1onbQ/799ivBY/2GxpN0yceEQ==
X-Received: by 2002:a05:6214:509c:b0:467:d42b:3b43 with SMTP id kk28-20020a056214509c00b00467d42b3b43mr5961677qvb.19.1654280858433;
        Fri, 03 Jun 2022 11:27:38 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id n2-20020a05620a294200b006a6a3f1548bsm1098413qkp.54.2022.06.03.11.27.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jun 2022 11:27:36 -0700 (PDT)
Date:   Fri, 3 Jun 2022 14:27:35 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, johannes.schindelin@gmx.de,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 0/4] rebase: update branches in multi-part topic
Message-ID: <YppSl4rOvVciLuXE@nand.local>
References: <pull.1247.git.1654263472.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.1247.git.1654263472.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 03, 2022 at 01:37:48PM +0000, Derrick Stolee via GitGitGadget wrote:
> This is a feature I've wanted for quite a while. When working on the sparse
> index topic, I created a long RFC that actually broke into three topics for
> full review upstream. These topics were sequential, so any feedback on an
> earlier one required updates to the later ones. I would work on the full
> feature and use interactive rebase to update the full list of commits.
> However, I would need to update the branches pointing to those sub-topics.

This is really exciting. I'm glad that you're working on it, because I
have also wanted this feature a handful of times over the years.

This definitely would have come in handy when writing MIDX bitmaps,
where I was often editing a local branch pointing at the final topic,
and then trying to reconstruct all of the intermediate branches after
each rebase. Not ever having to do that again sounds like a delight ;-).

> pick 2d966282ff3 docs: document bundle URI standard
> pick 31396e9171a remote-curl: add 'get' capability
> pick 54c6ab70f67 bundle-uri: create basic file-copy logic
> pick 96cb2e35af1 bundle-uri: add support for http(s):// and file://
> pick 6adaf842684 fetch: add --bundle-uri option
> pick 6c5840ed77e fetch: add 'refs/bundle/' to log.excludeDecoration
> exec git update-ref refs/heads/bundle-redo/fetch HEAD 6c5840ed77e1bc41c1fe6fb7c894ceede1b8d730

But I wonder if we can or should delay these update-refs as long as
possible. In particular: what happens if I get past this "exec" line (so
that I've already updated my bundle-redo/fetch branch to point at the
new thing), but decide at some later point to abort the rebase?

I think users will expect us to restore bundle-redo/fetch to where it
was before if we end up in that case. Recovering from it manually sounds
like kind of a headache.

What if instead we created labels here, and then delayed all ref updates
to the end by replacing this with:

    label bundle-redo/fetch

and then at the end of the todo list we'd add:

    exec git update-ref refs/heads/bundle-redo/fetch refs/rewritten/bundle-redo/fetch

If we do all of those ref updates in a single transaction at the end, it
should be much easier to roll back from if desired, and we'd avoid the
aborted-rebase problem entirely.

Thanks,
Taylor
