Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0012D1F453
	for <e@80x24.org>; Thu, 25 Oct 2018 06:23:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727411AbeJYOyv (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Oct 2018 10:54:51 -0400
Received: from cloud.peff.net ([104.130.231.41]:53866 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727185AbeJYOyv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Oct 2018 10:54:51 -0400
Received: (qmail 25808 invoked by uid 109); 25 Oct 2018 06:23:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 25 Oct 2018 06:23:35 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13999 invoked by uid 111); 25 Oct 2018 06:22:48 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 25 Oct 2018 02:22:48 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 25 Oct 2018 02:23:32 -0400
Date:   Thu, 25 Oct 2018 02:23:32 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        github@brendanforster.com
Subject: Re: [PATCH] http: give curl version warnings consistently
Message-ID: <20181025062332.GD11460@sigill.intra.peff.net>
References: <pull.46.git.gitgitgadget@gmail.com>
 <764791d13d20478639402e7af95e901223444240.1539598481.git.gitgitgadget@gmail.com>
 <CAPig+cQFb3S0Lm+huUZDN4aw9rWwinh0iZp12ss1zVKpJ=2MdA@mail.gmail.com>
 <xmqqzhv2lnn6.fsf@gitster-ct.c.googlers.com>
 <xmqqsh0uln5c.fsf_-_@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqsh0uln5c.fsf_-_@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 25, 2018 at 12:29:19PM +0900, Junio C Hamano wrote:

> When a requested feature cannot be activated because the version of
> cURL library used to build Git with is too old, most of the codepaths
> give a warning like "$Feature is not supported with cURL < $Version",
> marked for l10n.  A few of them, however, did not follow that pattern
> and said things like "$Feature is not activated, your curl version is
> too old (>= $Version)", and without marking them for l10n.
> 
> Update these to match the style of the majority of warnings and mark
> them for l10n.

This is definitely an improvement.

> @@ -908,8 +907,7 @@ static CURL *get_curl_handle(void)
>  	curl_easy_setopt(result, CURLOPT_PROTOCOLS,
>  			 get_curl_allowed_protocols(-1));
>  #else
> -	warning("protocol restrictions not applied to curl redirects because\n"
> -		"your curl version is too old (>= 7.19.4)");
> +	warning(_("Protocol restrictions not supported with cURL < 7.19.4"));

This loses the mention of redirects, but I think that is actually a
bonus. The #ifdef'd code covers both original and redirected requests.

-Peff
