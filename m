Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EEC5C433E9
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 18:00:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 596A264F20
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 18:00:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232889AbhCQR7a (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Mar 2021 13:59:30 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:60981 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232803AbhCQR7L (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Mar 2021 13:59:11 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 77A101346D2;
        Wed, 17 Mar 2021 13:59:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=V3IVbPUmSEuCN2lkvUEpgkhMyRk=; b=f8CtWF
        uEGE44FmiEBAn5POIKWXYckus3qRCztDFe3JGN5qQGwSHM7MMGEZVs2JinygcrLi
        MVqt4njFpAZ3KK98HoVdGp3qehH8q7p9BbpEbD4dXgXUEOoXGHQNZPKAYxOQ3I7P
        uHo9gtayQQQwOPJ0uNs/oQRvmYR3vRqRGHYfk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=HWaJVTU5arY3SIY7X9Lsdl7gui0ZYq1L
        cntAALHYQy1kwkk/W5J9gxmdM9WZyGpDoenMwHijCqYDAjFtNtNo9eaiu/vSccEQ
        OtNRZFQxy5oMZ2LWlQPKDOGb9L3RH3VX+6+uan2XLYCx6lUTmKGljYTPQ8eDlrjX
        l9dokVyuQHA=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 6FE781346D1;
        Wed, 17 Mar 2021 13:59:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id B81D41346D0;
        Wed, 17 Mar 2021 13:59:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 5/7] Makefile: add 'check-sort' target
References: <cover.1615856156.git.liu.denton@gmail.com>
        <5088e93d76e44de9d079b7b2296b8c810828a2f5.1615856156.git.liu.denton@gmail.com>
Date:   Wed, 17 Mar 2021 10:59:07 -0700
In-Reply-To: <5088e93d76e44de9d079b7b2296b8c810828a2f5.1615856156.git.liu.denton@gmail.com>
        (Denton Liu's message of "Mon, 15 Mar 2021 17:56:24 -0700")
Message-ID: <xmqq5z1py844.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 78B9DA66-874A-11EB-AEFA-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

> +	./check-sort.perl 'int cmd_[^(]*\(' <builtin.h
> +	./check-sort.perl 'int cmd__[^(]*\(' <t/helper/test-tool.h

These two are trivial to see.

> +	./check-sort.perl '\t\{ "[^"]*",' <git.c

This is too brittle to be acceptable.  It FORBIDS us from
introducing initialization for another table to the file.

I won't participate in the bikeshedding of how the Perl script would
be best written ;-)
