Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AF8BC05027
	for <git@archiver.kernel.org>; Mon, 20 Feb 2023 16:42:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232278AbjBTQmV (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Feb 2023 11:42:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232328AbjBTQmR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Feb 2023 11:42:17 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA21D20050
        for <git@vger.kernel.org>; Mon, 20 Feb 2023 08:41:37 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id m6so2488735lfq.5
        for <git@vger.kernel.org>; Mon, 20 Feb 2023 08:41:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YHuja2JBezYVFid/irhUtR2dPCDCXNt8TgFhUMe592o=;
        b=DvRSOQUmK0wv608mVZvUYMQfqCsNxc8SR/vg1Tx8Kz/2vBGQ8XlT1FTkGXjxmlZ5Tk
         oA1py/gNSGqKDUOYAjCnRRreTK195UxH+NIwIyP9my4tEuyCkM/s+h36UBdDXSakXf79
         CDNut8uK/WwJExV2tTZp0aknIvIRulLuztve6H8wQde3IJiopoaMxxIxM+pWlcvgJsgP
         yJzci5I1DjZhSSkgByv3nxZl+Wl9IasF04culH7t0trGZf2NlTTV4cdJiH9EMT8ikLwU
         Uj5EO2bp+sNMzznX0xxSTViY0zphfaSxo1zCprEHqleLIt+5LvhwQfKWE20cLyuNQXkS
         HDAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YHuja2JBezYVFid/irhUtR2dPCDCXNt8TgFhUMe592o=;
        b=zDFKXAoey4UV9HIWt4dW1sprQP6qA8FYw/3qbCcX12XMs1imVl2DQQFZ5nLqn2AcJW
         0UMEaslorOAPuw2S0Hbj+8ZhoZ0YSBqwJlVyH4kXHgAhMHdgS9JrDDiUMlp6A/+e0wdi
         lNe0+3T5SbUdxoVM/SNsx5Y08PvDCPpwxEREiTox9DBYpmkbvKhD7uNjXc/9usSzz7x8
         W9S9P+jXwhU4b/vvQ9qBhZCwxk8WvY9dVHDuWonmA8ZHlJ21E7XKwU3qbuUcx+kxmbcE
         IrYPPEQDaI7EeAlf1o2b5x/p3pHrRFSjHm2Trw/fYi6WUhe/20XcqPjIhkEwmu6NAzmL
         pv6A==
X-Gm-Message-State: AO0yUKWRgOYifonFa/Rr1Urdkiy5DQzifR7QGCseJNSQPpvK8gLxTmAF
        EscfLjCGa3CpEDIZoIGfxn7CiV1vfpu6EFXwLow=
X-Google-Smtp-Source: AK7set9Zn8g88J364oXjmbk3rDEFLpcQbQjz1h7OmJ2mWQb0uSOk/GpoPYQVe9T38SQa7xgV+A5I9iXDDilNcnaa194=
X-Received: by 2002:a05:6512:516:b0:4dc:807a:d148 with SMTP id
 o22-20020a056512051600b004dc807ad148mr841540lfb.7.1676911295953; Mon, 20 Feb
 2023 08:41:35 -0800 (PST)
MIME-Version: 1.0
References: <20230220033224.10400-1-alexhenrie24@gmail.com> <20230220033224.10400-2-alexhenrie24@gmail.com>
In-Reply-To: <20230220033224.10400-2-alexhenrie24@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 20 Feb 2023 08:41:22 -0800
Message-ID: <CABPp-BE8yAqFi6Pjyfn=Sk_q3udP8ffgbf=ZAbCkZBYTKcPN9g@mail.gmail.com>
Subject: Re: [PATCH 2/2] rebase: add a config option for --rebase-merges
To:     Alex Henrie <alexhenrie24@gmail.com>
Cc:     git@vger.kernel.org, tao@klerks.biz, gitster@pobox.com,
        phillip.wood123@gmail.com, Johannes.Schindelin@gmx.de
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Feb 19, 2023 at 7:33 PM Alex Henrie <alexhenrie24@gmail.com> wrote:
>
> At the same time, stop accepting --rebase-merges="" as a synonym of
> --rebase-merges=no-rebase-cousins.

I thought this meant you were turning "git rebase --rebase-merges ..."
into an error unless the '=' was provided.  I checked out the code to
verify and realized my understanding was wrong.  Maybe I'm not as
bright as other folks, but just in case, it might be worth clarifying
that you're not doing that in the commit message.

Also, I agree with Phillip that this change should probably be split
out into its own commit, if it's kept.
