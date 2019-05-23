Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0E3AD1F462
	for <e@80x24.org>; Thu, 23 May 2019 06:14:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726310AbfEWGOH (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 May 2019 02:14:07 -0400
Received: from bsmtp7.bon.at ([213.33.87.19]:62629 "EHLO bsmtp7.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725873AbfEWGOH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 May 2019 02:14:07 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp7.bon.at (Postfix) with ESMTPSA id 458fMw2bfcz5tl9;
        Thu, 23 May 2019 08:14:04 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id A6F3B2113;
        Thu, 23 May 2019 08:14:03 +0200 (CEST)
Subject: Re: [PATCH] Make stashing nothing exit 1
To:     Maksim Odnoletkov <odnoletkov@mail.ru>
Cc:     gitster@pobox.com, git@vger.kernel.org, keithbsmiley@gmail.com
References: <xmqqh8bsphny.fsf@gitster-ct.c.googlers.com>
 <20190522235705.68452-1-odnoletkov@mail.ru>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <30d1e067-4184-30e8-bfd2-6ba8da0fc1f5@kdbg.org>
Date:   Thu, 23 May 2019 08:14:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190522235705.68452-1-odnoletkov@mail.ru>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 23.05.19 um 01:57 schrieb Maksim Odnoletkov:
> The problem with current behaviour is it makes it hard to use stash in
> scripts. A natural stash use case is: wrap some operation requiring a
> clean working tree with a stash push-pop pair. But that doesn't work
> properly when working tree is already clean - push silently does nothing
> and following pop becomes unbalanced. You have to keep that in mind and
> work around with something like:
> 
> if ! git diff-index --exit-code --quiet HEAD
> then
> 	git stash push
> 	trap 'git stash pop' EXIT
> fi
> 
> With this change this can be simplified to:
> 
> git stash push && trap 'git stash pop' EXIT

In a script, shouldn't you better use 'create' + 'store' instead of 'push'?

-- Hannes
