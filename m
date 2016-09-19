Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EE18F2070F
	for <e@80x24.org>; Mon, 19 Sep 2016 21:16:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753075AbcISVQa (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Sep 2016 17:16:30 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51386 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752904AbcISVQ1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Sep 2016 17:16:27 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5632C40AAD;
        Mon, 19 Sep 2016 17:16:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=dOkAYSwEn4IxKO0ettYZmaFjiDs=; b=N3FGCD
        diNHkcvDbpXFhq4NllIo4bTX1jaSupeiyosB22aLToDPZcx4RkP7Jd7YNZ1KuUl8
        yEEa5UH+k/dzqrz6h64L/3DFEsz9/WP4u7eFPDqq8emQrNUXuOsSFsONB+My67AP
        kUD0ID/UjQN2WPUjP867Lm542RH/TbYEKM9PA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=G1IkMM7So8UvJuWSypgzuub8vMFu28xk
        QzpDNz//FAxjtmNHiLC2JpUXulvtdqC3oj2FPx9cDL9xMZhas34vYbYjJ7UfaHVm
        tAY6QAcPRVDpoY9SaGndrsgZ9TIdFypMcpNmf26GPyYsfjAYSg2SpN4WHO0r4qLN
        FUzm/+uTr3Y=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4D84340AAB;
        Mon, 19 Sep 2016 17:16:26 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id BC48C40AAA;
        Mon, 19 Sep 2016 17:16:25 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kevin Daudt <me@ikke.info>
Cc:     git@vger.kernel.org, Swift Geek <swiftgeek@gmail.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 1/2] t5100-mailinfo: replace common path prefix with variable
References: <20160919185440.18234-1-me@ikke.info>
        <20160916210204.31282-1-me@ikke.info>
        <20160919185440.18234-2-me@ikke.info>
Date:   Mon, 19 Sep 2016 14:16:23 -0700
In-Reply-To: <20160919185440.18234-2-me@ikke.info> (Kevin Daudt's message of
        "Mon, 19 Sep 2016 20:54:39 +0200")
Message-ID: <xmqqzin3d1zs.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 52AD430C-7EAE-11E6-81B3-5D827B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kevin Daudt <me@ikke.info> writes:

> Many tests need to store data in a file, and repeat the same pattern to
> refer to that path:
>
>     "$TEST_DATA"/t5100/

That obviously is a typo of

	"$TEST_DIRECTORY/t5100"

It is a good change, even though I would have chosen a name
that is a bit more descriptive than "$DATA".

>  test_expect_success 'split sample box' \
> -	'git mailsplit -o. "$TEST_DIRECTORY"/t5100/sample.mbox >last &&
> +	'git mailsplit -o. "$DATA"/sample.mbox >last &&

You are just following the pattern, and this instance is not too
bad, but lines like these

> -	test_cmp "$TEST_DIRECTORY"/t5100/msg$mo msg$mo &&
> -	test_cmp "$TEST_DIRECTORY"/t5100/patch$mo patch$mo &&
> -	test_cmp "$TEST_DIRECTORY"/t5100/info$mo info$mo
> +	test_cmp "$DATA"/msg$mo msg$mo &&
> +	test_cmp "$DATA"/patch$mo patch$mo &&
> +	test_cmp "$DATA"/info$mo info$mo

make me wonder why we don't quote the whole thing, i.e.

	test_cmp "$TEST_DATA/info$mo" "info$mo"

as leaving $mo part unquoted forces reader to wonder if it is our
deliberate attempt to allow shell $IFS in $mo and have the argument
split when that happens, which can be avoided if we quoted more
explicitly.

Perhaps we'd leave that as a low-hanging fruit for future people.

Thanks.
