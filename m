Return-Path: <SRS0=K77S=55=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A932AC2BB86
	for <git@archiver.kernel.org>; Mon, 13 Apr 2020 22:21:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F31C2072A
	for <git@archiver.kernel.org>; Mon, 13 Apr 2020 22:21:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="tIW208GU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389532AbgDMWVk (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Apr 2020 18:21:40 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57842 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389520AbgDMWVj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Apr 2020 18:21:39 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DBD0E628EB;
        Mon, 13 Apr 2020 18:21:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=IWebDcwEaePSFwRcGHMJS9QWyBs=; b=tIW208
        GUlxsGwGYWCe6d22TAThOTGzectjNypkJFL+WJomD3u587gcAxmcPJAzugHMyB8y
        489GXcgUnY1Rmv464LJlxaCcXWkVNAwEV9F7VZE6xgrjdhbYPBThdp2XmiRMP5lR
        JxLL66vbIjPHoYZOBlmo98K1b21jn+OLY3a2c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=p3r5qUskX9TGSriF3Nvi2UHcHbPv5fdO
        QDQhQ3l3lw+j4ZY3KvvO8JmlvJmFykDQRGi54L/6SkD+tVFdVkW9tKIiIeP996La
        FySy0mSc+ucnKGnoMvECP6FIN0J0jEoZW8t9YtSUCz2qjout607OHtPXLedGr94O
        cBl93zhTfKc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D3429628EA;
        Mon, 13 Apr 2020 18:21:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 508A1628E9;
        Mon, 13 Apr 2020 18:21:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, jnareb@gmail.com, garimasigit@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v2 2/4] commit: write commit-graph with Bloom filters
References: <pull.609.git.1586566981.gitgitgadget@gmail.com>
        <pull.609.v2.git.1586789126.gitgitgadget@gmail.com>
        <7e8f1aed1138ab2a52a8957ac95895ac9effd933.1586789126.git.gitgitgadget@gmail.com>
        <20200413161245.GE59601@syl.local>
Date:   Mon, 13 Apr 2020 15:21:35 -0700
In-Reply-To: <20200413161245.GE59601@syl.local> (Taylor Blau's message of
        "Mon, 13 Apr 2020 10:12:45 -0600")
Message-ID: <xmqqh7xnauxc.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 236403AE-7DD5-11EA-BDC2-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> Hmm. I'm not crazy about a library function looking at 'GIT_TEST_*'
> environment variables and potentially ignoring its arguments, but given
> the discussion we had in v1, I don't feel strongly enough to recommend
> that you change this.
>
> For what it's worth, I think that 'write_commit_graph' could behave more
> purely if callers checked 'GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS' and set
> 'flags' appropriately from the outside,...

Yeah, I agree that it would be a lot cleaner if that is easy to
arrange.  I have a suspicion that Derrick already tried and the
resulting code looked messier and was discarded?
