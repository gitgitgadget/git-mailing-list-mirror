Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3B73C20193
	for <e@80x24.org>; Thu, 27 Oct 2016 18:49:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935293AbcJ0Stz (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Oct 2016 14:49:55 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53550 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752074AbcJ0Sty (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Oct 2016 14:49:54 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5B93648694;
        Thu, 27 Oct 2016 14:49:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=JZymW/VaCe174MsQwPxEdWolfT8=; b=XaN252
        jSsRAmEfaayyMiISH5dc0pFRGEpHU+usjA5DoSm5bJ1gw0g0UV3DXtM4yDZplX1D
        +mRWnH66tqCNJGnf2KfZWLGbbexe/23LHq/swQt+7UCV/D6kXaB063qP2IfHT/SS
        n6u34NGcid3FH+cZ/OHnsmuN6UThb+/f/fbb8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=qZaMG4jmR4RVE+tQ17j59LTEXULs/nuI
        AtQ2fl/usKHramaKaR/ciTXXQurmTwZUULqoV8AJMwKDux/Fv9qJSqP8RvA8fXHU
        M3VFrRhVIAeF3o/zRXVBpWiNI8lTj1+c9rsjaFxq5OevoaX1YLVZTPuNxK82nqpg
        iR5lkyv6OdE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4E77848693;
        Thu, 27 Oct 2016 14:49:53 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9FD2248691;
        Thu, 27 Oct 2016 14:49:52 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Stefan Beller <sbeller@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        "git\@vger.kernel.org" <git@vger.kernel.org>,
        Simon Ruderich <simon@ruderich.org>, Jeff King <peff@peff.net>
Subject: Re: [PATCH] compat: Allow static initializer for pthreads on Windows
References: <20161026215732.16411-1-sbeller@google.com>
        <93be5d21-6cb6-ee2b-9f4f-c2fe7c690d6c@kdbg.org>
        <xmqqlgxa8h3a.fsf@gitster.mtv.corp.google.com>
        <67e38b43-0264-12f2-cca8-4b718ed7dc9d@kdbg.org>
        <xmqqh97y8g74.fsf@gitster.mtv.corp.google.com>
        <xmqqd1im8foi.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kbP3pgPHgv-x1Q-Q1QwmXc=gOyxWhXh2SngO8WSZc3PFA@mail.gmail.com>
        <34c88c40-2088-fd74-5d26-56c0599b7eb9@kdbg.org>
Date:   Thu, 27 Oct 2016 11:49:50 -0700
In-Reply-To: <34c88c40-2088-fd74-5d26-56c0599b7eb9@kdbg.org> (Johannes Sixt's
        message of "Thu, 27 Oct 2016 20:22:34 +0200")
Message-ID: <xmqqr3716301.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 254E738C-9C76-11E6-8120-987C12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Sixt <j6t@kdbg.org> writes:

> Am 27.10.2016 um 19:01 schrieb Stefan Beller:
> ...
> It is not possible to mark a mutex uninitialized on Windows without an
> extra piece of data. A solution would become quite complicated quite
> quickly, and at the cost of additional operations that are in the same
> ballpark as an uncontended mutex. I'm not enthused.
>
>> The positive aspect of this way the patch proposes would be that any
>> future contributor not knowing the details of how to do mutexes right
>> on Windows, would not totally break the whole system, i.e. this seems
>> to be more maintainable in the future as it reduces the friction between
>> pthreads mutexes and the way we can do things in Git in a platform
>> independent way
>
> This is a non-argument. Coders have to know their tools.

The codebase should strive to give coders a coherent abstraction
that can be implemented efficiently on platforms, so that coders do
not have to care too deeply about quirks that exist on individual
platforms.

It is OK to argue that the particular solution Stefan lifted from
somewhere (perhaps msdn article he cited???) does not qualify as
such an abstraction.  But I do not agree with your "Coders have to
know" as a blanket statement.
