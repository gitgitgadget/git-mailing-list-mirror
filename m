Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4AB021FE4E
	for <e@80x24.org>; Tue, 28 Jun 2016 05:20:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752059AbcF1FUo (ORCPT <rfc822;e@80x24.org>);
	Tue, 28 Jun 2016 01:20:44 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50135 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751065AbcF1FUn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jun 2016 01:20:43 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 3286A28E8C;
	Tue, 28 Jun 2016 01:20:42 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=su1rhKyVZ8Q7+flPT0MbCMjTmSw=; b=J+h7QV
	i2HhUx8ZH/AjeFLzeEMNMmWoVSH0o3puiaUuUQrg5gOGXD7u25ZSB1B25kRhsRZB
	vJJcc5s+BOVmPK39wIHUX1X15kTDrGjLNN1k2PSAMr9ySfzwok4XNSE7zyvrjFhS
	aZtW7+YvL7nqu0imCHsocqVgfjiDHb6hsp4qw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=iLt4jg2e+BiGkxzltQcjRUwb78TMmPQU
	251zY6RcSjv18xGOvzEAy3FSBU4PalB12o3fCWCZlaw+4txVWq3RWMPquetp9WJS
	qNW+fGbW6J57GtzemAukJr/zqRcelsu2l2rpmgFaaclu+ifuST0gFWrXgkvYvhLJ
	OIFnNks/jnM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 2A95228E8B;
	Tue, 28 Jun 2016 01:20:42 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 9293328E88;
	Tue, 28 Jun 2016 01:20:41 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Lukas Fleischer <lfleischer@lfos.de>
Cc:	"Jeff King" <peff@peff.net>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Git Mailing List" <git@vger.kernel.org>,
	"Nicolas Pitre" <nico@fluxnic.net>, "Johannes Sixt" <j6t@kdbg.org>
Subject: Re: [PATCH v2] Refactor recv_sideband()
References: <20160613195224.13398-1-lfleischer@lfos.de>
	<20160614210038.31465-1-lfleischer@lfos.de>
	<20160624153121.GA2494@sigill.intra.peff.net>
	<alpine.DEB.2.20.1606241942220.12947@virtualbox>
	<20160624181414.GA25768@sigill.intra.peff.net>
	<CAPc5daWxWpMe4ob4zu0tMK4uWpLPDxC7GS8KTb4+3g5=ztv71A@mail.gmail.com>
	<146702508453.24123.590646528169139972@s-8d3a37fa.on.site.uni-stuttgart.de>
	<xmqqr3bibpap.fsf@gitster.mtv.corp.google.com>
	<20160627161616.GA4430@sigill.intra.peff.net>
	<xmqqbn2mbjxm.fsf@gitster.mtv.corp.google.com>
	<146705966655.11886.6547584744094511110@typhoon>
Date:	Mon, 27 Jun 2016 22:20:39 -0700
In-Reply-To: <146705966655.11886.6547584744094511110@typhoon> (Lukas
	Fleischer's message of "Mon, 27 Jun 2016 22:34:27 +0200")
Message-ID: <xmqqy45panyw.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0EA365EC-3CF0-11E6-B5EC-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Lukas Fleischer <lfleischer@lfos.de> writes:

> I do not see how using fwrite() buys us anything. Neither fwrite() nor
> fputs() nor fprintf() guarantee to call write() only once.

That is not the point.

Your first attempt split what used to be a single fprintf(), which
(as Nico explained) ordinarily will result in an atomic write as
long as you are feeding a reasonable size buf, into two calls,
_guaranteeing_ that it will _not_ be atomic.  That was a bad change.

By accumulating things in strbuf (instead of char[] with hand-rolled
counting logic like the original before your patch) and feeding the
result out to a single fprintf(stderr, "%s", buf.buf), you will not
be making anything _worse_ compared to the code before your patch.
At the same time, you _are_ making the logic to accumulate the
output to a buffer far easier to read, which would be a net plus.

 
