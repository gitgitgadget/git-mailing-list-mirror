Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3354320196
	for <e@80x24.org>; Thu, 14 Jul 2016 19:10:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751278AbcGNTK0 (ORCPT <rfc822;e@80x24.org>);
	Thu, 14 Jul 2016 15:10:26 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60041 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751161AbcGNTKY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jul 2016 15:10:24 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 21ECB2BFB6;
	Thu, 14 Jul 2016 15:10:23 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=D7UKdUEEgsFHg6GY6ME2nrWngeU=; b=tqF/Su
	LM3KpcSOCAVsSzhwDtXr4sUWFZ4q5WKcURh8wO1RcWAfsU1pkS/tu4kZFG3nCq7x
	OKtthqi5Zd5S3984smoUBNdO/MkJWBZTWfWHB1dz9fc7W5mvkMF4l3Fu1bOfFzeV
	eYx1cDZ4LlCgkwFomvuiW+iOEgrStLQQr/xfw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Njm78VqMb2vx35RxqvxO6W5rn8oq3Gij
	xEX+kcoHFF4NYTM9/pm3xELvT/VS6sw0QVNT794JrWsQkfgMCva2jww39IeBYIsW
	+P9wwjXN+/4FLlV/DKlc70k63G6GLzyJPN4/jLgSnXGblDiufS/r1ZPtey7kJrMv
	9ZvLQzO1I/c=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 19E692BFB4;
	Thu, 14 Jul 2016 15:10:23 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 931C32BFB3;
	Thu, 14 Jul 2016 15:10:22 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Thorsten Glaser <t.glaser@tarent.de>
Cc:	git@vger.kernel.org
Subject: Re: Server-side preventing some files from being overwritten
References: <alpine.DEB.2.20.1607141725390.25238@tglase.lan.tarent.de>
	<CAGZ79kb=2rpYucjhavNB_XHLk9rjKSoHzL9bwM5buDO0GyW3vw@mail.gmail.com>
	<alpine.DEB.2.20.1607141948530.25238@tglase.lan.tarent.de>
	<xmqqpoqgqdlz.fsf@gitster.mtv.corp.google.com>
	<alpine.DEB.2.20.1607142049240.25238@tglase.lan.tarent.de>
Date:	Thu, 14 Jul 2016 12:10:20 -0700
In-Reply-To: <alpine.DEB.2.20.1607142049240.25238@tglase.lan.tarent.de>
	(Thorsten Glaser's message of "Thu, 14 Jul 2016 20:50:24 +0200
	(CEST)")
Message-ID: <xmqqbn20qbmr.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9CFF6DFA-49F6-11E6-9D19-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Thorsten Glaser <t.glaser@tarent.de> writes:

> On Thu, 14 Jul 2016, Junio C Hamano wrote:
>
>> Can't this become simpler, e.g.
>> 
>> 	if ! git diff-tree --quiet "$old" "$new" -- "$subdir"
>
> Thought about diff-tree, but additions are permitted,

	diff-tree -r --diff-filter=a "$old" "$new" -- "$subdir" 

or something like that?

> and diffing the actual file content has overhead too.

It is why exactly "diff-tree" is desired here, as you do not have to
diff actual file at all.
