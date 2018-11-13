Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 273681F87F
	for <e@80x24.org>; Tue, 13 Nov 2018 14:30:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731824AbeKNA2t (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Nov 2018 19:28:49 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55089 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727166AbeKNA2t (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Nov 2018 19:28:49 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9A48F1119FF;
        Tue, 13 Nov 2018 09:30:23 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=R9zeXwVvFPugVM4Bb2iMLDq6LF0=; b=Fzm9Cz
        4y+uEBLMQsO6SxSZZI4/jYIJ/cHnxQPsYyfRUZ3GpuO437+Z4syF3XkzHalm7e5O
        MLZO8NPL5+5yTDGx0/6tfWSFdVEdUphpoSIvQqScJ1Oos4RkrKQ1FIIKEGN1agAD
        xjnpkpNn/+GsuDoDenRaCaaiOxMDZ8YsNAO2M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=hXveNa06tikp3zUoXfTo1HjgWJvSBNl4
        zB7dQ/gvn97yyld1nD35uc9CgYmpP9ISBQ02GuA972hD39Z+pPLOQMxnNmycH+zP
        vq0vDeZrkXYrgl43oUsfC9NBkxDwOqdbrCwl39bEQXJiVdrUt2ZTfDNEdlygW0qt
        +uqM6s0tK3Y=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 943F41119FE;
        Tue, 13 Nov 2018 09:30:23 -0500 (EST)
Received: from pobox.com (unknown [35.187.50.168])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0DED01119FB;
        Tue, 13 Nov 2018 09:30:22 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     steadmon@google.com
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] remote-curl: die on server-side errors
References: <9a89e54e79593f6455b52e01d802695362f4ec21.1542062657.git.steadmon@google.com>
Date:   Tue, 13 Nov 2018 23:30:21 +0900
In-Reply-To: <9a89e54e79593f6455b52e01d802695362f4ec21.1542062657.git.steadmon@google.com>
        (steadmon's message of "Mon, 12 Nov 2018 14:44:56 -0800")
Message-ID: <xmqq4lcluk1u.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A7A32DA6-E750-11E8-99A5-BFB3E64BB12D-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

steadmon@google.com writes:

> When a smart HTTP server sends an error message via pkt-line,
> remote-curl will fail to detect the error (which usually results in
> incorrectly falling back to dumb-HTTP mode).

OK, that is a valid thing to worry about.

>
> This patch adds a check in discover_refs() for server-side error
> messages, as well as a test case for this issue.

This makes me wonder if discoer_refs() is the only place where we
ought to be checking for ERR packets but we are not.  Are there
other places that we also need a similar fix?
