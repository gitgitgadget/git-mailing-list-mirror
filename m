Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61DBAC433F5
	for <git@archiver.kernel.org>; Fri, 19 Nov 2021 20:05:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 476B761B30
	for <git@archiver.kernel.org>; Fri, 19 Nov 2021 20:05:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233651AbhKSUIq (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Nov 2021 15:08:46 -0500
Received: from bsmtp2.bon.at ([213.33.87.16]:38694 "EHLO bsmtp2.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230399AbhKSUIq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Nov 2021 15:08:46 -0500
Received: from [192.168.0.98] (unknown [93.83.142.38])
        by bsmtp2.bon.at (Postfix) with ESMTPSA id 4Hwnj06RK5z5tlB;
        Fri, 19 Nov 2021 21:05:40 +0100 (CET)
Subject: Re: git 2.34.0: Behavior of `**` in gitignore is different from
 previous versions.
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Danial Alihosseini <danial.alihosseini@gmail.com>,
        Jeff King <peff@peff.net>,
        Derrick Stolee <dstolee@microsoft.com>, git@vger.kernel.org
References: <CACLOEFZz7bunO2S5-ec1K10B9AJU4-m50j3j9c=12R6d1D+-dg@mail.gmail.com>
 <YZaHpJKeyDEY8qKW@coredump.intra.peff.net>
 <2bd2269f-c7f1-7afb-7052-48fac148dffd@gmail.com>
 <CACLOEFbY3LwMa2uhc=9jmcGFf0mvWzEM=YityLyFcuGWXVmqbw@mail.gmail.com>
 <72fffbff-16f7-fa17-b212-67aae9e1b034@gmail.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <190a1fea-124d-2e85-38ea-9dab87f3e377@kdbg.org>
Date:   Fri, 19 Nov 2021 21:05:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <72fffbff-16f7-fa17-b212-67aae9e1b034@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 19.11.21 um 15:51 schrieb Derrick Stolee:
> What is unclear to me is what exactly "match a directory" means.
> If we ignore a directory, then we ignore everything inside it (until
> another pattern says we should care about it), but the converse
> should also hold: if we have a pattern like "!data/**/", then that
> should mean "include everything inside data/<A>/ where <A> is any
> directory name".
> 
> My inability to form a mental model where the existing behavior
> matches the documented specification is an indicator that this was
> changed erroneously. A revert patch is included at the end of this
> message.
> 
> If anyone could help clarify my understanding here, then maybe
> there is room for improving the documentation.

You form a wrong mental model when you start with the grand picture of a
working tree. That is, when you say

- here I have theeeeeese many files and directories,
- and I want to ignore some: foo/**/,
- but I don't want to ignore others: !bar/**/.

This forms the wrong mental model because that is not how Git sees the
working tree: it never has a grand picture of all of its contents.

Git only ever sees the contents of one directory. When Git determines
that a sub-directory is ignored, then that one's contents are never
inspected, and there is no opportunity to un-ignore some of the
sub-directory's contents.

-- Hannes
