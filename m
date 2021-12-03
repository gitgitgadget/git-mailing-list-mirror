Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38EFCC433EF
	for <git@archiver.kernel.org>; Fri,  3 Dec 2021 09:19:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379509AbhLCJXF (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Dec 2021 04:23:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351316AbhLCJXD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Dec 2021 04:23:03 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AFCEC06173E
        for <git@vger.kernel.org>; Fri,  3 Dec 2021 01:19:40 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id x15so9021439edv.1
        for <git@vger.kernel.org>; Fri, 03 Dec 2021 01:19:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=8t14LYi6sxXnbT7jmGTphBjU736vvvCQTWne/muFKmU=;
        b=SnKeg9OcLLF0zuZ3OeC/fw0AVN24ZZRSr0xC9YQ42L3nrrzC9q560bCBvrLS62pMaX
         Drg0qtfDUs0oN4KmuUA03kgA4oFnZMbaEieTx1Q04mWivFzCNu+f0EnsjPe1GOjuDYui
         ZqSayBP68QGQSxOmm3GsV/pVrp9kc2tikIL3Zd3RDsb+Mrpenf7WNOd2Nn2UtdWbn6FL
         ANxlLQ3fVTSkfgdWP/Y/hBe/Vp9Z7PQ3PUHNxoYJNtCTN1+Lse5Vw3P7VVAcezRItS0h
         rA1WGl3uFFwLggDqJqavpvd+ZD9WEWSxitFr7hg5JkfTDvluznihetMvieOT3XVA+aSH
         MQWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=8t14LYi6sxXnbT7jmGTphBjU736vvvCQTWne/muFKmU=;
        b=0OXJf1Gj+Ccap1dVHqKWdPGq4untRtWRzqe/kocQF1We1QfzGuHmvTK9aJo9Wh3vQf
         I0eyyyhS2iEDuRDVD1HMZBkVNI8MAhgpxRG1CvBRYU9ukT1lHXNEl+Xl1u/Ro9Gk7K9N
         Bj3hMl8M5mwceZdZYrneiGc34TkYboSNO4AV4GK1dsxbgfzC28UfbPdrQDHXCgoYvbtd
         mn5ycvgcNMSElLIgP9MAft1SGuV+Z/emc/QJMR6p1u8wOHRjUUXdbdgHDBNlNQtdErJg
         /CPhZRlBuRruqJPLzUWSwMwpEuIaSqzdId7uz/+bY4nRNDXhrH6s/WXdqLktLebTQO13
         Coig==
X-Gm-Message-State: AOAM530GtHKwEORFaj8qS4Dr5dqhsQ7pigWA5yAGM5DAfl1rg10b29Ub
        mIy3xy+/iO7S3Zo6JPAKrgqoUouGlpg=
X-Google-Smtp-Source: ABdhPJwJLnN4WJdJz1FAgmvBQHmCmOFzmv+eBcbmd4aLckyHToUUlP/nz2NrmnV+wAFfUlWg3ZzXTg==
X-Received: by 2002:a17:906:580a:: with SMTP id m10mr23189748ejq.213.1638523178609;
        Fri, 03 Dec 2021 01:19:38 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id m6sm1570202edc.36.2021.12.03.01.19.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Dec 2021 01:19:38 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mt4jB-0003hg-GG;
        Fri, 03 Dec 2021 10:19:37 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     git@vger.kernel.org, Baruch Burstein <bmburstein@gmail.com>,
        Randall Becker <rsbecker@nexbridge.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Rafael Silva <rafaeloliveira.cs@gmail.com>
Subject: Re: [PATCH 1/2] worktree: send "chatty" messages to stderr
Date:   Fri, 03 Dec 2021 10:17:02 +0100
References: <20211203034420.47447-1-sunshine@sunshineco.com>
 <20211203034420.47447-2-sunshine@sunshineco.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.9
In-reply-to: <20211203034420.47447-2-sunshine@sunshineco.com>
Message-ID: <211203.86fsrat592.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Dec 02 2021, Eric Sunshine wrote:

> The order in which the stdout and stderr streams are flushed is not
> guaranteed to be the same across platforms or `libc` implementations.
> This lack of determinism can lead to anomalous and potentially confusing
> output if normal (stdout) output is flushed after error (stderr) output.
> For instance, the following output which clearly indicates a failure due
> to a fatal error:
>
>     % git worktree add ../foo bar
>     Preparing worktree (checking out 'bar')
>     fatal: 'bar' is already checked out at '.../wherever'
>
> has been reported[1] on Microsoft Windows to appear as:
>
>     % git worktree add ../foo bar
>     fatal: 'bar' is already checked out at '.../wherever'
>     Preparing worktree (checking out 'bar')

Makes sense.

>  test_expect_success 'repair incorrect gitdir' '
> @@ -141,10 +139,9 @@ test_expect_success 'repair incorrect gitdir' '
>  	git worktree add --detach orig &&
>  	sed s,orig/\.git$,moved/.git, .git/worktrees/orig/gitdir >expect &&
>  	mv orig moved &&
> -	git worktree repair moved >out 2>err &&
> +	git worktree repair moved 2>err &&
>  	test_cmp expect .git/worktrees/orig/gitdir &&
> -	test_i18ngrep "gitdir incorrect" out &&
> -	test_must_be_empty err
> +	test_i18ngrep "gitdir incorrect" err
>  '

This is just a "for bonus points", but maybe we could/should while we're
at it harden and make the tests more exhaustive by checking the full
output of both, e.g.

	cat >actual.out <<-\EOF &&
	Preparing worktree (checking out 'bar')
	EOF
	cat >actual.err <<-\EOF &&
	fatal: 'bar' is already checked out at '.../wherever'
	EOF
        <cmd> [...]
	test_cmp expect.out actual.out &&
	test_cmp expect.err actual.err

Doesn't need a re-roll etc., just if you're interested... :)
