Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A1C1C433EF
	for <git@archiver.kernel.org>; Mon, 13 Dec 2021 17:25:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237672AbhLMRZm convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Mon, 13 Dec 2021 12:25:42 -0500
Received: from mail-pj1-f45.google.com ([209.85.216.45]:38494 "EHLO
        mail-pj1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235682AbhLMRZl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Dec 2021 12:25:41 -0500
Received: by mail-pj1-f45.google.com with SMTP id p18-20020a17090ad31200b001a78bb52876so15139741pju.3
        for <git@vger.kernel.org>; Mon, 13 Dec 2021 09:25:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+T6HeVYxanec1IXA2/OWzfdtzIQ4HQCT44ucw8yzSg0=;
        b=F7pOUN5KnWahZFYbcP5wHy2YuZEV5csEIkGek/fwmfGum8kjHZyFyL9uP8U1GjylJ9
         HUg8SqDgEYtLjVif78uuoy41gVvR5ZSFenFOKmKwbc8NU8n3RllVL5Bm7tSDeF2JnGEF
         VwMFQK46F8yVm8k8CeDaPjHt7B/N8r32Oq+vrq7c5JoZXVHL6IUvriB0UzIYzZqbtADY
         yUDAIF+PwAVosNqioXWxiX6p7x+wWR5ybd1Eto5MYZ3Xrlp/CCT73DPz65i68Y9Yjuyh
         EFZyoSuT1Wl8zcJLZ6Qht0Cjv47uHIu5mWt5J6ed/DCMoeozw5+Rnmw7Ns8Q4Fjeqcir
         Hr7A==
X-Gm-Message-State: AOAM532tdfMW9rtp3DL8jBT3w14rBFqONzW08LK89ZkP0kgBJk2EJdlk
        7iAIXBAtES6Tj1+3KIZICydC1xqtQi0S8Ay9I/zVz9xOEfbDdg==
X-Google-Smtp-Source: ABdhPJwhH1jR1R7kfmO+a3XRZdkbEJkAX2PwJM9o00MrRO7uR3VK7zxHIGARneVmSgTTInbdzM+BjrC6YLSwI6BxiYI=
X-Received: by 2002:a17:90a:b107:: with SMTP id z7mr45643825pjq.104.1639416340850;
 Mon, 13 Dec 2021 09:25:40 -0800 (PST)
MIME-Version: 1.0
References: <20211213063059.19424-1-sunshine@sunshineco.com>
 <20211213063059.19424-6-sunshine@sunshineco.com> <20211213102224.y5psbojmivlxe5px@fs>
 <CAPig+cSKn6wdPKc=b8Xjqy5D=bVdu6FQtYKJuwN2VoV7pEEgHw@mail.gmail.com>
 <20211213154327.pmhopjbdlkz7dgjh@fs> <CAPig+cSXHBMgOUycL0cXuVCb_PJ2=x2w4wUkc7eQQueyk=0Uzw@mail.gmail.com>
 <211213.86tufc8oop.gmgdl@evledraar.gmail.com> <CAPig+cR5Q2q=wdXuVBeP52=pAfvh6_4z__g-0JUGWq_7uor_Hg@mail.gmail.com>
In-Reply-To: <CAPig+cR5Q2q=wdXuVBeP52=pAfvh6_4z__g-0JUGWq_7uor_Hg@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 13 Dec 2021 12:25:30 -0500
Message-ID: <CAPig+cRkC=-dV_i1LJg3kZVVpR778YNyhpO6maHnH5zFH9zS6w@mail.gmail.com>
Subject: Re: [PATCH 05/15] t/Makefile: optimize chainlint self-test
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Fabian Stelzer <fs@gigacodes.de>, Git List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 13, 2021 at 12:05 PM Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Mon, Dec 13, 2021 at 11:17 AM Ævar Arnfjörð Bjarmason
> <avarab@gmail.com> wrote:
> > The reason I looked at this to begin with is that it takes it ~100-150ms
> > to run now, which adds up if you're e.g. using "make test T=<glob>" in
> > "git rebase -i --exec".
>
> Regarding this last point, one idea I strongly considered (and have
> not rejected) is to stop making `check-chainlin` a dependency of
> `test` and `prove`. [...]

Another less sledge-hammer approach would be to make t/Makefile
respect GIT_TEST_CHAIN_LINT so that it doesn't run `check-chainlint`
for `test` and `prove` when that variable is `0`. That would allow
your `git rebase -i --exec` case to avoid the wasted extra overhead of
`check-chainlint` (and chainlint in general).
