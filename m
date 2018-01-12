Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A7CD91F406
	for <e@80x24.org>; Fri, 12 Jan 2018 23:27:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965364AbeALX1o (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Jan 2018 18:27:44 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59573 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965260AbeALX1n (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Jan 2018 18:27:43 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 69BE0D8317;
        Fri, 12 Jan 2018 18:27:43 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=IOESwYY1dj2ApH2/pgyehnmhdIg=; b=BNcVtk
        fkg+/bvtW04PmXIbxJIw49wykKPAiUKTZQc+moVdJ8ZDgaiGJfYN+fbp0AkgA5iF
        vwUXNahQar3RBBCOJkQBNy5eSMcfFg5jmUi9Pr8cvSp63zGebCgGUmRDxiFiVvph
        Aax/qwspkP708nvEffZUXPDPklqe0p8r3sEbM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=sbEYUPe1pgDs6qv6pOyHL2ttiMvCKTfE
        xaamV+vlxI6LP7ryzHMqp3qVmmZsnkA7bL5soAz/2iXBU6LZHjiElghE86KYh+NW
        DEDFqRSB8S0EI8JCDdYyFYNAPgNb9JobzWR8Ldg1yoeQmcsEy8i6+KyOKyGR6c56
        jplJZ986ejA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 60A0ED8316;
        Fri, 12 Jan 2018 18:27:43 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D2067D8315;
        Fri, 12 Jan 2018 18:27:42 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Randall S. Becker" <rsbecker@nexbridge.com>
Cc:     <git@vger.kernel.org>, "'Tanay Abhra'" <tanayabh@gmail.com>,
        "'Matthieu Moy'" <git@matthieu-moy.fr>
Subject: Re: [ANNOUNCE] Git v2.16.0-rc2 - breakages in t1308 and 1404
References: <004b01d38bdd$7a11da60$6e358f20$@nexbridge.com>
        <xmqqd12ewx1v.fsf@gitster.mtv.corp.google.com>
        <008f01d38bfa$7eba9bc0$7c2fd340$@nexbridge.com>
Date:   Fri, 12 Jan 2018 15:27:41 -0800
In-Reply-To: <008f01d38bfa$7eba9bc0$7c2fd340$@nexbridge.com> (Randall
        S. Becker's message of "Fri, 12 Jan 2018 18:10:05 -0500")
Message-ID: <xmqqy3l2ves2.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3011589E-F7F0-11E7-BCDD-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Randall S. Becker" <rsbecker@nexbridge.com> writes:

> Sadly, fixing the "except" thing causes the test to break now.

That is exactly what I wanted to say.  If you want to "fix" it,
you'd need to figure out what the author of the "except" thing
wanted to test, adjust the args given to test-config (it cannot be
the same as the test-config invocation of the previous test), and
then fix the typo s/except/expect/.  Changing the typo alone *will*
of course make the test fail, because then the file with the
corrected name, i.e. "expect", has bogus lines that does not match
how the current invocation of "test-config" command is expected to
output.

> sense of the intent of this, unless the test is to find unmatching keys and
> it really does mean "except"
> --- expect      2018-01-12 23:03:41 +0000
> +++ actual      2018-01-12 23:03:41 +0000
> @@ -1,5 +1 @@
> -sam
> -bat
>  hask
> -lama
> -ball
>
> [case]
> baz = lama
> [my]
> new = silk
> [case]
> baz = ball
