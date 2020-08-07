Return-Path: <SRS0=eX0j=BR=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C0D1C433E0
	for <git@archiver.kernel.org>; Fri,  7 Aug 2020 21:10:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6858C22CAF
	for <git@archiver.kernel.org>; Fri,  7 Aug 2020 21:10:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="H7MhIQfj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726481AbgHGVKr (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Aug 2020 17:10:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbgHGVKq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Aug 2020 17:10:46 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C8F0C061756
        for <git@vger.kernel.org>; Fri,  7 Aug 2020 14:10:46 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id a14so4268361ybm.13
        for <git@vger.kernel.org>; Fri, 07 Aug 2020 14:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=sGp/gXAUeeZD06/AE2rUBaCd71Uz3ulOGgNnjxRv258=;
        b=H7MhIQfj32OdlNunNZ6HkhdnxKaKZQ2BRJMAmyug7ypeMoZwbRcqULfRwSCAuzrWDZ
         YBDBwDSo1f0+QHrXKJFTIdsY9KFH7ZzNfJA2DpQAId39PzqMim+Ysc5ldMVBNwPINSL0
         +05QoZ+XPjCo5pV0S772uJxEYsOwwjS9jsakKYGuellwpPHN3m/B87hQcoT28PdvjEN+
         m1glVgukr57J2omXlFt0nUys2m751eReMdYGQukSW8t/ee8ITuneDqBDIoLAKjVE5+TS
         lYHekDW9jFh3vffSQCsH8bcVnhZ83auAL2YqM6p3neAGMaZIkHxiwnzDJ3FWpJ2amBZQ
         jodw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=sGp/gXAUeeZD06/AE2rUBaCd71Uz3ulOGgNnjxRv258=;
        b=Z5HV/npiQLT9F0ZA/Fu3cZ0cXMeyB1+B+VuaDH5jbFESFglw7rpYv8hv3VQez1ZM5/
         KigJ6pfQxEa0pdr5qTEpIqnTbvkO/bNHvJ+aX3531vKBaLMtmKqCmi0rR4m0gZpy/dCU
         BiF+9MvPThUQB9X8kdYwrxW94adTqPVUx5uteKfPKnbi3gNpKune9rAt6CZjRjugV6eu
         Ay1iinUYYG0iTfSZ8jilNUUtkYjRfpER9RMwkfxhm7oQh+d1nWaDgiOyb66lon9IiaGL
         4+ol59aINZtA4bPY4mZbFE4dDJ+TOEcVs4yW5hlrGCpIXt9rdWJ8iZKeMbewcQDVKQdB
         3eOw==
X-Gm-Message-State: AOAM531fuNoy25aH2RxwL2GjJ/zdnH+5tpb96M7rgWGpDTId5000VGVK
        M8jCLFR1S0vyqpaz5+jwy+ST5YnH9ZNs2ZdH/zpx
X-Google-Smtp-Source: ABdhPJzb3SkPEn4lnwE6G73T+D0uOhBXPMG1z5AxewOmxVXoDLmnqFe25aBSRp2o3L2fcunyc7t8Cj6pY67GtfOudqDL
X-Received: by 2002:a05:6902:1009:: with SMTP id w9mr22691773ybt.30.1596834645590;
 Fri, 07 Aug 2020 14:10:45 -0700 (PDT)
Date:   Fri,  7 Aug 2020 14:10:43 -0700
In-Reply-To: <xmqqft90omsw.fsf@gitster.c.googlers.com>
Message-Id: <20200807211043.2738308-1-jonathantanmy@google.com>
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
