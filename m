Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5A8541F462
	for <e@80x24.org>; Wed, 24 Jul 2019 16:24:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728326AbfGXQYd (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Jul 2019 12:24:33 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59184 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726871AbfGXQYc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Jul 2019 12:24:32 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 388121534BA;
        Wed, 24 Jul 2019 12:24:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=w2pHIBv4B1BU
        fl05QdkfxRw8j0Y=; b=BX4e3WRyoUR6mFoWIMNy/7+8nTavhReSXbE1U7YC+L9E
        opI8brp8XWv8UbfWQDE06+dgaumaYZaVOqnS/SeVaJIrP+oIMzCZTCGEpEcbPbBv
        MMM8SQmTJT2NnrnqZHjSn6rKjuySNBmpv1xPajYZksJAeQn3ApQnp5lXsfSEuE0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=P/lP5t
        x+raPym4h82+wDB6RJdxbBYQQILHsuVGbACCb6W6wF7GU9cnaJfsO0iDRsmqF8UV
        Tn+sqn88+Maw8I9wRk6OPS0NDkqD+nACTaBYg8Bw/vdyORZ7vQfIK81//9zGE4sv
        naaxKmiw3AA/L95qwwGrCbvCaukoX25ih0PeQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 31A5D1534B9;
        Wed, 24 Jul 2019 12:24:30 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8DB1C1534B8;
        Wed, 24 Jul 2019 12:24:29 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org,
        Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= 
        <carenas@gmail.com>, Beat Bolli <dev+git@drbeat.li>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/3] grep: stop "using" a custom JIT stack with PCRE v2
References: <20190721194052.15440-1-carenas@gmail.com>
        <20190724151415.3698-3-avarab@gmail.com>
Date:   Wed, 24 Jul 2019 09:24:28 -0700
In-Reply-To: <20190724151415.3698-3-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Wed, 24 Jul 2019 17:14:14 +0200")
Message-ID: <xmqqwog7qu2r.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 82FFC45E-AE2F-11E9-BA05-72EEE64BB12D-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Since we've haven't had any reports of users running into
> PCRE2_ERROR_JIT_STACKLIMIT in the wild I think we can safely assume
> that we can just use the library defaults instead and drop this
> code.

Does everybody use pcre2 with JIT with Git these days, or only those
who want to live near the bleeding edge?

> This won't change with the wider use of PCRE v2 in
> ed0479ce3d ("Merge branch 'ab/no-kwset' into next", 2019-07-15), a
> fixed string search is not a "large or complicated pattern".

In any case, if we were not "using" the custom stack anyway for v2,
this change does not hurt anybody, possibly other than those who
will learn about pcre2 support by reading this message and experiments
with larger patterns.  And it should be simple to wire it back if it
becomes necessary later.

Thanks for cleaning up.
