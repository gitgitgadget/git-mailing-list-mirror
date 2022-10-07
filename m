Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 550E9C433FE
	for <git@archiver.kernel.org>; Fri,  7 Oct 2022 17:08:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229494AbiJGRIy (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Oct 2022 13:08:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbiJGRIw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Oct 2022 13:08:52 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C5C1A87AB
        for <git@vger.kernel.org>; Fri,  7 Oct 2022 10:08:50 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 44C2515B917;
        Fri,  7 Oct 2022 13:08:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=WTPZ+kRthaq56vVRLoezqjYdwU/cpznPvyX0X5
        bLuuU=; b=TcwSw5h5LTOBtJ8zNn7ktIUt270XPHbuix2VDhl5NgeKimsUftBUyG
        soN2T/HccZCaz6GnTy6dTuFTVs7YPmBQnQoCOGhCAhxZNyZQ/ipMzQDNEb8mdLZk
        nlNIEM1m//EURxKqdOXAL0ShHz9MFndR/F9EMhzqDhjyyAPwSrkTI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3AEF015B916;
        Fri,  7 Oct 2022 13:08:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9A74D15B915;
        Fri,  7 Oct 2022 13:08:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH 0/3] [RFC] tests: add test_todo() for known failures
References: <pull.1374.git.1665068476.gitgitgadget@gmail.com>
        <221006.86v8owr986.gmgdl@evledraar.gmail.com>
        <8df2260c-7a35-5b50-7273-fbd9894a614c@dunelm.org.uk>
Date:   Fri, 07 Oct 2022 10:08:47 -0700
In-Reply-To: <8df2260c-7a35-5b50-7273-fbd9894a614c@dunelm.org.uk> (Phillip
        Wood's message of "Fri, 7 Oct 2022 14:26:59 +0100")
Message-ID: <xmqq8rlrh880.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B5A376DE-4662-11ED-A7EE-2AEEC5D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

> I think there is a question of whether we need a new toplevel
> test_expect_todo - why would we add it if we can just reuse
> test_expect_success? That way when a test failure is fixed all that
> needs to be done is to remove the test_todo calls.

Yup, that is one of the reasons why I favor test_todo inside the
normal test_expect_success.  A patch that fixes a breakage would
come with a change to the tests that flips test_expect_failure to
test_expect_success often had the step that were expected to fail
outside the post context and did not make it immediately obvious
what was fixed, and use of a more focused test_todo would make it
more clear.  Unless we gain a clear advantage by using a different
top-level (e.g. some of the limitations like "not in a subshell" can
be lifted?), I do not think we want to add one.


