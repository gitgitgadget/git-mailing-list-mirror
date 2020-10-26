Return-Path: <SRS0=PD7l=EB=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D849C4363A
	for <git@archiver.kernel.org>; Mon, 26 Oct 2020 17:36:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 371F82224A
	for <git@archiver.kernel.org>; Mon, 26 Oct 2020 17:36:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="w9kzzdhv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1781278AbgJZRgp (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Oct 2020 13:36:45 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56723 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1781164AbgJZRgo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Oct 2020 13:36:44 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E8B2E90491;
        Mon, 26 Oct 2020 13:36:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=48CXRBYLx2WI5vVhdBv8reRAj+s=; b=w9kzzd
        hv8G/mDZkh8iW0R2YnL2yTu3wymPMEpf4lS+LGvYP7lnqT1EdydiJ28SxYIYUtvF
        rTKj4j7/dq4WRw84jbcedxy/mvlSdil9+rXsKhjb0ku7cRipkqJ6aPB1wKWukMIi
        ++i3SboJTmNtBSYpyyhftivDXGkKTjz9QnrfI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=VOQPF3ydtE4ntSHw+xsuT8tItUBCH16T
        ecN7JCy8I+g65OWZ6HZ4pBmIDE5MsdnEvI3NzZBzTSET00Jc6QV46rchJ4HQyzZO
        dKujWCuP9ta/47bPuzJTWlZGs6SyCEIJY8QNuxfn7E+ZXfcZy8GmPUHzxSrCfWvh
        hkKyZ4lzKKo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DDFC790490;
        Mon, 26 Oct 2020 13:36:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 2E0879048E;
        Mon, 26 Oct 2020 13:36:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Sangeeta NB <sangunb09@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: [Outreachy] [PATCH v4] diff: do not show submodule with
 untracked files as "-dirty"
References: <pull.751.git.1602781723670.gitgitgadget@gmail.com>
        <20201023111827.40188-1-sangunb09@gmail.com>
        <xmqqmu0cfx9a.fsf@gitster.c.googlers.com>
        <CAHjREB6fC6j30MH1Lb7enE3KJaGdX--Ft8+hwVeDfwApab5FNQ@mail.gmail.com>
Date:   Mon, 26 Oct 2020 10:36:41 -0700
In-Reply-To: <CAHjREB6fC6j30MH1Lb7enE3KJaGdX--Ft8+hwVeDfwApab5FNQ@mail.gmail.com>
        (Sangeeta NB's message of "Sun, 25 Oct 2020 15:53:49 +0530")
Message-ID: <xmqqblgoga8m.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CF742A86-17B1-11EB-8379-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sangeeta NB <sangunb09@gmail.com> writes:

>> > -     git diff HEAD >actual &&
>> > +     git diff --ignore-submodules=none HEAD >actual &&
>> >       sed -e "1,/^@@/d" actual >actual.body &&
>> >       expect_from_to >expect.body $subprev $subprev-dirty &&
>> >       test_cmp expect.body actual.body &&
>> >       git diff --ignore-submodules=all HEAD >actual2 &&
>> >       test_must_be_empty actual2 &&
>> > -     git diff --ignore-submodules=untracked HEAD >actual3 &&
>> > +     git diff HEAD >actual3 &&
>>
>> This line can be left as-is, no?
>
> Ya, they can be left as it is but I removed the
> --ignore-submodules=untracked because we also have to check the
> default git behavior and adding that doesn't change anything in the
> code so I removed that.
> In general, in all the tests I followed this practice:
> 1. I added --ignore-submodules=none where there were no options
> specified(as this was the earlier default)
> 2. I removed --ignore-submodules=untracked(as this should even work if
> no options are specified)
>
> I would put that back if you still want it?

OK, I re-read the changes to the tests in v5 (an excerpt at the end
of this message), and I think this one makes sort-of sense.

We want to see that a plain-vanilla invocation of "git diff" without
custom "--ignore-submodules" option would stop saying -dirty when
untracked cruft is in the submodule's working tree, and this test,
as it says in its title, is exactly testing that case (i.e. "how is
a submodule without change relative to the gitlink in the
superproject shown when there is untracked cruft there?").  It is a
perfect opportunity to give the answer to the question and how that
answer will be different from the current system if we took this
patch.  We used to expect to see that submodule has changed from the
commit subprev to the same commit subprev with dirty indicator.
What should we expect under the new world order?  We should stop
claiming that submodule has any change.

So I would have expected that would be shown by the first step in
first "what happens without custom --ignore-submodules invocation?"
test by changing the expect_from_to that corresponds to it, and then
a *new* test added to show that with "--ignore-submodules=none" it
is still possible to get "changed from the same commit to the same
commit with the -dirty indicator" as a second test.

As long as all cases (i.e. all possible values to --ignore-submodules=<what>,
plus the case where --ignore-submodules=<what> is not given at all) are
covered, it is OK, but I think it is the best to show the case without
an option, especially when the original does so.

Thanks.

@@ -168,13 +177,13 @@ test_expect_success 'git diff HEAD with dirty submodule (untracked, refs match)'
 		git clean -qfdx &&
 		>cruft
 	) &&
-	git diff HEAD >actual &&
+	git diff --ignore-submodules=none HEAD >actual &&
 	sed -e "1,/^@@/d" actual >actual.body &&
 	expect_from_to >expect.body $subprev $subprev-dirty &&
 	test_cmp expect.body actual.body &&
 	git diff --ignore-submodules=all HEAD >actual2 &&
 	test_must_be_empty actual2 &&
-	git diff --ignore-submodules=untracked HEAD >actual3 &&
+	git diff HEAD >actual3 &&
 	test_must_be_empty actual3 &&
 	git diff --ignore-submodules=dirty HEAD >actual4 &&
 	test_must_be_empty actual4
