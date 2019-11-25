Return-Path: <SRS0=39iz=ZR=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E185CC432C0
	for <git@archiver.kernel.org>; Mon, 25 Nov 2019 02:02:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE4212073F
	for <git@archiver.kernel.org>; Mon, 25 Nov 2019 02:02:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Frp/UF0S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726861AbfKYB4m (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 24 Nov 2019 20:56:42 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50434 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726803AbfKYB4m (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Nov 2019 20:56:42 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 896A42B6C6;
        Sun, 24 Nov 2019 20:56:35 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=CCCTpUCkSErvH0wNsCOpR08jWIc=; b=Frp/UF
        0SP6Dt5c9LOGgjjsXTfne/5AemYeg5CvUHX0FmY8ttUqjKxJECN7rwMN/3D39JmF
        mdPXpsyKLzMuDw2XBnbO6srClN0VHHUAAZmyG1gDucYcVZibzh7sCadTTRLJRRaW
        KSixhyoN15mLKmWk3SQI1L+MS6uOov3EblLt4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=YAsa9EZPSyJ+6DZwHGUy3F6MC7G2QtSa
        vFGeEfdMJnLN96YOJg3gz/8ruHd9CQl79FooMkPoy2mEcIsV9EZTaxAPCp88Wyy1
        FQNi9sMS8Siw1VN8rjlggycR20wCrePza0BWr8t72sfDyeAKJonOjn8CSymoVZmy
        ES2vKvMCir0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 81CD12B6C4;
        Sun, 24 Nov 2019 20:56:35 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E5D9D2B6C3;
        Sun, 24 Nov 2019 20:56:34 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Manish Goregaokar via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Manish Goregaokar <manishsmail@gmail.com>
Subject: Re: [PATCH v2 1/1] submodule: fix 'submodule status' when called from a subdirectory
References: <pull.472.git.1574490521.gitgitgadget@gmail.com>
        <pull.472.v2.git.1574582473.gitgitgadget@gmail.com>
        <e4c932bd0907daa53d1d721f9c9400bdad17fb62.1574582473.git.gitgitgadget@gmail.com>
Date:   Mon, 25 Nov 2019 10:56:33 +0900
In-Reply-To: <e4c932bd0907daa53d1d721f9c9400bdad17fb62.1574582473.git.gitgitgadget@gmail.com>
        (Manish Goregaokar via GitGitGadget's message of "Sun, 24 Nov 2019
        08:01:13 +0000")
Message-ID: <xmqqfticzpke.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CF50D37C-0F26-11EA-B947-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Manish Goregaokar via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Manish Goregaokar <manishsmail@gmail.com>
>
> When calling `git submodule status` while in a subdirectory, we are
> incorrectly not detecting modified submodules and
> thus reporting that all of the submodules are unchanged.
>
> This is because the submodule helper is calling `diff-index` with the
> submodule path assuming the path is relative to the current prefix
> directory, however the submodule path used is actually relative to the root.
>
> Always pass NULL as the `prefix` when running diff-files on the
> submodule, to make sure the submodule's path is interpreted as relative
> to the superproject's repository root.
>
> Signed-off-by: Manish Goregaokar <manishsmail@gmail.com>
> ---
>  builtin/submodule--helper.c |  3 ++-
>  t/t7400-submodule-basic.sh  | 19 +++++++++++++++++++
>  2 files changed, 21 insertions(+), 1 deletion(-)

Thanks.

Will queue as-is for now, but others may have comments on the patch
(and certainly the test part would see a few issues pointed out),
which we may want to address before this hits the 'next' and lower
branches.

> diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
> index a208cb26e1..4545b47ca4 100755
> --- a/t/t7400-submodule-basic.sh
> +++ b/t/t7400-submodule-basic.sh
> @@ -356,6 +356,25 @@ test_expect_success 'status should only print one line' '
>  	test_line_count = 1 lines
>  '
>  
> +test_expect_success 'status from subdirectory should have the same SHA1' '
> +	test_when_finished "rmdir addtest/subdir" &&
> +	(
> +		cd addtest &&

> +		git status > /tmp/foo &&

I think that you added this line for debugging the test; because
what it does has no effect on anything in the test, let's remove it.

> +		git submodule status | awk "{print \$1}" >expected &&

This construct to have "git submodule status" on the left hand side
of a pipe hides its exit status.  We wouldn't notice even if it
crashes with a segfault, which is bad especially if it does so after
showing the output we expect.  This instance is doubly bad because
the output is not even compared against a known-good copy.  In fact,
this is to create a known-good copy, so if "git submodule status"
gets broken so badly that it crashes even before emitting anything,
we would get an empty "expected" file (by the way, we tend to
compare 'expect' and 'actual', not 'expected' and 'actual',
especially in our newer tests) here, which would be compared with
outputs from other invocations of "git submodule status" later in
the test.  If "git ubmodule status" is so broken that it crashes
immediately, these later invocations would die without showing any
output, so all the actual* files would also be empty and out
test_cmp would be very happy to report that all tests are good.

Not so good.

	git submodule status >output &&
	sed -e "s/ .*// >expect &&

perhaps?

> +		mkdir subdir &&

If the test fails before reaching this line for whatever reason,
addtest/subdir directory won't exist, and test-when-finished would
not be so happy.

> +		cd subdir &&
> +		git submodule status | awk "{print \$1}" >../actual &&
> +		test_cmp ../expected ../actual &&
> +		git -C ../submod checkout @^ &&

Gahh.  Please stick to human language HEAD^ and avoid line noise @^.

> +		git submodule status | awk "{print \$1}" >../actual2 &&
> +		cd .. &&
> +		git submodule status | awk "{print \$1}" >expected2 &&
> +		test_cmp actual2 expected2 &&
> +		test_must_fail test_cmp actual actual2

Please do not apply test_must_fail to anything but "git subcmd".
For now,

	! test_cmp actual actual2

is a safer alternative.  Right now we are cooking a topic to allow
us to write it as

	test_cmp ! actual actual2

but it hasn't been merged to 'master' yet. 

> +	)
> +'
> +
>  test_expect_success 'setup - fetch commit name from submodule' '
>  	rev1=$(cd .subrepo && git rev-parse HEAD) &&
>  	printf "rev1: %s\n" "$rev1" &&
