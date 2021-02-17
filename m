Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3494CC433DB
	for <git@archiver.kernel.org>; Wed, 17 Feb 2021 02:04:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E2E5464E76
	for <git@archiver.kernel.org>; Wed, 17 Feb 2021 02:04:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230235AbhBQCDv (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Feb 2021 21:03:51 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51410 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230221AbhBQCDv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Feb 2021 21:03:51 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D9645A017E;
        Tue, 16 Feb 2021 21:03:07 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=EX60CRpL22H+W9Cd1JELhVyk1WM=; b=FgLYwi
        ehzw8IcbXZdot9lDdYep0u3tHozDqSmthXqva9HmUHMUg4eQdAmOkJahIoWCtP7O
        TD6X4+YGaWBgVd7lz8puxr9HzuPYZ52Vv+mYXelDMKTaVtou/AezHAyHy/B4Crk+
        yncVdFk+EPaJ7ORdgysQ05ZB6Yo9e1Wfbe8Qk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=aq2ylaG4L+sHEyRUAgY6y5xEn8CQqEQt
        2Z0m5RF/lHDfkVSrtz9hXQV4GPhtTiPTMHa7Q0HdCfdl07pPwVs5EKa/HvK8iSSS
        5gEgFe7wUGtI3WwdPP+zaD3IN8E1UV6MU3TZC9S91tC+1GisVUJwGWiPb8jVfhYD
        PfHJjWuYJ9Y=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D1A38A017D;
        Tue, 16 Feb 2021 21:03:07 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 621D6A0175;
        Tue, 16 Feb 2021 21:03:07 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org,
        Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Adam Spiers <git@adamspiers.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Chris Torek <chris.torek@gmail.com>
Subject: Re: [PATCH v2 09/27] userdiff tests: match full hunk headers
References: <20210215005236.11313-1-avarab@gmail.com>
        <20210215154427.32693-10-avarab@gmail.com>
        <4bd7bb84-3b75-258e-b488-f66dff6ba6b5@kdbg.org>
        <xmqqsg5vrhha.fsf@gitster.c.googlers.com>
Date:   Tue, 16 Feb 2021 18:03:06 -0800
In-Reply-To: <xmqqsg5vrhha.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Tue, 16 Feb 2021 10:32:33 -0800")
Message-ID: <xmqqim6rmox1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 47218E46-70C4-11EB-87B9-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> +		sed -ne "s/^@@[^@]*@@//p" actual |
> +		if test -n "$HEAD"
> +		then
> +			grep -F "$HEAD"

I think this should also use "-x" (match the whole line) if it is
portable enough; the option should be available in POSIX.1 but we
haven't used it anywhere in our test suite.

> +		else
> +			grep "^.*RIGHT"
> +		fi
> +	'
>  done
