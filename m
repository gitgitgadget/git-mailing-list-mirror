Return-Path: <SRS0=K77S=55=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C96DC2BA2B
	for <git@archiver.kernel.org>; Mon, 13 Apr 2020 22:12:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C13E20739
	for <git@archiver.kernel.org>; Mon, 13 Apr 2020 22:12:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="xzuR+dXc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389481AbgDMWMH (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Apr 2020 18:12:07 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:55750 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727871AbgDMWMH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Apr 2020 18:12:07 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 75D42C39A4;
        Mon, 13 Apr 2020 18:12:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=mJTtlWJJBT8XspdbDLpibOFBSQs=; b=xzuR+d
        Xc7YsXGIAsMU8DExngv8KkFcsHFkvu/eqwOTOW5eoI/qDGHclyn7ql1DL8C/5/Ec
        tXOUAzHLTrIIfQoNO+Gp30NqPGJf57LZRx3b7yKnDAlqKvI6ffDIAge5NRUt+UAM
        N+j5ezlq3UOA81OwZJtImeJVFhLlzMeA30FWA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=kOEXdt7Rgczbcm6qMGzDGRJzTNwMhlM8
        l6upvsgeuHDRhsSeL9hISRcD2taMwIFJZxxhRZDDh8IHnPXzZ792gBMo++yjR5sD
        IR/jsWbIntAAkJ7verH73pIcBysquFbSQbttNazjA2G8eeoy6uR89F/X9Tbo/ogz
        vPrrIXfx42s=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 6E278C39A3;
        Mon, 13 Apr 2020 18:12:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id A0C76C399E;
        Mon, 13 Apr 2020 18:12:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, jnareb@gmail.com, garimasigit@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 2/3] commit: write commit-graph with bloom filters
References: <pull.609.git.1586566981.gitgitgadget@gmail.com>
        <bb5ce39d0283f14095d87dd0645e641ae799f16c.1586566981.git.gitgitgadget@gmail.com>
        <xmqqa73hheip.fsf@gitster.c.googlers.com>
        <20200412205148.GB50412@syl.local>
        <8ef47003-784d-6a27-666d-5c916c4deb33@gmail.com>
Date:   Mon, 13 Apr 2020 15:11:58 -0700
In-Reply-To: <8ef47003-784d-6a27-666d-5c916c4deb33@gmail.com> (Derrick
        Stolee's message of "Mon, 13 Apr 2020 08:08:50 -0400")
Message-ID: <xmqqtv1navdd.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CCDBE502-7DD3-11EA-A9C2-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> If we keep this simple, or extract the process to a
> "write_commit_graph_for_tests()" macro inside builtin.h, then we could
> insert a commit-graph write in more places.

As long as the check necessary is cheap enough to realize that we
are in production mode, we should be able to keep the run-time
overhead to the minimum.  Sprinkling such a call all over the place,
however, might add to the overhead of reading code, though.

> However, I think there is value in testing the "not every commit is
> included in the commit-graph" case, which our current setup does quite
> nicely.

Yeah, that is also a good point.

> The one exception is that 'git merge' could benefit from this
> snippet, so we cap off the commit-graph whenever a test script
> "constructs" a repository to match a data shape.

Sounds good.

> The problem here is that if GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS=1 and
> someone runs "git commit-graph write --no-changed-paths" then the
> negation of that option is ignored. But this is a GIT_TEST_* variable,
> and any test that requires that check could disable the enviroment
> variable first.

Yeah, that sounds good.
