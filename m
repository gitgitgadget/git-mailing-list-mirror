Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 11C772036D
	for <e@80x24.org>; Wed, 22 Nov 2017 02:01:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751431AbdKVCBa (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Nov 2017 21:01:30 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63632 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751364AbdKVCB3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Nov 2017 21:01:29 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 91BACBA3D0;
        Tue, 21 Nov 2017 21:01:24 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=bAEZD1PlUdNL
        2MSLe01k1FUQNPU=; b=Kj3nPKX/HwvozpHOAu6o8kCknr9MAXwq8pmtPqOPcCgq
        tgWXQ6eYMDrJNWxBgwHmrWQoggTufBqREipLyHLMYyVFrlztdOtr4io6NJz9OYv2
        EJMDn35PDtKgINp5/A5VVR4TyNmgxf5kiE83JDnPva+wef6u9aF6t8FHsBytTxk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=srKb9A
        VI2RVQkIkl0uI/slin6jLiCj13jgoTjSFBuj54HZmVe8M4xrbr44b0XjXBgRMpF1
        jzc7dc3PU9M03786BM6bjxESDihXAdatz+2r9fcaeToNaIDVahurdtdSAObvzt9j
        PK+Jar/D+mfcVtKidIbsbL1tonQuGAmbWCwIE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 88DF5BA3CF;
        Tue, 21 Nov 2017 21:01:24 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0BB93BA3CE;
        Tue, 21 Nov 2017 21:01:23 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Cc:     Vladimir Nikishkin <lockywolf@gmail.com>, git@vger.kernel.org
Subject: Re: core.safecrlf warning is confusing[improvement suggestion?]
References: <CA+A2iZaLZCMvyb3nbcn=ofVGAPeW2_wRhjOeRRu5q01LuV++Gw@mail.gmail.com>
        <20171121161824.GA13548@tor.lan>
Date:   Wed, 22 Nov 2017 11:01:22 +0900
In-Reply-To: <20171121161824.GA13548@tor.lan> ("Torsten =?utf-8?Q?B=C3=B6g?=
 =?utf-8?Q?ershausen=22's?=
        message of "Tue, 21 Nov 2017 17:18:24 +0100")
Message-ID: <xmqqine3xea5.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 0AD8022A-CF29-11E7-82C0-575F0C78B957-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

>> I want to have LF line endings in the repository and CRLF endings in
>> the working copy. (Because I use windows-exclusive tools to develop.)
>
> Side note: If you ever want to push your repository somewhere,
> it would be good practice to have a .gitattributes file:
> ...

Now we got your attention ;-)

What would be the BCP we would give if somebody has just a tarball
without .git that has LF endings?

    $ git init a-project
    $ cd a-project
    $ tar xf ../a-project.tar
    $ git add .
    $ git commit -m 'Initial import'

would achieve one half of the original wish (i.e. "I want to end up
with repository data in LF eol"); disabling the "safe crlf" before
running that "git add ." step may also not be a bad idea, because it
reduces the number of things that can get in the way by one.

But the above also leaves the "working tree" files in LF eol
(i.e. it goes against "I want to work with CRLF in my working
tree").  What would be our recommendation?

One big-hammer way I can think of is

    $ git rm -f .
    $ git reset --hard

and that actually may be a good enough solution, given that you'd be
doing this just once at the beginning of "your" project that starts
from an inherited code drop.
