Return-Path: <SRS0=yMBz=Z4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_SBL,URIBL_SBL_A autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8551C43603
	for <git@archiver.kernel.org>; Fri,  6 Dec 2019 17:39:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 851C221823
	for <git@archiver.kernel.org>; Fri,  6 Dec 2019 17:39:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="xhuCoS3O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726359AbfLFRjL (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Dec 2019 12:39:11 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:64423 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726328AbfLFRjL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Dec 2019 12:39:11 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 7671DA1772;
        Fri,  6 Dec 2019 12:39:10 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=HaI8ZpsxaXExBaDPYxgZOR2sIOY=; b=xhuCoS
        3ONWsm3ofm8bVvrFUAcbcFg9IcjpRzsn4dAZbXe+awfkRvEjiRtMktmhErWVXy7w
        d8I1+wcphesuV0i7aV+HPnEOzxXxFH2737Y1av7fVMAAZ84kkhEbPS4hJMGKLDME
        qQ57022wyg8I22gebYM3UTHG1rE4z6hR4bEOk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Pcd2gDuKsEOjTikcbrhpjVPvAr/nxlld
        Q9UEilyuBpWWi7lgq9IyldY5NGPY7NJc/agBwLlCdUKxxS3VvWAlhqVDFDvI1Xcd
        AUdrNAR94BBHfx1O+P9lOk8LZJwzBdfGYIVppxQCZ2xZIr3kds1b2SB/Djv74Hc/
        wnaM3eGIFjY=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 69048A1771;
        Fri,  6 Dec 2019 12:39:10 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 909BCA176F;
        Fri,  6 Dec 2019 12:39:07 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v2 1/9] t3404: use test_cmp_rev
References: <pull.417.git.1571787022.gitgitgadget@gmail.com>
        <20191206160614.631724-1-phillip.wood123@gmail.com>
        <20191206160614.631724-2-phillip.wood123@gmail.com>
Date:   Fri, 06 Dec 2019 09:39:05 -0800
In-Reply-To: <20191206160614.631724-2-phillip.wood123@gmail.com> (Phillip
        Wood's message of "Fri, 6 Dec 2019 16:06:06 +0000")
Message-ID: <xmqq5zitxsjq.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4DDD96E0-184F-11EA-9FAA-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> There are a number of places where we compare two revisions with
>     test $(git rev-parse rev1) = $(git rev-parse rev2)
> when these fail there's no indication what has gone wrong and you need
> to be running with `-x` to see where the test has failed. Lets use
> test_cmp_rev instead.

Makes sense.  Wonder if we can have a version of coccinelle for
shell scripts ;-)

>
> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> ---
>  t/t3404-rebase-interactive.sh | 38 +++++++++++++++++------------------
>  1 file changed, 19 insertions(+), 19 deletions(-)
>
> diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
> index c573c99069..d8a05fd439 100755
> --- a/t/t3404-rebase-interactive.sh
> +++ b/t/t3404-rebase-interactive.sh
> @@ -191,7 +191,7 @@ test_expect_success 'no changes are a nop' '
>  	git checkout branch2 &&
>  	git rebase -i F &&
>  	test "$(git symbolic-ref -q HEAD)" = "refs/heads/branch2" &&
> -	test $(git rev-parse I) = $(git rev-parse HEAD)
> +	test_cmp_rev I HEAD
>  '
>  
>  test_expect_success 'test the [branch] option' '
> @@ -200,16 +200,16 @@ test_expect_success 'test the [branch] option' '
>  	git commit -m "stop here" &&
>  	git rebase -i F branch2 &&
>  	test "$(git symbolic-ref -q HEAD)" = "refs/heads/branch2" &&
> -	test $(git rev-parse I) = $(git rev-parse branch2) &&
> -	test $(git rev-parse I) = $(git rev-parse HEAD)
> +	test_cmp_rev I branch2 &&
> +	test_cmp_rev I HEAD
>  '
>  
>  test_expect_success 'test --onto <branch>' '
>  	git checkout -b test-onto branch2 &&
>  	git rebase -i --onto branch1 F &&
>  	test "$(git symbolic-ref -q HEAD)" = "refs/heads/test-onto" &&
> -	test $(git rev-parse HEAD^) = $(git rev-parse branch1) &&
> -	test $(git rev-parse I) = $(git rev-parse branch2)
> +	test_cmp_rev HEAD^ branch1 &&
> +	test_cmp_rev I branch2
>  '
>  
>  test_expect_success 'rebase on top of a non-conflicting commit' '
> @@ -218,12 +218,12 @@ test_expect_success 'rebase on top of a non-conflicting commit' '
>  	git rebase -i branch2 &&
>  	test file6 = $(git diff --name-only original-branch1) &&
>  	test "$(git symbolic-ref -q HEAD)" = "refs/heads/branch1" &&
> -	test $(git rev-parse I) = $(git rev-parse branch2) &&
> -	test $(git rev-parse I) = $(git rev-parse HEAD~2)
> +	test_cmp_rev I branch2 &&
> +	test_cmp_rev I HEAD~2
>  '
>  
>  test_expect_success 'reflog for the branch shows state before rebase' '
> -	test $(git rev-parse branch1@{1}) = $(git rev-parse original-branch1)
> +	test_cmp_rev branch1@{1} original-branch1
>  '
>  
>  test_expect_success 'reflog for the branch shows correct finish message' '
> @@ -280,7 +280,7 @@ test_expect_success 'show conflicted patch' '
>  
>  test_expect_success 'abort' '
>  	git rebase --abort &&
> -	test $(git rev-parse new-branch1) = $(git rev-parse HEAD) &&
> +	test_cmp_rev new-branch1 HEAD &&
>  	test "$(git symbolic-ref -q HEAD)" = "refs/heads/branch1" &&
>  	test_path_is_missing .git/rebase-merge
>  '
> @@ -323,7 +323,7 @@ test_expect_success 'retain authorship w/ conflicts' '
>  	echo resolved >conflict &&
>  	git add conflict &&
>  	git rebase --continue &&
> -	test $(git rev-parse conflict-a^0) = $(git rev-parse HEAD^) &&
> +	test_cmp_rev conflict-a^0 HEAD^ &&
>  	git show >out &&
>  	grep AttributeMe out
>  '
> @@ -340,7 +340,7 @@ test_expect_success 'squash' '
>  			git rebase -i --onto master HEAD~2
>  	) &&
>  	test B = $(cat file7) &&
> -	test $(git rev-parse HEAD^) = $(git rev-parse master)
> +	test_cmp_rev HEAD^ master
>  '
>  
>  test_expect_success 'retain authorship when squashing' '
> @@ -399,9 +399,9 @@ test_expect_success REBASE_P 'preserve merges with -p' '
>  	git update-index --refresh &&
>  	git diff-files --quiet &&
>  	git diff-index --quiet --cached HEAD -- &&
> -	test $(git rev-parse HEAD~6) = $(git rev-parse branch1) &&
> -	test $(git rev-parse HEAD~4^2) = $(git rev-parse to-be-preserved) &&
> -	test $(git rev-parse HEAD^^2^) = $(git rev-parse HEAD^^^) &&
> +	test_cmp_rev HEAD~6 branch1 &&
> +	test_cmp_rev HEAD~4^2 to-be-preserved &&
> +	test_cmp_rev HEAD^^2^ HEAD^^^ &&
>  	test $(git show HEAD~5:file1) = B &&
>  	test $(git show HEAD~3:file1) = C &&
>  	test $(git show HEAD:file1) = E &&
> @@ -433,7 +433,7 @@ test_expect_success '--continue tries to commit' '
>  		git add file1 &&
>  		FAKE_COMMIT_MESSAGE="chouette!" git rebase --continue
>  	) &&
> -	test $(git rev-parse HEAD^) = $(git rev-parse new-branch1) &&
> +	test_cmp_rev HEAD^ new-branch1 &&
>  	git show HEAD | grep chouette
>  '
>  
> @@ -740,7 +740,7 @@ test_expect_success 'do "noop" when there is nothing to cherry-pick' '
>  		--author="Somebody else <somebody@else.com>" &&
>  	test $(git rev-parse branch3) != $(git rev-parse branch4) &&
>  	git rebase -i branch3 &&
> -	test $(git rev-parse branch3) = $(git rev-parse branch4)
> +	test_cmp_rev branch3 branch4
>  
>  '
>  
> @@ -799,7 +799,7 @@ test_expect_success 'rebase -i continue with unstaged submodule' '
>  	test_must_fail git rebase -i submodule-base &&
>  	git reset &&
>  	git rebase --continue &&
> -	test $(git rev-parse submodule-base) = $(git rev-parse HEAD)
> +	test_cmp_rev submodule-base HEAD
>  '
>  
>  test_expect_success 'avoid unnecessary reset' '
> @@ -822,7 +822,7 @@ test_expect_success 'reword' '
>  			git rebase -i A &&
>  		git show HEAD | grep "E changed" &&
>  		test $(git rev-parse master) != $(git rev-parse HEAD) &&
> -		test $(git rev-parse master^) = $(git rev-parse HEAD^) &&
> +		test_cmp_rev master^ HEAD^ &&
>  		FAKE_LINES="1 2 reword 3 4" FAKE_COMMIT_MESSAGE="D changed" \
>  			git rebase -i A &&
>  		git show HEAD^ | grep "D changed" &&
> @@ -886,7 +886,7 @@ test_expect_success 'always cherry-pick with --no-ff' '
>  		git diff HEAD~$p original-no-ff-branch~$p > out &&
>  		test_must_be_empty out
>  	done &&
> -	test $(git rev-parse HEAD~3) = $(git rev-parse original-no-ff-branch~3) &&
> +	test_cmp_rev HEAD~3 original-no-ff-branch~3 &&
>  	git diff HEAD~3 original-no-ff-branch~3 > out &&
>  	test_must_be_empty out
>  '
