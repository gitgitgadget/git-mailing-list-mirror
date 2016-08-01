Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6C2381F855
	for <e@80x24.org>; Mon,  1 Aug 2016 18:32:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754718AbcHASc1 (ORCPT <rfc822;e@80x24.org>);
	Mon, 1 Aug 2016 14:32:27 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54486 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754661AbcHASc0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Aug 2016 14:32:26 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1904032CEC;
	Mon,  1 Aug 2016 14:32:24 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=g8eJeBQXe/yza3ZlLPFi+gf5bVA=; b=SZyqKy
	X2NkOdjCnjT5eNOcN1/dvsGv2/lsrn4t+VgLu6Pyc7DnRrP/K7vaDC9dxL6BtO90
	oo64gTgMAW6/ADi8y0HdUt67MiHsnJg2DkW6H/9nAJ+sK5qEkzcMzljXLZOKPdwx
	ZF08OIJLo9ayjxeVdxblPAxXqkRdffbRWPwtk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=kFWnCzd+dnb/2J1RRFllShghLx3JpsCT
	cuBc+KuYmW+3zuHCE2UJIqVdverunDZlBLv1OQ8tJIfxlltQPqfrKJEqLszGkw+5
	5a1LM28NJuFvGclpvycOpoMo6ak26vV9cHtxK5OLft1iAlwWnWfelic0+kM+uUIG
	QKpOYZ+cJVk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1117E32CEB;
	Mon,  1 Aug 2016 14:32:24 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 833D632CE9;
	Mon,  1 Aug 2016 14:32:23 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:	git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
	Duy Nguyen <pclouds@gmail.com>,
	Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>
Subject: Re: [PATCH v5 16/16] merge-recursive: flush output buffer even when erroring out
References: <cover.1469187652.git.johannes.schindelin@gmx.de>
	<cover.1469547160.git.johannes.schindelin@gmx.de>
	<af195979d2c0cf9958b7811b4d2294deeea30b75.1469547160.git.johannes.schindelin@gmx.de>
	<xmqq4m7avi32.fsf@gitster.mtv.corp.google.com>
	<alpine.DEB.2.20.1608011141380.149069@virtualbox>
Date:	Mon, 01 Aug 2016 11:32:20 -0700
In-Reply-To: <alpine.DEB.2.20.1608011141380.149069@virtualbox> (Johannes
	Schindelin's message of "Mon, 1 Aug 2016 11:49:37 +0200 (CEST)")
Message-ID: <xmqqtwf4jq6j.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4A0A28E6-5816-11E6-BBBF-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> This is of course a good change, but we need to assume that no
>> further output is made from the remainder of the function for the
>> change in the next hunk to remove the existing flush to be correct.
> ...
> But you made me realize that I cannot simply *move* the flush_output()
> call here, in case that code in between will eventually add output.

Yup, that removal of the original one was the only thing I was
pointing out.


