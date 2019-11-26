Return-Path: <SRS0=BbQ7=ZS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ABFBC432C0
	for <git@archiver.kernel.org>; Tue, 26 Nov 2019 15:57:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F32D82071E
	for <git@archiver.kernel.org>; Tue, 26 Nov 2019 15:57:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728018AbfKZP5n (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Nov 2019 10:57:43 -0500
Received: from cloud.peff.net ([104.130.231.41]:32936 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726101AbfKZP5n (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Nov 2019 10:57:43 -0500
Received: (qmail 2501 invoked by uid 109); 26 Nov 2019 15:57:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 26 Nov 2019 15:57:42 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2933 invoked by uid 111); 26 Nov 2019 16:01:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 26 Nov 2019 11:01:45 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 26 Nov 2019 10:57:41 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] push: use skip_prefix() instead of starts_with()
Message-ID: <20191126155741.GB25729@sigill.intra.peff.net>
References: <90f94e4b-6cf3-58cc-01dc-c3d731037217@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <90f94e4b-6cf3-58cc-01dc-c3d731037217@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 26, 2019 at 04:18:28PM +0100, René Scharfe wrote:

> diff --git a/builtin/push.c b/builtin/push.c
> index 843f5b22a2..6dbf0f0bb7 100644
> --- a/builtin/push.c
> +++ b/builtin/push.c
> @@ -64,6 +64,7 @@ static struct string_list push_options_config = STRING_LIST_INIT_DUP;
>  static const char *map_refspec(const char *ref,
>  			       struct remote *remote, struct ref *local_refs)
>  {
> +	const char *branch_name;
>  	struct ref *matched = NULL;
> 
>  	/* Does "ref" uniquely name our ref? */
> @@ -84,8 +85,8 @@ static const char *map_refspec(const char *ref,
>  	}
> 
>  	if (push_default == PUSH_DEFAULT_UPSTREAM &&
> -	    starts_with(matched->name, "refs/heads/")) {
> -		struct branch *branch = branch_get(matched->name + 11);
> +	    skip_prefix(matched->name, "refs/heads/", &branch_name)) {
> +		struct branch *branch = branch_get(branch_name);

Yep, obviously correct because you introduce a new variable instead of
mutating an existing one. Looks good.

-Peff
