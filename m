Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B64F31F453
	for <e@80x24.org>; Tue, 23 Oct 2018 22:38:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726737AbeJXHD0 (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Oct 2018 03:03:26 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:44789 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725787AbeJXHD0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Oct 2018 03:03:26 -0400
Received: by mail-ed1-f67.google.com with SMTP id z21-v6so3165921edb.11
        for <git@vger.kernel.org>; Tue, 23 Oct 2018 15:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wFu3aDH5oR3P5HlMZbe3XFATr6HI2ewm9r9Sb4Li3bU=;
        b=uQMpCbJsWDFkTyiVwRIroHYosvOk419CrAcTYYoMlVAtRuzQLBfHfr6LvvG9IVrJod
         soT+HXVw0noQF6Rcn1Qd9yT97KFdhwv5IlrhIBH3lOjrm3Anp7RtRb5NtExi+xMiwnyT
         fflvwx44BhcMMWQo233Bu/rlCPBJmVVXEPewcNJBd/3QzRYQar4sYRxLhcUSA3ZB56IC
         vcMzfWK11iQ+bi1X6danTGl0wCXkk5pSazok7b6AaHDu7jmbhF91CeBz/v4NHz7QkUR7
         BJ+0T0c7wgVG/8wGBmZ9pUDUA3Y1tedz5loTUp+SyYkotejPBo/HeYo11kZ+WPkueOwH
         uj6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wFu3aDH5oR3P5HlMZbe3XFATr6HI2ewm9r9Sb4Li3bU=;
        b=G4ptlLUJaWLrids7oLAiFEPZpp3zKUh+9IxXn6LdrEUWzu/fRAIDPAxmH4mvzOU5jl
         yOxUv2UV19FQ0eKomw0XCQRbWlZ6/W7UAL/8AzESIICfe6AYrKFCwKWjViRq3f/WiIiM
         jCTxplzm3LR5qVHBj+Lipc/GnIG8874RsNzYd3+GIUcZotUcncW7icc09lqy1RgROSkC
         1QpXt3hgb7bl5j1WxkoKME6cbcTLkI9vvY4T7AdTQrxhp75FFYcEzzIy3L8AI2HEESAu
         ns7CkvdLzH50eyVAwEn2ZWQ4GmvA/RRueIK2ARSjj6C6UcYbvMoe+YcU85CldcTMj1wb
         lGqw==
X-Gm-Message-State: AGRZ1gKMI4mj20FBRDHnmOo3amiy7CPmBQD1A62ZkRJc63J/eMM/Nhfm
        9mtwQD2AuCxq/yXSsDAMiqw4tWJrvSbI9YAAuPCxNw==
X-Google-Smtp-Source: AJdET5dsEeVaqoXvip8v4q35qB7izTeB1nCUQSkF7pjYc4rl7RlO8GfG1sxgKa8/gqv4+x2Hj5fZ+glvfnh4twQq/qM=
X-Received: by 2002:a17:906:b819:: with SMTP id dv25-v6mr57404ejb.70.1540334280103;
 Tue, 23 Oct 2018 15:38:00 -0700 (PDT)
MIME-Version: 1.0
References: <20181016181327.107186-9-sbeller@google.com> <20181018003954.139498-1-jonathantanmy@google.com>
In-Reply-To: <20181018003954.139498-1-jonathantanmy@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 23 Oct 2018 15:37:48 -0700
Message-ID: <CAGZ79kZrK5G-EeGRzxyw0xW3ozo9_aPab4r8fn_Jc4hzKDOEwg@mail.gmail.com>
Subject: Re: [PATCH 8/9] fetch: retry fetching submodules if needed objects
 were not fetched
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 17, 2018 at 5:40 PM Jonathan Tan <jonathantanmy@google.com> wrote:
>
> > Currently when git-fetch is asked to recurse into submodules, it dispatches
> > a plain "git-fetch -C <submodule-dir>" (with some submodule related options
> > such as prefix and recusing strategy, but) without any information of the
> > remote or the tip that should be fetched.
> >
> > This works surprisingly well in some workflows (such as using submodules
> > as a third party library), while not so well in other scenarios, such
> > as in a Gerrit topic-based workflow, that can tie together changes
> > (potentially across repositories) on the server side. One of the parts
> > of such a Gerrit workflow is to download a change when wanting to examine
> > it, and you'd want to have its submodule changes that are in the same
> > topic downloaded as well. However these submodule changes reside in their
> > own repository in their own ref (refs/changes/<int>).
>
> It seems that the pertinent situation is when, in the superproject, you
> fetch a commit (which may be the target of a ref, or an ancestor of the
> target of a ref) that points to a submodule commit that was not fetched
> by the default refspec-less fetch that you describe in the first
> paragraph. I would just describe it as follows:
>
>   But this default fetch is not sufficient, as a newly fetched commit in
>   the superproject could point to a commit in the submodule that is not
>   in the default refspec. This is common in workflows like Gerrit's.
>   When fetching a Gerrit change under review (from refs/changes/??), the
>   commits in that change likely point to submodule commits that have not
>   been merged to a branch yet.

Makes sense.

> Another thing you need to clarify is what happens if the fetch-by-commit
> fails. Right now, it seems that it will make the whole thing fail, which
> might be a surprising change in behavior.

But a positive surprise, I would assume?

> The test stores the result in a normal branch, not a remote tracking
> branch. Is storing in a normal branch required?

In the test we fetch from another repository, such that in the
repository-under-test this will show up in a remote tracking branch?

> Also, do you know why this is required? A naive reading of the patch
> leads me to believe that this should work even if merely fetching to
> FETCH_HEAD.

See the next patch, check_for_new_submodule_commits() is missing
for FETCH_HEAD.

>
> > +struct get_next_submodule_task {
> > +     struct repository *repo;
> > +     const struct submodule *sub;
> > +     unsigned free_sub : 1; /* Do we need to free the submodule? */
> > +     struct oid_array *commits;
> > +};
>
> Firstly, I don't think "commits" needs to be a pointer.
>
> Document at least "commits". As far as I can tell, if NULL (or empty if
> you take my suggestion), this means that this task is the first pass for
> this particular submodule and the fetch needs to be done using the
> default refspec. Otherwise, this task is the second pass for this
> particular submodule and the fetch needs to be done passing the
> contained OIDs.

Makes sense. I think I'll make it a non-pointer, but will introduce another
flag or counter for the phase.

>
> > +static const struct submodule *get_default_submodule(const char *path)
> > +{
> > +     struct submodule *ret = NULL;
> > +     const char *name = default_name_or_path(path);
> > +
> > +     if (!name)
> > +             return NULL;
> > +
> > +     ret = xmalloc(sizeof(*ret));
> > +     memset(ret, 0, sizeof(*ret));
> > +     ret->path = name;
> > +     ret->name = name;
> > +
> > +     return (const struct submodule *) ret;
> > +}
>
> What is a "default" submodule and why would you need one?

s/default/artificial/. Such a submodule is a submodule that has no
config in the .gitmodules file and its name == path.
We need to keep those around for historic reasons AFAICT, c.f.
c68f837576 (implement fetching of moved submodules, 2017-10-16)

> > +             task = get_next_submodule_task_create(spf->r, ce->name);
> > +
> > +             if (!task->sub) {
> > +                     free(task);
> > +                     continue;
> >               }
>
> Will task->sub ever be NULL?

Yes, if we fall back to these "default" submodule and just try if it
can be handled
as a submodule, but it cannot be handled as such,
get_next_submodule_task_create has

    task->sub = submodule_from_path(r, &null_oid, path);
    if (!task->sub) {
        task->sub = get_default_submodule(path);

and get_default_submodule can return NULL.


>
> > +     if (spf->retry_nr) {
> > +             struct get_next_submodule_task *task = spf->retry[spf->retry_nr - 1];
> > +             struct strbuf submodule_prefix = STRBUF_INIT;
> > +             spf->retry_nr--;
> > +
> > +             strbuf_addf(&submodule_prefix, "%s%s/", spf->prefix, task->sub->path);
> > +
> > +             child_process_init(cp);
> > +             prepare_submodule_repo_env_in_gitdir(&cp->env_array);
> > +             cp->git_cmd = 1;
> > +             cp->dir = task->repo->gitdir;
> > +
> > +             argv_array_init(&cp->args);
> > +             argv_array_pushv(&cp->args, spf->args.argv);
> > +             argv_array_push(&cp->args, "on-demand");
>
> This means that we need to trust that the last entry in spf->args can
> take an "on-demand" parameter. Could we supply that argument here
> explicitly instead?
>
> > +             argv_array_push(&cp->args, "--submodule-prefix");
> > +             argv_array_push(&cp->args, submodule_prefix.buf);
> > +
> > +             /* NEEDSWORK: have get_default_remote from s--h */
>
> What is s--h?

builtin/submodule--helper, will clarify

>
> > +static int commit_exists_in_sub(const struct object_id *oid, void *data)
> > +{
> > +     struct repository *subrepo = data;
> > +
> > +     enum object_type type = oid_object_info(subrepo, oid, NULL);
> > +
> > +     return type != OBJ_COMMIT;
> > +}
>
> Shouldn't the function name be commit_missing_in_sub?

yes.

>
> >  static int fetch_finish(int retvalue, struct strbuf *err,
> >                       void *cb, void *task_cb)
> >  {
> >       struct submodule_parallel_fetch *spf = cb;
> > +     struct get_next_submodule_task *task = task_cb;
> > +     const struct submodule *sub;
> > +
> > +     struct string_list_item *it;
> > +     struct oid_array *commits;
> >
> >       if (retvalue)
> >               spf->result = 1;
> >
> > +     if (!task)
> > +             return 0;
>
> When will task be NULL?
>
> > +
> > +     sub = task->sub;
> > +     if (!sub)
> > +             goto out;
>
> Same as above - when will sub be NULL?
>
> > +     it = string_list_lookup(&spf->changed_submodule_names, sub->name);
> > +     if (!it)
> > +             goto out;
>
> And "it" as well.

I'll add comments.

>
> > +     commits = it->util;
> > +     oid_array_filter(commits,
> > +                      commit_exists_in_sub,
> > +                      task->repo);
> > +
> > +     /* Are there commits that do not exist? */
> > +     if (commits->nr) {
> > +             /* We already tried fetching them, do not try again. */
> > +             if (task->commits)
> > +                     return 0;
>
> Clearer and more efficient if the check for task->commits was first
> before all the filtering.
>
> > +test_expect_success "fetch new commits on-demand when they are not reachable" '
>
> "not reachable" confused me - they are indeed reachable, just not from
> the default refspec.

Makes sense

>
> > +     git checkout --detach &&
> > +     C=$(git -C submodule commit-tree -m "new change outside refs/heads" HEAD^{tree}) &&
> > +     git -C submodule update-ref refs/changes/1 $C &&
> > +     git update-index --cacheinfo 160000 $C submodule &&
> > +     git commit -m "updated submodule outside of refs/heads" &&
> > +     D=$(git rev-parse HEAD) &&
> > +     git update-ref refs/changes/2 $D &&
> > +     (
> > +             cd downstream &&
> > +             git fetch --recurse-submodules --recurse-submodules-default on-demand origin refs/changes/2:refs/heads/my_branch &&
> > +             git -C submodule cat-file -t $C &&
> > +             git checkout --recurse-submodules FETCH_HEAD
> > +     )
> > +'
>
> For maximum test coverage, I think this test should involve 2
> submodules:
>
>  B   C  E   F
>   \ /    \ /
>    A      D
>
> and the upstream superproject having:
>
>   G -> H -> I
>
> The downstream superproject already has G, and is fetching I. In H, the
> submodule gitlinks point to B and E respectively, and in I, the
> submodule gitlinks point to C and F respectively. This ensures that both
> multiple submodules work, and that submodule commits are also fetched
> for interior superproject commits.

ok.
