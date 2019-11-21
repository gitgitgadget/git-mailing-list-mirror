Return-Path: <SRS0=oq1W=ZN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C0E8C432C3
	for <git@archiver.kernel.org>; Thu, 21 Nov 2019 12:59:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A1DE20731
	for <git@archiver.kernel.org>; Thu, 21 Nov 2019 12:59:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726725AbfKUM7T (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Nov 2019 07:59:19 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35664 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726293AbfKUM7T (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Nov 2019 07:59:19 -0500
Received: by mail-wr1-f67.google.com with SMTP id s5so4328423wrw.2
        for <git@vger.kernel.org>; Thu, 21 Nov 2019 04:59:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fgQX4nqXvgi0X1Po4U5s/9NAYT4yBSfcBcnQXGd33bE=;
        b=RuIm0zfmKTh7V/ujGv2lE1aiLvOylHHSxp8k7TxzGb7olo/LIUVD+uQ/nxRtA0ATJn
         jEVkLaEPgGnKI7TTP1qfbECqyVqKYTFK+M8toGHMQ2SFyCMw7NUemBcaFNtVIhb+4cxW
         HMOPrU7jKTRFpYSsC1DaZbQ1l8kflbiCFSC4G5s5DxYoPSSvKfZskm7fVy1oQtKnjhPo
         EEo5L/6GPgwMhZxd4bYg/BLDBpkPj9fA1Se23Gi4TZUm4kzQoqNsUWmrKzOQ8aF9sByE
         qDqvRhDuznNtR01OHAN46BaC21pu1/8gjkNNq66yxsE8I/XBIcWlbWMfeWhw/CXCjuQW
         46aw==
X-Gm-Message-State: APjAAAWrGB4q05qSn/fH4EQOeqHZw4mKmOWXoPiWzPPcnExsMkOHKsi2
        YOvFDmNhdRWk/77K55wmH8m+K3x6ew7Iz4BUcJQ=
X-Google-Smtp-Source: APXvYqzEzJsXGPgG/jLPCkgxk9QRXZOlJ5ypCum0xOlPhS0d+2PEg86Wu5LzRwcFTO6aLLKtRWSMCop/jWb/uYd6RN8=
X-Received: by 2002:a5d:42d1:: with SMTP id t17mr10262750wrr.56.1574341156591;
 Thu, 21 Nov 2019 04:59:16 -0800 (PST)
MIME-Version: 1.0
References: <cover.1573779465.git.liu.denton@gmail.com> <cover.1574296987.git.liu.denton@gmail.com>
 <b24745bd6059017358bf47e96ad9ce33481f440f.1574296987.git.liu.denton@gmail.com>
In-Reply-To: <b24745bd6059017358bf47e96ad9ce33481f440f.1574296987.git.liu.denton@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 21 Nov 2019 07:59:05 -0500
Message-ID: <CAPig+cQviTjwLSZ+QkC62B58mq6z3yDA-XhPVJQYRq0inEo9nA@mail.gmail.com>
Subject: Re: [PATCH v2 12/21] t5317: use ! grep to check for no matching lines
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 20, 2019 at 7:46 PM Denton Liu <liu.denton@gmail.com> wrote:
> Several times in t5317, we would use `wc -l` to ensure that a grep
> result is empty. However, grep already has a way to do that... Its
> return code! Use `! grep` in the cases where we are ensuring that there
> are no matching lines.
>
> It turns out that these tests were simply born this way[1], doing all
> this unnecessary work for no reason, probably due to copy/paste
> programming, and it seems no reviewer caught it. Likewise, the
> unnecessary work wasn't noticed even when the code was later touched
> for various cleanups[2,3].
>
> Signed-off-by: Denton Liu <liu.denton@gmail.com>
> ---
>     Thanks for your help, Eric. I shamelessly stole your message text for
>     the commit message.

That's fine, but you ought to amend it a bit since it makes no sense
when extracted verbatim from my longer review comment which provided
needed context. In particular, the bit:

    ...doing all this unnecessary work for no reason...

is confusing since the reader doesn't know what "this unnecessary
work" is. My review email had an entire preceding paragraph that
provided context. It should at least be amended to say something along
the lines of:

    While at it, drop unnecessary invocations of 'awk' and 'sort' in
    each affected test since those commands do not influence the
    outcome. It's not clear why that extra work was being done in the
    first place, and the code's history doesn't shed any light on the
    matter since these tests were simply born this way[1], doing all
    the unnecessary work for no reason, probably due to copy/paste
    programming...
