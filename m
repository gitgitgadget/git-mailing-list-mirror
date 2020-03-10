Return-Path: <SRS0=Lnee=43=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61050C10F27
	for <git@archiver.kernel.org>; Tue, 10 Mar 2020 14:50:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37B952146E
	for <git@archiver.kernel.org>; Tue, 10 Mar 2020 14:50:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vh/Fy+P0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727070AbgCJOug (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Mar 2020 10:50:36 -0400
Received: from mail-lf1-f43.google.com ([209.85.167.43]:41672 "EHLO
        mail-lf1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726378AbgCJOug (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Mar 2020 10:50:36 -0400
Received: by mail-lf1-f43.google.com with SMTP id q10so10382133lfo.8
        for <git@vger.kernel.org>; Tue, 10 Mar 2020 07:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=RNHJStAubIILG3f1rmGaOa/1vff3fq5e/jKizq1VlRw=;
        b=vh/Fy+P0Kq9gwkb4zx632jWLsClq2aru2nTt8vMfUZZ+2brpqjxRemRBhgxkCB0cOI
         zBlKh1s04rFVngOGM4lQvtk7zmzcI0sndpFbDVfdZ+UwkplVD9wC40qxSX77csgzyolA
         2RA4Du27d2LZRhce+CJzSSTluMJwHzerecfjByw3XGse9I7KC76435TpPjxufE5UdxAa
         N9rKzhB2cIKvIk85zygbopgQbtBZQ7CQMa4gW8fFs6AiMt6h7KsNOnIjkP8OqlTYlb1z
         H+2jvSZhRyCXlDGn15+mMT10Mei8lWa+UjD8diB5A8Q5Z+kzFwTfznwhnuBITlqntOeE
         +CLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:user-agent
         :mime-version:content-transfer-encoding;
        bh=RNHJStAubIILG3f1rmGaOa/1vff3fq5e/jKizq1VlRw=;
        b=kE2ie+77u87D5TkMxEOVBKZAbAWqg9CHHkXEdbO4ntEJTRdvK6Pxc0dJ4paNeqctik
         EuqewO4xBX/WppW8xy6tKL2MdFt/O4zmD4amOijXzxkhIrJieXpvX/S4nacqCpIZIgCu
         xmbrmPtlATTQTItNJejX+ZVjueopQcQdX8paEH4Wc4WaxC0cpSCsWS9A+Z0m/ZpuRmXM
         dP4jr35HIFJKZC1dsAKv8iI+GE5+Fpc/c7u2o/E1rngOmn4VFwSuVx7y4kXFcgyiXaX1
         s/oJGmaVXzPfDonFZPLuE52fY2LY9o/tzHT6IGiR4Y1TxsexfXf60jA8nWchXfnxACw+
         IQZQ==
X-Gm-Message-State: ANhLgQ0HxSRsev+0zSYP3OyRqd5sYuvfw+2gNIoHlVuDN72KAgD/SMLr
        /lbqEOXvrsLrAoQN4QQlgMM=
X-Google-Smtp-Source: ADFU+vuHg0s2HMrYHfA8J2eV4M5r8Zb1GOcwn74TlxUFYM+vHIYZm2B00eAm/5K5MYzsDGH4V/z57g==
X-Received: by 2002:a05:6512:6c7:: with SMTP id u7mr13221709lff.176.1583851831873;
        Tue, 10 Mar 2020 07:50:31 -0700 (PDT)
Received: from Laptop-Acer-Aspire-F15 ([158.75.2.130])
        by smtp.gmail.com with ESMTPSA id b3sm3826135ljj.46.2020.03.10.07.50.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 10 Mar 2020 07:50:31 -0700 (PDT)
From:   Jakub Narebski <jnareb@gmail.com>
To:     git@vger.kernel.org
Cc:     Christian Couder <christian.couder@gmail.com>
Subject: [RFC] Possible idea for GSoC 2020
Date:   Tue, 10 Mar 2020 15:50:24 +0100
Message-ID: <86mu8o8dsf.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

Here below is a possible proposal for a more difficult Google Summer of
Code 2020 project.

A few questions:
- is it too late to propose a new project idea for GSoC 2020?
- is it too difficult of a project for GSoC?

Best,

  Jakub Nar=C4=99bski

--------------------------------------------------

### Graph labelling for speeding up git commands

 - Language: C
 - Difficulty: hard / difficult
 - Possible mentors: Jakub Nar=C4=99bski

Git uses various clever methods for making operations on very large
repositories faster, from bitmap indices for git-fetch[1], to generation
numbers (also known as topological levels) in the commit-graph file for
commit graph traversal operations like `git log --graph`[2].

One possible improvement that can make Git even faster is using min-post
intervals labelling.  The basis of this labelling is post-visit order of
a depth-first search traversal tree of a commit graph, let's call it
'post(v)'.

If for each commit 'v' we would compute and store in the commit-graph
file two numbers: 'post(v)' and the minimum of 'post(u)' for all commits
reachable from 'v', let's call the latter 'min_graph(v)', then the
following condition is true:

  if 'v' can reach 'u', then min_graph(v) <=3D post(u) <=3D post(v)

If for each commit 'v' we would compute and store in the commit-graph
file two numbers: 'post(v)' and the minimum of 'post(u)' for commits
that were visited during the part of depth-first search that started
from 'v' (which is the minimum of post-order number for subtree of a
spanning tree that starts at 'v').  Let's call the later 'min_tree(v)'.
Then the following condition is true:

  if min_tree(v) <=3D post(u) <=3D post(v), then 'v' can reach 'u'

The task would be to implement computing such labelling (or a more
involved variant of it[3][4]), storing it in commit-graph file, and
using it for speeding up git commands (starting from a single chosen
command) such as:

 - git merge-base --is-ancestor A B
 - git branch --contains A
 - git tag --contains A
 - git branch --merged A
 - git tag --merged A
 - git merge-base --all A B
 - git log --topo-sort

References:

1. <http://githubengineering.com/counting-objects/>
2. <https://devblogs.microsoft.com/devops/supercharging-the-git-commit-grap=
h-iii-generations/>
3. <https://arxiv.org/abs/1404.4465>
4. <https://github.com/steps/Ferrari>

See also discussion in:

<https://public-inbox.org/git/86tvl0zhos.fsf@gmail.com/t/>
