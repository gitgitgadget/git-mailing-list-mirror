Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7095B1F4BD
	for <e@80x24.org>; Wed,  9 Oct 2019 11:44:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729471AbfJILob (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 Oct 2019 07:44:31 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50115 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725962AbfJILob (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Oct 2019 07:44:31 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 18B0939D1C;
        Wed,  9 Oct 2019 07:44:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=BS2JmcXl7CD5X5aYWNcOJLkHYYw=; b=UXNyX6
        8a17nKjLefN8YWxBojFiyAz50h7hrdGdMKrVbm1YijBf6A6KOi85mR3RtlPXVf8/
        gUJ+NARVP+XD9Eu9ub1TFUmutfAFqp1P+F+KIafc3tq8xhHn/XPcD0FTYArSvUY3
        kVNjPUoBpywHmipPKpyarPbqz23I0UIux4qWs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Buyzv+Ks4fF2jsCKk7GpqAUUUV30bdwy
        2KWL/hY9T0ujO4wL0nhNgulTOjuh1rjAaf+jOJQ4B/dVgMwLmqhxETwKzzNtVvDM
        P4CojLz9JfsapDyAv+krVIcoCeTXyYrvTVTnVM8nmoCVt5jOziieJG8gqs94jVxX
        yj67Jty8ehw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 100FA39D1B;
        Wed,  9 Oct 2019 07:44:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6E97A39D1A;
        Wed,  9 Oct 2019 07:44:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Sixt <j6t@kdbg.org>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 1/1] Add a helper to reverse index_pos_to_insert_pos()
References: <pull.378.git.gitgitgadget@gmail.com>
        <81648344bbab4219c0bfc60d1e5f02473ea7d495.1570517329.git.gitgitgadget@gmail.com>
        <75a9c7ce-893c-6341-ba8d-eed3ccba7ee3@kdbg.org>
        <xmqq5zkyn2a7.fsf@gitster-ct.c.googlers.com>
        <623fcd51-5f0d-bc5b-f70d-0224a054ec5c@kdbg.org>
        <nycvar.QRO.7.76.6.1910091015090.46@tvgsbejvaqbjf.bet>
Date:   Wed, 09 Oct 2019 20:44:27 +0900
In-Reply-To: <nycvar.QRO.7.76.6.1910091015090.46@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Wed, 9 Oct 2019 10:17:58 +0200 (CEST)")
Message-ID: <xmqqeezmkusk.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 268D4C72-EA8A-11E9-9392-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> FWIW I actually agree with Junio about the helper, but in hindsight I
> could have used a better name (not one that is tied to the "index").
> Something like `unsigned_one_complement()`. But of course, that would
> say _what_ it does, not _why_.

I personally feel that the particular name is on the better side of
the borderline.  "st_add3(a, b, c)" says it is about adding three
size_t quantities, without saying why it exists and should be used
over a+b+c.  Existence of the helper and calling it alone should be
a good enough sign that we somehow feel a+b+c is not sufficient [ly
safe], so we do not call it st_add3_safe() or st_add3_wo_overflow().

Your unsigned-one-complement would fall into the same category, no?
