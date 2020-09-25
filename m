Return-Path: <SRS0=RFRG=DC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD242C4363D
	for <git@archiver.kernel.org>; Fri, 25 Sep 2020 18:12:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D35E208A9
	for <git@archiver.kernel.org>; Fri, 25 Sep 2020 18:12:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729720AbgIYSMP (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Sep 2020 14:12:15 -0400
Received: from bsmtp2.bon.at ([213.33.87.16]:16665 "EHLO bsmtp2.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726401AbgIYSMP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Sep 2020 14:12:15 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp2.bon.at (Postfix) with ESMTPSA id 4Byg3x2lrQz5tlF;
        Fri, 25 Sep 2020 20:12:13 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id BE798210E;
        Fri, 25 Sep 2020 20:12:12 +0200 (CEST)
Subject: Re: [RFC 0/1] Leading whitespace as a function identification
 heuristic?
To:     Ryan Zoeller <rtzoeller@rtzoeller.com>
References: <20200923215859.102981-1-rtzoeller@rtzoeller.com>
From:   Johannes Sixt <j6t@kdbg.org>
Cc:     git@vger.kernel.org
Message-ID: <f0fab667-fb72-b15d-258b-aa437235bba4@kdbg.org>
Date:   Fri, 25 Sep 2020 20:12:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200923215859.102981-1-rtzoeller@rtzoeller.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 23.09.20 um 23:59 schrieb Ryan Zoeller:
> I've recently been annoyed by git's choice of lines when invoking
> `git diff --function-context`. git isn't doing a _bad_ job per se,
> given that it's using regular expressions to parse nonregular languages,
> but in my opinion it could do better.
> 
> The issue I'm seeing is that constructs like nested functions cause
> `git diff --function-context` to stop taking lines prematurely; a line
> containing a function declaration has been reached, but it's not the one
> I'm expecting git to stop at. This results in some of the function being
> omitted from the output of `git diff --function-context`, and also
> manifests itself as the incorrect function being listed in the hunk header
> in general.

There are two mechanisms at play here:

The first is that the context above and below a point of interest is
extended to the next function. This is relevant for both `git diff` and
`git grep` when --function-context is specified.

The second is the determination of the hunk header. It is only relevant
for `git diff`.

The purpose of the hunk header is to get an estimation of where the hunk
is located. It is most helpful in this case when the closest anchor
point is listed; it is not important to find where the semantically
surrounding nesting context begins.

Therefore, I suggest that you aim only for the --function-context case,
because there it makes sense to find the correctly nested surrounding
context if possible.

-- Hannes
