Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2AC2020193
	for <e@80x24.org>; Thu,  4 Aug 2016 18:09:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965139AbcHDSJx (ORCPT <rfc822;e@80x24.org>);
	Thu, 4 Aug 2016 14:09:53 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62943 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932505AbcHDSJw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Aug 2016 14:09:52 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id C7B743235E;
	Thu,  4 Aug 2016 14:09:50 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Frgs2ghhLsai4t2LWMVbGlQFwn4=; b=YcxUUV
	PhpOQTa7Kdf+JAffitF6HxAHjgUyuKLatltc5saOpiQai1Ih7P9QAY0vvQEwMuYQ
	JJFA0F35COxGlaVOWVUyPvsWG5HjvxSsSiUx6gwQs+cKvjq2tXi75WEnsb/gQlU4
	HhDXB5B0q5f8UYVL9+e400wSWolbVzpBK0X+8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=K06IaV9sWtMeXBQHJFAbZzw/i40ABzy2
	PhvjMxubK6jSUghgK/oDCgu+HOBai9LKBBYZfPiVWAw/INQivCAv5H4RfdE27tkG
	RJmkZPB5amxMsS/rOl0m2B0DZ4O2TjM0qczV8u/M0rDi7kCcbBevbZgNOdYK4pxC
	5hfgt4hooas=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id C01553235D;
	Thu,  4 Aug 2016 14:09:50 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 496713235B;
	Thu,  4 Aug 2016 14:09:50 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:	git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
	Duy Nguyen <pclouds@gmail.com>,
	Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>
Subject: Re: [PATCH v6 07/16] merge-recursive: avoid returning a wholesale struct
References: <cover.1469547160.git.johannes.schindelin@gmx.de>
	<cover.1470051326.git.johannes.schindelin@gmx.de>
	<4cbe2757bd921a202c359382086fadeb2616434a.1470051326.git.johannes.schindelin@gmx.de>
Date:	Thu, 04 Aug 2016 11:09:48 -0700
In-Reply-To: <4cbe2757bd921a202c359382086fadeb2616434a.1470051326.git.johannes.schindelin@gmx.de>
	(Johannes Schindelin's message of "Mon, 1 Aug 2016 13:44:17 +0200
	(CEST)")
Message-ID: <xmqqk2fw4d8z.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A2A70938-5A6E-11E6-AB52-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> It is technically allowed, as per C89, for functions' return type to
> be complete structs (i.e. *not* just pointers to structs).
>
> However, it was just an oversight of this developer when converting
> Python code to C code in 6d297f8 (Status update on merge-recursive in
> C, 2006-07-08) which introduced such a return type.
>
> Besides, by converting this construct to pass in the struct, we can now
> start returning a value that can indicate errors in future patches. This
> will help the current effort to libify merge-recursive.c.

I do not think returning a small struct by value is unconditionally
a bad thing, but I do agree with you that this change makes the 
resulting code much easier to read, especially once this starts
returning errors.

Good.

