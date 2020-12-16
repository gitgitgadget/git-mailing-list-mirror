Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 292C6C4361B
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 02:18:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6735230FF
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 02:18:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725385AbgLPCSq (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Dec 2020 21:18:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725274AbgLPCSq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Dec 2020 21:18:46 -0500
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9019C0613D6
        for <git@vger.kernel.org>; Tue, 15 Dec 2020 18:18:05 -0800 (PST)
Received: by mail-qv1-xf42.google.com with SMTP id p12so10626477qvj.13
        for <git@vger.kernel.org>; Tue, 15 Dec 2020 18:18:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zB7pptHzYvAi7BK3mz5zxeviAlhoToos6nQslCMNh/8=;
        b=aiM/jQryS+e65h+DTOLwWW9suCPK8IPCsoo8C0Xy6Iu4X4kWVb9zCjhGeNVCfN4MUe
         F/N94DrQ9qXfFXNukerzFxTkhIdI3X1zeY5SgtY1RK4fHTqmpqryuiCAyOtwMATm4r3S
         OkvuS8sZBOho/J1L1whHBptCQx0FRv+xAbjXiRp12v99zLdZQbscAtg8x+ewpD9XPgrW
         6LAm5egbzWqlEzCi/lj0WJuakLdctGaNenGkRFkFYkFTOAsilQiz2R402AJJCbShclgR
         7De4U87L6JRysskOlTQh/egBNbn+r4NCIYkXYlIarOC9ENRxCgXTj7iZWqG5NCPkc8/6
         O/DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zB7pptHzYvAi7BK3mz5zxeviAlhoToos6nQslCMNh/8=;
        b=p5YoM/TdykO8/iIpgf5lW0Um2WO5cbmFUOgLhME7lUOzjJlZHuBYhuAb0+mjxLUKW2
         PpnCCxnsHu9HNJFcWtHz9Djg08QDEBjk3GW/Mb9sQTVJP5eJhI7efK4ZOosGxWtWr9td
         2yZsFC5tQCG2j3OTiS4YmB6/Al0ojNE5IZm3uFoBlqlcNYaC1b6Mm+wYy16tzMlcWEyg
         i8XH0apV2cOoaACQGLjlAMrnpV4TO6IB3fdU6dgJIXx1+TLf77ReSXZtMCc3hU9R3vG6
         zypUZH0gamwGT6i6hF04gm9ql7WYnTEF9ZpjTV7YxzHz0t+Qt/E+1K1or/sgsWuz4p48
         SCjA==
X-Gm-Message-State: AOAM530uW7RiaaySKgkGOUslyWdgGd34FJKTb8pjTbTQ6pTQqeMCent9
        DWWcKrIhIBzfke5SYZ52FQg=
X-Google-Smtp-Source: ABdhPJxxkMI9bzvxMjTwZInIBswuD2yuGYj26x6D2GgXzCin6gAdi+PPJAkNZvfXjwh2ymJ5DqOXiQ==
X-Received: by 2002:a05:6214:d4a:: with SMTP id 10mr38396661qvr.62.1608085085223;
        Tue, 15 Dec 2020 18:18:05 -0800 (PST)
Received: from [192.168.1.127] ([192.222.216.4])
        by smtp.gmail.com with ESMTPSA id 127sm389562qkj.51.2020.12.15.18.18.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Dec 2020 18:18:04 -0800 (PST)
From:   Philippe Blain <levraiphilippeblain@gmail.com>
Subject: Re: Perf lib sanity tests fail on OSX
To:     Sangeeta <sangunb09@gmail.com>, Git List <git@vger.kernel.org>
Cc:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
References: <CAHjREB6QrR-FQzwOphgw1z1Rba=o7gNvEwomHc60aNH3EkQg5A@mail.gmail.com>
Message-ID: <fde32488-97e7-55f3-86d5-25f525492844@gmail.com>
Date:   Tue, 15 Dec 2020 21:18:02 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <CAHjREB6QrR-FQzwOphgw1z1Rba=o7gNvEwomHc60aNH3EkQg5A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Sangeeta,

Le 2020-12-15 à 14:08, Sangeeta a écrit :

> Hey everyone,
>
> The performance test, p0000-perf-lib-sanity.sh[1], is failing on my
> local OSX machine due to an error in the test_export of the foo
> variable. I think the test is failing because it is not able to export
> the `foo` variable using `test_export`.
> [1] https://github.com/git/git/blob/master/t/perf/p0000-perf-lib-sanity.sh#L26

It is not the export per se that fails (that would be very bad news
indeed), it is the shell magic in the 'test_run_perf_' function in
'perf-lib.sh' that uses a non-portable sed(1) invocation:

      set | sed -n "s'"/'/'\\\\''/g"';s/^\\($test_export_\\)/export 
'"'&'"'/p" >test_vars

As you might already know, since macOS has some BSD background/ancestry,
most POSIX utilities are closer to the OpenBSD/FreeBSD versions than to
their GNU/Linux counterparts.

I successfully ran p0000-perf-lib-sanity.sh on my Mac after installing 
the GNU version of sed using Homebrew and making sure to follow the
indications in the 'Caveats' so that the sed from Homebrew is first in
PATH:

      brew install gnu-sed

      export PATH="/usr/local/opt/gnu-sed/libexec/gnubin:$PATH"

      ./p0000-perf-lib-sanity.sh

I do not know sed syntax enough to fix the invocation to make it
portable (nor do I know if it's possible).

I've CC-ed Johannes and Lars since they were involved in the thread you 
mentioned.

> Thanks and Regards,
> Sangeeta

Cheers,

Philippe.

P.S. my usual email setup is broken at the moment so I'm sorry if this 
email is formatted wrong.
P.P.S. and sorry for the re-send.

