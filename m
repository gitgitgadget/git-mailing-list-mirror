Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BFC6C433ED
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 18:18:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 194226023C
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 18:18:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243959AbhDLSS2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Apr 2021 14:18:28 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61749 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239725AbhDLSS2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Apr 2021 14:18:28 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2F9D0AAD68;
        Mon, 12 Apr 2021 14:18:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=1AaZvNNE/lKF
        tfguT5JYd80HZRU=; b=IwxQEDEkO1t98mbvKxLINbX02Ydb4S51VUyOR660gtS4
        aGrky1k1GIky3GW8OpoEL8xVcWnou1EoXm9etISRnJZgrKei5Cm48EJVZi+aUBIA
        hevYcRaGB5UOG9uFAhK06QaAMPcO7cvfQyoUWBd5rxw7ePz8fkMKPzhvP3Tx3lo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=VwH8vr
        Lsl5OUmIjl/bE5wpIrCa3PPOs0myZ5P9BUq1S//GoAlb9f+jjKCNpmiC9ScUa3kV
        qRx6o9kM2lRn73iHH3PDF+28TeQ14W0OKnQeHsmsU+Lqicrv7oLPPB26Pj+/Y9sJ
        +uGg9Y/YHywU1tqr7gvnt9YNPdbXno9/4OxpE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2185EAAD67;
        Mon, 12 Apr 2021 14:18:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 493CDAAD63;
        Mon, 12 Apr 2021 14:18:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Matthieu Moy <git@matthieu-moy.fr>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 00/16] test-lib.sh: new test_commit args, simplification
 & fixes
References: <cover-00.16-00000000000-20210412T110456Z-avarab@gmail.com>
Date:   Mon, 12 Apr 2021 11:18:06 -0700
In-Reply-To: <cover-00.16-00000000000-20210412T110456Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Mon, 12 Apr
 2021 13:08:49
        +0200")
Message-ID: <xmqqa6q3e59d.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 6E17D718-9BBB-11EB-9715-D152C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> This is a "various small fixes" series to test-lib.sh,
> test-lib-functions.sh.
>
> I have a couple of outstanding patch serieses that I've pulled this
> from (ab/describe-tests-fix, ab/pickaxe-pcre2), as well as some other
> local work I've been having a chicken and egg problem with.
>
> I think the approach of pulling out these various miscellaneous test
> fixes into their own topic makes the most sense,...

I guess I'm expected to discard the other topics that have been
expecting rerolls from my tree to make room for this, queue this
topic and wait it to stabilize, before taking the rerools of these
other topics.

I find it a bit distracting to retract multiple topics that have
been already reviewed and reorganizing them in a new topic.  The
reviewer resource spent for the last round might not be completely
lost, but for reviewers it makes it unnecessarily harder to verify
which review comments have been addressed and which parts haven't
changed, so the net effect is to require them a fresh review anyway.
If you can entice reviewers to review this new series and making
them giving it priority over other topics in flight, that is.

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason (16):
>   check-non-portable-shell: complain about "test" a/-o instead of &&/||
>   test-lib: bring $remove_trash out of retirement
>   test-lib tests: remove dead GIT_TEST_FRAMEWORK_SELFTEST variable
>   test-lib-functions: reword "test_commit --append" docs
>   test-lib-functions: document test_commit --no-tag
>   test-lib functions: add an --annotated-tag option to "test_commit"
>   describe tests: convert setup to use test_commit
>   test-lib functions: add --printf option to test_commit
>   submodule tests: use symbolic-ref --short to discover branch name
>   test-lib: reformat argument list in test_create_repo()
>   test-lib: do not show advice about init.defaultBranch under --verbose
>   test-lib: modernize test_create_repo() function
>   test-lib-functions: normalize test_path_is_missing() debugging
>   test-lib-functions: use "return 1" instead of "false"
>   Revert and amend "test-lib-functions: assert correct parameter count"
>   test-lib-functions: remove last two parameter count assertions
