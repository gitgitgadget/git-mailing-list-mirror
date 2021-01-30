Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29DE6C433DB
	for <git@archiver.kernel.org>; Sat, 30 Jan 2021 09:07:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E344264DE2
	for <git@archiver.kernel.org>; Sat, 30 Jan 2021 09:07:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232630AbhA3JHI (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 30 Jan 2021 04:07:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233721AbhA3E2P (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Jan 2021 23:28:15 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA10CC0613D6
        for <git@vger.kernel.org>; Fri, 29 Jan 2021 20:27:33 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id z2so5040870pln.18
        for <git@vger.kernel.org>; Fri, 29 Jan 2021 20:27:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=O0l736f921CwH9fPnkHUnwfmnklLc1ooFwqLw+0ZyS0=;
        b=Y7oim5vdH/ZOfFAgN/J1vlKBEeGxFUjDx0gBCtMbuSoBmWphaDpw4DxP8VA/ItJHzn
         sJOwtedVnR6KIuDPJAc5fc6Zwp4WuJ47gawadmfzkLzjUDa+6kOZ503H1090tFzgVVfB
         IJrG8Ak1Aphd+sW/rVO6JyoMDtfgOigDzCrl1weyXJiptufLv3GMZmQ7d1Y7wu3aB/sk
         5V/bqR67zpaCOq1wMLn3Hs4u+qySNFey0o/y7F0D1CWT0weXSY+Q4Lp4sm6b2QLy9Dnd
         1e/cq0K3b1hAzHk4GHOFMSPv52L3YZ/WjGKjQ8Rws4Tp1GQ/SLOnLODlzYAMXduVLBFs
         zq6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=O0l736f921CwH9fPnkHUnwfmnklLc1ooFwqLw+0ZyS0=;
        b=mbajdHQIobFMCsE4ABN2c+gcrbGTr/m04OCNizEPKNj9K/qPi19OhFdfXjPqYTJQnz
         1nbmCfteA+mEud+IdZa8f9Y2umH0UlU8ahKxm6S8Ly/uFTmzavoVKzLb0meNS/hX74ff
         hcGF6erhmmUNtBuaGUTKsJnJMVrdoMFI3ovIT6DGGKf2iJ1Qm1iAYXuHmzZ+ARM1YjYs
         EcWiHDIgHqiHH8mLIY3EoMwvXHSSdmmebedz26FjF+eGJCcJOJbpgL2CHxXxSyzIXy2J
         slgO70q9IaDhg1mN6teyKWhTTUJ2TUevJEDcOsp6gnfsRua9nfcYLAy0VZjSpNjpjJkw
         zvsw==
X-Gm-Message-State: AOAM5301+lDkJlHikXxYX+i++CbLIJsLVr3u8j6ogmJSBHxEx8eZ/QW4
        XjH0/+MRIeDn6PIipLQmmMlOVmcAPZlKT5cnLMCN
X-Google-Smtp-Source: ABdhPJy8ubDGXy2h2uWX0m3HtsvrblfX38QjMfhsesafp/lGYld7SP1ak80Y/emW3wYCQNaEnug9U/gGclDQJidcs1X/
Sender: "jonathantanmy via sendgmr" <jonathantanmy@twelve4.c.googlers.com>
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:90b:1297:: with SMTP id
 fw23mr7423776pjb.219.1611980853162; Fri, 29 Jan 2021 20:27:33 -0800 (PST)
Date:   Fri, 29 Jan 2021 20:27:31 -0800
In-Reply-To: <xmqqzh0vz69k.fsf@gitster.c.googlers.com>
Message-Id: <20210130042731.804454-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <xmqqzh0vz69k.fsf@gitster.c.googlers.com>
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
Subject: Re: [PATCH v5 3/3] clone: respect remote unborn HEAD
From:   Jonathan Tan <jonathantanmy@google.com>
To:     gitster@pobox.com
Cc:     jonathantanmy@google.com, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Jonathan Tan <jonathantanmy@google.com> writes:
> 
> >  init.defaultBranch::
> >  	Allows overriding the default branch name e.g. when initializing
> > -	a new repository or when cloning an empty repository.
> > +	a new repository.
> 
> Looking good.
> 
> > diff --git a/builtin/clone.c b/builtin/clone.c
> > index 211d4f54b0..77fdc61f4d 100644
> > --- a/builtin/clone.c
> > +++ b/builtin/clone.c
> > @@ -1330,10 +1330,21 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
> >  		remote_head = NULL;
> >  		option_no_checkout = 1;
> >  		if (!option_bare) {
> > -			const char *branch = git_default_branch_name();
> > -			char *ref = xstrfmt("refs/heads/%s", branch);
> > +			const char *branch;
> > +			char *ref;
> > +
> > +			if (transport_ls_refs_options.unborn_head_target &&
> > +			    skip_prefix(transport_ls_refs_options.unborn_head_target,
> > +					"refs/heads/", &branch)) {
> > +				ref = transport_ls_refs_options.unborn_head_target;
> > +				transport_ls_refs_options.unborn_head_target = NULL;
> > +			} else {
> > +				branch = git_default_branch_name();
> > +				ref = xstrfmt("refs/heads/%s", branch);
> > +			}
> >  
> >  			install_branch_config(0, branch, remote_name, ref);
> > +			create_symref("HEAD", ref, "");
> >  			free(ref);
> 
> OK, we used to say "point our HEAD always to the local default
> name", and the code is still there in the else clause.  But when the
> transport found what name the other side uses, we use that name
> instead.
> 
> I presume that clearing transport_ls_ref_options.unborn_head_target
> is to take ownership of this piece of memory ourselves?

Yes - just to be consistent with the other branch where "ref" needs to
be freed.

> We didn't call create_symref() in the original code, but now we do.
> Is this a valid bugfix even if we did not have this "learn remote
> symref even for unborn HEAD" feature?  Or is the original codepath
> now somehow got broken with an extra create_symref() that we used
> not to do, but now we do?

Ah...now I think I see what you and Peff [1] were saying. Yes I think
the symref creation is not necessary when we use the default branch name
(like we currently do). I'll verify and write back with my findings in
the next version.

[1] https://lore.kernel.org/git/YBCf8SI3fK+rDyox@coredump.intra.peff.net/

> 
> > @@ -1385,5 +1396,6 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
> >  	junk_mode = JUNK_LEAVE_ALL;
> >  
> >  	strvec_clear(&transport_ls_refs_options.ref_prefixes);
> > +	free(transport_ls_refs_options.unborn_head_target);
> >  	return err;
> >  }
> > diff --git a/connect.c b/connect.c
> > index 328c279250..879669df93 100644
> > --- a/connect.c
> > +++ b/connect.c
> > @@ -376,7 +376,8 @@ struct ref **get_remote_heads(struct packet_reader *reader,
> >  }
> >  
> >  /* Returns 1 when a valid ref has been added to `list`, 0 otherwise */
> > -static int process_ref_v2(struct packet_reader *reader, struct ref ***list)
> > +static int process_ref_v2(struct packet_reader *reader, struct ref ***list,
> > +			  char **unborn_head_target)
> >  {
> >  	int ret = 1;
> >  	int i = 0;
> > @@ -397,6 +398,25 @@ static int process_ref_v2(struct packet_reader *reader, struct ref ***list)
> >  		goto out;
> >  	}
> >  
> > +	if (!strcmp("unborn", line_sections.items[i].string)) {
> > +		i++;
> > +		if (unborn_head_target &&
> > +		    !strcmp("HEAD", line_sections.items[i++].string)) {
> > +			/*
> > +			 * Look for the symref target (if any). If found,
> > +			 * return it to the caller.
> > +			 */
> > +			for (; i < line_sections.nr; i++) {
> > +				const char *arg = line_sections.items[i].string;
> > +
> > +				if (skip_prefix(arg, "symref-target:", &arg)) {
> > +					*unborn_head_target = xstrdup(arg);
> > +					break;
> > +				}
> > +			}
> > +		}
> > +		goto out;
> > +	}
> 
> We split the line and notice that the first token is "unborn"; if
> the caller is not interested in the unborn head, we just skip the
> rest, but otherwise, if it is about HEAD (i.e. we do not care if a
> dangling symref that is not HEAD is reported), we notice the target
> in unborn_head_target.
> 
> OK.  We already saw how this is used in cmd_clone().
> 
> > @@ -461,6 +481,8 @@ struct ref **get_remote_refs(int fd_out, struct packet_reader *reader,
> >  	const char *hash_name;
> >  	struct strvec *ref_prefixes = transport_options ?
> >  		&transport_options->ref_prefixes : NULL;
> > +	char **unborn_head_target = transport_options ?
> > +		&transport_options->unborn_head_target : NULL;
> 
> So any caller that passes transport_options will get the unborn head
> information for free?  The other callers are in fetch-pack.c and
> transport.c, which presumably are about fetching and not cloning.
> 
> I recall discussions on filling a missing refs/remotes/X/HEAD when
> we fetch from X and learn where X points at.  Such an extension can
> be done on top of this mechanism to pass transport_options from the
> fetch codepath, I presume?

I don't recall those discussions, but I think that we can do that (as
long as HEAD points to a branch that is part of the refspec we're
fetching, because the ref-prefix check still applies).

> Thanks.  I tried to follow the thought in the patches aloud, and it
> was mostly a pleasant read.

Thanks.
