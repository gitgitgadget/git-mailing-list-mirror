Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B68AD1F404
	for <e@80x24.org>; Tue, 20 Feb 2018 23:03:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751762AbeBTXD3 convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Tue, 20 Feb 2018 18:03:29 -0500
Received: from elephants.elehost.com ([216.66.27.132]:50224 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751758AbeBTXD2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Feb 2018 18:03:28 -0500
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id w1KN3MAq095886
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 20 Feb 2018 18:03:22 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Eric Sunshine'" <sunshine@sunshineco.us>
Cc:     "'Git List'" <git@vger.kernel.org>
References: <005301d3aa8a$80521c70$80f65550$@nexbridge.com> <CAPig+cTHTZT2vRBYbdAgeVg+TDuo_C=mXRXYX4o094VmtygxRQ@mail.gmail.com>
In-Reply-To: <CAPig+cTHTZT2vRBYbdAgeVg+TDuo_C=mXRXYX4o094VmtygxRQ@mail.gmail.com>
Subject: RE: [BUG] Worktree prune complains about missing path
Date:   Tue, 20 Feb 2018 18:03:16 -0500
Message-ID: <006001d3aa9f$011dab80$03590280$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQINSVcQmnaRefgkcdyr8T2TyNu3bQFjDDMhoy+QSNA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On February 20, 2018 5:22 PM Eric Sunshine wrote:
> On Tue, Feb 20, 2018 at 3:36 PM, Randall S. Becker
> <rsbecker@nexbridge.com> wrote:
> > I’m a bit confused about this, as I thought I understood worktrees :(.
> >
> > /home/randall/nsgit/test/test dir.mytest: rm -rf dest.wt
> > /home/randall/nsgit/test/test dir.mytest/dest: git worktree prune -v
> > Removing worktrees/dest.wt: gitdir file points to non-existent
> > location
> >
> > It seems like one or two situations are a problem:
> > 1) I’m using a full path for the worktree.
> > 2) There’s a blank in my path – deliberate… tests, yanno.
> >
> > This is git 2.16.2. Could anyone shed some light on this?
> 
> This appears to be working as intended. "git worktree prune" is telling you
> that it is pruning the administrative data for the "dest.wt" worktree (reason:
> "worktree location no longer exists"), which you intentionally deleted before
> pruning. It's not clear what it is that you find confusing. There is not a lot
> more I can say without understanding what behavior you were expecting
> and how your expectation differs from the actual experience.

I should have been more clear here as to the issue. My bad. The git worktree prune operation does not remove all vestiges of the removed worktree. The following files are retained:

./logs/refs/heads/dest.wt
./refs/heads/dest.wt

So, now that I understand in hindsight, these are actually references to the worktree branch 'dest.wt' that obviously remains correctly and properly in git.

Adding:  git branch -D dest.wt    to my test script cleared my (embarrassing) problem of my own doing.

> 
> (Also, please consider how easy or difficult it is for a reader to interpret your
> pasted "sample session". The one provided is more confusing than necessary
> due to the command prompt bearing the same path information as the
> output of the "git worktree list" command, as well as unnecessary duplicated
> commands, such as "ls", and missing "cd" commands which do not help to
> illuminate what it is you are trying to get across. The pasted transcript also
> contains invalid code-points which render as oddball characters -- or not at all
> -- which didn't help. Best would be to prepare a minimal example of shell
> commands to reproduce the behavior you're trying to illustrate.)

Good point. Again, my bad - very long day debugging. I wanted to show where I was in the directory so I sacrificed brevity for completeness and noise. My apologies.

So, no bug, just a buggy user.

Cheers,
Randall

