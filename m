Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 91C691F453
	for <e@80x24.org>; Tue, 30 Oct 2018 11:17:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727610AbeJ3UKb (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Oct 2018 16:10:31 -0400
Received: from mail.ao2.it ([92.243.12.208]:50135 "EHLO ao2.it"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727603AbeJ3UKb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Oct 2018 16:10:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=ao2.it; s=20180927;
        h=Content-Transfer-Encoding:Content-Type:Mime-Version:References:In-Reply-To:Message-Id:Subject:Cc:To:From:Date; bh=eQQIfVhNesCom2y9MVPY1MxYxSMXvbySFk/i/CSdjIg=;
        b=pII9L+pzCJwjBfmBEl3zqienGdxpdaWmOXPctms4o2GBbpxDbitMdNko0ibOFOpWlnjyUPcmhQyBILQZMpKRgcIgWd6bznzOBj91ZgOv706ipWKrIIkY7FYDC653lXsBWvJU/GURudaUEhzhum8k9ZnHQnCTL0YkKzo8FduqeKy8fmNTvU5v8tpICdj3s2YuTzcrHCkQ1dNcvzPdlY7UdoRIIW29ICf48IthVr6xBC0+xds3QS16p1pDJOnx9os7w75/rmA+kB8Hm9mUY4JXiLjos5BgMA1BEeeP+PgossXw0pAc6gZw16dPSA+WQifXkXvhjRP8Wt3Lz2fJrWoUnQ==;
Received: from localhost ([::1] helo=jcn.localdomain)
        by ao2.it with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ao2@ao2.it>)
        id 1gHS19-0002IU-30; Tue, 30 Oct 2018 12:17:03 +0100
Date:   Tue, 30 Oct 2018 12:16:30 +0100
From:   Antonio Ospite <ao2@ao2.it>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     gitster@pobox.com, git@vger.kernel.org,
        Jonathan Nieder <jrnieder@gmail.com>,
        Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
        SZEDER =?ISO-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v7 09/10] submodule: support reading .gitmodules when
 it's not in the working tree
Message-Id: <20181030121630.0aec137f670bd5d3486cccc5@ao2.it>
In-Reply-To: <nycvar.QRO.7.76.6.1810301053540.4546@tvgsbejvaqbjf.bet>
References: <20181025161813.17252-1-ao2@ao2.it>
        <20181025161813.17252-10-ao2@ao2.it>
        <nycvar.QRO.7.76.6.1810301053540.4546@tvgsbejvaqbjf.bet>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-unknown-linux-gnu)
X-Face: z*RaLf`X<@C75u6Ig9}{oW$H;1_\2t5)({*|jhM<pyWR#k60!#=#>/Vb;]yA5<GWI5`6u&+
 ;6b'@y|8w"wB;4/e!7wYYrcqdJFY,~%Gk_4]cq$Ei/7<j&N3ah(m`ku?pX.&+~:_/wC~dwn^)MizBG !pE^+iDQQ1yC6^,)YDKkxDd!T>\I~93>J<_`<4)A{':UrE
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 30 Oct 2018 10:57:09 +0100 (STD)
Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:

> Hi Antonio,
>

Hi Johannes,

> On Thu, 25 Oct 2018, Antonio Ospite wrote:
> 
> > diff --git a/t/t7418-submodule-sparse-gitmodules.sh b/t/t7418-submodule-sparse-gitmodules.sh
> > new file mode 100755
[...]
> > +	echo "$PWD/submodule" >expect &&
> 
> Would you mind squashing this fixup in?
> 
> -- snip --
> diff --git a/t/t7418-submodule-sparse-gitmodules.sh b/t/t7418-submodule-sparse-gitmodules.sh
> index 21a86b89c6cb..3f7f27188313 100755
> --- a/t/t7418-submodule-sparse-gitmodules.sh
> +++ b/t/t7418-submodule-sparse-gitmodules.sh
> @@ -55,7 +55,7 @@ test_expect_success 'initialising submodule when the gitmodules config is not ch
>  	test_must_fail git -C super config submodule.submodule.url &&
>  	git -C super submodule init &&
>  	git -C super config submodule.submodule.url >actual &&
> -	echo "$PWD/submodule" >expect &&
> +	echo "$(pwd)/submodule" >expect &&
>  	test_cmp expect actual
>  '
>  
> -- snap --
> 
> On Windows, `$PWD` and `$(pwd)` are *not* synonymous. The former
> reflects the "Unix path" which is understood by the Bash script (and
> only by the Bash script, *not* by `git.exe`!) while the latter refers to
> the actual Windows path.
>

I see, this is also mentioned in t/README, I had overlooked that part.
Thank you for reporting.

> Without this fix, your new test case will fail on Windows all the time,
> see e.g.
> https://git-for-windows.visualstudio.com/git/_build/results?buildId=22913&view=logs
> 

Junio, what is the plan for 'ao/submodule-wo-gitmodules-checked-out'?
I see it's not in next yet; do you want me to resend the whole series
with this fixup in or would it be less overhead for you to apply it
directly to patch 9/10 from v7 of the series?

Thank you,
   Antonio

P.S. I was wondering if it is worth having patchset versions mentioned
somewhere in pu/, maybe in merge commits if not in branch names?
Or at least in whats-cooking.txt next to the date.

-- 
Antonio Ospite
https://ao2.it
https://twitter.com/ao2it

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?
