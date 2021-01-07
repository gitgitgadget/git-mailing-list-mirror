Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A19CDC433DB
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 18:36:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65E63233CF
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 18:36:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729019AbhAGSgO (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Jan 2021 13:36:14 -0500
Received: from mx2.suse.de ([195.135.220.15]:58898 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726064AbhAGSgO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jan 2021 13:36:14 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 5D443AAF1;
        Thu,  7 Jan 2021 18:35:33 +0000 (UTC)
Date:   Thu, 7 Jan 2021 19:35:32 +0100
From:   Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To:     Andreas Schwab <schwab@linux-m68k.org>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: git gc ineffective
Message-ID: <20210107183531.GB6564@kitsune.suse.cz>
References: <20201109092041.GV29778@kitsune.suse.cz>
 <87361ilv1a.fsf@igel.home>
 <20201109101738.GW29778@kitsune.suse.cz>
 <20201109104327.GX29778@kitsune.suse.cz>
 <87v9eekcd6.fsf@igel.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87v9eekcd6.fsf@igel.home>
User-Agent: Mutt/1.11.3 (2019-02-01)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

On Mon, Nov 09, 2020 at 12:17:57PM +0100, Andreas Schwab wrote:
> On Nov 09 2020, Michal Suchánek wrote:
> 
> > On Mon, Nov 09, 2020 at 11:17:38AM +0100, Michal Suchánek wrote:
> >> On Mon, Nov 09, 2020 at 10:49:21AM +0100, Andreas Schwab wrote:
> >> > On Nov 09 2020, Michal Suchánek wrote:
> >> > 
> >> > > I noticed I am running out of disk space, and one repository taking up
> >> > > about 38G. Did git gc --aggressive, and the used space *raised* to 42G,
> >> > > and git would report it does gc after every commit.
> >> > 
> >> > Do you have a lot of loose objects?
> >> { for i in  .git/objects/?? ; do ls $i ; done ; } | wc -l
> >> 53392
> > And in the double-size repository it's doubled, too:
> >  { for i in  .git/objects/?? ; do ls $i ; done ; } | wc -l
> >  101167
> 
> git count-objects also shows the size.
$ git count-objects
59853 objects, 43249880 kilobytes
$ du -hs .git
48G     .git
$ git gc --aggressive
Enumerating objects: 1825080, done.
Counting objects: 100% (1825080/1825080), done.
Delta compression using up to 4 threads
Compressing objects: 100% (1803925/1803925), done.
Writing objects: 100% (1825080/1825080), done.
Total 1825080 (delta 1234005), reused 587969 (delta 0), pack-reused 0
Removing duplicate objects: 100% (256/256), done.
Checking connectivity: 2003814, done.
Expanding reachable commits in commit graph: 337512, done.
$ du -hs .git
172G    .git
$ git count-objects
178734 objects, 175309572 kilobytes

> Does it help to prune them --exprire now?

$ git prune
Checking connectivity: 1825478, done.
$ du -hs .git
3.9G    .git
$ git --version
git version 2.26.2

So it is my wrong expectation that 'gc' comand removes garbage. It
creates it en masse.

It just makes is in a way that the 'prune' command that really reoves
garbage can now remove it.

Thanks

Michal
