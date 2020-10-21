Return-Path: <SRS0=jwDG=D4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1BD0C55179
	for <git@archiver.kernel.org>; Wed, 21 Oct 2020 16:20:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 548F520665
	for <git@archiver.kernel.org>; Wed, 21 Oct 2020 16:20:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="Fhu6g0PN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2444525AbgJUQUt (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Oct 2020 12:20:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2444522AbgJUQUt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Oct 2020 12:20:49 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7756C0613CF
        for <git@vger.kernel.org>; Wed, 21 Oct 2020 09:20:48 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id r7so3073945qkf.3
        for <git@vger.kernel.org>; Wed, 21 Oct 2020 09:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=sgmQ1CpuVut2LyrcEMY84+N9kQHifPCncUNxm2awfX0=;
        b=Fhu6g0PNEmOPmxhE1mu2mHibCyYAcD3GwPGQlB689wMKd49Hav8xp1zUiMT+PokhrY
         PqCP9NJVC8pGAXeF8wjVxuO6TjCbHGH9WhdQkjc+e2iTIS4HEXGB1yvxXfPPbXM/Z8Bx
         lLFdp+9OQYgtWZbJKrYX/MNValw+vV1YngIPVbYawRPI6deOGOH+7rU2INR3WEFyxLw7
         gjiedY0xQkpIsv/s7FdT4IC5ldYPvrmkF9HdYwZqzwdfwKtznVbHSXc6AiIhbi7qR7Fq
         CfFI4xTyP4d6X1vHOnrsYMSINf07gywrVueUaLc5ur9HEFYb57YrJuji9BFyvvnxWElm
         0XuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sgmQ1CpuVut2LyrcEMY84+N9kQHifPCncUNxm2awfX0=;
        b=soNUe5HCsTzrBOeQyyR6iUCVMNJCDEbjND60LXUn/XShicuVqfPocEg1Z0z9KNJfPa
         gjmKAxs99KQ2pkoNmxIT3RrpS0pfV68uPU8QWD0oc5qte0ccH7Lp4N84Edn1G5gaxswF
         +znI/Q0vEThEy3Ph+nPAzJySe6hk2Xu/PcaUjVl8JzW2qg64WOC0mNjjXwA1ARSstI7n
         fEVH2mZOACDPOWURivJsLIUaqvr98i3b9QAykwKIc/NR7nF0OhPiezx4tPuzChpV6VOL
         DA7LPoWMlEHzpWV2PTHJlLNKvRfcv7kfj24zv/oJlm8Kk7U/OUPcygr4kTC5GcGqsNpY
         q5Aw==
X-Gm-Message-State: AOAM530Ddq8yUDqyTZO+zYUQzezJiPUhcNTG6D/OOmsNUR1lZxeo/myJ
        E7wPpBfDRku0nR/6OG9LegRbYg==
X-Google-Smtp-Source: ABdhPJwn0/5yIDMamrBQZzoZVNePSJZVIpcIZ34/9U8j5mmnyYJOkcoBFg0MFnvDWVtzoNdlwM7NXw==
X-Received: by 2002:a37:478c:: with SMTP id u134mr4079275qka.206.1603297247842;
        Wed, 21 Oct 2020 09:20:47 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:5440:c3ba:60f:b745])
        by smtp.gmail.com with ESMTPSA id w40sm1548858qtj.48.2020.10.21.09.20.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2020 09:20:47 -0700 (PDT)
Date:   Wed, 21 Oct 2020 12:20:44 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     phillip.wood@dunelm.org.uk
Cc:     Sangeeta via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Sangeeta <sangunb09@gmail.com>
Subject: Re: [PATCH][OUTREACHY] bisect: allow `git bisect` to run from
 subdirectory
Message-ID: <20201021162044.GB111581@nand.local>
References: <pull.765.git.1603271344522.gitgitgadget@gmail.com>
 <2f71d0c4-a5de-c22b-9cbe-a9efcb3cd21d@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2f71d0c4-a5de-c22b-9cbe-a9efcb3cd21d@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 21, 2020 at 02:41:39PM +0100, Phillip Wood wrote:
> Hi Sangeeta
>
> It's great to see you tackling another patch
>
> On 21/10/2020 10:09, Sangeeta via GitGitGadget wrote:
> > From: Sangeeta Jain <sangunb09@gmail.com>
> >
> > As `git rebase` was never prevented to run from subdirectory we shouldn't
> > prevent `git bisect` to run from subdirectories.
>
> I'm not sure it's relevant to bisect whether or not rebase can be run from a
> subdirectory. What is important is that we want all commands to be able to
> be run from a subdirectory unless there is a good reason not to (and there
> isn't for bisect)

I'm not sure that that's the case: Junio pointed out a while[1] ago that
we'd have to answer the question of "what happens if I'm in a
subdirectory that goes away during some point of the bisection?". I
think that you could probably find an answer to that question, but the
fact that there isn't an obvious one seems to indicate that we're going
down the wrong path.

I agree that it would be nice to run bisect from any directory, but it
may not be as easy as I'd hope.

[1]: https://lore.kernel.org/git/xmqqpnd359l6.fsf@gitster.c.googlers.com/

Thanks,
Taylor
