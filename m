Return-Path: <SRS0=XLsf=DH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 283CDC4727C
	for <git@archiver.kernel.org>; Wed, 30 Sep 2020 20:42:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D905B20759
	for <git@archiver.kernel.org>; Wed, 30 Sep 2020 20:42:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Lt3mTL1U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730196AbgI3UmD (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Sep 2020 16:42:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725355AbgI3UmD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Sep 2020 16:42:03 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A6B8C061755
        for <git@vger.kernel.org>; Wed, 30 Sep 2020 13:42:02 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id u23so1701897qku.17
        for <git@vger.kernel.org>; Wed, 30 Sep 2020 13:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=UA268sJcFlHioX5pVvddaS/3Mjt70FqR4bI+0i+c158=;
        b=Lt3mTL1UAOUm0IRstvlACXSToTxtxjCUoIbOlyZNer6I8nqUC9sKnE59pT01OooAL/
         yz2oMFPXz0tDLEWfjUFzLrm3P6hrm+C+jrOoOmv85/zFAck43oUHVtUzh44sn0LNqF+p
         RyTLwZ6HENaGDxm1B37JTjYq4q3ivJDrmFCqAKVDrQ7XXswRk8ewiyGDmlG39MLPsoc/
         9LKZ2Ce2v6Aa7wrNDTJKH7ZdtCNm9nAkvBMOYfTcKH2mcZZavpa8cQVI3wMeZuFJoMb0
         +5LxStgjPmlkJehu8NPWivi8ob67efJeft5RcF69sB4RfLlgav0XfFMrb+49jkhgqwpt
         ev6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=UA268sJcFlHioX5pVvddaS/3Mjt70FqR4bI+0i+c158=;
        b=YG1Lphedks/zy+xcQZR2+GoO0afrf79If6yOcKi9SO7Y735Cp8u+Ozjln+xjtUFpwg
         VAbrds9v1pggTSaoJsmVQrUiN8uhFuU3utrlOlsoMamA0Q/RQvfKZjHiV4ffNf2xO3Om
         MJ4tDBWkWrHQ2ethzODbT7vVolQiuJ2vSRP5KHMbcg0ca74R6hLEYDUg1yh2LvBsAYXg
         nhwtcFCJlksDr24N1+qrlytsrZi9/xOSay9NQaYFyRWZi1Qs6JcRG5Fyo5PbKxk1dWea
         sAeC4B0YkZDw+Wn0gwmnCStjJZufxrVwKa/DYQxxbrNvjeJ5fgqvq0oh+Q3jiH8V30PD
         ELlg==
X-Gm-Message-State: AOAM5328LkjxRyD21vhfCH3TFfHGvwy7XUIdvXwetSSIgcEej9ySmDnk
        xqxV6SmcfqcDPHoowLD8yO/+YsYpBBr/lr9ItX/e
X-Google-Smtp-Source: ABdhPJxxbkaeSd0wJp/ziMqgizJi3Ix4uQuboiP3YwQIqb8TwTcWthrmVloRTvu99BULOXlnhnsXb0u8RQv5jWs+TuLA
Sender: "jonathantanmy via sendgmr" <jonathantanmy@twelve4.c.googlers.com>
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:ad4:47cc:: with SMTP id
 p12mr4323303qvw.26.1601498521115; Wed, 30 Sep 2020 13:42:01 -0700 (PDT)
Date:   Wed, 30 Sep 2020 13:41:59 -0700
In-Reply-To: <20200930142846.0eeaa33a@ado-tr.home.arpa>
Message-Id: <20200930204159.433045-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <20200930142846.0eeaa33a@ado-tr.home.arpa>
X-Mailer: git-send-email 2.28.0.709.gb0816b6eb0-goog
Subject: Re: [PATCH 0/7] Submodules and partial clones
From:   Jonathan Tan <jonathantanmy@google.com>
To:     andrew@adoakley.name
Cc:     jonathantanmy@google.com, git@vger.kernel.org, luke@diamand.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Yes, grep just calls `add_to_alternates_memory` and will be broken.
> 
> When handling nested submodules `config_from_gitmodules` does the same
> thing, so that will also be broken if some of the .gitmodules files
> need fetching.
> 
> Fixing these probably does require supporting fetching of objects from
> submodules.

[snip]

> > > The patches rework various cases where objects from a submodule are
> > > added to the object store of the main repository.  There are some
> > > remaining cases where add_to_alternates_memory is used to do this,
> > > but add_submodule_odb has been removed.
> > > 
> > > I expect there will be some remaining issues, but these changes
> > > seem to be enough to get the basics working.  
> > 
> > What are the basics that work?
> 
> I've tried at least the following, in a repo with several submodules and
> large objects (but no nested submodules):
> - git clone --recursive --filter=blob:limit=1M ...
> - git pull --rebase --recurse-submodules=on-demand
> - git show --submodue=diff <commit-with-big-submodule-object>
> - git push --recurse-submodules=check
> - git push --recurse-submodules=on-demand
> 
> I used the partial clone for a while and didn't hit any problems, but I
> can't say what (relevant) commands I might have used.
> 
> An important thing that I've not tried is a merge that needs to fetch
> objects.  I should probably write a testcase for that.

Thanks - so it looks like what we need to have are:

 (1) propagate --filter when cloning (done here)
 (2) handle how Git lazy-fetches when accessing submodule objects
  (2a) access through add_submodule_odb (seems to have been done here -
       the patches here convert these accesses into (2c))
  (2b) access through add_to_alternates_memory (reading missing objects will
       trigger a likely-to-fail fetch)
  (2c) access through repo_.* and similar functions (reading missing objects
       will fail outright)
  (2d) access through invoking a subprocess (will work)

Having (1) and (2a) means that (as you described above) we can have
generally working partial-clone submodules (in that commands like
"clone", "pull", and "push" work), except that there may be some
commands like "grep" that will have strange behavior (lazy-fetching from
the wrong repo and failing). Currently, partial-clone submodules do not
work at all. My initial inclination was to say that we should resolve
(2c) first, but it is true that this change (even without (2b) and (2c))
would bring user-facing benefit, but at the cost of possible negative
surprises (even if we warn in the documentation that this feature is
experimental and might fail). I'm not sure what the rest of the Git
developer community thinks about this.

> > When I looked into this, my main difficulty lay in getting the
> > lazy fetch to work in another repository. Now that lazy fetches are
> > done using a separate process, the problem has shifted to being able
> > to invoke run_command() in a separate Git repository. I haven't
> > figured out the best way to ensure that run_command() is run with a
> > clean set of environment variables (so no inheriting of GIT_DIR
> > etc.), but that doesn't seem insurmountable.
> 
> Yes, I think that to fix promisor_remote_get_direct we need to:
> - store the promisor configuration per-repository
> - run the fetch process in the correct repository
> 
> AFAICT we just need to set cp.dir and call prepare_submodule_repo_env
> to get the right environment for the fetch process. The per-repository
> configuration looks more fiddly to do.  I'm happy to try and make these
> additional changes (but it won't be quick as I'm busy with the day job).
> 
> In any case we need to pass the right repository around.

Ah, good point about prepare_submodule_repo_env() - that does take care
of the environment variables.

I'll look at per-repository configuration and see what I can do too.
