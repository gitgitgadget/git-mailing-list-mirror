Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CED44C433EF
	for <git@archiver.kernel.org>; Mon, 13 Sep 2021 00:46:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A85DD61027
	for <git@archiver.kernel.org>; Mon, 13 Sep 2021 00:46:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236196AbhIMArf (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 12 Sep 2021 20:47:35 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56160 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231303AbhIMArf (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Sep 2021 20:47:35 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C6511F667A;
        Sun, 12 Sep 2021 20:46:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Rs3Cef3XyTBEA2KayGNhDtur6AVFVbXZRUEKhU
        gLr9Y=; b=igixgoUU0IjM2RwNJahZ95CObGhn8P1xEd5AL0LfBc5Ih6+i9GDThX
        3h/ZWas63tz8CjMJHDaD0RNQGz0DBpvlTNzLWumShd5qGIrqkIroWq2ohObRfDcF
        O5XdIyD+ttjFsh5Z2aBDSoTneQfcGm2r5bR67+LQ+84FDYAVlDjho=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BDA2DF6679;
        Sun, 12 Sep 2021 20:46:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 477DDF6678;
        Sun, 12 Sep 2021 20:46:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, peff@peff.net
Subject: Re: [PATCH 4/4] t5326: test propagating hashcache values
References: <cover.1631049462.git.me@ttaylorr.com>
        <acf3ec60cb6f151a9f121d242f38fef6711cced4.1631049462.git.me@ttaylorr.com>
Date:   Sun, 12 Sep 2021 17:46:18 -0700
In-Reply-To: <acf3ec60cb6f151a9f121d242f38fef6711cced4.1631049462.git.me@ttaylorr.com>
        (Taylor Blau's message of "Tue, 7 Sep 2021 17:18:05 -0400")
Message-ID: <xmqqa6khi9ph.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 02677868-142C-11EC-84E1-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> Now that we both can propagate values from the hashcache, and respect
> the configuration to enable the hashcache at all, test that both of
> these function correctly by hardening their behavior with a test.

When we serve "git fetch" requests from a resulting repository,
because we have namehash available without traversing, we can serve
a packfile to the requestor, using the reachability bitmap to pick
objects that need to be sent, grouping the blobs with the same
namehash to be deltified against each other, resulting in a pack
that is better compressed than before?

What I am wondering is if we can come up with a "now, because we no
longer lose hashcache, we can do X so much better, here are the
numbers".

