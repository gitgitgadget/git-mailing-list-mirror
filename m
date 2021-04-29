Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EF6BC433B4
	for <git@archiver.kernel.org>; Thu, 29 Apr 2021 07:25:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3BE71613BC
	for <git@archiver.kernel.org>; Thu, 29 Apr 2021 07:25:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239050AbhD2HZz (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Apr 2021 03:25:55 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54156 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232082AbhD2HZs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Apr 2021 03:25:48 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 98C2FD1854;
        Thu, 29 Apr 2021 03:24:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=nqSaRXyXrMEC
        +a+jO5HE9HQMC3lTNwBikAedyXOQ6dM=; b=S6Ao5y6Atx7lzQ0gE4C4euFoTtCS
        TExxx0HkmfWej+TM4nV04RHUU48XLFkqGvqQKTqLa2t7F6smbRva/ELYWNYSG58v
        4+7pXyyyM4lDpBIN/X4qaQKdN+xYbV17kuoX/rQYBvOGORdCgEPobsklIqNfJfFX
        V57Xc2uDY3Ws4Vk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BF786D1852;
        Thu, 29 Apr 2021 03:24:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 062BBD1851;
        Thu, 29 Apr 2021 03:24:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Matthieu Moy <git@matthieu-moy.fr>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBD?= =?utf-8?B?w7RuZw==?= Danh 
        <congdanhqx@gmail.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [PATCH v5 00/11] test-lib.sh: new test_commit args,
 simplification & fixes
References: <cover-00.11-0000000000-20210421T101156Z-avarab@gmail.com>
        <cover-00.11-00000000000-20210423T072006Z-avarab@gmail.com>
Date:   Thu, 29 Apr 2021 16:23:59 +0900
In-Reply-To: <cover-00.11-00000000000-20210423T072006Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Fri, 23 Apr
 2021 09:21:04
        +0200")
Message-ID: <xmqqo8dx7dv4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: DDEAD83A-A8BB-11EB-A46F-D152C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Changes since v4: Only a commit message change/re-wording per
> <87v98e1oj7.fsf@evledraar.gmail.com>.
>
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason (11):
>   test-lib: bring $remove_trash out of retirement
>   test-lib tests: remove dead GIT_TEST_FRAMEWORK_SELFTEST variable
>   test-lib-functions: reword "test_commit --append" docs
>   test-lib-functions: document test_commit --no-tag
>   test-lib functions: add an --annotated option to "test_commit"
>   describe tests: convert setup to use test_commit
>   test-lib functions: add --printf option to test_commit
>   submodule tests: use symbolic-ref --short to discover branch name
>   test-lib: reformat argument list in test_create_repo()
>   test-lib: do not show advice about init.defaultBranch under --verbose
>   test-lib: split up and deprecate test_create_repo()

I wasn't paying much attention to this series, and didn't look at
the last step at all (as I saw somebody else is already deeply
biting into it), but the earlier parts looked good to me.

It was painful to come back to the pile of topics after a week's
interruption, though.  While juggling ~50 topics, it is unfair to
expect the maintainer to remember that a topic that is still going
through iterations are depended on two other topics in flight (it is
easier for contributors, who will be juggling far fewer number of
topics at one time).

But I think I've sorted out the duplicates caused by forgetting that
I had to rebase ab/pickaxe-pcre2 and ab/describe-tests-fix on top of
this topic.  Will be pushing out the result of today's integration
sometime this evening, which is far from complete as I am still in
the "catch up with what happened during my absense" mode.

Thanks.



