Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 626CB1F454
	for <e@80x24.org>; Thu,  7 Nov 2019 05:39:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726457AbfKGFje (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Nov 2019 00:39:34 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:65414 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725770AbfKGFje (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Nov 2019 00:39:34 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 53B228CC83;
        Thu,  7 Nov 2019 00:39:33 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=w3IWvXiy3WOc
        zdYwFFmwToRrAOE=; b=f4jW11gAihLUHwN2Z/gm6/ZdP/fGTD1eMSp1a20i7EHI
        vfXgzEFRQxu/wfhScwmKE6PfuV0vr8vaJ2VjCqcrBRf2quiYN9mhEk+0gcv3I90v
        CWtdZAVwIzBMPBSe/iRA9/GlkOJtuDRtIxmx9sLBHNzPW1qQsaEDsXshP3MGExw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=oV3HCW
        TY28dz9IC1chWEzOL779mbDD8d8Rxzr0IfoLwPo792f2Fv2kDquKtbk8LwqM+BF+
        iRAd4Tl4b9b3XUvTtiab5vvTF4xUdHPeENkIdOBOaMxfPYymCxgZpr7YSS56DxaT
        TK7SZekqB8eg5lNgpE7/IqmDNkncdiJCbVf8c=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4C32D8CC82;
        Thu,  7 Nov 2019 00:39:33 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 745B98CC79;
        Thu,  7 Nov 2019 00:39:30 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: Re: [PATCH v2 1/1] remote-curl: unbreak http.extraHeader with custom allocators
References: <pull.453.git.1572991158.gitgitgadget@gmail.com>
        <pull.453.v2.git.1573034695.gitgitgadget@gmail.com>
        <3168ba2c9eadcf0cd7e4f2533c9306b5d2c627d0.1573034695.git.gitgitgadget@gmail.com>
        <xmqq7e4dtd9n.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1911062031480.46@tvgsbejvaqbjf.bet>
Date:   Thu, 07 Nov 2019 14:39:28 +0900
In-Reply-To: <nycvar.QRO.7.76.6.1911062031480.46@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Wed, 6 Nov 2019 20:34:51 +0100 (CET)")
Message-ID: <xmqq1ruks0rz.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: F851F760-0120-11EA-9D14-8D86F504CC47-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Wed, 6 Nov 2019, Junio C Hamano wrote:
>
>> > presence of custom allocators, cURL would attempt to use the wrong
>> > allocator to release the memory.
>>
>> s/allocator/de&/; perhaps, even though it is clear enough from the
>> context, so it is probably OK as is.
>>
>> > A na=C3=AFve attempt at fixing this would move the call to
>> > `curl_global_init()` _before_ the config is parsed (i.e. before that
>> > call to `slist_append()`).
>> >
>> > However, that does work, as we _also_ parse the config setting
>>
>> s/does work/does not work/; presumably?
>
> Indeed. Could I ask you to fix up locally, or do you want me to send a
> new revision of the patch?

You can certainly tell me to locally tweak, but you'd need to be
more specific when some of my suggestions were "perhaps" (aka "you
could do it this way, which may be better, but I do not care too
deeply---I am OK with whichever you chooose after you (re)think
about it, but I am not choosing for you").

For now, I'll do the "does not work" thing only.

Thanks.
