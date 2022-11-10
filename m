Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFF4BC433FE
	for <git@archiver.kernel.org>; Thu, 10 Nov 2022 22:36:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231592AbiKJWg3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Nov 2022 17:36:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbiKJWg1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Nov 2022 17:36:27 -0500
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2CE6B87B
        for <git@vger.kernel.org>; Thu, 10 Nov 2022 14:36:25 -0800 (PST)
Received: by mail-io1-f44.google.com with SMTP id z3so2442642iof.3
        for <git@vger.kernel.org>; Thu, 10 Nov 2022 14:36:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0O5QLlSjszNe/RwBl1ZmOR8okq3ReTVWGWwGXTqc5l8=;
        b=U+Br3+wS4e2G097bqvB9DMtRPN8Yit4cWgKsEg6w0WdOjiTxuW3ynTPJjh0JNktUG6
         2X69FS52LFwBf6tkJxQOLdQw5kBFDrDdxqXzZSYP9/oqfgZVCg+xFtSADzqWkSRD0KKg
         3UGke+2MwTtKTYucvbPNPe8zKfSHCZd9WHL9I8F1orV9Rs1ZJNGWEp8KRuebzK7RlOuJ
         WjSX2iLohxt+sZFJ7ugSwezvmPsQd1MyIDPv3OpJpAO060+5k6cIzvDDN78SQu7HuW2R
         R7eO0ZM3s1poyT2cv8sl+C4txGo5fNo1bR2/BiyaG5KcKvCc33rbg/CFQW7HT7lD53bH
         CS1Q==
X-Gm-Message-State: ACrzQf21KBTHk28d1HFQGVWJEynY3BxjbzV+uVLqzGPajaObqItCt2po
        FpVdjHtwee8yYf2l9UR7kLhqLudkPL51JQRUMpBBDhFP
X-Google-Smtp-Source: AMsMyM7XbmTya+2UYFZy+4ciuEYhQ0ykQ5sG4CQ249eE6EQvgdoy7yws6gsl8OvFfeTaHlBs11d1N6D4LZMzRpSV+QA=
X-Received: by 2002:a05:6638:1a08:b0:374:d0bd:f4cc with SMTP id
 cd8-20020a0566381a0800b00374d0bdf4ccmr3755414jab.285.1668119785166; Thu, 10
 Nov 2022 14:36:25 -0800 (PST)
MIME-Version: 1.0
References: <pull.1413.git.1668013114.gitgitgadget@gmail.com>
 <b85b28e5a6beea97c149f0b9de6ba8d0a4a7c1f9.1668013114.git.gitgitgadget@gmail.com>
 <Y2xkpJj4jLqfsggL@tapette.crustytoothpaste.net> <CAPig+cTL4x45E2a0RbpO2ntPo08K8hQ2wxcXm=QesqtYqxpvaw@mail.gmail.com>
 <Y215ZKz2iZWJCYo3@tapette.crustytoothpaste.net>
In-Reply-To: <Y215ZKz2iZWJCYo3@tapette.crustytoothpaste.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 10 Nov 2022 17:36:14 -0500
Message-ID: <CAPig+cRcw8qxAMTZz-CpM23zPn+VpPJ7qQTtFrbMRmgbiyhymQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] chainlint: sidestep impoverished macOS "terminfo"
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Eric Sunshine via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 10, 2022 at 5:21 PM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
> On 2022-11-10 at 03:37:16, Eric Sunshine wrote:
> > I notice that the iTerm2 FAQ also recommends "xterm-new" on macOS, and
> > that one lacks "dim", as well on my machine. So, it seems that it
> > should be special-cased too.
> >
> > Taking all the above into account, perhaps this regex?
> >
> >     /xterm|xterm-.*color|xterm-new|nsterm/
>
> Maybe this, then?
>
> /(xterm|nsterm)(-(256color|direct))?|xterm-new/
>
> That matches the three special variants of each one here plus xterm-new.

I was thinking of targeting xterm-16color too, not just
xterm-256color, just to cover bases a bit better.

I also don't mind manually spelling out the regex:

    /xterm|xterm-\d+color|xterm-new|xterm-direct|nsterm|nsterm-\d+color|nsterm-direct/

for simplicity's sake; sure it's verbose, but it's also dead-easy for
people to understand and extend in the future if necessary.
