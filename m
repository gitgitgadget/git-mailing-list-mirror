Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D626920193
	for <e@80x24.org>; Thu,  4 Aug 2016 16:16:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758845AbcHDQQJ (ORCPT <rfc822;e@80x24.org>);
	Thu, 4 Aug 2016 12:16:09 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51822 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758721AbcHDQQH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Aug 2016 12:16:07 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 5EBDA31106;
	Thu,  4 Aug 2016 12:16:06 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=22W2IZsKRwo9irkIbNbbfixPLaw=; b=lOF2BL
	qnQSv+NOGa5f3/4HOVWojjudQ/Ej1rlWfqG5mekFbCPU2WdrTIwgoBf1hULNUKA7
	iuK+NzFrEe/0hMUek5sK4h2BYeF4RskJzc0zIq1KMeeSYqt8tnaDgs4I3OUgwFOQ
	b28MPmRat4C6l5+viBZFxDo7+Zx1oO9AGYFw0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gnnNaEV30Wg54uY7nq+5CpV0olWXoq09
	JTf8f3pO2IbfOUKMc1nbJd43eDr0Ku6NmeNbt2FCjmsMl0JmuI71S/Xq5G0tdAYe
	wUyqSwt5JUSznK3aNzRd66MVFmftoWjZdav7+b2RFiZrNR1ilut/wSzP1/980uGp
	5pbPzpB6zQc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 56F7231105;
	Thu,  4 Aug 2016 12:16:06 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D077031103;
	Thu,  4 Aug 2016 12:16:05 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Jeff King <peff@peff.net>
Cc:	larsxschneider@gmail.com, git@vger.kernel.org, jnareb@gmail.com,
	tboegi@web.de, mlbright@gmail.com, e@80x24.org
Subject: Re: [PATCH v4 03/12] pkt-line: add packet_flush_gentle()
References: <20160729233801.82844-1-larsxschneider@gmail.com>
	<20160803164225.46355-1-larsxschneider@gmail.com>
	<20160803164225.46355-4-larsxschneider@gmail.com>
	<20160803213920.jg3eshy57bsldqjh@sigill.intra.peff.net>
Date:	Thu, 04 Aug 2016 09:16:03 -0700
In-Reply-To: <20160803213920.jg3eshy57bsldqjh@sigill.intra.peff.net> (Jeff
	King's message of "Wed, 3 Aug 2016 17:39:20 -0400")
Message-ID: <xmqqa8gs5x30.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BF00D75E-5A5E-11E6-9773-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>   2. It calls check_pipe(), which will turn EPIPE into death-by-SIGPIPE
>      (in case you had for some reason ignored SIGPIPE).
> ...
>
> Thinking about (2), I'd go so far as to say that the trace actually
> should just be using:
>
>   if (write_in_full(...) < 0)
> 	warning("unable to write trace to ...: %s", strerror(errno));
>
> and we should get rid of write_or_whine_pipe entirely.

I like the simplicity the above suggestion gives us.

