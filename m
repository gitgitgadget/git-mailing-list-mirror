Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 79DB420954
	for <e@80x24.org>; Thu,  7 Dec 2017 19:30:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750939AbdLGTaL (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Dec 2017 14:30:11 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61181 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750828AbdLGTaK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Dec 2017 14:30:10 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D4913C3959;
        Thu,  7 Dec 2017 14:30:09 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=avYNZcCmjz8KefKN48t9H5+0BuE=; b=A3hkMi
        b1RlCtdMENjmfns2fKMS6BwAA1N0RkK9l9VjtbUWJnzqSlN0C511FUi4rxWAUp68
        jeTPFDVSJ1P9JX3cPrB+sDfbuD8zTg3XmAptBuH1RzcsGoHAO1IOa68e1PEjYJqA
        VpJiyY7bNMtx5SwhjNxE6VanbAD0yGmGnzWsA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=JsqdQivTZgVtWHedHsv7idY/ocrivR3y
        LqCzICjY1TBGqKWKoo7MvekUf3ukCXeIguoRNUhYFYdT5oS48UkXHeVnTL9McV3F
        XgTEeUP41Dxte2t9D47lv6Q3I+hy8hceSEeF1qfknh3oyV1SOc/7nlX8iHvzSbbD
        KGuGK/2H4I0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CBE4DC3958;
        Thu,  7 Dec 2017 14:30:09 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 9D6C5C3951;
        Thu,  7 Dec 2017 14:30:08 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [WIP 08/15] connect: discover protocol version outside of get_remote_heads
References: <20171020171839.4188-1-bmwill@google.com>
        <20171204235823.63299-1-bmwill@google.com>
        <20171204235823.63299-9-bmwill@google.com>
        <xmqq7etye5il.fsf@gitster.mtv.corp.google.com>
        <20171207190446.GB152943@google.com>
Date:   Thu, 07 Dec 2017 11:30:06 -0800
In-Reply-To: <20171207190446.GB152943@google.com> (Brandon Williams's message
        of "Thu, 7 Dec 2017 11:04:46 -0800")
Message-ID: <xmqqy3mecp4x.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 09064F3E-DB85-11E7-997E-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> writes:

> While we could wrap the preamble into a function it sort of defeats the
> purpose since you want to be able to call different functions based on
> the protocol version you're speaking.  That way you can have hard
> separations between the code paths which operate on v0/v1 and v2.

As I envision that the need for different processing across protocol
versions in real code would become far greater than it would fit in
cases within a single switch() statement, I imagined that the reader
structure would have a field that says which version of the protocol
it is, so that the caller of the preamble thing can inspect it later
to switch on it.

