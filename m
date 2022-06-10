Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76B9FC433EF
	for <git@archiver.kernel.org>; Fri, 10 Jun 2022 16:40:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348285AbiFJQke (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Jun 2022 12:40:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244328AbiFJQkc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Jun 2022 12:40:32 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28F6839BB7
        for <git@vger.kernel.org>; Fri, 10 Jun 2022 09:40:28 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id ABE8011EA12;
        Fri, 10 Jun 2022 12:40:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=8W35+QlMmuzg
        xvDe877+7FUv47FxIcQWaQzZhEks8gI=; b=e41+QxDZK3fvYRRtD01AXC/tDZlX
        6d7l7Oz6S7fOmvDmiXcfSogMT3HIAVBbm6K8VnpztE5YrAT+t4eR5zYxh+vpTfc+
        ulCXTd/1Sg3BGPD2E61MnR5LnKDwKWEgzslR+QXkxnuKXJL6z8+PUBtUZx4yFJBg
        unSNhTTlWGnDu/k=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A356011EA10;
        Fri, 10 Jun 2022 12:40:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 180C511EA0E;
        Fri, 10 Jun 2022 12:40:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] ci(github): bring back the 'print test failures' step
References: <pull.1252.git.1654684998599.gitgitgadget@gmail.com>
        <220609.868rq6t0la.gmgdl@evledraar.gmail.com>
Date:   Fri, 10 Jun 2022 09:40:25 -0700
In-Reply-To: <220609.868rq6t0la.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Thu, 09 Jun 2022 15:06:43 +0200")
Message-ID: <xmqqtu8sfp52.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 0849B3D8-E8DC-11EC-B869-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Wed, Jun 08 2022, Johannes Schindelin via GitGitGadget wrote:
>
>> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>>
>> Git now shows better information in the GitHub workflow runs when a te=
st
>> case failed.
>
> This commit message should be more on-point. "Git" isn't showing
> anything, and it's unclear that this is a regression fix for fc5a070f59=
1
> (Merge branch 'js/ci-github-workflow-markup', 2022-06-07).
>
>> However, when a test case was implemented incorrectly and therefore
>> does not even run, nothing is shown.
>
> The *report* came about because of an incorrectly implemented test (of
> mine).
>
> But the real issue is that your recent change to the CI output is
> implemented in such a way as to hide entire classes of errors that we'd
> previously show.

Yup, I think we are all on the same page on that.  And we also all
agree that CI output should help those developers who make mistakes
by making it easy to see them.  The recent change may have been too
aggressive to hide stuff in the name of "newbie friendliness", which
may or may not have been a mismatch between what it claimed to aim
at and what it actually did, but let's not grumble too much about it
and move on in a more constructive way.

These fix-ups are to correct such earlier mistakes.

> I don't think we should call these "full logs" while the bug above
> remains unsolved. Perhaps "more verbose logs emitted when running with
> --github-workflow-markup, omit the flag to get the full *.out logs"?

Yup.

>> diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
>> index 3fa88b78b6d..cd1f52692a5 100644
>> --- a/.github/workflows/main.yml
>> +++ b/.github/workflows/main.yml
>> @@ -119,6 +119,10 @@ jobs:
>>      - name: test
>>        shell: bash
>>        run: . /etc/profile && ci/run-test-slice.sh ${{matrix.nr}} 10
>> +    - name: print test failures
>
> When ci/print-test-failures.sh was last in this file before 08dccc8fc1f
> (ci: make it easier to find failed tests' logs in the GitHub workflow,
> 2022-05-21) there was no "name" field, that's an unrelated change that
> shouldn't be part of a narrow regression fix.
>
>> +      if: failure() && env.FAILED_TEST_ARTIFACTS !=3D ''
>
> We likewise just had "if failure()" then, is the distinction different
> in all these cases?
>
>> +      shell: bash
>
> ...and you've made every single one of them run with "bash" instead of
> the default shell, which is another "change while at it" that isn't
> discussed.

If it is so important to support all the other shells in the GitHub
workflows environment, we can discuss fix-up patches on top or
replacement patches, but does that really matter?  If this were main
Makefile or ci/*.sh that are supposed to be usable by places other
than GitHub Actions environment we use for the CI there, of course
it would be worth to try being extra portable, but it may be even
beneficial to "fix" .github/workflows/* stuff, so that we won't have
to be affected by mistaken use of non-portable shell construct
written there, perhaps?
