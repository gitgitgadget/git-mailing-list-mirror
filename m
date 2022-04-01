Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C3BAC433EF
	for <git@archiver.kernel.org>; Fri,  1 Apr 2022 20:11:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351971AbiDAUNi (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Apr 2022 16:13:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351999AbiDAUN1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Apr 2022 16:13:27 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32B1B226A16
        for <git@vger.kernel.org>; Fri,  1 Apr 2022 13:11:23 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9552F11FFC8;
        Fri,  1 Apr 2022 16:11:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=4kS+dUn/zeDw51q5aC5L8ZKzXAggO2zGi2G/hh
        XfvVc=; b=iD2s1xjo9KpQpIZIWO2yAHXyqCDKbTy8bR7ianoWezdBSPlrUyofj5
        MuIeKRrMqK086X7x/14X+GXIDJi3XF2CwOeoBHs6+9AcFQRclP19QeM7X5EkYyOC
        77p4FoXT77SEtuT9uChMXoe39qJzgpfCc3gl7sPWDZE22DXiBtgfU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8D88611FFC6;
        Fri,  1 Apr 2022 16:11:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.227.145.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E756211FFC5;
        Fri,  1 Apr 2022 16:11:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elia Pinto <gitter.spiros@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] t5510-fetch: upgrade to a more modern style
References: <20220331175412.305968-1-gitter.spiros@gmail.com>
Date:   Fri, 01 Apr 2022 13:11:20 -0700
In-Reply-To: <20220331175412.305968-1-gitter.spiros@gmail.com> (Elia Pinto's
        message of "Thu, 31 Mar 2022 17:54:12 +0000")
Message-ID: <xmqqo81kva1j.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E640424A-B1F7-11EC-B57D-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elia Pinto <gitter.spiros@gmail.com> writes:

> Clean up the code style so all the tests, and not just a few,
> that chdir around isolate themselves in a subshell.
>
> Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
> ---
> this patch was inspired by a Junio #leftoverbit
> https://lore.kernel.org/git/xmqqmtjh0x5f.fsf@gitster.g/
>  t/t5510-fetch.sh | 927 ++++++++++++++++++++++++-----------------------
>  1 file changed, 477 insertions(+), 450 deletions(-)
>
> diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
> index 6f38a69fbb..d0b249d276 100755
> --- a/t/t5510-fetch.sh
> +++ b/t/t5510-fetch.sh
> @@ -48,342 +48,349 @@ test_expect_success "clone and setup child repos" '
>  '
>  
>  test_expect_success "fetch test" '
> -	cd "$D" &&
> -	echo >file updated by origin &&
> -	git commit -a -m "updated by origin" &&
> -	cd two &&
> -	git fetch &&
> -	git rev-parse --verify refs/heads/one &&
> -	mine=$(git rev-parse refs/heads/one) &&
> -	his=$(cd ../one && git rev-parse refs/heads/main) &&
> -	test "z$mine" = "z$his"
> +	(
> +		cd "$D" &&
> +		echo >file updated by origin &&
> +		git commit -a -m "updated by origin" &&
> +		(
> +			cd two &&
> +			git fetch &&
> +			git rev-parse --verify refs/heads/one &&
> +			mine=$(git rev-parse refs/heads/one) &&
> +			his=$(cd ../one && git rev-parse refs/heads/main) &&
> +			test "z$mine" = "z$his"
> +		)
> +	)
>  '

I think the idea of the "first unconditionally go to $D and then do
these things" pattern was that these tests anticipate that the step
before them will leave the process in an unexpected directory when
they begin.  If the original version of this test fails when we
created the first commit "updated by origin", the next test piece
will start in "$D" directory, and if we successfully run it to the
end, the next test piece will start in "$D/ two".

Now, the point of this patch is to make sure each test piece will
not chdir around by isolating the parts that run in different
directories inside subshells.  The purpose of doing so is?  It is to
relieve later tests from having to worry about "going back to the
known starting place".

So, it is dubious that we want the subshell around the whole thing,
whose first command is to go to "$D", after we apply this patch.
Removal of that part was the primary reason why we are writing this
patch.

So I'd expect that the above test piece would become more like
in "git diff -w" output.

It is important to notice that the reason why we had 'cd "$D"' in
this test is *not* because the previous test has chdir'ed around,
but to look similar to later tests in the series.

Thanks.


diff --git c/t/t5510-fetch.sh w/t/t5510-fetch.sh
index 6f38a69fbb..1ed27607e2 100755
--- c/t/t5510-fetch.sh
+++ w/t/t5510-fetch.sh
@@ -48,15 +48,16 @@ test_expect_success "clone and setup child repos" '
 '
 
 test_expect_success "fetch test" '
-	cd "$D" &&
 	echo >file updated by origin &&
 	git commit -a -m "updated by origin" &&
+	(
 		cd two &&
 		git fetch &&
 		git rev-parse --verify refs/heads/one &&
 		mine=$(git rev-parse refs/heads/one) &&
 		his=$(cd ../one && git rev-parse refs/heads/main) &&
 		test "z$mine" = "z$his"
+	)
 '
 
 test_expect_success "fetch test for-merge" '
