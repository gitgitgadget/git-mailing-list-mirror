Return-Path: <SRS0=5dtp=C4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E75CDC43464
	for <git@archiver.kernel.org>; Sat, 19 Sep 2020 17:01:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 946D12075E
	for <git@archiver.kernel.org>; Sat, 19 Sep 2020 17:01:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AAnZAn3J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbgISRBX (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 19 Sep 2020 13:01:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726434AbgISRBX (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Sep 2020 13:01:23 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5910AC0613CE
        for <git@vger.kernel.org>; Sat, 19 Sep 2020 10:01:23 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id u9so4653006plk.4
        for <git@vger.kernel.org>; Sat, 19 Sep 2020 10:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=yhQ/11j5tSfboTkEHEwmOzQGadJWpLCGHcWMexYDYeY=;
        b=AAnZAn3J6ul34DBmxN36slD+jqthgI8BR1lautZjXMMdzNghhCvo0FToQ+VjF7s2Lr
         wZKl2S6tD1j64ir9SYx0AVoif7fGL7zlgQB2QUzvH52dWDVx9uUlR8JpLDjiTvVXv7Is
         /LWMPEg9pmxH5Ie0/ZdgVUORatvyAfkkSYiKh6wQFMlDnqVmRVlrHju2UAX476Vkdwrv
         PobHANbGbEB88a/zboLrSGDDfRYtiIqi0NZ+25qx4eb+D3xu944g0T1pdA7W3ZSZT35C
         dYdsFNpP32T+Ngm2KqRThSmnT/RKbuxhB7PZWhsVoAVJqk9SFBTONirSWuE4VNjLjtpD
         tSpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yhQ/11j5tSfboTkEHEwmOzQGadJWpLCGHcWMexYDYeY=;
        b=p+W8rKA9UtPoW7H/L6JJNRr6lDU/Vg79BoJDrAAQWF/mbJai5DVWqyUR90fgOWEj5C
         c3ZACv/aMAeyYBgVU3+aVha8HEq7fP11QmwPONx8u22D7hE0HTIrDIwdY1SLpESk9qcZ
         8+lfYA3KrsvvKuE9HNzqe4XSGv9p2bFf2RdIb3bSDB81MFjmoF9IzyTQPNQquqgwX8CV
         lfsCI5xutQnu5soNvnCPkjT6Dd3DvxyuCGMqgt+UR+Jz9zkHXVuJsFbToiUsg0NIZ+V5
         ejTWlIr4UXvhRnCxWBa0dJ1vt+gcmsLF+ySh91+l/6/eLeHwHAiKrvwMqBHEnMGsUI3E
         VNdA==
X-Gm-Message-State: AOAM532XEDM39aaUg6d9NHRI79qONyZqvv4jrlrl/SaR6ErlzZvnjk1Z
        6mIH0JbsA27YtL+tMXQYGn8=
X-Google-Smtp-Source: ABdhPJxUXo/MGPHISLNMUjMzJCyHMjUhfq38tI1vJuU/srG/HAh5x0oQrY6xpMby0bm8fD3D+CYo7g==
X-Received: by 2002:a17:90a:760f:: with SMTP id s15mr17897166pjk.214.1600534882527;
        Sat, 19 Sep 2020 10:01:22 -0700 (PDT)
Received: from mail.clickyotomy.dev ([104.200.132.172])
        by smtp.gmail.com with ESMTPSA id u71sm7508524pfc.43.2020.09.19.10.01.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2020 10:01:21 -0700 (PDT)
Date:   Sat, 19 Sep 2020 22:31:14 +0530
From:   Srinidhi Kaushik <shrinidhi.kaushik@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3 1/7] remote: add reflog check for "force-if-includes"
Message-ID: <20200919170114.GA81372@mail.clickyotomy.dev>
References: <20200912150459.8282-1-shrinidhi.kaushik@gmail.com>
 <20200913145413.18351-1-shrinidhi.kaushik@gmail.com>
 <20200913145413.18351-2-shrinidhi.kaushik@gmail.com>
 <nycvar.QRO.7.76.6.2009161356560.56@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.2009161356560.56@tvgsbejvaqbjf.bet>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Johannes,

On 09/16/2020 14:35, Johannes Schindelin wrote:

> > [...]
> > +		struct commit *loc = lookup_commit_reference(the_repository,
> > +							     n_oid);
> > +		struct commit *rem = lookup_commit_reference(the_repository,
> > +							     r_oid);
> > +		ret = (loc && rem) ? in_merge_bases(rem, loc) : 0;
> > +	}
> 
> This chooses the strategy of iterating over the reflog just once, and at
> every step first testing whether the respective reflog entry is identical
> to the remote-tracking branch tip. Only when they are different do we test
> whether the remote-tracking branch tip is at least reachable from the
> reflog entry.
> 
> Let's assume that our local branch has 20 reflog entries, and the 4th one
> is identical to the current tip of the remote-tracking branch. Then we
> tested reachability 3 times. But that test is rather expensive.
> 
> Therefore, I would have preferred to have a call to
> `for_each_reflog_ent_reverse()` with a callback function that only returns
> the `oideq()` result, and only if the return value of that call is 0, I
> would have wanted to see another call to `for_each_reflog_ent_reverse()`
> to go through, this time looking for reachability.

OK, you're right about this. Will update check to use the two-step
approach.

> > [...] 
> > +	int ret = 0;
> > +	struct commit *r_commit, *l_commit;
> > +
> > +	l_commit = lookup_commit_reference(the_repository, l_oid);
> > +	r_commit = lookup_commit_reference(the_repository, r_oid);
> 
> At this point, we already LOOked up `r_commit`. But we don't pass that to
> `ref_reachable()` at any point (instead passing only `r_oid`), so we have
> to perform the lookup again.
> 
> That's wasteful. Shouldn't we pass `r_commit` directly?

Hmm, I suppose we can. Not sure why I did that in the first place. 

> With the two-pass strategy I outlined above, the first pass would use
> `r_oid`, and only when the second pass is necessary would we resort to
> calling the expensive reachability check.
> 
> > +
> > +	/*
> > +	 * If the remote-tracking ref is an ancestor of the local
> > +	 * ref (a merge, for instance) there is no need to iterate
> > +	 * through the reflog entries to ensure reachability; it
> > +	 * can be skipped to return early instead.
> > +	 */
> > +	ret = (r_commit && l_commit) ? in_merge_bases(r_commit, l_commit) : 0;
> 
> Correct me if I am wrong, but isn't the first reflog entry
> (`<remote-branch>@{0}`) identical to `r_commit`? In that case, the first
> iteration of the second pass over the reflog would trivially perform this
> check, and we do not need to duplicate the logic here.

That's a correct assumption; the second pass will check for this.

> > +	if (!ret)
> > +		ret = for_each_reflog_ent_reverse(local_ref_name, ref_reachable,
> > +						  (struct object_id *)r_oid);
> > +
> > +	return ret;
> > +}
> > +
> > +/*
> > + * Check for reachability of a remote-tracking
> > + * ref in the reflog entries of its local ref.
> > + */
> > +void check_reflog_for_ref(struct ref *r_ref)
> > +{
> > +	struct object_id r_oid;
> > +	struct ref *l_ref = get_local_ref(r_ref->name);
> > +
> > +	if (r_ref->if_includes && l_ref && !read_ref(l_ref->name, &r_oid))
> 
> If `r_ref->if_includes` is 0, we do not even have to get the local ref,
> correct? It would make `check_reflog_for_ref()` much easier to read for me
> if it was only called when that flag was already verified to be 1, and
> then followed this structure:
> 
> 	if (!l_ref)
> 		return;
> 	if (read_ref(...))
> 		warning(_("ignoring stale remote branch information ..."));
> 	else
> 		r_ref->unreachable = ...
> 
> Also, it might make a lot more sense to rename `check_reflog_for_ref()` to
> `check_if_includes_upstream()`, and to rename `r_ref` to `local` and
> `l_ref` to `remote_tracking` or something like that: nothing is inherently
> "left" or "right" about those refs.

Now that I think about it, we don't need te call to "read_ref()" at all
because the reflog will have the OID we need for checking. As to
"{l,r}_ref", they were meant to be [l]ocal and [r]emote. :)

> > +		r_ref->unreachable = !ref_reachable_from_reflog(&r_ref->old_oid,
> > +								&r_oid,
> > +								l_ref->name);
> > +}
> > +
> >  static void apply_cas(struct push_cas_option *cas,
> >  		      struct remote *remote,
> >  		      struct ref *ref)
> >  {
> > -	int i;
> > +	int i, is_tracking = 0;
> >
> >  	/* Find an explicit --<option>=<name>[:<value>] entry */
> >  	for (i = 0; i < cas->nr; i++) {
> > @@ -2288,16 +2381,26 @@ static void apply_cas(struct push_cas_option *cas,
> >  			oidcpy(&ref->old_oid_expect, &entry->expect);
> >  		else if (remote_tracking(remote, ref->name, &ref->old_oid_expect))
> >  			oidclr(&ref->old_oid_expect);
> > -		return;
> > +		else
> > +			is_tracking = 1;
> 
> As part of `remote_tracking()`, we already looked up the branch name.
> Since we need it in the `is_tracking` case, maybe this should not be a
> Boolean anymore but store a copy of the remote-tracking branch name
> instead?
> 
> Oh, following the code path all the way down to
> `match_name_with_pattern()`, it seems that `remote_tracking()`'s `dst`
> variable _already_ contains a copy (which means that that memory is
> leaked, right?).

I'm not sure I understand what you mean. The call to "remote_tracking()"
gets the OID of the remote ref and writes it to "old_oid_expect".
We don't need "dst" from there because "old_oid" is sufficient for
checking the reflog entries. However, calling "get_local_ref()" is
necessary to get the local branch name. Also, why does "is_tracking"
have to be a Boolean? We already have "ref->name", right?

Anyway, I think we can get rid of "is_tracking" altogether and just use
"if_includes".

> > [...] 
> > +/*
> > + * Runs when "--force-if-includes" is specified.
> > + * Checks if the remote-tracking ref was updated (since checkout)
> > + * implicitly in the background and verify that changes from the
> > + * updated tip have been integrated locally, before pushing.
> > + */
> > +void apply_push_force_if_includes(struct ref*, int);
> 
> This function is not even hooked up in this patch, right? I don't think
> that it makes sense to introduce it without a caller, in particular since
> it makes it harder to guess what those parameters might be used for.
> 
> In general, it appears to me as if the code worked way too hard to
> accomplish something that should be a lot simpler: when
> `--force-if-includes` is passed, it should piggy-back on top of the
> `--force-with-lease` code path, and just add yet another check on top.

Well, it isn't included in this commit, because it was called from
"transport.c" and "send-pack.c", I decided to put that in another
commit. I will fix that in the next patch series.

> With that in mind, I would have expected something more in line with this:
> 
> -- snip --
>  struct push_cas_option {
>  	unsigned use_tracking_for_rest:1;
>  	struct push_cas {
>  		struct object_id expect;
> -		unsigned use_tracking:1;
> +		enum {
> +			PUSH_NO_CAS = 0,
> +			PUSH_CAS_USE_TRACKING,
> +			PUSH_CAS_IF_INCLUDED
> +		} mode;
>  		char *refname;
>  	} *entry;
>  	int nr;
>  	int alloc;
>  };
> -- snap --
> 
> and then adjusting the respective code paths accordingly.

OK, I will clean it up and get rid of the redundant/wasteful
calls and data being passed around. Regarding the new "enum",
I feel that just having a new bit-field "use_force_if_includes"
might be sufficient for "push_cas_option". The idea is to set it
to "1" when "--force-if-includes" is specified along with
"--force-with-lease", and "apply_push_cas()" will run the check
and set "ref->unreachable" depending on the check status.
To clarify, you would have to specify something like this to
enable the check:

   git push --force-if-includes --force-with-lease=master [...]

Then, having a configuration setting "push.useForceIfIncludes" would
be the same as running "git-push" like mentioned above. This new option
will be a "no-op" if specified otherwise. Would that be acceptable?

Thanks again, for a thorough review. 
-- 
Srinidhi Kaushik
