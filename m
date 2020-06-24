Return-Path: <SRS0=BxWL=AF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06391C433DF
	for <git@archiver.kernel.org>; Wed, 24 Jun 2020 23:12:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC64A20738
	for <git@archiver.kernel.org>; Wed, 24 Jun 2020 23:12:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Iun21Nbq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728857AbgFXXLy (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Jun 2020 19:11:54 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59632 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728090AbgFXXLy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Jun 2020 19:11:54 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3031467A2B;
        Wed, 24 Jun 2020 19:11:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=3H/I9l+dDT0Mr2+RFcPTZat9bqY=; b=Iun21N
        bqFuaPPyq0nWvUuOa9EeAqbRXZFy0LKs9RWmkUxMFFbhoeffRuLIj4I+mud+1C5E
        p41Rh2hfnZLjy2+rdUpToF8HRMVxf+y1S4VKvn1C4A0gVNJSJjhPDjOuXZXDf/4q
        q1alSf+X4y5IwTngceLuCNxpTqqe09rubaoL8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=utXrQ8wRiv+TJnMg/tErfV1oFBZ0OMMT
        p/h/9ymxXA0H/mgj7X6J6hz2e8PNzHFmd0kZBXkgoSyViQnV1YFzdyzSQiwmgpT4
        I3fQrai6UgbRckAgUUrBOa+H9cUoNiKAN5/7TM8KB++l6Th2vHUVlvTjFg6dvyMb
        +s2rAgsvIRI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2770067A2A;
        Wed, 24 Jun 2020 19:11:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.231.104.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id AAB8767A29;
        Wed, 24 Jun 2020 19:11:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com, szeder.dev@gmail.com,
        l.s.r@web.de, Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v2 00/11] More commit-graph/Bloom filter improvements
References: <pull.659.git.1592252093.gitgitgadget@gmail.com>
        <pull.659.v2.git.1592934430.gitgitgadget@gmail.com>
Date:   Wed, 24 Jun 2020 16:11:51 -0700
In-Reply-To: <pull.659.v2.git.1592934430.gitgitgadget@gmail.com> (Derrick
        Stolee via GitGitGadget's message of "Tue, 23 Jun 2020 17:46:59
        +0000")
Message-ID: <xmqqftak5aa0.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 166EBDC8-B670-11EA-829B-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This does not seem to play well with what is in flight.  Tests seem
to pass with topics up to es/config-hooks merged but not with this
topic merged on top.

    1b5d3d8260 Merge branch 'ds/commit-graph-bloom-updates' into seen
    32169c595c Merge branch 'es/config-hooks' into seen
    ...

$ sh t4216-log-bloom.sh -i -v

ends like so:

ok 133 - Use Bloom filters if they exist in the latest but not all commit graphs in the chain.

expecting success of 4216.134 'persist filter settings':
        test_when_finished rm -rf .git/objects/info/commit-graph* &&
        GIT_TRACE2_EVENT="$(pwd)/trace2.txt" git commit-graph write --reachable --changed-paths &&
        grep "{\"hash_version\":1,\"num_hashes\":7,\"bits_per_entry\":10}" trace2.txt &&
        cp .git/objects/info/commit-graph commit-graph-before &&
        corrupt_graph $BASE_K_BYTE_OFFSET "\09" &&
        corrupt_graph $BASE_LEN_BYTE_OFFSET "\0F" &&
        cp .git/objects/info/commit-graph commit-graph-after &&
        test_commit c18 A/corrupt &&
        GIT_TRACE2_EVENT="$(pwd)/trace2.txt" git commit-graph write --reachable --changed-paths &&
        grep "{\"hash_version\":1,\"num_hashes\":57,\"bits_per_entry\":70}" trace2.txt

not ok 134 - persist filter settings
# ...

Thanks.
