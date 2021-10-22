Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0E67C433EF
	for <git@archiver.kernel.org>; Fri, 22 Oct 2021 03:21:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9BE9961440
	for <git@archiver.kernel.org>; Fri, 22 Oct 2021 03:21:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231134AbhJVDYN (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Oct 2021 23:24:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230349AbhJVDYM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Oct 2021 23:24:12 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96EA6C061764
        for <git@vger.kernel.org>; Thu, 21 Oct 2021 20:21:55 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id l7so2825801iln.8
        for <git@vger.kernel.org>; Thu, 21 Oct 2021 20:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=eiJ3kBZnumiG4435n06m3eRfMZYjDYJ5s9yiabjDc7g=;
        b=C7YI34IGJOAHx4wBKsh19R0kMmfGkIFTfWzpo1VCHY3GrZD+y3msGi7B9jxS/4ODRb
         Q2IAOMgbpyzgOlL0+j28lrnsYEUZWWtXRC+VKGr7dFm/GjBv9YxnD10a+q7tF6xdqEmC
         V3ZMC7QtxOIR1Psi6zide3ClEnKi73oM2Dd4Nw7CxBgoB6M/lJw37flv1g6Dq5oSLYRq
         eSOrRfw5eNACX1gJsPzFZlQhe4fvejySgz2rdF2JanvcJGgAUHNCRuQBOEHDw05ww3Qg
         OqYpU6d3uNMePhwaRVodroCah5Nrs0oWyjuY+TZtL0Tb67OfmH0utkQCMZKB2AI7YR02
         LOmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eiJ3kBZnumiG4435n06m3eRfMZYjDYJ5s9yiabjDc7g=;
        b=R35INDt/RXf5NAfnoL8GN1mAoLZITcLSK89lBWC8pOCMO/AroRWjI7ONH75rc3nTqE
         JngZwYuhMAQua5K9MVL12j74j5spdS7Sm2uF0GXpcjOT3ZS29kQzkIb2KlQTtlzKROEL
         HrlQ9iaXf2iV+zfyRiBxPSicjXKGfaLi5vSfhaqLS2rjddUaeL9s+M8SoBccirTCijGT
         3RemLGIWJMxMhdnPA922eixWEoYpdDGi0Z5vR7lrf2/EuLBZI02aX4S38oHRw4E9K0Aj
         kOCtCMJLaqs+D8ywniuL6Ot1NyGgQAlkjxRXsgm829ATeeIfQaq9Wzj4zJprptO5URQW
         AcmQ==
X-Gm-Message-State: AOAM530/DyJR9oqpCX999rxzzPBkEoq3FA3JT3bWQZxDYIZ5ele3s6EP
        Ls8VgScWa7Bsv6boun+H9jANm/SQQ7nqqA==
X-Google-Smtp-Source: ABdhPJyaL4ufBpGLhj81UQjdM0nS/Az05dzvKe6X+EQAuGEBb2epG8jY16+yNPL0gXF5ygPx7bcMBQ==
X-Received: by 2002:a05:6e02:1c2b:: with SMTP id m11mr6315014ilh.307.1634872914908;
        Thu, 21 Oct 2021 20:21:54 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id c5sm3618400ilq.71.2021.10.21.20.21.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 20:21:54 -0700 (PDT)
Date:   Thu, 21 Oct 2021 23:21:53 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, avarab@gmail.com, dstolee@microsoft.com,
        peff@peff.net
Subject: Re: [PATCH 05/11] builtin/repack.c: avoid leaking child arguments
Message-ID: <YXIuURFP/FOpae7U@nand.local>
References: <cover.1634787555.git.me@ttaylorr.com>
 <a68c77c00638bef7e8ce88929015a587d2d1b6f8.1634787555.git.me@ttaylorr.com>
 <xmqqmtn2mj0s.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqmtn2mj0s.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 21, 2021 at 09:37:07AM -0700, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>
> > `git repack` invokes a handful of child processes: one to write the
> > actual pack, and optionally ones to repack promisor objects and update
> > the MIDX.
> >
> > In none of these cases do we bother to call child_process_clear(), which
> > frees the memory associated with each child's arguments and environment.
> >
> > In order to do so, tweak each function that spawns a child process to
> > have a `cleanup` label that we always visit before returning from each
> > function. Then, make sure that we call child_process_clear() as a part
> > of that label.
>
> I have a slight aversion against the fact that this patch makes us
> call child_process_clear(), when we know we may have called
> finish_command().  Callers of finish_command() in other codepaths
> rely on the fact that finish_command() calls child_process_clear(),
> which means that because of this change, we are now constrained to
> keep child_process_clear() idempotent?

Good point. In functions besides cmd_repack(), it's easy enough to just
call child_process_clear() once before returning instead of using a
label. That has the added benefit of side-stepping the variable name
question that you and Stolee raised (but I think whether we call it
"result", "res", or "ret" is besides the point).

In cmd_repack(), I'd like to wrap the other cleanup-related calls
underneath a 'cleanup' label. So there we want to track whether or not
we have called finish_command(), so that we only call
child_process_clear() when we *haven't* already called it via
finish_command().

Thanks,
Taylor
