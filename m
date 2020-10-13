Return-Path: <SRS0=7dzq=DU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF195C433E7
	for <git@archiver.kernel.org>; Tue, 13 Oct 2020 06:38:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 859E2208D5
	for <git@archiver.kernel.org>; Tue, 13 Oct 2020 06:38:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389603AbgJMGiv convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Tue, 13 Oct 2020 02:38:51 -0400
Received: from mx.pao1.isc.org ([149.20.64.53]:21168 "EHLO mx.pao1.isc.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389308AbgJMGiv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Oct 2020 02:38:51 -0400
Received: from zmx1.isc.org (zmx1.isc.org [149.20.0.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx.pao1.isc.org (Postfix) with ESMTPS id 06B413AB092;
        Tue, 13 Oct 2020 06:38:51 +0000 (UTC)
Received: from zmx1.isc.org (localhost [127.0.0.1])
        by zmx1.isc.org (Postfix) with ESMTPS id E7ED316003E;
        Tue, 13 Oct 2020 06:38:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by zmx1.isc.org (Postfix) with ESMTP id CC538160053;
        Tue, 13 Oct 2020 06:38:50 +0000 (UTC)
Received: from zmx1.isc.org ([127.0.0.1])
        by localhost (zmx1.isc.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id GsNeZuqKsLfG; Tue, 13 Oct 2020 06:38:50 +0000 (UTC)
Received: from larwa.hq.kempniu.pl (unknown [212.180.223.213])
        by zmx1.isc.org (Postfix) with ESMTPSA id E5D6B16003E;
        Tue, 13 Oct 2020 06:38:49 +0000 (UTC)
Date:   Tue, 13 Oct 2020 08:38:46 +0200
From:   =?utf-8?B?TWljaGHFgiBLxJlwaWXFhA==?= <michal@isc.org>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 3/3] t: add -I<regex> tests
Message-ID: <20201013063846.GF3278@larwa.hq.kempniu.pl>
References: <20201001120606.25773-1-michal@isc.org>
 <20201012091751.19594-1-michal@isc.org>
 <20201012091751.19594-4-michal@isc.org>
 <nycvar.QRO.7.76.6.2010121320190.50@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.2010121320190.50@tvgsbejvaqbjf.bet>
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Johannes,

> > Exercise the new -I<regex> diff option in various scenarios to ensure it
> > behaves as expected.
> 
> Excellent. I was actually looking for a test in patch 2/3 and almost
> commented about that.

Right, I expressed my doubts in this area at the end of the cover letter
for v1:

>>   - Should tests be added in a separate commit?  This is what I did as I
>>     thought it would help with readability, but...

I will be glad to follow any guidance provided, I just picked one of the
two possible routes for v1.

> Hmm. I wonder whether we could do with a much more concise test script.
> The test suite already takes a quite long time to run, which is not a
> laughing matter: we had issues in the past where contributors would skip
> running it because it took too long, and this test is sure to exacerbate
> that problem.

First, let me say that the goal of minimizing the run time of a test
suite is close to my heart (it is an issue at my day job).  Yet, I
assumed that this new test would not be detrimental to test suite run
times as it takes about half a second to run t4069-diff-ignore-regex.sh
on my machine - and (I hope) its contents are in line with the "tests
are the best documentation" proverb.  That being said, I realize that
the hosts used in various test environments may have different
processing capabilities.  I tried preparing something exhaustive and
well-commented, so that it is clear what to expect from the new feature.
Yet, if you would rather have me cut some things out, I am certainly not
particularly attached to the tests from patch 3 and I will be glad to
rip them out if that is the recommendation :-)

> I could imagine, for example, that it would be plenty enough to do
> something like this instead:
> 
> -- snip --
> diff --git a/t/t4013-diff-various.sh b/t/t4013-diff-various.sh
> index 5c7b0122b4f..bf158be137f 100755
> --- a/t/t4013-diff-various.sh
> +++ b/t/t4013-diff-various.sh
> @@ -6,6 +6,7 @@
>  test_description='Various diff formatting options'
> 
>  . ./test-lib.sh
> +. "$TEST_DIRECTORY"/diff-lib.sh
> 
>  test_expect_success setup '
> 
> @@ -473,4 +474,24 @@ test_expect_success 'diff-tree --stdin with log formatting' '
>  	test_cmp expect actual
>  '
> 
> +test_expect_success '-I<regex>' '
> +	seq 50 >I.txt &&
> +	sed -e "s/13/ten and three/" -e "/7\$/d" <I.txt >J.txt &&
> +	test_must_fail git diff --no-index -I"ten.*e" -I"^[124-9]" I.txt J.txt >actual &&
> +	cat >expect <<-\EOF &&
> +	diff --git a/I.txt b/J.txt
> +	--- a/I.txt
> +	+++ b/J.txt
> +	@@ -34,7 +31,6 @@
> +	 34
> +	 35
> +	 36
> +	-37
> +	 38
> +	 39
> +	 40
> +	EOF
> +	compare_diff_patch expect actual
> +'
> +
>  test_done
> -- snap --
> 
> Note how it tests various things in one go?

Right, neat, though this does not (yet) test:

  - the interaction between -I and --ignore-blank-lines (this is visible
    in code coverage),

  - whether the list of hunks emitted varies for different -U<n> values,

  - diffstat with -I<regex>,

  - invalid regular expressions.

Would you like me to add these tests to your proposal or to skip them,
given that -I uses the same field for marking changes as ignored as
--ignore-blank-lines does?

> P.S.: My main interest in the `-I` option is its use case for `git
> range-diff` in Git's own context: if you want to compare your patches to
> what entered the `seen` branch, there will _always_ be a difference
> because Junio adds their DCO. Something like this can help that:
> 
> git range-diff \
> 	-I'^    Signed-off-by: Junio C Hamano <gitster@pobox.com>$' \
> 	<my-patch-range> <the-equivalent-in-seen>

Right, makes sense, I have not thought of that use case.

-- 
Best regards,
Michał Kępień
