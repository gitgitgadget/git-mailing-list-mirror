Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8949D20195
	for <e@80x24.org>; Fri, 15 Jul 2016 18:13:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751379AbcGOSNp (ORCPT <rfc822;e@80x24.org>);
	Fri, 15 Jul 2016 14:13:45 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55926 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751286AbcGOSNo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jul 2016 14:13:44 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id AE6AF2D851;
	Fri, 15 Jul 2016 14:13:42 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=qDWotR0ncNeFvNxtH6QkTP+TVoU=; b=CJc9Kk
	4ZTEtqPbGhaTsmqb3XjjysP7f4Moc95yRwI+4UxaK9J29mbZFN9jC8d3EzV+z/U0
	p3L+KUU3pnDk/OnlXwDcU1/hDC7SXZN6KWYO/MXbe0kdQFZSt18kIBy5CN0xazGd
	TDgWmK2BvIniumITz+1EIdbuQGQIpxOia9hLo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=umAolZ+lcToVTMvrBAAJQUqrV4KN+knk
	dweie56iYE3nyd9GiJW+I+B7pJM8+qfP5f1gkxmWHHLHDHwaoacM1jX6OC+9z160
	4Hf5B0MGyPOtrxP9a+YyQqUWfhVClmdrQGySiLN9URr0h0YmeF1etPEI2COV+kcb
	eyl3PEqI9BE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A5F882D850;
	Fri, 15 Jul 2016 14:13:42 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 237772D84F;
	Fri, 15 Jul 2016 14:13:42 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Jeff King <peff@peff.net>
Cc:	git@vger.kernel.org
Subject: Re: [PATCH 04/12] check_everything_connected: use a struct with named options
References: <20160715102506.GA23164@sigill.intra.peff.net>
	<20160715103039.GD19271@sigill.intra.peff.net>
Date:	Fri, 15 Jul 2016 11:13:40 -0700
In-Reply-To: <20160715103039.GD19271@sigill.intra.peff.net> (Jeff King's
	message of "Fri, 15 Jul 2016 06:30:40 -0400")
Message-ID: <xmqqfuran50r.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DC94A07C-4AB7-11E6-A26F-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> The number of variants of check_everything_connected has
> grown over the years, so that the "real" function takes
> several possibly-zero, possibly-NULL arguments. We hid the
> complexity behind some wrapper functions, but this doesn't
> scale well when we want to add new options.

I was kind of embarrassed to admit that I wasn't even aware that
things got this bad, so I took a look at the history to realize that
"grown over the years" above is a bit misleading statement.  It is
not like many people over the years were doing something like this.
There are only two commits that brought in this pattern with poor
design taste.

> Instead, let's add a struct to hold all of the optional
> parameters.
> ...
>  connected.c            | 39 +++++++++++----------------------------

Yup, that is absolutely the right thing to do.

Thanks.
