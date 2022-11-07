Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02721C4332F
	for <git@archiver.kernel.org>; Mon,  7 Nov 2022 23:19:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232506AbiKGXTM (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Nov 2022 18:19:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232196AbiKGXTJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Nov 2022 18:19:09 -0500
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DCEB2716C
        for <git@vger.kernel.org>; Mon,  7 Nov 2022 15:19:08 -0800 (PST)
Received: by mail-io1-xd31.google.com with SMTP id r81so10209842iod.2
        for <git@vger.kernel.org>; Mon, 07 Nov 2022 15:19:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VfYa3xgRNzSbHmWggn7zzZLEYPpRgsuOVcsmmeSh484=;
        b=xL+zBAUpO6PD3e84XVb0DUrsnM04W1pENetDFfgsl/rRQJtnvHHc45Qpg+t1fnawQG
         IY1hLpu+ekoGk5z+h15KVUdVZepQlIZtVsOy+ee4Lf++og3VXFxsLPINGlAHb+c+aaNR
         a2wePOcL1YG0Vyu+NWBGyFBMt6GhWz6WPCJYdRR2y9ecNYNXcwYPlRX/6TmwjONUzZeZ
         4EACW7WiawUFDfhooPYTMZdSvdq2d2mCCUfhq638rpEmmdRql8idax6KU1H9LkmEloyC
         ws1T6a7dkNIapuQkOzZOw1Xt3zyh2/gEFreGPF42qJVrWPlL6WvJPvkcQH+uWpsvdIZB
         ZuZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VfYa3xgRNzSbHmWggn7zzZLEYPpRgsuOVcsmmeSh484=;
        b=W4xSEUzXtl+fxZDYvpHJGDkJYfqlqWlvN4+BeZlEI908n9rf/VSUJ8rpPs6ma9mfcD
         JYLLTwXFk1ToWYnMCb8A48BUk8l/aj03XvnkTpLRCFR4qMk9vO6ylooPr6I4r1iqxu7v
         cRByp9OaCgyRVKls51zWqRTtmFd/XO47woX/bGybpZEPbqG/jA1UOGcUoEQwvDYppSEF
         OMVhOejtevQXA6OXJsh52Z6zD4I+cxbThijtQa9fm9BEanhnkaH+hQY2T+OHcb4Iy1e1
         JxmIllGM0VT8lOUHtOcZZ+FL2+9fhPoTxACTunhfZI47krI+DxuYezBVJAQnPxP9J6AU
         AL9g==
X-Gm-Message-State: ACrzQf2UfXcwXvZ6lQ0sSHq4NKz/fiR3vr/5zQ11HDCaxOxuG/E/MVkf
        6UeWr8ptihICwnPqsiGAvNrvmQ==
X-Google-Smtp-Source: AMsMyM7eB6CNCfr2SAK2LLCwSoAbBugHOCAjRvEkC4EcAAosIu7BN/sAH/1Gf2eh+NRkLKWGT3Dq7Q==
X-Received: by 2002:a5e:9e0a:0:b0:6c0:dbd0:cfac with SMTP id i10-20020a5e9e0a000000b006c0dbd0cfacmr32084234ioq.106.1667863147546;
        Mon, 07 Nov 2022 15:19:07 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id d26-20020a02605a000000b0037553e5bd58sm3186321jaf.100.2022.11.07.15.19.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 15:19:07 -0800 (PST)
Date:   Mon, 7 Nov 2022 18:19:05 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Taylor Blau <me@ttaylorr.com>,
        Rudy Rigot via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff Hostetler <git@jeffhostetler.com>,
        Rudy Rigot <rudy.rigot@gmail.com>
Subject: Re: [PATCH v3] status: long status advice adapted to recent
 capabilities
Message-ID: <Y2mSabWsOfgBqNcR@nand.local>
References: <pull.1384.v2.git.1667002005494.gitgitgadget@gmail.com>
 <pull.1384.v3.git.1667424467505.gitgitgadget@gmail.com>
 <Y2WG6ursW7qT29lc@nand.local>
 <32e86ad3-2576-b90e-444b-636131bc168d@github.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <32e86ad3-2576-b90e-444b-636131bc168d@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 07, 2022 at 03:02:09PM -0500, Derrick Stolee wrote:
> On 11/4/22 5:40 PM, Taylor Blau wrote:
> > On Wed, Nov 02, 2022 at 09:27:47PM +0000, Rudy Rigot via GitGitGadget wrote:
> >> From: Rudy Rigot <rudy.rigot@gmail.com>
> >>
> >> Improve the advice displayed when `git status` is slow because
> >> of excessive numbers of untracked files.  Update the `git status`
> >> man page to explain the various configuration options.
> >
> > This one is looking good to me. Jeff: do you agree? If so, I'm ready to
> > start merging this one down.
>
> Sorry, I came in with some late review. I think one more round
> would be helpful.

Thanks, all. Will wait for one more round before we start merging this
down.


Thanks,
Taylor
