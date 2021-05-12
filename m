Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AE8FC433ED
	for <git@archiver.kernel.org>; Wed, 12 May 2021 20:35:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4643961408
	for <git@archiver.kernel.org>; Wed, 12 May 2021 20:35:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239293AbhELUgM (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 May 2021 16:36:12 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:44640 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241737AbhELSFl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 May 2021 14:05:41 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id E5E441F5AE;
        Wed, 12 May 2021 18:04:31 +0000 (UTC)
Date:   Wed, 12 May 2021 18:04:31 +0000
From:   Eric Wong <e@80x24.org>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Gregory Anders <greg@gpanders.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/9] send-email: various optimizations to speed up by >2x
Message-ID: <20210512180431.GA22854@dcvr>
References: <cover-0.9-0000000000-20210512T132955Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover-0.9-0000000000-20210512T132955Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> wrote:
> As noted in the subject this speeds up git-send-email invocations by
> ~2x or more, and brings the very slow t9001 test from running in ~26s
> on my box to ~12s. It's no longer consistently the slowest test I run.
> 
> This is basically done in two ways: We lazily invoke "git config" to
> get config, before it's very eager, and deferring Perl compilation
> with s/use/require/g.

Nice.  I've been doing similar things elsewhere and hoping to
find time to get around to git-svn at some point.

> Ævar Arnfjörð Bjarmason (9):
>   send-email: remove non-working support for "sendemail.smtpssl"
>   send-email: refactor sendemail.smtpencryption config parsing
>   send-email: lazily load config for a big speedup
>   send-email: lazily shell out to "git var"
>   send-email: use function syntax instead of barewords
>   send-email: get rid of indirect object syntax
>   send-email: lazily load modules for a big speedup
>   perl: lazily load some common Git.pm setup code
>   send-email: move trivial config handling to Perl

I spotted some further optimizations for 7 and 8,
but otherwise consider this series:

Reviewed-by: Eric Wong <e@80x24.org>
