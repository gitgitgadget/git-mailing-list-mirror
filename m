Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E5DE21F859
	for <e@80x24.org>; Tue, 16 Aug 2016 17:54:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751059AbcHPRyi (ORCPT <rfc822;e@80x24.org>);
	Tue, 16 Aug 2016 13:54:38 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58357 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750803AbcHPRyh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Aug 2016 13:54:37 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 1D32D34FAB;
	Tue, 16 Aug 2016 13:54:36 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=t7w39F2efiUx+Lst2KAfwlRnkD8=; b=WY9Icw
	KAwtSlRWHNj3YmFZylu/No7WQG2sECgySMM822tuSsLIC0EdgZo5UXD6s2N6DgWp
	opCQDf2Dg5+DwqzJ0Jh7ndHj+xzBifFX1lk98mCMjoLfD35Uybn/a3UnnV0eRc4z
	YFVNT5Eta/loBSb5hpM63wXAM2qnex9d2FiQs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=OZPwer4jWJO64u9u7vyvqgMW9SqjpFYE
	fjf18gWQkRZ59z93rMHUUjk5BvAJDS6YAEXPBVEoZpeDcxNJNy1e+VMJNhH9fO53
	w2usazljOkF23uSQ/J9KWMODiyk/ImJPgCD1OSiewFt7N2WdTyisvXhsLYVNvV8D
	KK+Eu6uFDzg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 165CA34FAA;
	Tue, 16 Aug 2016 13:54:36 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 964FF34FA8;
	Tue, 16 Aug 2016 13:54:35 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Jeff King <peff@peff.net>
Cc:	Stefan Beller <sbeller@google.com>, meta@public-inbox.org,
	"git\@vger.kernel.org" <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Eric Wong <e@80x24.org>
Subject: Re: Working with public-inbox.org [Was: [PATCH] rev-parse: respect core.hooksPath in --git-path]
References: <CAGZ79kasebzJb=b2n=JQiVMrSfJKaVfZaaoaVJFkXWuqKjfYKw@mail.gmail.com>
	<xmqqa8gcej1p.fsf@gitster.mtv.corp.google.com>
	<20160816172022.juqvfn5vwt2pdcyd@sigill.intra.peff.net>
Date:	Tue, 16 Aug 2016 10:54:33 -0700
In-Reply-To: <20160816172022.juqvfn5vwt2pdcyd@sigill.intra.peff.net> (Jeff
	King's message of "Tue, 16 Aug 2016 13:20:22 -0400")
Message-ID: <xmqqtwekd2g6.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7E6A2954-63DA-11E6-AB2F-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> For my workflow, it is not about "initial skip", but rather just "skip
> emails that don't have patches in them at all".

OK.  That is different from "the subject line says 0/N so let's
skip".

If we can safely determine that there is no patch in a message,
skipping it may feel sensible.  Historically, we try to err on the
safe side by stopping when we do not understand an input and that is
where "Patch is empty" message came from, because skipping and
continuing, even with a warning, while applying tons of patches is
not good enough to get user's attention.

An "ignore empty input" option (and eventually with a configuration)
may not be a bad idea.
