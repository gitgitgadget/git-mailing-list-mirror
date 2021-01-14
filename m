Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	PLING_QUERY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21CFAC43333
	for <git@archiver.kernel.org>; Thu, 14 Jan 2021 20:33:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8C3B23A5E
	for <git@archiver.kernel.org>; Thu, 14 Jan 2021 20:33:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728848AbhANUdV (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Jan 2021 15:33:21 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59189 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726915AbhANUdV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Jan 2021 15:33:21 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1BDA3AF7B9;
        Thu, 14 Jan 2021 15:32:39 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=HoQQoMegRYCpKDhFuO18+KVDPzg=; b=Lx3H1Z
        in7v3xpOjgRkcBaMjxkW9UQ+cI7NPMfCQUxDgALtocmjcG8D6J5FVgaJtVBD2tDO
        6V79Msvxm+96ZzfcHDc2ADDLUuYZpbOUwz1rHCaoFjANGNumy44Y49Ox4V6q5sot
        i6uMlmiqd9hFOrsMzjSOxlBlzHKKMtxepxIuc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=sG+dNXpzWxZyRO8x0aeExpRblRMMrgRf
        v3hIGGJkRm5XTkScs3mhSotUY2iGSlFDkWIJGvjfdif7jDUzOp7ZrYM+lSt6GXb7
        J1aCJ4nEJNaFGeuy0OKDGQXQwHxWBgXt9kPvQsi0opZ/Z4RtURUCyklIjVVqYks1
        9rn7yUvcBAk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1301CAF7B7;
        Thu, 14 Jan 2021 15:32:39 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 84603AF7B6;
        Thu, 14 Jan 2021 15:32:38 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     Charvi Mendiratta <charvi077@gmail.com>, git <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: How to implement the "amend!" commit ?
References: <CAPSFM5c2iqBn8_Dih2id7q6RRp0q=vfCSVUHDE5AOXZ8z3Ko9w@mail.gmail.com>
        <CAPSFM5f+cm87N5TO3V+rJvWyrcazybNb_Zu_bJZ+sBH4N4iyow@mail.gmail.com>
        <99b40665-45dd-6c4d-d46a-56c7dbf89568@gmail.com>
Date:   Thu, 14 Jan 2021 12:32:37 -0800
In-Reply-To: <99b40665-45dd-6c4d-d46a-56c7dbf89568@gmail.com> (Phillip Wood's
        message of "Thu, 14 Jan 2021 10:39:50 +0000")
Message-ID: <xmqq7dofxnru.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A49391E6-56A7-11EB-BDF6-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

> This is the only option that is backwards
> compatible. `--fixup=:/<text> ` still works and can be used with the
> new syntax as `--fixup=amend::/<text>`.

Do you mean both "--fixup=:/<text>" and "--fixup=amend::/<text>"
work and do the same thing?  If so, that is good.

> Note that we intend to allow
> accept any prefix of "amend" and "reword" so --fixup=a:<commit> would
> work.

"a" and "r" may happen to be unique but we would not want to be
limited to these two forever---future developers are allowed to
invent other clever variants.  So let's say "accept unique prefix as
abbreviation for these operating mode words like 'amend' and 'reword'"

