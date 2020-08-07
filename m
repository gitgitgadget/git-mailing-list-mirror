Return-Path: <SRS0=eX0j=BR=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E2FBC433E0
	for <git@archiver.kernel.org>; Fri,  7 Aug 2020 19:12:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 23B1F2086A
	for <git@archiver.kernel.org>; Fri,  7 Aug 2020 19:12:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OqNVGshK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726212AbgHGTMe (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Aug 2020 15:12:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbgHGTMe (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Aug 2020 15:12:34 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3C07C061756
        for <git@vger.kernel.org>; Fri,  7 Aug 2020 12:12:33 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id v9so3319918ljk.6
        for <git@vger.kernel.org>; Fri, 07 Aug 2020 12:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=uoNJjnrI67aNTT4BZXiaFbtOUfmeFb219wDWJ4fHp4U=;
        b=OqNVGshKGm3y/EymNCv+cgIUAvyY3LLHU69Gs4UKkjwzxX0vcepm5SDNANjD4U79fm
         avi2K115gW2ekLcS0/Y/Sh6Et8zZlWYnEr05KLjE23csIPkQLWb/LLPDh3K333CIdTIC
         qpssTQdvvX2qPmK3ghITYehf5aWfU5o7FXeUw7BbsPfzqVhsj5enoQZpwgq62MLLAleG
         sPJyLys4mTMf8B7AyxaJbYZ1+gk6qeDXmdSF/w9+oCAKI+EEK86z5ChOzNw7Puj/lMaJ
         cxVZb/r6M/Z1ipbRppzTu54fMEsKz2XzWxSPPtc0ZhbnGQyIoUdC9MFVe14QbI8EAsRL
         OW3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=uoNJjnrI67aNTT4BZXiaFbtOUfmeFb219wDWJ4fHp4U=;
        b=MW9gl7r3YUWT4OkQCzwhdWVx3lpWfkCxPBij2jUBeqUbl0JGBn/Fx7PA750oOo8vuH
         c/78/V5vi0PXsNnVJ1bkmnYJx6J12evMlCgG9dEaBDq0rczB5pC16uTEXtOSZc6UoiPu
         wlNHIWx1XhYMIC0oq62lmVAajF9XBXc3mm5t4dCXDZMme33WfbiqrIU+HJOehp0fhzx5
         6rdud4qBHqWfheCvc6gLLE8r5256c2p2W7aQj7G5EBezdeMW9jneXAhrF+HxyDPoMJLW
         1CguN93zTNtgCbpKcSrASK+F4zTEsV0dghJdLZQq6RPbC1+ffM2fKAQarJsGGYwMw6Wb
         jrPA==
X-Gm-Message-State: AOAM532uDLJ0z7ZqpFQZpMYJe7YXfgWg7QaufaO6t50zZmlLZAhFaXVU
        8NltMceS8Dskl37KP/QGa6c=
X-Google-Smtp-Source: ABdhPJzE4JsK3oKwbbVR0GxlaQN5x/rSYyzmbbbA8IPQkmi+Qjcb14WeKv9syGk5Nq7xOPDrVdYaUA==
X-Received: by 2002:a05:651c:208:: with SMTP id y8mr7172768ljn.233.1596827551421;
        Fri, 07 Aug 2020 12:12:31 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id p9sm4155355ljg.76.2020.08.07.12.12.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2020 12:12:30 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Chris Torek <chris.torek@gmail.com>
Subject: Re: [PATCH v2 0/7] making log --first-parent imply -m
References: <20200803180824.GA2711830@coredump.intra.peff.net>
        <874kpi47xj.fsf@osv.gnss.ru> <xmqqbljqrydm.fsf@gitster.c.googlers.com>
        <20200804200018.GB2014743@coredump.intra.peff.net>
        <877due1688.fsf@osv.gnss.ru>
        <20200804212201.GA2020725@coredump.intra.peff.net>
        <xmqq3652rs84.fsf@gitster.c.googlers.com> <878seuxdz8.fsf@osv.gnss.ru>
        <20200804221440.GC2022650@coredump.intra.peff.net>
        <xmqqpn86qb6a.fsf@gitster.c.googlers.com>
        <20200807082643.GA34012@coredump.intra.peff.net>
        <xmqqlfiqgxn7.fsf@gitster.c.googlers.com> <87364ymji7.fsf@osv.gnss.ru>
        <xmqqh7tegu0m.fsf@gitster.c.googlers.com>
Date:   Fri, 07 Aug 2020 22:12:29 +0300
In-Reply-To: <xmqqh7tegu0m.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Fri, 07 Aug 2020 12:01:29 -0700")
Message-ID: <87tuxel17m.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Sergey Organov <sorganov@gmail.com> writes:
>
>>> I agree in principle that the above is a good framework to think
>>> about the issue around "what to do with diff when showing a merge
>>> commit", but I suspect that overly spending our effort to cover the
>>> possibilities become mostly useless mental exercise, mostly because
>>> (1) comparing with second parent is mostly useful only when the
>>> merge was done in the wrong direction (i.e. an attempt by a leaf
>>> contributor to "catch up to the trunc"), (2) octopus merges are rare
>>> curiosity and discouraged due to bisect efficiency anyway, and (3)
>>> even when looking at an octopus merge, omitting some and using only
>>> a few selected parents to view with --cc/-c has dubious usefulness,
>>> as the postimage has to show contributions from all the parents
>>> plus "evil" adjustment anyway (iow, the primary effect of omitting
>>> parents while viewing --cc/-c is to make it fuzzy which part of
>>> apparently "evil" adjustment is what the merge did vs what the
>>> hidden parents did).  These are all examples that show not all the
>>> combinations are useful.
>>>
>>> So...
>>
>> So, does
>>
>> --diff-merges=(off,none|comb|dense,dense-comb,comb-dense|sep,split)
>>
>> make sense as covering all the current features?
>
> If we are primarily interested in theoretical completeness, it may.
> If we are interested more in practical usefulness, I am not sure if
> such a "full flexibility" matrix is a good way to present the
> feature to the end-users.

I thought it's just a -c, -cc, and -m in better wording. No any
matrix:

-c  = --diff-merges=combined
-cc = --diff-merges=dense
-m  = --diff-merges=split

Just separate mutually exclusive options assembled into one multi-value
option, so it's explicit they are mutually exclusive. I don't see any
matrix here.

Thanks,
-- Sergey
