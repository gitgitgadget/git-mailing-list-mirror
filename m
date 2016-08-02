Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 379DE1F71B
	for <e@80x24.org>; Tue,  2 Aug 2016 19:22:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755977AbcHBTW3 (ORCPT <rfc822;e@80x24.org>);
	Tue, 2 Aug 2016 15:22:29 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63488 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755566AbcHBTW2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Aug 2016 15:22:28 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id D4EF432A26;
	Tue,  2 Aug 2016 15:22:26 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=GMX2KAhNzvYZwua+l4erMKgPYRc=; b=M4tfL5
	8h9+YpnG2C0Qz9NtzmU5/21SSfOPzYuI39kMiNYMFSkisc6dqD2yBKtSWunLWIjF
	+OQ92qIGyHaLkr+iwRYWZFpG/WLHeCwJNpVtIGS/O0Wkc/saK1qm8b7VoP9D6fqr
	YxLWaHTyLbW3exnWLDltLbT7jxPBqQ7hBV1JQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BPLw3Wj8qVFPbaUEh/dCVOPieG5vExRk
	v3ZUoEqXOCxd3rWiKEKf9E2AU2m87KG6y+9vUk6sGyPaIGNFTaRs8JctGlnhrJ+Q
	WWId0bgrABgEwIr/f28H600Uop212plOgHWIIZafxq85PReERiKE7B+/1Yxa4qYd
	bKzNOvgy07g=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id CC37032A25;
	Tue,  2 Aug 2016 15:22:26 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 57C7A32A24;
	Tue,  2 Aug 2016 15:22:26 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Pranit Bauva <pranit.bauva@gmail.com>
Cc:	git@vger.kernel.org
Subject: Re: [RFC/PATCH v11 12/13] bisect--helper: `get_terms` & `bisect_terms` shell function in C
References: <0102015640423c26-2060fd70-c90d-4de3-ae8c-1801ad160b1c-000000@eu-west-1.amazonses.com>
	<0102015640423d09-87c8e96f-f10f-47dc-b24e-e30ba1de4408-000000@eu-west-1.amazonses.com>
Date:	Tue, 02 Aug 2016 12:22:24 -0700
In-Reply-To: <0102015640423d09-87c8e96f-f10f-47dc-b24e-e30ba1de4408-000000@eu-west-1.amazonses.com>
	(Pranit Bauva's message of "Sun, 31 Jul 2016 09:21:38 +0000")
Message-ID: <xmqq1t27dlhr.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 723CDEF0-58E6-11E6-BC80-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Pranit Bauva <pranit.bauva@gmail.com> writes:

> +static int bisect_terms(struct bisect_terms *terms, int term_defined)
> +{
> +	if (get_terms(terms)) {
> +		fprintf(stderr, "no terms defined\n");
> +		return -1;
> +	}
> +	if (!term_defined) {
> +		printf("Your current terms are %s for the old state\nand "
> +		       "%s for the new state.\n", terms->term_good.buf,
> +		       terms->term_bad.buf);
> +		return 0;
> +	}

In the original, all of the above messages go through gettext; this
rewrite should do the same.
