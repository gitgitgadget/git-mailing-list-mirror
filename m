Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 83CCB20281
	for <e@80x24.org>; Mon,  2 Oct 2017 12:15:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751166AbdJBMPG (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Oct 2017 08:15:06 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62110 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751062AbdJBMPF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Oct 2017 08:15:05 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 881D199455;
        Mon,  2 Oct 2017 08:15:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=D1FQR/SKUeAgPhpy+SggBsgkPno=; b=oRDoPM
        Fd/UJjh14Eb8FqMSGods090vXM3Gx57LxJnMtAVEN9SfFG09OOBTCSjEgykxsSVc
        8WSDjWGtuLThOO+VlFgKyjhKZBlC4ygjuaCwEPrxmRM03f/QgbUz7LL05oUMMMmm
        qknlvIO640V4pb93Xle4Xhh8FiGgf1q1tfecE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=uYNZcI3sC5cF2clOsDDN1lhbXYm95xP3
        NZAzHCrlhkRHhazxUL0E4mus0Bd88/RRnlai3hX1UVX1iC9Z2ETnj537YRM0XjEO
        j3vhCZDqbpCPBq2mncnB3GhSg6cPF3JtbGRuE35r4CRQN+x2iYKrf1gmoQ6PR7x5
        6arpESmRuWY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 68F7E99453;
        Mon,  2 Oct 2017 08:15:04 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CC9CE9944B;
        Mon,  2 Oct 2017 08:15:01 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, peff@peff.net
Subject: Re: [PATCH v6 0/7] Support %(trailers) arguments in for-each-ref(1)
References: <20170930062238.87077-1-me@ttaylorr.com>
        <20170930184151.GB43975@D-10-157-251-166.dhcp4.washington.edu>
        <20171001000647.GA20767@D-10-157-251-166.dhcp4.washington.edu>
        <20171001161725.GA66172@D-10-157-251-166.dhcp4.washington.edu>
        <20171002003116.GA69902@D-10-157-251-166.dhcp4.washington.edu>
        <20171002052326.GA10729@D-10-157-251-166.dhcp4.washington.edu>
        <xmqq7eweotup.fsf@gitster.mtv.corp.google.com>
Date:   Mon, 02 Oct 2017 21:15:00 +0900
In-Reply-To: <xmqq7eweotup.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Mon, 02 Oct 2017 17:07:58 +0900")
Message-ID: <xmqqy3otn3uj.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 50E4112C-A76B-11E7-BC76-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Thanks.  t6300 seems to show that %(contents:trailers:unfold) does
> not quite work, among other things.
>
>   https://travis-ci.org/git/git/jobs/282126607#L3658
>
> I didn't have a chance to look into it myself.

Peff's "oops, your logic is backwards" fixes the above failure.

We also need this on top to pass the gettext-poison build.

diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index 872973b954..3bdfa02559 100755
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -685,19 +685,21 @@ test_expect_success '%(contents:trailers:only) and %(contents:trailers:unfold) w
 '
 
 test_expect_success '%(trailers) rejects unknown trailers arguments' '
+	# error message cannot be checked under i18n
 	cat >expect <<-EOF &&
 	fatal: unknown %(trailers) argument: unsupported
 	EOF
 	test_must_fail git for-each-ref --format="%(trailers:unsupported)" 2>actual &&
-	test_cmp expect actual
+	test_i18ncmp expect actual
 '
 
 test_expect_success '%(contents:trailers) rejects unknown trailers arguments' '
+	# error message cannot be checked under i18n
 	cat >expect <<-EOF &&
 	fatal: unknown %(trailers) argument: unsupported
 	EOF
 	test_must_fail git for-each-ref --format="%(contents:trailers:unsupported)" 2>actual &&
-	test_cmp expect actual
+	test_i18ncmp expect actual
 '
 
 test_expect_success 'basic atom: head contents:trailers' '
