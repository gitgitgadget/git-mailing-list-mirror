Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E4CFA20281
	for <e@80x24.org>; Wed,  4 Oct 2017 09:08:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751932AbdJDJIc (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Oct 2017 05:08:32 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53430 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751888AbdJDJIb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Oct 2017 05:08:31 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E4AD198A5F;
        Wed,  4 Oct 2017 05:08:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=U7BGjH/MYB5l7sk0e6Pm9qnG14w=; b=ebp9uR
        RrkibwTtSGwjWhfekSsmvEbm0UJbnItSKM2Tg0pTyCDlqwHVIqgV03vcZjcU34w3
        ll6RpyaIlDtfpzE9EgSN0rROfbqINq6TaI6Y1dqferarloJQTL8iCBtYwoCwDjn9
        a7ZAvZzV/GXkCGqZ1Aes692VGe+ebNQBUEMno=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=wTWQ5X6XOYtzS+xIvtHAtXLM4icIo+/y
        uA39kM2hq22guyCpiyCZTAKjs5cuV+OxTUEENQiO/kz6DGJ6KdO/6IEem5fxaNWr
        ADE3jgvvtggDjV9U5wxZW4MQ/B3EpaGG1gJ1uVwsmLJm2tQRRtxQS0j19056liMy
        UIdmjkm5qi0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DA14D98A5D;
        Wed,  4 Oct 2017 05:08:30 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5F74D98A5C;
        Wed,  4 Oct 2017 05:08:30 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/3] for-each-ref: let upstream/push optionally report the remote name
References: <cover.1506952571.git.johannes.schindelin@gmx.de>
        <0e03bf1e50e24a52f57be0f51d19f4657c68d2fa.1506952571.git.johannes.schindelin@gmx.de>
        <xmqq376zcrls.fsf@gitster.mtv.corp.google.com>
Date:   Wed, 04 Oct 2017 18:08:29 +0900
In-Reply-To: <xmqq376zcrls.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Wed, 04 Oct 2017 16:14:07 +0900")
Message-ID: <xmqq7ewbb7qq.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 97178E52-A8E3-11E7-B111-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>> +	} else if (atom->u.remote_ref.option == RR_REMOTE_NAME) {
>> +		int explicit;
>> +		const char *remote = starts_with(atom->name, "push") ?
>> +			pushremote_for_branch(branch, &explicit) :
>> +			remote_for_branch(branch, &explicit);
>
> I think "int explicit = 0;" is needed, as pushremote_for_branch()
> does seem to expect that the "explicit" return parameter is
> initialized by the caller.

Not really. I misread these helper functions.  pushremote_for_branch()
ends up calling remote_for_branch() which does clear, so we are OK
without caller initializing it.
