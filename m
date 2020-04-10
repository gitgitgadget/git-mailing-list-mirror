Return-Path: <SRS0=1KXq=52=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BA2BC2D0EC
	for <git@archiver.kernel.org>; Fri, 10 Apr 2020 17:45:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6CFD2082D
	for <git@archiver.kernel.org>; Fri, 10 Apr 2020 17:45:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="mSb2Rd6F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726682AbgDJRpD (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Apr 2020 13:45:03 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59339 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726177AbgDJRpC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Apr 2020 13:45:02 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D0B8D486EC;
        Fri, 10 Apr 2020 13:45:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=319Nix7g/M/wCUZWFkE7qsi1by0=; b=mSb2Rd
        6F8qnYH/qXihX0E5R+pRpzNYP0vgjk9fYtoBvclj/yIh1T2ov7uc/4kBEZbeFAP/
        riy1PC7qP21TwPTeZD1Dk3R7uFjhfVkpVtRyxJIYkFqYYwEgN+9DuJbOWbb/uZ7k
        6eScSkvRbNxpYTZN7rrhbZqWkr4tvphIWVakA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=QFH/O9THsXmpqq3r7Y9K+0Id9+PVRRou
        87wmdxJH+ZmVsNjp455fQ8DX1S//4TOCQ4ahR+qoRKGjNlA3AzUGuLVq0M/5Q0yx
        Ks2NDhghKJE99dgKsmEfA3249G+SrBVFg+yPGLX3Gkw/onD91I3FpWo8r8wowQzJ
        Py03Qs4HC+s=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8390B486EB;
        Fri, 10 Apr 2020 13:45:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id BD817486EA;
        Fri, 10 Apr 2020 13:44:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 1/2] Refactor code asking the user for input interactively
References: <pull.755.git.git.1586374380709.gitgitgadget@gmail.com>
        <pull.755.v2.git.git.1586518072.gitgitgadget@gmail.com>
        <9d2ee78a9e414c0b6aacbc9c878ab08eb70703d5.1586518072.git.gitgitgadget@gmail.com>
Date:   Fri, 10 Apr 2020 10:44:59 -0700
In-Reply-To: <9d2ee78a9e414c0b6aacbc9c878ab08eb70703d5.1586518072.git.gitgitgadget@gmail.com>
        (Johannes Schindelin via GitGitGadget's message of "Fri, 10 Apr 2020
        11:27:50 +0000")
Message-ID: <xmqqftdbjkv8.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FFD5A610-7B52-11EA-8377-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> -		if (strbuf_getline(&input, stdin) == EOF) {
> +		if (git_read_line_interactively(&input) == EOF) {

It's not like we are mimicking or giving a thin wrapper to improve
an existing read_line_interactively() from a third-party, so I do
not see much point in giving "git_" prefix here.  On the other hand,
"strbuf_" prefix may not hurt (but the type of its first parameter
is sufficient so it is not exactly required).

>  			printf(_("Remove %s [y/N]? "), qname);
> -			if (strbuf_getline_lf(&confirm, stdin) != EOF) {
> -				strbuf_trim(&confirm);
> -			} else {
> +			if (git_read_line_interactively(&confirm) == EOF) {
>  				putchar('\n');
>  				eof = 1;

A fat-finger that gave an answer " yes <RET>" used to be still taken
as a yes but now it is interpreted as "no", because the new helper
trims a lot less.  In general, the existing code should be already
choosing the safer default, so such a change in behaviour brought in
by this change, even if they were not intentional, should probably
be safe.

Thanks.
