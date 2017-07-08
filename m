Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8942320357
	for <e@80x24.org>; Sat,  8 Jul 2017 01:17:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752123AbdGHBRz (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Jul 2017 21:17:55 -0400
Received: from mail-vk0-f48.google.com ([209.85.213.48]:36374 "EHLO
        mail-vk0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751659AbdGHBRy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Jul 2017 21:17:54 -0400
Received: by mail-vk0-f48.google.com with SMTP id y70so25748612vky.3
        for <git@vger.kernel.org>; Fri, 07 Jul 2017 18:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=Eti9YuCtz2KyJPqGpegQfZNKnL7GGyaSe5iZJDfhfvE=;
        b=RdkUW7sQv3r3se+YlA92Q9iM8gDm4QzDt6+05KFENMF1b45kiMe1CPnjltwa3kk+0h
         Q5s0wY7plUad274/pAr9rNRqXIzS8xyoES51BfzXgxsmH/czZdMA/bGovD4s57heEIXJ
         pzSPDIcMNkBU7d0VVDIFd1TUAhVqbWLtm5t+2GXpYIQxPFr+F4lWUPMn7vezqu5BSTzE
         6PWWogTqpIzkWCs8MgCVKR754ejSMHN8VH0fFJQWRsxVYVZXK4oJgbCb7lUwCQ7HVhCg
         E0Hv62H/eOqvxtLVqSKy1Z5NanqqxxczoQJpPu3w8YN8x9Tj/mbxd/BCfEdmtsuywir+
         Sw9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=Eti9YuCtz2KyJPqGpegQfZNKnL7GGyaSe5iZJDfhfvE=;
        b=a7xeDaq3+2hg2D1k50kOO6YXwaVDhW66iMfelwseFs/3EYuNIngIZiC+oZiXYKHKjW
         y0w4gM0Q4+ScB8lCgr3h/ht134o5CqasZCf4Dov3FiLgK+W0Nyem7SW0WLYWHQ262JY9
         CMBxlFE2P3EtNbV4FUE2t7yrTa803viyGfRDar+Jnm+hrBk32250E5j+DSLySSPcp9Jg
         +xKoNnmztCb89LDt9NjDjmWO6wmVsJt+tyj06ms+NmwlFClpHTh5oK3Csjoukbv3Zl2U
         PUQy+YVxA8JnsMFX36wjtDdKH5tvvWt211/HdRViihVbW1IbkB5TmohEwi14xtB4rGDn
         LqdA==
X-Gm-Message-State: AIVw112ZFQGXYfzX0bAhCN7KKYXiWUo9azpA5Y31NTlEuYaB3PaffiYM
        SIEYEAOgmRauTwGHSjhtgTbM0syIuWf3
X-Received: by 10.31.168.20 with SMTP id r20mr1959861vke.129.1499476673156;
 Fri, 07 Jul 2017 18:17:53 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.103.81.70 with HTTP; Fri, 7 Jul 2017 18:17:32 -0700 (PDT)
From:   Marko Kungla <marko.kungla@gmail.com>
Date:   Sat, 8 Jul 2017 03:17:32 +0200
Message-ID: <CAKY_R-uk9hpR2hbkPsw2cqoMo6bQKoyp6cWTO20L3fOWfLW2-Q@mail.gmail.com>
Subject: bug with check-ref-format outside of repository
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

As contrived e.g: if I have in my "workspace" sub directories mostly
git repositories, but some not and if I exec,
"for d in */ ; do (cd $d && git check-ref-format --branch @{-1});
done" then I get 3 possible responses.

git version: 2.13.0
1. Valid branch name
2. fatal: '@{-1}' is not a valid branch name
3. fatal: BUG: setup_git_env called without repository

git version 2.13.2.915.ga9c46e097
1. Valid branch name
2. fatal: '@{-1}' is not a valid branch name
3. BUG: environment.c:178: git environment hasn't been setup

best marko
