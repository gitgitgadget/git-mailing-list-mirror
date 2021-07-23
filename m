Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBBB3C4338F
	for <git@archiver.kernel.org>; Fri, 23 Jul 2021 17:28:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8CBF860EB5
	for <git@archiver.kernel.org>; Fri, 23 Jul 2021 17:28:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230172AbhGWQrk (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Jul 2021 12:47:40 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63705 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230098AbhGWQrj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Jul 2021 12:47:39 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E9B3FD4604;
        Fri, 23 Jul 2021 13:28:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=w3SnfGbkDoGu5ZfN4o1DnJuHBNWYPM/i6O8Bvl
        tM2CY=; b=wAYUf67qhWQEdO6k7NvV1gSgz96yIy4yyyvMM2SzehB8MBM2W4IWSg
        bg41nVjCHpXjje9NCALeFHIjJfcUka8to61Zcq4HTPlQ5xKTsFPm6CjPoUt1OF2O
        p9awK1/aUV+oqXkluLH1BG9GaFsD7HJB1q4K2yuaeKUwvgJdMFez8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E1F3DD4603;
        Fri, 23 Jul 2021 13:28:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.71.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6D103D4602;
        Fri, 23 Jul 2021 13:28:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH v2 07/11] t1405: mark test for 'git pack-refs' as REFFILES
References: <pull.1052.git.git.1626718050.gitgitgadget@gmail.com>
        <pull.1052.v2.git.git.1626989327.gitgitgadget@gmail.com>
        <05dead16f1cbc8d967edf101e170049bbe121cb4.1626989327.git.gitgitgadget@gmail.com>
Date:   Fri, 23 Jul 2021 10:28:10 -0700
In-Reply-To: <05dead16f1cbc8d967edf101e170049bbe121cb4.1626989327.git.gitgitgadget@gmail.com>
        (Han-Wen Nienhuys via GitGitGadget's message of "Thu, 22 Jul 2021
        21:28:43 +0000")
Message-ID: <xmqqsg05ndn9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5A8F7D16-EBDB-11EB-A741-8B3BC6D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Han-Wen Nienhuys <hanwen@google.com>
>
> The outcome of the pack-refs operation is not checked. This was apparently
> forgotten in the commit introducing this test: 16feb99d (Mar 26 2017, "t1405:
> some basic tests on main ref store").
>
> I tried adding the obvious check this, but it seems to fail on the freebsd_12
> builder.

These two paragraphs may state the truth, but readers would
appreciate if it is clarified that they are both side notes that do
not necessarily help understanding the change being made with the
patch.  Something like this

    The number of loose ref files under .git/refs/ directory before
    and after running the "git pack-refs" command only matter when
    the files ref-backend is in use, so hide the test behind the
    REFFILES prerequisite.

would be needed before these sidenotes.

With a larger context, as you said, 

    diff --git a/t/t1405-main-ref-store.sh b/t/t1405-main-ref-store.sh
    index 92b0487324..3517f54961 100755
    --- a/t/t1405-main-ref-store.sh
    +++ b/t/t1405-main-ref-store.sh
    @@ -9,10 +9,14 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME

     RUN="test-tool ref-store main"

    -test_expect_success 'pack_refs(PACK_REFS_ALL | PACK_REFS_PRUNE)' '
    -	test_commit one &&
    +
    +test_expect_success 'setup' '
    +	test_commit one
    +'
    +
    +test_expect_success REFFILES 'pack_refs(PACK_REFS_ALL | PACK_REFS_PRUNE)' '
            N=`find .git/refs -type f | wc -l` &&
            test "$N" != 0 &&
            $RUN pack-refs 3 &&
            N=`find .git/refs -type f | wc -l`
     '

we do count the number of regular files in .git/refs hierarchy after
running "test-tool ref-store main pack-refs 3" (whatever that means).

I think your "obvious check" would have been something like the
attached?  How would that break?  It is not the "'wc -l' pads the
output with extra spaces" we often see on macOS, is it?

Thanks.

 t/t1405-main-ref-store.sh | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git c/t/t1405-main-ref-store.sh w/t/t1405-main-ref-store.sh
index 3517f54961..9dc88d7580 100755
--- c/t/t1405-main-ref-store.sh
+++ w/t/t1405-main-ref-store.sh
@@ -15,10 +15,11 @@ test_expect_success 'setup' '
 '
 
 test_expect_success REFFILES 'pack_refs(PACK_REFS_ALL | PACK_REFS_PRUNE)' '
-	N=`find .git/refs -type f | wc -l` &&
-	test "$N" != 0 &&
+	N=$(find .git/refs -type f | wc -l) &&
+	test $N -ne 0 &&
 	$RUN pack-refs 3 &&
-	N=`find .git/refs -type f | wc -l`
+	N=$(find .git/refs -type f | wc -l) &&
+	test $N -eq 0
 '
 
 test_expect_success 'create_symref(FOO, refs/heads/main)' '
