Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B215DC433E6
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 19:58:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7CC4D23433
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 19:58:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726985AbhAGT6T (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Jan 2021 14:58:19 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:61850 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726064AbhAGT6T (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jan 2021 14:58:19 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 0C7E511D738;
        Thu,  7 Jan 2021 14:57:36 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=t9RCUbM4+iACg8scKZbCy6bvz3U=; b=MkNS3b
        IGYKbpI217EFqkupGYiO+oJEdLGUmq7YPrEPoeZPr+1s2rj74EgsvcsmYy3TGdYf
        cztYJXk8SAZvqLrBAcAHnflPCjHi80t3VdOOlQ/aMU6/iyBuNnn26f+BD6Gm4xAV
        XCXXv7z91Sq42aJtwNFXcihawolv/l24FzbEQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=E4Oso2WetOmxSU2fIShIYycJaB5wY8xi
        vV8ORsoT5re6/bLCdJDQBJ6a5Z1815dbrAT8BH3yPCDlR5rZFUuf89Vs0T2RLGSZ
        eCuZk8IC2aRehVjJrDOa+4qwuwH7SzwC15LaIzyu0VfvhPkU5FV1+rKNNNW+iE/1
        HaIJmUf1zYk=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 0483611D737;
        Thu,  7 Jan 2021 14:57:36 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 1697111D736;
        Thu,  7 Jan 2021 14:57:33 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v2 14/14] update-index: remove static globals from
 callbacks
References: <pull.830.git.1609506428.gitgitgadget@gmail.com>
        <pull.830.v2.git.1609821783.gitgitgadget@gmail.com>
        <2b171a142b36b114d5ff526073fe3fd9517a4d32.1609821783.git.gitgitgadget@gmail.com>
        <CAPig+cTfHsd7WMvcX1_433WVOG+y4FceUACBx_4UfnjJTgVY6g@mail.gmail.com>
        <73f51832-583a-27e8-65fa-86eb0ebac4cf@gmail.com>
        <CAPig+cSLsLibDik3YYTPdwbHpywStMxR_4rRBZfYrX7S-cFnNA@mail.gmail.com>
Date:   Thu, 07 Jan 2021 11:57:31 -0800
In-Reply-To: <CAPig+cSLsLibDik3YYTPdwbHpywStMxR_4rRBZfYrX7S-cFnNA@mail.gmail.com>
        (Eric Sunshine's message of "Thu, 7 Jan 2021 13:53:40 -0500")
Message-ID: <xmqq4kjsmses.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 94BCF33C-5122-11EB-A802-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

>> It could be possible to replace all references to 'istate' with
>> 'repo->index' but the patches get slightly more messy. I also
>> think the code looks messier, but you do make a good point that
>> there is no concrete reason to separate the two.
>
> I agree that it would make the code a bit noisier (to read) if
> `istate` is eliminated from the callback structure, however, even
> though I didn't originally feel strongly one way or the other about
> having both `repo` and `istate` in the structure, I'm now leaning more
> toward seeing `istate` eliminated. My one (big) concern with `istate`
> is that it confuses readers into wondering whether `istate` and
> `repo->istate` will ever be different.

Some applications may want to work on more than one in-core index at
the same time (perhaps a merge strategy may want to keep a copy of
the original index and update a second copy with the result of the
merge), and it may be useful for such applications if 'repo->istate'
does not have to be the in-core index instance to be worked on.  So
things that go in libgit.a may want to allow such distinction.

But what goes in builtin/ is a different story.  As long as this
application has no need for such a feature and will always work on
the primary in-core index, prepared for the in-core repository
structure for convenience, it may not worth it to support such a
feature that no callers benefit from.

Thanks.
