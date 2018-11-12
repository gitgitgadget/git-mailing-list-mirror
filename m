Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EC0CF1F87F
	for <e@80x24.org>; Mon, 12 Nov 2018 13:02:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729480AbeKLWzg (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Nov 2018 17:55:36 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55453 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729173AbeKLWzg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Nov 2018 17:55:36 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 47B651069BF;
        Mon, 12 Nov 2018 08:02:23 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=a/UjhSjO8Vr+
        OCiFsJuMQFFaD3c=; b=oifMkjLnDfhNAeaq7BlVDX1Bt7lVd/D0/mvH9BqUJFYP
        ihcU0LD9CELJXcRnJyBqaylqlLhT03nQZZJn/ObGj2zUCYYSQlqQUDv9rIqSH6Eh
        0CfN9HSdNhfe4c4LMF2ycE0nU6jFMsKiVcdvtXtYVj3bzVmXQnBKq+icFWeH/cQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=dZGxR1
        YLc/ADQJhZ3UqEwX9DZko2p4c5qZc59/aX/3Ya77jZ7vyklXcMLOYdtfCQpBznbD
        cUjewiOcXUUQ2I7P2LCnA308RvwQJoGsZ605LpUOnh4NcfGI+nvEbh2fp9BLtVkF
        Wqz0JbeKpQbHgaTbbk0iVa0i9HGWL+3o/7Z3c=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3DF861069BD;
        Mon, 12 Nov 2018 08:02:23 -0500 (EST)
Received: from pobox.com (unknown [104.155.68.112])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 96A541069BC;
        Mon, 12 Nov 2018 08:02:22 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Matthieu Moy <git@matthieu-moy.fr>,
        Per Lundberg <per.lundberg@hibox.tv>,
        Duy Nguyen <pclouds@gmail.com>,
        Git Mailing List <git@vger.kernel.org>, jost@tcs.ifi.lmu.de,
        Joshua Jensen <jjensen@workspacewhiz.com>,
        Clemens Buchacher <drizzd@gmx.net>,
        "Holger Hellmuth \(IKS\)" <hellmuth@ira.uka.de>,
        Kevin Ballard <kevin@sb.org>
Subject: Re: [RFC PATCH] Introduce "precious" file concept
References: <875zxa6xzp.fsf@evledraar.gmail.com>
        <20181111095254.30473-1-pclouds@gmail.com>
        <871s7r4wuv.fsf@evledraar.gmail.com>
        <CACsJy8CYpuc7-CZhk7kQQVQFxOfLFZu4TVpG=b0a7j8P1J394Q@mail.gmail.com>
        <591ab1f7-ef39-13e5-83b8-76fe372ecc2c@hibox.tv>
        <1205132135.1189562.1542013731020.JavaMail.zimbra@matthieu-moy.fr>
        <87o9au39s7.fsf@evledraar.gmail.com>
        <xmqqk1li1thy.fsf@gitster-ct.c.googlers.com>
        <87in1231o2.fsf@evledraar.gmail.com>
Date:   Mon, 12 Nov 2018 22:02:21 +0900
In-Reply-To: <87in1231o2.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Mon, 12 Nov 2018 13:45:01 +0100")
Message-ID: <xmqqbm6u1maq.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 31D71F04-E67B-11E8-A636-BFB3E64BB12D-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

>> Or only selected "*.o" (vendor supplied binary blob) kept tracked
>> while everything else is built from the source.
>> ...
> But it also does get used for "mostly we don't want this file, but
> sometimes we do" use-case, so that's something we need to deal with in
> practice.

Exactly.  "Mostly we don't want *.o as we prefer to build from the
source, but we have only object files for some selected ones" is an
often cited use case where it is the BCP to have *.o in .gitignore
and use "add -f" to add the "selected" ones initially.

