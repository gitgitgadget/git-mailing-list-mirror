Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9B71E2022A
	for <e@80x24.org>; Wed, 26 Oct 2016 16:15:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754937AbcJZQPH (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Oct 2016 12:15:07 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58392 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752359AbcJZQPF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Oct 2016 12:15:05 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 474D846B8E;
        Wed, 26 Oct 2016 12:14:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ddHil0S0ChJEARP+l9BcyK6Hbks=; b=oehY5o
        YEj4iupcPTmB4ZQOtG2BVcC4GAeENTTRvGG+FRy6+p1J1AeC1pHk44TdW2u6XLdg
        6UMjVBk35uBqFmf6zVSq/RWYp1TQe7afmCDWm9E1Y/tLyeEkRKLpW3ppS3b0oYso
        2Slhy+wDLCOpnu0ZBJwIqOWOhrxxRh+jvJvLw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=BcF2pl64WPii3EO9uYvftS7PKC2KXW6j
        kSJsJTdhH/LND7KrqnkaE3IGTC5rGtXtM3xOsVXxxRdRC9bpC/BfP1h1nkPVjPUg
        v5aDQbdgnpnvB3ycyU08nbhvBilmM11PKX86+c/TEns3UM6mhnWIiIcFlY+6cKqy
        8VSE9PW+CCI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3FB8746B8D;
        Wed, 26 Oct 2016 12:14:59 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id BAEDF46B8C;
        Wed, 26 Oct 2016 12:14:58 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Christian Couder <christian.couder@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v1 00/19] Add configuration options for split-index
References: <20161023092648.12086-1-chriscool@tuxfamily.org>
        <xmqq8ttd7h8g.fsf@gitster.mtv.corp.google.com>
        <CACsJy8BBwWRGSyJDYQ7THj7quu4=T1xT_-KojQd45Vye4Kgcng@mail.gmail.com>
        <xmqqk2cws5t6.fsf@gitster.mtv.corp.google.com>
        <CACsJy8Ba0BY=pZwrKf5rcD5AaZ3YyKh9=ENKkj7hHpTqh00OnA@mail.gmail.com>
Date:   Wed, 26 Oct 2016 09:14:56 -0700
In-Reply-To: <CACsJy8Ba0BY=pZwrKf5rcD5AaZ3YyKh9=ENKkj7hHpTqh00OnA@mail.gmail.com>
        (Duy Nguyen's message of "Wed, 26 Oct 2016 16:25:44 +0700")
Message-ID: <xmqqeg33ccjj.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 574441C6-9B97-11E6-A824-3AB77A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

> On Wed, Oct 26, 2016 at 12:21 AM, Junio C Hamano <gitster@pobox.com> wrote:
>
> Even if we ignore user index files (by forcing them all to be stored
> in one piece), there is a problem with the special temporary file
> index.lock, which must use split-index because it will become the new
> index. Handling race conditions could be tricky with ref counting.
> Timestamps help in this regard.

I actually think using the split-index only for the $GIT_DIR/index,
the primary one, and using the full index for others is a bad idea,
as we use temporary index ourselves when making partial commits,
which happens quite often.

So time-based GC it is.

I actually do not think index.lock is a problem, but is a solution,
if we only limit the split-index to the primary one (we can have at
most one, so we can GC the stale shared ones while holding the
lock).

But that is no longer important.


