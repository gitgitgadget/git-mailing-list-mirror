Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCE9FC433FE
	for <git@archiver.kernel.org>; Wed,  2 Nov 2022 08:15:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230037AbiKBIP1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Nov 2022 04:15:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230179AbiKBIPO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Nov 2022 04:15:14 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7B461C920
        for <git@vger.kernel.org>; Wed,  2 Nov 2022 01:15:13 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id be13so27009900lfb.4
        for <git@vger.kernel.org>; Wed, 02 Nov 2022 01:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zSUyYQZk/t6osLtm3gIUlmgbEwoy+dcUQfFQJ5E58eY=;
        b=LMRDaoh7HrInIGOru0fqjbGyWIqUBgVE3cJak7jFnMsmD/0isaEg8aK0xquXjxmQHW
         GLkDn0Ec01LWfSTg/KV5dIvuqzSja06cJY9/hvjSqjDfviGuUZpfbrHfPnOWkaDgmLR9
         Zbaa1r79tpl2zB+xGE4agP6iOpEItYm/cFY72p7AdBQbavLKw80RDPYL4UuMELEttMwJ
         V3gQ+1Tlppz/s8h+kItpePdYJimLDWTrBjE+mdcu07hclA9FojexcRfFuPAAUuLgB9EU
         18ORGPm07cgWFEzqfN82e/bxgDeueLBADyV1rrL33w0Tn5FaNP6VnCRQMLj1vd3BQqrp
         mZPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zSUyYQZk/t6osLtm3gIUlmgbEwoy+dcUQfFQJ5E58eY=;
        b=2QpzxiTaaKh7AUAswzMbLLbhClXcJSA8auX+T0Msep/5Z06AWQAJE9ThAwO3/L/ItL
         M0wutnMhXFsVs6X5LRvotpRKKURfyUQia5lkJR3OE0fo2qyZeX7toExAIgI6Sd1BGJ/6
         lJsFnVqd6OrfqxkouZr7MSKYrElHM3kRTuS1cYyRDEzUGl2ZgRaQF+fGiQWZy7zVCoWK
         kw+vyoF6MkcD1zlL1++MvN85LJQ8zlnENrcokYpjafLA/mlNIF6H4hHBQd4aLuNcvwIZ
         Kr7bJpg9KuE/RCdXanbnY9TOB4CxWRqpfVKK/FPwqel9HEWFm1iOOPvruu3xBOnnVxBn
         awHw==
X-Gm-Message-State: ACrzQf09JDYVxEYAKlrPspQI37uYZssQH68SxpuIw2sf6ATwwDZqILrY
        9dlM0Ru0t1jpI6BAy6tuR5pPIW2RFkNnLlAkSlENbGqRIfU=
X-Google-Smtp-Source: AMsMyM6pNW5M911SWfatnz5F3xOOU9E2UoSFGbMItK+hrQ0zizhJBznKWe3IXuQYiMeMgW+EfOGVc+eGVIlGfz38PiM=
X-Received: by 2002:a05:6512:304e:b0:4a2:6c66:8355 with SMTP id
 b14-20020a056512304e00b004a26c668355mr9796984lfb.238.1667376912033; Wed, 02
 Nov 2022 01:15:12 -0700 (PDT)
MIME-Version: 1.0
References: <CABYbkvP=fMmaFUD3bQbeQ-XKiMSP6g-u0p7Vq1Qt_K5=D5WJ+A@mail.gmail.com>
 <Y2EPgICMsmzKvCC8@coredump.intra.peff.net> <38d50c30-c6a3-5989-6e01-47c5467d9d6b@gmail.com>
 <Y2IeqOT5Ao1Qa0Zl@coredump.intra.peff.net>
In-Reply-To: <Y2IeqOT5Ao1Qa0Zl@coredump.intra.peff.net>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 2 Nov 2022 01:14:59 -0700
Message-ID: <CABPp-BGmNqV5H5meMggKYTcTJDxxt5dRT3rZRnRPz496OJn3Vg@mail.gmail.com>
Subject: Re: Git Bug Report: out of memory using git tag
To:     Jeff King <peff@peff.net>
Cc:     Philippe Blain <levraiphilippeblain@gmail.com>,
        Martin Englund <martin@englund.nu>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 2, 2022 at 12:51 AM Jeff King <peff@peff.net> wrote:
>
> Here are patches which fix them both. I may be setting a new record for
> the ratio of commit message lines to changed code

It looks like the first patch is 72 lines of commit message for a
one-line fix, and the second patch is 61 lines of commit message for a
two line fix.

I don't know what the record ratio is, but it's at least 96[1], so
clearly you'll need to figure out how to pad your first commit message
with at least another 25 lines before this series can be accepted.
;-)

[1] https://lore.kernel.org/git/7vaac73265.fsf@alter.siamese.dyndns.org/
