Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 80B9E2022A
	for <e@80x24.org>; Tue, 16 Aug 2016 17:10:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753439AbcHPRKr (ORCPT <rfc822;e@80x24.org>);
	Tue, 16 Aug 2016 13:10:47 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53862 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751584AbcHPRKq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Aug 2016 13:10:46 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 643B4356F9;
	Tue, 16 Aug 2016 13:10:45 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=SA4w9VFCJEol6s/wHFyu1+RJd7U=; b=dUqNar
	3Bm4bW1kBavZ+JEg9VgyKwA6LBrsChSJnCceWfSiM84theKqODNXlrEnLpUhPBxl
	2H2D2FgdQK61mdbck4hDyDXNX/ABH5etlC6v8n3hmC+rjoI6HJQupoQTVimjJReP
	vSFmMYN8X9ueN17/QQadv98e5wVqvBTO1eK3E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wRgb8va/ulMmbRu1pHYtVHYaX+ZoqP79
	CVDtDIJ6RAC3L5XrqSxrIgb4aRC4CwLrNDiRml5D4OHdPD7jXIGodC00rBmBjykv
	b5Uo0uFTVCwSEIdlYvTSzDLvczqJbhV7MD+j4+ZFdyJcsQisBJqF20wvxTWm3F8P
	YHmMbwOJfyQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5B739356F7;
	Tue, 16 Aug 2016 13:10:45 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id DA0EC356F6;
	Tue, 16 Aug 2016 13:10:44 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Stefan Beller <sbeller@google.com>
Cc:	meta@public-inbox.org,
	"git\@vger.kernel.org" <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Eric Wong <e@80x24.org>
Subject: Re: Working with public-inbox.org [Was: [PATCH] rev-parse: respect core.hooksPath in --git-path]
References: <CAGZ79kasebzJb=b2n=JQiVMrSfJKaVfZaaoaVJFkXWuqKjfYKw@mail.gmail.com>
Date:	Tue, 16 Aug 2016 10:10:42 -0700
In-Reply-To: <CAGZ79kasebzJb=b2n=JQiVMrSfJKaVfZaaoaVJFkXWuqKjfYKw@mail.gmail.com>
	(Stefan Beller's message of "Tue, 16 Aug 2016 09:55:38 -0700")
Message-ID: <xmqqa8gcej1p.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5E620DC6-63D4-11E6-97A3-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> So as a discussion starter:
> * Should git am skip a patch 00/XX automatically ?

No.  My preference is to add "--initial-skip=<N>", though.

When I receive a patch series to reroll another series, I somehow
know and verify that earlier N patches have not changed, I detach
the HEAD at the last unchanged commit from the previous round and
apply the remainder of the new series, so that I can preserve the
author timestamps of earlier steps from the previous series.  By
the time I "know and verify" where the first step that was updated,
I have a full series in a single mbox; having "--initial-skip=<N>"
would help with that use case, too, and "skipping the first" is a
narrow special case of giving N=1.

> * Should the public-inbox offer another link to patches 1-n, without
>   the cover letter? Or should it add instructions:
>
>         If this is a patch series you can apply it locally as:
>         curl <link> >tmpXXX
>         git am tmpXXX && git am --skip && git am --continue

I do not think it is sensible for "cover-letter" specific
instructions.  However, I do not think it is unreasonable to either
add another mbox.gz link or replace the behaviour of mbox.gz link so
that you can grab a mbox that contains "this message and everything
after it in the thread".  That way, I could open the first message,
see something like this I found in your message:

>> Thread overview: 4+ messages in thread (expand / mbox.gz / Atom feed / [top])
>> 2016-08-15 23:06 Jacob Keller [this message]
>> 2016-08-15 23:07 ` [PATCH v6 1/3] diff.c: remove output_prefix_length field Jacob Keller
>> 2016-08-15 23:07 ` [PATCH v6 2/3] graph: add support for --line-prefix on all graph-aware output Jacob Keller
>> 2016-08-15 23:07 ` [PATCH v6 3/3] diff: add SUBMODULE_DIFF format to display submodule diff Jacob Keller

and then go to 1/3 and click that "this and everything that
follows".
