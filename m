Return-Path: <SRS0=39iz=ZR=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E209BC432C0
	for <git@archiver.kernel.org>; Mon, 25 Nov 2019 03:15:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFE7720823
	for <git@archiver.kernel.org>; Mon, 25 Nov 2019 03:15:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726944AbfKYDPb (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 24 Nov 2019 22:15:31 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:47184 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726910AbfKYDPb (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Nov 2019 22:15:31 -0500
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id E32921F464;
        Mon, 25 Nov 2019 03:15:30 +0000 (UTC)
Date:   Mon, 25 Nov 2019 03:15:30 +0000
From:   Eric Wong <e@80x24.org>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 6/8] git-svn: drop support for `--preserve-merges`
Message-ID: <20191125031530.GA29212@dcvr>
References: <pull.195.git.1574542242.gitgitgadget@gmail.com>
 <b7ba83969da8fd2db4e6074d5044938c05b992fd.1574542243.git.gitgitgadget@gmail.com>
 <20191123220850.GA29423@dcvr>
 <nycvar.QRO.7.76.6.1911242224400.31080@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1911242224400.31080@tvgsbejvaqbjf.bet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com> wrote:
> > > We already passed the `--rebase-merges` option to `git rebase` instead,
> > > now we make this move permanent.
> >
> > > diff --git a/git-svn.perl b/git-svn.perl
> > > index 4aa208ff5f..f1fa1bc7f7 100755
> > > --- a/git-svn.perl
> > > +++ b/git-svn.perl
> > > @@ -271,7 +271,6 @@ sub _req_svn {
> > >  			  'fetch-all|all' => \$_fetch_all,
> > >  			  'dry-run|n' => \$_dry_run,
> > >  			  'rebase-merges|p' => \$_rebase_merges,
> > > -			  'preserve-merges|p' => \$_rebase_merges,
> > >  			  %fc_opts } ],
> > >  	'commit-diff' => [ \&cmd_commit_diff,
> > >  	                   'Commit a diff between two trees',
> >
> > Nack, it breaks existing usages.   Why the urgency with removal?
> 
> Which urgency? The cover letter spells it out quite clearly that this is
> not even intended for v2.25.0, which is still over 2 months out.

"Months" a blink of an eye when it comes to deprecations and removals.

> The reason I submitted this patch series now is so that we can avoid
> inadvertent new users of the `--preserve-merges` backend.

Then documenting it as deprecated and warning is all that's
needed.

> > I don't know a whole lot about this rebase feature in
> > particular, but deprecation periods should be measured in years
> > or even decades because of LTS distros.  Not months, especially
> > for things which have been around for a long while.
> 
> The LTS distros will not even pick up this patch. So that's a red herring.
> 
> But yes, you're right, v2.25.0 will probably be the first version to even
> have the `--rebase-merges` option in `git svn`, and therefore v2.26.0
> would be awfully early a time to drop `--preserve-merges` in `git svn`.
> Question is whether we want to split this patch series, or just rather
> wait with merging it to `master` until a year from now, or something like
> that?

Fwiw, I object to the regressions to all the other commands
(rebase/pull/remote) in this series, too, but I mainly do Perl.

--preserve-merges was only deprecated in v2.22.0 (2019-06-07).
LTS distro users are very likely on pre-v2.22.0, more likely
v2.1x.0 and maybe even v2.x.0.

Their next LTS release could be several years from now.  We
could be on git 2.[345]x.0 by then and that's when the LTS
packagers could package the next version.  LTS users are likely
to never see the entire period from v2.22.0..v2.25.0 and thus
never see a deprecation warning.

Even Debian stable (not exactly LTS, but still on the slower
side) went from v2.11.0 in Debian 9 all the way to v2.20.1
in Debian 10.  Actual LTS users will see bigger jumps.
