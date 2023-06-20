Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10D38EB64D7
	for <git@archiver.kernel.org>; Tue, 20 Jun 2023 09:22:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232218AbjFTJWw (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Jun 2023 05:22:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232033AbjFTJWv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jun 2023 05:22:51 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A658F1
        for <git@vger.kernel.org>; Tue, 20 Jun 2023 02:22:50 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id 5614622812f47-38e04d1b2b4so3112273b6e.3
        for <git@vger.kernel.org>; Tue, 20 Jun 2023 02:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687252969; x=1689844969;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=G5dUaV1dG5H5BAG2sbdqoRuHaKCy/OHkEJdIP3ONmxg=;
        b=m+GTIVQnIs/KukBCY/c2ZLJ1+YwVnsxbF5fNEQkw5pTLz3Hhz05xRA+IMcwASAMSz8
         THr/1gzr3je2FNvvTe+7A20b1oVyOxdg+NBfK+lsg192bbL/tjC/3aIHaDxtAMYLZa7V
         lTsEJ2hCLtmFPrH3vjulslmArkMfl0PoYsA75ZIHnfIVc6C5vafP07bZ2a+tyGGYn8v+
         Mip/E2L9E2ay0o4XMcYS+pw8B05D5O7nFvSOcqDyAiHGVWxHHveiPPYd+m3ClyFY/Une
         jyHIYhDd4gl5mieA9h9LQBjdoY4g9MJKRhTU2hURtrH/T84Bh6l42OQsGFEMMu59Sj6m
         9+hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687252969; x=1689844969;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=G5dUaV1dG5H5BAG2sbdqoRuHaKCy/OHkEJdIP3ONmxg=;
        b=GfMu8CEvvT6fp4DEGkZrQOuE6rqLZjKP2tolKRYkgpscCriyNYya6xQlkxEoH1DZ8T
         4Pvn9IPIYgkBnDJZPUhfFTOT738dqM5+s0eVUwI2FdshkZWNZqYis65Qv7SHUVlW3Ntf
         mq4O/b7+o9IDmI3057KN7ut7Pqg0HOgdgCjQmbtCGvXzWxIzMljdGgzitXBkTXw5Ji7I
         Ygyfk8UzeB/NSB54FJDyJmBf+FDlTn9jN3Z0cjRFMGqMkpP/CIjO4FcWDaCw7HoJOe5c
         CUvbZYuhwDPWUa1VoFNn38ibiBjP6gnhzRSwnkp/shd5vHkt8deocxY8ixqopEwKqGY/
         MhLQ==
X-Gm-Message-State: AC+VfDxidWNomf9CUqZSrOoSAl7kRpbOOEqDY1v3dZyyJjV5H42upRvf
        kyVUP8TvBN/P5qPm7fTRWo8/lRegRGb3vOreCjxiIu9iLhD+VA==
X-Google-Smtp-Source: ACHHUZ69RJJB2+AppzRICJDzLIIVQAKconKegX5MuakFvD35yWRxK1ePlotA626KMAAp+VJ0MzDcdQvHMBC5gkM0Z1I=
X-Received: by 2002:a05:6808:3009:b0:396:4977:e148 with SMTP id
 ay9-20020a056808300900b003964977e148mr15318831oib.9.1687252969273; Tue, 20
 Jun 2023 02:22:49 -0700 (PDT)
MIME-Version: 1.0
From:   Karthik Nayak <karthik.188@gmail.com>
Date:   Tue, 20 Jun 2023 11:22:23 +0200
Message-ID: <CAOLa=ZRumrpfG8FxQQG=Q8tGvxEapMvOx6SZyRPh0GSpn5iuUg@mail.gmail.com>
Subject: [Bug?] Information around newlines lost in merge
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When merging two files which contain newlines at the end, the blob
created (with conflicts) is the
same as two files created without newlines at the end.

We can demonstrate the same using this simple script which uses
`git-merge-tree(1)`. The script
creates two files in master, newBranch and then merges the tree. The
created files seem to have
the same content, eventhough the source files differed by newlines.

#!/usr/bin/env bash

git init
git commit --allow-empty -m "base commit"

git branch newBranch

echo -ne "\nA\n" > newline
echo -ne "\nA" > half
git add .
git commit -m "master commit"

git checkout newBranch

echo -ne "\nB\n" > newline
echo -ne "\nB" > half
git add .
git commit -m "branch commit"

treeOID=$(git merge-tree master newBranch | head -n1)
halfOID=$(git cat-file -p $treeOID | grep half | awk '{print $3}')
newlineOID=$(git cat-file -p $treeOID | grep newline | awk '{print $3}')

if [[ $halfOID == $newlineOID ]]; then
     exit 1
else
     exit 0
fi

Is this expected behavior? Shouldn't the two merged files (newline,
half) differ? i.e., shouldn't the file (newline) with newlines at the
end
contain an extra newline compared to the file without the newline? (half).

If this is expected behavior, what would be the best way to
differentiate the two? This is not a bug introduced, but rather the
behavior since,
the start, which makes me think that I'm missing something (verified
via git bisect on latest git).

The context of this is that it is hard to programmatically resolve
conflicts without loosing information, since we don't know if there
should
be a newline suffix in the file or not.
