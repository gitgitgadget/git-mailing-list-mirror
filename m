Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28D7AC4338F
	for <git@archiver.kernel.org>; Mon,  2 Aug 2021 17:06:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0841361100
	for <git@archiver.kernel.org>; Mon,  2 Aug 2021 17:06:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbhHBRHH (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Aug 2021 13:07:07 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:51354 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbhHBRHH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Aug 2021 13:07:07 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B088913D805;
        Mon,  2 Aug 2021 13:06:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=WzXWGXw8pjcf
        bGSZsA05tQFI8QExlYa91hsWi0nJ+jU=; b=o8z8UaBa/Pk1+P3bLupjm/Y/7qzB
        Sf7OewstY9oUqP7W/hREPoLdFAL2KEJmVgN2cBLl0WRrHeCghsDdgduCLe4dPrq8
        sMM3ddMUvk3O+fBynC+KXY82OUNLgXNoEUbi0fqB5Y5bF3L+8EQ5LTngxhUsFZVv
        JP6HzbJ6mLlcmAQ=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A8CA813D803;
        Mon,  2 Aug 2021 13:06:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.71.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id EC44A13D802;
        Mon,  2 Aug 2021 13:06:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        heapcrash heapcrash <heapcrash@gmail.com>, git@vger.kernel.org
Subject: Re: Enhancing --show-function and --function-context in default
 configurations
References: <CAM1Tk15N6uK3aU5bY6mWQVX5UdEOraysrRmO+v4TA+P-Wa9_hQ@mail.gmail.com>
        <875ywoqldr.fsf@evledraar.gmail.com>
        <YQgahVPT8g0+U1B3@coredump.intra.peff.net>
Date:   Mon, 02 Aug 2021 10:06:53 -0700
In-Reply-To: <YQgahVPT8g0+U1B3@coredump.intra.peff.net> (Jeff King's message
        of "Mon, 2 Aug 2021 12:17:09 -0400")
Message-ID: <xmqqmtpzwzbm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 09D974B8-F3B4-11EB-AF3E-FA9E2DDBB1FC-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Mon, Aug 02, 2021 at 10:45:25AM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 =
Bjarmason wrote:
>
>> I would like to see us have a setting to turn these on by default, but
>> think it would be better to make that a diff.* config setting to put
>> into ~/.gitconfig, i.e. we'd extend git itself to know about a list of
>> extensions for the given userdiff drivers, and use them when rendering
>> diffs.
>
> A long time ago we discussed doing this. The relevant thread is:
>
>   https://lore.kernel.org/git/20111216110000.GA15676@sigill.intra.peff.=
net/
>
> which references a few others:
>
>   https://lore.kernel.org/git/4E569F10.8060808@panasas.com/
>
>   https://lore.kernel.org/git/4E6E928A.6080003@sunshineco.com/
> ...

Thanks for pointers.

One good suggestion given there was to use diff=3Dc and diff=3Dperl in
our own .gitattributes to use the patterns ourselves, which we seem
to have been doing just fine ;-)

As long as the default built-in ones are

 (1) at least 90% of the time improvement over, or at least is not
     broken compared to, the unconfigured case, and

 (2) at the lowest priority that users can easily countermand for
     the rest 10% cases

I do not think it is too bad to resurrect the old patches from these
threads.

Thanks.


