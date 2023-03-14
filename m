Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CEE8C7618B
	for <git@archiver.kernel.org>; Tue, 14 Mar 2023 09:00:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230319AbjCNJAw convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Tue, 14 Mar 2023 05:00:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230210AbjCNJAr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Mar 2023 05:00:47 -0400
X-Greylist: delayed 521 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 14 Mar 2023 02:00:40 PDT
Received: from mailproxy05.manitu.net (mailproxy05.manitu.net [217.11.48.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7E0E7E7B1
        for <git@vger.kernel.org>; Tue, 14 Mar 2023 02:00:40 -0700 (PDT)
Received: from localhost (unknown [IPv6:2001:9e8:6a73:3a00:7381:443c:be39:72b2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: michael@grubix.eu)
        by mailproxy05.manitu.net (Postfix) with ESMTPSA id 607E51B6012E;
        Tue, 14 Mar 2023 09:51:57 +0100 (CET)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20230312201520.370234-2-rybak.a.v@gmail.com>
References: <20230312201520.370234-1-rybak.a.v@gmail.com> <20230312201520.370234-2-rybak.a.v@gmail.com>
Subject: Re: [PATCH v1 1/7] t1005: assert output of ls-files
From:   Michael J Gruber <git@grubix.eu>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?utf-8?q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Jeff King <peff@peff.net>,
        Patrick Steinhardt <ps@pks.im>,
        Michael Haggerty <mhagger@alum.mit.edu>
To:     Andrei Rybak <rybak.a.v@gmail.com>, git@vger.kernel.org
Message-ID: <167878391659.3913.5697119728018854973.git@grubix.eu>
Date:   Tue, 14 Mar 2023 09:51:56 +0100
User-Agent: alot/0.10
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Andrei Rybak venit, vidit, dixit 2023-03-12 21:15:13:
> Test 'reset should work' in t1005-read-tree-reset.sh compares two files
> "expect" and "actual" to assert the expected output of "git ls-files".
> Several other tests in the same file also create files "expect" and
> "actual", but don't use them in assertions.
> 
> Assert output of "git ls-files" in t1005-read-tree-reset.sh to improve
> test coverage.
> 
> Signed-off-by: Andrei Rybak <rybak.a.v@gmail.com>
> ---
>  t/t1005-read-tree-reset.sh | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
> 
> diff --git a/t/t1005-read-tree-reset.sh b/t/t1005-read-tree-reset.sh
> index 12e30d77d0..26be4a2b5a 100755
> --- a/t/t1005-read-tree-reset.sh
> +++ b/t/t1005-read-tree-reset.sh
> @@ -41,7 +41,8 @@ test_expect_success 'reset should remove remnants from a failed merge' '
>         git ls-files -s &&
>         read_tree_u_must_succeed --reset -u HEAD &&
>         git ls-files -s >actual &&
> -       ! test -f old
> +       ! test -f old &&
> +       test_cmp expect actual
>  '
>  
>  test_expect_success 'two-way reset should remove remnants too' '
> @@ -56,7 +57,8 @@ test_expect_success 'two-way reset should remove remnants too' '
>         git ls-files -s &&
>         read_tree_u_must_succeed --reset -u HEAD HEAD &&
>         git ls-files -s >actual &&
> -       ! test -f old
> +       ! test -f old &&
> +       test_cmp expect actual
>  '
>  
>  test_expect_success 'Porcelain reset should remove remnants too' '
> @@ -71,7 +73,8 @@ test_expect_success 'Porcelain reset should remove remnants too' '
>         git ls-files -s &&
>         git reset --hard &&
>         git ls-files -s >actual &&
> -       ! test -f old
> +       ! test -f old &&
> +       test_cmp expect actual
>  '
>  
>  test_expect_success 'Porcelain checkout -f should remove remnants too' '
> @@ -86,7 +89,8 @@ test_expect_success 'Porcelain checkout -f should remove remnants too' '
>         git ls-files -s &&
>         git checkout -f &&
>         git ls-files -s >actual &&
> -       ! test -f old
> +       ! test -f old &&
> +       test_cmp expect actual
>  '
>  
>  test_expect_success 'Porcelain checkout -f HEAD should remove remnants too' '
> @@ -101,7 +105,8 @@ test_expect_success 'Porcelain checkout -f HEAD should remove remnants too' '
>         git ls-files -s &&
>         git checkout -f HEAD &&
>         git ls-files -s >actual &&
> -       ! test -f old
> +       ! test -f old &&
> +       test_cmp expect actual
>  '
>  
>  test_done
> -- 
> 2.39.2
> 

Just in case someone else was wondering, too:

All these subtests write to `expect` just before the provided context
lines, so there indeed is something to compare to, and it is the output
of `git ls-files -s` before any changes and resets. As a consequence,
these subtests checked only removal of remnants in the woring tree
before the patch, and they check removal of index bits after the patch
(additionally).

Looks fine to me - though one could probably use `git ls-files -s -o` or
such instead, the suggested version is more "explicit".

Michael
