Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9CFA91F461
	for <e@80x24.org>; Tue,  2 Jul 2019 06:48:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726335AbfGBGs4 (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 Jul 2019 02:48:56 -0400
Received: from waltz.apk.li ([185.177.140.48]:64342 "EHLO waltz.apk.li"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725812AbfGBGs4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Jul 2019 02:48:56 -0400
X-Greylist: delayed 348 seconds by postgrey-1.27 at vger.kernel.org; Tue, 02 Jul 2019 02:48:56 EDT
Received: from continuum.iocl.org (localhost [IPv6:::1])
        by waltz.apk.li (Postfix) with ESMTP id 36BF1598041;
        Tue,  2 Jul 2019 08:43:04 +0200 (CEST)
Received: (from krey@localhost)
        by continuum.iocl.org (8.11.3/8.9.3) id x626gqf27682;
        Tue, 2 Jul 2019 08:42:52 +0200
Date:   Tue, 2 Jul 2019 08:42:52 +0200
From:   Andreas Krey <a.krey@gmx.de>
To:     Bryan Turner <bturner@atlassian.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Kulcyk <Eric.kulcyk@microsoft.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Tracking parent branches in Git
Message-ID: <20190702064252.GA26953@inner.h.apk.li>
References: <DM5PR00MB040845755401A07E5C90251CF1F90@DM5PR00MB0408.namprd00.prod.outlook.com> <xmqqpnmt5z19.fsf@gitster-ct.c.googlers.com> <CAGyf7-EBs_cRB5R7RyQhX0ZDNqLZWVJEYEtqkGRGJykRqKKTvA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGyf7-EBs_cRB5R7RyQhX0ZDNqLZWVJEYEtqkGRGJykRqKKTvA@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
X-message-flag: What did you expect to see here?
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, 01 Jul 2019 12:48:16 +0000, Bryan Turner wrote:
...
> In other words, when I locally do:
> git checkout --no-track -b bturner-some-bugfix origin/release/5.16
> 
> release/5.16 is the "parent branch" of my bugfix branch and, when I
> push my branch and try to open a pull request, release/5.16 is a
> _likely_ target for where I'd want to merge it.

We have simply conventionalized this - the parent relation is in
the branch names. Your bugfix branch would be release/5.16/bturner-some-bugfix
(in the central repo; we don't care how you name it locally), and, because
ref storage, the parent would be release/5.16/master.

You'd just do

  git create-br release/5.16/bturner-some-bugfix

and it would be branched off the corresponding /master, be checked
out, and tracking already been set up. Likewise we have a

  git update

which looks at the upstream name, deduces the parent, and pulls
that in, with a suitable commit message. Finally,

  git mkpullreq

creates a pull request from the current to the parent branch.

(I would like to have a way to make bitbucket server use the same
convention for the default pull request target.)

- Andreas

-- 
"Totally trivial. Famous last words."
From: Linus Torvalds <torvalds@*.org>
Date: Fri, 22 Jan 2010 07:29:21 -0800
