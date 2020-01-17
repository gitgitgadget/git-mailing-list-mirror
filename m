Return-Path: <SRS0=B37d=3G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5177C33CB1
	for <git@archiver.kernel.org>; Fri, 17 Jan 2020 15:55:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7548A2083E
	for <git@archiver.kernel.org>; Fri, 17 Jan 2020 15:55:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nowsci.com header.i=@nowsci.com header.b="lNw+xhUJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729099AbgAQPzk (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Jan 2020 10:55:40 -0500
Received: from mail.nowsci.com ([172.104.14.39]:52136 "EHLO mail.nowsci.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727043AbgAQPzk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Jan 2020 10:55:40 -0500
X-Greylist: delayed 524 seconds by postgrey-1.27 at vger.kernel.org; Fri, 17 Jan 2020 10:55:39 EST
X-Virus-Scanned: Yes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nowsci.com; s=mail;
        t=1579276013; bh=cnViU6/7YdeQ7VqXkLht7i9wYTtDrYhoGwSsCHtLcqQ=;
        h=Subject:From:To:Cc:In-Reply-To:References;
        b=lNw+xhUJWB736LW9GUiwksciiUxSC6CqmhonHbMNU85yE6e+wpQRX566eJNhcP9c7
         ujPJnFjwZ2C19iJ3FUeqrpVm7SCzuFTymQ0h6M4uiX10Y8fqZyI4fwSmxcoF5TiTzf
         ov+md/RXy516Qo8h1wNDNOTNm+G0i6GwylVpBd+I=
X-Virus-Scanned: Yes
Message-ID: <fe3b20a8251b033a2392ee7f7a1110d026a4357e.camel@nowsci.com>
Subject: Re: [PATCH] commit: replace rebase/sequence booleans with single
 pick_state enum
From:   Ben Curtis <nospam@nowsci.com>
To:     git@vger.kernel.org
Cc:     Derrick Stolee <stolee@gmail.com>,
        Ben Curtis via GitGitGadget <gitgitgadget@gmail.com>
Date:   Fri, 17 Jan 2020 10:46:45 -0500
In-Reply-To: <551af3c3-4633-3dba-4999-1c1a63e5703a@gmail.com>
References: <pull.531.git.1579268705473.gitgitgadget@gmail.com>
         <551af3c3-4633-3dba-4999-1c1a63e5703a@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 2020-01-17 at 09:29 -0500, Derrick Stolee wrote:
> On 1/17/2020 8:45 AM, Ben Curtis via GitGitGadget wrote:
> > From: Ben Curtis <nospam@nowsci.com>
> > 
> > In 116a408, the boolean `rebase_in_progress` was introduced by
> > dscho to
> 
> In 116a408 (commit: give correct advice for empty commit during a
> rebase,
> 2019-10-22), ...
> 
> > handle instances when cherry-pick and rebase were occuring at the
> > same time.
> 
> s/occuring/occurring
> 
> > This created a situation where two independent booleans were being
> > used
> > to define the state of git at a point in time.
> > 
> > Under his recommendation to follow guidance from Junio,
> > specifically
> > `
> > https://public-inbox.org/git/xmqqr234i2q0.fsf@gitster-ct.c.googlers.com/`
> > ,
> 
> Use lore.kernel.org and use "[1]" like a citation.
> 
> [1] 
> https://lore.kernel.org/git/xmqqr234i2q0.fsf@gitster-ct.c.googlers.com/
> 
> > it was decided that an `enum` that defines the state of git would
> > be a
> > more effective path forward.
> > 
> > Tasks completed:
> 
> Everything in the message is about what you did and why. It's good
> that
> you prefaced the "what" with so much "why", but now you can just
> describe
> the "what" using paragraphs. The "Tasks completed:" line is
> superfluous.
> 
> >   - Remove multiple booleans `rebase_in_progress` and
> > `sequencer_in_use` and
> > replaced with a single `pick_state` enum that determines if, when
> > cherry-picking, we are in a rebase, multi-pick, or single-pick
> > state
> >   - Converted double `if` statement to `if/else if` prioritizing
> > `REBASE` to
> > continue to disallow cherry pick in rebase.>
> > 
> > Signed-off-by: Ben Curtis <nospam@nowsci.com>
> > ---
> >     commit: replaced rebase/sequence booleans with single
> > pick_state enum
> >     
> >     Addresses https://github.com/gitgitgadget/git/issues/426
> >     
> >     Previous discussions from @dscho and Junio led to the decision
> > to merge
> >     two independent booleans into a single enum to track the state
> > of git 
> >     during a cherry-pick leading to this PR/patch.
> > 

Sure thing! I will revise the commit as described. And thanks for the
feedback, just diving into `git` development so this is my first time
through and this is very helpful.

> > Published-As: 
> > https://github.com/gitgitgadget/git/releases/tag/pr-531%2FFmstrat%2Fjs%2Fadvise-rebase-skip-v1
> > Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-
> > 531/Fmstrat/js/advise-rebase-skip-v1
> > Pull-Request: https://github.com/gitgitgadget/git/pull/531
> > 
> >  builtin/commit.c | 24 +++++++++++++++---------
> >  1 file changed, 15 insertions(+), 9 deletions(-)
> > 
> > diff --git a/builtin/commit.c b/builtin/commit.c
> > index 2beae13620..84f7e69cb1 100644
> > --- a/builtin/commit.c
> > +++ b/builtin/commit.c
> > @@ -125,7 +125,11 @@ static enum commit_msg_cleanup_mode
> > cleanup_mode;
> >  static const char *cleanup_arg;
> >  
> >  static enum commit_whence whence;
> > -static int sequencer_in_use, rebase_in_progress;
> > +static enum {
> > +	SINGLE_PICK,
> > +	MULTI_PICK,
> > +	REBASE
> > +} pick_state;
> >  static int use_editor = 1, include_status = 1;
> >  static int have_option_m;
> >  static struct strbuf message = STRBUF_INIT;
> > @@ -184,10 +188,12 @@ static void determine_whence(struct wt_status
> > *s)
> >  		whence = FROM_MERGE;
> >  	else if
> > (file_exists(git_path_cherry_pick_head(the_repository))) {
> >  		whence = FROM_CHERRY_PICK;
> > -		if (file_exists(git_path_seq_dir()))
> > -			sequencer_in_use = 1;
> >  		if (file_exists(git_path_rebase_merge_dir()))
> > -			rebase_in_progress = 1;
> > +			pick_state = REBASE;
> > +		else if (file_exists(git_path_seq_dir()))
> > +			pick_state = MULTI_PICK;
> > +		else
> > +			pick_state = SINGLE_PICK;
> 
> Since before the "if"s were not exclusive, would rebase_in_progress =
> 1
> also include sequencer_in_use = 1? That would explain why you needed
> to
> rearrange the cases here. (Based on later checks, it seems that these
> cases are indeed independent.)
> 

While the above two `if` statements were not exclusive, their use in
the below `if` statements did appear to be (at first). The line right
above the if statement just below this comment is:

else if (whence == FROM_CHERRY_PICK) {

Since we are always in a cherry pick state, and the new code
prioritizes checking on a rebase first, I had thought this would work
out. However given the below I can see how the single-pick state could
still crop up. I will update the commit with REBASE_SINGLE and
REBASE_MULTI states to eliminate that without adding redundancy.

> > -			if (rebase_in_progress && !sequencer_in_use)
> > +			if (pick_state == REBASE)
> 
> This old error condition makes it appear that you _could_ be in the
> state
> where rebase_in_progress = 1 and sequencer_in_use = 0, showing that
> one
> does not imply the other.
> 
> > -			if (sequencer_in_use)
> > +			if (pick_state == MULTI_PICK)
> >  				fputs(_(empty_cherry_pick_advice_multi)
> > , stderr);
> > -			else if (rebase_in_progress)
> > +			else if (pick_state == REBASE)
> >  				fputs(_(empty_rebase_advice), stderr);
> >  			else
> >  				fputs(_(empty_cherry_pick_advice_single
> > ), stderr);
> 
> Since we are using an enum, should we rearrange these cases into a
> switch (pick_state)?
> 

Yes, that would be cleaner, I will shift to a switch.

> Thanks,
> -Stolee
> 

Thanks!
Ben

