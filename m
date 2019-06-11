Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 562CB1F462
	for <e@80x24.org>; Tue, 11 Jun 2019 19:53:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405552AbfFKTxO (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Jun 2019 15:53:14 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62942 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404282AbfFKTxO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Jun 2019 15:53:14 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id EA5E714A148;
        Tue, 11 Jun 2019 15:53:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=wXJNviRePnihLQlw1924LuLUW3g=; b=jRnQXW
        6jO6jfXor13JXj36vOtxJ8inDmsfrTe64w4Cr9fLt0bNEJe/h2D673VCEGwnNUr+
        rMm1lnIjEP2P9nAL91lvyFuK3Jqy9Aj84TetO9urXfWDs+TtonWjfAtiKPpFuEXm
        rKg/37J/5XyeOYRNxe9io6TpC2lfy2BLfBVMw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Kiw3nhGp7ypTdcJXXeI84BsTB7UZxuAG
        JrBtofpqvkTuWguoM2PRjGmSjddi3zD5cBPAp0jA25w6pbeBbv2aO9+E4cQbU2f3
        6DNy7rmRxqZ3kqU3yhUcbFU1K4jJypZVyd4LAzezYE2U9zbuzmhyEu++9CSoklYn
        4S4RtEhGvl4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E099214A145;
        Tue, 11 Jun 2019 15:53:11 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 3C33014A144;
        Tue, 11 Jun 2019 15:53:11 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Matthew DeVore <matvore@comcast.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Matthew DeVore <matvore@google.com>, git@vger.kernel.org,
        avarab@gmail.com, git@matthieu-moy.fr, olyatelezhnaya@gmail.com,
        samuel.maftoul@gmail.com, karthik.188@gmail.com, pclouds@gmail.com,
        sunshine@sunshineco.com, emilyshaffer@google.com
Subject: Re: [RFC PATCH] ref-filter: sort detached HEAD lines firstly
References: <faaa9a3d6ba66d77cc2a8eab438d1bfc8f762fa1.1559857032.git.matvore@google.com>
        <nycvar.QRO.7.76.6.1906090954510.789@QRFXGBC-DHN364S.ybpnyqbznva>
        <20190610234918.GA10396@comcast.net>
        <20190611004106.GB64137@google.com>
Date:   Tue, 11 Jun 2019 12:53:10 -0700
In-Reply-To: <20190611004106.GB64137@google.com> (Jonathan Nieder's message of
        "Mon, 10 Jun 2019 17:41:06 -0700")
Message-ID: <xmqqftoflx09.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8ABAA3CC-8C82-11E9-A066-72EEE64BB12D-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

> Git seems to be inconsistent about this.  Documentation/CodingGuidelines
> says
>
>         - When there are multiple arms to a conditional and some of them
>           require braces, enclose even a single line block in braces for
>           consistency. E.g.:
>
> so you have some cover from there (and it matches what I'm used to,
> too). :)

Yup, it took us for quite some time before we settled on that rule
and wrote it down, so there are some lines that predate it *and*
have survived.
