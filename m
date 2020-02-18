Return-Path: <SRS0=PlGQ=4G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6413EC34031
	for <git@archiver.kernel.org>; Tue, 18 Feb 2020 23:46:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EA392173E
	for <git@archiver.kernel.org>; Tue, 18 Feb 2020 23:46:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DBYFuoyk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726749AbgBRXqf (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Feb 2020 18:46:35 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:52814 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726641AbgBRXqf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Feb 2020 18:46:35 -0500
Received: by mail-pj1-f65.google.com with SMTP id ep11so1745165pjb.2
        for <git@vger.kernel.org>; Tue, 18 Feb 2020 15:46:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+pjUrXg3IqzA5zVD5kqNggEn07pEF0p4gIBBsGpawWQ=;
        b=DBYFuoykO1fzX2sED137H9FEBj5a2UvFufvXwvWFOpJQ1IGoZSkJW572qb9uuGeuZx
         zcwMmInyqxBc/aJ28pgfi/tGQ31+7HY0dJrgzgnyQ2dPhuNKPOtLRJZmz91juNhJj6nQ
         pOOSAyUSrp+aGdnZnbYWF7A2vTGzmBEsPZTN3ygX7f9+0Mgil7mPRNFWL9GflVKbdZLV
         Z9r2tT5UYAwgs+sgJ9/1jrGcwCFY2NwSwBwBlXUFzK9FyOHC4CHOX6h6O3+QIpkRQsjg
         RkH9Jqq9vtIT0GAKxo1inAOcnnlUjWY6DUMOruXr7ndkwHeshEbO9EAvg6Z2eQsxoERl
         WSxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+pjUrXg3IqzA5zVD5kqNggEn07pEF0p4gIBBsGpawWQ=;
        b=Ql8LRJF9JGiFPNKgiY805AbUJaN5pHYemIcG6YraxBFNIoCY/6z50r7xDPiXRH0Irx
         SWP1uX1ZPO3WzHMsBqN+VdkM6vpCCnqdkM019CTo9YWsd2UMIbAOd+YIsNemDLuQ/Ey7
         Al5FpFxz3jHloIgBSLHEsc4x26XxIXDPKGSpXVbTXRtVpErP6U+ywqfq9WVA5FjkpQEy
         7VlDrZWfG9vtEL9MnTXs+dwa3vZF/IYNXNcXwfk72+M1YyAzf/5s2SgAFXt8xQYWkLns
         X9d5prTn54izYYGGI3NCXYoXa/yvFnkgwVxqh+59K/x6qMe1BZG0Pd++IPjRE5cEkG0N
         5CIA==
X-Gm-Message-State: APjAAAVX9dh7rTLoDdlpTrf+tB0Jy9wIC0LpA/l3arOoX4XT7ncSvtI0
        XTBl5lQbmucYWN29FDOjePgOz9dGKm8=
X-Google-Smtp-Source: APXvYqzvJ70i4GSFdYEAKjkuNasNOLPB/0BG7rfVkZ7yLFhi2ZlFlQgvq/C1r0zR0tLPSUaT0D2yVQ==
X-Received: by 2002:a17:90a:c78f:: with SMTP id gn15mr5591813pjb.64.1582069594142;
        Tue, 18 Feb 2020 15:46:34 -0800 (PST)
Received: from google.com ([2620:15c:2ce:0:231c:11cc:aa0a:6dc5])
        by smtp.gmail.com with ESMTPSA id m12sm55482pjf.25.2020.02.18.15.46.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2020 15:46:33 -0800 (PST)
Date:   Tue, 18 Feb 2020 15:46:28 -0800
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v7 03/15] bugreport: add tool to generate debugging info
Message-ID: <20200218234628.GA1461@google.com>
References: <20200214015343.201946-1-emilyshaffer@google.com>
 <20200214015343.201946-4-emilyshaffer@google.com>
 <xmqqzhdlnksn.fsf@gitster-ct.c.googlers.com>
 <20200215015729.GN190927@google.com>
 <xmqq1rqvogif.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq1rqvogif.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Feb 15, 2020 at 10:24:40AM -0800, Junio C Hamano wrote:
> Emily Shaffer <emilyshaffer@google.com> writes:
> 
> > On Fri, Feb 14, 2020 at 09:25:12AM -0800, Junio C Hamano wrote:
> >> Emily Shaffer <emilyshaffer@google.com> writes:
> >> 
> >> > +	switch (safe_create_leading_directories(report_path.buf)) {
> >> 
> >> This helper is about creating paths in the working tree and Git
> >> repository,
> >
> > It's also used by cmd_format_patch() with --output-directory specified,
> > which is how I found it.
> 
> And that is an example of a good use of this helper.  What will be
> written out there should be visible by the same people as those who
> have access to the repository; get_shared_repo() and adjust_perm()
> based on what the repository you are taking patches from is
> perfectly sensible.  And as it is format-patch, we know we have
> get_shared_repo() working, and we know which repository we are
> working on.
> 
> Output directory for bugreport is on the same boat when we know the
> users are producing a report on their use of Git within a
> repository.  It is not clear if the tool is started without any
> repository---it happens to do a random safe thing (i.e. I think
> get_shared_repo() gives PERM_UMASK, which tells adjust_perm() not to
> do anything especial) right now, but there is no guarantee that we
> will keep it working like that.  Somebody may come and demaind
> get_shared_perm() to die() when outside a repository, for example,
> and that would break the nice property that lets bugreport working
> outside a repository.

Hm, this would break the convention of the name of
safe_create_leading_directories() too though right? As I understood it,
"safe_foo" in this codebase means "this function will not die()"?

> 
> I just wanted to make sure that somebody will be keeping an eye to
> remind those who propose such a change in the future.  A comment
> near where get_shared_repo() happens may be something that can be
> done with a minimum effort when code that depends on that property
> is introduced at the same time.

Ok. I want to make sure I understand you right. I think you're saying,
"This is OK, except if someone changes get_shared_repo() it could break,
so we need a way to warn someone that it could break." It sounds like
you suggested leaving a comment in the
safe_create_leading_directories() helper. My own preference is to write
a test so that it's explicit that we depend on that behavior, instead -
it's easy to gloss over a comment or read a different part of the
codebase, but it's hard to ignore a breaking test. It'd be trivial to
add one, so I will in v8 - unless I misunderstood you.

> 
> >> I thought I read somewhere that this tool is meant to be usable
> >> outside a repository?  If that is not the case, then the use of this
> >> helper is OK.  If not, we may want to make sure that it will stay to
> >> be safe to use the helper (I think it happens to be OK right now,
> 
> I am actually OK if we limit the use of this tool to "use with a
> repository that is not corrupt", as coping with these kinds of
> breakages that in the main Git executable we deem "needs manual
> intervention" inside a single process is too painful (it would have
> been easier to cope with these too if we stuck with a script that
> invokes many discrete commands and acts on their errors, but that is
> optimizing for rare case and not recommended).  But we should tell
> users about the limitation and encourage them to ask for help in non
> automatable means.

I think you're saying, "Mention this drawback in the manpage for
git-bugreport." Sounds like a good idea to me, so I'll add it for v8.

 - Emily
