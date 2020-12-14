Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCED5C2BB9A
	for <git@archiver.kernel.org>; Mon, 14 Dec 2020 19:26:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90D7C224B0
	for <git@archiver.kernel.org>; Mon, 14 Dec 2020 19:26:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440614AbgLNT0k (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Dec 2020 14:26:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2440954AbgLNT0T (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Dec 2020 14:26:19 -0500
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 010A6C061793
        for <git@vger.kernel.org>; Mon, 14 Dec 2020 11:25:39 -0800 (PST)
Received: by mail-qv1-xf4a.google.com with SMTP id m91so12541446qva.21
        for <git@vger.kernel.org>; Mon, 14 Dec 2020 11:25:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=3C5STMxpb5DHH2uczSS57bP3bc/4tjKfIYmJukuhR9s=;
        b=cD8mRsNYhKccUecb9ebChhEcTzJiQ1k27Qf2P7dQoA0hoLDC/EBeVQR0Y5HqSboRJt
         qYIrMet1XPC5/6hoNMFkxX+PD4YUVteB5wRHVgq4FUXNdcj01aHGXfUXA5oynxMK4TkI
         kUqlmPz9qlSv7qJlSlGqduZeLIs92QCw5a+Yd4TCulIai/+GvwnRjqdnSPVmsC6Z8KNy
         yfGXf5GrNhSC7v+5CTBV3vGz3BNUSnf+19lNMSpLlbhT7rkVmsz5FykNZHe8GPJ1OJGr
         s0Loz+dTd8ZSJ+Yp6Kihe1Ia5I8j5LoF+agr2D6m84nHsQf+zjlvcwdbF+3KRGvCgo7y
         pEIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=3C5STMxpb5DHH2uczSS57bP3bc/4tjKfIYmJukuhR9s=;
        b=ZecisRHqHDC96A0IVUjd+/Q9l6gyHLf4Qc3W7odRdY8gZuCAfv4xGExq8qj9XHPNGH
         yOU7jfu6NAgtjD39wPkQU9rm4sdUU3a+sSQRN4DZ+UPdj1z7VKzN42rbUhX8TagX8vje
         rn0SREE9TZfg0lnChS5IyEnXNt2+iMKSVM7fk1crVhmtmnR12yUmmwENC04DqI1UCdUu
         9P/COkkuH6HuI0q8h6WOJTWa6t1Kww1kG5PPO+dufKf8zN273VcXGaDgeuXQDOBcNPDK
         S74AhrIFdrkT4iFSnCvwXaBjvtwcKjPY04meXCnKGIwftK+6z59RtGtnXVkSwoQ4KfkY
         8xDQ==
X-Gm-Message-State: AOAM531kQuqehH0NLpKkNnyPvTcoPU8dq/hEJouyWZ/pRt/Z5/Kac71+
        GFqJmYvVCxWiZFKuASIJPAGl5q8o9C8I/zUcigNR
X-Google-Smtp-Source: ABdhPJybwWNiAzTm+w+S3p0dCXKPCXWeDYUwKIEA/uIhiYO0KgO5+qGeCMUhepObRu0Z2NK7zQVdTqz4CsQiOWkMeI07
Sender: "jonathantanmy via sendgmr" <jonathantanmy@twelve4.c.googlers.com>
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a05:6214:140d:: with SMTP id
 n13mr30181340qvx.45.1607973938071; Mon, 14 Dec 2020 11:25:38 -0800 (PST)
Date:   Mon, 14 Dec 2020 11:25:34 -0800
In-Reply-To: <87blewwoil.fsf@evledraar.gmail.com>
Message-Id: <20201214192534.3105508-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <87blewwoil.fsf@evledraar.gmail.com>
X-Mailer: git-send-email 2.29.2.684.gfbc64c5ab5-goog
Subject: Re: [PATCH] clone: in protocol v2, use remote's default branch
From:   Jonathan Tan <jonathantanmy@google.com>
To:     avarab@gmail.com
Cc:     jonathantanmy@google.com, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> I'm not a fan of this change not because of the whole s/master/whatever/
> discussion, but because of the magic it adds for seemingly little gain &
> without any documentation.
> 
> So if I have init.defaultBranch explicitly set that'll be ignored on
> "clone", but on "init/git remote add/fetch" it won't?
> 
> I think so, and I swear I knew yesterday when I read this patch, but now
> I can't remember. Anyway, the point that I avoided re-reading the patch
> to find out, because even if there's an on-list answer to that it should
> really be documented because I'll forget it next week, and our users
> will never know :)

That's the plan - yes. It makes sense to me that "git clone" will not
use "init.defaultBranch" (especially since it has "init" in the name),
but "git init" will. (It also makes sense to me that "git remote add"
and "git fetch" will not change HEAD.)

> This patch also leaves Documentation/config/init.txt untouched, and now
> under lsrefs.unborn it explicitly contradicts the behavior of git:
> 
>     Allows overriding the default branch name e.g. when initializing
>     a new repository or when cloning an empty repository.

Ah...thanks for the pointer. I'll change it.

> Shouldn't this at the very least be a
> init.defaultBranchFromRemote=<bool> which if set overrides
> init.defaultBranch? We could turn that to "true" by default and get the
> same behavior as you have here, but with less inexplicable magic for the
> user, no?

I think you're coming with the idea that it is perfectly natural for
"git clone" to respect "init.defaultBranch", but that doesn't even
happen in the typical case wherein we clone a non-empty repository - so
I don't agree with that idea.

> It seems if you're a user and wonder why a clone of a bare repo doesn't
> give you "init" defaults the only way you'll find out is
> GIT_TRACE_PACKET and the like.

I assume you mean empty repo instead of bare repo? For me, I would find
it more surprising that the resulting local repo didn't have the same
HEAD as the remote.

> Another reason I'm not a fan of it is because it's another piece of
> magic "clone" does that you can't emulate in "init/fetch". We have
> e.g. --single-branch as an existing case of that (although you can at
> least do that with parse ls-remote -> init -> config -> fetch), and
> that's a case that doesn't fit into a refspec.

Same answer as above.

> But shouldn't there at least be a corresponding "fetch" option? On init
> we'll create head, but "git fetch --clobber-my-idea-of-HEAD-with-remote
> ..."?

I think that it's OK for "clone" to create HEAD, but not OK for "fetch"
to modify HEAD.

> Maybe not for reasons I haven't thought of, but I'd at least be much
> happier with an updated commit message justifying another special-case
> in clone that you can't do with "init/fetch".

Same answer as above - I don't think this is a special case.

> And on the "litte gain" side of things: I very much suspect that the
> only users who'll ever use this will be some big hosting providers (but
> maybe not, the commit doesn't suggest a use-case). Wouldn't this be even
> more useful in those cases by just a pre-receive hook on their side
> detecting an initial push refusing "master", and:
> 
>     git push -o yes-use-old-init-default <...>
> 
> Instead of a patch to git to do the same & which would take $SOMEYEARS
> to be rolled out, since it depends on client-side understanding.

This would detect the problem only upon push.

> > @@ -62,7 +62,7 @@ struct protocol_capability {
> >  
> >  static struct protocol_capability capabilities[] = {
> >  	{ "agent", agent_advertise, NULL },
> > -	{ "ls-refs", always_advertise, ls_refs },
> > +	{ "ls-refs", ls_refs_advertise, ls_refs },
> >  	{ "fetch", upload_pack_advertise, upload_pack_v2 },
> >  	{ "server-option", always_advertise, NULL },
> >  	{ "object-format", object_format_advertise, NULL },
> 
> All of this looks good to me, and re unrelated recent questions about
> packfile-uri I had it's really nice to have a narrow example of adding a
> simple ls-refs time verb / functionality like this to the protocol.

Thanks.

> > diff --git a/t/t5606-clone-options.sh b/t/t5606-clone-options.sh
> > index 7f082fb23b..d3bd79987b 100755
> > --- a/t/t5606-clone-options.sh
> > +++ b/t/t5606-clone-options.sh
> > @@ -102,11 +102,12 @@ test_expect_success 'redirected clone -v does show progress' '
> >  '
> >  
> >  test_expect_success 'chooses correct default initial branch name' '
> > -	git init --bare empty &&
> > +	git -c init.defaultBranch=foo init --bare empty &&
> > +	test_config -C empty lsrefs.unborn advertise &&
> 
> Isn't this reducing test coverage? You're changing an existing
> argument-less "init --bare" test's behavior,

The test here is regarding "clone", not the behavior of "init". I'm
doing some textual comparison below, so I want to insulate this test
against future default branch name changes.

> 
> >  	GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME= \
> >  	git -c init.defaultBranch=up clone empty whats-up &&
> > -	test refs/heads/up = $(git -C whats-up symbolic-ref HEAD) &&
> > -	test refs/heads/up = $(git -C whats-up config branch.up.merge)
> > +	test refs/heads/foo = $(git -C whats-up symbolic-ref HEAD) &&
> > +	test refs/heads/foo = $(git -C whats-up config branch.foo.merge)
> >  '
> 
> Also re the above point about discoverability: Right below this we test
> "init --initial-branch=guess". Wouldn't a way to unify bring
> fetch/init/clone functionality be to use that as a jump-off point,
> i.e. clone having --use-remote-initial-branch, 

OK - this is already happening for non-empty repositories, and my patch
makes it also happen for empty repositories.

> init optionally leaving
> behind a (broken) empty/nonexisting HEAD, 

I'm not sure how this is superior to just using what the remote has
(upon "clone") and using init.defaultBranch when no remote is involved
(upon "init").

> and "fetch" with an argument
> also supporting --use-remote-initial-branch or something.

Again, I don't think that "fetch" should update HEAD.

> 
> > +test_expect_success 'clone of empty repo propagates name of default branch' '
> > +	git -c init.defaultbranch=mydefaultbranch init file_empty_parent &&
> > +	test_config -C file_empty_parent lsrefs.unborn advertise &&
> > +
> > +	git -c init.defaultbranch=main -c protocol.version=2 \
> > +		clone "file://$(pwd)/file_empty_parent" file_empty_child &&
> 
> Nit. Let's spell config.likeThis not config.likethis when not in the C
> code.

OK - will do.
