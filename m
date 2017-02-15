Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 573C52013A
	for <e@80x24.org>; Wed, 15 Feb 2017 20:36:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751389AbdBOUgx (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Feb 2017 15:36:53 -0500
Received: from hapkido.dreamhost.com ([66.33.216.122]:44713 "EHLO
        hapkido.dreamhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751313AbdBOUgw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Feb 2017 15:36:52 -0500
Received: from homiemail-a2.g.dreamhost.com (homie.mail.dreamhost.com [208.97.132.208])
        by hapkido.dreamhost.com (Postfix) with ESMTP id 2BA158DC96
        for <git@vger.kernel.org>; Wed, 15 Feb 2017 12:36:52 -0800 (PST)
Received: from homiemail-a2.g.dreamhost.com (localhost [127.0.0.1])
        by homiemail-a2.g.dreamhost.com (Postfix) with ESMTP id 1BA6F280073
        for <git@vger.kernel.org>; Wed, 15 Feb 2017 12:36:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=bit-booster.com; h=
        mime-version:from:date:message-id:subject:to:content-type; s=
        bit-booster.com; bh=0S4ssbmgFa4Jizd0DiHBk0nL8ZM=; b=WJzNNEKzI4k3
        1A70rdpxM1ptxBLtg7vg2LDb0rCF8d0PeoIeUly1jSN+xH6Y6hn6mN8wRJnVBrtP
        2bnGf9kef8ZOUKX/NOs9SnhCQo1jTIKNLlIjGLHYg5PxffL/wgGAgKut9m8eRYp1
        miZ7LPWd/EhlZ0FtYCPlwZQniIN9tVw=
Received: from mail-yb0-f174.google.com (mail-yb0-f174.google.com [209.85.213.174])
        (using TLSv1 with cipher AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sylvie@bit-booster.com)
        by homiemail-a2.g.dreamhost.com (Postfix) with ESMTPSA id 0CB50280072
        for <git@vger.kernel.org>; Wed, 15 Feb 2017 12:36:51 -0800 (PST)
Received: by mail-yb0-f174.google.com with SMTP id 123so48062349ybe.3
        for <git@vger.kernel.org>; Wed, 15 Feb 2017 12:36:51 -0800 (PST)
X-Gm-Message-State: AMke39kxMm+rTBQb2OGhciUPEnJx2mRrCx3/h+y5OcxkUfxVxULJoa7NdQ4wLoxuOydfSfZclr85if+0mmGhMQ==
X-Received: by 10.37.31.85 with SMTP id f82mr25424941ybf.188.1487191010320;
 Wed, 15 Feb 2017 12:36:50 -0800 (PST)
MIME-Version: 1.0
Received: by 10.37.56.201 with HTTP; Wed, 15 Feb 2017 12:36:50 -0800 (PST)
From:   "G. Sylvie Davies" <sylvie@bit-booster.com>
Date:   Wed, 15 Feb 2017 12:36:50 -0800
X-Gmail-Original-Message-ID: <CAAj3zPx6uP5WbA68Co0yX_yh-e5C+jze2T1hJ0NYS7hHBzgdqg@mail.gmail.com>
Message-ID: <CAAj3zPx6uP5WbA68Co0yX_yh-e5C+jze2T1hJ0NYS7hHBzgdqg@mail.gmail.com>
Subject: how are "untracked working tree files" even possible in this case?
To:     Git Users <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I have a script that runs the following sequence of commands within a clone:

-----
/usr/bin/git rebase --abort (took 148ms)
/usr/bin/git cherry-pick --abort (took 103ms)
/usr/bin/git clean -d -f -x (took 2007ms)
/usr/bin/git reflog expire --expire=now --all (took 106ms)
/usr/bin/git reset --hard --quiet
181def85d58597dfb28729029b2ad76b9fbb09f5 -- (took 60103ms)
/usr/bin/git merge --squash 333def1a1513f84c1eb79e5341ed6ebca0d359a1
(took 1795ms)
Err: '/usr/bin/git merge --squash 333def1a1513f84c1eb79e5341ed6ebca0d359a1'
Exit=128
error: The following untracked working tree files would be overwritten by merge:
.gitignore

[...many more files...]

Please move or remove them before you can merge.
Aborting
-----


I don't understand how untracked working tree files are possible after
"git clean -d -f -x" and "git reset --hard" !

I don't have access to this particular repo, but it's around 30GB when
cloned (git directory plus working tree), and around 500,000 files in
the working tree when checked out.  Note:  the "reset --hard" takes 60
seconds here.




- Sylvie
