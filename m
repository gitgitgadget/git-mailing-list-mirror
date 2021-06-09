Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7872FC48BCD
	for <git@archiver.kernel.org>; Wed,  9 Jun 2021 18:20:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59E63613D7
	for <git@archiver.kernel.org>; Wed,  9 Jun 2021 18:20:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229517AbhFISWG (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Jun 2021 14:22:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbhFISWG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Jun 2021 14:22:06 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C332C061574
        for <git@vger.kernel.org>; Wed,  9 Jun 2021 11:20:11 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id 17-20020a630b110000b029022064e7cdcfso14855859pgl.10
        for <git@vger.kernel.org>; Wed, 09 Jun 2021 11:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=uOHR+raCsL5hGtegUZJvvx1DlwoUFPY/cUjI0T/xyv4=;
        b=VCg83OtdvOxrnWtSgrFI5G76WcI3MEb/O/VKdr7AlGtjwdj4FE3MquNGvH+hGiKOV8
         bip55EU6dWGpSVFAmV9FZaFKJkLHY1iRb+s5im+QDzyRrSAFohpJP0uQz64+oOp9xXiW
         CMzB3Eb5hCdmu4eCwIoQ/9NAX2D8Vl/Ruofs7V9UcU8VVSRCywi500UuV88t9+Wvx/Tm
         DhVPUBdUkKLGsZypICxT8bc9VYKT9xzNTKD/oqneBBqnwSodILqrd0qeh91UohTHbmWq
         masyqS12abH0nHBoA9/6mkyGB/OyCKtOxSibkkr3IkM7GsARt7teVilOG8p2ikOPdRNI
         kVtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=uOHR+raCsL5hGtegUZJvvx1DlwoUFPY/cUjI0T/xyv4=;
        b=JeMhfYa4jV9BwdimRbA5TpArreHL82WE/u4Afn3sAja7Tqt5aOLbggOl3PCXyLsH9L
         cKXaXPcioGiAF0qMxt61pavwkUTCgoNcvApJz7xME3tM0xOpTHP6IR5BK5BMlRQlfEgz
         n++ntiRJacxeBan6XBh6LlYZisMRkUZ0M9wsVeG4uK6MiDbgE5BrZ0cIBxDPsPUqErz2
         344+LP2kmSSWLW+RiAo/ZeHSrTf7Str0gmgHT0n4Y/2nzzJrJ0lgE9LtImgApUINPxy/
         V7MQKPnHrWkdCY6j5rXxEuk/43uzxZJVnsiTyWe0yJJ97FEnaInAWDsi+Lq6wX4Y8f4X
         Vk4A==
X-Gm-Message-State: AOAM53117Py+soPDllWt59t98HpgqC4U/WluwzUx5reRBNvmN3At+HhH
        QrQa/lPtz6Z3QpIXJhyInA2tQOYLIJFrOUHRemsl
X-Google-Smtp-Source: ABdhPJzbPBTF8OGPfdKwuLAoakZrL2m9+zLXsR4y/Pm2RFJCEqE9rwqLCcjFr+aBEfgXXykx5b58Vf8OuS0aWdJw390H
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:902:d483:b029:115:3e1c:649c with
 SMTP id c3-20020a170902d483b02901153e1c649cmr1020499plg.44.1623262810628;
 Wed, 09 Jun 2021 11:20:10 -0700 (PDT)
Date:   Wed,  9 Jun 2021 11:20:08 -0700
In-Reply-To: <xmqqk0n3k3g1.fsf@gitster.g>
Message-Id: <20210609182008.2401762-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <xmqqk0n3k3g1.fsf@gitster.g>
X-Mailer: git-send-email 2.32.0.rc1.229.g3e70b5a671-goog
Subject: Re: [PATCH v2 4/4] promisor-remote: teach lazy-fetch in any repo
From:   Jonathan Tan <jonathantanmy@google.com>
To:     gitster@pobox.com
Cc:     jonathantanmy@google.com, git@vger.kernel.org, me@ttaylorr.com,
        newren@gmail.com, emilyshaffer@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Jonathan Tan <jonathantanmy@google.com> writes:
> 
> >> by filling appropriate environ[] array to be run in a repository
> >> that is different from ours (which is "other repo" part of its name)
> >> not to want to even know which repository the "other" repo is?
> >
> > Good point. I'll update prepare_other_repo_env() to have a gitdir
> > parameter.
> 
> I actually meant that the function should take an in-core "repo"
> structure.

But that seems like we're passing much more than we need - we only need
the git_dir. Also, there is a function that wants to pass a literal "."
as the gitdir; if we do this, I'll have to check if there is still a
struct repository that we can pass that will result in the same gitdir.

> >> Object type and object sizes are something that you can
> >> safely express in plain text, would be handy for testing, and would
> >> not require too much extra code, I'd imagine.
> >
> > It would, but we can already use "git cat-file -s" (or -t) for that. The
> > helper is meant to test a specific code path wherein we access a
> > submodule object during a process running in the superproject.
> 
> I know, but can you use "git cat-file -s" to check the codepath you
> care about?  I do not think so.  Hence the suggestion.

I'm still not convinced that we'll need it in the future, but you're
right that it is not too much trouble. I'll add it in.
