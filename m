Return-Path: <SRS0=R55k=B3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1179BC433E3
	for <git@archiver.kernel.org>; Mon, 17 Aug 2020 22:20:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DCA7E20738
	for <git@archiver.kernel.org>; Mon, 17 Aug 2020 22:20:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KErkap0R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728864AbgHQWUb (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Aug 2020 18:20:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729002AbgHQWTo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Aug 2020 18:19:44 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1833CC061342
        for <git@vger.kernel.org>; Mon, 17 Aug 2020 15:19:44 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id k13so8234046plk.13
        for <git@vger.kernel.org>; Mon, 17 Aug 2020 15:19:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=akksgQNyDhMtOxGJYgXldN64D1pEzC3rO6DOv2gbNeE=;
        b=KErkap0R/gKDdZIHvZChS3aN9MpgGDMkVakiDSK5mDRdiXDmEBqTVRWRddhjQFX+EO
         aZvk4GpVPMts2xyBxbFls+x+4SRGY7ntzmryeeD7AQiCq/Q/gyu9smWkWFLKvro+V+cS
         vRghgQXPvp4C3EPm+hzrFqlO6BmWYNRlPXK5Nz8envqIoSrMpxkbicNemoV3cIHqKs3w
         sf2eg2GgYl5o9Pj7gw0lp1GGZy2NLUboTVXvAR7Kv0M3OXsLpE9eCoTqeAlKGgXyILGJ
         vIJD5HclhXqyVwdndpeYCVK6caboYlYYXxWSWBE5nkneWtIVuDQd6vAAZ4lP5Nt4Y50A
         qg0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=akksgQNyDhMtOxGJYgXldN64D1pEzC3rO6DOv2gbNeE=;
        b=lX/DH2d9OMuFMPShcoDI9yYu7RtBiuAGgrzYr7pb+OXYEAwfyY+xMJAklhIbwEABYS
         nu2i3WRBW7EKLQNVH5YL7GkRW+j+jZsbVBxP+FExRoWlkShIST3h7WjguOXstzdpOefh
         z8GL/v8AL52PmWdcJRI3Sikb5bhyrEKQtZYOUiEzR/+OXFzSCHEgjBS+1viSLTwhO8F7
         19OvSo5WeRf+3IWP6HWPkXN5OV5+ahcVngGwmB6DmLU6ZCyreKvOnLrtiwOAC5zbFIJc
         1+8B+fa0BAmHCTD5Oa/Da+OfTvjIuEgTudNgnCrSaRhoYyigOLxvWJLa2reggU6QxqIe
         pEMQ==
X-Gm-Message-State: AOAM533zlwfAmlRcgoBd28r9yI1bK6vSZOaqMc/QpYEK3zbKcKURDTHz
        QYE/nCu3UPhdxxvmvl7sTyHlx/uaFOskSA==
X-Google-Smtp-Source: ABdhPJxcZ7dPhUygqC/8PKEO/SUT6VHSKNd3R6Dc44yUPp8owGLcMan+7j0zpO+/0D2yuYcUaWl2iQ==
X-Received: by 2002:a17:90b:4a4e:: with SMTP id lb14mr14334979pjb.228.1597702783206;
        Mon, 17 Aug 2020 15:19:43 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:1ea0:b8ff:fe77:f690])
        by smtp.gmail.com with ESMTPSA id e23sm18369548pgb.79.2020.08.17.15.19.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2020 15:19:42 -0700 (PDT)
Date:   Mon, 17 Aug 2020 15:19:38 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/2] progress: create progress struct in 'verbose' mode
Message-ID: <20200817221938.GA331156@google.com>
References: <20200710014242.1088216-1-emilyshaffer@google.com>
 <20200710014242.1088216-2-emilyshaffer@google.com>
 <xmqq365zro2u.fsf@gitster.c.googlers.com>
 <20200714001504.GI3189386@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200714001504.GI3189386@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 13, 2020 at 05:15:04PM -0700, Emily Shaffer wrote:
> 
> On Fri, Jul 10, 2020 at 03:40:25PM -0700, Junio C Hamano wrote:
> > > diff --git a/builtin/blame.c b/builtin/blame.c
> > > index 94ef57c1cc..1d72b27fda 100644
> > > --- a/builtin/blame.c
> > > +++ b/builtin/blame.c
> > > @@ -1129,8 +1129,8 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
> > >  
> > >  	sb.found_guilty_entry = &found_guilty_entry;
> > >  	sb.found_guilty_entry_data = &pi;
> > > -	if (show_progress)
> > > -		pi.progress = start_delayed_progress(_("Blaming lines"), sb.num_lines);
> > > +	pi.progress = start_delayed_progress(_("Blaming lines"), sb.num_lines,
> > > +					     show_progress);
> > >  
> > >  	assign_blame(&sb, opt);
> > 
> > But there are others that look a bit problematic.  In this example
> > taken from fsck, we open all the pack index, only because it is
> > needed to show the progress, and the existing conditionals are ways
> > to avoid spending unneeded cycles.
> 
> That info is still used, when performing trace log during
> stop_progress():
> 
>   if (p_progress && *p_progress) {
>           trace2_data_intmax("progress", the_repository, "total_objects",
>                              (*p_progress)->total);
> 
>           if ((*p_progress)->throughput)
>                   trace2_data_intmax("progress", the_repository,
>                                      "total_bytes",
>                                      (*p_progress)->throughput->curr_total);
> 
>           trace2_region_leave("progress", (*p_progress)->title, the_repository);
>   }
> 
> Because the progress struct is no longer NULL, we can write down the
> number of objects calculated to the trace2 log file. So the expense of
> calculating it is not wasted, at least in scenarios where someone cares
> about the output of the trace log.
> 
> But yes, lots of users don't care about trace log - they are using their
> home computer and don't care about metrics like how many objects were
> transferred in every single push. Now it becomes a little strange - is
> it better to instead wrap each 'struct progress' constructor in "if
> (should_i_log || should_i_trace)"? Have we got a simple way to look up
> 'should_i_trace'?
> 
> Some later comments have the same point - "why am I calculating the
> totals if the user won't see and doesn't care?" - so I won't respond to
> each other one; my reply is the same.
> 
> > 
> > > @@ -836,16 +836,15 @@ int cmd_fsck(int argc, const char **argv, const char *prefix)
> > >  			uint32_t total = 0, count = 0;
> > >  			struct progress *progress = NULL;
> > >  
> > > -			if (show_progress) {
> > > -				for (p = get_all_packs(the_repository); p;
> > > -				     p = p->next) {
> > > -					if (open_pack_index(p))
> > > -						continue;
> > > -					total += p->num_objects;
> > > -				}
> > > -
> > > -				progress = start_progress(_("Checking objects"), total);
> > > +			for (p = get_all_packs(the_repository); p;
> > > +			     p = p->next) {
> > > +				if (open_pack_index(p))
> > > +					continue;
> > > +				total += p->num_objects;
> > >  			}
> > > +
> > > +			progress = start_progress(_("Checking objects"), total,
> > > +						  show_progress);
> > >  			for (p = get_all_packs(the_repository); p;
> > >  			     p = p->next) {
> > >  				/* verify gives error messages itself */
> > 
> > Likewise, we do not even have to be scanning the index entries
> > upfront if we are not showing the progress report (and more
> > importantly, the user likely has chosen the speed/cycles over eye
> > candy progress meter) while checking out paths from the index.
> > 
> > > diff --git a/unpack-trees.c b/unpack-trees.c
> > > index 4be5fc3075..fa84244466 100644
> > > --- a/unpack-trees.c
> > > +++ b/unpack-trees.c
> > > @@ -338,16 +338,14 @@ static struct progress *get_progress(struct unpack_trees_options *o,
> > >  {
> > >  	unsigned cnt = 0, total = 0;
> > >  
> > > -	if (!o->update || !o->verbose_update)
> > > -		return NULL;
> > > -
> > >  	for (; cnt < index->cache_nr; cnt++) {
> > >  		const struct cache_entry *ce = index->cache[cnt];
> > >  		if (ce->ce_flags & (CE_UPDATE | CE_WT_REMOVE))
> > >  			total++;
> > >  	}
> > >  
> > > -	return start_delayed_progress(_("Updating files"), total);
> > > +	return start_delayed_progress(_("Updating files"), total,
> > > +				      (o->update && o->verbose_update));
> > >  }
> > >  
> > >  static void setup_collided_checkout_detection(struct checkout *state,
> > 
> > 
> > And there are cases where the "is progress enabled?" parameter (by
> > the way, I am not sure 'verbose' is quite the right name for the
> 
> I struggled some with this; I also considered using 'quiet' but it
> required inverting the logic everywhere when all callers already were
> asking "should I print?" instead of "should I not print?". Maybe "print"
> is better?
> 
> > parameter and the field name, as that word implies there can be
> > multiple verbosity levels---what I see you've done is that you added
> > an "is this enabled?" flag) is not a simple variable, like these.
> > Some are simple enough, but some are not.  Some of the worst appear
> > in preload-index.c and read-cache.c---they may become easier to read
> > if we introduced a variable to be passed as the "enable?"  parameter
> > and compute it before makng a call, and that might be enough, though.
> 
> Sure, makes sense.
> 
> > > diff --git a/read-cache.c b/read-cache.c
> > > index aa427c5c17..2ddc422dbd 100644
> > > --- a/read-cache.c
> > > +++ b/read-cache.c
> > > @@ -1532,9 +1532,9 @@ int refresh_index(struct index_state *istate, unsigned int flags,
> > >  	const char *unmerged_fmt;
> > >  	struct progress *progress = NULL;
> > >  
> > > -	if (flags & REFRESH_PROGRESS && isatty(2))
> > > -		progress = start_delayed_progress(_("Refresh index"),
> > > -						  istate->cache_nr);
> > > +	progress = start_delayed_progress(_("Refresh index"),
> > > +					  istate->cache_nr,
> > > +					  (flags & REFRESH_PROGRESS && isatty(2)));
> > >  
> > >  	trace_performance_enter();
> > >  	modified_fmt   = in_porcelain ? "M\t%s\n" : "%s: needs update\n";
> > 
> > 
> > And here is the only one that may benefit from this change, which
> > cares that the codepath prepared in rev-list, primarily to support
> > the progress meter, is exercised because those pieces of code
> > happens to be used by the tracing output as well.  Perhaps we
> > shouldn't have tied the "when showing progress, we can also trace"
> > earlier and we didn't have to touch this many codepath only to spend
> > cycles when progress output is not desired?
> 
> I guess I don't see how this is the only caller that benefits. The
> tracing output should appear in all the places where I touched the code;
> that was the point of the earlier change. Since the object total is provided in
> start_progress() and friends, and the runtime is logged by
> region_enter() in start_progress() and region_leave() in
> stop_progress(), then every caller is now unconditionally leaving traces
> to give some impression of how much work and how long it took. So I am
> confused - can you explain how the other callers don't benefit?
> 
> > 
> > > diff --git a/builtin/rev-list.c b/builtin/rev-list.c
> > > index f520111eda..f64cad8390 100644
> > > --- a/builtin/rev-list.c
> > > +++ b/builtin/rev-list.c
> > > @@ -620,8 +620,13 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
> > >  	if (bisect_list)
> > >  		revs.limited = 1;
> > >  
> > > -	if (show_progress)
> > > -		progress = start_delayed_progress(show_progress, 0);
> > > +	/*
> > > +	 * When progress is not printed to the user, we still want to be able to
> > > +	 * classify the progress during tracing. So, use a placeholder name.
> > > +	 */
> > > +	progress = start_delayed_progress(
> > > +			show_progress ? show_progress : _("Quiet rev-list operation"),
> > > +			0, show_progress != NULL);
> > 
> > I've cut out the hunks that exhibits similar looking patterns as the
> > ones I covered in the above discussion.  You are right to say that
> > these are simple and similar changes all over the place.  I am not
> > yet convinced that the simplicity supports that this change is the
> > right thing to do, though.  The only saving grace might be that
> > there aren't that many hunks that explicitly do unnecessary things
> > like the ones in unpack-trees.c and builtin/fsck.c even when we are
> > not showing progress.  
> > 
> > But the other codepaths may be doing conditional computation not
> > based on "if (show_progress)" but on "if (progress)", in which case
> 
> Hm, good point. For what it's worth, I performed the changes manually:
> 
>   git grep "start_progress()"
>   for each caller, open in vim
>   /progress
>   delete or move if necessary
>   (repeat until all matches for /progress look right)
> 
> and I did not see cases where 'if (progress)' was being used. That is
> hard to express in a diff; I can try to audit it better. (This process
> is how I also noticed the things to change in 2/2 in this series, even
> though they are unrelated to start_progress()).
> 
> > with this patch, we may be paying a lot more overhead even if we
> > know progress meter won't be shown and the worse part from
> > reviewability point of view is that this patch does not explicitly
> > do anything to make it happen because start_delayed_progress() now
> > unconditionally give a non-NULL progress structure to enable them.
> > 
> > So I dunno.  It certainly is not for the upcoming release, but we do
> > want to make sure that trace requested even when the command is quiet
> > gets collected in the longer term (i.e. during the next cycle).
> 
> Ok. It sounds like you are saying you want the spirit of the change,
> even if not in this exact form - that is good to know.

A month later, are we still interested in this change? I'd like to
pursue it - we are trying to use this progress tracing internally to
generate some metrics and not having this change (or some version of it)
means those metrics aren't accurate.

The main concern I saw here was "we are doing a lot of work that isn't
used if the user doesn't want to log traces" - should I approach a
reroll of this topic by trying to be smarter about whether to set
'quiet' or 'print' or 'verbose' or whatever it is renamed to, based on
whether there is a trace destination? Then for systems which are logging
traces the extra work is worth it, but for everyone else it can function
as before.

I don't love it from a design perspective - it feels a little like
progress module is looking a little too closely at trace module
internals - but from a performance perspective I see the appeal.

On the other hand, progress operations are showing progress because they
are slow - is a little more work on something that's already
human-noticeable slow such a big deal?

 - Emily
