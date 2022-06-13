Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3723C43334
	for <git@archiver.kernel.org>; Mon, 13 Jun 2022 22:27:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239284AbiFMW1O (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Jun 2022 18:27:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234454AbiFMW1N (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Jun 2022 18:27:13 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9836C30F53
        for <git@vger.kernel.org>; Mon, 13 Jun 2022 15:27:12 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id v25so9128404eda.6
        for <git@vger.kernel.org>; Mon, 13 Jun 2022 15:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Qau9m1CGoyaxh/bv+vp32842sGFFWl5wJcxWkLKpdkM=;
        b=UidvetC66EdbD0Q1lMyEAFC371ueaBwSMnHZ7xE2djyUYem2+v3eqsFHOP1euM3LLq
         ZIQiq5AnMSqnuBVhUPU2un0wcxzxDSXUEf7AfhscY5M50sM89H0OUJAHMJnSR4Yg1wVR
         BJy6xNqPNg8j+AwTDI0xhsDiQBms1brmL+KqGQ0tDPRjZKolMOQ99mndI5g9xgC+TLLU
         NgEAonHoR6RQvAX+zuV00gDOZfhjCTCpOZ6hSaQM8yyGTOjwM3XfRxRn4omXqP9JCl6P
         GoucR07zJCS7dLlZFVAi0J1WrNrqHYkqDGg+8CkusFlDgQt/BTL+S/x/6NGcV29WcxzW
         fk7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Qau9m1CGoyaxh/bv+vp32842sGFFWl5wJcxWkLKpdkM=;
        b=UXze59ntkZBTQKuHrzsL+F9nBMTFBubqLTj3JEGiVPD2BA/WH/jJSxtdimU55kuOCb
         IbfCsf/Aj2UdpwsZB/zYWeTiVXHMKU2d60lfou0NbkiAo4G7DqabztpEAO3z0aRX5Rbi
         4a5RjwQ29tV+YU+2QVFj8LgkXSwEZK2B4Z49wannB5D5lUQLoOHZ/7Fa870xxcEg44NW
         Yrez+XDewQTtKRj/RdBOLvKoog+jWFB+Gv0nBULF8F0EH4WlHU70wc8AXfSAuSwQeKLY
         OX9KWJw0rzHsUTjq1h0rJAME4Y/vPmxz9E2E9sdxAbpIvhQe5eVw7l+HPJFEVOGaRFNq
         f5aQ==
X-Gm-Message-State: AJIora9Fe0mjauN+tFBhguH1jBdBL/4k1B40czxjdOdBZo7FzYRDMate
        VOwQEPlsuoeHR05wfxoLJCasyZQgb/8P2u3WQh1L+lit
X-Google-Smtp-Source: AGRyM1urIhLFH++rmlUz21xv+XHB3DAPLL/GGks6VFVNCt/bYQvuilgLSfFW6tVc3KIS8SUf6c4Mkibw5W0LfDQol3w=
X-Received: by 2002:aa7:d441:0:b0:431:486b:2573 with SMTP id
 q1-20020aa7d441000000b00431486b2573mr2325538edr.60.1655159231137; Mon, 13 Jun
 2022 15:27:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220613203145.wbpi2m3ys3hchw6c@meerkat.local>
 <YqepoUMb3rkKgWqB@nand.local> <YqerC883GiwHiiZU@nand.local>
 <20220613213221.iekmfjihho5ujfq2@meerkat.local> <Yqet68Sll1cz+ySY@nand.local> <20220613214514.udtn35w7j6q2lrbh@meerkat.local>
In-Reply-To: <20220613214514.udtn35w7j6q2lrbh@meerkat.local>
From:   Chris Torek <chris.torek@gmail.com>
Date:   Mon, 13 Jun 2022 15:26:59 -0700
Message-ID: <CAPx1GveKAaO1NMRZvcoj5nGm4Cd=A5CLkq7u-eOYtRvU2YVaGw@mail.gmail.com>
Subject: Re: Repository corruption if objects pushed in the middle of repack
To:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc:     Taylor Blau <me@ttaylorr.com>, Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 13, 2022 at 3:07 PM Konstantin Ryabitsev
<konstantin@linuxfoundation.org> wrote:
> It's just strange that we've been doing something similar like this to tens of
> thousands of repositories (e.g. those on codeaurora.org), and it's the first
> time that I see such consistent corruption manifest itself. If I were to go
> with my gut instinct, I would blame the shallow checkout on the client, but I
> don't have any good way of explaining why that would be the culprit either.

One thing that *is* different with a shallow clone followed by push, is
that the `git push` pushes a lot of objects unnecessarily because the
client doesn't have the commits to prove that they're unnecessary. So
the delivered pack file has a *lot* of redundant objects.

(A `--depth 2` clone usually omits most redundant objects, which is a
reason to use `--depth 2` instead of `--depth 1`.)

Chris
