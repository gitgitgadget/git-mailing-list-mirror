Return-Path: <SRS0=R55k=B3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87A9DC433E1
	for <git@archiver.kernel.org>; Mon, 17 Aug 2020 09:24:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F19D207FB
	for <git@archiver.kernel.org>; Mon, 17 Aug 2020 09:24:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727839AbgHQJYd (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Aug 2020 05:24:33 -0400
Received: from cloud.peff.net ([104.130.231.41]:60858 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726381AbgHQJYd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Aug 2020 05:24:33 -0400
Received: (qmail 3360 invoked by uid 109); 17 Aug 2020 09:24:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 17 Aug 2020 09:24:32 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14793 invoked by uid 111); 17 Aug 2020 09:24:32 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 17 Aug 2020 05:24:32 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 17 Aug 2020 05:24:31 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/3] msvc: copy the correct `.pdb` files in the Makefile
 target `install`
Message-ID: <20200817092431.GA1259595@coredump.intra.peff.net>
References: <pull.411.git.1597655273.gitgitgadget@gmail.com>
 <120d2bb3e461717e5248bb4c97feab86d4e45c9d.1597655273.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <120d2bb3e461717e5248bb4c97feab86d4e45c9d.1597655273.git.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 17, 2020 at 09:07:51AM +0000, Johannes Schindelin wrote:

> -	$(INSTALL) git.pdb '$(DESTDIR_SQ)$(bindir_SQ)'
> -	$(INSTALL) git-shell.pdb '$(DESTDIR_SQ)$(bindir_SQ)'
> -	$(INSTALL) git-upload-pack.pdb '$(DESTDIR_SQ)$(bindir_SQ)'
> -	$(INSTALL) git-credential-store.pdb '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
> -	$(INSTALL) git-daemon.pdb '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
> -	$(INSTALL) git-fast-import.pdb '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
> -	$(INSTALL) git-http-backend.pdb '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
> -	$(INSTALL) git-http-fetch.pdb '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
> -	$(INSTALL) git-http-push.pdb '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
> -	$(INSTALL) git-imap-send.pdb '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
> -	$(INSTALL) git-remote-http.pdb '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
> -	$(INSTALL) git-remote-testsvn.pdb '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
> -	$(INSTALL) git-sh-i18n--envsubst.pdb '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
> -	$(INSTALL) git-show-index.pdb '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
> +	$(INSTALL) $(patsubst %.exe,%.pdb,$(filter-out $(BUILT_INS),$(patsubst %,%$X,$(BINDIR_PROGRAMS_NEED_X)))) '$(DESTDIR_SQ)$(bindir_SQ)'
> +	$(INSTALL) $(patsubst %.exe,%.pdb,$(filter-out $(BUILT_INS) $(REMOTE_CURL_ALIASES),$(PROGRAMS))) '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'

Oh, this is much better than what my patch does. :)

The rest of the series looks like a good direction to me, but is outside
the scope of my series. I'd be happy to pick this first patch up for a
re-roll of mine (which would require tweaking the rest of the patches on
top to stop removing things from the .pdb list). Or we could just leave
this as a separate topic and deal with the merge conflict (which would
obviously resolve in favor of yours).

-Peff
