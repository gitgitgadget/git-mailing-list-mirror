Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81F77C433E6
	for <git@archiver.kernel.org>; Tue, 22 Dec 2020 02:11:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4287122BF3
	for <git@archiver.kernel.org>; Tue, 22 Dec 2020 02:11:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726282AbgLVCLu (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Dec 2020 21:11:50 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62430 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725850AbgLVCLt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Dec 2020 21:11:49 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 38E39895E5;
        Mon, 21 Dec 2020 21:11:07 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Etyvjtq+WcD+i35nAminHF55IQU=; b=GWZZIN
        jedMFLolDo3jhHedCwA1VVX3Q19n4o6+1ZCheltkMnBOFbQGShcqDKtIHjPnPfOD
        /mu3Mmk4OvsTVji9cHk6o6CpCL2yM+5ATPWik/WP3a5wXNEZo9fzkxCvy6CV7v12
        zC+AE8ZHmzg0JID63dkxCizRe78bfxgtX8794=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=AAEXqwXV68VgjjaevL8zetb0CK4kEYKe
        Xu6DU1iGka10/RutAAQgRuT4b+X7ocn4RBQC7MUasEpLy6Y49W2BEjTJQSgoMhVc
        XNB95FHpheGEJGMB4VYaYjsVzqwyb9l920+As9sfygJJASUPZKeWay4qT2x7mh/+
        llx8BbM1JdA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2BBA6895E4;
        Mon, 21 Dec 2020 21:11:07 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 61DBF895E3;
        Mon, 21 Dec 2020 21:11:06 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        James Ramsay <james@jramsay.com.au>,
        Jonathan Nieder <jrnieder@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?utf-8?Q?=C3=86var_Arnfj=C3=B6?= =?utf-8?Q?r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Phillip Wood <phillip.wood123@gmail.com>,
        Josh Steadmon <steadmon@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v7 00/17] propose config-based hooks (part I)
References: <20201222000220.1491091-1-emilyshaffer@google.com>
Date:   Mon, 21 Dec 2020 18:11:05 -0800
In-Reply-To: <20201222000220.1491091-1-emilyshaffer@google.com> (Emily
        Shaffer's message of "Mon, 21 Dec 2020 16:02:03 -0800")
Message-ID: <xmqqft3yk2ti.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F3179F02-43FA-11EB-942A-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <emilyshaffer@google.com> writes:

> Since v6:
>
>  - Converted 'enum hookdir_opt' to UPPER_SNAKE
>  - Coccinelle fix in the hook destructor
>  - Fixed a bug where builtin/hook.c wasn't running the default git config setup
>    and therefore missed hooks in core.hooksPath when it was set. (These hooks
>    would still run except when invoked by 'git hook run' as the config was
>    called by the processes which invoked the hook library.)

Thanks.  Queued both series (it probably is easier to think of these
as a single 34-patch series, as long as they both are in flight at
the same time).

