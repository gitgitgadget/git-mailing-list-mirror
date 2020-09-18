Return-Path: <SRS0=7xvA=C3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9395C43464
	for <git@archiver.kernel.org>; Fri, 18 Sep 2020 18:10:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9648D20872
	for <git@archiver.kernel.org>; Fri, 18 Sep 2020 18:10:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726139AbgIRSK1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Sep 2020 14:10:27 -0400
Received: from cloud.peff.net ([104.130.231.41]:33622 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726007AbgIRSK1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Sep 2020 14:10:27 -0400
Received: (qmail 11662 invoked by uid 109); 18 Sep 2020 18:10:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 18 Sep 2020 18:10:27 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23784 invoked by uid 111); 18 Sep 2020 18:10:27 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 18 Sep 2020 14:10:27 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 18 Sep 2020 14:10:26 -0400
From:   Jeff King <peff@peff.net>
To:     Andrew Klotz via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Andrew Klotz <agc.klotz@gmail.com>
Subject: Re: [PATCH 1/2] config: improve error message for boolean config
Message-ID: <20200918181026.GA187490@coredump.intra.peff.net>
References: <pull.841.git.git.1600395427.gitgitgadget@gmail.com>
 <689d84672422dd96d1eb89ea6137e79ce4030248.1600395427.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <689d84672422dd96d1eb89ea6137e79ce4030248.1600395427.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 18, 2020 at 02:17:06AM +0000, Andrew Klotz via GitGitGadget wrote:

> diff --git a/t/t0205-gettext-poison.sh b/t/t0205-gettext-poison.sh
> index f9fa16ad83..b66d34c6f2 100755
> --- a/t/t0205-gettext-poison.sh
> +++ b/t/t0205-gettext-poison.sh
> @@ -33,7 +33,7 @@ test_expect_success 'eval_gettext: our eval_gettext() fallback has poison semant
>  
>  test_expect_success "gettext: invalid GIT_TEST_GETTEXT_POISON value doesn't infinitely loop" "
>  	test_must_fail env GIT_TEST_GETTEXT_POISON=xyz git version 2>error &&
> -	grep \"fatal: bad numeric config value 'xyz' for 'GIT_TEST_GETTEXT_POISON': invalid unit\" error
> +	grep \"fatal: bad boolean config value 'xyz' for 'GIT_TEST_GETTEXT_POISON'\" error
>  "

This test is pretty subtle and depends on gettext-poison's inner
workings. I wonder if it's worth adding a separate:

  git config --bool --default=foo does.not.exist

test in t1300 or similar.

-Peff
