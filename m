Return-Path: <SRS0=AzkS=BC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B96FC433E3
	for <git@archiver.kernel.org>; Thu, 23 Jul 2020 19:11:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0B63206F4
	for <git@archiver.kernel.org>; Thu, 23 Jul 2020 19:11:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MeRQKBO7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727975AbgGWTLR (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Jul 2020 15:11:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726994AbgGWTLQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Jul 2020 15:11:16 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B144C0619DC
        for <git@vger.kernel.org>; Thu, 23 Jul 2020 12:11:16 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id j11so7521864ljo.7
        for <git@vger.kernel.org>; Thu, 23 Jul 2020 12:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=8USsxedUA9hp7MptZ7qRmzn+/JSaPW2lpC6gPSzW7b8=;
        b=MeRQKBO7AMUn9lvJxdQO+WRNp3pm5XuFQnwUCZCdmxEU/TkEeQDEHNKOPo/Fg6aKAj
         F259R2kQQRtKv+l90ssZsUwc61nQcPaUtr0NzKxCA9X9YAQhJOFyHwtg+fxT2Uxlh3+5
         cGWzXU7EbvFySCsOV4P+H7eBFZqoVIimbwbGLcVWXeWsYw6HErmwDfZzQWAPytznb4p7
         grFKhbLgbaqEnkLE9trOy2ezIZFNiQ0L1oQgjxm6itMJ1dU5cyEJQw9uqi9qOr0L5eNe
         GUormX3f5JMyaeaFObuJ66YJOfP3TN6Bt7g/cBllGKT9kfyZ95kdjOcnS7ta2FnpAyQA
         8B9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=8USsxedUA9hp7MptZ7qRmzn+/JSaPW2lpC6gPSzW7b8=;
        b=WpDsrySMtJ/p09e8U3RI7lm6bh8jOzkVfx0ilRumMua4y8NUwEZhOo9Iob8UCuYXrH
         1LFQ7A7AHRyzeH9uDAvl9t4t1CXXEaSlNNSVEE0yc+Bu3tVQASsf+bN40SwI9P9cUGzY
         DZeL7WvQ0GkU1+9pyO92RomiU0R/43svJoNd1gBhCtfy4zau2Wo0cBtYMqdqqvP/x00B
         YWjYz/jUgYeJKnv2qn1pONXd9Wh5XoPmJm6n+Ol8OGCX8viGl8IGnB3soEg3pRiO5voB
         chiGRfmoDb0/AXkFweSk6Fj7dqLcQaJpHtg2XKTs/cqgidXVDvo5+JomKOxsGfF49Jkb
         uHYQ==
X-Gm-Message-State: AOAM530HMrkHr/xAyeTmyDEbth0LpYxfnkXkBRyJRJsM23LQB/5KxZSs
        wIt6FuKjQx+0j6ZSdoTzgg4uMbKO
X-Google-Smtp-Source: ABdhPJwphsJPB5gNSBzVUnxKe91ZMcNgTLWSVIWd5tz9UNHpcAmv8sX3Ze2GCw+TPI4kb1UUz6Lwsg==
X-Received: by 2002:a2e:1514:: with SMTP id s20mr2515363ljd.455.1595531473369;
        Thu, 23 Jul 2020 12:11:13 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id 9sm3285014lff.82.2020.07.23.12.11.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2020 12:11:12 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
        "B. Stebler" <bono.stebler@gmail.com>, git@vger.kernel.org
Subject: Re: Improving merge of tricky conflicts
References: <a0418859-c62e-c207-a1b0-1b1aaf178527@gmail.com>
        <4df975f0-e4b1-afa1-cac1-f38e6d31a0d8@kdbg.org>
        <874kpzmhis.fsf@osv.gnss.ru> <xmqqwo2v45hq.fsf@gitster.c.googlers.com>
        <87tuxzl00h.fsf@osv.gnss.ru>
        <20200723182648.GC3975154@coredump.intra.peff.net>
Date:   Thu, 23 Jul 2020 22:11:11 +0300
In-Reply-To: <20200723182648.GC3975154@coredump.intra.peff.net> (Jeff King's
        message of "Thu, 23 Jul 2020 14:26:48 -0400")
Message-ID: <87blk6yrlc.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Thu, Jul 23, 2020 at 12:20:46AM +0300, Sergey Organov wrote:
>
>> >> Is there 'git merge' command-line option for that? I failed to find one.
>> >
>> > There isn't, unless you count
>> >
>> >     $ git -c merge.conflictstyle=diff3 merge side-branch
>> >
>> > as a "command line option" (which may technically is).
>> 
>> Yeah, I thought of maybe making an alias for that, so apparently I do
>> count it as command line option, thanks!
>
> You can also do it after "git merge" aborts with conflicts by running:
>
>   git checkout --conflict=diff3 my-file
>
> but do note that it will check out from the index, overwriting any
> resolution you've already done in that file.

Really nice trick, thanks for sharing!

Though now it gets really odd "git merge" itself doesn't have this
option.

-- Sergey
