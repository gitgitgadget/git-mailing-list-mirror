Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC19BC433F5
	for <git@archiver.kernel.org>; Fri,  1 Apr 2022 18:24:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233663AbiDAS0c (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Apr 2022 14:26:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231851AbiDAS0a (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Apr 2022 14:26:30 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 850501903C5
        for <git@vger.kernel.org>; Fri,  1 Apr 2022 11:24:40 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E5470193115;
        Fri,  1 Apr 2022 14:24:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=OQyBNSE/UF2KL91bAaPPNeRLekoQSVCqaT3eJr
        DqpDE=; b=srFSXcqQomu4qeYtt8aNAUkR04IADIsP5+XoEq1hPJjMGpqCL5HBjS
        4WqsDIAYVH9NFzPEphFw9WteINUAE1JHi3bUJGj936dl+ywY17lZWhoLZSH4d6yk
        15i1TVbgpwUMdrB4U4O8kSuRGEzh0TzFE+YiS2U6oXNPjsIXi/jvM=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D48E9193114;
        Fri,  1 Apr 2022 14:24:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.227.145.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id E921A193113;
        Fri,  1 Apr 2022 14:24:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Labnann <khalid.masum.92@gmail.com>
Cc:     avarab@gmail.com, git@vger.kernel.org, gitgitgadget@gmail.com
Subject: Re: [PATCH v2 3/3] t3501: test cherry-pick revert with oids
References: <220331.86bkxnt77a.gmgdl@evledraar.gmail.com>
        <20220331191525.17927-1-khalid.masum.92@gmail.com>
        <20220331191525.17927-4-khalid.masum.92@gmail.com>
Date:   Fri, 01 Apr 2022 11:24:35 -0700
In-Reply-To: <20220331191525.17927-4-khalid.masum.92@gmail.com> (Labnann's
        message of "Thu, 31 Mar 2022 19:15:25 +0000")
Message-ID: <xmqq7d88wtjw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FC93A370-B1E8-11EC-B1C1-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Labnann <khalid.masum.92@gmail.com> writes:

>  we did a revert of a file we had so that it's the same as in
> "initial", but now it's at a different path, which we can exhaustively
> do by checking the blob OIDs

Don't indent the first line by a space, and capitalize the first
letter of the full sentence as usual.  End the sentence with a full
stop.

I did not quite get the "blob OIDs" reference; does that refer to
the changes in both hunks?

> Signed-off-by: Labnann <khalid.masum.92@gmail.com>
> ---
>  t/t3501-revert-cherry-pick.sh | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
>
> diff --git a/t/t3501-revert-cherry-pick.sh b/t/t3501-revert-cherry-pick.sh
> index bd19c272d6..08103923ab 100755
> --- a/t/t3501-revert-cherry-pick.sh
> +++ b/t/t3501-revert-cherry-pick.sh
> @@ -72,8 +72,7 @@ test_expect_success 'cherry-pick after renaming branch' '
>  
>  	git checkout rename2 &&
>  	git cherry-pick added &&
> -	test_cmp_rev_parse HEAD^ rename2 &&
> -	test_path_is_file opos &&
> +	test_cmp_rev_parse rename2 HEAD^ &&
>  	grep "Add extra line at the end" opos &&

This change is not quite explained anywhere.  Why do we have to swap
HEAD^ and rename2?  I agree that we do not have to make sure that
opos exists since we are going to run "grep" on it in a later step
anyway, and the lack of that file will be detected as a failure,
but these two changes deserve mention in the proposed log message.

>  	git reflog -1 | grep cherry-pick
>  
> @@ -83,9 +82,8 @@ test_expect_success 'revert after renaming branch' '
>  
>  	git checkout rename1 &&
>  	git revert added &&
> -	test_cmp_rev_parse HEAD^ rename1 &&
> -	test_path_is_file spoo &&
> -	! grep "Add extra line at the end" spoo &&
> +	test_cmp_rev_parse rename1 HEAD^ &&
> +	test_cmp_rev_parse initial:oops HEAD:spoo &&

Again, did we need to swap and if so why?

So instead of allowing spoo to be some random garbage as long as it
does not have the "Add extra line" message, we can exactly predict
what the contents of the correct result, which is to end up with the
identical contents in oops of the initial commit.  OK, that makes
sense.

    Swap the order of revisions being compared in two tests for such
    and such reasons.  In one test, stop checking for the presence
    of a file (opos) because we are going to "grep" in it in the
    same test and the lack of it will be noticed as a failure
    anyway.  In the other test, instead of allowing any random
    contents as long as a known phrase is not there in it, we can
    expect the exact outcome---after the successful revert of
    "added", the contents of file "spoo" should become identical to
    what was in file "oops" in the "initial" commit.

or something like that, perhaps.

Strictly speaking, this used to check the working tree files but now
it checks the contents of the resulting commit.  I wonder if we need
to ensure that the HEAD, the index and the working tree are all
updated the same way, or if that is too basic, obvious, and (most
importantly) already tested elsewhere?

Thanks.

>  	git reflog -1 | grep revert
>  
>  '
