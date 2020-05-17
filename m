Return-Path: <SRS0=BhVQ=67=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36B36C433E0
	for <git@archiver.kernel.org>; Sun, 17 May 2020 15:31:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 112FA207BB
	for <git@archiver.kernel.org>; Sun, 17 May 2020 15:31:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="BfHjmLv+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728084AbgEQPbJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 17 May 2020 11:31:09 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:60003 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728063AbgEQPbI (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 May 2020 11:31:08 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 72F57DBC89;
        Sun, 17 May 2020 11:31:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=s8EJcx3/BuSuMBELtz4VpM3kg+E=; b=BfHjmL
        v+uGMl+d9/qtxHiuxERYfRgtnWSBrUKP63IQg7KVVH1QGnPoKS/b244nXSvxdgDf
        xSAsYOYf0GRmYN5QXuLJwo8eKDtniVkkL8uQDouuFhWjV7tXCdGGHROo6oGxrkOo
        HIZCrMcNfoB05LHEnmruThi92lGMmBxFcd7RQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=n5wbctEx37PwLY2ISKDIKXvAa8I2Rjtu
        B6P4tRwNDO6nQjAQpa2zGVExerYsrqEO5/y6xgBJJAwr8vWeXZeJ92Zi9DvpUtzc
        pGIQWaU239Zbj6rctNr6BUjQdTRtj7irt6sAKPog2ioeWEPH1AbMF2V8qbzmdtHt
        ekw4x/OYPjA=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 6BC9ADBC88;
        Sun, 17 May 2020 11:31:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 26475DBC87;
        Sun, 17 May 2020 11:31:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kenneth Lorber <keni@hers.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC PATCH 3/6] Add namespace collision avoidance guidelines file
References: <1589681624-36969-1-git-send-email-keni@hers.com>
        <1589681624-36969-4-git-send-email-keni@hers.com>
Date:   Sun, 17 May 2020 08:31:00 -0700
In-Reply-To: <1589681624-36969-4-git-send-email-keni@hers.com> (Kenneth
        Lorber's message of "Sat, 16 May 2020 22:13:41 -0400")
Message-ID: <xmqqh7we7f4b.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6A520E08-9853-11EA-AB64-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kenneth Lorber <keni@hers.com> writes:

> From: Kenneth Lorber <keni@his.com>
>
> Add a file of guidelines to prevent the namespace collisions
> mentioned in git help config without any guidance.

Collisions with whom are you worried about?

Random $stuff the end users want to have the namespace that governs
$stuff (where $stuff could be an environment variable, a file on the
filesystem, refname in git, etc.)?

Random $stuff third-party tools want to add?

As far as git is concerned, all the files under $GIT_DIR are
blackbox and off-limits from end users and third-party tools, so
there is no collisions in "a file on the filesystem", but creating a
ref may result in a creation of a file in $GIT_DIR/, and carving out
a part of refs/* hierarchy for use by a third-party tool is a
worthwhile goal.  Just like "git bisect" uses refs/bisect/* for its
own operation and wants to reserve the hierarchy from other tools
and the end users, any third-party tool would want a similar
carve-out.  The same for configuration variables.

HOWEVER

I would rather not to see an arbitrary set of rules that are not
battle-tested in the field added to our documentation.

Instead, my preference is to add a document that describes what
namespaces (e.g. environment variable, reference, configuration
varable) third-party tools may want carving out for themselves to
raise awareness of writers of such tools, and tell them to talk to
us on the list, saying "I plan to write a tool that wants to reserve
refs/frotz/ hierarchy for its own use---comments?", so that people
can respond with "I know a tool that already uses that hierarchy, so
you'd need to come up with a different one" to save hassles of
having to rename before it happens.

After gaining experience from such exchanges, we might come up a set
of rules so that no collisions would be possible without any
coordination, and then we could document those rules.  

I do not think that is plausible to happen, but that is OK.
