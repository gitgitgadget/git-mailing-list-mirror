Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D7A091FF76
	for <e@80x24.org>; Fri, 23 Dec 2016 18:04:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S941331AbcLWSEu (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Dec 2016 13:04:50 -0500
Received: from bsmtp1.bon.at ([213.33.87.15]:6658 "EHLO bsmtp1.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1758653AbcLWSEt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Dec 2016 13:04:49 -0500
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp1.bon.at (Postfix) with ESMTPSA id 3tlbrb22ydz5tlK;
        Fri, 23 Dec 2016 19:04:47 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 11F4C221D;
        Fri, 23 Dec 2016 19:04:46 +0100 (CET)
Subject: Re: [PATCH] mingw: add a regression test for pushing to UNC paths
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
References: <9fb8a9f405b19db087379ea5bbad80c3fbac8e4e.1482513055.git.johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <6d69b529-a42c-9f93-f342-7c6c19170285@kdbg.org>
Date:   Fri, 23 Dec 2016 19:04:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.5.1
MIME-Version: 1.0
In-Reply-To: <9fb8a9f405b19db087379ea5bbad80c3fbac8e4e.1482513055.git.johannes.schindelin@gmx.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 23.12.2016 um 18:11 schrieb Johannes Schindelin:
> Let's make sure that it does not regress again, by introducing a test
> that uses so-called "administrative shares": disk volumes are
> automatically shared under certain circumstances, e.g.  the C: drive is
> shared as \\localhost\c$.

Clever!

> +test_expect_success setup '
> +	test_commit initial
> +'
> +
> +test_expect_success clone '
> +	git clone "file://$UNCPATH" clone
> +'
> +
> +test_expect_success push '
> +	(
> +		cd clone &&
> +		git checkout -b to-push &&
> +		test_commit to-push &&
> +		git push origin HEAD
> +	)
> +'
> +
> +test_done

Wouldn't at a minimum

test_expect_success 'check push result' '
	git rev-parse to-push
'

be a good idea to make sure that the pushed commit actually arrived?

-- Hannes

