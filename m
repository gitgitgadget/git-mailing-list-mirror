Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED385C433FE
	for <git@archiver.kernel.org>; Mon,  7 Mar 2022 22:52:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343880AbiCGWxc (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Mar 2022 17:53:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235685AbiCGWx3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Mar 2022 17:53:29 -0500
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E66D297
        for <git@vger.kernel.org>; Mon,  7 Mar 2022 14:52:30 -0800 (PST)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 4653A193143;
        Mon,  7 Mar 2022 17:52:30 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=9OZfJbQQXaLahedS+Osrl0uCuNLbQnCm279KJB
        9A9i0=; b=UQ9hB8A6XviJy3KRmjttx4WQFhSeqqHsGJfFOtEp81yazgLUOXPTHf
        30gg+rja5XvW0u/kp14QQ0yT0EaL1LAZ50Om1JYIcwJfD48cP1wROHXb7Nc1aYQN
        rUH3YYWEEQS/C2nMdqDgQ/yrn2ovJaXx5aSSw7MDQ9op+3HncJ93U=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 3ECA1193142;
        Mon,  7 Mar 2022 17:52:30 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.230.65.123])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id B9A4919313F;
        Mon,  7 Mar 2022 17:52:27 -0500 (EST)
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
        <xmqqilsvet82.fsf@gitster.g>
        <CA+P7+xo=UwUQ422o36_8XGNWoYjROGi5wBT4=jy4ThJBs_z=Xw@mail.gmail.com>
        <39f08f98-be0f-bba7-c41a-1c9eb6182a67@github.com>
        <CO1PR11MB508949A91933E83A6BE1194FD6089@CO1PR11MB5089.namprd11.prod.outlook.com>
Date:   Mon, 07 Mar 2022 14:52:26 -0800
In-Reply-To: <CO1PR11MB508949A91933E83A6BE1194FD6089@CO1PR11MB5089.namprd11.prod.outlook.com>
        (Jacob E. Keller's message of "Mon, 7 Mar 2022 22:30:55 +0000")
Message-ID: <xmqq7d95qst1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 433231B8-9E69-11EC-8596-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Keller, Jacob E" <jacob.e.keller@intel.com> writes:

> Ok. The problem is that specific test does not behave the same. In fact it *cannot* behave the same because we're trying to test the non-commit-graph flow there. Since i'm dropping it in v3 I won't worry too much about it.

As you said, if you are removing the test, it is a moot point, but I
think what Derrick suggests is to do something like this:

diff --git c/t/t6120-describe.sh w/t/t6120-describe.sh
index c353c21cc8..871bdbbec9 100755
--- c/t/t6120-describe.sh
+++ w/t/t6120-describe.sh
@@ -508,6 +508,7 @@ test_expect_success 'name-rev without commitGraph does not handle non-monotonic
 		cd non-monotonic &&
 
 		rm -rf .git/info/commit-graph* &&
+		sane_unset GIT_TEST_COMMIT_GRAPH &&
 
 		echo "main~3 undefined" >expect &&
 		git name-rev --tags main~3 >actual &&

where you want to decline using the commit-graph feature.  As this
test piece is already in its own subshell, the unsetting will affect
only this one.
