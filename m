Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D34AB1F406
	for <e@80x24.org>; Wed,  3 Jan 2018 19:15:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751235AbeACTPJ (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Jan 2018 14:15:09 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54276 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751204AbeACTPG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Jan 2018 14:15:06 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id EC0D4CE65F;
        Wed,  3 Jan 2018 14:15:04 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=lK+l438cnPO4
        Epl4g+Mm6hAshuY=; b=CF+axl0sGgKrV06sGg8+Uc7OH1sE9G8nSTqmVjstjGXi
        T+twlyJb4DALcbSTLjPjEP3z1E1zu6zDFSOwxBoYLi70lo9+MIJz5sFddhHqp7Uc
        S3E81AoYiPsTsnL2dqrlULh/j/+65qpJ1gGmGY8a4Mq9fO6wvMiqxhTd58LYKJU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=B2YdrB
        SN7p76yZ35TwtM3UXNxbcAAgMlquZoAmZhltp3hwou1lY9zrJ4QeEDMA/OIMEV29
        5dkZ5TEOq5Rt9BWXQ6A6eoyuNs67YPec8PfrTNTI9npfkK4muAf0BEKzfbFdMP4j
        ASP1QQ5D14pZ5gE34oyMgtl3z8LhUT3p/4XBg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E1A12CE65E;
        Wed,  3 Jan 2018 14:15:04 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 79656CE65D;
        Wed,  3 Jan 2018 14:15:03 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Cc:     Lars Schneider <larsxschneider@gmail.com>,
        Lars Schneider <lars.schneider@autodesk.com>,
        Git List <git@vger.kernel.org>, peff@peff.net,
        patrick@luehne.de
Subject: Re: [PATCH v1] convert: add support for 'encoding' attribute
References: <20171211155023.1405-1-lars.schneider@autodesk.com>
        <20171217171404.GA18175@tor.lan>
        <BF5C58AC-C1E6-4AD5-A4F8-C4CC5C9108F7@gmail.com>
        <20171229125954.GA9772@tor.lan>
Date:   Wed, 03 Jan 2018 11:15:01 -0800
In-Reply-To: <20171229125954.GA9772@tor.lan> ("Torsten =?utf-8?Q?B=C3=B6ge?=
 =?utf-8?Q?rshausen=22's?= message
        of "Fri, 29 Dec 2017 13:59:54 +0100")
Message-ID: <xmqq7esyiwju.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 66AF0848-F0BA-11E7-8F81-8EF31968708C-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

> May be.
> Originally utf8.c was about encoding and all kind of UTF-8 related stuf=
f.
> Especially it didn't know anything about strbuf.
> I don't know why strbuf.h and other functions had been added here,
>
> I once moved them into strbuf.c without any problems, but never send ou=
t
> a patch, because of possible merge conflicts in ongoing patches.
>
> In any case, if it is about strbuf, I would try to put it into strbuf.c

Please don't.

A code that happens to use strbuf as a container and about
manipulating the contents is quite different from a code about
strbuf.  The latter is to enhance and extend how the strbuf as a
container behaves.  An operation about character encoding for a
string that happens to be stored in strbuf is more about the
encoding, and much much less about strbuf.

convert.c is about massaging contents coming from the outside world
into a shape stored in Git and the other way around, and there are
multiple ways the contents are massaged.  EOL convention may be
adjusted, characters may be reencoded, end-user defined conversion
may be applied.  Some of these operations may use helpers specific
for the task from other more library-ish files, like checking if a
string looks like encoded in UTF-8 from utf8.[ch].

