Return-Path: <SRS0=C4D3=4R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA0A0C3F2D9
	for <git@archiver.kernel.org>; Sat, 29 Feb 2020 04:49:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD8CA246B0
	for <git@archiver.kernel.org>; Sat, 29 Feb 2020 04:49:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DdrDU0i0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726880AbgB2Etz (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Feb 2020 23:49:55 -0500
Received: from mail-qt1-f170.google.com ([209.85.160.170]:40671 "EHLO
        mail-qt1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726046AbgB2Etz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Feb 2020 23:49:55 -0500
Received: by mail-qt1-f170.google.com with SMTP id v25so3713132qto.7
        for <git@vger.kernel.org>; Fri, 28 Feb 2020 20:49:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=gAJgBTnEXXhVkDmVmIDpWCjMtzF9HNv3x8vL0UiTNjE=;
        b=DdrDU0i0tyehy76h7G+iq2P+gHHESGUZipkVaB1eI9EeoKEqM21cwy3x/BsVzLc8cT
         MKXr6qYXsQS820+WBAYco1Y7rwzYKA7cBXJR8lIQsmBb7BIy6Y4irIhjcZn2LB/XhSyB
         zaB4IvQCrfJ8JijyaEuj31IJ+fMdhni6AgqDnvpmyqt0dq+YiCEQgI4YtGEFM2PcZDhD
         t/ed1D8TCihb10m3VDaMgX4JjogRoXXRtdiSkjpaic0QISdF+C5Nui/pVKM2aOMSdPrK
         0EWKl7Pcb3MWEZ3SMldndiThbvw6TvU1OGR63OWX3R4ti8zWS1l6KniJsp5WzLZW6lgO
         YbmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=gAJgBTnEXXhVkDmVmIDpWCjMtzF9HNv3x8vL0UiTNjE=;
        b=YppDboMgMk49DAymMKzJKHDp3WiJr4g52OAchg+XRK5pAUGog34lzdMOKiA9T+2lXu
         0pKxgG0psRkLboSPBpl8xLMBFnUdYeeM0hxE+OVjvh0ATXhpt+awpX/hHX4nernpOJjg
         BCOM74KlAWaHB4nEHkR/nY1MKFN3dQZaDopJezixAcexB4i9ctJWwUUZcwqjwgmt+Qh/
         SNA8NyahYO7Y/nMZJhsdI/QNeHyFveosacdNYdZBjk8VzF8ZCnIq3fZjvgHvBrv5O4LL
         nMaCJ+8HOI9PWN7QVCoVURtH6grVAMSOfAFMi+cUx2PDbiAJR0UUg04WNJIT8IJrwf3h
         WEnQ==
X-Gm-Message-State: APjAAAU5NhXsouDsQZD35SRkAacLKveIY2VbGLZDeU73mkaKxObWqlj1
        UoCXzXRGTvoe4e1OTM6yW4Onci1+Q5UNx24XOzX/WznG
X-Google-Smtp-Source: APXvYqxy3VaED1SyP22mZjaQO3io6qtjYCgheih/oFMxPQcIyafg7NW17IAK6hHSOpmdnUQvRhtBBgAopIg46c61Seg=
X-Received: by 2002:ac8:42d7:: with SMTP id g23mr7006129qtm.206.1582951794123;
 Fri, 28 Feb 2020 20:49:54 -0800 (PST)
MIME-Version: 1.0
From:   Chris Jerdonek <chris.jerdonek@gmail.com>
Date:   Fri, 28 Feb 2020 20:49:43 -0800
Message-ID: <CAOTb1wfXp+gXSwbG-CVgVE8E_5yzxQKwNKh_=3ECqTMvZFw7dQ@mail.gmail.com>
Subject: ambiguous git-reflog output for symbolic refs
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I encountered some output that seems unexpected and ambiguous to me
when calling git-reflog on a symbolic ref.

Specifically, if the symbolic ref has no reflog of its own, then
git-reflog shows the reflog of the symbolic ref's target, but with the
symbolic ref's name in the output lines. This means you can't tell if
the reflog entries are from the symbolic ref's reflog, or from the
symbolic ref target's reflog:

To illustrate, create a symbolic ref pointing to a branch (this is
using git version 2.25.0):

$ git update-ref -m AAA refs/heads/test-branch
931dd4e7f267865e8077ae47c75888fe5d1b2755
$ git symbolic-ref refs/my-symbolic refs/heads/test-branch

Now, the git-reflog command below shows the log entries for
refs/heads/test-branch:

$ git reflog refs/my-symbolic
931dd4e (HEAD -> master, refs/my-symbolic, test-branch)
refs/my-symbolic@{0}: AAA

But if we ensure that refs/my-symbolic has its own reflog, e.g. by doing this:

$ git update-ref -m BBB --create-reflog refs/my-symbolic
931dd4e7f267865e8077ae47c75888fe5d1b2755

Then running the same git-reflog command as above now shows the
symbolic ref's reflog instead of the target's:

$ git reflog refs/my-symbolic
931dd4e (HEAD -> master, refs/my-symbolic, test-branch)
refs/my-symbolic@{0}: BBB

(The ref is still a symbolic ref pointing to "test-branch" as you can
see below.)

$ git symbolic-ref refs/my-symbolic
refs/heads/test-branch

To recap, looking at the two git-reflog outputs above, there's no way
to tell from the output which of the two cases you're in (the symbolic
ref's reflog or the target's).

So my question is: Is this behaving like it should? I was surprised
that git-reflog dereferences the symbolic ref prior to querying the
reflog, and even more surprising, replaces "refs/heads/test-branch" in
refs/heads/test-branch's reflog with "refs/my-symbolic".

And either way, is there a way to get unambiguous output? For example,
is there a way to make sure you're reading the symbolic ref's reflog
and not the reflog of its target?

Thank you,
--Chris
