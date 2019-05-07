Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BE57B1F45F
	for <e@80x24.org>; Tue,  7 May 2019 07:19:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726906AbfEGHTc (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 May 2019 03:19:32 -0400
Received: from cloud.peff.net ([104.130.231.41]:49864 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726828AbfEGHTb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 May 2019 03:19:31 -0400
Received: (qmail 17892 invoked by uid 109); 7 May 2019 07:19:31 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 07 May 2019 07:19:31 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8894 invoked by uid 111); 7 May 2019 07:20:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 07 May 2019 03:20:07 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 07 May 2019 03:19:29 -0400
Date:   Tue, 7 May 2019 03:19:29 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v2 1/2] perf-lib.sh: make "./run <revisions>" use the
 correct gits
Message-ID: <20190507071929.GC28060@sigill.intra.peff.net>
References: <20190506202451.GA19850@sigill.intra.peff.net>
 <20190506232309.28538-2-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190506232309.28538-2-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 07, 2019 at 01:23:08AM +0200, Ævar Arnfjörð Bjarmason wrote:

> diff --git a/t/perf/perf-lib.sh b/t/perf/perf-lib.sh
> index 169f92eae3..b15ee1d262 100644
> --- a/t/perf/perf-lib.sh
> +++ b/t/perf/perf-lib.sh
> @@ -32,6 +32,10 @@ TEST_NO_MALLOC_CHECK=t
>  if test -z "$GIT_TEST_INSTALLED"; then
>  	perf_results_prefix=
>  else
> +	if test -n "$GIT_PERF_DIR_MYDIR_REL"
> +	then
> +		GIT_TEST_INSTALLED=$GIT_PERF_DIR_MYDIR_REL
> +	fi
>  	perf_results_prefix=$(printf "%s" "${GIT_TEST_INSTALLED%/bin-wrappers}" | tr -c "[a-zA-Z0-9]" "[_*]")"."
>  	GIT_TEST_INSTALLED=$ABSOLUTE_GIT_TEST_INSTALLED
>  fi

I still like my fix better, as it works completely within perf-lib.sh,
and so is a more direct fix.  And doesn't have this weird exported
MYDIR_ABS that nobody actually uses.

But I don't actually think this topic is worth spending too many brain
cycles on. So I am fine with either fix, as long as we do something.

-Peff
