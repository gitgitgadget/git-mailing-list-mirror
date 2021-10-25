Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6F34C433F5
	for <git@archiver.kernel.org>; Mon, 25 Oct 2021 18:09:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8171261040
	for <git@archiver.kernel.org>; Mon, 25 Oct 2021 18:09:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230246AbhJYSMO (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Oct 2021 14:12:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230194AbhJYSMM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Oct 2021 14:12:12 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0436C061745
        for <git@vger.kernel.org>; Mon, 25 Oct 2021 11:09:49 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id lt6-20020a17090b354600b001a232054fe5so35389pjb.5
        for <git@vger.kernel.org>; Mon, 25 Oct 2021 11:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=/KfcrxDcqwtaWXALRvd/JSxEH0nAZ9Y5AUU/k7iHbcs=;
        b=VZzf7/BI4jOIYyEYWNs6KUF9HjzFaOloHRLoWqUdJWAaJEu6RcFkx2DEKQb5Gbl6iE
         7/vHsY5BHZLDW/GrpPEyqxoK9Nwl2f5asAHTE6lh9XbBMuHxGqxgmbCY3dsak8c2vwxR
         d1TNrzYjfyuMdN2kP40baoplBnwGVrZyMOWafCYpViXXBAXXaTezyG05V13sdEUGs9we
         6X5rVEM/wRMp+P5nrn8cjLbrku4u9/7HaUitGVyRtKP3ILIs3GLZEl3OWKLGgmkcVEVb
         QvEPAjVs6EDtwr8R2zC3yu0EllOmwSWxNko/KD0Bj48sh7Y8Zqnk7HUOrqb+0zpxT3uC
         ejaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=/KfcrxDcqwtaWXALRvd/JSxEH0nAZ9Y5AUU/k7iHbcs=;
        b=W1GvAu+mh0YqDGXHRwU1figkQsEVXgCklJYuQ9CDTVGuM7716oS+ByinIBrmAWXWMy
         +o/GfA7Pt+03YpZb/48eCabjda/WfkP/53LEBbDkakVNIiYdfOs+2w9ah9rQn9XgwmHR
         ceFSskcB2TLsjGNB3EjCaPlxO8JtdU8FcRSLNnOeQNQY3uhsw08IGsbWTRwiEXr6Of3p
         RniPZaegmjLEFR/JqdlxdQlevreH7vPJQGB+HdbRWzk0pupPHtQI6/8g8xazbQTj82ii
         9OW+Bsfb7rFOcU6J/oKa8EcPWtKIjQ8W/VDF+awLaD8nBKQx3hGb/3p/fKRzfixmNgPT
         RsOw==
X-Gm-Message-State: AOAM5321u6oWgkyxFZJtuyoxjfO1TM2ZEf50JjlucManWyuAkSkxD4CA
        WnBbw/P3E6yBHDs33ou+Udq/kqm+eolm7g==
X-Google-Smtp-Source: ABdhPJw85B58LAUY+Or/EME6bAMYMQRlge7tNgHnL9Pl32caRkscGt13etV4Z6cTnwrVNMvpvbbKWEmj1Dx0dw==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:902:8ec5:b0:13a:2789:cbb0 with SMTP
 id x5-20020a1709028ec500b0013a2789cbb0mr17798525plo.60.1635185389169; Mon, 25
 Oct 2021 11:09:49 -0700 (PDT)
Date:   Mon, 25 Oct 2021 11:09:46 -0700
In-Reply-To: <xmqqtuhbo2tn.fsf@gitster.g>
Message-Id: <kl6l35opasd1.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <20211013193127.76537-1-chooglen@google.com> <20211019224339.61881-1-chooglen@google.com>
 <20211019224339.61881-3-chooglen@google.com> <xmqqzgr3o4yw.fsf@gitster.g> <xmqqtuhbo2tn.fsf@gitster.g>
Subject: Re: [PATCH v3 2/4] remote: use remote_state parameter internally
From:   Glen Choo <chooglen@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Sorry I wasn't able to get to this sooner, this will be my first
priority.

Junio C Hamano <gitster@pobox.com> writes:

>> This made my "git push" to k.org and other places over ssh segfault
>> when their tip and what I am attempting to push are identical.  I
>> haven't spent more time than just to bisect the history down to
>> identify this commit as the possible culprit.

Does this fail iff the tip and the attempted push are identical, or does
it also fail for others sorts of pushes?

> (gdb) bt
> #0  0x000055555579a785 in pushremote_for_branch (branch=0x0, explicit=0x7fffffffcf84)
>     at remote.c:564
> #1  0x000055555579a5c2 in remotes_remote_get_1 (remote_state=0x5555559782a0, name=0x0,
>     get_default=0x55555579a742 <pushremote_for_branch>) at remote.c:518
> #2  0x000055555579a6d0 in remotes_pushremote_get (remote_state=0x5555559782a0, name=0x0)
>     at remote.c:542
> #3  0x000055555579a740 in repo_pushremote_get (repo=0x555555974b80 <the_repo>, name=0x0)
>     at remote.c:554
> #4  0x000055555560aa9d in pushremote_get (name=0x0) at ./remote.h:135
> #5  0x000055555560c5ce in cmd_push (argc=0, argv=0x7fffffffdc70, prefix=0x0)
>     at builtin/push.c:611
> #6  0x000055555557396a in run_builtin (p=0x555555941f78 <commands+2136>, argc=3,
>     argv=0x7fffffffdc70) at git.c:461
> #7  0x0000555555573d79 in handle_builtin (argc=3, argv=0x7fffffffdc70) at git.c:713
> #8  0x0000555555573fe6 in run_argv (argcp=0x7fffffffdafc, argv=0x7fffffffdaf0) at git.c:780
> #9  0x000055555557448f in cmd_main (argc=3, argv=0x7fffffffdc70) at git.c:911
> #10 0x000055555565b2ae in main (argc=6, argv=0x7fffffffdc58) at common-main.c:52
>
> The direct culprit is this part:
>
>     const char *pushremote_for_branch(struct branch *branch, int *explicit)
>     {
>             if (branch && branch->pushremote_name) {
>                     if (explicit)
>                             *explicit = 1;
>                     return branch->pushremote_name;
>             }
>             if (branch->remote_state->pushremote_name) {
>
> where the second if() statement used to check "pushremote_name", but
> now unconditionally dereferences "branch".
>
> The caller is remote_get_1(); this funciton was called with
> "current_branch", which can be NULL until you have a repository and
> you've called read_config(), but otherwise shouldn't be.

Thanks for helping to narrow the scope of the search :)

> I think somebody is not setting up the remote_state correctly?  When
> the user wants to just use the repository-wide pushremote, not
> having the current_branch would not matter, but if the pushremote
> for the current branch is different from the repository-wide one,
> the code would silently push to a wrong remote.

For the_repository, remote_state should be initialized via
initialize_the_repository(), which is called in common-main.c. I assumed
that this would set up remote_state correctly. I will confirm whether or
not this is the cause.

> In any case, any public facing entry point, like pushremote_get()
> that is directly called from cmd_push() with just a name, should
> auto vivify an instance of struct remote_state and populate its
> members as needed, I think, and in this particular case, I suspect
> that it forgets to initialize the current_branch and other members
> by calling read_config(), just like other entry points like
> repo_remote_get() do.

I'm fairly certain that pushremote_get() calls read_config() correctly
via repo_pushremote_get():

  struct remote *repo_pushremote_get(struct repository *repo, const char *name)
  {
    read_config(repo);
    return remotes_pushremote_get(repo->remote_state, name);
  }

Perhaps the problem lies elsewhere, let me look into it further.
