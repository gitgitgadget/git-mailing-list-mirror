Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F077C433EF
	for <git@archiver.kernel.org>; Thu, 27 Jan 2022 21:33:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344365AbiA0VdJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Jan 2022 16:33:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234277AbiA0VdJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jan 2022 16:33:09 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34DADC061714
        for <git@vger.kernel.org>; Thu, 27 Jan 2022 13:33:09 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id z20-20020aa791d4000000b004bd024eaf19so2185638pfa.16
        for <git@vger.kernel.org>; Thu, 27 Jan 2022 13:33:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=LZdKdnxXEiXtCL/HsGiIe11WgR7Dn8ukO+eDOmsKs8g=;
        b=e3vLR0R7786nkOSdoQcYPdmrQVLIVqH14RDRtWT4EeOKXIJmXZw6yLyWGpIfkM6gM1
         Hu7KeobPEzt5bDIiytcqJdMmJT47wemHlSRJ/PZ3sKz25XSyphqyFDWcJJQkA4RLmlhd
         gu8wdc7/Vn7agnZEIDMGpM6YRmFAcml2DkUUSX52BqtjsqQ1huez/FNLbRi8aQZRWka/
         lc3p8LkfvdHP+SVLnKddVVI16FigMFk0fKBWr2q8NWQkvWyV7uDBK2l+5PiaGf7uxvaf
         R36BrlE4Dal4RqqKVA3KsWWLb2DRroIPmVlwxMwYQy0yg0IoBWiFn0Bxovx9zZCHozSM
         y1Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=LZdKdnxXEiXtCL/HsGiIe11WgR7Dn8ukO+eDOmsKs8g=;
        b=vjul4F7joEny2ckMTSprh1onzp4mG3UNLJN2hTKmVZe5JwuWAeXwY/F9gickGv+vJu
         XmSQX9uMqjI9ygWec9L/XEkO/ZFHIePFSDOOnw2/NbMa52c7pnz9MnlmISvqnDv4g4zb
         OlWxJDk9jvuBB3WclKRLhNlE6uK8UqpCzHoQkvvTCFqk6nzfAxlXp0ak1s9SYNY/Pe26
         iG3iRB9193Ql34Kyhlpx8+c+lEH1vNxCFqJfMv3mmIkW4XYJ038VxJuVkjCae/VtAVO6
         wyTHV1ZxyncD0H6ToCcbjJP30SRRge4cpL/anEIIwAa950uFA3UiFlmvkyxJiwjVXRwv
         d+Jw==
X-Gm-Message-State: AOAM532mKGX2D6kuaPDLUCMJPnzLkw0cEC/c6nv6uF/vl9mWdIBh0+4A
        uSlf1PGCGXtA+WZl5MJ7L11iyzvpToDxng==
X-Google-Smtp-Source: ABdhPJwK4PBV6p/m3M+NohUNV2gbk8rgaM3JMq8bTdtk2Q+uoyUvsQlhqN4nyNMD3cFDZL7Z7ZKS6hJEGI4T0w==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:aa7:9429:: with SMTP id
 y9mr5078880pfo.20.1643319188453; Thu, 27 Jan 2022 13:33:08 -0800 (PST)
Date:   Thu, 27 Jan 2022 13:32:58 -0800
In-Reply-To: <20220127202918.3099460-1-jonathantanmy@google.com>
Message-Id: <kl6lr18szwxh.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <20220124204442.39353-6-chooglen@google.com> <20220127202918.3099460-1-jonathantanmy@google.com>
Subject: Re: [PATCH v7 5/6] branch: add --recurse-submodules option for branch creation
From:   Glen Choo <chooglen@google.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, jonathantanmy@google.com, steadmon@google.com,
        emilyshaffer@google.com, avarab@gmail.com,
        levraiphilippeblain@gmail.com, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

>> Although this commit does not introduce breaking changes, it is
>> incompatible with existing --recurse-submodules commands because "git
>> branch --recurse-submodules" writes to the submodule ref store, but most
>> commands only consider the superproject gitlink and ignore the submodule
>> ref store. For example, "git checkout --recurse-submodules" will check
>> out the commits in the superproject gitlinks (and put the submodules in
>> detached HEAD) instead of checking out the submodule branches.
>
> The usual meaning of "incompatible" is "cannot be used together", I
> think, which is not what's happening here - it's just that the user
> would expect them to work together in a specific way but they don't do
> that.

Ok, I'll replace "incompatible with" with "does not interact well with".

>> + */
>> +static int submodule_create_branch(struct repository *r,
>> +				   const struct submodule *submodule,
>> +				   const char *name, const char *start_oid,
>> +				   const char *start_name, int force,
>> +				   int reflog, int quiet,
>> +				   enum branch_track track, int dry_run)
>> +{
>> +	int ret = 0;
>> +	struct child_process child = CHILD_PROCESS_INIT;
>> +	struct strbuf child_err = STRBUF_INIT;
>> +	struct strbuf out_buf = STRBUF_INIT;
>> +	char *out_prefix = xstrfmt("submodule '%s': ", submodule->name);
>> +	child.git_cmd = 1;
>> +	child.err = -1;
>> +	child.stdout_to_stderr = 1;
>> +
>> +	prepare_other_repo_env(&child.env_array, r->gitdir);
>> +	/*
>> +	 * submodule_create_branch() is indirectly invoked by "git
>> +	 * branch", but we cannot invoke "git branch" in the child
>> +	 * process because it does not let us set start_name and
>> +	 * start_oid separately (see create_branches_recursively()).
>
> Probably clearer to enumerate the 3 different pieces of information
> needed: the name of the branch to be created, the OID, and the name of
> the branch that would be used for tracking purposes.

Makes sense. Also the comment on create_branches_recursively() doesn't
do a great job of explaining why we need the additional piece of
information (tracking name), so I'll tidy them up together.

> An argument could be made that "git branch" should be extended to be
> able to take in these 3 different pieces of information, but it also
> makes sense to put this functionality in submodule--helper for now,
> since the whole thing is marked as experimental.

Yes, I considered this, but I can't think of a good reason to expose
this functionality to users - users can set their upstream with the more
intuitive "git branch --set-upstream-to".

>> +/*
>> + * Creates a new branch in repository and its submodules (and its
>> + * submodules, recursively). Besides these exceptions, the parameters
>> + * function identically to create_branch():
>> + *
>> + * - start_name is the name of the ref, in repository r, that the new
>> + *   branch should start from. In submodules, branches will start from
>> + *   the respective gitlink commit ids in start_name's tree.
>> + *
>> + * - tracking_name is the name used of the ref that will be used to set
>> + *   up tracking, e.g. origin/main. This is propagated to submodules so
>> + *   that tracking information will appear as if the branch branched off
>> + *   tracking_name instead of start_name (which is a plain commit id for
>> + *   submodules). If omitted, start_name is used for tracking (just like
>> + *   create_branch()).
>> + *
>> + */
>> +void create_branches_recursively(struct repository *r, const char *name,
>> +				 const char *start_name,
>> +				 const char *tracking_name, int force,
>> +				 int reflog, int quiet, enum branch_track track,
>> +				 int dry_run);
>
> Instead of taking in "name", "start_name", and "tracking_name", could we
> take in "name", "oid", and "tracking_name"? That way, it's clearer what
> each parameter is used for.

I used start_name to mirror create_branches(), but start_name makes less
sense here because it's ambiguous.

Since the start_name is always an oid or NULL, this makes sense. I'll do
this.

>> +test_expect_success 'should not create branches in inactive submodules' '
>> +	test_when_finished "reset_test" &&
>> +	test_config -C super submodule.sub.active false &&
>> +	(
>> +		cd super &&
>> +		git branch --recurse-submodules branch-a &&
>> +		git rev-parse branch-a &&
>> +		test_must_fail git -C sub branch-a
>> +	)
>> +'
>
> The "test_must_fail" line doesn't make sense - there is no such command
> branch-a. To avoid errors like this, maybe make sure that all
> test_must_fail invocations are accompanied by assertions on the error
> message. (And for "test_must_fail git rev-parse", we could have a helper
> function here that asserts the "object not found".)

Ah good catch. I'll make the test helper.

>
>> +test_expect_success 'should set up tracking of local branches with track=always' '
>> +	test_when_finished "reset_test" &&
>> +	(
>> +		cd super &&
>> +		git -c branch.autoSetupMerge=always branch --recurse-submodules branch-a main &&
>> +		git -C sub rev-parse main &&
>> +		test "$(git -C sub config branch.branch-a.remote)" = . &&
>> +		test "$(git -C sub config branch.branch-a.merge)" = refs/heads/main
>> +	)
>> +'
>
> As described in t/README line 671, this means that the inner command
> could silently fail. You can do `REMOTE=$(...) &&` <newline> `test ...`.
> Same comment throughout this file.

Thanks for the catch and double thanks for the recommended fix.

Will reroll soon.
