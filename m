Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C5B6A1F462
	for <e@80x24.org>; Mon,  3 Jun 2019 18:32:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726503AbfFCScO (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Jun 2019 14:32:14 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51706 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbfFCScO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Jun 2019 14:32:14 -0400
Received: by mail-wm1-f68.google.com with SMTP id f10so12275128wmb.1
        for <git@vger.kernel.org>; Mon, 03 Jun 2019 11:32:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MF6eDleGzIRfFtFjXv78IkpHdaU+bJ0ejoov5qzGDFc=;
        b=oMe1D8BTXsA6esxCFo5L8Deq7lIVwMINKkLlm4+EZWJVH7ZRHP2kbV+rogaMkDmdu0
         TyTESyQxmv8QAYck/BLfYcvNbiR6S+O66ahQpfjlmnKtk8d3V6zmE41IvpIPHYJl/ydX
         EIdg3YbG/ZOlIGCyL6PCzigQo2quQENwgpn3eCRY4fQJ2ThbNhmvl3zjuQY1H/U4esO9
         MUM89IdDhkcV88q2THIBfdMd+fy73QLVVxZmgR3CknDdVFaAtAezUxpUdgPC0Sup005y
         HbWG+MD7Xvpc70Ba/kU4bcTsv1AugrHHjI7KJD5xkmhPYdc72TyZqS6vBR4nBLyNYYOL
         uqxA==
X-Gm-Message-State: APjAAAVQxog4KRZjHrffHgG9BAdSm+2F3c5F8jOLbmMCp85M/v1KxTde
        rJYeOsL/2rxs6soun2+zge4Zr8Em60PDqSwkApw=
X-Google-Smtp-Source: APXvYqySiAoA1uPt0kXHddrGshHkeTOTPt0cSDG+rte2OGLAuljdb+bR9HRzWShzpDvF+LacIydHvDrd+wKJ8LnZW9g=
X-Received: by 2002:a05:600c:218d:: with SMTP id e13mr15361261wme.101.1559586732171;
 Mon, 03 Jun 2019 11:32:12 -0700 (PDT)
MIME-Version: 1.0
References: <ad2ff81a-d75e-1ac4-07d0-c807a2ed9e36@gmx.de> <CAPig+cSsNQDe-3GLnmvA+EPior=RSPETJDjkCc7X1qi6gWSGDQ@mail.gmail.com>
 <CACsJy8CxSN90-EfTpkd6RUHFVp2iGjZXokpMqw7Tf0EMXT5LfQ@mail.gmail.com>
In-Reply-To: <CACsJy8CxSN90-EfTpkd6RUHFVp2iGjZXokpMqw7Tf0EMXT5LfQ@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 3 Jun 2019 14:32:01 -0400
Message-ID: <CAPig+cQ0po+cqdqohkVqFyk=aowtjuYGM2J=31pFu6ZuPeAUFA@mail.gmail.com>
Subject: Re: worktree add already exists
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Ingo Wolf <ingo.wolf@gmx.de>, Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 3, 2019 at 5:47 AM Duy Nguyen <pclouds@gmail.com> wrote:
> On Sun, Jun 2, 2019 at 2:11 PM Eric Sunshine <sunshine@sunshineco.com> wrote:
> > On Mon, May 27, 2019 at 11:32 AM Ingo Wolf <ingo.wolf@gmx.de> wrote:
> > > I would like to attach an existing dir to git (make it a workdir) and
> > > then update the index with git reset and checkin the differences.
> >
> > I haven't thought through the possible ramifications, but the actual
> > implementation might be as simple as changing this code in
> > builtin/worktree.c:validate_worktree_add():
>
> Coming from "git clone" background I would still expect --no-checkout
> to abort on non-empty directory (i.e. we always start at a good known
> state). Maybe another option can be used in combination with
> --no-checkout for this. And do we want the same option in "git clone"?

Taking a potential use-case into account, it might be more appropriate
to compare this suggested behavior to git-init rather than to
git-clone. Say, for instance, someone downloads a "tarball" of a
project (with no .git/ directory), experimentally hacks on it for a
while and then decides that that work is worthy of being submitted to
the project as patches or a pull-request. One could imagine that a way
to accomplish this would be to "git clone ..." the project, and then
"git worktree add --no-checkout /path/to/my/hacking", followed by a
series of "git add ..." and "git commit ..." invocations to formalize
the changes into discreet commits.

This is analogous to how you might start hacking from scratch on a new
experimental project before you know if it will pan out, and before
you know if it will be worthy of placing under revision control. If it
does pan out, then you "git init" the existing populated directory,
and follow with a series of "git add ..." and "git commit ..."
invocations.

I'm not sure how common such a use-case is, though. I recall being in
such a situation once or twice over the years, but that's not
necessarily a good metric. So, I'm not suggesting that such a feature
should or need be added to git-worktree, but the above thought
experiment perhaps provides some context for possible behavior.
