Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A018C433F5
	for <git@archiver.kernel.org>; Thu,  3 Mar 2022 01:10:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231255AbiCCBLZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Mar 2022 20:11:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231169AbiCCBLX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Mar 2022 20:11:23 -0500
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E488D159E82
        for <git@vger.kernel.org>; Wed,  2 Mar 2022 17:10:39 -0800 (PST)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E090A11D519;
        Wed,  2 Mar 2022 20:10:38 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=PB9UIjylO95CkRqHXVJ+msWNZFZX6wMlm+hZt9
        frqBY=; b=ZHhVTgYM5xQnqIA9HkbX0tDR6iMciPxxRUEl3ZJt2E3ZmgiyETr6gO
        9DGyWH+Qa6+iMjbCeYISsXXlNjR8tc09VLYcsARcIi76bmkJQHjdMC0zN9XzUZiQ
        KMhrfJ4DJjNUyAPIa1qmrOWfzSWxWWWuBMinvAc8uL7mNQt4wwfNI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D7BF811D518;
        Wed,  2 Mar 2022 20:10:38 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4830411D516;
        Wed,  2 Mar 2022 20:10:38 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Keller, Jacob E" <jacob.e.keller@intel.com>
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Git mailing list <git@vger.kernel.org>
Subject: Re: [PATCH] name-rev: use generation numbers if available
References: <20220228215025.325904-1-jacob.e.keller@intel.com>
        <20220228215025.325904-3-jacob.e.keller@intel.com>
        <xmqqpmn6wg98.fsf@gitster.g>
        <CA+P7+xoECs-rXb4vpRrw40Q-oRvfu97kMig9zu0rEE6KagAyiw@mail.gmail.com>
        <xmqqfso2t9cu.fsf@gitster.g>
        <6b00c67b-01c9-bf22-a8e6-904f47fa7acf@github.com>
        <f5ca62f4-eb3d-eeb7-e7c8-7fb800f3d6cd@intel.com>
        <3c3e6063-7eb4-7ff4-3a1b-a07db1fe969f@github.com>
        <xmqqfso1pgmv.fsf@gitster.g>
        <CO1PR11MB5089DC997DB42023324F1BF0D6029@CO1PR11MB5089.namprd11.prod.outlook.com>
Date:   Wed, 02 Mar 2022 17:10:37 -0800
In-Reply-To: <CO1PR11MB5089DC997DB42023324F1BF0D6029@CO1PR11MB5089.namprd11.prod.outlook.com>
        (Jacob E. Keller's message of "Tue, 1 Mar 2022 22:46:06 +0000")
Message-ID: <xmqqilsvet82.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BCAD1BEA-9A8E-11EC-A828-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Keller, Jacob E" <jacob.e.keller@intel.com> writes:

> Let's clarify. There are two versions of the test in this version:
>
> 1) test which enables commit graph and tests that it does the right behavior.
>
> 2) test which removes commit graph and tests that it behaves the old way.
>
>
> test (1) checks the flow with the commit graph enabled, and verifies that with a commit graph the new behavior is used. This test will fail if you revert the name-rev commit-graph support.
>
> test (2) always performs the way we don't like. (since we disable the commit graph and the new flow doesn't kick in) This is the test I think I will eliminate in the next revision.
>
>
> I will remove the 2nd test, since the first test covers the change
> in behavior just fine, and I think I agree we don't need to set
> in-stone the implementation without commit graph.
>
> I will also look at adding a test which performs a count of which
> revisions get inspected and makes sure that we actually are doing
> the optimization.

Sounds like a sensible thing to do.

In any case, in the current patch, #2 is not working in
linux-TEST-vars job at CI.  You can visit this URL

https://github.com/git/git/runs/5400048732?check_suite_focus=true#step:4:68062

while logged into your GitHub account for details.

Thanks.
