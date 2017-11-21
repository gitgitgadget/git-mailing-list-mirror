Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 90A57202F2
	for <e@80x24.org>; Tue, 21 Nov 2017 00:32:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751728AbdKUAc1 (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Nov 2017 19:32:27 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57132 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751242AbdKUAcZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Nov 2017 19:32:25 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B9C4D9FE11;
        Mon, 20 Nov 2017 19:32:24 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=EkxHFx/FCVekGVPhpksqWaa/4mY=; b=qINq1A
        /CDn71EP6UKjrSZdf98choFsupJrMJeWdhDSc43ppe47gwinXR92sOzIhzIEVscm
        zmGagd6KXc0UVRP4CaqvJJf38pavXkDHw9VAwnzCI4YFS7VoW2jiW11SXI4Os0Zr
        C4ZOhKkA8hm1x9UecE5F7r5ytFBazl+6JLhSc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=rC9FsfqqShYqy5DEATbMAI6zrI1f3jiq
        946+bXXzQMZ+/L+dh4nEik8MNd9iH/48S7/pdZAsLC9RtBUsyxrTJdC34NIo6Zcq
        bqltXS8/vXygUfZI7h4UvRBqxQFqg5p+I4mv5CJCWtCPyUKlMB9Ud2o/N/+sFSHT
        n6b0CmF4iZA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B0A109FE10;
        Mon, 20 Nov 2017 19:32:24 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 3439B9FE0F;
        Mon, 20 Nov 2017 19:32:24 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH] git-send-email: fix get_maintainer.pl regression
References: <20171116154814.23785-1-alex.bennee@linaro.org>
        <CAPig+cSh0tVVkh0xF9FwCfM4gngAWMSN_FXd2zhzHcy2trYXfw@mail.gmail.com>
        <CAPig+cSbRrGnyDkunMFiFXbWRMAsGyuAL-0FpP1QTtjSUSY2Hg@mail.gmail.com>
Date:   Tue, 21 Nov 2017 09:32:22 +0900
In-Reply-To: <CAPig+cSbRrGnyDkunMFiFXbWRMAsGyuAL-0FpP1QTtjSUSY2Hg@mail.gmail.com>
        (Eric Sunshine's message of "Mon, 20 Nov 2017 13:57:10 -0500")
Message-ID: <xmqqfu98lbe1.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 71A4764A-CE53-11E7-B4EF-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> The more I think about this, the less I consider this a bug in
> git-send-email. As noted, people might legitimately use a complex
> command (--cc-cmd="myscript--option arg"), so changing git-send-email
> to treat cc-cmd as an atomic string seems like a bad idea.

I concur.  Thanks for thinking this through.

> Assuming no changes to git-send-email, to get your test working, you
> could try to figure out how to quote the script's path you're
> specifying with --cc-cmd, however, even easier would be to drop $(pwd)
> altogether. That is, instead of:
>
>     --cc-cmd="$(pwd)/expected-cc-script.sh"
>
> just use:
>
>     --cc-cmd=./expected-cc-script.sh

Sounds sensible.
