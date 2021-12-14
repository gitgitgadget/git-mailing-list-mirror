Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D365C433EF
	for <git@archiver.kernel.org>; Tue, 14 Dec 2021 20:35:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237648AbhLNUfR (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Dec 2021 15:35:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232388AbhLNUfQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Dec 2021 15:35:16 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA714C061574
        for <git@vger.kernel.org>; Tue, 14 Dec 2021 12:35:16 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id o4so18758490pfp.13
        for <git@vger.kernel.org>; Tue, 14 Dec 2021 12:35:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=nZ6C9E9850HBkWtXyZno23otU3KnCMWAAvo6qT5ZleM=;
        b=rR7QvnInpN/tzO4fd8vxCOFmSzQmsDUSljij+2sOqWfO/9l8jgiqso/6zBu6WHmHhQ
         u61viwD3P0TBU8w0D7hZvBSZDAIZes8fIZUIt0Tr5iIBXa+SDVJsUnkRj7teFqjVrxj9
         //COGqV3fNzb/jhxfe5b01F1QE11uFFQOCNHBLl6tHuucuM0+AItCNE1ImaiSPtVW6M2
         hjx+L+pVqb6JHXflHmc5jbPAMfgcVB9H61RMOGuIBlfMr89um7iPg7aXlJj6cRpFnt+L
         4NbxJ0WiQmqizF+C9HonH5rAh9+NJBiQfyBaaAxD68Gi4MDK+nsYW448XBm26ZzFx1AQ
         97aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=nZ6C9E9850HBkWtXyZno23otU3KnCMWAAvo6qT5ZleM=;
        b=YJad8OH+F3Y7MUaRs0I/AytF7XRltRPvk83FsrhIIf+cT3s88oxhKI103ObKmmagXR
         lJxaWJ7OYYWLOKseJdA1Eq7VHp2XauKBZBVzjXq8Cz6CgCc7g0lEnSrowdP78dnO4Bhj
         NRxTVGM/7ul20Chi13NS5OWPaIQ74XS8y0AQOMhM/XayJUdWIlBn64CN+xodFldRF2BZ
         bgAs230zaGuaXc29j0Z8S2aEdEuFpLA3rapdLZW7u+4K6ooGlGF2cxxg3vc/iHk2x0vx
         bppFsAmnqGKy+ErbxRxJ+qFONMPAAqVj3PXPvOJvsn6Xlje7KvBnDdDWWscZoA/mD9i6
         oC1A==
X-Gm-Message-State: AOAM532ZR7/r/4FPe5CRF5WbFdW9SlwuTsrm2Ov2TzBJDuhuNRD2/ws8
        MgBZj9MVKUNAPzFM8GLj6WVmY7X8WrZEsg==
X-Google-Smtp-Source: ABdhPJx2kAQCd/l2bE8JTG//yw0U7/HFlhnzXygyAU77QfF3usTUGddp8PiGTO5fEUTHRLefKaDp6Q==
X-Received: by 2002:a65:4c43:: with SMTP id l3mr5250388pgr.398.1639514115859;
        Tue, 14 Dec 2021 12:35:15 -0800 (PST)
Received: from google.com ([2620:15c:2ce:200:b37:fbed:ef52:5dca])
        by smtp.gmail.com with ESMTPSA id om5sm470123pjb.5.2021.12.14.12.35.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Dec 2021 12:35:15 -0800 (PST)
Date:   Tue, 14 Dec 2021 12:35:09 -0800
From:   Josh Steadmon <steadmon@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, chooglen@google.com, emilyshaffer@google.com,
        avarab@gmail.com
Subject: Re: [PATCH v5 1/2] branch: accept multiple upstream branches for
 tracking
Message-ID: <Ybj//dzRfvyuPZOv@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        chooglen@google.com, emilyshaffer@google.com, avarab@gmail.com
References: <9628d145881cb875f8e284967e10f587b9f686f9.1631126999.git.steadmon@google.com>
 <cover.1638859949.git.steadmon@google.com>
 <ba7d557725e70f2ae8f10ae5992c8168eb97f2fc.1638859949.git.steadmon@google.com>
 <xmqqk0gg6wqn.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqk0gg6wqn.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2021.12.07 11:28, Junio C Hamano wrote:
> Josh Steadmon <steadmon@google.com> writes:
> 
> > +static int install_branch_config_multiple_remotes(int flag, const char *local, const char *origin,
> > +		struct string_list *remotes)
> 
> The line got overly long so perhaps cut the line after "*local,",
> as "origin" and "remotes" conceptually are closer together.
> 
> What is in the string list?  Names of refs at the remote "origin",
> instead of a single ref there?

Added a comment explaining the purpose and arguments.


> >  {
> >  	const char *shortname = NULL;
> >  	struct strbuf key = STRBUF_INIT;
> > -	int rebasing = should_setup_rebase(origin);
> > -
> > -	if (skip_prefix(remote, "refs/heads/", &shortname)
> > -	    && !strcmp(local, shortname)
> > -	    && !origin) {
> > -		warning(_("Not setting branch %s as its own upstream."),
> > -			local);
> 
> When 'origin' is NULL in the original caller, it means a local
> tracking, and making sure we do not say "my 'master' branch builds
> on top of itself" makes sense.
> 
> > -		return 0;
> > -	}
> > +	int i, rebasing = should_setup_rebase(origin);
> > +
> > +	if (remotes->nr < 1)
> > +		BUG("must provide at least one remote for branch config");
> > +
> > +	if (!origin)
> > +		for (i = 0; i < remotes->nr; i++)
> > +			if (skip_prefix(remotes->items[i].string, "refs/heads/", &shortname)
> > +			    && !strcmp(local, shortname)) {
> > +				warning(_("Not setting branch %s as its own upstream."),
> > +					local);
> > +				return 0;
> 
> I am a bit surprised with this warning and early return before
> inspecting the remainder of the list.  When 'origin' is NULL,
> i.e. we are talking about the local building on top of another local
> branch, if the function is called for the local branch 'main' with
> 'main' in the remotes list alone, we do want to issue the warning
> and exit without doing anything (i.e. degenerating to the original
> behaviour of taking a single string variable, when a string list
> with a single element is given).  But if the remotes list has 'main'
> and 'master', would we want to just "skip" the same one, but still
> handle the other ones as if the "same" branch were not in the list?

The inheritance case when creating a new branch is the only time we get
multiple branches, and I think it is a sign of a wider misconfiguration
if we have our own branch name listed as upstream in this case.

When inheriting, `local` should always be a new branch, and `remotes`
should contain the `branch.<name>.merge` entries of the branch we're
inheriting from. For this check to trigger would mean that the parent
branch has configured a local upstream branch that doesn't actually
exist. So it seems that something has gone wrong; perhaps we can assume
what the user wanted such as in your case above, but it seems to me that
it's safer to warn when this happens.

> > @@ -75,8 +80,17 @@ int install_branch_config(int flag, const char *local, const char *origin, const
> >  
> >  	strbuf_reset(&key);
> >  	strbuf_addf(&key, "branch.%s.merge", local);
> > -	if (git_config_set_gently(key.buf, remote) < 0)
> > +	/*
> > +	 * We want to overwrite any existing config with all the branches in
> > +	 * "remotes". Override any existing config with the first branch, but if
> > +	 * more than one is provided, use CONFIG_REGEX_NONE to preserve what
> > +	 * we've written so far.
> > +	 */
> > +	if (git_config_set_gently(key.buf, remotes->items[0].string) < 0)
> >  		goto out_err;
> > +	for (i = 1; i < remotes->nr; i++)
> > +		if (git_config_set_multivar_gently(key.buf, remotes->items[i].string, CONFIG_REGEX_NONE, 0) < 0)
> > +			goto out_err;
> >  
> >  	if (rebasing) {
> >  		strbuf_reset(&key);
> > @@ -87,29 +101,62 @@ int install_branch_config(int flag, const char *local, const char *origin, const
> >  	strbuf_release(&key);
> >  
> >  	if (flag & BRANCH_CONFIG_VERBOSE) {
> > -		if (shortname) {
> > -			if (origin)
> > -				printf_ln(rebasing ?
> > -					  _("Branch '%s' set up to track remote branch '%s' from '%s' by rebasing.") :
> > -					  _("Branch '%s' set up to track remote branch '%s' from '%s'."),
> > -					  local, shortname, origin);
> > -			else
> > -				printf_ln(rebasing ?
> > -					  _("Branch '%s' set up to track local branch '%s' by rebasing.") :
> > -					  _("Branch '%s' set up to track local branch '%s'."),
> > -					  local, shortname);
> > +		int plural = remotes->nr > 1;
> > +		int all_shortnames = 1;
> > +		const char *msg_fmt;
> > +		struct strbuf ref_string = STRBUF_INIT;
> > +
> > +		for (i = 0; i < remotes->nr; i++)
> > +			if (skip_prefix(remotes->items[i].string, "refs/heads/", &shortname)) {
> > +				strbuf_addf(&ref_string, "'%s', ", shortname);
> > +			} else {
> > +				all_shortnames = 0;
> > +				strbuf_addf(&ref_string, "'%s', ", remotes->items[i].string);
> 
> So, all_shortnames == true means everything was a local branch in
> the 'origin' remote, and when it has a non-branch (like a tag),
> all_shortnames becomes false?
> 
> > +			}
> > +		/* The last two characters are an extraneous ", ", so trim those. */
> > +		strbuf_setlen(&ref_string, ref_string.len - 2);
> 
> As you are starting from an empty ref_string, a more idiomatic way
> to build concatenated string would be to prefix when you add a new
> item, e.g.
> 
> 	loop {
> 		if (ref_string already has items)
> 			ref_string.append(", ");
> 		ref_string.append(this_item);
> 	}

Ack, although changes to address other review feedback has made this
point moot.


> > +		if (all_shortnames && origin) {
> > +			if (rebasing && plural)
> > +				msg_fmt = "Branch '%s' set up to track remote branches %s from '%s' by rebasing.";
> 
> What does it mean to keep my 'topic' branch up-to-date by rebasing
> on top of more than one remote sources?  By merging, I can sort-of
> understand (i.e. creating an octopus), but would it make sense to
> track more than one remote sources in general?  Is it common?
> 
> When the benefit is not clear, it might make more sense not to do
> this when there are already multiple tracking sources defined for
> the original; it might be a mistake that we may not want to spread
> with the new option.
> 
> Of course, it is very possible that I am missing a perfectly valid
> use case where having more than one makes good sense.  If so, please
> do not take the above comments as an objection, but adding some
> comments before the function to explain when having remote list with
> more than one items makes sense and how such a setting can be used
> to avoid future readers asking the same (stupid) question as I just
> did.

No, that's an oversight on my part. This will now exit with an error if
we try to rebase onto multiple branches.


> > +			else if (rebasing && !plural)
> > +				msg_fmt = "Branch '%s' set up to track remote branch %s from '%s' by rebasing.";
> > +			else if (!rebasing && plural)
> > +				msg_fmt = "Branch '%s' set up to track remote branches %s from '%s'.";
> > +			else if (!rebasing && !plural)
> > +				msg_fmt = "Branch '%s' set up to track remote branch %s from '%s'.";
> > +
> > +			printf_ln(_(msg_fmt), local, ref_string, origin);
> 
> I am not sure how well the "plural" thing works with i18n.  It may
> suffice for the original in English to have only two choices between
> one or more-than-one, but not all languages are English.  Counting
> the actual number (I guess remotes->nr is it) and using Q_() to
> choose between the possible variants.  I think Ævar knows about this
> much better than I do.
> 
> But if we are not doing this "set multiple" and instead go the
> "detect existing multiple and refrain from spreading the damage"
> route, all of that is moot.
> 
> Thanks.

Thanks for the feedback!
