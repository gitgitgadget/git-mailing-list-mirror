Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 52DAB1F404
	for <e@80x24.org>; Wed, 10 Jan 2018 21:38:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752567AbeAJViy (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Jan 2018 16:38:54 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58999 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751996AbeAJVix (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Jan 2018 16:38:53 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0BCD8B83F8;
        Wed, 10 Jan 2018 16:38:53 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=gGhBAY9lF8oa
        p8qeeliV8R5MPyI=; b=TBjQwfKcSz3LiS4sGN3Nd5q5YRXv+GCpheZ9ueNTKsOr
        l2aGj5Hxq4Gam/YJTRlM7/+F8n0sxmlTXBdOp6eBFZnLjvrosMuTiGS2UFXNQZYs
        7BWBZ2VJpDkdN1OUDEG5t0wdAg8kzfKgRdBj/qdzlzdfwewOW47iXMzhkQCMyrg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=m5RkoL
        rm0vKOYZfZDICeA+f9mX1eJVD8zMjOyQVlR4QCx5gkeoC4n5PsEk/KlhNv15Zyz3
        16HUH+Y9Bw9qam51kFSsk7/+XJOyT0Xrbp/DohPG4GsKgjAm9a3+INu0ZISRj+eE
        tJpBGeHhBbepxzOwX6v4wC7z4Igb/43TwfdWY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0163DB83F7;
        Wed, 10 Jan 2018 16:38:53 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7158AB83F5;
        Wed, 10 Jan 2018 16:38:52 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, "H . Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH 1/2] cat-file doc: document that -e will return some output
References: <20180110125554.12582-1-avarab@gmail.com>
        <20180110125554.12582-2-avarab@gmail.com>
Date:   Wed, 10 Jan 2018 13:38:51 -0800
In-Reply-To: <20180110125554.12582-2-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Wed, 10 Jan 2018 12:55:53 +0000")
Message-ID: <xmqqtvvtz95g.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: A6D2A04E-F64E-11E7-809A-8EF31968708C-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> The -e option added in 7950571ad7 ("A few more options for
> git-cat-file", 2005-12-03) has always errored out with message on
> stderr saying that the provided object is malformed, currently:
>
>     $ git cat-file -e malformed; echo $?
>     fatal: Not a valid object name malformed
>     128
>
> A careful reader of this documentation would be mislead into thinking
> the could write:
>
>     if ! git cat-file -e "$object" [...]

It is arguable if such a reader is careful or careless.  I'd rather drop
s/careful // there ;-)

> As opposed to:
>
>     if ! git cat-file -e "$object" 2>/dev/null [...]
>
> To check whether some arbitrary $object string was both valid, and
> pointed to an object that exists.
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
> ---
>  Documentation/git-cat-file.txt | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
