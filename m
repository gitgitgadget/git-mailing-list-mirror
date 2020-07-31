Return-Path: <SRS0=dkLL=BK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50141C433DF
	for <git@archiver.kernel.org>; Fri, 31 Jul 2020 13:10:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2011C206FA
	for <git@archiver.kernel.org>; Fri, 31 Jul 2020 13:10:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WQSVcXCp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730881AbgGaNKy (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 31 Jul 2020 09:10:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730291AbgGaNKy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Jul 2020 09:10:54 -0400
Received: from mail-vk1-xa42.google.com (mail-vk1-xa42.google.com [IPv6:2607:f8b0:4864:20::a42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D449CC061574
        for <git@vger.kernel.org>; Fri, 31 Jul 2020 06:10:53 -0700 (PDT)
Received: by mail-vk1-xa42.google.com with SMTP id g22so6889962vke.9
        for <git@vger.kernel.org>; Fri, 31 Jul 2020 06:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=3IJnq5orCcJJS8NG9y67WRRsynldWkHdbJvx2LH0NJA=;
        b=WQSVcXCppKaMu7mnwBZ/YnpZE6bJGXk1ycSF0MW3vxvJwcMkdliw0wYbdVSrkeHgDJ
         1Golw30arMcYWZ09MiiCG8Ak2LsRxGEsX35pyF1FaIyQ1LD9hb4cC9JeTRKMbXVqF0tt
         VOlzyyYZWrk5BRd5gLYPoqAYVE8+IP4PpzZsPa1gWDfnFKxFEVmDcUOuq27F1rJhCpOo
         NTBuKbv8UHSMXooL6PJGkdOxIEtRHvTNkJh4WcVg6CiFILibeDKuJj/LbJBNfPwy/Aaa
         InT4XTobZmH4k9GiJYHlaa4wtbOrMcD5VMhtPc6v6m0lbsqJOJ9IbWrGZ81bli99c1oS
         khsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=3IJnq5orCcJJS8NG9y67WRRsynldWkHdbJvx2LH0NJA=;
        b=lqlmEjhHOwz4+ZkKYHRWWEfjCKJMDjSe2PELxJj4dhQdX6d/GLX3SAlQn0+0muvaoC
         7lD3hsN1PNquScTIHSiXIFcMKQc2s0mNXE7RswTFpnBwA0X1bymo+ddTS1cAK5do7IqF
         SUHYvV3BmhuxcDmKt9KmuEZzYvzSxKai0AopSJs9DnkCptvNapIGhwyIOKcx9Fw6wQKi
         eAgrwraTh7+aa4OhhGJmtdHcoaXM81forTUIV+YVSc2AUt63iHMv1uZ8ps2wxWIpTJ+E
         IPItrcqKelw6f8cgYCA7vCHBAcMB33AnCoux2QrIUKbr98AkM8VEnl7lOCQVBTjw7Xru
         LfpA==
X-Gm-Message-State: AOAM533vl4k/Aa1aKpNI33fg9PPbyNeT5zwvMCc26RwTs7GJFonkIf17
        z96JhoF0NWN/fKs9hTJeSZL1CQpUGk35eTi1ziNyJuw16o4=
X-Google-Smtp-Source: ABdhPJxP//MrCzDwjbQ/kNArwtB3opnnihwxuCtOK9oxNFn+WfQchXo3ls2EsA3U7i2cf1XMT1Ym4p0hRxF0pHo38g0=
X-Received: by 2002:ac5:c546:: with SMTP id d6mr2597308vkl.102.1596201052707;
 Fri, 31 Jul 2020 06:10:52 -0700 (PDT)
MIME-Version: 1.0
From:   Matt Rogers <mattr94@gmail.com>
Date:   Fri, 31 Jul 2020 09:10:44 -0400
Message-ID: <CAOjrSZtQPQ8Xxuz+7SGykR8Q-gFDEZANSE5yQASqKjpbUAq_5Q@mail.gmail.com>
Subject: Diff --stat for files that differ only in whitespace
To:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When using a repository with "core.autocrlf=false" I'm trying to run a diff
between two commits that have many files (~1000) changed that differ mostly
in line endings or other whitespace.  When I run
`git diff --stat --ignore-all-space <commit-1> <commit-2>` I'm getting an output
that has many files listed like:

some-file.txt | 0

This is easy enough to parse through when it's a small number of files but when
there is ~1000 files with only maybe 1500 insertions/deletions showing it's not
really useful to me to see a list of those 1000 files, if there was a way to
sort by number of insertion/deletions or filter out the files that had 0
effective changes that would solve my problem.


Simple example:

```
mkdir example && cd example
git init
git config --local core.autocrlf false
echo HELLO > file.txt
echo WORLD >> file.txt
git add file.txt
git commit -m "first kind of line endings"

<use an editor to swap out the line endings>
git add file.txt
git commit -m "second kind of line endings"

git diff --stat --ignore-all-space HEAD~1 HEAD
```

Thanks,
Matthew Rogers
