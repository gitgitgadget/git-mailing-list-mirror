Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33121C433EF
	for <git@archiver.kernel.org>; Mon, 20 Sep 2021 02:25:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1165660F25
	for <git@archiver.kernel.org>; Mon, 20 Sep 2021 02:25:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234074AbhITCZJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 19 Sep 2021 22:25:09 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:62159 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234052AbhITCZI (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Sep 2021 22:25:08 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5E86E167704;
        Sun, 19 Sep 2021 22:23:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=F/SS/zxomCCAkCpcwLsTm2Nc7dGsUKgXTO08JR
        hYrQc=; b=BsajaAqMCJUMadyixOPMNF1ofg2cSIpyGZ9PLJjtL6XC0rXqyJzIKC
        MdComYyXkdp2VJR74Xqv7OEk8mlRhy0iH/lWLiZ5wUFwLv9afyRBPD2uwoW451lU
        NwGE5gmYOmVvL9CWmW18TON8BZye3CNgW1eAavNIJ7o++y6Ct38+s=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 588E6167703;
        Sun, 19 Sep 2021 22:23:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id BD8DD167702;
        Sun, 19 Sep 2021 22:23:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Aaron Gray <aaronngray.lists@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: git diff --git-ignore
References: <CANkmNDf5KVn7Afj9xtvMGC0Ua7G6O3EOjBRtAfBOKOnaYgqVXA@mail.gmail.com>
Date:   Sun, 19 Sep 2021 19:23:38 -0700
In-Reply-To: <CANkmNDf5KVn7Afj9xtvMGC0Ua7G6O3EOjBRtAfBOKOnaYgqVXA@mail.gmail.com>
        (Aaron Gray's message of "Mon, 20 Sep 2021 00:50:56 +0100")
Message-ID: <xmqq4kagdlxx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C47E6C1C-19B9-11EC-815D-98D80D944F46-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Aaron Gray <aaronngray.lists@gmail.com> writes:

> Is it possible to add a --git-ignore flag to git diff so I only see
> the diffs for what I really want to be looking at, and not what I
> don't ;)

How does your --git-ignore option exactly guess differences for
which paths to show and which paths to exclude?  How do you tell the
"git diff --git-ignore" command which paths are what you really want
to be looking at?

If it is by magic, good luck writing such a feature ;-)

If it is like "I only am interested in changes in src/ directory and
the top-level Makefile", then perhaps using pathspec is what you
want.  E.g.

    $ git diff -- src/ Makefile
    $ git diff --cached -- src/ Makefile
    $ git diff master topic -- src/ Makefile
    $ git diff master...topic -- src/ Makefile

Modern Git even allows you to include negative elements to the
pathspec, e.g.

    $ git diff src/ ':(exclude)*.h'

would tell us "show only changes in the src/ directory, but do not
bother with changes to the dot-h files".

HTH
