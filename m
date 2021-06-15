Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55669C48BDF
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 09:34:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 28BF16140C
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 09:34:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231354AbhFOJgH convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Tue, 15 Jun 2021 05:36:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231327AbhFOJgG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Jun 2021 05:36:06 -0400
X-Greylist: delayed 576 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 15 Jun 2021 02:34:02 PDT
Received: from mailproxy05.manitu.net (mailproxy05.manitu.net [IPv6:2a00:1828:1000:1110::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A65FAC06175F
        for <git@vger.kernel.org>; Tue, 15 Jun 2021 02:34:02 -0700 (PDT)
Received: from localhost (200116b860a00300716b7f4f66be36b7.dip.versatel-1u1.de [IPv6:2001:16b8:60a0:300:716b:7f4f:66be:36b7])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: michael@grubix.eu)
        by mailproxy05.manitu.net (Postfix) with ESMTPSA id 3E0D71B60147;
        Tue, 15 Jun 2021 11:24:23 +0200 (CEST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
In-Reply-To: <patch-4.4-c54c6a7b205-20210614T171626Z-avarab@gmail.com>
References: <cover-0.4-00000000000-20210614T171626Z-avarab@gmail.com> <patch-4.4-c54c6a7b205-20210614T171626Z-avarab@gmail.com>
Subject: Re: [PATCH 4/4] show-branch tests: add missing tests
From:   Michael J Gruber <git@grubix.eu>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?utf-8?q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>
To:     git@vger.kernel.org,
        =?utf-8?q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>
Message-ID: <162374905722.40525.516266574605586007.git@grubix.eu>
Date:   Tue, 15 Jun 2021 11:24:17 +0200
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason venit, vidit, dixit 2021-06-14 19:18:10:
> Add missing tests for --remotes, --list and --merge-base. These are
> not exhaustive, but better than the nothing we have now.
> 
> There were some tests for this command added in f76412ed6db ([PATCH]
> Add 'git show-branch'., 2005-08-21) has never been properly tested,
> namely for the --all option in t6432-merge-recursive-space-options.sh,
> and some of --merge-base and --independent in t6010-merge-base.sh.
> 
> This fixes a few more blind spots, but there's still a lot of behavior
> that's not tested for.
> 
> These new tests show the add (and possibly unintentional) behavior of

"odd"

Other than that, I don't think show-branch was broken, so I somehow
contest the phrase "fix" in this series, it's more of a clean-up.

Just to be sure: Users have no way of assigning a color code with
background colors to the columns, which is why omitting
the lookup and reset is correct for a space.

Now, people scripting around show-branch might be bitten by that change
because the number of (unprocessed) characters in the output changes, or
because a control character which they used to "tr" is not there any more.
They should not (script this command), I guess.

> --merge-base with one argument, and how its output is the same as "git
> merge-base" with N bases in this particular case. See the test added
> in f621a8454d1 (git-merge-base/git-show-branch --merge-base:
> Documentation and test, 2009-08-05) for a case where the two aren't
> the same.
> 
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>  t/t3202-show-branch.sh | 61 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 61 insertions(+)
> 
> diff --git a/t/t3202-show-branch.sh b/t/t3202-show-branch.sh
> index 54025f03379..ad9902a06b9 100755
> --- a/t/t3202-show-branch.sh
> +++ b/t/t3202-show-branch.sh
> @@ -85,4 +85,65 @@ test_expect_success 'show-branch --color output' '
>         test_cmp expect actual
>  '
>  
> +test_expect_success 'show branch --remotes' '
> +       cat >expect.err <<-\EOF &&
> +       No revs to be shown.
> +       EOF
> +       git show-branch -r 2>actual.err >actual.out &&
> +       test_cmp expect.err actual.err &&
> +       test_must_be_empty actual.out
> +'
> +
> +test_expect_success 'setup show branch --list' '
> +       sed "s/^> //" >expect <<-\EOF
> +       >   [branch1] branch1
> +       >   [branch2] branch2
> +       >   [branch3] branch3
> +       >   [branch4] branch4
> +       >   [branch5] branch5
> +       >   [branch6] branch6
> +       >   [branch7] branch7
> +       >   [branch8] branch8
> +       >   [branch9] branch9
> +       > * [branch10] branch10
> +       EOF
> +'
> +
> +test_expect_success 'show branch --list' '
> +       git show-branch --list $(cat branches.sorted) >actual &&
> +       test_cmp expect actual
> +'
> +
> +test_expect_success 'show branch --list has no --color output' '
> +       git show-branch --color=always --list $(cat branches.sorted) >actual &&
> +       test_cmp expect actual
> +'
> +
> +test_expect_success 'show branch --merge-base with one argument' '
> +       for branch in $(cat branches.sorted)
> +       do
> +               git rev-parse $branch >expect &&
> +               git show-branch --merge-base $branch >actual &&
> +               test_cmp expect actual
> +       done
> +'
> +
> +test_expect_success 'show branch --merge-base with two arguments' '
> +       for branch in $(cat branches.sorted)
> +       do
> +               git rev-parse initial >expect &&
> +               git show-branch --merge-base initial $branch >actual &&
> +               test_cmp expect actual
> +       done
> +'
> +
> +test_expect_success 'show branch --merge-base with N arguments' '
> +       git rev-parse initial >expect &&
> +       git show-branch --merge-base $(cat branches.sorted) >actual &&
> +       test_cmp expect actual &&
> +
> +       git merge-base $(cat branches.sorted) >actual &&
> +       test_cmp expect actual
> +'
> +
>  test_done
> -- 
> 2.32.0.555.g0268d380f7b
>
