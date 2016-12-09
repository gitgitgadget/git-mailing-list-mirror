Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 835921FC96
	for <e@80x24.org>; Fri,  9 Dec 2016 23:12:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752863AbcLIXML (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Dec 2016 18:12:11 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53870 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752065AbcLIXMK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Dec 2016 18:12:10 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B3F4E5663E;
        Fri,  9 Dec 2016 18:12:09 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=rFZJA2LL8+vfamBYvY8PHgy/AUA=; b=Z9rEX/
        PwZ2h7wMqh5iWZU50Lvf885FIzEFxk+9pRbteZI33ii6bW7jB8r6pPA6FWfS5Pok
        UwDHCvSgqHZKg9D2y4ZdPLChiZeRDTMp83ye+0ux3QguDArisblYk0/KZc7h5Tot
        yAaIK94S6/GXmpH6oPo0poyhukRf8te4vv7D0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Jcp2yUayS9BGqP4coE/XESZlm8HC6MSU
        +SQ+Drtueuf1hMsbGAc3f/plUoNVETF1znDI2b+iwPb9vEDi5oAWbUGJfB1s6R/R
        j3EeIPAvCmtPVJsfKlfe81DOEdzoaVBa06pwS848e3lRje4ZdqZVgLkAyDSWXNT8
        X94Tv4xe8dE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id AC1A25663D;
        Fri,  9 Dec 2016 18:12:09 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 21E2D5663A;
        Fri,  9 Dec 2016 18:12:09 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Quinn Grier <quinn@quinngrier.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] describe: add tests for unusual graphs
References: <20161209131141.3096-1-quinn@quinngrier.com>
Date:   Fri, 09 Dec 2016 15:12:07 -0800
In-Reply-To: <20161209131141.3096-1-quinn@quinngrier.com> (Quinn Grier's
        message of "Fri, 9 Dec 2016 07:11:41 -0600")
Message-ID: <xmqq60msr92w.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E8B4951C-BE64-11E6-B054-B2917B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Quinn Grier <quinn@quinngrier.com> writes:

> git describe may give incorrect results if there are backdated commits
> or multiple roots. This commit adds two test_expect_failure tests that
> demonstrate these problems.

I am not sure if this is a good patch to take.  test_expect_failure
is to demonstrate an incorrect behaviour that we wish to correct
later, but I do not think these demonstrate incorrect behaviours to
begin with.

For example, the latter one seems to expect that by asking to
describe D in this picture

> +#
> +# A---B*--D master
> +#        /
> +#       C* other
> +#

you seem to expect the description is based on B.  

It is not at all clear why it is incorrect if the description were
made based on C.  If D were described relative to A, ignoring B,
then I understand why that result is incorrect and I would agree
that describing D in terms of B is more correct.  But I do not think
that is what the test is trying to demonstrate.

But it is hard to guess only from looking at the test and the
proposed log message, because it does not say what makes you think
the behaviour you saw was incorrect.
