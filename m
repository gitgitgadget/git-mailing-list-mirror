Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71A8AC0015E
	for <git@archiver.kernel.org>; Tue,  1 Aug 2023 20:39:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232559AbjHAUjR (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Aug 2023 16:39:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232455AbjHAUjQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Aug 2023 16:39:16 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76B5118D
        for <git@vger.kernel.org>; Tue,  1 Aug 2023 13:39:15 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3fbc59de009so56426335e9.3
        for <git@vger.kernel.org>; Tue, 01 Aug 2023 13:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690922354; x=1691527154;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EJZVS9cFozq366W3O1M2k0uregY5GR96agkrABBlN4M=;
        b=rQwYylOOWfAX7xoKLqyGfLaatL1afSaTCK2XrXTfhY7I8AHSUw/VWVeJeyCqYBldp/
         W1ZYjz8fz5oN9t367y2qHtadgI91cTVYwXjAl2fdgBes6xSHHsJTdUO6EkuhdUiK3Z7M
         e7HOW82jiJQCESLvaoxHJIE43wC2ypc1pHCj3RsI9ySR1aF1/zUA2LzXcUzrFpwSuQMb
         MI7wHLe53ju1Lku/409uw9ChUiTXSPjPeE8anhnib7cJ821eql6Bu3um3k4ffEzrSdEh
         49v3mUFdNGzrfI/LJQ/1G16xM+C6RGzy7SRtcgWvUcVQK3jzMKh6ggBQIOVOHHakHDSv
         WLxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690922354; x=1691527154;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EJZVS9cFozq366W3O1M2k0uregY5GR96agkrABBlN4M=;
        b=FuV2B+PsZI3FbAd4WLi0xV7KkN37gp3kzi/tCoJ0qoaHCdskVdq+6ndupBgWRzZXwf
         yV9NRwmyKfFq8AIC0QrJT0T9kt+vyBrIMEHXHkh8U17tO4fW6lxu5IpvTgcnZmYCL7n3
         q+8aa+310QKFitbRZ1CSJkn79JIpTuvRdfsH55wdW++jsSs0Q7mrXM3Bdf9IC+cBdyY5
         0JFsdYA9Pbho5JZaTssEsdSLLHsBFVRoGJGLhv+kDqHGFbJ6iq1QgeszdQf3z0waP+x8
         DLSyDgTtjCKM+fzocHnt1NhZolwVP03Y+Ra27M2GZ08V+DyTqCzvo5o/RChNJlL6tmbC
         MpYg==
X-Gm-Message-State: ABy/qLb0dVuMhShXfutM8yon51WMWVr9x1oVpxuWxvjfA+OTy9vgEuMF
        mweu3dvKuPvran40wzHGMDbs/o8Pn34=
X-Google-Smtp-Source: APBJJlFZ/BDytXZ8N4z9Ld9fTO/kwgMXqpYq3Usl7lbPvaazvLyuKhGj0PARenvC8sA8/bEx8BzmsA==
X-Received: by 2002:a05:600c:22da:b0:3fc:e00:5282 with SMTP id 26-20020a05600c22da00b003fc0e005282mr3221016wmg.0.1690922353681;
        Tue, 01 Aug 2023 13:39:13 -0700 (PDT)
Received: from [192.168.2.52] (225.red-88-14-55.dynamicip.rima-tde.net. [88.14.55.225])
        by smtp.gmail.com with ESMTPSA id m25-20020a7bcb99000000b003fc0505be19sm14571582wmi.37.2023.08.01.13.39.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Aug 2023 13:39:13 -0700 (PDT)
Subject: Re: [PATCH] status: fix branch shown when not only bisecting
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>
References: <48745298-f12b-8efb-4e48-90d2c22a8349@gmail.com>
 <xmqqedkn3arv.fsf@gitster.g>
From:   =?UTF-8?Q?Rub=c3=a9n_Justo?= <rjusto@gmail.com>
Message-ID: <32997081-62d8-b900-d58a-308e5c773818@gmail.com>
Date:   Tue, 1 Aug 2023 22:39:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <xmqqedkn3arv.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 31-jul-2023 16:45:56, Junio C Hamano wrote:
> Rubén Justo <rjusto@gmail.com> writes:
> 
> > In 83c750acde (wt-status.*: better advice for git status added,
> > 2012-06-05), git-status received new informative messages to describe
> > the ongoing work in a worktree.
> >
> > Multiple operations can be performed concurrently in a worktree.  For
> > example, during a rebase, the user can also perform a cherry-pick.
> 
> Hmph ...
> 
> > In
> > that situation, git-status only shows information about one of them,
> > prioritizing which one, in order: merge, am, rebase, cherry-pick.
> 
> ... I have to wonder if it is a bug that "cherry-pick" proceeds when
> there is an ongoing "rebase" going on, though.

Doing an interactive rebase, stop at some point, cherry-pick some commit
and let the rebase continue, it's not optimal but does not seem to me to
be bad workflow.

> When a sequencer is
> driving a cherry-pick of master..topic1 and the user gets control
> back in the middle, perhaps due to a conflict, should the user be
> allowed to do "cherry-pick master..topic2", splicing these commits
> from the other topic in the middle of the first cherry-pick session
> the user started?

We already prevent this to happen.  Maybe because we do not want to
support multiple .git/CHERRY_PICK_HEAD files.  Anyway, to me, sounds
like a reasonable thing to have: that nesting limit of 1.  The same for
the other operations.
