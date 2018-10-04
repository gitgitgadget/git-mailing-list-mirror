Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1E2851F453
	for <e@80x24.org>; Thu,  4 Oct 2018 13:16:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727469AbeJDUJy (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 Oct 2018 16:09:54 -0400
Received: from fed1rmfepo203.cox.net ([68.230.241.148]:55370 "EHLO
        fed1rmfepo203.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727415AbeJDUJx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Oct 2018 16:09:53 -0400
Received: from fed1rmimpo306.cox.net ([68.230.241.174])
          by fed1rmfepo203.cox.net
          (InterMail vM.8.01.05.28 201-2260-151-171-20160122) with ESMTP
          id <20181004131637.UUNS4163.fed1rmfepo203.cox.net@fed1rmimpo306.cox.net>
          for <git@vger.kernel.org>; Thu, 4 Oct 2018 09:16:37 -0400
Received: from thunderbird.smith.home ([68.2.114.239])
        by fed1rmimpo306.cox.net with cox
        id jRGc1y02l59yGBo01RGdKZ; Thu, 04 Oct 2018 09:16:37 -0400
X-CT-Class: Clean
X-CT-Score: 0.00
X-CT-RefID: str=0001.0A09020C.5BB612B5.003B,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
X-CT-Spam: 0
X-Authority-Analysis: v=2.3 cv=cYVmUULM c=1 sm=1 tr=0
 a=BlDZPKRk22kUaIvSBqmi8w==:117 a=BlDZPKRk22kUaIvSBqmi8w==:17
 a=kj9zAlcOel0A:10 a=x7bEGLp0ZPQA:10 a=smKx5t2vBNcA:10 a=1XWaLZrsAAAA:8
 a=mK_AVkanAAAA:8 a=zXwBfdiiUvvSbLr2YdIA:9 a=CjuIK1q_8ugA:10
 a=3gWm3jAn84ENXaBijsEo:22
X-CM-Score: 0.00
Authentication-Results: cox.net; auth=pass (LOGIN) smtp.auth=ischis2@cox.net
Received: from thunderbird.localnet (localhost [127.0.0.1])
        by thunderbird.smith.home (Postfix) with ESMTP id D52EF29A010A;
        Thu,  4 Oct 2018 06:16:36 -0700 (MST)
From:   Stephen Smith <ischis2@cox.net>
To:     Chris Jeschke <chrisjberlin@googlemail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        sbeller@google.com, git@vger.kernel.org
Subject: Re: inside the git folder
Date:   Thu, 04 Oct 2018 06:16:36 -0700
Message-ID: <384680468.dD3INfo3AG@thunderbird>
Organization: Personal
References: <CADWf5z4pAR20qeoT1RnYENBB7Q5fA2fVVTNqPzMzvOE5Dq02qA@mail.gmail.com> <CADWf5z4DNRj=+X5pUF-Pe4vTq01OmFLk7KMP-=_hWWOEmsJg4A@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Chris -

You may want to look at "git bundle" to transfer the repository contents.   
Then the recipient could fetch from the bundle to get the source git history.

Just a thought.

sps

On Thursday, October 4, 2018 4:03:27 AM MST Johannes Schindelin wrote:
> Hi Chris,
> 
> as mentioned by Stefan (who is a respected, active core Git contributor,
> if you need any more arguments to listen to him), it is inappropriate to
> copy the contents of the .git/ directory wholesale to another user's
> machine.
> 
> For one, it would horribly break in case the user overrode `user.email` in
> `.git/config`. That's one setting that should not be copied *anywhere*.
> And that's just one, there are *plenty* more examples. Just think of
> absolute paths referring to files that probably do not even exist on
> another machine! Like, worktrees, etc.
> 
> Of course, you could start a list of exceptions (files, config keys, etc)
> that should not be copied. But that's very fragile a solution.
> 
> So no, copying the .git/ directory is always the wrong thing to do, as
> Stefan pointed out.
> 
> I could imagine that a much better idea is to identify a *positive* list
> of things you want to copy over. The output of `git rev-parse
> --symbolic-full-name HEAD`? Sure. Maybe even the output of `git rev-parse
> --symbolic-full-name HEAD@{u}`? And then the URL of the corresponding
> remote? Sure. `.git/objects/alternates/`? Absolutely not.
> 
> It is tedious, alright, but you simply cannot copy the contents of .git/
> to another machine and expect that to work.
> 
> Ciao,
> Johannes
> 
> On Thu, 4 Oct 2018, Chris Jeschke wrote:
> > Hi Stefan,
> > 
> > thanks for your answer.
> > 
> > The Goal after sending the files is to have a copy on the remote site.
> > This includes that the working directory is the same (what we already
> > guarantee with our tool) and that git is at the same 'state' (that
> > means that we have the same history and that we checkout at the same
> > branch/commit).
> > My idea:
> > Send the working directory with our  tool
> > Initialize a Git directory on the remote side
> > Send the 'objects','refs', 'HEAD' and the 'gitignore' with our tool
> > 
> > Is there anything else I should take care of?
> > 
> > Am Mi., 3. Okt. 2018 um 20:51 Uhr schrieb Stefan Beller 
<sbeller@google.com>:
> > > On Wed, Oct 3, 2018 at 5:26 AM Chris Jeschke
> > > 
> > > <chrisjberlin@googlemail.com> wrote:
> > > > Hey git-team,
> > > > I am working on a plug-in for a distributed pair programming tool. To
> > > > skip the details: I was thinking about sending parts of the git folder
> > > > as a zip folder with our own Bytestream instead of using the git API.
> > > > Is there a common sense about what should and what shouldn't be done
> > > > when working with the files inside the git folder?
> > > 
> > > This contradicts the security model of git.
> > > 
> > > Locally I can do things like:
> > >     git config alias.co "rm -rf ~"
> > >     echo "rm -rf ~" >.git/hooks/{...}
> > > 
> > > and I would experience bad things, but that is ok,
> > > as I configured it locally (supposedly I know what
> > > I am doing); but if I have the ability to send these
> > > tricks to my beloved coworkers, hilarity might ensue.
> > > 
> > > What stuff do you need to send around?
> > > 
> > > objects? Fine, as the receive could check they are
> > > good using fsck.
> > > 
> > > refs/ ? Sure. It may be confusing to users,
> > > but I am sure you'll figure UX out.
> > > 
> > > local config, hooks ? I would not.
> > > 
> > > Not sure what else you'd think of sending around.
> > > 
> > > Cheers,
> > > Stefan




