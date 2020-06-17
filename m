Return-Path: <SRS0=YePV=76=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2568DC433E0
	for <git@archiver.kernel.org>; Wed, 17 Jun 2020 14:46:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0CA6820890
	for <git@archiver.kernel.org>; Wed, 17 Jun 2020 14:46:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726758AbgFQOqy (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Jun 2020 10:46:54 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:46192 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726328AbgFQOqy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Jun 2020 10:46:54 -0400
Received: by mail-io1-f67.google.com with SMTP id t9so2955017ioj.13
        for <git@vger.kernel.org>; Wed, 17 Jun 2020 07:46:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bcglo3YPFrQao8KqXOjNFlCtqSpfBmPTAh/Nek81IP8=;
        b=MXbLGhgyylDMLlZp7Z72K8gt7g0Av/FpJOhpMd1HvLkOsxECkSXv/JZvgQ8nvqiSoW
         Pu1ZCOWbkskvul1m5eQoR3d1dfd2pqyq/yqnvprMr+ymMxbQGyTxPzsDvPVuVd41D8h0
         NJT9R84z0S0hY3KJMA4JVsXKcXSOl9gHdm+2YHbIdiomZpZUEa7zHfjiUrrKSU6qi4gQ
         TrzHvy9LJKmBQk3vXeLWXG977+dd+j7O3hEzNGmu++2iXjvW0HUofr0+lmroOetfCYDA
         m0fcfrfOtfUc9+pZxLRn/3Q2IXWUqIWEORPFKtWGvnNqVgkjEv39CevJw00ooj4zLG8I
         aCZA==
X-Gm-Message-State: AOAM531RVuMsDyu+Ev/XCkA0A2SbLBR0NDeOujGyr5DO3JgL9H6e9lRa
        Kyw9kgdi6G8qLF4Ckxvqk9Y94Mc4djFCLuI6658=
X-Google-Smtp-Source: ABdhPJyHa/VfjzNGJpm9sRx0r++eaQUlNicBWZEiDHAvy6zyyETs6duKhCXPsgMcYM1JS85hV4W27YJRoF7Ddl/Ewi0=
X-Received: by 2002:a02:ce8a:: with SMTP id y10mr31848607jaq.136.1592405213093;
 Wed, 17 Jun 2020 07:46:53 -0700 (PDT)
MIME-Version: 1.0
References: <CAPyFy2AKSVQJtSY0RNgJDJ5k1P=-gjNXVjDgPh+CdghhZtJXDw@mail.gmail.com>
 <F0FBE3B6-0DF5-40A4-B1A3-18EF65D48FF3@icloud.com> <CAPyFy2Ar+OncJtgZZyAzxs0PkXy5rSU6ALS+MimK8x5TzWjLug@mail.gmail.com>
In-Reply-To: <CAPyFy2Ar+OncJtgZZyAzxs0PkXy5rSU6ALS+MimK8x5TzWjLug@mail.gmail.com>
From:   Ed Maste <emaste@freebsd.org>
Date:   Wed, 17 Jun 2020 10:46:40 -0400
Message-ID: <CAPyFy2CMSGwPgGLh2Jbfvuf8oRBcvZ1LRv-m7AVvPybtpEybnw@mail.gmail.com>
Subject: Re: git-subtree split misbehaviour with a commit having empty ls-tree
 for the specified subdir
To:     Tom Clarkson <tqclarkson@icloud.com>
Cc:     git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 20 Dec 2019 at 10:56, Ed Maste <emaste@freebsd.org> wrote:
>
> On Wed, 18 Dec 2019 at 19:57, Tom Clarkson <tqclarkson@icloud.com> wrote:
> >
> > > Overall I think your proposed algorithm is reasonable (even though I
> > > think it won't address some of the cases in our repo). Will your
> > > algorithm allow us to pass $dir to git rev-list, for the initial
> > > split?
> >
> > Is this just for performance reasons? As I understand it that was left out because it would exclude relevant commits on an existing subtree, but it could make sense as an optimization for the first split of a large repo.
>
> Yes, it's for performance reasons on a first split that I'd like to
> see it. On the FreeBSD repo the difference is some 40 minutes vs. a
> few seconds.

Following up on this old thread, I plan to revisit the optimization,
implementing something on top of your work in
https://github.com/gitgitgadget/git/pull/493. I might look at adding a
--initial flag to subtree split, having it essentially auto-detect a
revision to use as the value for --onto. For the common case of an
initial merge commit with two parents I think we can relatively easily
determine which is the subtree parent. If that's not sufficiently
general (or broadly useful outside of our context) we could just
create a helper script wrapping `subtree split` tailored to the
FreeBSD cases. We have something like 100 projects we're looking to
split, as part of our svn to git migration.
