Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 637111F453
	for <e@80x24.org>; Fri,  5 Oct 2018 16:21:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729659AbeJEXVU (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Oct 2018 19:21:20 -0400
Received: from cloud.peff.net ([104.130.231.41]:43120 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728694AbeJEXVT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Oct 2018 19:21:19 -0400
Received: (qmail 18167 invoked by uid 109); 5 Oct 2018 16:21:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 05 Oct 2018 16:21:55 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12361 invoked by uid 111); 5 Oct 2018 16:21:11 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 05 Oct 2018 12:21:11 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 05 Oct 2018 12:21:53 -0400
Date:   Fri, 5 Oct 2018 12:21:53 -0400
From:   Jeff King <peff@peff.net>
To:     Tao Qingyun <taoqy@ls-a.me>
Cc:     git@vger.kernel.org, sbeller@google.com, gitster@pobox.com
Subject: Re: [PATCH] branch: trivial style fix
Message-ID: <20181005162152.GA11254@sigill.intra.peff.net>
References: <20181005095213.12509-1-taoqy@ls-a.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181005095213.12509-1-taoqy@ls-a.me>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 05, 2018 at 05:52:14PM +0800, Tao Qingyun wrote:

> diff --git a/builtin/branch.c b/builtin/branch.c
> index c396c41533..52aad0f602 100644
> --- a/builtin/branch.c
> +++ b/builtin/branch.c
> @@ -222,10 +222,11 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
>  		if (!head_rev)
>  			die(_("Couldn't look up commit object for HEAD"));
>  	}
> -	for (i = 0; i < argc; i++, strbuf_reset(&bname)) {
> +	for (i = 0; i < argc; i++) {
>  		char *target = NULL;
>  		int flags = 0;
>  
> +		strbuf_reset(&bname);
>  		strbuf_branchname(&bname, argv[i], allowed_interpret);
>  		free(name);
>  		name = mkpathdup(fmt, bname.buf);

This one isn't just style: it switches the reset from the end of the
loop to the beginning of the loop. So we'd need to make sure that we are
not depending on its contents going into the first iteration, nor coming
out of the last one.

Looking at the surrounding code, I think it is OK.

> @@ -716,8 +717,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
>  		print_columns(&output, colopts, NULL);
>  		string_list_clear(&output, 0);
>  		return 0;
> -	}
> -	else if (edit_description) {
> +	} else if (edit_description) {
>  		const char *branch_name;
>  		struct strbuf branch_ref = STRBUF_INIT;

And this one is obviously correct.

-Peff
