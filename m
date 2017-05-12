Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 85D151FF34
	for <e@80x24.org>; Fri, 12 May 2017 14:20:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757472AbdELOUb (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 May 2017 10:20:31 -0400
Received: from mail-it0-f47.google.com ([209.85.214.47]:34909 "EHLO
        mail-it0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757400AbdELOUa (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 May 2017 10:20:30 -0400
Received: by mail-it0-f47.google.com with SMTP id c15so11401773ith.0
        for <git@vger.kernel.org>; Fri, 12 May 2017 07:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=M3jd38dLdBisA8IoRNtdRLRYtotn7ud1yW9RrUr8xF0=;
        b=tKDbC+xarSnLtCzKlG5OtM5SMm1Y6TLaH1Wf3x8cJOEePNb22LH85H/bCaJBX7QaRY
         uTU206oLg8cIaCcr1SlFF2EVlHtCI+YeW2lnTz3Y/9D4gCRUFtasoJc1rcIlbO3XEC3Q
         BGXkDs3wUI8a4eXAhCFxIj/XD9jEECM2rB7z1bF0JkUQ9nT7QDgcgWp2IfgEE2970030
         0AR5mI6L254jXUg1kpBxpWm8/BzDCAhprco4KrgoLdAXl/PIYUlRXfO8PTfk79RiMFc3
         zTipcuMn5yxTVz0KyXB+b8pwIc9mn+Q6JRyMafKv7clOz4gzg5zAuJPLyLb7aicXVQbp
         T/Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=M3jd38dLdBisA8IoRNtdRLRYtotn7ud1yW9RrUr8xF0=;
        b=BXhTTUQwrA4qCF4RJdGrzKn7GUJQ+Fgw0qEt2hR492OImxE7Zg3JuSrBtZ4D9s9VsL
         kxT1Lel5LwAX79gingN0iLoHH8q39apuLLu11wP43YsPLkspqQKFfa9F7Ya4036Farpi
         bUJKk41i2bg+Dsr8zt8C+Wb7Dx884StWskl4jiP0sXmk1nPv+dMvhQ/Bh3YfjP0SsmtV
         j9ler4PM3JJL5GOIb2qTdcX2/sJhs1FDPQFqHeebvr1QcFR0+87ZhmU9zeLr5ddOti14
         gwSMKFyPkR1kmuOX1cKdvthBeQI4AORmjW2iNKCDYr0eRoo+jzIpZqyXG0QrXoTSU5jm
         njcg==
X-Gm-Message-State: AODbwcDUzQT3+Ra+Llymn+KZDBdnuZT29Z1WdXiAu9zeF3WDslfbDLU0
        leM+9YHj5u6tSgW1mMZu660xoxGAw/EkRH8=
X-Received: by 10.36.225.8 with SMTP id n8mr3747312ith.29.1494598829917; Fri,
 12 May 2017 07:20:29 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.38.6 with HTTP; Fri, 12 May 2017 07:19:59 -0700 (PDT)
From:   Josh Hagins <hagins.josh@gmail.com>
Date:   Fri, 12 May 2017 10:19:59 -0400
Message-ID: <CANuW5x0pBwfQeha50mxN8pVQKm67u_b3UKTCQ8ZbJA6FUGvYbw@mail.gmail.com>
Subject: [Git 2.13.0] BUG: setup_git_env called without repository
To:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey Git people,

Since upgrading to Git 2.13.0 I'm seeing this error message whenever
`git config --local <whatever>` is called outside a Git repository.
For example, note the difference in behavior between Git 2.13 and
Apple Git:

    $ pwd
    /Users/jhagins
    $ /usr/bin/git --version
    git version 2.11.0 (Apple Git-81)
    $ /usr/bin/git config --local --get user.name
    $ /usr/local/bin/git --version
    git version 2.13.0
    $ /usr/local/bin/git config --local --get user.name
    fatal: BUG: setup_git_env called without repository

Apple Git outputs nothing, as expected. The summarized release notes
published by GitHub specifically mentioned that instances of this
error message should be reported, so here you go!

Please let me know if I can provide any more information that would be helpful.

Cheers!

-- 
Josh Hagins
