Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 832A5C433E9
	for <git@archiver.kernel.org>; Mon,  1 Mar 2021 13:56:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B6CD64E83
	for <git@archiver.kernel.org>; Mon,  1 Mar 2021 13:56:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235999AbhCAN42 convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Mon, 1 Mar 2021 08:56:28 -0500
Received: from elephants.elehost.com ([216.66.27.132]:34737 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235983AbhCAN4Z (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Mar 2021 08:56:25 -0500
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [173.33.197.34])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id 121DteAH099213
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 1 Mar 2021 08:55:41 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Jean-Marie Lemetayer'" <jeanmarie.lemetayer@gmail.com>
Cc:     "=?UTF-8?Q?'=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason'?=" 
        <avarab@gmail.com>, <git@vger.kernel.org>
References: <CAAdc0hwmR7BF53_66LNaceLrkFPDphU-y2sLEGB_1YoR5ErQsg@mail.gmail.com> <87tupy7sx6.fsf@evledraar.gmail.com> <042b01d70c5e$593f0380$0bbd0a80$@nexbridge.com> <CAAdc0hw5O8aUQUdFnbUsiigdkhp_Sd6Djef3Hz9oA8XqN7Mhjg@mail.gmail.com>
In-Reply-To: <CAAdc0hw5O8aUQUdFnbUsiigdkhp_Sd6Djef3Hz9oA8XqN7Mhjg@mail.gmail.com>
Subject: RE: [RFC] new subcommand: git sync
Date:   Mon, 1 Mar 2021 08:55:35 -0500
Message-ID: <008d01d70ea2$90f0f400$b2d2dc00$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQEsx88Gsg9SUtS2FEWLuPNec+9+BwErBOsKAiRIcVYBxWrOWqubDsiw
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On March 1, 2021 4:48 AM, Jean-Marie Lemetayer wrote:
> To: Randall S. Becker <rsbecker@nexbridge.com>
> Cc: Ævar Arnfjörð Bjarmason <avarab@gmail.com>; git@vger.kernel.org
> Subject: Re: [RFC] new subcommand: git sync
> 
> On Fri, Feb 26, 2021 at 5:42 PM Randall S. Becker <rsbecker@nexbridge.com>
> wrote:
> >
> > On February 26, 2021 10:25 AM, : Ævar Arnfjörð Bjarmason wrote:
> > > To: Jean-Marie Lemetayer <jeanmarie.lemetayer@gmail.com>
> > > Cc: git@vger.kernel.org
> > > Subject: Re: [RFC] new subcommand: git sync
> > >
> > > On Fri, Feb 26 2021, Jean-Marie Lemetayer wrote:
> > >
> > > > Hi folks,
> > > >
> > > > I created a new "git sync" sub-command a few months ago to deal
> > > > with the pull request workflow.
> > > >
> > > > Its goals are to:
> > > >  - keep all configured branches synchronized with the remotes
> > > > (--set-upstream)
> > > >  - do not touch your wip feature branches (which has diverged from
> > > > upstream)
> > > >  - prune the remotes
> > > >
> > > > As I use it on a daily basis, to synchronize the remotes and then
> > > > be able to quickly rebase my pull requests. I think it's worth
> > > > sharing. What do
> > > you think?
> > > >
> > > > For now it is a simple shell script available here:
> > > > https://github.com/jmlemetayer/one-time-setup/blob/main/git-sync
> > > >
> > > > If you think it's a good idea, I'll propose a series of patches
> > > > with the new sub-command, the manual page and the associated tests.
> > >
> > > Have you seen 'git branch -v' and 'git branch -v --format=*'? There
> > > seems to be a high amount of overlap between this wrapper you've
> written and it.
> > >
> > > I suspect most of what you have here could be turned into an %(if:*)
> > > directive where you emit the pull/push command as appropriate.
> > >
> > > If you search the internet for "git-sync" there's dozens of such
> > > command (and I've personally observed at least two of them being
> > > written by co- workers in real time, not sure if either of those is in the
> Google results).
> > >
> > > So I think there's probably a worthwhile problem to be solved here
> > > that could be turned into patches to git.git, something between "git
> > > [clone|push] --mirror" and "git branch -v".
> > >
> > > I don't think there's any interest in getting new shellscript
> > > built-ins in the future. We've been actively migrating away from those.
> > >
> > > But most of the logic in your script is just calling the
> > > ref-filter.c API behind the scenes.
> > >
> > > B.t.w. you can probably speed up & simplify your script a lot by
> > > making use of IFS="" in the shell and not calling N for-each-ref
> > > commands when it seems to me that one invocation would do. Just
> dump
> > > the N fields you need split on some token, and split on that token in your
> loop.
> >
> > Yeah, I'm one of those that has made extensive use of the name "sync"
> when using git to synchronize between (POSIX) OSS/USS and (Non-POSIX)
> NonStop/MVS respectively. If you're going somewhere with it, could I
> suggest something like "reconcile" or of it is specific to the pull workflow,
> maybe "pull-sync"? I agree that scripts are not desirable long-term.
> 
> Thanks for the feedback !
> 
> To sum up -- if I have the time to do it -- I must do it in native C and not use a
> generic name like "sync".
> 
> As it is a way to keep my branches up to date with the remotes, maybe
> create an option for the "git branch" submodule instead of a new
> subcommand? Maybe "git branch --synchronize" or something better ...
> 
> As using "Pull request" is not the only way to use this command and also
> because there is a big trolling issue with the termes"Pull request" and
> "Merge request" I don't think using "pull-sync" is a good idea either.
> 
> I know that the first golden rule of coding is "Naming", but damn, sometimes
> it's hard to find a good name.

It's almost feels like you are thinking along the lines of a variant of a mirror rather than pulls and merges. I wonder whether that analogy would hold up? I would love to have a stable mechanism of mirroring repositories when doing development on 2-3 platforms at the same time. Yes, pull/merge can be a bit heavy handed in this situation. I have considered something like rsync to do the job (which it can), but within a git context it sounds more like a mirror - although it would be nice to mirror work in progress. So perhaps this should go through the stash mechanism.

