Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7C1011F406
	for <e@80x24.org>; Tue,  9 Jan 2018 19:13:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935454AbeAITNQ (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Jan 2018 14:13:16 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60343 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935440AbeAITNO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Jan 2018 14:13:14 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 96708C8985;
        Tue,  9 Jan 2018 14:13:13 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=8yQ+wLLXt6Lr
        byWh2+48qur0TUQ=; b=DGnjCMCg84ntDpgVsfiPETNKEifyDWeCgU2/bbIgJ/Y6
        aKcV3Qy0jsiqN668Q5tPURqUawMvAjBmh9LN+7DDxHWOU4kOn1nx5A1a6OZuKG4a
        gQWuvEuVAf1ZhOOan/x3liCkA2k+t4uOjDELbWNFQbcttH2T+3VOkmyxL2keBEU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=H0oDQb
        rMziI2Nvpf8x7eaZzaXleaLdqfBV6d2eGh9LMna1OesGz1h5WOsq9TLGgVu/+MJ4
        YdSZEJr8sYxv6yYi542DECDaLD1Q6seyBET0C1HRoY7FWzU97aObNBKurngxK5ka
        ijpUWlHZPKwxj7EnsJ24MsMlHx2F0lr2b+ml4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8DFD9C8984;
        Tue,  9 Jan 2018 14:13:13 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0EBB4C8982;
        Tue,  9 Jan 2018 14:13:12 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Thomas Rast <tr@thomasrast.ch>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: merge-base --is-ancestor A B is unreasonably slow with unrelated history B
References: <87608bawoa.fsf@evledraar.gmail.com>
Date:   Tue, 09 Jan 2018 11:13:11 -0800
In-Reply-To: <87608bawoa.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Tue, 09 Jan 2018 16:17:41 +0100")
Message-ID: <xmqq7esq6e2g.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 2351930C-F571-11E7-8D2C-8EF31968708C-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> This is obviously a pathological case, but maybe we should work slightl=
y
> harder on the RHS of and discover that it itself is an orphan commit.

In order to discover a commit is an orphan, you'd need to prove not
just that it does not reach the main part of the history (which is
cheap---its parenthood network would be quite limited and traversing
all of it is not that expensive) but the other way around, i.e. the
main part of the history would not reach it.

Do you have a cheaper way to do the latter than a full traveral of
the main history?  If not, then the cost similar to "git log master"
is expected.
