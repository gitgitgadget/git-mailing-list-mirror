Return-Path: <SRS0=3i0n=DJ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54A50C4363D
	for <git@archiver.kernel.org>; Fri,  2 Oct 2020 19:39:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08793206DD
	for <git@archiver.kernel.org>; Fri,  2 Oct 2020 19:39:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n6GtR7ln"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388321AbgJBTjP (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Oct 2020 15:39:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726224AbgJBTjP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Oct 2020 15:39:15 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85700C0613D0
        for <git@vger.kernel.org>; Fri,  2 Oct 2020 12:39:13 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id n14so1983588pff.6
        for <git@vger.kernel.org>; Fri, 02 Oct 2020 12:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BwD2aoX98PkBOLb18DpF+vGsuu/y2wn0Cud8ltwB814=;
        b=n6GtR7lnsL7ejtxK+YK1YaA71gupOAgfmSrpdAuy/p8err1mEUzFl9sgkctYsAiwoO
         WDXthVvJtIA5U8Wn18dX8O0ROuAGxBqXTpiNz4J+7LL7BHjuWUmagN4QAdFBmnicYhWa
         gPgyua3Hu1vvTttkhU4FjOThUzhnJ99uktBMDkFBqdEP2KciEPg8GgaIOU4ZKAVyZoVF
         4H464xcybsDOPSzZHMdG4RDiVCLnknrsMXgeCN1xYHESC5iJ7VLo+JVtNPJfSsAci5jw
         FarUYdwUbYa/mj6wQrYUvCqSvK40EYKAla2WwU77vQX5SZtpogV4GTr55WlWu0TG/9PN
         LCLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BwD2aoX98PkBOLb18DpF+vGsuu/y2wn0Cud8ltwB814=;
        b=ZbwXvsRoEt0QT7asixYVPQs/hmlqmWTVI+7QTaRiMaAbZiehxAQUJ2n3FybUnrE3tB
         wxKF/KT7+MQEwFn+tn+q/74Rb/aw8RjpKVLdnpaMYAt0ZaoXRAzgRE31WY1rayTex2kq
         aTgq3wweIpjhx5pqKdFTtZVWszQfSmXKifD/49mn4HZPs7sgPs3GsobpZ+D++zgSd7bg
         fPNkOO8mvWbctw2OPmxP+uTWxKWg0jWzlVGFJXjcWjWc6zPDuYeZxQ25J4ZG3PTP6Qn3
         nhNNv0Ib42r3JPZKzaiIWURQunbBoxaOb5bgafElAuC0T8WNqQztUmMVZetJYG+HZ3DP
         JX9g==
X-Gm-Message-State: AOAM532xiwgqezAcNdgRug1C2XdHapgRcR80YUmJkzrkSuFlUrYgJJ+V
        XcpBDTcF9GwxqncVYF6GZXE=
X-Google-Smtp-Source: ABdhPJy+I/TN+nhOAelJZASuDMgBRx6Q+T92J2VbzAOAWag9KOGuSp1KdIHauCUJ3emKMvhCvkLIQg==
X-Received: by 2002:a62:184f:0:b029:142:2501:39fd with SMTP id 76-20020a62184f0000b0290142250139fdmr4411335pfy.76.1601667552819;
        Fri, 02 Oct 2020 12:39:12 -0700 (PDT)
Received: from mail.clickyotomy.dev ([124.123.104.31])
        by smtp.gmail.com with ESMTPSA id w203sm2847569pfc.97.2020.10.02.12.39.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2020 12:39:11 -0700 (PDT)
Date:   Sat, 3 Oct 2020 01:09:06 +0530
From:   Srinidhi Kaushik <shrinidhi.kaushik@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: [PATCH v9 1/3] push: add reflog check for "--force-if-includes"
Message-ID: <20201002193906.GA78209@mail.clickyotomy.dev>
References: <20200927141747.78047-1-shrinidhi.kaushik@gmail.com>
 <20201001082118.19441-1-shrinidhi.kaushik@gmail.com>
 <20201001082118.19441-2-shrinidhi.kaushik@gmail.com>
 <nycvar.QRO.7.76.6.2010021550170.50@tvgsbejvaqbjf.bet>
 <20201002150710.GA54370@mail.clickyotomy.dev>
 <xmqqft6wa8dc.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqft6wa8dc.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On 10/02/2020 09:41, Junio C Hamano wrote:
> Srinidhi Kaushik <shrinidhi.kaushik@gmail.com> writes:
> 
> >> We should not call `in_merge_bases_many()` repeatedly: there is a much
> >> better API for that: `get_reachable_subset()`.
> >
> > Perfect. I wasn't aware of this.
> 
> This is possibly a piece of misinformation.  in_merge_bases_many()
> is designed to be callable more than once.  get_reachable_subset()
> may be an overkill as we only are interested in a single "is this
> one an ancestor of any of these?", not "which ones among these are
> ancestors of the other set?".

Noted; even though "get_reachable_subset()" and "in_merge_bases_many()"
(after the commit-graph fix) return the same result, I suppose the
latter was designed for this specific use-case.

> > OK. The tests are passing with or without "GIT_TEST_COMMIT_GRAPH"
> > by switching to "get_reachable_subset()" we don't have to toggle
> > te feature during the check.
> 
> Correct.  Once the "see if this one is reachable from any of these"
> is fixed (either by correcting the broken in_merge_bases_many() or
> using get_reachable_subset()), we can get rid of this hack.

OK. Shall I update the next set by reverting the "disable commit-graph"
change, s/list/array/ and leaving the rest as is -- if we decide to go
forward with "in_merge_bases_many()", that is?

> > Again, thank you so much working on this! If you'd like, I can go ahead
> > and apply these patches and rename "reflog_commit_list" to "commit_array"
> > in the next series (v10).
> 
> I like the s/list/array/ change, but I do not think switching to
> get_reachable_subset() and having to receive a commit list only to
> free the list is warranted.
> 
> Derrick sent a fix to in_merge_bases_many() in the near-by thread.

Nice! Will take a look.

Thanks.
-- 
Srinidhi Kaushik
