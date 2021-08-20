Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D6FEC432BE
	for <git@archiver.kernel.org>; Fri, 20 Aug 2021 09:26:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 044E260C3E
	for <git@archiver.kernel.org>; Fri, 20 Aug 2021 09:26:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236546AbhHTJ1U (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Aug 2021 05:27:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236602AbhHTJ1K (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Aug 2021 05:27:10 -0400
Received: from host1.jankratochvil.net (host1.jankratochvil.net [IPv6:2a02:2b88:6:3b57::1f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA07BC06175F
        for <git@vger.kernel.org>; Fri, 20 Aug 2021 02:26:31 -0700 (PDT)
Received: from host1.jankratochvil.net (localhost [127.0.0.1])
        by host1.jankratochvil.net (8.16.1/8.16.1) with ESMTPS id 17K9QS9E2787888
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Fri, 20 Aug 2021 11:26:28 +0200
DKIM-Filter: OpenDKIM Filter v2.11.0 host1.jankratochvil.net 17K9QS9E2787888
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jankratochvil.net;
        s=default; t=1629451588;
        bh=7kE2D8BKCHJWC6cKktozFhpa+CIiIentx+LFFq2M694=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UlENhodFz1n9hH04OXsSB2cWGcVoAJDbjTeD/6YvFkXXpqkVfCj8dAE0JH0+iqPQQ
         ytN3c7Whv1yEXe8cwvIM9AITZA1WmDQfUET4vP8r49FE0pJjFp9uaytpArdoIA2wao
         wsBdULTiyY8jAXMtuQWDfliTR+OLlMGPB1AycU1g=
Received: (from lace@localhost)
        by host1.jankratochvil.net (8.16.1/8.16.1/Submit) id 17K9QSqS2787887;
        Fri, 20 Aug 2021 11:26:28 +0200
Date:   Fri, 20 Aug 2021 11:26:28 +0200
From:   Jan Kratochvil <jan@jankratochvil.net>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: bugreport: git apply -3 confusing "lacks the necessary blob"
Message-ID: <YR91RNbfPwrTZ/3c@host1.jankratochvil.net>
References: <YR1OszUm08BMAE1N@host1.jankratochvil.net>
 <73a31988-d298-0168-43d5-849f91366d7d@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <73a31988-d298-0168-43d5-849f91366d7d@gmail.com>
User-Agent: Mutt/2.0.7 (2021-05-04)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 20 Aug 2021 11:19:39 +0200, Bagas Sanjaya wrote:
> On 19/08/21 01.17, Jan Kratochvil wrote:
> > reproducer:
> > (set -ex;: rm -rf gitgit;mkdir gitgit;cd gitgit;git init;echo a >x;git add x;git commit -am.;git checkout -b b;echo b >x;git commit -am.;git checkout master;echo c >x;git commit -am.;git diff master^..b|grep -v ^index >b.diff;git apply -3 b.diff || cat b.diff)
> 
> I can reproduce your issue on latest Git (2.33.0).
> 
> It seems like you remove `index` line, which **may** contain blob hash
> information required for three-way merge with git apply -3.
> 
> But if you don't remove it when generating patch that way, you will get
> expected conflict when git applying.

Yes.

The problem is when the 'index' line is already removed (as it was always
being removed in my existing setup) it is difficult to find out that is the
reason of this confusing message. So the error message should be different
when the 'index' line is missing at all.


Jan
