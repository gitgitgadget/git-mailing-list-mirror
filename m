Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6955E77370
	for <git@archiver.kernel.org>; Sat, 30 Sep 2023 11:29:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234154AbjI3L3E (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 30 Sep 2023 07:29:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbjI3L3D (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Sep 2023 07:29:03 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18A7F113
        for <git@vger.kernel.org>; Sat, 30 Sep 2023 04:29:01 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-533c4d20b33so3427971a12.0
        for <git@vger.kernel.org>; Sat, 30 Sep 2023 04:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696073339; x=1696678139; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yURaXZv7cy4+QE9JmHhC9TqHAKidDbap/GP5WLMul54=;
        b=a2sBx7Iqfpj7tN4XbVzEWIRgiQKzyh4RskzrfLiDeXwAH8PK0xdkCAfONsIMgF4Ph0
         +JFcQIERPMQQJjpou2Kl2pFNvrPplN8Vssi0DRp7jOJjW2zVlgOLHnZMWceBVVOEJTCf
         wzlUyFHCIN6Kl72WHMGqXQ4u6WQtSiWPLB3UUpkvpbnoPGo0aRkU6IbqbKM5r28c94FR
         /POGi6/ljq/xsR6qViNEoXNDRvVqvAY8RSHC5jbBHnOwQeMg5dSYdPlAHd8mMyj3NVgn
         NNInL2z/r/XwCBeL/eoD3jJD20ye782+rqLxmpvEzm0yR1B4D+yvBnBObVr0JXmddSQ3
         6S2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696073339; x=1696678139;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yURaXZv7cy4+QE9JmHhC9TqHAKidDbap/GP5WLMul54=;
        b=MjT1x1l7n50qlayzQDQAwPyXe/cali0MQOkAuCsmDpag6E03BdFQc1ShWg5AKe2l+h
         M9vP36XueCgIi6vByrnNlMHz2y48ybRy5YgRASlKShA/opL201fBwKR3bj3ZSk63umJB
         X/RlXYrALhRq/zMoPj6Tedte/y1a8sc2F+BL5Bc6/Qccms+yGBpV2RT+5D7gWCd4IXSY
         0u/tKAyL0TmDi8rxY1/A4w+Am0UupqMEkSlvPgY3Nzpm5NMDQiUgFFMQc8UZb7G2vjLi
         eSz0txRkR9xNzBA7O9UTOD0ab+dPiQLp461xR8rbuNG0QQmRAQSTtNgFNI7oGPbD9y6v
         dpeQ==
X-Gm-Message-State: AOJu0Yxl7zDcKTwCmzaI0PfUu6SaS2B1uzX5XZ2vLHs3t8a5SK0IFxUh
        hoJTtEEJ/YjWihVY2sojdD5W2eboYELzhUMxMlw=
X-Google-Smtp-Source: AGHT+IHpW39PuCtQvPtKupYDqdhZhOND2Z1CZODbwf90lhcGQMOIvq0GxLA8ozgWCNZUoxvIwSoltA62/stU2nbjZII=
X-Received: by 2002:a05:6402:3491:b0:52e:3ce8:e333 with SMTP id
 v17-20020a056402349100b0052e3ce8e333mr7302742edc.18.1696073339078; Sat, 30
 Sep 2023 04:28:59 -0700 (PDT)
MIME-Version: 1.0
References: <CAAcHogVu+jrLdtEZi+Jx9d9gM5BvUF_nRVKEc4BsWCxCanL9Uw@mail.gmail.com>
In-Reply-To: <CAAcHogVu+jrLdtEZi+Jx9d9gM5BvUF_nRVKEc4BsWCxCanL9Uw@mail.gmail.com>
From:   Chris Torek <chris.torek@gmail.com>
Date:   Sat, 30 Sep 2023 04:28:47 -0700
Message-ID: <CAPx1GvcjvctrQ-w1MekBs7S+R_7=KhCLUQ915-JAnxEq=BE3iQ@mail.gmail.com>
Subject: Re: bug - Inconsistency of git status and branch, ./git/branches and ./git/HEAD
To:     Irina Gulina <igulina@redhat.com>
Cc:     git@vger.kernel.org, Tomas Tomecek <ttomecek@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Sep 30, 2023 at 4:06=E2=80=AFAM Irina Gulina <igulina@redhat.com> w=
rote:
> ... So the question is why 'git
> status' says "On branch master", but 'git branches' don't?

Although this seems weird, it is in fact normal.

This situation in Git -- where you are on a branch that does not exist --
is called an "orphan branch" or an "unborn branch" (which term is used
depends on which bit of documentation you read).

The unborn / orphan current branch becomes "born" (begins to exist)
once you make a commit while on it. If you move to a different branch,
the unborn branch never comes into existence.

A new, empty repository cannot have any branches, because a branch
is defined as "the latest commit that is on the branch" (this definition is
unsatisfyingly circular, but that too is what it is). With no commits in th=
e
repository, no branches can exist. Yet you must be "on" some branch.
Hence the existence of unborn branches, which are born when you
make a new commit. That first commit creates the first branch name
as well as the first commit.

Creating a new commit while on an unborn branch causes the new
commit to have no parent commit. This, too, is normal and natural
in a new empty repository, but it holds true for the situation in which
you create a new unborn / orphan branch using `git checkout --orphan`
or `git switch --orphan` while in a non-empty repository. You don't
normally want to do this, but it's sometimes useful for some special
oddball cases.

Chris
