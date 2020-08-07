Return-Path: <SRS0=eX0j=BR=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53706C433DF
	for <git@archiver.kernel.org>; Fri,  7 Aug 2020 21:10:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C93322CA1
	for <git@archiver.kernel.org>; Fri,  7 Aug 2020 21:10:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LGtSbgr9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726542AbgHGVKc (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Aug 2020 17:10:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbgHGVKc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Aug 2020 17:10:32 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C598C061756
        for <git@vger.kernel.org>; Fri,  7 Aug 2020 14:10:32 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id s60so7849607pjc.1
        for <git@vger.kernel.org>; Fri, 07 Aug 2020 14:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=sGp/gXAUeeZD06/AE2rUBaCd71Uz3ulOGgNnjxRv258=;
        b=LGtSbgr94zBUYXwuHaT2dzhsrPLGt6SSafp6t2cwEqG5fndVqzxPSgoQf27JUQ9ez+
         dSNIn1cU8kS8IyLzfqnic61ksoy93pC1FTvUv2uInQPGyTTfLqGNivMW3+UttvXAp6+h
         HbNCzal4nVJt9IRpsFan6NxQ4elF3UZML5I3ja4IV+z2wJ/4jh/y+CK/wgp/b7LcQI/H
         tMmk3ZNnwHWLatpPgg+yj+LexGYhvsm6tyRmJ+3bXATyox9jG/1Rnodon0ucOzHOSA4i
         7xlrgRI+qLbTX2+29dhYUIADK1HUtZzCrRV64Cq23Hqhr9FS7T6Tbv7KNKtQCb0bUrVV
         wVMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=sGp/gXAUeeZD06/AE2rUBaCd71Uz3ulOGgNnjxRv258=;
        b=c/XCdaq2F1m59vAdWUUIOIgMMXSPJ+NTGVhpnXv0BijAIS8yNTOai0ngb5qKUsQd9v
         kMUq4S6wso8aAkpHJi7Wf9dMHW2YTpYAXKl8jIRm/uXvsNl4Ma3y/ZY89bG9AovjIqOK
         j9smqWIQu75lU5brtn3CcvpVEgdS/5Ovm+iH6ghgjGqltwkxot5lzJFNPFbSHmIQmZ3q
         akQFOQwcUz2Vu91Pf5JCHoU+3gIyGylQZm9Z/ZbtcSlP7r9cfedrdcoPC+VMfymtyA7O
         aVbgE6E5zBVFf0w2zIOAzQhOR3Fw5YyZIEeS2vVobgswsIWQoACj01pj2SxVPSJvTHk+
         3kVQ==
X-Gm-Message-State: AOAM530sQjLQp5Fn0tlJ7zXCHMrnysDeYmjrZRPX8UX3k8dYh++TX3ZZ
        6bZibpTt597lrZnAN35lhxvBOzkRtM1t8avO5tjc
X-Google-Smtp-Source: ABdhPJy/30IWs+1HN9bvAv8/F8g9gRl5gFQtO9N+Ar/wGURz3YMNV5br9bqYiE1b9TJxpKs+oOjtKwVsH+ltIztURtL+
X-Received: by 2002:a17:90b:4385:: with SMTP id in5mr14036031pjb.16.1596834631141;
 Fri, 07 Aug 2020 14:10:31 -0700 (PDT)
Date:   Fri,  7 Aug 2020 14:10:28 -0700
In-Reply-To: <xmqqft90omsw.fsf@gitster.c.googlers.com>
Message-Id: <20200807211028.2736644-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <xmqqft90omsw.fsf@gitster.c.googlers.com>
X-Mailer: git-send-email 2.28.0.236.gb10cc79966-goog
Subject: Re: [RFC PATCH 4/7] fetch: --stdin
From:   Jonathan Tan <jonathantanmy@google.com>
To:     gitster@pobox.com
Cc:     jonathantanmy@google.com, git@vger.kernel.org, peff@peff.net
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> > @@ -1741,6 +1745,13 @@ static int fetch_one(struct remote *remote, int argc, const char **argv, int pru
> >  		}
> >  	}
> >  
> > +	if (use_stdin_refspecs) {
> > +		struct strbuf line = STRBUF_INIT;
> > +		while (strbuf_getline_lf(&line, stdin) != EOF)
> > +			refspec_append(&rs, line.buf);
> > +		strbuf_release(&line);
> > +	}
> 
> This will use refspecs both from the command line and the standard
> input by appending?  IOW, these refspecs that came from the standard
> input are treated otherwise identically to those that came from the
> command line?
> 
> I do not particularly care whether it is "append to command line" or
> "replace command line", as I do not think it makes much difference
> in usability.  Just wanted to be sure you coded the behaviour you
> wanted.

Yes, except that I didn't plan to support the "tag foo" format. (My aim
with this is just to allow "git fetch" to take large numbers of
refspecs, because when we lazy fetch, the number of objects we fetch
might be large.)

> > @@ -1849,6 +1860,10 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
> >  			die(_("--filter can only be used with the remote "
> >  			      "configured in extensions.partialclone"));
> >  
> > +		if (stdin_refspecs)
> > +			die(_("--stdin can only be used when fetching "
> > +			      "from one remote"));
> 
> Is that only because you happened to have implemented the reading in
> fetch_one() that is designed to be called once per remote?  
> 
> You could read them here to a refspec for everybody, and then pass a
> pointer to that refspec as the extra parameter to fetch_one(), and
> fetch_one() can use that by duplicating and appending to its "rs",
> if we wanted to, no?  I do not know how important to support such a
> use case, though.  It just feels a bit of shame if this restriction
> is purely imposed by the implementation, when lifting the refstiction
> does not seem too involved.

Yes, and I only implemented the reading in fetch_one() because
fetch_multiple() does not read additional refspecs from the command-line
(it does not take "argv"). Looking at the code, this seems to be on
purpose - there is the error message "fetch --all does not make sense
with refspecs", and when --multiple is set, all args are assumed to be
remotes.
