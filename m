Return-Path: <SRS0=ga/5=CR=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FF38C43461
	for <git@archiver.kernel.org>; Tue,  8 Sep 2020 01:13:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB4BA208C7
	for <git@archiver.kernel.org>; Tue,  8 Sep 2020 01:13:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="jbGTaJO9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728264AbgIHBNq (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Sep 2020 21:13:46 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:52263 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728056AbgIHBNp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Sep 2020 21:13:45 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B646EE6E24;
        Mon,  7 Sep 2020 21:13:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Ls/YN5srAbBQHTF6ccCOH+BR+Gc=; b=jbGTaJ
        O91kSqKNP0oBSp8pvGm7KZfmqx8fFAIhEf/wZ8EjZw8oNTNcsCko8+MIFIaBhwJa
        c8veN82lJigV7gyRTPNE01JyILWTbWxlt3UXw2eTgMo/u/sPtkciZIBoK5Mhn/oF
        nFvEubZHgM43uZPMn1Ku0x5RzUWvlMhn22UZs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Y5+D7JOA/CWBAe5AzmTnWvtrJYsqW2je
        LhLC6XVWbn+HEWF4hx8Iel6CrzAWD75HGBwgMyrMmKg9rcR90fZf15LUTZWgX0U+
        GbVrNIrl8hZjc6S1QozVYyJDbRDXMMZRVE4wwawubRKGV/cMQOYexjJ8FZHxYFXF
        GV0KZnwVMAU=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id AFD38E6E23;
        Mon,  7 Sep 2020 21:13:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id EC75AE6E22;
        Mon,  7 Sep 2020 21:13:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Patrick Fong <patrickf3139@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [Bug report] git status doesn't escape paths of untracked files
References: <CAMRL+qb0YC1EOTM-LDfMpJ=AJJ014LT5ufBcs0v77byN74A0vw@mail.gmail.com>
Date:   Mon, 07 Sep 2020 18:13:39 -0700
In-Reply-To: <CAMRL+qb0YC1EOTM-LDfMpJ=AJJ014LT5ufBcs0v77byN74A0vw@mail.gmail.com>
        (Patrick Fong's message of "Mon, 7 Sep 2020 17:28:57 -0700")
Message-ID: <xmqqa6y1135o.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 88139558-F170-11EA-8F05-843F439F7C89-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Patrick Fong <patrickf3139@gmail.com> writes:

> What did you do before the bug happened? (Steps to reproduce your issue)
> touch "this is escaped"
> touch "this is not escaped"
> git add "this is escaped"
> git status --short
>
> What did you expect to happen? (Expected behavior)
> I expected that git status --short would string escape both "this is
> escaped" and "this is not escaped" since they both contain spaces that
> need escaping.
>
> What happened instead? (Actual behavior)
> git status did not string escape "this is not escaped" but it does if
> you add it to the index.

It indeed is a disturbing inconsistency, and the code that shows the
untracked paths should be fixed.  I wonder what is done to ignored
paths when the "--ignored" option is given.

wt-status.c::wt_shortstatus_status() has a strange special case that
says "whitespace alone does not usually deserve quoting, but we
special case it and manually quote"; this discrepancy/special casing
was introduced at dbfdc625 (status: Quote paths with spaces in short
format, 2010-11-08).  A fix would probably be to port the same fix
to wt-status.c::wt_shortstatus_other().

In the longer term, quote.c::quote_path() may want to learn an
optional flag to tell it to do the the special casing.

Thanks.  
