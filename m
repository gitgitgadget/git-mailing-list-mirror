Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C325AC433B4
	for <git@archiver.kernel.org>; Fri, 30 Apr 2021 04:34:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 994C860FD9
	for <git@archiver.kernel.org>; Fri, 30 Apr 2021 04:34:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbhD3Ee6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Apr 2021 00:34:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbhD3Ee4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Apr 2021 00:34:56 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BF06C06174A
        for <git@vger.kernel.org>; Thu, 29 Apr 2021 21:34:08 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id i3so55382522edt.1
        for <git@vger.kernel.org>; Thu, 29 Apr 2021 21:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZJ70APABdNRJi+4MsC27ObcW9KaMTmV9WhxeX2hF5UU=;
        b=faPHiGgruDUkyG1q7rVvfZV0ba4b6tvqNBd/8K6em5jyBnLBkb+EBS33WDmkmbmVim
         LySNJ21qJ8/RTSxHByeSZLfW+o9p1ShE+UIeBncmzT96dfyAT1q0f1H7BfCSWN3DvjGJ
         kyUaVm4iW1yDSCj6RRLZTgN1JJTEHzSsjIMqoant9z9sTH5IXZXH0TrchobY8sobMjv6
         yZh7iFjyRzJ0AhjFpXt+FzcDyzkQWVbhHCnZ6FXFkJS2nHdY8ub+VUnBw6pnTboz+2nT
         wsMTpu2FDuNy0RhOjxQba6ERaVU8Nf3EBA9a5GixWc27be9MTDTZKTks+8EiHGksLx4T
         KgLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZJ70APABdNRJi+4MsC27ObcW9KaMTmV9WhxeX2hF5UU=;
        b=QqjCxUMS5pAAk88Cw6DRzI7p+Vfeh1PKO1rqrKUEjzkh7xxIeFAJprFCwpzULmus4o
         UOJGVI8dT0UB9V1iQA2PKCqfHr3SlXYHzhQ0CTHReynIY7oH6vYp17Z/MNrRWja5Mbd6
         OoaC7SinRvHy7XRUFUOvE8D3HIQKDwj8FiVKQ3hYSNIQ6jdODMTrbNtIafdFN4iKkSpg
         o3QF1mn2V8iu5mss7Ny7F+PJFN2iFScu8zu+FoasZAJJyiwbjCim777ILrp67VF2/u9h
         opteLX0gh+Ekz7ctmRHRkQq/sEZ5BA4V7XKT9f9FvZkNxd41FqJr8mvH8YuCC7Zzafkb
         i5pA==
X-Gm-Message-State: AOAM532zTqKINAnnepW9EyIz7FSk2ruthSNqO7ISs8sF57EKnejw1Oua
        ItKCckZXKctwgso1bFcE0TCdzsvh3yiTHMkPwgg=
X-Google-Smtp-Source: ABdhPJxmIXq+3yMEB0A4bu6/DF4DPlhkGQcqhLn7CIrqEZ1QhMpHHIq4UWtKZXWhn9vbdT/JjGZCwLHCtl7ViAi9z5s=
X-Received: by 2002:a05:6402:752:: with SMTP id p18mr3367026edy.127.1619757247211;
 Thu, 29 Apr 2021 21:34:07 -0700 (PDT)
MIME-Version: 1.0
References: <fa098676-a56c-cbb9-28cb-e57d4a8a5d77@ramsayjones.plus.com> <xmqqo8dwegk0.fsf@gitster.g>
In-Reply-To: <xmqqo8dwegk0.fsf@gitster.g>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Fri, 30 Apr 2021 06:33:55 +0200
Message-ID: <CAP8UFD08kH5k1wrjo0pHJ3KH2iW4=DDzePxiZXvYbDSCOqQSEw@mail.gmail.com>
Subject: Re: [PATCH v2] bisect--helper: use BISECT_TERMS in 'bisect skip' command
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Ramsay Jones <ramsay@ramsayjones.plus.com>,
        GIT Mailing-list <git@vger.kernel.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Trygve Aaberge <trygveaa@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Pranit Bauva <pranit.bauva@gmail.com>,
        Miriam Rubio <mirucam@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 30, 2021 at 2:56 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Ramsay Jones <ramsay@ramsayjones.plus.com> writes:
>
> > This v2 patch was also created directly on top of commit e4c7b33747 and,
> > once again, applied to current 'master' (@311531c9de). (I was a little
> > surprised that it applied clean, given the changes to t6030-*.sh in the
> > meantime! ;).
> >
> > I didn't bother with the range-diff[*], since it wasn't very illuminating
> > (just the addition of a few trailing lines in the commit message and the
> > addition of the test).
>
> Thanks.  Let's hear from Bagas that this version looks good and
> merge it down.

This version looks good to me.

Thanks Ramsay and Bagas!
