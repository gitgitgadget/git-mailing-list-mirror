Return-Path: <SRS0=iCZD=ZT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FC05C432C0
	for <git@archiver.kernel.org>; Wed, 27 Nov 2019 11:51:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F5852070B
	for <git@archiver.kernel.org>; Wed, 27 Nov 2019 11:51:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726496AbfK0LvZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Nov 2019 06:51:25 -0500
Received: from cloud.peff.net ([104.130.231.41]:33756 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726320AbfK0LvZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Nov 2019 06:51:25 -0500
Received: (qmail 10638 invoked by uid 109); 27 Nov 2019 11:51:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 27 Nov 2019 11:51:25 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9505 invoked by uid 111); 27 Nov 2019 11:55:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 27 Nov 2019 06:55:28 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 27 Nov 2019 06:51:24 -0500
From:   Jeff King <peff@peff.net>
To:     Jack Bates <bk874k@nottheoilrig.com>
Cc:     git@vger.kernel.org
Subject: Re: Bug? clone ignores --git-dir
Message-ID: <20191127115124.GE22221@sigill.intra.peff.net>
References: <7d28416e-c927-4cd3-bac2-d8bfd02ce949@nottheoilrig.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7d28416e-c927-4cd3-bac2-d8bfd02ce949@nottheoilrig.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 26, 2019 at 11:07:27AM -0700, Jack Bates wrote:

> If you `git rebase --exec 'gulp runtests-parallel --runners user'` this
> project, the tests perform Git operations on various subprojects [1], but
> because Git exports `GIT_DIR` and `GIT_WORK_TREE`, they end up operating on
> the parent project instead.
> 
> Adding `--git-dir` and `--work-tree` overrides `GIT_DIR` and `GIT_WORK_TREE`
> [2], forcing the tests to operate on the correct repositories, however
> `clone` ignores `--git-dir`:
> 
> > git init repository
> > git --git-dir git-dir clone repository directory
> I'd expect Git to create a directory `git-dir` and put the index, etc.
> there, but instead it creates `directory/.git`, as usual. I'm not sure if
> this is a bug or the expected behavior?

This is the expected behavior. "clone" and "init" are special in that
they are creating _new_ repositories, so they explicitly ignore the
any notion of the current repository.

I'm not quite sure what you're trying to do. I'd think:

  git clone --bare repository git-dir

would do what you want, but then I'm not sure why you're specifying
"directory" in the first place, or what you expect to happen. Are you
looking for clone's --separate-git-dir option, perhaps?

-Peff
