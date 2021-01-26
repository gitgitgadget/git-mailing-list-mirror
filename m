Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4413BC432C3
	for <git@archiver.kernel.org>; Tue, 26 Jan 2021 22:08:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2395820665
	for <git@archiver.kernel.org>; Tue, 26 Jan 2021 22:08:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727708AbhAZWB0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Jan 2021 17:01:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391919AbhAZSWz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jan 2021 13:22:55 -0500
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E74B6C06174A
        for <git@vger.kernel.org>; Tue, 26 Jan 2021 10:22:14 -0800 (PST)
Received: by mail-pg1-x549.google.com with SMTP id z6so4999193pgg.17
        for <git@vger.kernel.org>; Tue, 26 Jan 2021 10:22:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=ysnz7fht//Rer9H3X5a6LDT4WzFOwfXlXKnOoHFRKpQ=;
        b=IjPph8ZYjCfR3d6ZMSEN3hBvePFc/1mNcvQ29s/44IE4dyJ8QkSW1gGXSVP6oGHeIY
         qrMJx+eTFUZ568djhmedyEma5mpC/2TbwGgdy43QGYxYP9qbG3/QIshc3dMrnCkRhdYH
         I2SjXjeS6kKUwPNHXBcad5o9+J+RDnfFyREFLHZOcjbIDSke67gzXKOq0bEcwhaUfySL
         UI2sdL7z1ud57eJusqNANNmoy2jvNNgu+za8vFw223xSOTPf31hq/+ExW9aSPcpB1xc7
         XkUNHrGFDk16bAOcAYWS/Nnr+xlgsKvSGpN/08Mal/4P7+EfJU/0a/QPyIDqY4uTBvou
         wlhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ysnz7fht//Rer9H3X5a6LDT4WzFOwfXlXKnOoHFRKpQ=;
        b=eoLt7kTzhT5yAf1bEQTUDuJsuuXC9ARSuauDVAd8ng1M/HjOh9X4I025Q/qwPnY0lz
         W0psuwAK5b+FMuPAi4dHKETEKr/VkZWel/VLtiKRGdBIbkKqhE86G1lR61Ykela+tVHJ
         vwLBC75J+NPFL//8QuQ7lcSIaB+nsX5m8GQJNBL5j9lHs5LJ4nv6zbE4FJwonzHf2Ngu
         iE8LJUTWrJzrFbkdimg/cy2V9LgDr1kDmSYZY/R9xJNmLAJM6z9fw4plngz6jiAk8rYK
         GKc3LZK1Wg0sPieo9uKqklWb/swTxINFVvo87nMZEzYDPMVCkzwnq+jJCyzbJdUb88yj
         fFww==
X-Gm-Message-State: AOAM5337PYs74D7k5vED4jdWhTIqPm+LBbfaV5Yzm0hrE+JZUM69ftVT
        ajR9sgzcLDnALAOMroy4kghhh7WCgCXuhex3ugJk
X-Google-Smtp-Source: ABdhPJxU397sCxED4YXxVlqltKf5JQdUBGjFKMC+xeWCn1JEfWWOhj95z4ePcXeBfrbSmuXdZRzUu8DZW/I92wNvAyQy
Sender: "jonathantanmy via sendgmr" <jonathantanmy@twelve4.c.googlers.com>
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:902:edcb:b029:df:cce5:1105 with
 SMTP id q11-20020a170902edcbb02900dfcce51105mr7268648plk.2.1611685334435;
 Tue, 26 Jan 2021 10:22:14 -0800 (PST)
Date:   Tue, 26 Jan 2021 10:22:12 -0800
In-Reply-To: <YAnr8lBESOO+ACL/@coredump.intra.peff.net>
Message-Id: <20210126182212.2337587-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <YAnr8lBESOO+ACL/@coredump.intra.peff.net>
X-Mailer: git-send-email 2.30.0.280.ga3ce27912f-goog
Subject: Re: [PATCH v4 3/3] clone: respect remote unborn HEAD
From:   Jonathan Tan <jonathantanmy@google.com>
To:     peff@peff.net
Cc:     jonathantanmy@google.com, git@vger.kernel.org, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> On Tue, Dec 22, 2020 at 01:54:20PM -0800, Jonathan Tan wrote:
> 
> > @@ -1323,10 +1325,20 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
> >  		remote_head = NULL;
> >  		option_no_checkout = 1;
> >  		if (!option_bare) {
> > -			const char *branch = git_default_branch_name();
> > -			char *ref = xstrfmt("refs/heads/%s", branch);
> > +			const char *branch;
> > +			char *ref;
> > +
> > +			if (unborn_head_target &&
> > +			    skip_prefix(unborn_head_target, "refs/heads/", &branch)) {
> > +				ref = unborn_head_target;
> > +				unborn_head_target = NULL;
> > +			} else {
> > +				branch = git_default_branch_name();
> > +				ref = xstrfmt("refs/heads/%s", branch);
> > +			}
> >  
> >  			install_branch_config(0, branch, remote_name, ref);
> > +			create_symref("HEAD", ref, "");
> >  			free(ref);
> >  		}
> 
> In the old code, we never called create_symref() at all. It makes sense
> that we'd do it now when unborn_head_target is not NULL. But what about
> in the "else" clause there? Now we're adding an extra create_symref()
> call.

The "else" branch you're referring to is the one enclosing all of the
lines quoted above, I believe?

> Who was setting up the HEAD symref before, and are we now doing it
> twice?

It was init_db(). Yes, we are now setting it once in init_db() and
setting it again, but this is the same as in the regular clone (as can
be seen by the invocation of update_head() that sets HEAD in some
situations).

> If we have a valid unborn head, then we alias it to "ref" and we set the
> original to NULL. And it gets cleaned up here via free(ref). Makes
> sense. It confused me for a moment with this hunk...
> 
> > @@ -1373,6 +1385,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
> >  	strbuf_release(&key);
> >  	junk_mode = JUNK_LEAVE_ALL;
> >  
> > +	free(unborn_head_target);
> 
> ...since this line will almost always be free(NULL) as a result (either
> there was no unborn head, or we consumed the string already). But it is
> covering the case that somebody gave us an unborn_head_target but it
> didn't start with refs/heads/. So it's useful to have.

Yes.

Thanks for your review.
