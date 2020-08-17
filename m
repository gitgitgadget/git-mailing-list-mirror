Return-Path: <SRS0=R55k=B3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDDCAC433E1
	for <git@archiver.kernel.org>; Mon, 17 Aug 2020 19:40:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C298520716
	for <git@archiver.kernel.org>; Mon, 17 Aug 2020 19:40:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="SH5nQSe5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732130AbgHQTkg (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Aug 2020 15:40:36 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59589 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729747AbgHQTka (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Aug 2020 15:40:30 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 62BB285119;
        Mon, 17 Aug 2020 15:40:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=7Nvl98+YShSZOsKqYaGoj3pJPaY=; b=SH5nQS
        e5Wp4q9oL2pN2K5qMhWyreCY7RQKSh8FVQMyHnT7K1pcgTNZfVYGnQdhXgwCrdo7
        rDDfqfZNvl0rVQjQeECgNEbNuDm2hsCvBSyMk73yduzTikDN1tJpmnm3TekojQzF
        H7ndg5TbAofY6Td8GQEBPdUILj/lXzncOXAaA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=FSP2O4Qt0MJCKsbLJJGDtGKXoB7oxMQ+
        deHs29YDeoFtB01Z8irHXmnlG31rxzxEmrRYQGRv2xf6UCj7jCZBGoIZ4qtWQZoa
        EskMO5m3qBKkpEvCYh0kTPDvlUXdo2fv4XjWBdcIdyjB4mqlqml7Y7Dt1wDv44br
        xJKB9czuceg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 494A985118;
        Mon, 17 Aug 2020 15:40:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.190.152.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id BB01A85117;
        Mon, 17 Aug 2020 15:40:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: Re: [PATCH 0/4] Handle FETCH_HEAD generically
References: <pull.705.git.1597678796.gitgitgadget@gmail.com>
Date:   Mon, 17 Aug 2020 12:40:26 -0700
In-Reply-To: <pull.705.git.1597678796.gitgitgadget@gmail.com> (Han-Wen
        Nienhuys via GitGitGadget's message of "Mon, 17 Aug 2020 15:39:52
        +0000")
Message-ID: <xmqqd03p12ol.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 808666E0-E0C1-11EA-9151-2F5D23BA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com> writes:

> This moves the FETCH_HEAD handling into refs.c as discussed in 
> https://public-inbox.org/git/xmqq5z9pav01.fsf@gitster.c.googlers.com/
>
> Han-Wen Nienhuys (4):
>   Split off reading loose ref data in separate function
>   refs: fix comment about submodule ref_stores
>   refs: move gitdir into base ref_store
>   refs: read FETCH_HEAD generically
>
>  refs.c                | 27 +++++++++++++++++++++++-
>  refs/files-backend.c  | 49 ++++++++++++++++++++++---------------------
>  refs/packed-backend.c |  1 +
>  refs/refs-internal.h  | 11 +++++++++-
>  4 files changed, 62 insertions(+), 26 deletions(-)

Nice.  Quite cleanly done.

Will queue; thanks.

