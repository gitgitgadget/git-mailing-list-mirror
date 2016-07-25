Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9119D203E2
	for <e@80x24.org>; Mon, 25 Jul 2016 20:05:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752487AbcGYUFy (ORCPT <rfc822;e@80x24.org>);
	Mon, 25 Jul 2016 16:05:54 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55098 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751787AbcGYUFx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jul 2016 16:05:53 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id B7BEE2E8ED;
	Mon, 25 Jul 2016 16:05:51 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=aCE/OHQoOkKnUL+5fmAq3UFeQ5c=; b=fPTeds
	k2WB6K0tII1OFNDPKNlqZfkViBrE2o8pyZJncIbLLL2w7z04eldn6yuIiJ0n9W5E
	5KeCmlA+QKh9dWQoDbHq+TafjO9YsZ0ulYHOd6suKoqoEQzSJlpVv7nVkJQ0xXLr
	JVGDak/EQSO4TrlzVVm2kc7QVp5gJdewuMXZQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=SiKgbCHdaRT4CbVE2oPFnbUSvmeTxr9F
	fSp1hC+foqR2zhJmDCquyLSBjX9/hYhU3tRNbOoeBmtnv7C3L+Xr3Ez6KLMPX/WS
	26ZVleKNI2NgwLbvQv/WGe3QtwAroFDHkMfJOC1BGbuAHLAHF6N6SLyFjr00Kjh4
	fnhPCRyty94=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id AF51F2E8EC;
	Mon, 25 Jul 2016 16:05:51 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 37CAD2E8EB;
	Mon, 25 Jul 2016 16:05:51 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Jeff Hostetler <jeffhost@microsoft.com>
Cc:	git@vger.kernel.org, git@jeffhostetler.com, peff@peff.net,
	Johannes.Schindelin@gmx.de
Subject: Re: [PATCH v2 2/8] status: cleanup API to wt_status_print
References: <1469474750-49075-1-git-send-email-jeffhost@microsoft.com>
	<1469474750-49075-3-git-send-email-jeffhost@microsoft.com>
Date:	Mon, 25 Jul 2016 13:05:49 -0700
In-Reply-To: <1469474750-49075-3-git-send-email-jeffhost@microsoft.com> (Jeff
	Hostetler's message of "Mon, 25 Jul 2016 15:25:44 -0400")
Message-ID: <xmqq7fc95vqa.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2F8EBE6E-52A3-11E6-AC50-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Jeff Hostetler <jeffhost@microsoft.com> writes:

> Refactor the API between builtin/commit.c and wt-status.[ch].
> Hide details of the various wt_*status_print() routines inside
> wt-status.c behind a single (new) wt_status_print() routine
> and eliminate the switch statements from builtin/commit.c
>
> This will allow us to more easily add new status formats
> and isolate that within wt-status.c
>
> Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
> ---

The division of labour between wt-status.c and cmd_status() that was
originally envisioned was to have status computation in the former
and presentation in the latter, but that was broken and more output
is made from the latter these days, so I think it may make sense to
admit that the original vision did not work out well, and this step
is a good move forward to shift the boundary.

