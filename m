Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9456620C11
	for <e@80x24.org>; Mon, 27 Nov 2017 23:53:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753324AbdK0Xw6 (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Nov 2017 18:52:58 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:65065 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753241AbdK0Xw5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Nov 2017 18:52:57 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0557196C78;
        Mon, 27 Nov 2017 18:52:57 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=xD280KQ5gkAcdW3XS63CNowKrsE=; b=rb9PrI
        uZPX5Ld+yC9WSIJx9RCAveJMZJtah2Jap0BQXx67s697oeK2ddWfatigg4YL9lqa
        CIzpkERlM3BIayu+Gb/hGOJdOAoFHXkIPmtw4TV/eChheJeIsvZ1bW3704x9Cmut
        z43fWXYJBDmmxF6XksfBXVE5Pmv6wodrqXk0E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Rsnww+ub1ejMPtTkcYJsickbyr3DovYJ
        TYEstnIHdMe9H03G2Yk3+KLPkcEUFg5IiwVocU6fA+0bJT+Po5Q0n087V/2xwgyu
        BCo2sP3X1UM/UTWgQ+CZGzh3qiXH8sfMLcDJ1mbWzQQGNvs0FrIhrpGWUyPoYX+0
        SKe5B9iJ2gM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id EE79E96C74;
        Mon, 27 Nov 2017 18:52:56 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 596B896C73;
        Mon, 27 Nov 2017 18:52:56 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Takuto Ikuta <tikuta@google.com>, Jeff King <peff@peff.net>,
        git@vger.kernel.org
Subject: Re: [PATCH] Use OBJECT_INFO_QUICK to speedup git fetch-pack
References: <0102015ffbbb2905-570eadd1-6b5c-46af-a3a9-bddfbd01c242-000000@eu-west-1.amazonses.com>
        <xmqqo9noe3u0.fsf@gitster.mtv.corp.google.com>
        <20171127043740.GA5994@sigill>
        <xmqqk1yce301.fsf@gitster.mtv.corp.google.com>
        <CALNjmMo3KH4QXY00ViVaiHdy=pSZ5j0BWRueO1T=sC_r0=3c3g@mail.gmail.com>
        <alpine.DEB.2.21.1.1711272222100.6482@virtualbox>
Date:   Tue, 28 Nov 2017 08:52:55 +0900
In-Reply-To: <alpine.DEB.2.21.1.1711272222100.6482@virtualbox> (Johannes
        Schindelin's message of "Mon, 27 Nov 2017 22:24:46 +0100 (CET)")
Message-ID: <xmqqbmjn9t48.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 173AC206-D3CE-11E7-B05D-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> My current plan is to release a new Git for Windows version on Wednesday,
> to allow for a new cURL version to be bundled.

Is this an updated 2.15.0 or are you planning to package 2.15.1?  I
am asking because you earlier asked me to hold 2.15.1 while you were
away last week and there are accumulated changes on 'maint'.

As I won't be online later this week, unless I cut 2.15.1 today or
early tomorrow, it will have to be done early next week, and I'd
prefer not to do 2.15.1 _immediately_ after a platform announces
an updated release of 2.15.0 for obvious reasons.


