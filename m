Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE714C43334
	for <git@archiver.kernel.org>; Thu, 14 Jul 2022 21:44:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232538AbiGNVod (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Jul 2022 17:44:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240790AbiGNVo1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Jul 2022 17:44:27 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FA1D13D3C
        for <git@vger.kernel.org>; Thu, 14 Jul 2022 14:44:25 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id r1so1580009plo.10
        for <git@vger.kernel.org>; Thu, 14 Jul 2022 14:44:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=h6UUY30jUCQfDit3ljHXMMt7WwwYv/5QZBile1Y11QU=;
        b=Mz8hOPzKI1YRD0F8r7rh4IhMsSojSM8oZTH8A36UCVcWqTsO789Y1DR3C5lPf4bYdU
         3KNnBNWjNdn9Ngr9FasRyPJSBXpBbslT1cL1ZP6doxDrhyr3GCJFNolcQWBVIGUtwL9d
         PswWYBA5plSI/V9hGvBLRvNvI8zQKHjk0uU7ZfpIKtWHsbwoeRdD7PRuXx2+8YXlqc7T
         CoOVGCCam7LdiQLwrb2JFTFPWfEEY6BsWfUxPj43kSjC334UKrXvdPYrf5fFXzmiV9ls
         XtswpwPDEnrc1cjSl0j8neD4kjtg1A9AhwlyLEssCwEJXBnaAa0uSWTabynIoCm32IAF
         CkFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=h6UUY30jUCQfDit3ljHXMMt7WwwYv/5QZBile1Y11QU=;
        b=bDdtlMiYQ9jQ4zpvM/G3LbDvv7s13WNaJCWpZMKSZGnjfnf7lToFyu80VRRt8UQApx
         EVCcpVj9vmQEcb+PRJ03PCvPEeUtRq0V1qdQX6GWLb4WfYiTGpuDCjp4ye4eXpWj1hDg
         jd6zrDoHgr2EJMbdQ16mqumfztIntmZ5c5QPPH9R61cli5PgphwnR2d13p9grOOZK3+n
         mMk/YvyDxisgUk6iAc5jR0DlR/bOZghuQmzJvy6lVlC88arHRNBQBv67etxlr79vtWaT
         rp8M9sjazNI7a1LIeCKr8gFw1Q7OLcQfDH05VAffhl8P3yN2mYOB6RaZWdQIetLEv0/P
         NIXQ==
X-Gm-Message-State: AJIora8kSy48nozAc4CL0t4SgrffveqOMMQBYECSc58db8Z54o4lfrw2
        4IeOSm1oYLxGpJEQpIsFh7OUQg==
X-Google-Smtp-Source: AGRyM1s6i2dMjuQKJQ8xs4QXhDN6aLV9WsJBQJcC5/uhAgdfX17U9xmo/ZbNH3JjtGosx9KQBun3lQ==
X-Received: by 2002:a17:902:ab13:b0:16c:bc10:85a9 with SMTP id ik19-20020a170902ab1300b0016cbc1085a9mr2254423plb.7.1657835064597;
        Thu, 14 Jul 2022 14:44:24 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:8983:501b:77cd:111d])
        by smtp.gmail.com with ESMTPSA id l5-20020a170903244500b0016bef6f6903sm1954968pls.72.2022.07.14.14.44.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 14:44:23 -0700 (PDT)
Date:   Thu, 14 Jul 2022 14:44:17 -0700
From:   Josh Steadmon <steadmon@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com, derrickstolee@github.com,
        lessleydennington@gmail.com, vdye@github.com, avarab@gmail.com,
        jonathantanmy@google.com
Subject: Re: [PATCH v3] commit-graph: refactor to avoid prepare_repo_settings
Message-ID: <YtCOMegkRgaY3gnX@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        me@ttaylorr.com, derrickstolee@github.com,
        lessleydennington@gmail.com, vdye@github.com, avarab@gmail.com,
        jonathantanmy@google.com
References: <Yjt6mLIfw0V3aVTO@nand.local>
 <9b56496b0809cc8a25af877ea97042e2cb7f2af6.1655246092.git.steadmon@google.com>
 <xmqq1qvfyrbb.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq1qvfyrbb.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2022.06.23 14:59, Junio C Hamano wrote:
> Josh Steadmon <steadmon@google.com> writes:
> 
> > This series of changes broke fuzz-commit-graph, which attempts to parse
> > arbitrary fuzzing-engine-provided bytes as a commit graph file.
> > commit-graph.c:parse_commit_graph() calls prepare_repo_settings(), but
> > since we run the fuzz tests without a valid repository, we are hitting
> > the BUG() from 44c7e62 for every test case.
> >
> > Fix this by moving the majority of the implementaiton of
> > `parse_commit_graph()` into a new function,
> > `parse_commit_graph_settings()` that accepts a repo_settings pointer.
> > This allows fuzz-commit-graph to continue to test the commit-graph
> > parser implementation without relying on prepare_repo_settings().
> 
> It sounds like this is not a "fix" but a workaround to bend the
> production code so that a non-production test shim can be inserted
> more easily.
> 
> I am OK with the idea, but have a huge problem with the new name.
> 
> Is it just me who thinks parse_commit_graph_settings() is a function
> that parses some kind of settings that affects the way the commit
> graph gets used or written?
> 
> Stepping back a bit, why can't fuzz-commit-graph prepare a
> repository object that looks sufficiently real?  Something along the
> lines of...
> 
>                 struct repository fake_repo;
> 
>                 fake_repo.settings.initialized = 1;
>                 fake_repo.gitdir = ".";
>                 parse_commit_graph(&fake_repo, (void *)data, size);
> 		...
> 
> Also, I feel somewhat uneasy to see these changes:
> 
> > -	if (get_configured_generation_version(r) >= 2) {
> > +	if (s->commit_graph_generation_version >= 2) {
> > -	if (r->settings.commit_graph_read_changed_paths) {
> > +	if (s->commit_graph_read_changed_paths) {
> > -	ctx->write_generation_data = (get_configured_generation_version(r) == 2);
> > +	ctx->write_generation_data = (r->settings.commit_graph_generation_version == 2);
> >  	ctx->num_generation_data_overflows = 0;
> 
> that makes the production code bend over backwards to _avoid_
> referencing 'r', only to cater to the test shim.  That's an
> artificial limitation we are forcing on our developers who works on
> this code.  It might be that what is in the repository settings is
> sufficient for today's code to work, but I do not think needs for
> fuzz tests should tie the hand of this production code by forbidding
> it to look at other things in the repository in the future.  After
> all, tests are to serve the production code, not the other way
> around.
> 
> On the other hand, I think a change that is slightly smaller than
> the posted patch, which justifies itself with a completely different
> rationale, would be totally acceptable.  You can justify this change
> with NO mention of fuzzers.
> 
>     The parse_commit_graph() function takes a "struct repository *"
>     pointer, but all it cares about is the .settings member of it.
> 
>     Update the function and all its existing callers so that it
>     takes "struct repo_settings *" instead.
> 
> Now, in the future, some developers _might_ find it necessary to
> access stuff other than the repository settings to validate the
> contents of the graph file, and we may need to change it to take a
> full repository structure again.  The test should adjust to such
> needs of the production code, not the other way around.  But until
> then...
> 
> Thanks.

I trimmed down the changes and reworded the commit message for V4. I'm
assuming you don't object to mentioning the fuzzer, just that it
shouldn't be the main justifiation for the change.

Sorry for the delayed response, and thanks for the feedback.
