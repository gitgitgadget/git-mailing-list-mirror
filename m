Return-Path: <SRS0=90au=Z7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44E7CC43603
	for <git@archiver.kernel.org>; Mon,  9 Dec 2019 21:25:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D258D2071E
	for <git@archiver.kernel.org>; Mon,  9 Dec 2019 21:25:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="FAVopggz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726677AbfLIVZU (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Dec 2019 16:25:20 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51281 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726354AbfLIVZU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Dec 2019 16:25:20 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 63515224EB;
        Mon,  9 Dec 2019 16:25:18 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Dmp64h9e8gbJsyCgN9flEiEbLDg=; b=FAVopg
        gzV3itHYo5z0fDaJHTg4u0NTlPJcjTUehuxQ7DjH5cN38yOeFsWzFMOpTImtJtLQ
        7u/Svp8FF9Pf23a46XEF89ecVCrpiaCY7aiioFnti8BB0ZMenKSsJ/kXvLeB1FDD
        oVF90DyOVnUl1y2OLfgpLZpGQ80Gk3VE+V0GI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=IATipY9n2DD9juGrjqEHXxc1bcEFoua4
        AamaJTS/I3tk5M0QfJZcLabbXEJSno5hbYp7XW5184wqkvj3JzzaxrTRY3ulc5YF
        gq/9wHwbQfvNc+uFxs9b+lj6BNQBVqxD5cOykCqf0AYXqeEdc6NU6RIdxpyfSkEi
        u5breQBy+eU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 582D2224EA;
        Mon,  9 Dec 2019 16:25:18 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 472BF224E6;
        Mon,  9 Dec 2019 16:25:17 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Pratyush Yadav <me@yadavpratyush.com>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>,
        =?utf-8?B?5Yqg6Jek5LiA?= =?utf-8?B?5Y2a?= <kato-k@ksysllc.co.jp>,
        Jonathan Gilbert <JonathanG@iQmetrix.com>
Subject: Re: [PATCH] git gui: fix branch name encoding error on git gui
References: <20191207002842.32208-1-kato-k@ksysllc.co.jp>
        <xmqqpngxux78.fsf@gitster-ct.c.googlers.com>
        <20191209210942.gcyp6ch7zingkhfs@yadavpratyush.com>
Date:   Mon, 09 Dec 2019 13:25:16 -0800
In-Reply-To: <20191209210942.gcyp6ch7zingkhfs@yadavpratyush.com> (Pratyush
        Yadav's message of "Tue, 10 Dec 2019 02:39:42 +0530")
Message-ID: <xmqqr21dtcn7.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 65476F0E-1ACA-11EA-9D5B-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Pratyush Yadav <me@yadavpratyush.com> writes:

> My position is that we should default to UTF-8 given its popularity (at 
> least in the Git world), but I'm wondering whether we should also add a 
> config variable to allow users to configure their encodings.
>
> If you don't mind, your thoughts on this would be appreciated :)
>
> [0] https://github.com/prati0100/git-gui/pull/21

Quite honestly, as long as we can keep the core part to stay
"pathnames and refnames are just runs of bytes, terminated by NUL,
and no other interpretation is necessary", I do not think I care too
deeply if the UI layers (either GUI or Porcelain) become a bit more
restrictive.

But that is just my gut feeling.


