Return-Path: <SRS0=gV3S=CS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEFC6C43461
	for <git@archiver.kernel.org>; Wed,  9 Sep 2020 22:37:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 844E821D7E
	for <git@archiver.kernel.org>; Wed,  9 Sep 2020 22:37:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="jYnCrNXI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729779AbgIIWhM (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Sep 2020 18:37:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729298AbgIIWgz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Sep 2020 18:36:55 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53906C061573
        for <git@vger.kernel.org>; Wed,  9 Sep 2020 15:36:50 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id g18so2741421pgl.10
        for <git@vger.kernel.org>; Wed, 09 Sep 2020 15:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=ziaiP1wJL1os9i1v5UPiXwHGmy2cqkzT9UzD7FyVUdk=;
        b=jYnCrNXIIpDDpSe0ETcC7YQsWFWy99YupP4s6abgyynazxkZv607amPRPkI46hHelW
         Efvb82qU7dScCvFowx5C7yfzIYW8424jxqY9RGJwn0VJfOL+8y7Q4/RBPCM6+1r6FNHX
         bP5GXM+VeBdQvc8msWNOXcBcRzvP5KRDchx/gLCziEW33x/YeB5z9fWYBuo/DzcDyR+l
         I5azzbfnbW/M1uG5Y/zwMOlm6hSworfX66hbAY251ARGl12aCs+gEW9Nv1frFMUL82VW
         CSFqz0UMngaUIRwYzaAjR/uUshBolLdG04jofAIufj7rg2YiEB02jepcDh8GUKwFn5wt
         2czA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ziaiP1wJL1os9i1v5UPiXwHGmy2cqkzT9UzD7FyVUdk=;
        b=LZmK7cSumoAX/AV8GLSBuh5qRtWm44gaFCmC+7rbp7y+TxHXi154sJeDjsEFCoSIiM
         /wVCv4cEgN22QEvHlrBjT+vfwqhDpuzX6nb1wilyE6PdcCWEzR2YgmK6d30uqdHf7qqq
         kWZLJuN1m2bbG3Ft2KHYh247raIz5MNLCk6uPs11FvWm0u05JEglbi6oUmP6Oi3XMNYY
         QkA1UOCBLJYqfagT3pRaWSjOR/XdSxwWIZGz0LMDvG9WQ12sQ96LWf2lDp3j5Lcxxlox
         rkWj4LW7ynYinWFMcsogT+6bNeTGhvo5rlVofNcgaDCT/McQMwhKvb2bPu/hjN0bgE1b
         2kGg==
X-Gm-Message-State: AOAM530HaCvojmLUnThxfcRMEeICVPeJ0d9XT807PnLXbEEK3YGXZrkh
        1ZjyEq4ZXR+aGLm702f/bfz2cqPVIhHMUbvAv4aF
X-Google-Smtp-Source: ABdhPJzB/TUG9KZ4TaG3F11nAyhJwzb29fAZlT+uEplEdzzqoclfLo68+NnT3IFzdQN+KpMOnI66Gie1LoqKY7+uqs+K
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:18d])
 (user=jonathantanmy job=sendgmr) by 2002:a17:90a:cc0e:: with SMTP id
 b14mr2477397pju.166.1599691005496; Wed, 09 Sep 2020 15:36:45 -0700 (PDT)
Date:   Wed,  9 Sep 2020 15:36:31 -0700
In-Reply-To: <xmqq365zro2u.fsf@gitster.c.googlers.com>
Message-Id: <20200909223631.864145-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <xmqq365zro2u.fsf@gitster.c.googlers.com>
X-Mailer: git-send-email 2.28.0.526.ge36021eeef-goog
Subject: Re: [PATCH 1/2] progress: create progress struct in 'verbose' mode
From:   Jonathan Tan <jonathantanmy@google.com>
To:     gitster@pobox.com
Cc:     emilyshaffer@google.com, git@vger.kernel.org,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> But there are others that look a bit problematic.  In this example
> taken from fsck, we open all the pack index, only because it is
> needed to show the progress, and the existing conditionals are ways
> to avoid spending unneeded cycles.
> 
> > @@ -836,16 +836,15 @@ int cmd_fsck(int argc, const char **argv, const char *prefix)
> >  			uint32_t total = 0, count = 0;
> >  			struct progress *progress = NULL;
> >  
> > -			if (show_progress) {
> > -				for (p = get_all_packs(the_repository); p;
> > -				     p = p->next) {
> > -					if (open_pack_index(p))
> > -						continue;
> > -					total += p->num_objects;
> > -				}
> > -
> > -				progress = start_progress(_("Checking objects"), total);
> > +			for (p = get_all_packs(the_repository); p;
> > +			     p = p->next) {
> > +				if (open_pack_index(p))
> > +					continue;
> > +				total += p->num_objects;
> >  			}
> > +
> > +			progress = start_progress(_("Checking objects"), total,
> > +						  show_progress);
> >  			for (p = get_all_packs(the_repository); p;
> >  			     p = p->next) {
> >  				/* verify gives error messages itself */
> 
> Likewise, we do not even have to be scanning the index entries
> upfront if we are not showing the progress report (and more
> importantly, the user likely has chosen the speed/cycles over eye
> candy progress meter) while checking out paths from the index.

This was the most problematic one I saw, and I don't think it's that
problematic - the loop at the bottom of the quotation above calls
verify_pack(), which also calls open_pack_index(), so (unless some of
the "struct packed_git" are freed in the meantime - I haven't looked at
this closely) the opening of the pack indexes are not being wasted.

I also saw some strbuf manipulation to generate the title, but I also
don't think that takes significant cycles compared to the task that
requires the progress display.

But if this is a problem, one thing we could do is pass the total as a
callback instead of as an int, and provide a generic callback that just
returns the dereferenced cb_data. Most invocations would just use that
generic callback. (Alternatively, as discussed in-office, we could allow
start_progress() to return NULL when no progress display is needed,
change start_progress() to not take a total, add a progress_set_total(),
and check in display_progress() that the total has been set before
proceeding.)

> But the other codepaths may be doing conditional computation not
> based on "if (show_progress)" but on "if (progress)", in which case
> with this patch, we may be paying a lot more overhead even if we
> know progress meter won't be shown and the worse part from
> reviewability point of view is that this patch does not explicitly
> do anything to make it happen because start_delayed_progress() now
> unconditionally give a non-NULL progress structure to enable them.

One way to enumerate this might be to get the LHS of all the assignments
from start_progress() and friends (e.g. "pi.progress" in
builtin/blame.c, "progress" in builtin/commit-graph.c) and then grepping
the respective files to see if "if (.*[LHS]" is done.
