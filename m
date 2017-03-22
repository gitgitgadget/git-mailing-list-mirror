Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 08C6F20323
	for <e@80x24.org>; Wed, 22 Mar 2017 21:07:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754041AbdCVVHj (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Mar 2017 17:07:39 -0400
Received: from cloud.peff.net ([104.130.231.41]:49641 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932746AbdCVVHi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Mar 2017 17:07:38 -0400
Received: (qmail 25399 invoked by uid 109); 22 Mar 2017 21:07:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 22 Mar 2017 21:07:37 +0000
Received: (qmail 31109 invoked by uid 111); 22 Mar 2017 21:07:51 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 22 Mar 2017 17:07:51 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 22 Mar 2017 17:07:33 -0400
Date:   Wed, 22 Mar 2017 17:07:33 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Stefan Beller <sbeller@google.com>, git@vger.kernel.org,
        Jan Palus <jan.palus@gmail.com>
Subject: Re: [PATCH 2/3] t7406: fix here-doc syntax errors
Message-ID: <20170322210733.ohb7duy7bmmon6ny@sigill.intra.peff.net>
References: <20170322173528.ho43ulndlozq35tu@kalarepa>
 <20170322200805.23837-1-gitster@pobox.com>
 <20170322200805.23837-3-gitster@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170322200805.23837-3-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 22, 2017 at 01:08:04PM -0700, Junio C Hamano wrote:

> diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
> index 347857fa7c..a20df9420a 100755
> --- a/t/t7406-submodule-update.sh
> +++ b/t/t7406-submodule-update.sh
> @@ -442,9 +442,9 @@ test_expect_success 'submodule update - command in .git/config catches failure -
>  '
>  
>  test_expect_success 'submodule update - command run for initial population of submodule' '
> -	cat <<-\ EOF >expect
> +	cat >expect <<-\EOF &&
>  	Execution of '\''false $submodulesha1'\'' failed in submodule path '\''submodule'\''
> -	EOF &&
> +	EOF

After applying this, I get a failure:

  --- expect	2017-03-22 21:01:53.350721155 +0000
  +++ actual	2017-03-22 21:01:53.346721155 +0000
  @@ -1 +1 @@
  -Execution of 'false $submodulesha1' failed in submodule path 'submodule'
  +Execution of 'false 4301fd3e4110d3b6212c19aed3094150392545b9' failed in submodule path '../submodule'

At the very least, we need to drop the "\" from EOF to expand
$submodulesha1. But the submodule path seems wrong, too. I'm not sure if
the expectation is wrong, or if there's a bug. +cc Stefan

-Peff
