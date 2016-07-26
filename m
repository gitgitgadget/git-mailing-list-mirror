Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 38494203E3
	for <e@80x24.org>; Tue, 26 Jul 2016 17:13:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757309AbcGZRMW (ORCPT <rfc822;e@80x24.org>);
	Tue, 26 Jul 2016 13:12:22 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64294 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757012AbcGZRMU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jul 2016 13:12:20 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 154F62E3B2;
	Tue, 26 Jul 2016 13:12:19 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Dcd3lKqP0vrVtFN3sQpRnt0Axd4=; b=R4Q0pk
	UYUC4a20/bhWRw4n60CrQJGJ/+vYJqZfxjXxMDD5p+UaX6JvWpvma+YifsHniXwh
	dRMBctA/kq1ZHFl6xTpRk5tPOtbnQHxxB2v5Hqf4Ow4+hszIZBSM29NHWROZJ93o
	UKUn3fDcdpTy6Uli+4im3rt+Vh56Q0a0i3VWk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=RAwT4+dNEFmbbsgOWYNm04ziND5OitSt
	uT4ZrQ7E3e1wDUTU5MGb3LuqHQvRsdzv0wmjcHuhVha0sZzC70RUBE0QqPHDdHLG
	qWwm912eoKEeue5Lxt6rnXYC5oJey/4VPahQL1/T8PQOLI50AOvkj4MCCxb821xg
	JZ2f98Trw0c=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 0D2682E3B1;
	Tue, 26 Jul 2016 13:12:19 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 87A4B2E3B0;
	Tue, 26 Jul 2016 13:12:18 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:	git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
	Duy Nguyen <pclouds@gmail.com>,
	Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>
Subject: Re: [PATCH v4 11/16] am -3: use merge_recursive() directly again
References: <cover.1467902082.git.johannes.schindelin@gmx.de>
	<cover.1469187652.git.johannes.schindelin@gmx.de>
	<667d2f991f1423b138a746f4c685b13c5b572a83.1469187653.git.johannes.schindelin@gmx.de>
	<xmqqy44p2wds.fsf@gitster.mtv.corp.google.com>
	<alpine.DEB.2.20.1607261426340.14111@virtualbox>
Date:	Tue, 26 Jul 2016 10:12:16 -0700
In-Reply-To: <alpine.DEB.2.20.1607261426340.14111@virtualbox> (Johannes
	Schindelin's message of "Tue, 26 Jul 2016 14:30:55 +0200 (CEST)")
Message-ID: <xmqqr3ag1fyn.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1B92398E-5354-11E6-93CB-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> If you want, I can break out the subsequent patches into a separate
> series.

I do not think that would help anybody, as we'll have to review them
anyway.  If some of the the later ones were "oops, this earlier step
did an incomplete job and here is a fix-up", then squashing them
into the step where such a mistake happens may reduce the review
load, but I suspect that is not the case (iow, they are enhancements
and the earlier ones can stand on their own).

> I may have missed something as stupid as an unclosed file handle, after
> all.

Yes, reviewing the same change over and over, especially if the
change is your own, tends to have diminishing rate of bug yields,
which is why they need to be reviewed by fresh set of eyes.



