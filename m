Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9E46C1F407
	for <e@80x24.org>; Sun, 10 Dec 2017 22:28:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751526AbdLJW2L (ORCPT <rfc822;e@80x24.org>);
        Sun, 10 Dec 2017 17:28:11 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52679 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751268AbdLJW2K (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Dec 2017 17:28:10 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B471DCCDFD;
        Sun, 10 Dec 2017 17:28:09 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=PKpvzl4xJHNWfBcclpIpt3Jik6w=; b=qlXNqS
        k0uQLTo3QizXs3KxyhFKSr/vTPLIB+pJIDPJqYmB7dRbDwi9JE8e+NqZOxD1gPlq
        4vcIBqIe1FVS3lmNsBOVa160mi/SfdbKFBfCit7IL2MNGMQuOm775MJW1Y/+5hsQ
        NhR7409yICk1BNYzYZwWSulWCL1mAQ/qDtX9E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=dz0WrwLMCNvH/3f73BvvUTEAWIV5z4OO
        JRHh4tOI6QdY12ZqhbDhdkhqjNIE0likzof8GnxIx5JJ+vmjF87+J470Re66UO7r
        kOMlgMa5DypyD1kA5D0edwiPdIZOGIpcH6SNo+E8/Hg1/dY23IgOGybZjwDCxVxI
        CQRpYWR9iK0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id AC96CCCDFC;
        Sun, 10 Dec 2017 17:28:09 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 2D265CCDFB;
        Sun, 10 Dec 2017 17:28:09 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     GIT Mailing-list <git@vger.kernel.org>
Subject: Re: t9001 failures on 32-bit Linux?
References: <42367c9f-debb-8ea2-e1ea-1ca513853ded@ramsayjones.plus.com>
Date:   Sun, 10 Dec 2017 14:28:07 -0800
In-Reply-To: <42367c9f-debb-8ea2-e1ea-1ca513853ded@ramsayjones.plus.com>
        (Ramsay Jones's message of "Sun, 10 Dec 2017 19:58:18 +0000")
Message-ID: <xmqqfu8i5ibs.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 665C17EC-DDF9-11E7-B27E-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ramsay Jones <ramsay@ramsayjones.plus.com> writes:

> Hi Junio,
>
> I noticed the revert of the 'ab/simplify-perl-makefile' branch on
> top of 'pu'. So, I fired up my 32-bit Linux and attempted to see
> if I could debug this t9001 test failure.
>
> Unfortunately, I could not get it to fail. :(
>
> Both of the 'pu' (@77e921d77d) and 'pu~1' (@cfef1ebefd) builds pass
> the full test-suite and, likewise, running t9001 in a loop for a
> count of 100 (about 45 minutes run-time each).
>
> [If it makes any difference, I don't have sendmail installed (no
> /usr/sbin/sendmail or /usr/lib/sendmail), or any sendmail in my
> $PATH.]
>
> Sorry I couldn't help with this! :(

I suspect that the difference is not about send(e)mail per-se, but
the differences between the set of perl modules installed in the
linux32 Travis environment and the other one.  Perhaps the use of
deprecated Error.pm is the culprit?

I do appreciate that the environments we use on Travis are not
monoculture and we end up testing more variations (in this case,
the cause likely does not have anything to do with 64- vs 32-bit,
but Perl modules).  It sometimes gets confusing, though ;-)

Another difference I noticed while scanning the failing log is that
the Linux32 environment seem to lack libsvn-perl and all tests are
skipped there.  I do not think that this particular variation is
helping us to diversify our test base, though ;-)

Thanks.
