Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0285A20209
	for <e@80x24.org>; Sat,  1 Jul 2017 15:24:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751865AbdGAPYm (ORCPT <rfc822;e@80x24.org>);
        Sat, 1 Jul 2017 11:24:42 -0400
Received: from mail-ua0-f180.google.com ([209.85.217.180]:34784 "EHLO
        mail-ua0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751805AbdGAPYl (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Jul 2017 11:24:41 -0400
Received: by mail-ua0-f180.google.com with SMTP id z22so90274810uah.1
        for <git@vger.kernel.org>; Sat, 01 Jul 2017 08:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=mime-version:from:date:message-id:subject:to;
        bh=eAB4eX3GPLZ4ZNdkBBS2uOttB7746ILkYTYo7BDCgMA=;
        b=IgCgd62NZMBhPABitC762w4gZYWXr/XWXM+vBUoTae6dkQtksgufIYLmFSW6yPrKHK
         um7l6G7kJuOfjjZO4Ov3oMIZpZ/RQQ2fXghDSS9PeA/9MStAOIVrX2pni5we+8divaCW
         3rCPbSLTzkPGNYM3M8p2wxyxdJ3OBCRT78DpM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=eAB4eX3GPLZ4ZNdkBBS2uOttB7746ILkYTYo7BDCgMA=;
        b=hMgBiCGy8GCZcYtP48ttTWY2sxDLO50uA9YDxCKbyVnkI5/BfBPdWzNegZgSuQEs+A
         AgDsauHnvth10kHivGiR7bYM3zf3l1RlW341jdG0feKa3An5B/KzMQzfIA1HwWrV9gMg
         +c+6tJt8VB8BOVdgy0B66Are+iNmfX8kNbWDu83wdM/oHBMLRtVmsmUOxAfAkRJjBERQ
         ES+ultNfJW/i4erGxHk8TRIKM1ATnC79k7YY+82vH5Qh9eqsmn2vDn8dppY3v0zkpLYn
         U8B7vunNWfSp17t5OiPr9qHeF5OitMkyOjHUY+Kxu6xxc5d7j/bWGFZ7u1WN0ZUVrRPs
         tBHw==
X-Gm-Message-State: AIVw1126FyUBIWd6r783hBejALIHr0KCo3VM8VAv0iD+u1OHgau8YhYl
        E8J5ee/3G0AHSJoDdF8ye8/Vel0datCQYX4=
X-Received: by 10.176.24.80 with SMTP id j16mr1270228uag.120.1498922680531;
 Sat, 01 Jul 2017 08:24:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.176.69.194 with HTTP; Sat, 1 Jul 2017 08:24:20 -0700 (PDT)
From:   Dan Kohn <dan@linuxfoundation.org>
Date:   Sat, 1 Jul 2017 11:24:20 -0400
Message-ID: <CAHv71zK5SqbwrBFX=a8-DY9H3KT4FEyMgv__p2gZzNr0WUAPUw@mail.gmail.com>
Subject: Request for git merge --signoff
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

https://github.com/coreinfrastructure/best-practices-badge is a user
of the https://github.com/probot/dco bot which checks that commits
have a signoff. The issue is that there is no `--signoff` option in
git for merge commits, which is a standard part of our workflow with
feature branches. Here is a workflow where we currently get stuck:

```sh
(master)$ git checkout -b feature-branch
# make some changes
(feature-branch)$ git commit -sam 'Adding features'
# Changes have occurred on master so need to add them for easier merge
(feature-branch)$ git fetch
(feature-branch)$ git merge origin/master
# Save default commit message
(feature-branch)$ git push
# This now fails the DCObot check because the merge commit is not signed.
```

This alternative workflow works, but is obviously tedious:

```sh
# First 3 steps are the same
(feature-branch)$ git merge origin/master
# Save default commit message
(feature-branch)$ git commit --amend -s
# Commit message now has signoff line
(feature-branch)$ git push
# This now passes the DCObot check.
```

Or, I could manually add the Signoff line to the proposed git merge
commit message, which would allow me to skip the `--amend` step.

Could you please add a `--signoff` option to `git merge`?

Probot issue reference: https://github.com/probot/dco/issues/13
--
Dan Kohn <mailto:dan@linuxfoundation.org>
Executive Director, Cloud Native Computing Foundation <https://cncf.io/>
tel:+1-415-233-1000
