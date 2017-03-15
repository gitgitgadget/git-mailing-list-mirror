Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6297C202C1
	for <e@80x24.org>; Wed, 15 Mar 2017 15:59:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753893AbdCOP6y (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Mar 2017 11:58:54 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61550 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753175AbdCOP6T (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Mar 2017 11:58:19 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 621CC76908;
        Wed, 15 Mar 2017 11:57:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=bEQo5Bbai6qM29XWmZpj82RaTZc=; b=f7JkP2
        toqJFfG1yeCN7r7OLbsjZlftfgDYmKVHFSvlfOpMZOQ3/mMT43wgLqGgIElCEPKO
        DcKzo88Yo/VDN9SxkdPeHNBl3gBRd/KQHPEUY/sYcjdPrr7yuIiwS5TvPA4mV5kF
        Fl8OYymp0H7j7EvZwsHo/FJbd0vKyR/9Nbouc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=eYzpbDFob+mh7FGFkemhmvZO4eC7q7e7
        24BelfjYR8X68HkjRamnfwqBSgu7SHyZ5G4L1+V91XbXfODQbwQVLTtFmQw2oWC1
        RMtBDghoun0g4bBVGDbLm3+lplft1VG8+F3E82BFuxEBUDX/Tc3PWFm6EdPsm2p1
        GA8AgEn2N80=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5B6ED76907;
        Wed, 15 Mar 2017 11:57:38 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id BEAEA76906;
        Wed, 15 Mar 2017 11:57:37 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
Subject: Re: [RFC PATCH] Move SHA-1 implementation selection into a header file
References: <20170311222818.518541-1-sandals@crustytoothpaste.net>
        <20170314184126.GJ26789@aiede.mtv.corp.google.com>
        <20170314201424.vccij5z2ortq4a4o@sigill.intra.peff.net>
        <xmqq1stzio5b.fsf@gitster.mtv.corp.google.com>
        <1fce97df-7eb8-79d5-b96b-2086746bf19d@ramsayjones.plus.com>
        <20170314234659.wamzgpqu2aikghci@genre.crustytoothpaste.net>
        <dd285cb9-c7c7-e945-1fa2-7eb58d83ea06@ramsayjones.plus.com>
Date:   Wed, 15 Mar 2017 08:57:36 -0700
In-Reply-To: <dd285cb9-c7c7-e945-1fa2-7eb58d83ea06@ramsayjones.plus.com>
        (Ramsay Jones's message of "Wed, 15 Mar 2017 00:15:39 +0000")
Message-ID: <xmqqvarafs7j.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1CA84D4A-0998-11E7-914E-FC50AE2156B6-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ramsay Jones <ramsay@ramsayjones.plus.com> writes:

> On 14/03/17 23:46, brian m. carlson wrote:
>>>>
>>>> Since the SHA1_HEADER include is not defined in such a case, developers
>>>> see spurious errors when using these tools.  Furthermore, while using a
>>>> macro as the argument to #include is permitted by C11, it isn't
>>>> permitted by C89 and C99, and there are known implementations which
>>>> reject it.
>>>
>
>> Junio, do you want to amend the commit message before you merge it?
>
> Yes, please! ;-)

If only you were a few hours quicker.

Let me see how bad the fallout is to revert the merge to 'next' and
merge an amended version in.

I _think_ the whole "Furthermore" sentence can go, since nobody
complained since cef661fc ("Add support for alternate SHA1 library
implementations.", 2005-04-21) started using the Makefile construct.

Thanks.
