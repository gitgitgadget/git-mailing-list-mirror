Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 006A11F6BF
	for <e@80x24.org>; Thu,  1 Sep 2016 20:56:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755429AbcIAUzf (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Sep 2016 16:55:35 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55201 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754519AbcIAUzR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Sep 2016 16:55:17 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 436353761F;
        Thu,  1 Sep 2016 14:15:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=cF7kDYYYc4ldlp5ELrkOwgMTYC0=; b=LR5Xdv
        26mOIwqF6j+zW54exXn9/Ggx5/PgYsPSRMquugy8nzbfy+yV/IOhPZk6nFe/Atpm
        ibtblCOXDbymGMpUfXSYBhXZwBOkXQGX0PtD4jhCHYUWTW0VIFMS30zc5EubBJ5o
        ZRsn++OHwJjW1GjTBl61k91XJkwjgwnH5FU+E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=pcWitKNn8GBld4C2rwJ38z6orM+mvgo9
        kSfzHR0DsICEzA2WSUeWGEfS7ywnI9nkmkd6YE18Nidhy5Qodu1CZ6IZBf/0w4o/
        vXwZEuOlAtipfwW1P+KTpo9km3g8el0n+WgIDZQgQbNc5tXVhAxqvrWgdv3scDdS
        qcVjKTf2aLI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3CA3C3761D;
        Thu,  1 Sep 2016 14:15:47 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id BC35537617;
        Thu,  1 Sep 2016 14:15:46 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Dennis Kaarsemaker <dennis@kaarsemaker.net>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: [PATCH 07/34] sequencer (rebase -i): add support for the 'fixup' and 'squash' commands
References: <cover.1472633606.git.johannes.schindelin@gmx.de>
        <5488a031ffe14373b7434d497b7fd2f2e5fe55bd.1472633606.git.johannes.schindelin@gmx.de>
        <1472718808.4680.19.camel@kaarsemaker.net>
Date:   Thu, 01 Sep 2016 11:15:44 -0700
In-Reply-To: <1472718808.4680.19.camel@kaarsemaker.net> (Dennis Kaarsemaker's
        message of "Thu, 01 Sep 2016 10:33:28 +0200")
Message-ID: <xmqqr393wkof.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1AB15DA4-7070-11E6-AA0F-51057B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dennis Kaarsemaker <dennis@kaarsemaker.net> writes:

>> +static const char *nth_for_number(int n)
>> +{
>> +	int n1 = n % 10, n10 = n % 100;
>> +
>> +	if (n1 == 1 && n10 != 11)
>> +		return "st";
>> +	if (n1 == 2 && n10 != 12)
>> +		return "nd";
>> +	if (n1 == 3 && n10 != 13)
>> +		return "rd";
>> +	return "th";
>> +}
>
>>8---
>
>> +	if (command == TODO_SQUASH) {
>> +		unlink(rebase_path_fixup_msg());
>> +		strbuf_addf(&buf, "\n%c This is the %d%s commit message:\n\n%s",
>> +			comment_line_char,
>> +			count, nth_for_number(count), body);
>> +	}
>> +	else if (command == TODO_FIXUP) {
>> +		strbuf_addf(&buf,
>> +			"\n%c The %d%s commit message will be skipped:\n\n",
>> +			comment_line_char, count, nth_for_number(count));
>> +		strbuf_add_commented_lines(&buf, body, strlen(body));
>> +	}
>
> This way of handling numbers is not translatable, and I really think we
> should mark these strings for translation, like they are in the .sh
> version.

Correct.

For those who were not paying attention on the 'master' front during
this pre-release period [*1*], I have to point out that the scripted
Porcelain has been updated to lose the Anglo-centric st/nd/rd/th and
this series would want to get updated to match.


[Footnote]

*1* Why weren't you?  Repent! ;-)
