Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 240191F4B6
	for <e@80x24.org>; Tue, 14 May 2019 23:38:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726314AbfENXiK (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 May 2019 19:38:10 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:40508 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726218AbfENXiK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 May 2019 19:38:10 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 83B421F461;
        Tue, 14 May 2019 23:38:09 +0000 (UTC)
Date:   Tue, 14 May 2019 23:38:09 +0000
From:   Eric Wong <e@80x24.org>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Antonio Ospite <ao2@ao2.it>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH] get_oid: handle NULL repo->index
Message-ID: <20190514233809.7wnlbb4s6cjhjv63@dcvr>
References: <20190511205711.tdclwrdixaau75zv@dcvr>
 <20190511223120.GA25224@sigill.intra.peff.net>
 <20190511230204.GA18474@sigill.intra.peff.net>
 <20190514135455.GA17927@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190514135455.GA17927@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> wrote:
> +++ b/sha1-name.c
> @@ -1837,7 +1837,7 @@ static enum get_oid_result get_oid_with_context_1(struct repository *repo,
>  		if (flags & GET_OID_RECORD_PATH)
>  			oc->path = xstrdup(cp);
>  
> -		if (!repo->index->cache)
> +		if (!repo->index || !repo->index->cache)
>  			repo_read_index(repo);

Awesome, looks obviously correct and can confirm it fixes the
new segfault :>

Now I'm kinda wondering if some static checker coulda/shoulda
spotted that, sooner.
