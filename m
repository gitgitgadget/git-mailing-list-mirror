Return-Path: <SRS0=PU/F=7O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1C86C433E0
	for <git@archiver.kernel.org>; Mon,  1 Jun 2020 20:54:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B0B72074B
	for <git@archiver.kernel.org>; Mon,  1 Jun 2020 20:54:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="O2Pm80fN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728205AbgFAUyz (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Jun 2020 16:54:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726124AbgFAUyz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Jun 2020 16:54:55 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D324C061A0E
        for <git@vger.kernel.org>; Mon,  1 Jun 2020 13:54:55 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id a5so7978367qkk.12
        for <git@vger.kernel.org>; Mon, 01 Jun 2020 13:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=JshZMKKSsqOKl3M686OnbSzLC5CT/c3VOU9E4R8HR1Y=;
        b=O2Pm80fNprYxo68QKrHCD9+j6TkP6TuZEe9rqfPjIA9A+SwAYFjSopE3cLZH8L8/fD
         +dpFJXPjKYYpSLT9EuUVotLij06nWO9xKaunUBsXUB4xjy54GGGNOd69X/0Z1pDoHq8f
         tbA0SmT5gEqxtreHNkTNKhoOO9E+UAbb8amB+alYtzyrpFr3+1cEqC1CoaI6CFXqTyTY
         MbFN3oyL9hVi5GrWj9qh1UWQnuT0D801cMz9EfPYuxzE1q4kWF37t7iuM6F2XqBs9z3I
         wfHfXVvpEX2RUTO99Um2x+W+7zL4hdlTxkOEfx+PzvDnhy8kE+SNpgCeSMroHCM3oxi3
         Xo0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=JshZMKKSsqOKl3M686OnbSzLC5CT/c3VOU9E4R8HR1Y=;
        b=ghEuF0OIHefrxYU5oA+w7ONVs2HEQTPrNsRcA35173ggF0UOViU1jbzQ/h8O8E/tAB
         Fku4C/S0AZhV+74YDMvkQMMWSrbnzK59kxDnKQhxefTiGNdJ0EGM/j2FpGbT1F1WQqGw
         IOx0aqu7Q1HYRB6XtvdGGfJ1VwvqL87n367giteJmRJtP5VLjUALKObfqn5uAREkv5AW
         QGH6E8jzQvijlSBkzWC2HcVxz27ObTX6EiHrcWLvNACofuEZV31L3oO7vegpvCjyio0P
         ykvLNpPYrX2kBBijXu7rO4SOM/xeb1QNZuFA9mFhYi0iX0DMHegvHz94YoZbAb1zHBAN
         4jtQ==
X-Gm-Message-State: AOAM531IRlO4oNU9DWTOeCwD/SN3r5rwnco8JCmNkJmiDz2tKKaCCf8Z
        HeUoQUe5o2rvUKPe7iZjAozvVgwp1DaGHTRc0Wal
X-Google-Smtp-Source: ABdhPJwjbaX7RhPT5+MLjyT96wmJwghrvv54GbK99SVzwIPLfSC5NrRkBf5onX8yx51W/HvPa8D8RgaG4A6NdcJf4meR
X-Received: by 2002:a05:6214:178e:: with SMTP id ct14mr6144229qvb.73.1591044894469;
 Mon, 01 Jun 2020 13:54:54 -0700 (PDT)
Date:   Mon,  1 Jun 2020 13:54:52 -0700
In-Reply-To: <xmqqeer2xr0f.fsf@gitster.c.googlers.com>
Message-Id: <20200601205452.229381-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <xmqqeer2xr0f.fsf@gitster.c.googlers.com>
X-Mailer: git-send-email 2.27.0.rc2.251.g90737beb825-goog
Subject: Re: [PATCH 3/8] http-fetch: support fetching packfiles by URL
From:   Jonathan Tan <jonathantanmy@google.com>
To:     gitster@pobox.com
Cc:     jonathantanmy@google.com, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> > -	if (argc != arg + 2 - commits_on_stdin)
> > +	if (argc != arg + 2 - (commits_on_stdin || packfile))
> >  		usage(http_fetch_usage);
> >  	if (commits_on_stdin) {
> >  		commits = walker_targets_stdin(&commit_id, &write_ref);
> > +	} else if (packfile) {
> > +		/* URL will be set later */
> 
> Prefer to see an empty statement spelled more explicitly, like this:
> 
> 		; /* URL will be set later */
> 
> Otherwise reader would be left wondering if a line was (or lines
> were) accidentally lost after this comment.

OK.

> The above probably want to be a single helper function.
> 
> The other side of if/else may also become another helper function.
> 
> That way, the flow of control would become clearer.  After all,
> these two branches do not share all that much.  Only http-init and
> http-cleanup and nothing else.
> 
> For that matter, even before introducing this new mode of operation,
> another patch to make a preparatory move of the original logic in
> this function to a helper function that would be called from the
> "else" side may make it easier to see what is going on.

OK.

> > diff --git a/http.c b/http.c
> > index 130e9d6259..ac66215ee6 100644
> > --- a/http.c
> > +++ b/http.c
> > @@ -2280,15 +2280,18 @@ int finish_http_pack_request(struct http_pack_request *preq)
> >  	int tmpfile_fd;
> >  	int ret = 0;
> >  
> > -	close_pack_index(p);
> > +	if (p)
> > +		close_pack_index(p);
> >  
> >  	fclose(preq->packfile);
> >  	preq->packfile = NULL;
> >  
> > -	lst = preq->lst;
> > -	while (*lst != p)
> > -		lst = &((*lst)->next);
> > -	*lst = (*lst)->next;
> > +	if (p) {
> > +		lst = preq->lst;
> > +		while (*lst != p)
> > +			lst = &((*lst)->next);
> > +		*lst = (*lst)->next;
> > +	}
> 
> This is quite ugly.  What is the original meaning of the target
> field of the pack_request structure again?  A packed_git structure
> that will be filled when we are done fetching the packfile from the
> other side and installed in our repository?  When we are (ab)using
> http_fetch code to fetch a single packfile, we do not install the
> packfile into the running process, because we are only (re)using the
> existing machinery as a poor-man's "curl | git index-pack --stdin"?
> 
> I do not think it is a bad idea to roll "curl | git index-pack
> --stdin" our own, but I do find this an ugly way to do so.  Perhaps
> a set of lower-level helper functions can be isolated out of the
> existing code before this new feature is added, and then a new "just
> fetch and pipe it to the index-pack" feature should be written using
> these helpers but with a separate set of entry points?  Would it be
> a good way to make the resulting code cleaner than this patch does?
> I dunno.

OK - I'll extract the functions as you suggested earlier in the email,
and then it might be more obvious if it can be done more cleanly.

> > diff --git a/http.h b/http.h
> > index a5b082f3ae..709dfa4c19 100644
> > --- a/http.h
> > +++ b/http.h
> > @@ -223,12 +223,21 @@ struct http_pack_request {
> >  	struct active_request_slot *slot;
> >  
> >  	/*
> > -	 * After calling new_http_pack_request(), point lst to the head of the
> > +	 * After calling new_http_pack_request(), if fetching a pack that
> > +	 * http_get_info_packs() told us about, point lst to the head of the
> >  	 * pack list that target is in. finish_http_pack_request() will remove
> >  	 * target from lst and call install_packed_git() on target.
> >  	 */
> >  	struct packed_git **lst;
> >  
> > +	/*
> > +	 * If this is true, finish_http_pack_request() will pass "--keep" to
> > +	 * index-pack, resulting in the creation of a keep file, and will not
> > +	 * suppress its stdout (that is, the "keep\t<hash>\n" line will be
> > +	 * printed to stdout).
> > +	 */
> > +	unsigned generate_keep : 1;
> > +
> 
> I suspect that this is a sign that this single patch is trying to
> do too many things at the same time.
> 
>  - Whether we are fetching a single packfile from a URL, or walking
>    to fetch all the packfiles in the repository at a given URL
> 
>  - Whether packfiles taken from outer space are marked with the
>    "keep" bit
> 
>  - Whether the obtained packfile(s) are internally "installed"
>    to the running process
> 
> are conceptually independent choices, but somehow mixed up, it
> seems.

You might be right...I needed another mode that does the opposite
choices in these 3 points and these points because options that could be
toggled independently. I'll see if there is a better way to do this.
