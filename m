Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 10FB41F453
	for <e@80x24.org>; Wed, 24 Apr 2019 18:48:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727904AbfDXSsf (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Apr 2019 14:48:35 -0400
Received: from bsmtp7.bon.at ([213.33.87.19]:55881 "EHLO bsmtp7.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726074AbfDXSsf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Apr 2019 14:48:35 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp7.bon.at (Postfix) with ESMTPSA id 44q8Tr6cynz5tlH;
        Wed, 24 Apr 2019 20:48:32 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 8ED291AE8;
        Wed, 24 Apr 2019 20:48:32 +0200 (CEST)
Subject: Re: [PATCH 1/5] run-command: add preliminary support for multiple
 hooks
To:     Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Duy Nguyen <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <20190424004948.728326-1-sandals@crustytoothpaste.net>
 <20190424004948.728326-2-sandals@crustytoothpaste.net>
 <xmqqo94w2l3k.fsf@gitster-ct.c.googlers.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <8f79d251-58d9-f63b-7171-7f1fbd11c6f9@kdbg.org>
Date:   Wed, 24 Apr 2019 20:48:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <xmqqo94w2l3k.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 24.04.19 um 04:27 schrieb Junio C Hamano:
> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>> +static int has_hook(struct strbuf *path, int strip)
>> +{
>> +	if (access(path->buf, X_OK) < 0) {
> 
> Does ".git/post-commit" that is not an executable exist?
> 
> It was perfectly fine for find_hook() to say "there is no hook for
> post-commit" in the old world in such a case, because the
> unexecutable file it found is not going to be run anyway.
> 
> But it is not clear if has_hook(), that affects "there is no single
> hook file for post-commit, so let's look at post-commit.d" decision
> made by find_hooks(), should behave that way.  It somehow feels more
> intuitive if a post-commit file that is not executable, by merely
> existing, stops post-commit.d directory from being scanned, at least
> to me.

Furthermore, basing a decision on whether a file is executable won't
work on Windows as intended. So, it is better to aim for an existence check.

-- Hannes
