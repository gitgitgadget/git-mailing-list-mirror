Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6941120281
	for <e@80x24.org>; Tue,  3 Oct 2017 02:25:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751101AbdJCCZr (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Oct 2017 22:25:47 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53309 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750869AbdJCCZr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Oct 2017 22:25:47 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 84EF8B41F6;
        Mon,  2 Oct 2017 22:25:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=a2IUbsvPFRiR593qi4Dy+oBI4xU=; b=ILosCJ
        TvSYa6g2uwpcHlGn1pfAm1GrsMMwT5iybIZkk+JJWJpQqpnRwsVDnFZCLA+x+d00
        5KpiJ3wvv8Odozr/9SONmKqfqNpaZFLeTDSvelTyPLuqDRl0Ai80hJkBeGgKXetN
        pwQavVUgH/tGSQjq2Ky9zigwOsuNT9bjXvLUY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=JT9vgmTeAwdSIlgFg0x0CDbmG///+HB3
        0guU4eI835aHphT/Y19ktMLmST8pSJG60M/xuMkM5JUr39n6qK+jYwDUELhSSoJy
        +yymR9mK6tRDHXiB8gbBWZOifjMkq0eF98qNlruR/qBgnKAsbJ1r8Qps6nQHJ5MU
        de0tTx5HXJE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7DB6AB41F5;
        Mon,  2 Oct 2017 22:25:46 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0276CB41F4;
        Mon,  2 Oct 2017 22:25:45 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Toni Uebernickel <tuebernickel@gmail.com>, git@vger.kernel.org,
        Tsvi Mostovicz <ttmost@gmail.com>, Jeff King <peff@peff.net>
Subject: Re: Updated to v2.14.2 on macOS; git add --patch broken
References: <86D0A377-8AFD-460D-A90E-6327C6934DFC@gmail.com>
        <20171002230017.GT19555@aiede.mtv.corp.google.com>
        <xmqqpoa5kp0c.fsf@gitster.mtv.corp.google.com>
Date:   Tue, 03 Oct 2017 11:25:44 +0900
In-Reply-To: <xmqqpoa5kp0c.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Tue, 03 Oct 2017 10:18:27 +0900")
Message-ID: <xmqqinfxklw7.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2996AC66-A7E2-11E7-8476-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Jonathan Nieder <jrnieder@gmail.com> writes:
>
>> Yet another alternative would be to treat color.ui=always as a
>> deprecated synonym for color.ui=auto.  I think that's my preferred
>> fix.
>
> It is mine, too.  And I do not think color.ui=absolutely-always for
> those who want to keep the current behaviour is unneeded.

Having said that, I do not mind solving what 136c8c8b ("color: check
color.ui in git_default_config()", 2017-07-13) tried to do in a
different way.  If 4c7f1819b that made even plumbing to default to
auto was wrong (because plumbing did not pay attention to color.ui
so people could not override that 'auto' default), we can partially
revert 4c7f1819 ("make color.ui default to 'auto'", 2013-06-10) to
make the default 'auto' not apply to plumbing.

In any case, I think the first step may be to revert 136c8c8b from
both 'master' and 2.14.x.  These alternative solutions can come on
top.

Thoughts?
