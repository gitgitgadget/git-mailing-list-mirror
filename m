Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0E33A208D0
	for <e@80x24.org>; Mon, 21 Aug 2017 00:20:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753427AbdHUAUx (ORCPT <rfc822;e@80x24.org>);
        Sun, 20 Aug 2017 20:20:53 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53144 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753408AbdHUAUw (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Aug 2017 20:20:52 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E7654A9D78;
        Sun, 20 Aug 2017 20:20:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=YXSCgk6RO2fc4QTLA4vNXF/7HuU=; b=JuUQ8l
        zFDh2pvZP+ixDO4rz8rC2gqVzXbTpd+YTsPH6hA5iFuwCthEIrv4SkKP5Bje0J/J
        O5X0c5xOiFHzkhB4+9A0MdpGS+KHGaTe4rkMJJNmHPUZ/Elikhh2F2cAB+TOb/or
        6QLeeCIf4UBfHEVtZ0hgW3eU/nysbm8emlkGQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=YYwQijzwVgdkZamUqmqJrQIZSJnFSbyg
        wVJqmd+/kRVtHhqrisuEY1X0g6xN9ZrPx/2YMZncf56P+CIa7ZxDhSfS3WDyfEpK
        Y+OsXare0Y90h960z8MVvA62wGfFd1lawplpGGTowDLb1qTxIkVZm/dT+ENSNg0P
        PxKncOH7nZE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DE6C7A9D77;
        Sun, 20 Aug 2017 20:20:51 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 55D3BA9D76;
        Sun, 20 Aug 2017 20:20:51 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     git@vger.kernel.org, Uwe Hausbrand <uwe.hausbrand@gmx.de>
Subject: Re: [PATCH 2/2] rerere: allow approxidate in gc.rerereResolved/gc.rerereUnresolved
References: <xmqqfudpj1vo.fsf@gitster.mtv.corp.google.com>
        <20170819203013.3053-1-gitster@pobox.com>
        <20170819203013.3053-3-gitster@pobox.com>
        <d1ce349c-a6ca-796d-7ac1-8c720e48e02f@ramsayjones.plus.com>
Date:   Sun, 20 Aug 2017 17:20:50 -0700
In-Reply-To: <d1ce349c-a6ca-796d-7ac1-8c720e48e02f@ramsayjones.plus.com>
        (Ramsay Jones's message of "Sun, 20 Aug 2017 22:45:20 +0100")
Message-ID: <xmqqa82t7ov1.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 96A8E36C-8606-11E7-ACFD-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ramsay Jones <ramsay@ramsayjones.plus.com> writes:

> On 19/08/17 21:30, Junio C Hamano wrote:
>
>> In the future, we may find other variables that only allow an
>> integer that specifies "this many days" (or other unit of time) and
>> allow them to also do the same, and at that point we probably would
>> want to move the helper to a place that is not specific to the
>> rerere machinery.  Perhaps config.c would be such a good neutral
>> place, as it will allow git_parse_signed() to go back to static to
>> the file.
>
> You make git_parse_unsigned() external in this patch, in addition
> to git_parse_signed(), but don't actually call it. Was that intended?

Yes, it was done on purpose for symmetry and was done before I had
that "perhaps this can be moved to config.c" vision.

Perhaps I should follow up the topic with [PATCH 3/2] to really move
it to config.c to clean it up.  But not today.

Thanks.
