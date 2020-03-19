Return-Path: <SRS0=WCE0=5E=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E3C4C4332B
	for <git@archiver.kernel.org>; Thu, 19 Mar 2020 16:01:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A61D2080C
	for <git@archiver.kernel.org>; Thu, 19 Mar 2020 16:01:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727933AbgCSQBk convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Thu, 19 Mar 2020 12:01:40 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45454 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727496AbgCSQBk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Mar 2020 12:01:40 -0400
Received: by mail-wr1-f66.google.com with SMTP id i9so3688280wrx.12
        for <git@vger.kernel.org>; Thu, 19 Mar 2020 09:01:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8nADK+xfWiiT7E4Zo8HKcqx3mxdig8vbQJzKZdTVaSg=;
        b=pvvaY3GYTcSLgHP9+m9QLlxi17xaswbnajIe0IhpnDQAg25STyItG2VM4bc6sGvTLz
         jNKIUomdHUasRz+gmWIIp91gNh+TrHn1lG26vPMFK7qXpgcKUlyD7qjb1pIkjF7u6JM+
         1JMRVtHYKdp1UCfc9g6FIw2wnNrTmQdJN2VWsOcy2dhcHqlkvDBg5c9gNG76XffM1ts2
         zkdGcbXQR2coVQrlHS4MdxQVizryNObDvLAZqlf2d4NboMYHz2DjTG6o62wbJlsR8MKR
         Wk0swQN2gigZa1ianWm8A6in9kvEXh0qkhM+mlwJU5s2FoscRaa74rPZGMQqffpgq6Vg
         K5oQ==
X-Gm-Message-State: ANhLgQ0SMmleLtqQVXe8Um7Fyed0B/sxtsCY6ZTU9dKAOkzd9uUkFbnO
        Y9s7ulguXJJT0AwXk1kMqYVL/LWZw9w9D/GSlJs=
X-Google-Smtp-Source: ADFU+vuud17If5s7uxVAT2WJXbZIeWSnDCEkeypO+3n1zfclhUjMWduyVagl49sEerdH5sfTzyVbPxUh254B+OdzDVw=
X-Received: by 2002:adf:ce8e:: with SMTP id r14mr5162155wrn.415.1584633699099;
 Thu, 19 Mar 2020 09:01:39 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1584625896.git.congdanhqx@gmail.com> <c45d6383173d8d3e73cdcdd6e993d3259d519a68.1584625896.git.congdanhqx@gmail.com>
 <20200319155307.GB3513282@coredump.intra.peff.net>
In-Reply-To: <20200319155307.GB3513282@coredump.intra.peff.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 19 Mar 2020 12:01:28 -0400
Message-ID: <CAPig+cRzHtGu2KfjoO4DaPWzDrJOhEQGkgo2Fm7egUPM9m7Vyw@mail.gmail.com>
Subject: Re: [PATCH 1/6] t4061: use POSIX compliance regex(7)
To:     Jeff King <peff@peff.net>
Cc:     =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 19, 2020 at 11:53 AM Jeff King <peff@peff.net> wrote:
> On Thu, Mar 19, 2020 at 09:00:02PM +0700, Đoàn Trần Công Danh wrote:
> > Fix it by using literal `+` instead.
>
> This makes sense, I think. It could hurt a sed which is expected ERE and
> needs the "+" escaped, but I think such a sed would be wrong (and I
> imagine would break things elsewhere).

I had the same thought and considered suggesting a character class:

    sed -n -e "1,4d" -e "s/^[+]//p" <"$1" >.tmp-1

to make it painfully obvious that "+" is not special in the
expression. But then I thought better of it -- for the same reason as
you (to wit: such a 'sed' would be wrong) -- and decided against
saying anything.
