Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60515C4332F
	for <git@archiver.kernel.org>; Thu, 27 Jan 2022 22:42:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244421AbiA0Wmv (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Jan 2022 17:42:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244912AbiA0Wmt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jan 2022 17:42:49 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70255C061714
        for <git@vger.kernel.org>; Thu, 27 Jan 2022 14:42:49 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id i8-20020a17090a718800b001b35ee7ac29so2708906pjk.3
        for <git@vger.kernel.org>; Thu, 27 Jan 2022 14:42:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=hRO9zbaGrGLPILcm6sEgpjcPNfgPs7Fe5GN6qNmSfKI=;
        b=PTAYP2EYwDk4M4jzn56CFXpEYrPuq45ebmvVG1yDLvDacek9WW8dAwdr3q7ZSZR1X9
         XgR9qItDHynffJqppMDnxuKEP74rg2SB2X7Ifg4tgd0eFxw7D1AST3RA5ey9faq2LaBG
         a8IRFHrK8XKlz651TTU+hZwDk/AjiL2xOoTE6Cw83uPROvEvc/fiHq+4BnWQam79zU3C
         821deiWHGwUAL4TnBAu0ikGSMJ/eUxV1o57PiRICgDkP80HCC9nrdATnkX1WcJaJLnTn
         6gKYIbfl3tTCF1CSVsapqKA58iZWN+Sjx+aBcVeE6SC2retnZqa8FRlylQRluTtnCta+
         /ksA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=hRO9zbaGrGLPILcm6sEgpjcPNfgPs7Fe5GN6qNmSfKI=;
        b=VUGilBkVZWg51zlVrKwSc82Nqq8q1l+9QZ5mAKp+PrUsTqcRmdRXOSufvQKyhrN6qe
         xhExC0QxFyGJeHQqKNmjZJuIUonmZxv4ZpIP0VKfRFu2wBH1C/aXOFSop8j/1vF7rA0g
         qxp8eHHu0fjSFUm8VK03MgSRNqh9JoaLQ+CRJc5iNegE1N1i9dLi9LSrjDAb8lHHc/ua
         JXq8aMcvmxmOrAXEXmjZbaOCoQP7EDEpNx4p2i3BcMjyp/7VdBDkklgIrolMDz1RhTHr
         7Aiy1X2U94USwSPfYKOvUlXxzJMIIXH0ibG8qCrz7y/QUw9SVeJW6Sp+0gb9iYh88EEu
         aBUQ==
X-Gm-Message-State: AOAM530XNkAF3q6Yit6f3axOYXzWisO1itOIIOOXi7i0pOncGK20XLSk
        FQEHwzPwAjGuOP8T/PUGnzhfrwP57Jq4zQ==
X-Google-Smtp-Source: ABdhPJye6bHXHI/c8CuXnSHwBVpXiKbuhWmE9EMdjV8EdArmy3aIR7Dfx+yHUw9mw1qh4G8jJ6N4zu/dmJjo6Q==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:902:db07:: with SMTP id
 m7mr5246852plx.102.1643323368904; Thu, 27 Jan 2022 14:42:48 -0800 (PST)
Date:   Thu, 27 Jan 2022 14:42:47 -0800
In-Reply-To: <kl6lr18szwxh.fsf@chooglen-macbookpro.roam.corp.google.com>
Message-Id: <kl6lk0ekn6l4.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <20220124204442.39353-6-chooglen@google.com> <20220127202918.3099460-1-jonathantanmy@google.com>
 <kl6lr18szwxh.fsf@chooglen-macbookpro.roam.corp.google.com>
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

Glen Choo <chooglen@google.com> writes:

> Jonathan Tan <jonathantanmy@google.com> writes:
>
>>> +/*
>>> + * Creates a new branch in repository and its submodules (and its
>>> + * submodules, recursively). Besides these exceptions, the parameters
>>> + * function identically to create_branch():
>>> + *
>>> + * - start_name is the name of the ref, in repository r, that the new
>>> + *   branch should start from. In submodules, branches will start from
>>> + *   the respective gitlink commit ids in start_name's tree.
>>> + *
>>> + * - tracking_name is the name used of the ref that will be used to set
>>> + *   up tracking, e.g. origin/main. This is propagated to submodules so
>>> + *   that tracking information will appear as if the branch branched off
>>> + *   tracking_name instead of start_name (which is a plain commit id for
>>> + *   submodules). If omitted, start_name is used for tracking (just like
>>> + *   create_branch()).
>>> + *
>>> + */
>>> +void create_branches_recursively(struct repository *r, const char *name,
>>> +				 const char *start_name,
>>> +				 const char *tracking_name, int force,
>>> +				 int reflog, int quiet, enum branch_track track,
>>> +				 int dry_run);
>>
>> Instead of taking in "name", "start_name", and "tracking_name", could we
>> take in "name", "oid", and "tracking_name"? That way, it's clearer what
>> each parameter is used for.
>
> I used start_name to mirror create_branches(), but start_name makes less
> sense here because it's ambiguous.
>
> Since the start_name is always an oid or NULL, this makes sense. I'll do
> this.

Rereading the code, I realise that start_name isn't guaranteed to be an
oid or NULL. When create_branches_recursively() is called at the root
level i.e. cmd_branch(), start_name is a user-given revision which
may or may not be an object id. In that scenario, tracking_name is NULL
to indicate that we would like to track start_name.

I can still pass only oids, but that would require parsing the revision
in cmd_branch() itself, and that seems like a violation of the layering
we have set up.

Instead, I'll try to find an accurate, but more descriptive name than
start_name.
