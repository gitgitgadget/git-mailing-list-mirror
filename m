Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E520FC433EF
	for <git@archiver.kernel.org>; Thu, 10 Feb 2022 23:04:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244406AbiBJXEY (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Feb 2022 18:04:24 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239716AbiBJXEY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Feb 2022 18:04:24 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8670855BC
        for <git@vger.kernel.org>; Thu, 10 Feb 2022 15:04:24 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id s19-20020a170902b19300b00149a463ad43so2376351plr.1
        for <git@vger.kernel.org>; Thu, 10 Feb 2022 15:04:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:subject:from:to:cc;
        bh=Fe5UJKa1hXrDq2PZo1yFg/OI/zZZjGjDFnlFnvVGqM4=;
        b=s2Hr9YVQAeKK5+UXPGmDS/91FI50lcyv9/ic/0LHX6mL1h298RsbwhHNluYJ0YfBZR
         Rcm8S43Xg34u889ssJOjHwd7/lJh+tndO4D8z1kC2tKP16VMrQncq4ljJDTU8sjEJ/yh
         2UCGu1dvCyoEzzCoYeOXLfYluYkFYVjvqnyefMT+kPY8I1tP6I37Z9Dl+0jOOmvxBqJC
         IUo0dha4zCEueqCAe6kO8Dhg8/44NHa7FIuOlhUusJs94TXPjcZ2E6ewBX22Mw2ZHRH1
         ktcY2g/m/w22YI3hbxJ4I1psM+ZfE27rDuon4RrPJLnQQDhRI5XzefbvADJFtW294Rdo
         soHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version:subject
         :from:to:cc;
        bh=Fe5UJKa1hXrDq2PZo1yFg/OI/zZZjGjDFnlFnvVGqM4=;
        b=BjvrgC7ldjA7S4jiULOnzEx1zTqJmZsFRVgjM0ryNahOikACmYq0pqetCLRLNki4Dq
         ad0y6GJ7RdhyqDZrst07QeltmOSBcT3S6hn4U9m2yweaVG/u0nZ+qZw3W30rf9eYByW+
         zqZSfhPH4Ld0mWSU2/hOElSsrcPnN5K6+rvJo4yIsEfeQ+Y6QWjSsI0Ox+4nVWxbL6ig
         6Hy2IuELxNK5bg0RxB52LP07GGxSOsut7f/HEMkTSMS2mH4YIA2ZLyqLo+UBj4CCJrOM
         5/JHDAcgmZxl9cC8sDqy8oaxdfeCsHv73TNfWG4fug4vJSO8wEHVh1P2mWEd3X5ECjgQ
         x8hg==
X-Gm-Message-State: AOAM530mCJKm9qqrWc9+vFMzeHtKrELpmuC5w3OjRwvePkxw8sArSCaY
        IlDT8Fir4kIisWEUVAmM3VmkRVGIfsNe+rU+mxZD
X-Google-Smtp-Source: ABdhPJyAA7C1bTcFpExo7Im/AR9P9U/xVQ1XoozhkzxadrvCbkhaz6fyhOinomoDNu7IKtFiUnqIfD4wCg2+HXx4mCD8
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:90b:1642:: with SMTP id
 il2mr25742pjb.99.1644534264048; Thu, 10 Feb 2022 15:04:24 -0800 (PST)
Date:   Thu, 10 Feb 2022 15:04:22 -0800
In-Reply-To: <20220210044152.78352-9-chooglen@google.com>
Message-Id: <20220210230422.690368-1-jonathantanmy@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.1.265.g69c8d7142f-goog
Subject: Re: [PATCH 8/8] submodule: fix bug and remove add_submodule_odb()
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Glen Choo <chooglen@google.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Glen Choo <chooglen@google.com> writes:
> add_submodule_odb() is a hack - it adds a submodule's odb as an
> alternate, allowing the submodule's objects to be read via
> the_repository. Its last caller is submodule_has_commits(), which calls
> add_submodule_odb() to prepare for check_has_commit(). This used to be
> necessary because check_has_commit() used the_repository's odb, but this
> is longer true as of 13a2f620b2 (submodule: pass repo to
> check_has_commit(), 2021-10-08).
> 
> Removing add_submodule_odb() reveals a bug in check_has_commit(), where
> check_has_commit() will segfault if the submodule is missing (e.g. the
> user has not init-ed the submodule). This happens because the
> submodule's struct repository cannot be initialized, but
> check_has_commit() tries to cleanup the uninitialized struct anyway.
> This was masked by add_submodule_odb(), because add_submodule_odb()
> fails when the submodule is missing, causing the caller to return early
> and avoid calling check_has_commit().
> 
> Fix the bug and remove the call to add_submodule_odb(). Since
> add_submodule_odb() has no more callers, remove it too.
> 
> Note that submodule odbs can still by added as alternates via
> add_submodule_odb_by_path().
> 
> Signed-off-by: Glen Choo <chooglen@google.com>
> ---
> This bug only exists because we can't call repo_clear() twice on the
> same struct repository. So instead of just fixing this site, an
> alternative (and maybe better) fix would be to fix repo_clear(). If
> others think that's a good idea, I'll do that instead.

Reading the first paragraph of the commit message, I'm given the
impression that this is the last site in which we attempt to add a
submodule ODB as an alternate, but that is not true. This is indeed the
last usage of add_submodule_odb(), but add_submodule_odb_by_path() still
exists.

I think the primary point of this commit is to fix a latent bug in
check_has_commit(), and add_submodule_odb()'s role here is just hiding
it. Its hacky behavior does not play a role.

I would write the commit message like this:

  submodule: fix latent check_has_commit() bug

  check_has_commit() will attempt to clear a non-initialized struct
  repository if initialization fails. This bug is masked by its only
  caller, submodule_has_commits(), first calling add_submodule_odb().
  The latter fails if the repo does not exist, making
  submodule_has_commits() exit early and not invoke check_has_commit()
  in a situation in which initialization would fail.

  Fix this bug, and because calling add_submodule_odb() is no longer
  necessary as of 13a2f620b2 (submodule: pass repo to
  check_has_commit(), 2021-10-08), remove that call too.

  This is the last caller of add_submodule_odb(), so remove that
  function. (Adding submodule ODBs as alternates is still present in the
  form of add_submodule_odb_by_path().)
