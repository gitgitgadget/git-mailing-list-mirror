Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 684C61F404
	for <e@80x24.org>; Wed, 14 Feb 2018 14:08:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030573AbeBNOIM (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Feb 2018 09:08:12 -0500
Received: from cloud.peff.net ([104.130.231.41]:52030 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1030448AbeBNOIL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Feb 2018 09:08:11 -0500
Received: (qmail 17138 invoked by uid 109); 14 Feb 2018 14:08:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 14 Feb 2018 14:08:11 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28808 invoked by uid 111); 14 Feb 2018 14:08:55 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 14 Feb 2018 09:08:55 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 14 Feb 2018 09:08:09 -0500
Date:   Wed, 14 Feb 2018 09:08:09 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org, doron.behar@gmail.com
Subject: Re: [PATCH 2/2] init-db: change --template type to OPTION_FILENAME
Message-ID: <20180214140808.GB27850@sigill.intra.peff.net>
References: <20180214101019.gaenosifgq3wx2nm@NUC.localdomain>
 <20180214105149.28896-1-pclouds@gmail.com>
 <20180214105149.28896-2-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180214105149.28896-2-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 14, 2018 at 05:51:49PM +0700, Nguyễn Thái Ngọc Duy wrote:

> OPTION_FILENAME has some magic behind the scene, like prefixing which is
> useless for init-db. The $HOME expansion though does come handy and
> makes --template more consistent with the rest (both env and config var
> get $HOME expansion).

Yep, makes sense.

> diff --git a/builtin/init-db.c b/builtin/init-db.c
> index 68ff4ad75a..d6bd9f19cb 100644
> --- a/builtin/init-db.c
> +++ b/builtin/init-db.c
> @@ -473,8 +473,9 @@ int cmd_init_db(int argc, const char **argv, const char *prefix)
>  	const char *template_dir = NULL;
>  	unsigned int flags = 0;
>  	const struct option init_db_options[] = {
> -		OPT_STRING(0, "template", &template_dir, N_("template-directory"),
> -				N_("directory from which templates will be used")),
> +		{ OPTION_FILENAME, 0, "template", &template_dir,
> +			N_("template-directory"),
> +			N_("directory from which templates will be used")},

It's a shame we can't use the slightly more readable OPT_FILENAME(), but
it forces the use of "file" for the argument name. I wonder if it really
ought to be OPT_PATH(), and say "path", which would work more
universally.

At any rate, I'm fine with this until somebody feels like fiddling with
the macros.

-Peff
