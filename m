Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29EBAC433E0
	for <git@archiver.kernel.org>; Wed,  3 Mar 2021 06:42:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D3E7A64ED0
	for <git@archiver.kernel.org>; Wed,  3 Mar 2021 06:42:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1448758AbhCCGfl (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Mar 2021 01:35:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbhCBXeA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Mar 2021 18:34:00 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B28AC061756
        for <git@vger.kernel.org>; Tue,  2 Mar 2021 15:33:20 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id p1so2520666pgi.16
        for <git@vger.kernel.org>; Tue, 02 Mar 2021 15:33:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=9IuhOXk2BjzCyymfiApUeS+aRwiiDI2jMUV7vIaySx8=;
        b=sxMc0DIz0zvBYi6acklhNDc7L5O8h/1im29exT4JlzFbRvUCsRMpgiqsnYEBHP2Ljo
         SV45EdtHHbdFEETezmzX6aeEo1lrjMa1sj3SfcvSWPjDcFRFxB/ewt7ek/FZ4tzLuTVp
         Gws/r9G8jwIzY+o66NGxbUeFTq2fzpG36SqcVfpGnboeXcCn366XzFwh2OWwXVDRZ4Al
         DuGJ5KARzgW8jeLlGJ9GghgHbYxDMFoJVZ3SWZWfYskL2VWW/undEB3Ho0vqbpU8zMqi
         3eL2gB7n6eSyy4x4MWCXRIIqh48tQ7QQU6at1UjSm9WzYXl9ZZiJsUaRTE2ybI415Fwv
         r6Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=9IuhOXk2BjzCyymfiApUeS+aRwiiDI2jMUV7vIaySx8=;
        b=DGMRBewvlBvSuISoOktVtdI/ic1bvPckp33BMXPC74WhVTGzdzrLmcj9xGNaNcLi9I
         x19Wj9rUBHJKuJbc7//bEj7rpoSyN5J4NbSSCfWrS6Ls3vn1oSEEVjKrNojkyNeiJJu8
         O+5ReIdL4rczd9hU2r7f+9mQ6Bs8mVHgGeHG3cYaDqcc4AIgHMOhFlweo7nKnhvBMQun
         b7s0KfAltojg44KQMEjgIx/shPxnUDiH5N4MkX4My6obijWHlnAxEVnrESSiIpK8kQjA
         MgKOEck5uodf/NHsqE2YFsTrjICk9QPBrkVm9w19tWQ6Na0Ve8AFyv2kJD6jsWpGz6IH
         egag==
X-Gm-Message-State: AOAM531IJe4kDEVZUMpyb0uYr7XsD2GK55E9XniGA+HjihB3VbQ7ffIt
        op/4QL//L3TgcU+7vlGWDWKdnIrs8A7BidPv55Pr
X-Google-Smtp-Source: ABdhPJyxEggBD/jVfs61ANCHrKNocLA6A4CdX2HnsUhYmjtuugwqjFBJEdqPJAZog9j+RteOP+lMdKd6ycrWgKEqV3uG
Sender: "jonathantanmy via sendgmr" <jonathantanmy@twelve4.c.googlers.com>
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:902:9a48:b029:e1:268d:e800 with
 SMTP id x8-20020a1709029a48b02900e1268de800mr311629plv.69.1614727999674; Tue,
 02 Mar 2021 15:33:19 -0800 (PST)
Date:   Tue,  2 Mar 2021 15:33:14 -0800
In-Reply-To: <YD2ZQIRfcwGzpFuQ@google.com>
Message-Id: <20210302233314.43539-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <YD2ZQIRfcwGzpFuQ@google.com>
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
Subject: Re: [PATCH v7 15/17] hook: provide stdin by string_list or callback
From:   Jonathan Tan <jonathantanmy@google.com>
To:     emilyshaffer@google.com
Cc:     jonathantanmy@google.com, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Jonathan and I discussed this a little more offline and agreed to leave
> the implementation as is.
> 
> Jonathan had suggested "have one callback invocation apply to all hooks
> that are running now", either by having the callback iterate over the
> task queue or by having the run-command lib take the result from the
> callback and have *that* iterate over the task queue. The idea being,
> one pointer to one copy of source material is easier to handle than
> many.
> 
> I suggested that the callback's implementation of the second version of
> that, where the library takes care of the "and do it for each task in
> progress" part, would be pretty much identical to the callback's
> implementation as it is in this patch, except that as it is here the
> context pointer is per-task and as Jonathan suggests the context pointer
> is per-entire-hook-invocation - so there isn't much complexity
> difference between the two, from the user's perspective.
> 
> We also talked about cases where N=# of hooks > M=# of jobs, that is,
> where some hooks must wait for other hooks to finish executing before
> that could start. In this case, users' callback implementations would
> need to be able to start over from the beginning of the source material,
> and a long-running hook would block other short-running hooks from
> beginning (because the long-running hook would be confused by hearing
> the source material to its stdin again).

Yes - this (number of hooks greater than number of jobs allowed to run
in parallel) was the case in which my suggestion of not having
hook-specific state would not work. The case we were talking about is
when there's a large amount of dynamically-generated data to be
transmitted to the hooks' stdins and I was thinking that it would be
best anyway if the callback looped over all hooks as data was generated,
but it would not be possible to only do a single pass if the number of
hooks is greater than the number of jobs.
