Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8A888211B3
	for <e@80x24.org>; Tue,  4 Dec 2018 02:20:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725981AbeLDCUU (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Dec 2018 21:20:20 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57940 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725937AbeLDCUU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Dec 2018 21:20:20 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E671510DBCA;
        Mon,  3 Dec 2018 21:20:17 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=F61gjH778X9jdh2Jdcx8YWTcZro=; b=sE5DCC
        liWpSFvspio/DCazTFtTxWyaamPeHoHr4khiEH25DUavHhhpmzzXBKt/N5N+cgf0
        BlrMDYK/QlVbO1Vzh1FCM1r4wihMyM+ayOxG7LVEcRf0/Gr4wiuCeBGjJf26sjZS
        /7fG1lZnbsLR199P/59ZuzMipmolIEQEyWS5c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Sz90omnK4F4Q078/FmCUh0t2uvEoq5Hg
        i5ZR2smMwKCUtLYDZmWk469vg1YsUXwBCCyOYlDfR1GY9rPMpdXRHpACOX7u2icE
        EyiynX+JKUaklFYjtGveE41BVNDaYxGAHeDZ5no5cNbF/ri8QsSDsJM+TaDBXxBs
        hhltTMDYJ0k=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DEB3510DBC9;
        Mon,  3 Dec 2018 21:20:17 -0500 (EST)
Received: from pobox.com (unknown [35.187.50.168])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 56D4C10DBC8;
        Mon,  3 Dec 2018 21:20:17 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Matthew DeVore <matvore@comcast.net>,
        Matthew DeVore <matvore@google.com>, git@vger.kernel.org,
        pclouds@gmail.com, jonathantanmy@google.com, jeffhost@microsoft.com
Subject: Re: [RFC 2/2] exclude-promisor-objects: declare when option is allowed
References: <cover.1540256910.git.matvore@google.com>
        <931421945c040ba4518d91f7af9f386d0136bd2f.1540256910.git.matvore@google.com>
        <20181121164019.GA24621@sigill.intra.peff.net>
        <19c82fb0-e0d6-0b15-06ab-cfba4d699d94@comcast.net>
        <20181201194424.GB28918@sigill.intra.peff.net>
        <80a08b99-14cb-e398-e6c2-2aa94a5fdda3@comcast.net>
        <20181203211555.GA8700@sigill.intra.peff.net>
Date:   Tue, 04 Dec 2018 11:20:16 +0900
In-Reply-To: <20181203211555.GA8700@sigill.intra.peff.net> (Jeff King's
        message of "Mon, 3 Dec 2018 16:15:55 -0500")
Message-ID: <xmqq7egqghi7.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2414C640-F76B-11E8-9BC8-BFB3E64BB12D-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> That said, our C99 designated initializer weather-balloons haven't
> gotten any complaints yet. So I think you could actually do:
>
>   struct setup_revision_opt s_r_opt = {
> 	.allow_exclude_promisor_objects = 1,
>   };
>   ...
>   setup_revisions(...);
>
> which is pretty nice.

Yup.  The output from 

    $ git grep -n ' \.[a-z0-9_]* =' -- \*.[ch]

with a bit of "git blame" tells us that cbc0f81d ("strbuf: use
designated initializers in STRBUF_INIT", 2017-07-10) is the balloon
for this exact feature.  The same for array was done in 512f41cf
("clean.c: use designated initializer", 2017-07-14)

[I am writing it down so that I do not have to dig for it every time
and instead can ask the list archive]


