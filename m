Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 082791F464
	for <e@80x24.org>; Fri, 20 Sep 2019 06:49:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403924AbfITGtm (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Sep 2019 02:49:42 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:51210 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732724AbfITGtl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Sep 2019 02:49:41 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 5106E1F463;
        Fri, 20 Sep 2019 06:49:41 +0000 (UTC)
Date:   Fri, 20 Sep 2019 06:49:41 +0000
From:   Eric Wong <e@80x24.org>
To:     Joseph Mingrone <jrm@ftfl.ca>
Cc:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        git@vger.kernel.org
Subject: Re: git-svn authors file in repo (Author: xxx not defined in
 .gitauthors file)
Message-ID: <20190920064941.trlc3noyvgseid3m@dcvr>
References: <86o8zgfj82.fsf@phe.ftfl.ca>
 <20190919231833.GA9363@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190919231833.GA9363@szeder.dev>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER Gábor <szeder.dev@gmail.com> wrote:
> On Thu, Sep 19, 2019 at 11:34:21AM -0300, Joseph Mingrone wrote:
> > Hello,
> > 
> > We maintain a .gitauthors file for git-svn.  When a new committer is
> > added to our project, a new entry is added to the .gitauthors file,
> > but we sometimes see errors like this:
> > 
> > % git -C /usr/ports svn rebase
> >         M       .gitauthors
> > r512146 = 0c1f924ca984d53333beabb909ea53afb856c44b (refs/remotes/origin/trunk)
> >         M       math/py-pystan/Makefile
> > r512147 = acc387d4c8f3ebf904010bccc5679be06b184a9d (refs/remotes/origin/trunk)
> >         M       deskutils/gworkspace-gwmetadata/Makefile
> > ...
> > ...
> > ...
> > r512184 = 442bd1025776d5e3171be8e497ef2056dc47ff06 (refs/remotes/origin/trunk)
> >         M       www/rubygem-passenger/Makefile
> >         M       www/rubygem-passenger/distinfo
> >         D       www/rubygem-passenger/files/patch-asio-libc++7
> > W: -empty_dir: head/www/rubygem-passenger/files/patch-asio-libc++7
> > r512185 = f1a1b447811ae84011288678136e185c83180b8e (refs/remotes/origin/trunk)
> >         M       astro/xearth/files/freebsd.committers.markers
> > Author: dmgk not defined in .gitauthors file
> > 
> > The new committer, dmgk, was added to .gitauthors in svn commit r512146,
> > then later he committed to the repository for the first time in r512185.
> > It seems that if these two commits are included in the same `git svn
> > rebase`, the error above will occur.
> > 
> > Is there a solution or workaround for this aside from each committer
> > having an updated .gitauthors before doing `git svn rebase`.  It's seems
> > to be a chicken/egg issue; they first need the updated .gitauthors file,
> > but the way to get the updated .gitauthors files is to do `git svn
> > rebase`.
> 
> I have no idea how 'git svn' works and what this '.gitauthors' file
> is, so no workarounds from me...  But this seems to be similar to the
> issue with '.gitattributes' in core Git that was fixed recently:
> 
>   https://public-inbox.org/git/20190902223944.897504-3-sandals@crustytoothpaste.net/
> 
> Perhaps 'git svn rebase' should do the same, i.e. look out for commits
> changing this '.gitauthors' file and re-read the file each time it is
> changed.
> 
> Cc-ing Eric for git-svn know-how.

Yes it's a bug in git-svn that we don't reload the authorsfile.
A patch (and reviewers) would be welcome :>
Kinda surprised nobody reported it until now, or maybe I missed it.
