Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CA99F1FADF
	for <e@80x24.org>; Mon,  8 Jan 2018 21:54:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756388AbeAHVyh (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 Jan 2018 16:54:37 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51545 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756193AbeAHVyg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Jan 2018 16:54:36 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 13E39B7EA2;
        Mon,  8 Jan 2018 16:54:36 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=SsyFCZEw1lZl
        69z95ZKLfToOIIA=; b=S2TcrXCyf4o0tNiJ8pHix/Akmu3FxSBX05msZevmCSKO
        RDCvw8mbY0FED3MUoNdwtIInYsR+4W1ubgfFTD4c/n1vdb+yupiSVH4g4JjmZQuE
        Fi6h++6h2vOadHipMqFry44us5XXzsl33aAcJRy5/qMWDNkcYLilqmNbmIGoGgc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=Kf8G0c
        PNevqoepy6QRp4vS/uBrhTZUHGkzwUA545q2/txJZlNJcrWT9qGG168rEeIEgQ+t
        BUwORVMPqgBDvXMTBcwlzNiVjHG9eoiUTGGJ0qywhPpUuXLgClb9jowU2TPJ6Yct
        v+cgN9NOJdKSkvqYajf7EApgmqgeDiXqh//3M=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0AA3BB7EA1;
        Mon,  8 Jan 2018 16:54:36 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7CC90B7E9E;
        Mon,  8 Jan 2018 16:54:35 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Dan Jacques <dnj@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     avarab@gmail.com, git@vger.kernel.org
Subject: Re: [PATCH v5 2/3] Makefile: add Perl runtime prefix support
References: <87inccbscj.fsf@evledraar.gmail.com>
        <20180108191812.52565-1-dnj@google.com>
        <nycvar.QRO.7.76.6.1801082125210.31@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
Date:   Mon, 08 Jan 2018 13:54:34 -0800
In-Reply-To: <nycvar.QRO.7.76.6.1801082125210.31@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
        (Johannes Schindelin's message of "Mon, 8 Jan 2018 21:27:37 +0100
        (STD)")
Message-ID: <xmqqzi5o6mp1.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 84189B6C-F4BE-11E7-BB1A-8EF31968708C-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Mon, 8 Jan 2018, Dan Jacques wrote:
>
>> On Mon, 08 Jan 2018, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason replied:
>>=20
>> >>+# it. This is intentionally separate from RUNTIME_PREFIX so that
>> >>notably Windows +# can hard-code Perl library paths while still
>> >>enabling RUNTIME_PREFIX +# resolution.
>> >
>> > Maybe we covered this in previous submissions, but refresh my memory=
,
>> > why is the *_PERL define still needed? Reading this explanation
>> > doesn't make sense to me, but I'm probably missing something.
>> >
>> > If we have a system where we have some perl library paths on the
>> > system we want to use, then they'll still be in @INC after our 'use
>> > lib'-ing, so we'll find libraries there.
>> >
>> > The only reason I can think of for doing this for C and not for Perl
>> > would be if you for some reason want to have a git in /tmp/git but
>> > then use a different version of the Git.pm from some system install,
>> > but I can't imagine why.
>>=20
>> The reason is entirely due to the way Git-for-Windows is structured. I=
n
>> Git-for-Windows, Git binaries are run directly from Windows, meaning
>> that they require RUNTIME_PREFIX resolution. However, Perl scripts are
>> run from a MinGW universe, within which filesystem paths are fixed.
>> Therefore, Windows Perl scripts don't require a runtime prefix
>> resolution.
>
> As I mentioned in the mail I just finished and sent (I started it hours
> ago, but then got busy with other things while the builds were running)=
: I
> am totally cool with changing this on Windows, too. Should simplify
> things, right?

Wonderful to see that you two are in agreement.  Will look forward
to see a simplified solution in a later round ;-)

