Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8C54F1F404
	for <e@80x24.org>; Tue, 23 Jan 2018 18:31:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752157AbeAWSa6 (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Jan 2018 13:30:58 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:65244 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751721AbeAWSa4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Jan 2018 13:30:56 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2A404B7246;
        Tue, 23 Jan 2018 13:30:56 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=BU/Kv9fQWuJQ
        RlQVIsEglVywumo=; b=RZiOXdrSBxT/W2jXuKJXU4vsO+pjucWeRshCWSNXmA4U
        1OxvuV2tgg9QYNlEqnIiNvWOCm1O7KbhNmsLxaq6I8+bi0V9ePk+fI6a3kSNUFi9
        RwhyliO6l/6OGHhGwSBKsObBQDqav8v4CgO/gt7CiCoI++mdFhUWnkB1Fjiot+I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=G3Ft53
        JJY7AujUJgDy8ZRzvR+rPRu6h4DwE2Ng9HwaknbD7t5rfzbIE/hjQ2K26SqQkqsZ
        mE5HtJf+7ycaY7Mx9rkd3m+WhrkSgAWrbqqtJMfaRdK8STHg7YUWAlBWFFAVKOG6
        2g0gTzs9SKzjnLZqDZNvH2MBD9UEP3XWGi5WQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 22E8AB7245;
        Tue, 23 Jan 2018 13:30:56 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 97A89B7242;
        Tue, 23 Jan 2018 13:30:55 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Lucas Werkmeister <mail@lucaswerkmeister.de>, git@vger.kernel.org
Subject: Re: [PATCH] daemon: add --no-syslog to undo implicit --syslog
References: <20180122232304.4863-1-mail@lucaswerkmeister.de>
        <87shaxh2b9.fsf@evledraar.gmail.com>
Date:   Tue, 23 Jan 2018 10:30:54 -0800
In-Reply-To: <87shaxh2b9.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Tue, 23 Jan 2018 01:00:10 +0100")
Message-ID: <xmqqh8rcig0x.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 8CABD40C-006B-11E8-87F2-575F0C78B957-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Mon, Jan 22 2018, Lucas Werkmeister jotted:
>
>> Several options imply --syslog, without there being a way to disable i=
t
>> again. This commit adds that option.
>
> Just two options imply --syslog, --detach & --inetd, unless I've missed
> something, anyway 2 !=3D several, so maybe just say "The --detach and
> --inetd options imply --syslog ...".

Correct. Moreover, --detach completely dissociates the process from
the original set of standard file descriptors by first closing them
and then connecting it to "/dev/null", so it will be nonsense to use
this new option with it.
