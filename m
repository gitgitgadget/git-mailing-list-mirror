Return-Path: <SRS0=vH5l=CZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 490F2C433E2
	for <git@archiver.kernel.org>; Wed, 16 Sep 2020 18:38:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 091E021974
	for <git@archiver.kernel.org>; Wed, 16 Sep 2020 18:38:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728206AbgIPSiW (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Sep 2020 14:38:22 -0400
Received: from cloud.peff.net ([104.130.231.41]:58648 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728192AbgIPSiT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Sep 2020 14:38:19 -0400
Received: (qmail 25677 invoked by uid 109); 16 Sep 2020 18:38:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 16 Sep 2020 18:38:14 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31096 invoked by uid 111); 16 Sep 2020 18:38:14 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 16 Sep 2020 14:38:14 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 16 Sep 2020 14:38:13 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Matthieu Moy <git@matthieu-moy.fr>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Antoine =?utf-8?Q?Beaupr=C3=A9?= <anarcat@debian.org>,
        Simon Legner <Simon.Legner@gmail.com>
Subject: Re: [PATCH 06/15] remote-mediawiki tests: use test_cmp in tests
Message-ID: <20200916183813.GA33925@coredump.intra.peff.net>
References: <20200916102918.29805-1-avarab@gmail.com>
 <20200916102918.29805-7-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200916102918.29805-7-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 16, 2020 at 12:29:09PM +0200, Ævar Arnfjörð Bjarmason wrote:

> Change code that used an ad-hoc diff invocation to use our test_cmp
> helper instead. I'm also changing the order of arguments to be the
> standard "test_cmp <expected> <actual>".

Definitely a positive direction, but...

> diff --git a/contrib/mw-to-git/t/t9360-mw-to-git-clone.sh b/contrib/mw-to-git/t/t9360-mw-to-git-clone.sh
> index 9106833578..4c39bda7bf 100755
> --- a/contrib/mw-to-git/t/t9360-mw-to-git-clone.sh
> +++ b/contrib/mw-to-git/t/t9360-mw-to-git-clone.sh
> @@ -28,7 +28,7 @@ test_expect_success 'Git clone creates the expected git log with one file' '
>  		git log --format=%s HEAD^..HEAD >log.tmp
>  	) &&
>  	echo "this must be the same" >msg.tmp &&
> -	diff -b mw_dir_1/log.tmp msg.tmp
> +	test_cmp msg.tmp mw_dir_1/log.tmp
>  '

...the original was ignoring whitespace. Is that not important?

-Peff
