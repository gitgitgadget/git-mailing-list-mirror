Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 820AEC433EF
	for <git@archiver.kernel.org>; Fri, 11 Feb 2022 03:18:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232438AbiBKDSE (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Feb 2022 22:18:04 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbiBKDSD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Feb 2022 22:18:03 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 653061105
        for <git@vger.kernel.org>; Thu, 10 Feb 2022 19:18:03 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id b5-20020a1709027e0500b0014ca986e6d8so2633025plm.13
        for <git@vger.kernel.org>; Thu, 10 Feb 2022 19:18:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Ij8cqt9xNHy6UBZ4rsoBD4/t5Qjv8QKEEkeLavYkqqA=;
        b=Fm0ANakfU5yqt87SO/im3LtuwIEbah/bwEaEmj+nDJKpSQuCYG+V7nZ35gDtgHpRqv
         kIEPHmi6yKeq+GHRCNk7xnUYb01JKV3UVIwaujGwxBSQ5hDxY0HNz7hzTdO7lh+4zDtY
         M3sPyPnhU+31GDRoOtvdjz09DGBUUmSpJi1apf6R9fHRKrMohfg3N4Onz+yHda+vz9Ug
         AUOuPRlb9vTrNAHWW0sZsuY77dhcwRTFvZqFaqWZ9YV3xZ2CTli6iD7XFAtLFPoEuC8A
         lfuO2Lf84M92Ibc+F9jIVFjVqPPbC/fyq9bBi0a3SUA1jmNFxHd/eRFyRasyY6u0utg/
         k9Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Ij8cqt9xNHy6UBZ4rsoBD4/t5Qjv8QKEEkeLavYkqqA=;
        b=PhdZRwvJBPr+pBGcYEwkrHCwHQDBOVutSaMl38mlLao+zWxZIHPmioGcvHBMEGxCy7
         fyfwvfAKMwDM6g/XTmJJaT1rd5hZmy+8lZGYFJs0zc7bRLUnhDFeqcNIwAH2zTLV1QTI
         ONN+K0Rc0IBfW8DzdrTRCdcuPNlqteWeyi2Lp8ZRq+VcwfASDBmLHEePMXaOwhRSUMv3
         kZ2/mEeTYjnSXwjbN83e4/GLlHYpAmTb8FgbzjuTVlw5LAFMLYcxFDpQDpBD7Cf1jrq9
         sbXV7RtVr1L62EgUjSTHOItfNRCYB3tlWOgxpnY1KkCe7VnFzlmR1x/TADdTRV8cBOho
         tZtQ==
X-Gm-Message-State: AOAM531yNGAUlMBdNCIoHJt6E6D6+AsOXpfDJuP1aufXdtRxtA8Df+yo
        9lqHE6GSmZrLTpn3tJ0/z/YRyBKa0WQl+g==
X-Google-Smtp-Source: ABdhPJwzuY+awy2e7E72z0rEIUP4PiM1SHhG6eK8Xxj/ezdSJ//kAcFjMAr4o5TaEcy+Cl7gndq/3j/iHCWi2Q==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a05:6a00:21c9:: with SMTP id
 t9mr10559850pfj.48.1644549482743; Thu, 10 Feb 2022 19:18:02 -0800 (PST)
Date:   Fri, 11 Feb 2022 11:18:00 +0800
In-Reply-To: <20220210230422.690368-1-jonathantanmy@google.com>
Message-Id: <kl6lo83edrbr.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <20220210230422.690368-1-jonathantanmy@google.com>
Subject: Re: [PATCH 8/8] submodule: fix bug and remove add_submodule_odb()
From:   Glen Choo <chooglen@google.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> Glen Choo <chooglen@google.com> writes:
>> add_submodule_odb() is a hack - it adds a submodule's odb as an
>> alternate, allowing the submodule's objects to be read via
>> the_repository. Its last caller is submodule_has_commits(), which calls
>> add_submodule_odb() to prepare for check_has_commit(). This used to be
>> necessary because check_has_commit() used the_repository's odb, but this
>> is longer true as of 13a2f620b2 (submodule: pass repo to
>> check_has_commit(), 2021-10-08).
>> 
>> Removing add_submodule_odb() reveals a bug in check_has_commit(), where
>> check_has_commit() will segfault if the submodule is missing (e.g. the
>> user has not init-ed the submodule). This happens because the
>> submodule's struct repository cannot be initialized, but
>> check_has_commit() tries to cleanup the uninitialized struct anyway.
>> This was masked by add_submodule_odb(), because add_submodule_odb()
>> fails when the submodule is missing, causing the caller to return early
>> and avoid calling check_has_commit().
>> 
>> Fix the bug and remove the call to add_submodule_odb(). Since
>> add_submodule_odb() has no more callers, remove it too.
>> 
>> Note that submodule odbs can still by added as alternates via
>> add_submodule_odb_by_path().
>> 
>> Signed-off-by: Glen Choo <chooglen@google.com>
>> ---
>> This bug only exists because we can't call repo_clear() twice on the
>> same struct repository. So instead of just fixing this site, an
>> alternative (and maybe better) fix would be to fix repo_clear(). If
>> others think that's a good idea, I'll do that instead.
>
> Reading the first paragraph of the commit message, I'm given the
> impression that this is the last site in which we attempt to add a
> submodule ODB as an alternate, but that is not true. This is indeed the
> last usage of add_submodule_odb(), but add_submodule_odb_by_path() still
> exists.
>
> I think the primary point of this commit is to fix a latent bug in
> check_has_commit(), and add_submodule_odb()'s role here is just hiding
> it. Its hacky behavior does not play a role.
>
> I would write the commit message like this:
>
>   submodule: fix latent check_has_commit() bug
>
>   check_has_commit() will attempt to clear a non-initialized struct
>   repository if initialization fails. This bug is masked by its only
>   caller, submodule_has_commits(), first calling add_submodule_odb().
>   The latter fails if the repo does not exist, making
>   submodule_has_commits() exit early and not invoke check_has_commit()
>   in a situation in which initialization would fail.
>
>   Fix this bug, and because calling add_submodule_odb() is no longer
>   necessary as of 13a2f620b2 (submodule: pass repo to
>   check_has_commit(), 2021-10-08), remove that call too.
>
>   This is the last caller of add_submodule_odb(), so remove that
>   function. (Adding submodule ODBs as alternates is still present in the
>   form of add_submodule_odb_by_path().)

Hm.. that is a good point, the commit message seems to promise more than
what it actually delivers. I'll take your suggestion, thanks!
