Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 935E51F403
	for <e@80x24.org>; Mon,  4 Jun 2018 14:50:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753297AbeFDOut (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Jun 2018 10:50:49 -0400
Received: from cloud.peff.net ([104.130.231.41]:33404 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751782AbeFDOut (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Jun 2018 10:50:49 -0400
Received: (qmail 27305 invoked by uid 109); 4 Jun 2018 14:50:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 04 Jun 2018 14:50:48 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14423 invoked by uid 111); 4 Jun 2018 14:51:01 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 04 Jun 2018 10:51:01 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 04 Jun 2018 10:50:47 -0400
Date:   Mon, 4 Jun 2018 10:50:47 -0400
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jun 2018, #02; Mon, 4)
Message-ID: <20180604145046.GB27655@sigill.intra.peff.net>
References: <xmqqr2lm4pth.fsf@gitster-ct.c.googlers.com>
 <20180604141817.22916-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180604141817.22916-1-szeder.dev@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 04, 2018 at 04:18:17PM +0200, SZEDER Gábor wrote:

> 
> > * jk/index-pack-maint (2018-06-01) 2 commits
> >   (merged to 'next' on 2018-06-04 at c553a485e8)
> >  + index-pack: handle --strict checks of non-repo packs
> >  + prepare_commit_graft: treat non-repository as a noop
> > 
> >  "index-pack --strict" has been taught to make sure that it runs the
> >  final object integrity checks after making the freshly indexed
> >  packfile available to itself.
> > 
> >  Will cook in 'next'.
> 
> These patches can't be applied directly on top of v2.17.1, or there
> was a wrong merge conflict resolution, or I don't know.  Anyway,
> building 368b4e5906 (index-pack: handle --strict checks of non-repo
> packs, 2018-05-31) results in:
> 
>       CC builtin/index-pack.o
>   builtin/index-pack.c: In function ‘final’:
>   builtin/index-pack.c:1487:23: warning: passing argument 1 of
>   ‘install_packed_git’ from incompatible pointer type
>   [-Wincompatible-pointer-types]
>       install_packed_git(the_repository, p);

Oh, right, I did have to adapt for the "the_repository" bits added on
master.

The diff to apply it on maint is just:

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 7b399478dd..3030c88d38 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -1484,7 +1484,7 @@ static void final(const char *final_pack_name, const char *curr_pack_name,
 		struct packed_git *p;
 		p = add_packed_git(final_index_name, strlen(final_index_name), 0);
 		if (p)
-			install_packed_git(the_repository, p);
+			install_packed_git(p);
 	}
 
 	if (!from_stdin) {

-Peff
