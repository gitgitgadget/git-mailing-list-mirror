Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E95561FA26
	for <e@80x24.org>; Wed, 19 Apr 2017 07:48:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1760589AbdDSHsd (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Apr 2017 03:48:33 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:60390 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1760333AbdDSHsc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Apr 2017 03:48:32 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 14B321FA26;
        Wed, 19 Apr 2017 07:48:31 +0000 (UTC)
Date:   Wed, 19 Apr 2017 07:48:30 +0000
From:   Eric Wong <e@80x24.org>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Brandon Williams <bmwill@google.com>, git@vger.kernel.org,
        jrnieder@gmail.com
Subject: Re: [PATCH v5 11/11] run-command: block signals between fork and
 execve
Message-ID: <20170419074830.GA25646@starla>
References: <20170417220818.44917-1-bmwill@google.com>
 <20170418231805.61835-1-bmwill@google.com>
 <20170418231805.61835-12-bmwill@google.com>
 <4c2f91fd-c9bd-cfe0-4e2d-3f1669410579@kdbg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4c2f91fd-c9bd-cfe0-4e2d-3f1669410579@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Sixt <j6t@kdbg.org> wrote:
> Am 19.04.2017 um 01:18 schrieb Brandon Williams:
> >@@ -400,6 +404,53 @@ static char **prep_childenv(const char *const *deltaenv)
> > }
> > #endif
> >
> 
> Does this #endif in this hunk context belong to an #ifndef
> GIT_WINDOWS_NATIVE? If so, I wonder why these new functions are outside
> these brackets? An oversight?

Seems like an oversight, sorry about that.
All the new atfork stuff I added should be protected by
#ifndef GIT_WINDOWS_NATIVE.

Brandon / Johannes: can you fixup on your end?

I wonder if some of this OS-specific code would be more
easily maintained if split out further to OS-specific files,
even at the risk of some code duplication.

And/or perhaps label all #else and #endif statements with
comments, and limit the scope of each ifdef block to be
per-function for with tiny attention spans like me :x

> >+struct atfork_state {
> >+#ifndef NO_PTHREADS
> >+	int cs;
> >+#endif
> >+	sigset_t old;
> >+};
> ...
> 
> -- Hannes
> 
