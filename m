Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8223E1F454
	for <e@80x24.org>; Sun,  3 Nov 2019 07:55:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727499AbfKCHzD (ORCPT <rfc822;e@80x24.org>);
        Sun, 3 Nov 2019 02:55:03 -0500
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:43771 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726546AbfKCHzD (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Nov 2019 02:55:03 -0500
X-Originating-IP: 1.186.12.57
Received: from localhost (unknown [1.186.12.57])
        (Authenticated sender: me@yadavpratyush.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 802DA20002;
        Sun,  3 Nov 2019 07:55:00 +0000 (UTC)
Date:   Sun, 3 Nov 2019 13:24:58 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     Jonathan Gilbert via GitGitGadget <gitgitgadget@gmail.com>
Cc:     "Bert Wesarg bert.wesarg-at-googlemail.com |GitHub Public/Example Allow|" 
        <xlwsizdz58ciy7t@sneakemail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jonathan Gilbert <rcq8n2xf3v@liamekaens.com>
Subject: Re: [PATCH 0/2] git-gui: revert untracked files by deleting them
Message-ID: <20191103074801.7fsqqi3hsefvcmby@yadavpratyush.com>
References: <pull.436.git.1572418123.gitgitgadget@gmail.com>
 <CAKPyHN1p+xRAF3Mjg_XqRiEUviGjj8ifP5FM=1hVb5LZUshzLw@mail.gmail.com>
 <CAPSOpYufF8B0sBUUYqBx5YTxH+02qRom+tz4a0_2iBcNOvvMXA@mail.gmail.com>
 <20191103011225.b6emr2ldskktokgd@yadavpratyush.com>
 <CAPSOpYsBRf4tCXP-wod2h+g_=NZ-Qr0KOSZw3M=96d5FUFpFzw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPSOpYsBRf4tCXP-wod2h+g_=NZ-Qr0KOSZw3M=96d5FUFpFzw@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

[Dropping "Jonathan Gilbert <logic@deltaq.org>" from the To: list because 
my mail server says "Domain not found". Putting the GGG address in To: 
instead.]

On 02/11/19 11:41PM, Jonathan Gilbert wrote:
> On Sat, Nov 2, 2019, 8:12 PM Pratyush Yadav, <me@yadavpratyush.com> wrote:
> > On 30/10/19 12:16PM, Jonathan Gilbert wrote:
> > > It's less about overloading the 'revert' operation as overloading the
> > > UI action which is currently called "Revert". I think it would be a
> > > worse experience to have to activate a different option to remove
> > > unwanted files as to remove unwanted changes. Maybe the UI option
> > > could be renamed "Revert & Clean" or something?
> >
> > I disagree. There are valid workflows where you want to remove all
> > changes to tracked files, but leave untracked ones alone. As an example,
> > say you wrote a small script to fix some textual things, like your
> > variable re-name patch. Now you run a diff before you commit those
> > changes just to be sure, and notice that your script was overzealous and
> > made some changes it shouldn't have. So, you clean up all tracked files,
> > and give your script a fresh start. Here, you don't want to delete your
> > script.
> >
> > And in the other direction, say you want to delete all untracked files
> > but have unstaged changes in your tracked files. Combining "Revert" and
> > "Clean" does not give you an option to only delete untracked files. So
> > you now either have to stash your changes, or run `git clean` from the
> > command line.
> 
> But, since this is in this GUI interface, you can clearly see which
> are which and select only the files you want to affect. If you have so
> many files that you have to select indiscriminately, then the
> command-line is probably a better choice anyway. In any case, my
> proposed change prompts for each part of the change, so you _can_ just
> select everything, press ^J, and then say "Yes" to only one of the
> prompts.

Ah yes! Makes sense. I got too tunnel-visioned when thinking about this, 
and lost context. Sorry.
 
> > > As a side note, `git clean untracked-file` won't do anything with a
> > > default configuration, you have to explicitly `-f` it. Not sure if
> > > that's relevant, but it does feel like a higher barrier to entry than
> > > `git revert`.
> >
> > `git revert` is different from our "Revert", though I admit the naming
> > is quite confusing.
> [..]
> > So I don't think you should, or _can_, use `git revert` for what you
> > want to do. And so, I don't see why it is being factored in with this
> > discussion. Am I missing something?
> 
> You are entirely correct, this was just a massive brain fart. Every
> time I wrote `git revert` in my head I was actually thinking of
> exactly what Git Gui does, reverting working copy changes by checking
> out the file. I should have written "reverting using `git checkout`".
> My apologies!
> 
> In my defence, I have over the past few days found myself digging into
> code hosted in SVN repositories, and `svn revert` does exactly what
> `git checkout` does to an unstaged modified file. :-)

I have never used svn, but I can imagine now confusing that might be ;)

-- 
Regards,
Pratyush Yadav
