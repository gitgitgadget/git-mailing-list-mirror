Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A709C1F45F
	for <e@80x24.org>; Thu,  9 May 2019 07:29:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726604AbfEIH3W (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 May 2019 03:29:22 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:56424 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726597AbfEIH3W (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 May 2019 03:29:22 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 2340955DB6;
        Thu,  9 May 2019 03:29:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=+u7qsJewLhK32FoWDNZuA1wbj8E=; b=FNc2Qk
        HiVDQDd4K1iwQEgdA74uPKWhXi7I9SNEzm4wviqlmshuZJQzQcBGcz7T3+95hwcT
        I/hc0OPUXYyFv44WQjw0wRBjTKYXROex5c/EXzaEFmeS/QdifYUi6LvrBjuLRgi5
        QgN1aJ41gMrwHFeHswnDUIQGnsF+Ej9Z5mktA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=gEs5VVJM2tFD22y3eIT81c41adlEl8Dg
        PWSTpWVi5IBeK4ivv57tY5g0aKZWAgT1NNIFZJndNijl9NxFS/xb/L99Oa+hX18c
        CqBFW4/2dv7oUSHVm8m16r3EVSoYlXJ7pA0hnJUJLJJHormLwQ8FLVAWnuSDo6ER
        xxOogPJeMXI=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 1B90555DB4;
        Thu,  9 May 2019 03:29:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.255.141])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 4DE2155DB2;
        Thu,  9 May 2019 03:29:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/1] difftool: --no-index is incompatible with --dir-diff
References: <pull.186.git.gitgitgadget@gmail.com>
Date:   Thu, 09 May 2019 16:29:15 +0900
In-Reply-To: <pull.186.git.gitgitgadget@gmail.com> (Johannes Schindelin via
        GitGitGadget's message of "Wed, 08 May 2019 14:52:40 -0700 (PDT)")
Message-ID: <xmqqv9ykdr1w.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2733D0E6-722C-11E9-96BA-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> ... it does not even make sense to combine those two options. The 
> --dir-diff option exists to enable diff'ing subdirectories of a worktree
> while pretending that untracked and ignored files in them do not even exist.

Hmph.  So there is no point in using the dir-diff mode when you have
say two extracts of pristine tarballs?

I guess that's true.

The difftool will launch an external "directory diff tool" on two
directories populated with the two "things" (be it "the contents
from a tree-ish", "the working tree files", "the contents in the
index") in the end, but you already have two directories to be
compared when you run "diff --no-index", so there is no point in
going through the "difftool" middleman.  You can just feed the two
directories you have directly to that external directory diff tool.

> base-commit: 20de316e33446f37200e51aa333ba7d824dfd478
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-186%2Fdscho%2Fdifftool-no-index-extra-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-186/dscho/difftool-no-index-extra-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/186
