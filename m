Return-Path: <SRS0=RFRG=DC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBB09C4727E
	for <git@archiver.kernel.org>; Fri, 25 Sep 2020 20:54:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85FD92086A
	for <git@archiver.kernel.org>; Fri, 25 Sep 2020 20:54:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="RgsdRDXR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726487AbgIYUye (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Sep 2020 16:54:34 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:56053 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725272AbgIYUye (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Sep 2020 16:54:34 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 242CBED557;
        Fri, 25 Sep 2020 16:54:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=IbR+bRlwwnjHKSgzBoxrODAphSk=; b=RgsdRD
        XReM2athV2OeRZBmijR/dsCgV5KUz/dBWDakEBCk1hN6kQWJtJiQIS6QMirVhdPo
        JirQdI9QCUgfN3vbPrJ+te+ApehxB1+H3Y565cVczGNyYPmczqZ7VhGDgyu53pfp
        SVVNkEgh4nO9yyQdnNgzR7VSOxfKoG7EZHN9E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Td2xVwrEBfturfHazc3pKEoidaHNqQr3
        ucbOly0/M161QRXh98QLNe2gr1ArnlQPkkNEPMUCTRhcxIfth28dwnSImROc3NO9
        gfZIXTVkGV1Vbi2BfLdYbyUdK3hOaT5pxvTNv+kgikDk/MtOUTIuJdaIHY7H7KL1
        qo90LLiayZU=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 1DE72ED556;
        Fri, 25 Sep 2020 16:54:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 50842ED550;
        Fri, 25 Sep 2020 16:54:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     shubham verma <shubhunic@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 11/11] t7001: move cleanup code from outside the tests
 into them
References: <20200925170256.11490-1-shubhunic@gmail.com>
        <20200925170256.11490-12-shubhunic@gmail.com>
Date:   Fri, 25 Sep 2020 13:54:25 -0700
In-Reply-To: <20200925170256.11490-12-shubhunic@gmail.com> (shubham verma's
        message of "Fri, 25 Sep 2020 22:32:56 +0530")
Message-ID: <xmqqlfgxk266.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4CD21690-FF71-11EA-AC2A-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

shubham verma <shubhunic@gmail.com> writes:

> From: Shubham Verma <shubhunic@gmail.com>
>
> Let's use test_when_finished() to include cleanup code inside the tests,
> as it's cleaner and safer to not have any code outside the tests.
>
> Signed-off-by: shubham verma <shubhunic@gmail.com>
> ---
>  t/t7001-mv.sh | 25 +++++++++++--------------
>  1 file changed, 11 insertions(+), 14 deletions(-)
>
> diff --git a/t/t7001-mv.sh b/t/t7001-mv.sh
> index 7bb4a7b759..b4d04ceaf8 100755
> --- a/t/t7001-mv.sh
> +++ b/t/t7001-mv.sh
> @@ -32,6 +32,7 @@ test_expect_success 'commiting the change' '
>  '
>  
>  test_expect_success 'checking the commit' '
> +	test_when_finished "rmdir path1" &&
>  	git diff-tree -r -M --name-status  HEAD^ HEAD >actual &&
>  	grep "^R100..*path1/COPYING..*path0/COPYING" actual
>  '

Sorry, but why in this test?  It only runs diff-tree and runs grep,
neither of which changes any state in the repository.  Because the
test does *not* create path1, and having or not having path1 on the
filesystem would not affect the outcome of the test, I do not see
how it makes sense to use test_when_finished in here.

If you are saying that path1 will no longer be used after this test
finishes, test_when_finished should be done in the test before this
one that used path1 the last, because this test does not care.  It
is probably the one that moves the file out of path1 back to path0
and records the result as a commit with title "move-in" (although if
I were writing this test today, I would merge the "move and commit"
into one step).

> @@ -43,6 +44,7 @@ test_expect_success 'mv --dry-run does not move file' '
>  '
>  
>  test_expect_success 'checking -k on non-existing file' '
> +	test_when_finished "rm -f idontexist path0/idontexist" &&
>  	git mv -k idontexist path0
>  '

I do not see the point of "rm -f idontexist" in the
post-test-cleanup at all.  Some might see that path0/ideontexist is
worth having there, in case the "mv" command gets so broken that it
creates such a file by mistake, but Personally I'd prefer to use
test_when_finished to clean up the side effects we _expect_ to
cause.  We cannot anticipate each and every breakage.

The other side of the coin is that this test DEPENDS ON the fact
that idontexist does *NOT* exist before it runs "git mv -k
idontexist path0", but nobody before us gives us any explicitly
guarantee.  This test also depends on the presence of path0
directory the same way.  Instead of relying on others that came
before us to have cleaned after themselves for us, we can more
explicitly protect ourselves by making sure the pre-condition we
depend on holds.  I.e.

    test_expect_success 'mv -k on non-exising file would not fail' '
	mkdir -p path0 &&
	rm -f idontexist path0/idontexist &&
	git mv -k idontexist path0
    '

A broken "git mv" may or may not leave path0/idontexist behind, but
as long as the tests that come after us protect themselves with the
same principle of making sure the preconditions they care about do
hold, we do not necessarily have to clean after ourselves.  Since we
expect we do not leave any side effect, I'd rather not to use
test_when_finished here.

@@ -55,6 +57,7 @@ test_expect_success 'checking -k on untracked file' '
>  
>  test_expect_success 'checking -k on multiple untracked files' '
>  	: > untracked2 &&
> +	test_when_finished "rm -f untracked2 path0/untracked2" &&
>  	git mv -k untracked1 untracked2 path0 &&
>  	test -f untracked1 &&
>  	test -f untracked2 &&

An exercise to readers.  Explain why

 - we want to move test_when_finished _before_ ">untracked2" is created;

 - "rm -f untrackd2" in test_when_finished is a good idea;

 - "rm -f path0/untracked2" is not a good idea;

 - we may want to do

	>untracked1 &&
	mkdir -p path0 &&

   before "git mv -k ..." is tested.

> -# clean up the mess in case bad things happen
> -rm -f idontexist untracked1 untracked2 \
> -     path0/idontexist path0/untracked1 path0/untracked2 \
> -     .git/index.lock
> -rmdir path1
> -
>  test_expect_success 'moving to absent target with trailing slash' '
>  	test_must_fail git mv path0/COPYING no-such-dir/ &&
>  	test_must_fail git mv path0/COPYING no-such-dir// &&

It may be a better approach to move the above removals at the
beginning of this test, just before the first test_must_fail line.

> -rm -fr papers partA path?
> -
>  test_expect_success "Sergey Vlasov's test case" '

Likewise.
