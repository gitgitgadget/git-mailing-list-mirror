Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C9D4A1F859
	for <e@80x24.org>; Mon, 15 Aug 2016 21:10:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932333AbcHOVKn (ORCPT <rfc822;e@80x24.org>);
	Mon, 15 Aug 2016 17:10:43 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50782 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932254AbcHOVKm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Aug 2016 17:10:42 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1CFD134CF6;
	Mon, 15 Aug 2016 17:10:41 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=OcCAW1op1LfZmLOqdknjsG+Hs6M=; b=I71zFf
	HhwjDQuSUnyTLgTLqkXY/wMEqV+B5c5/51mowDY44dA3EUEvXehZJHucXlaBfonZ
	EfgWUBhtu+xPwnoHEUvnOJTYlI1gWscvlA+P2SiADesVaENtNyI5F6YasArwWVN5
	Ukds4poj7I7zewx0loV4Q1lK7NlZCS1vYgykY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=tFvxW8Ql60RRzxvIaZLMg/HDJu0k+mm3
	Lac41SEqo78mrYxQA1jeGiS+AqxDdPT3S/IfrSepyOC6N+C6zdfAZ1gbR+8NoJa+
	u0R2+bklIzoZXQYPlsWehljTRvxgyWxLX8NoqjhIub082ZmuCXoiKrz5G7Bs23VS
	6KJws8yBg2g=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 12BCE34CF0;
	Mon, 15 Aug 2016 17:10:41 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7329734CEF;
	Mon, 15 Aug 2016 17:10:40 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Jeff King <peff@peff.net>
Cc:	Stefan Beller <sbeller@google.com>, git@vger.kernel.org,
	jrnieder@gmail.com, remi.galan-alfonso@ensimag.grenoble-inp.fr
Subject: Re: [PATCH 2/2] checkout: do not mention detach advice for explicit --detach option
References: <20160815184021.12396-1-sbeller@google.com>
	<20160815184021.12396-2-sbeller@google.com>
	<20160815184730.eevqogqrxp2zp43q@sigill.intra.peff.net>
	<xmqqh9alg2uh.fsf@gitster.mtv.corp.google.com>
Date:	Mon, 15 Aug 2016 14:10:36 -0700
In-Reply-To: <xmqqh9alg2uh.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Mon, 15 Aug 2016 14:05:26 -0700")
Message-ID: <xmqqd1l9g2lv.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B870C71A-632C-11E6-AF70-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Jeff King <peff@peff.net> writes:
>
>> I don't think doing it this way is _wrong_. It just feels sort of
>> pointlessly over-engineered. It's also a little weird that all of the:
>>
>>   if (advice_foo)
>>
>> will trigger because "advice_foo" is set to -1. I think it does the
>> right thing, but it feels like a bug (the value is now a tri-state, and
>> we silently collapse two states into one).
>
> Guilty as charged.  I do agree that this is over-engineered.

Let's discard 1/2 and amend 2/2 with this incremental.



 builtin/checkout.c         | 3 +--
 t/t2020-checkout-detach.sh | 5 -----
 2 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 2a32b5f..337c35a 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -656,8 +656,7 @@ static void update_refs_for_switch(const struct checkout_opts *opts,
 			   REF_NODEREF, UPDATE_REFS_DIE_ON_ERR);
 		if (!opts->quiet) {
 			if (old->path &&
-			    (advice_detached_head == 1 ||
-			     (advice_detached_head == -1 && !opts->force_detach)))
+			    advice_detached_head == 1 && !opts->force_detach)
 				detach_advice(new->name);
 			describe_detached_head(_("HEAD is now at"), new->commit);
 		}
diff --git a/t/t2020-checkout-detach.sh b/t/t2020-checkout-detach.sh
index fe311a1..fbb4ee9 100755
--- a/t/t2020-checkout-detach.sh
+++ b/t/t2020-checkout-detach.sh
@@ -180,11 +180,6 @@ test_expect_success 'no advice given for explicit detached head state' '
 	git checkout child && git checkout --detach HEAD^0 >actual 2>&1 &&
 	test_cmp expect.no-advice actual &&
 
-	# explicitly ask advice
-	test_config advice.detachedHead true &&
-	git checkout child && git checkout --detach HEAD^0 >actual 2>&1 &&
-	test_cmp expect.advice actual &&
-
 	# explicitly decline advice
 	test_config advice.detachedHead false &&
 	git checkout child && git checkout --detach HEAD^0 >actual 2>&1 &&
