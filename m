Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D39FD2036D
	for <e@80x24.org>; Wed, 22 Nov 2017 06:14:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751199AbdKVGOY (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Nov 2017 01:14:24 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61942 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751102AbdKVGOX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Nov 2017 01:14:23 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0B547BD0EF;
        Wed, 22 Nov 2017 01:14:21 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=WPKuyfEaS+/7y4UiV5LuP3uH50E=; b=azXukQ
        DUFB6KGzxF2/zT9fDRVaNnDKNfPGc5THUDtYiuFBMjQu+SLeibsBWR4TXnVDVQq9
        /kkomA4kJPe3MG7PRPgVs2AnIDLYp2NSZfsJeBic6wx2R7dXsLveGnvcBCLr0F8+
        J+6LpGtZRQNrkBWzLxh61NF7Jso73V5t6zKrA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=A1yBn7CzioUbOAvtkZaZVD+ywyBfns4d
        b4ynvY/Bi+Sqt/Bhx9e7eerVVVbESVQHRLd/u8PQ1K+CL1bxUjlL0o/3HsRzNcPo
        q3Tqh2fnHNTNjK40MLUGdEO7x+PMn8DgXmzKm/Upyiveehv/fP8tgoLe6VcS8D1+
        HVoJpOWDw6Y=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 03AD2BD0ED;
        Wed, 22 Nov 2017 01:14:21 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 7C70ABD0EC;
        Wed, 22 Nov 2017 01:14:20 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phil Hord <phil.hord@gmail.com>
Cc:     Git <git@vger.kernel.org>,
        Rafael =?utf-8?Q?Ascens=C3=A3o?= <rafa.almas@gmail.com>
Subject: Re: [PATCH] defer expensive load_ref_decorations until needed
References: <20171121234336.10209-1-phil.hord@gmail.com>
        <xmqqbmjuvrab.fsf@gitster.mtv.corp.google.com>
Date:   Wed, 22 Nov 2017 15:14:19 +0900
In-Reply-To: <xmqqbmjuvrab.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Wed, 22 Nov 2017 14:03:24 +0900")
Message-ID: <xmqqk1yiu9fo.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 60B82058-CF4C-11E7-934E-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Other than that, I like what this patch attempts to do.  A nicely
> identified low-hanging fruit ;-).

Having said that, this will have a bad interaction with another
topic in flight: <20171121213341.13939-1-rafa.almas@gmail.com>

Perhaps this should wait until the other topic lands and stabilizes.
We'd need to rethink if the approach taken by this patch, i.e. to
still pass the info to load() but holding onto it until the time
lazy_load() actually uses it, is a sensible way forward, or we would
want to change the calling convention to help making it easier to
implement the lazy loading.

Thanks.



