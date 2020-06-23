Return-Path: <SRS0=IiYM=AE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 851C3C433DF
	for <git@archiver.kernel.org>; Tue, 23 Jun 2020 12:44:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 602672072E
	for <git@archiver.kernel.org>; Tue, 23 Jun 2020 12:44:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A215midI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732603AbgFWMo5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Jun 2020 08:44:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729504AbgFWMo5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Jun 2020 08:44:57 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F9D1C061573
        for <git@vger.kernel.org>; Tue, 23 Jun 2020 05:44:56 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id n24so23197583lji.10
        for <git@vger.kernel.org>; Tue, 23 Jun 2020 05:44:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=8EC/MY+ZvkoiwikeczT5mM+CVxlm6xcr/xpv1/QBXAA=;
        b=A215midIm4pblMPWESR5wzr4Snm33r4YbvMkHNTJ8YUjN4aX64/qC+bpeXPpD0nM27
         3W6V9PbO1AbCE4/4VwvvXWMgqi3uNtHOTcSuOSaDvCvnVac3VjPu70tNOQ45HIiNXw9e
         BXYwSy6BRMx/2+jBXNc8ujH3FgHd/Ofpzz4W/eU8KRTElrs1pBS6VUzKeUIuZN4UVKHg
         e1xnBc6o/YwKew/HrqM5IV5+5JMjF3ttG8CuM8JXdHkYJs1OsAx5sKjlJ/SSl/lBv25h
         hCYL9HeDxQKPCt5Xi5f//IOhGTcE/6sEgvi334bbXQ7XYX+cGlpuVDncsBkDhR2YP2MW
         64lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=8EC/MY+ZvkoiwikeczT5mM+CVxlm6xcr/xpv1/QBXAA=;
        b=s+Afs2+pNt5z101D/ImGjFnpPyEJEBVc7KhvKF7Yx5gJusgGHZnpbMvCeI7ab26iBd
         FZjal25qKe1ldBzU8HHoA6E1D5C6DmQpnlO5wRfsz8SMkv1QKXbpVirmdU8PEWsOn8ZK
         QhwTiTvXtXzxiWWkDSE00ioSHH7P/5susOlIBSTLU1FtmOPTzV+pUUgyD7vXtVkVDy4j
         qhOn7G7j6dFr3TkCo8cRV+ODxkW5k+yxk4Nrk51QIxGp6pool9Mro9w0GYJMJqyaJ44v
         wTwYDAMCnKiIcmUc+gw6wdUiSKWdeH9x1nbIfnBDY7Es9fJz+A6jZDkWedisDnw0IQ9U
         JHew==
X-Gm-Message-State: AOAM530ttvjwW0crYECnJESWFK65Rbsn5sQ6+o2jwe8tvnXkZWjrgc02
        Qkd6ZT4rBP7DnS2QwCRkWlY=
X-Google-Smtp-Source: ABdhPJxgrO3kTsdpIXWv0dPk27IzqzktuaQoSwUyZEfBwwtMtfXqVNiwwKF2LfHkooatoTJJSW8tfA==
X-Received: by 2002:a2e:891a:: with SMTP id d26mr11012892lji.384.1592916294957;
        Tue, 23 Jun 2020 05:44:54 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id p19sm3267218lji.113.2020.06.23.05.44.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2020 05:44:54 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Tiran Meltser <Tiran.Meltser@mavenir.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Amir Yosef <Amir.Yosef@mavenir.com>
Subject: Re: Request for adding a simple mechanism to exclude files from Git
 merge operation
References: <DM6PR11MB27958B80E3994CEEF13971ECE5990@DM6PR11MB2795.namprd11.prod.outlook.com>
        <20200622194122.GN6531@camp.crustytoothpaste.net>
Date:   Tue, 23 Jun 2020 15:44:53 +0300
In-Reply-To: <20200622194122.GN6531@camp.crustytoothpaste.net> (brian m.
        carlson's message of "Mon, 22 Jun 2020 19:41:22 +0000")
Message-ID: <871rm6x86y.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> On 2020-06-20 at 18:21:40, Tiran Meltser wrote:
>> Hi,
>> This topic is quite common in various use cases (e.g. production
>> configuration vs. staging one) and there are quite a few talks about
>> it in the web.
>> Nevertheless, there is no specific solution to this problem, only
>> partial workarounds (including the famous merge driver “ours”).
>
> In general, this is a hard problem.  When you perform a merge, you're
> asking to incorporate changes from both heads against a common merge
> base.  What does it mean when you want to merge two branches together
> but not make any changes?  Which version do you want, ours or theirs?

I believe we basically need support to apply different merge strategies
to different files.

I had similar problem a few times when I merged a long-standing branch
and, after I saw the result of merge, I was basically satisfied, except
I needed to revert a few sub-directories of the project (that gave huge
number of conflicts), to their original state, either of my current
branch, or of the branch being merged, depending on particular case. You
see, I knew exactly what I needed, yet I was not able to achieve my goal
without resorting to nasty kludges.

> Normally merges are symmetric, so if you want non-symmetric behavior,
> you have to define what it's supposed to be.

Yes, I'm ready to define what it's supposed to be. The problem is that
"git merge" won't let me, due to lack of support to apply different
merge strategies to different files.

As I see it, first step of improvements could be to support

  git merge -- <files>

where selected strategy applies only to <files>, and the rest of files
are kept intact (effectively applying "ours" strategy to them), along
with

  git merge --exclude=<files>

, to be able to exclude specific files (apply "ours" only to them)
rather than include.

[ As a side-note, please notice that after such changes, the "ours"
strategy could be deprecated (not that I think it should), as either:

   git merge <branch> --

or

   git merge --exclude=. <branch>

would do the trick. ]

The next step would then be to support

  git merge --force -- <files>

that would force to re-merge <files> with given strategy no matter what
their current status in the index is.

Even though such support would be enough for my specific use-case, it
doesn't provide suitable way to configure the default behavior. As a
more generic solution, a new syntax for "git merge" to specify what
merge strategy to apply to what files could be designed, and then
ability to put that syntax into a file for "git merge" to pick would
solve the problem of quasi-static configuration problem. Alternatively,
even more generic .gitignore way of doing things apparently could be
re-used to some degree by adding support for .gitmerge files.

-- Sergey
