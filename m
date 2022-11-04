Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46949C433FE
	for <git@archiver.kernel.org>; Fri,  4 Nov 2022 12:53:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231978AbiKDMxz (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Nov 2022 08:53:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231975AbiKDMxx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Nov 2022 08:53:53 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B75F425EB3
        for <git@vger.kernel.org>; Fri,  4 Nov 2022 05:53:52 -0700 (PDT)
Received: (qmail 18695 invoked by uid 109); 4 Nov 2022 12:53:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 04 Nov 2022 12:53:51 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29647 invoked by uid 111); 4 Nov 2022 12:53:51 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 04 Nov 2022 08:53:51 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 4 Nov 2022 08:53:50 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?THVrw6HFoQ==?= Doktor <ldoktor@redhat.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 1/3] bisect--helper: remove unused options
Message-ID: <Y2ULXomMI7vcDuZO@coredump.intra.peff.net>
References: <1cb1c033-0525-7e62-8c09-81019bf26060@redhat.com>
 <cover.1667561761.git.congdanhqx@gmail.com>
 <489785ca45a84cffb4a2c16da15a09034829b7c6.1667561761.git.congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <489785ca45a84cffb4a2c16da15a09034829b7c6.1667561761.git.congdanhqx@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 04, 2022 at 06:40:10PM +0700, Đoàn Trần Công Danh wrote:

> diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
> index 1d2ce8a0e1..5ec2e67f59 100644
> --- a/builtin/bisect--helper.c
> +++ b/builtin/bisect--helper.c
> @@ -1283,7 +1283,6 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
>  {
>  	enum {
>  		BISECT_RESET = 1,
> -		BISECT_NEXT_CHECK,
>  		BISECT_TERMS,
>  		BISECT_START,
>  		BISECT_AUTOSTART,

OK, makes sense. It might be nice to mention in the commit message how
we got here. It looks like the callers that used this went away in
d1bbbe45df (bisect--helper: reimplement `bisect_run` shell function in
C, 2021-09-13) and 5e1f28d206 (bisect--helper: reimplement
`bisect_visualize()` shell function in C, 2021-09-13).

> @@ -1319,8 +1316,6 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
>  			 N_("visualize the bisection"), BISECT_VISUALIZE),
>  		OPT_CMDMODE(0, "bisect-run", &cmdmode,
>  			 N_("use <cmd>... to automatically bisect"), BISECT_RUN),
> -		OPT_BOOL(0, "no-log", &nolog,
> -			 N_("no log for BISECT_WRITE")),

Likewise digging up the history here lets us see why removing is the
right thing (and the bug is not that it _should_ be used and isn't).
Gábor posted a summary of the history elsewhere in the thread.

-Peff
