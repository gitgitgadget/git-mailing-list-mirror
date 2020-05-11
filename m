Return-Path: <SRS0=tgTL=6Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12DC8C38A2A
	for <git@archiver.kernel.org>; Mon, 11 May 2020 00:29:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CECF0206B9
	for <git@archiver.kernel.org>; Mon, 11 May 2020 00:29:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GhFtqHic"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729255AbgEKAYJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 10 May 2020 20:24:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729193AbgEKAYJ (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 10 May 2020 20:24:09 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5B16C061A0C
        for <git@vger.kernel.org>; Sun, 10 May 2020 17:24:08 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id e6so6919088pjt.4
        for <git@vger.kernel.org>; Sun, 10 May 2020 17:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XBh7aFI+PYr65lnk71/XoQctvudozgw2NTsCBCG5O3I=;
        b=GhFtqHicSFaAALD0is+h+JNvljodxpHf8azSiUIHlNxzp3eRTWRvz8WCSNYN6flwrn
         n69Df7J92ISSNKMhM2KRd9CNR56SMqmCl3ZDoolXKOYGi7IOZeBV/SMM1OXRV6xZSStP
         UCjYze2si6C2R5hbZKcTRVq9NvAgtoPK7hzlD0+LOItLSkKiJ3/DG4AyamhHVo7Dgrvh
         nUAy6qyuw5lIpfM9zpeRFg6yPFFGrLUZa36gSx06qSsaXYIuttgHWQudfCSjCJl+zDYf
         sNxXM9mC2jsMHpOTuWkVioVU1HSg6LoT4PBNxBdD0tl31HxtUkQ/OhzD6NmwkNvLdK/g
         kM8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XBh7aFI+PYr65lnk71/XoQctvudozgw2NTsCBCG5O3I=;
        b=p5ZCg3bNHY8V7x6YaChiqAVAVc/6M1ULS3SIEXYVGrXQIsqCWN4eoD6AUO20hDgeoh
         RVlK/HW9f7P6RxRgs6Yw7vX5PWG5I3b/nUqPqt6WTITKvn8oN3VxoQapFK+NrOMQOVPD
         GcJvXUmD/MR5JE6KNYaK30+h+RF2WnTaKW+qxHgwafHwnmfkZF7vqwvniBlYf0Uis3mO
         1RyLDgxuAv6wzgFyjHIF0V3Y949xsSB9x8oCr7alPbwm7fNqsWzj9dq7RxnWDydATTxW
         0XdwdLuDvoo0s3+rn/zCsS5jlk3ajpzAg9LeqqsuCfWMNllyDw6MCi1ZNa+Jfr1Hb7ge
         lBTw==
X-Gm-Message-State: AGi0Pub/SK3HfDYNbByCpcClSbIbujXWpnj9OIsr5rzxJxmXnkKMwI+L
        JCVlfLkJ/BUskHR7+b+Q0JeTqIFW
X-Google-Smtp-Source: APiQypLrG8TeCCF4oQg5pLQjMZdoSGsLlJ8u9vKH+h7wzjFyVrLxXxEslh7S0Y6TX5U7DZ8bYP7B2A==
X-Received: by 2002:a17:90b:93:: with SMTP id bb19mr17597129pjb.134.1589156648454;
        Sun, 10 May 2020 17:24:08 -0700 (PDT)
Received: from localhost ([2402:800:6374:cedc:d509:3e82:1f34:e3c4])
        by smtp.gmail.com with ESMTPSA id w30sm7644302pfj.25.2020.05.10.17.24.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 May 2020 17:24:07 -0700 (PDT)
Date:   Mon, 11 May 2020 07:24:05 +0700
From:   =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
To:     "D. Ben Knoble" <ben.knoble@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: git check-ignore --verbose fails oddly when invoked via an alias
Message-ID: <20200511002405.GA16475@danh.dev>
References: <CALnO6CBiAy-Jf+q7Qr3rtV9wy3f7ySd0SgK1ckCZvz30ER3i6g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALnO6CBiAy-Jf+q7Qr3rtV9wy3f7ySd0SgK1ckCZvz30ER3i6g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2020-05-10 15:59:08-0400, "D. Ben Knoble" <ben.knoble@gmail.com> wrote:
> I have the following two aliases:
> 
>     ig = check-ignore
>     igv = !git ig --verbose

Your "git igv" is an alias to a shell command.

> $ pwd
> /Users/Knoble/write/junk-drawer/code
> $ g rev-parse --show-toplevel
> /Users/Knoble/write/junk-drawer

You're working on subdirectory of git worktree.

> $ tree -a sml-binary
> sml-binary/

[.snip.]

> $ cat sml-binary/.gitignore
> myprog
> myprog.amd64-darwin
> $ g check-ignore sml-binary/*
> sml-binary/myprog
> sml-binary/myprog.amd64-darwin
> $ g check-ignore --verbose sml-binary/*
> code/sml-binary/.gitignore:1:myprog sml-binary/myprog
> code/sml-binary/.gitignore:2:myprog.amd64-darwin sml-binary/myprog.amd64-darwin
> $ g ig sml-binary/*
> sml-binary/myprog
> sml-binary/myprog.amd64-darwin
> $ g igv sml-binary/*
> $ echo $?
> 1

In git-config(1), we've noted that:

           Note that
           shell commands will be executed from the top-level directory of a
           repository, which may not necessarily be the current directory.
           GIT_PREFIX is set as returned by running git rev-parse
           --show-prefix from the original current directory. See git-rev-
           parse(1).

Which is the parent directory of your "$PWD".

So, two below commands are equivalent:

	$ git igv sml-binary/*
	$ (cd .. && git check-ignore --verbose sml-binary/myprog sml-binary/myprog.amd64-darwin <and other files>)

From Git 2.23.0, Git allows recursive alias expansion:

	igv = ig --verbose

-- 
Danh
