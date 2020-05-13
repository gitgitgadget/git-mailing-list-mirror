Return-Path: <SRS0=6HsL=63=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55656C433DF
	for <git@archiver.kernel.org>; Wed, 13 May 2020 21:53:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41A8320575
	for <git@archiver.kernel.org>; Wed, 13 May 2020 21:53:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="fWnvGhC6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729769AbgEMVxt (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 May 2020 17:53:49 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:50215 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729487AbgEMVxt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 May 2020 17:53:49 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8EC69C6ED2;
        Wed, 13 May 2020 17:53:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=CBtUfW09Bc3AvUiCV7VzjdMok
        TI=; b=fWnvGhC6z5RIT3ly1bPwKp6Jbjv8hvAsvN2PjRSuKUeEOJ1OXw+v1+e4J
        Tk7+Z8FEyxMCmUhZ1Pi/384btYuQsBP/F5z1+9A8lTt9h3lii/BdegVYP3CFywQS
        AP9sTNlwjweaYy6azknmOiQBEQIXMN6n7KZqS1mYN72xSGgKCY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; q=dns; s=sasl; b=wyWHZQbFZV0pKrxQ2Bc
        yanRAjOvgXtoCQF9CxQ1t60gpRMx8P2H4tKb7W0JQMBXDFZuPwHE/cCbQrJMkPUa
        jW2jLP+yDkxpSxb+rcSXrrqCkMaZIYpFytLzeAooplCa5UBaZ/ADxd4uyQA9eQf2
        iR5bgaYoZSsv/IHL7L2yNby0=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8716CC6ED0;
        Wed, 13 May 2020 17:53:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id CFC1CC6ECE;
        Wed, 13 May 2020 17:53:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>
Cc:     David Moseler <davidmoseler@protonmail.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: git-credential-store does not work with a file
References: <Wc7NKqbl9k45DWha23OG_TvVA4Ftq3sOCiHScVXhmAbCPOaz8pkEqQrPXw_JBC8G7g9CrIKxwfE8pv8Nr9Dcw5J0zA7fNCAi9Mq1OnxhpMg=@protonmail.com>
        <56HlWgfQEg1t99VKZaFZqhdcjAs279HXXP1gQ9YzZGOGcR9jEzSVYgl3flvbTiqSet2HB0gc6jotcDmYbtDipE7k0-QbdrzjgxiKZBnIK_4=@protonmail.com>
        <uBc-Htk5XJFPF28aiZsQUIowfd66Ay2NiCyVbxkWpD77ugn3k4LBLse-jm0Jf4HpAKMWt4chuRAbxskeczZpj_pEnUaX_XOrmhfYksCeVLw=@protonmail.com>
        <20200512112201.GA10049@Carlos-MBP>
Date:   Wed, 13 May 2020 14:53:41 -0700
Message-ID: <xmqq1rnnsdqy.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 364F6890-9564-11EA-BF4B-8D86F504CC47-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Carlo Marcelo Arenas Bel=C3=B3n <carenas@gmail.com> writes:

> On Tue, May 12, 2020 at 12:40:10AM +0000, David Moseler wrote:
>> Hi,
>>=20
>> I'm using git version 2.17.1. Providing a file to git-credential-store=
, such as in
>>=20
>> git config credential.helper store --file=3D'./git-credentials'
>
> your quoting is off, so you are passing to config only the value 'store=
' while
> the rest is ignored.

Actually it is worse than that.  If it were "the rest is ignored",
we can fix it to give an error.  But the problem is, the rest is
*not* ignored.  It is used as an argument with a meaning that the
user did not expect it to have.

The above asks "we want to update the value of credential.helper
variable(s) and set 'store' as its value, but we want to do so only
for the entries whose current value match the regular expression
given as the last argument". =20

It is unlikely that a credential.helper variable defined with the
value "--file=3D./git-credentials", so the command silently succeeds
after replacing 0 entries. =20

The same issue exists with "--replace-all", "--unset" and other
forms of "git config" that take an optional value_regex.

This is now totally offtopic for a thread about credential-store,
but we probably should fix the command line UI for this feature.

Perhaps

 1) Teach all the forms of "git config" that currently takes an
    optional value_regex to accept "--value-regexp=3Dregex" option.
    It will be an error to give both --value-regexp parameter and
    the optional "value_regex" argument.  Wait for several releases.

 2) Update these forms to warn when the current "optional"
    value_regex syntax is used, and tell users to explicitly use the
    "--value-regexp=3Dregex" option.  Wait for several releases.

 3) Remove support for the "optional" value_regex syntax and error
    out when it is used.

over a few years.
