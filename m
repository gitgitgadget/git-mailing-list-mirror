Return-Path: <SRS0=E3tc=7P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5799FC433E0
	for <git@archiver.kernel.org>; Tue,  2 Jun 2020 18:09:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 289702068D
	for <git@archiver.kernel.org>; Tue,  2 Jun 2020 18:09:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d8bd8ZQs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726373AbgFBSJK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Jun 2020 14:09:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725989AbgFBSJI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Jun 2020 14:09:08 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7493C05BD1E
        for <git@vger.kernel.org>; Tue,  2 Jun 2020 11:09:07 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id q25so4099573wmj.0
        for <git@vger.kernel.org>; Tue, 02 Jun 2020 11:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4NWb+hMliwytpXaEHCd+KM0+XZumcGHnn97YNcKut4I=;
        b=d8bd8ZQsx/xZ4IvPK4EzL7yX99Yul0USIu78p+fKeoKvVcRv9cp9b1XeBHrwzDM0IT
         2GwgJnOQUlCWLC1KXgfFhl7KRIghoIHr99yeJiQOKNKAQ9eHXBksBKLmwFnDL+dGELlc
         XCeh/RAuWdNlU/6+2Di/kuLsxTSEw/7Fk3PYvqNtG6z9jt/MxMiooMcQS+mZzTZC4d0V
         gTdIExeVGHQmyvx5f0XmcEbfZPyip8XL81g00BG25xBmoT5wNU4070C+cJbcMhAnWfil
         uby8qYcSwmKE88ftoxLLVS2Se+BW+eutSo1FJxkzY1O/JMNCEG6OEOZ5NBgJ2GTO34ak
         e21Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4NWb+hMliwytpXaEHCd+KM0+XZumcGHnn97YNcKut4I=;
        b=pSb6Vk6awm7hoKCQXWV7O0tz3xznMYe91q01ipTvGAEEOdddm/b1z/u2czKfJp6Iku
         clwazGK2TOJPvMc+oc5FoXQmMRmIlkGYrf4lz3ywmScquxDcMwIxjy6zgKoNU/MhogI3
         6cTJ0Ete5+Cr9SNNuhBufJeVcgVk0Qb8DYM+9YZpfpWS/Bz+uZTUW4CA4qC2uMnYVpn3
         xZ8XlstM9M9eNBey+rLiGaDoBQL2gK1pyj0/H/qnz9bMGIQkObYQRARVcOKkYparhKVe
         moGghNrsJOdbDrKYbhN5sJ6Wh16Q222YQNPv3wtmxEs9YSXaRxkqpVhQ9ixxyxG1qS/e
         i7yA==
X-Gm-Message-State: AOAM533EX+YQ/irLaCc4p+cmTuOU/NeXiJConOfEhlkY2tjRkOHnflM1
        vyTt39BsnAyL9jngac25j3XINABx
X-Google-Smtp-Source: ABdhPJy5NNf54Pjc56v2voOfQpPkqAi+nAF4g8+TcdGrjGhQG2YfwQv+/qGZCZMdFE/fqhMDosNMrg==
X-Received: by 2002:a1c:bc42:: with SMTP id m63mr5212035wmf.11.1591121346350;
        Tue, 02 Jun 2020 11:09:06 -0700 (PDT)
Received: from szeder.dev (78-131-14-185.pool.digikabel.hu. [78.131.14.185])
        by smtp.gmail.com with ESMTPSA id r2sm5112831wrg.68.2020.06.02.11.09.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Jun 2020 11:09:05 -0700 (PDT)
Date:   Tue, 2 Jun 2020 20:09:00 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] refs: implement reference transaction hooks
Message-ID: <20200602180900.GA11344@szeder.dev>
References: <1d1a94426f95d842e0e3ea6a1569c0c45239229c.1591086316.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1d1a94426f95d842e0e3ea6a1569c0c45239229c.1591086316.git.ps@pks.im>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 02, 2020 at 10:25:44AM +0200, Patrick Steinhardt wrote:
> The low-level reference transactions used to update references are
> currently completely opaque to the user. While certainly desirable in
> most usecases, there are some which might want to hook into the
> transaction to observe all queued reference updates as well as observing
> the abortion or commit of a prepared transaction.
> 
> One such usecase would be to have a set of replicas of a given Git
> repository, where we perform Git operations on all of the repositories
> at once and expect the outcome to be the same in all of them. While
> there exist hooks already for a certain subset of Git commands that
> could be used to implement a voting mechanism for this, many others
> currently don't have any mechanism for this.
> 
> The above scenario is the motivation for a set of three new hooks that
> reach directly into Git's reference transaction. Each of the following
> new hooks (currently) doesn't accept any parameters and receives the set
> of queued reference updates via stdin:
> 
>     - ref-transaction-prepared gets called when all reference updates
>       have been queued. At this stage, the hook may decide to abort the
>       transaction prematurely by returning a non-zero status code.
> 
>     - ref-transaction-committed gets called when a reference transaction
>       was transmitted and all queued updates have been persisted.
> 
>     - ref-transaction-aborted gets called when a reference transaction
>       was aborted and all queued updates have been rolled back.

The point of reference transactions is that they are atomic, and these
hooks must work together to ensure that.  This raises the question how
these hooks can be updated in an actively used repository.

Having multiple hooks means that they can't be updated atomically, and
git might invoke the new abort hook after the transaction was prepared
with the old hook.  Now, if there were a single 'ref-transaction' hook
(which gets the phase of the transaction ('prepared', 'committed' or
'aborted') as a parameter), then it could be updated atomically by
mv-ing it to place, but even that update can happen in between git
invokes 'ref-transaction prepared' and 'ref-transaction aborted'.

I suppose this issue could be addressed by a single hook which runs
during the whole transaction and some back-and-forth communication
through stdin/out between git and the hook.  However, this would, I'm
afraid, complicate both Git's handling of this hook and the hook as
well, so let's take a step back first: is this something we should
worry about in the first place?

> Given the usecase described above, a voting mechanism can now be
> implemented as a "ref-transaction-prepared" hook: as soon as it gets
> called, it will take all of stdin and use it to cast a vote to a central
> service. When all replicas of the repository agree, the hook will exit
> with zero, otherwise it will abort the transaction by returning
> non-zero. The most important upside is that this will catch _all_
> commands writing references at once, allowing to implement strong
> consistency for reference updates via a single mechanism.
> 
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  Documentation/githooks.txt       | 51 ++++++++++++++++++
>  refs.c                           | 67 +++++++++++++++++++++++-
>  t/t1416-ref-transaction-hooks.sh | 88 ++++++++++++++++++++++++++++++++
>  3 files changed, 204 insertions(+), 2 deletions(-)
>  create mode 100755 t/t1416-ref-transaction-hooks.sh
> 
> diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
> index 81f2a87e88..48f8446943 100644
> --- a/Documentation/githooks.txt
> +++ b/Documentation/githooks.txt
> @@ -404,6 +404,57 @@ Both standard output and standard error output are forwarded to
>  `git send-pack` on the other end, so you can simply `echo` messages
>  for the user.
>  
> +ref-transaction-prepared
> +~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +This hook is invoked by any Git command that performs reference
> +updates. It executes as soon as all reference updates were queued to
> +the transaction and locked on disk. This hook executes for every
> +reference transaction that is being prepared and may thus get called
> +multiple times.
> +
> +It takes no arguments, but for each ref to be updated it receives on
> +standard input a line of the format:
> +
> +  <old-value> SP <new-value> SP <ref-name> LF
> +
> +If the hook exits with a non-zero status, the transaction is aborted
> +and the command exits immediately. The
> +<<ref-transaction-aborted,'ref-transaction-aborted'>> hook is not
> +executed in that case.
> +
> +[[ref-transaction-aborted]]
> +ref-transaction-aborted
> +~~~~~~~~~~~~~~~~~~~~~~~
> +
> +This hook is invoked by any Git command that performs reference
> +updates. It executes as soon as a reference transaction is aborted and
> +after all reference locks were released and any changes made to
> +references were rolled back. The hook may get called multiple times or
> +never in case no transaction was aborted.
> +
> +The hook takes no arguments, but for each ref to be updated it

Nit: I found it a bit surprising to read about refs "to be updated" in
the description of the 'aborted' hook, because by the time this hook
is called the update has already been refused.  The same applies to
the 'committed' hook below as well.

> +receives on standard input a line of the format:
> +
> +  <old-value> SP <new-value> SP <ref-name> LF
> +
> +The hook's exit code is discarded by Git.
> +
> +ref-transaction-committed
> +~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +This hook is invoked by any Git command that performs reference
> +updates. It executes as soon as a reference transaction is committed,
> +persisting all changes to disk and releasing any locks. The hook may
> +get called multiple times or never in case no transaction was aborted.
> +
> +The hook takes no arguments, but for each ref to be updated it
> +receives on standard input a line of the format:
> +
> +  <old-value> SP <new-value> SP <ref-name> LF
> +
> +The hook's exit code is discarded by Git.
> +
>  push-to-checkout
>  ~~~~~~~~~~~~~~~~
>  
