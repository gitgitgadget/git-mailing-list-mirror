Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E23431F40E
	for <e@80x24.org>; Mon, 14 Nov 2016 02:57:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934062AbcKNC5O (ORCPT <rfc822;e@80x24.org>);
        Sun, 13 Nov 2016 21:57:14 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62548 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932899AbcKNC5K (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 Nov 2016 21:57:10 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 33FD64F14E;
        Sun, 13 Nov 2016 21:57:09 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=1L7tXJ3f5ayBfSYjJKJE8Kc3Tf0=; b=laqt3m
        IHnCU+RBZMyc0yrjN0YCJHyTvxXtmCdrevNZ4lOrhwlDnCWrgcvAWxhp5/RoELC7
        hXMboYNhwYm4ZnDtdb/7u4YEArPhaRQJkADdM/FWgszVzfxadVcw8tJhz4ItHnMy
        EYnMeZMb9AhmKKbiEHQ7t17nzY0ACL9h2gCA8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=e9qgX1Bhx+rdoqcJ2zIWT6PlpH5gSDL0
        ZPOFcIo36DfNnj5kPoLwcc+gFKkez6u1ATZBylwa4l7DKJpNrAPoBG+JYP3o+ypR
        BGBcjQjBc7hEyrJTW6Z15vwzbjTbBscx7yfJpBZMhe7bYOB31fo4KiTIaBLZgxM7
        +evDoUGsGiQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2AC304F14D;
        Sun, 13 Nov 2016 21:57:09 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 92EB84F14C;
        Sun, 13 Nov 2016 21:57:08 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Matt McCutchen <matt@mattmccutchen.net>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH] fetch/push: document that private data can be leaked
References: <xmqqy416uvan.fsf@gitster.mtv.corp.google.com>
        <1479001205.3471.1.camel@mattmccutchen.net>
Date:   Sun, 13 Nov 2016 18:57:07 -0800
In-Reply-To: <1479001205.3471.1.camel@mattmccutchen.net> (Matt McCutchen's
        message of "Sat, 12 Nov 2016 20:25:55 -0500")
Message-ID: <xmqq1syezs3g.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0845E902-AA16-11E6-B556-987C12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Matt McCutchen <matt@mattmccutchen.net> writes:

>  Documentation/fetch-push-security.txt | 9 +++++++++

A new (consolidated) piece like this that can be included in
multiple places is a good idea.  I wonder if the original
description in "namespaces" thing can be moved here and then
"namespaces" page can be made to also borrow from this?

>  Documentation/git-fetch.txt           | 2 ++
>  Documentation/git-pull.txt            | 2 ++
>  Documentation/git-push.txt            | 2 ++
>  4 files changed, 15 insertions(+)
>  create mode 100644 Documentation/fetch-push-security.txt
>
> diff --git a/Documentation/fetch-push-security.txt b/Documentation/fetch-push-security.txt
> new file mode 100644
> index 0000000..00944ed
> --- /dev/null
> +++ b/Documentation/fetch-push-security.txt
> @@ -0,0 +1,9 @@
> +SECURITY
> +--------
> +The fetch and push protocols are not designed to prevent a malicious
> +server from stealing data from your repository that you did not intend to
> +share. The possible attacks are similar to the ones described in the
> +"SECURITY" section of linkgit:gitnamespaces[7]. If you have private data
> +that you need to protect from the server, keep it in a separate
> +repository.

Yup, and then "do not push to untrustworthy place without checking
what you are pushing", too?

> diff --git a/Documentation/git-fetch.txt b/Documentation/git-fetch.txt
> diff --git a/Documentation/git-pull.txt b/Documentation/git-pull.txt
> diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt

These three look sensible.
