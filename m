Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 531E3C74A5B
	for <git@archiver.kernel.org>; Thu, 23 Mar 2023 20:26:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231152AbjCWU0c (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Mar 2023 16:26:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjCWU0b (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Mar 2023 16:26:31 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EBAE1E9F1
        for <git@vger.kernel.org>; Thu, 23 Mar 2023 13:26:27 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-5416698e889so414992577b3.2
        for <git@vger.kernel.org>; Thu, 23 Mar 2023 13:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112; t=1679603186;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=owrDuSpLsrOTD23+MH9UKp1B+GqdKvmANAdWW3ZtZJU=;
        b=jhVJFCEwBdYVobpzRXsN6sx7YcBUwjH9+L83Fp8ShTcCOZjZddcPYY9Y1/ta71n+2J
         I0b6TlB3jzqoOQq7l3bDNxt2ESKChYim3TEYmDdjcwwu9hu8RSfS9CYf3Gtv93XN3AiY
         P4X7Gw4Hzo1BRQzOO+eDHZQO1bUo9mbvVn7N9hKwHdyeokiiNW5LhUmMGEwpLnldfl1J
         QbVqASOjzp9GgdWPv2LEs4SaIOTaDC3oHLGEtqRXRclnW6it4dnFPjf1uTnGZFlrYqy7
         pV6kGJwGzdohUnVuSibkj9p2kflFYg1tSIBEhqMI2jDnpZ4G0iugVis1fsRSX1z3x4Y/
         sIvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679603186;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=owrDuSpLsrOTD23+MH9UKp1B+GqdKvmANAdWW3ZtZJU=;
        b=U+E5+Z6SzemhYNmhJO2OO0NTcoj96PWfvOJ2bCLlcN7fyDMYqAlfTS2AIWj4K1b3jz
         4rz7I72TJCUtSGFOiw9ZDv5FcB6jXm5huVc2cMlqWWT3nhyq6V1h7vMKotvNZtWDg+Db
         YrF8mB/JB6d5TRnX/G72rLo4OzEU+YOO0Pwd2X/po+qQIy7g6rEGqoU0ZarNPv9XBef9
         9Zg4r07LKalXHXPKplpR8XF7aMCH8SqL/qxC5JzEERjH2hNqIm47HIgF86vyvFHymGP+
         9TTjzgV7ugQq/HaYD/Z5m4AD9An6Dgd3pUXVqnGXiwRBBxnWD52GAS30mIdSaqf1Y/RT
         bn1Q==
X-Gm-Message-State: AAQBX9eXdhyVI+dxVXmUpqNpewCB+C1XOQd3I60hAeRu4lbM5raEub9L
        +uG3zxjQOhts8cEakmrib07B6AULQtY1cqwA/bLjGQ==
X-Google-Smtp-Source: AKy350ZXaUbNWEJXTuaFZKK5YLHyDSnpDidjMdhNN7yuYpRzVgbd5MD64/chogXiKI9VasylYmq22A==
X-Received: by 2002:a0d:d8d8:0:b0:539:4475:ff64 with SMTP id a207-20020a0dd8d8000000b005394475ff64mr4767460ywe.40.1679603186429;
        Thu, 23 Mar 2023 13:26:26 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id r7-20020a0dec47000000b00545a08184fcsm23567ywn.140.2023.03.23.13.26.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Mar 2023 13:26:26 -0700 (PDT)
Date:   Thu, 23 Mar 2023 16:26:24 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>
Cc:     git@vger.kernel.org,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Subject: Re: What is the status of GSoC 2022 work on making Git use roaring
 bitmaps?
Message-ID: <ZBy18EBE7WM/E4KF@nand.local>
References: <858rfnb770.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <858rfnb770.fsf@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jakub,

On Thu, Mar 23, 2023 at 08:26:11PM +0100, Jakub Narębski wrote:
> Hello,
>
> Could you tell me what is the status of the Abhradeep Chakraborty work
> in integrating roaring bitmaps (using CRoaring) in addition to, or
> replacing current EWAH bitmaps (using ewok)? The last communication
> about this shows that the patches were on the road to being merged in,
> see e.g. https://medium.com/@abhra303/gsoc-final-report-feaaacfae737 ,
> but there is no mention of 'roaring' in Git's code or documentation.

Abhradeep started working on a prototype to teach Git how to read and
write Roaring+Run bitmaps in this series:

  https://lore.kernel.org/git/pull.1357.git.1663609659.gitgitgadget@gmail.com/

Some folks gave it a review, but there wasn't any serious traction and I
don't think that Abhradeep has had a chance to come back to the series.

For what it's worth, I would love if Abhradeep (or anybody else
interested in working on this area) picked it back up, either using that
series as a starting point or going from scratch.

> Moreover, there is no proposal to finish this on the GSoC 2023 ideas
> page: https://git.github.io/SoC-2023-Ideas/ .  Is it because it would be
> too small of a project?  Or maybe it turned out that roaring bitmaps
> were not a good idea - though I haven't found mentions of any benchmarks
> of roaring vs EWAH in the mailing list archives?  Or perhaps there is no
> one to mentor this proposal?

I don't have the capacity to mentor a student this cycle, and I am
probably the most interested among potential mentors in seeing this
project through ;-).

I don't think that it's too small (in fact, it was probably an error on
my part to include this as a potential stretch goal in Abhradeep's
project). We don't have any evidence that it's a good or bad idea.

Abhradeep promised[1] that he'd include some performance work in his
next version of that series. I think the main things we'd be interested
in are:

  - Does using Roaring provide a file-size advantage over
    EWAH-compressed bitmaps?
  - Does Roaring make it faster to inflate bitmaps? To deflate them?

Deflating bitmaps doesn't matter as much, IMHO, since that is a cost
that we pay only when we first have to compress bitmaps before writing
them. But if we could significantly reduce the inflation cost, that
would be an advantage to using Roaring+Run bitmaps over EWAH ones since
they would be faster to decompress at read-time.

Thanks,
Taylor

[1]: https://lore.kernel.org/git/CAPOJW5wkXrV8eOysz6aJ5jN2u_u-iTX_3om3tSDKw+EmfCJBEw@mail.gmail.com/
