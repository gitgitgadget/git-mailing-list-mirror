Return-Path: <SRS0=mOGp=6L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32634C4CECD
	for <git@archiver.kernel.org>; Mon, 27 Apr 2020 18:09:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE4BF214D8
	for <git@archiver.kernel.org>; Mon, 27 Apr 2020 18:09:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="LZTnyLqk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726230AbgD0SJh (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Apr 2020 14:09:37 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59965 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725963AbgD0SJh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Apr 2020 14:09:37 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9E35C41C69;
        Mon, 27 Apr 2020 14:09:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=BsyaooqttCkb
        YJ/plFYwUKGK2bs=; b=LZTnyLqk1dyzAGNUFMp/jLWefETiUI0ix4E+rvu3nDHP
        npgFwfTjSHTOb6bnqznZsZWsj8QNDm11dwOfLo/Sh27o5hZ5gquD6hpzNhWXdAuE
        LMPSYoFNyxqYyETgODND1Ckh7S+JRMSFXJDH/xiWRlGD5dsCnSSb65Exxo2+T1s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=J/zY1H
        FBbFueEHg1eE/CD5izEXsKhJM9Y+AVKXKjSs4TODs9HG4lre7x0flgGkci8IvTHr
        qsWe4u5Sgbu+4Z/Uh91FN+cR5kq4FOTP53Gtw6H/bpfIAUZLVsRzEZuqEBBeTDMJ
        EuWYjweoDhA44nKRPYFeEM957vK3T6rkjwDFQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9607C41C68;
        Mon, 27 Apr 2020 14:09:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 16A0941C67;
        Mon, 27 Apr 2020 14:09:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>
Cc:     git@vger.kernel.org, dirk@ed4u.de, sunshine@sunshineco.com,
        peff@peff.net
Subject: Re: [PATCH v3] git-credential-store: skip empty lines and comments from store
References: <20200427084235.60798-1-carenas@gmail.com>
        <20200427125915.88667-1-carenas@gmail.com>
Date:   Mon, 27 Apr 2020 11:09:34 -0700
In-Reply-To: <20200427125915.88667-1-carenas@gmail.com> ("Carlo Marcelo
 Arenas
        =?utf-8?Q?Bel=C3=B3n=22's?= message of "Mon, 27 Apr 2020 05:59:15 -0700")
Message-ID: <xmqqftco94wx.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 4036D7D0-88B2-11EA-B095-C28CBED8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Carlo Marcelo Arenas Bel=C3=B3n  <carenas@gmail.com> writes:

> with the added checks for invalid URLs in credentials, any locally

s/with/With/

> modified store files which might have empty lines or even comments
> were reported[1] failing to parse as valid credentials.

These files are not supposed to be viewed or edited without the help
of the credential helpers.  Do these blank lines and comments even
survive when a new credential is approved, or do we just overwrite
and lose them?

I'd rather not to do either, if we did not have to, but if it were
necessary for us to do something, I am OK to ignore empty lines.
But I'd prefer not to mix the new "# comment" feature in, if we did
not have to.

Also, triming the lines that are not empty is unwarranted.  IIUC,
what the "store" action writes encodes whitespaces, so as soon as
you see whitespace on either end, (or anywhere on the line for that
matter), it is a hand-edited cruft in the file.  If you ignore
comments, you probably should ignore those lines, too.

