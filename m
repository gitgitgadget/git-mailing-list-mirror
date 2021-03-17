Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE434C433DB
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 18:06:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 66B1764F53
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 18:06:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232866AbhCQSF7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Mar 2021 14:05:59 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:63586 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232683AbhCQSFh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Mar 2021 14:05:37 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 32A9E119034;
        Wed, 17 Mar 2021 14:05:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=FZn3twYsE2IZPMe/V+KxCjOnCIY=; b=qhU9EK
        jXqhkLi7+te4F9fjCL/nU1/Ug1kiRV8fJ9ynsrOOoxhgGrtABSPruv0NJNESrTkW
        f7Z537UwA1Y2+n96niuQQD3yKh5q0TV9jpK+UlyfhozBnnkraGMl3VfXwLdlsph8
        p15PC2iPBPp9bw7BcP9h31g7mHwXBzZ15D50Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=tYLGkAQOP54Eknr+/rPz3mb/oyw2/R5+
        Bx/4GX785B+j/Wi/tn6a75TQcpKwFGbOpeEad0r+sdgkubbnCINhWeIUO8Ow1Z7j
        W6EccGGJyHezAA90+GDm6qV8CBZQ5niN5oHqANJ6H6OWGmFuHgqu4fPfY9APBTGO
        hNyVbjfbPxc=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 2A390119033;
        Wed, 17 Mar 2021 14:05:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 2E0CF119032;
        Wed, 17 Mar 2021 14:05:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 0/7] Sort lists and add static-analysis
References: <cover.1615856156.git.liu.denton@gmail.com>
Date:   Wed, 17 Mar 2021 11:05:32 -0700
In-Reply-To: <cover.1615856156.git.liu.denton@gmail.com> (Denton Liu's message
        of "Mon, 15 Mar 2021 17:56:19 -0700")
Message-ID: <xmqqwnu5wt8z.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5E7625C8-874B-11EB-B0DF-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

> As a follow-up to [0], sort some file lists and create a static-analysis
> check to ensure that those lists don't ever become un-sorted.
>
> [0]: https://lore.kernel.org/git/nycvar.QRO.7.76.6.2010081156350.50@tvgsbejvaqbjf.bet/
>
> Denton Liu (7):
>   Makefile: mark 'check-builtins' as a .PHONY target
>   Makefile: ASCII-sort LIB_OBJS
>   builtin.h: ASCII-sort list of functions
>   test-tool.h: ASCII-sort list of functions
>   Makefile: add 'check-sort' target
>   ci/run-static-analysis.sh: make check-builtins
>   ci/run-static-analysis.sh: make check-sort

I'd expect that the series would be structured better if we 

 - move #6 (static-analysis runs check-builtins) earlier, perhaps to
   the front of the series, as there is nothing to fix to make the
   check pass.

 - merge #7 into #5.

I've also left comments on a few individual steps.

Thanks for working on it.

>  Makefile                  | 30 ++++++++++++++++++++++++++++--
>  builtin.h                 | 22 +++++++++++-----------
>  check-sort.perl           | 31 +++++++++++++++++++++++++++++++
>  ci/run-static-analysis.sh |  2 +-
>  t/helper/test-tool.h      |  6 +++---
>  5 files changed, 74 insertions(+), 17 deletions(-)
>  create mode 100755 check-sort.perl
