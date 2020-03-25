Return-Path: <SRS0=ys1m=5K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB4AFC1975A
	for <git@archiver.kernel.org>; Wed, 25 Mar 2020 04:19:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7883120714
	for <git@archiver.kernel.org>; Wed, 25 Mar 2020 04:19:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IB/J2wke"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725832AbgCYETj (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Mar 2020 00:19:39 -0400
Received: from mail-ed1-f42.google.com ([209.85.208.42]:38533 "EHLO
        mail-ed1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725263AbgCYETj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Mar 2020 00:19:39 -0400
Received: by mail-ed1-f42.google.com with SMTP id e5so858990edq.5
        for <git@vger.kernel.org>; Tue, 24 Mar 2020 21:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=U6rl5u33n1ppYs2mhLxZLpSOMf/XpPoitoeVHIVe44s=;
        b=IB/J2wke0b0ZiW2Z/b0L/V1k1kyKJuIenL4WuOq7TKaLnTEVtSWvDZlqh5oXxiNVhm
         oPIDg+Tn5a1YVGsZP0hsmDM3+a/MidUHBw5dwHdWnxWWQaC9RzngGmEAjQSl6XG2OHq6
         v/aMNb+SmiwuPEjrjTbWnK/ntxKmJtK1IdeG/6cdokTUlZK0i+qGjj5JpA8xPM69PrsV
         vmHa0wnh6/KCdw5zn9H3Busfkwcn0asSsYFy3Xf008o4EItImUpNwxkKEtj7lZMO/a0e
         BbuwSw8NMutvMtzb+hEJWzIT5g2WTtkSV4Go2nKIv1NsNJadWnkfuuh7zy+oU+M3LE3z
         wm3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=U6rl5u33n1ppYs2mhLxZLpSOMf/XpPoitoeVHIVe44s=;
        b=aURJqYDlXtai5pt6uFoAzPDRz0Vsa3RbbbHXncWkPHCadLWQutX4XHK36lWvlGGcQe
         jjIXVKGODc0UShYv40QFDwM7stlBHUkIlsrTfmYdwBbNqQe5HXZXq+TlYkJ4gfcSsg5g
         nw+dfKYt92lnMuk3Uq8TMFRkx3mNjQOjxFdpvyHV8cRj6ienaNSB6zUafMdLBvNBi2PZ
         kI6R55s4nkX2fLmBpWuPivTvigVYPv9XIxCMjMvAa3sLMhVmLgjYTVCoe8/8A/H/dazc
         YRpKlnNPM683qvuB04QaMLv46aBhZwhoN32v1qcIjJZSzX1272ZlGwJnetXzhW2KecWK
         66nA==
X-Gm-Message-State: ANhLgQ38WTL2hY9Tm5eBb2MG5viQGH/jGIxMhO84hOgJGEgHazgRsWp/
        daYwvWw5/7MqSVClbss0Pj7Gstm69G5F/bCVLkDsbiZeIAU=
X-Google-Smtp-Source: ADFU+vvsaK2KQrx3z9oEnQMoTWyPpH9N7pV/ZYVdsKJdePf/f/zwVzJTH1oTQcPB+rI/1bwC/yTpOR9pxfapiivN3Zs=
X-Received: by 2002:a17:906:1ba1:: with SMTP id r1mr1496829ejg.297.1585109977033;
 Tue, 24 Mar 2020 21:19:37 -0700 (PDT)
MIME-Version: 1.0
From:   daniel mclean <maczor@gmail.com>
Date:   Wed, 25 Mar 2020 14:19:26 +1000
Message-ID: <CABVQXt5E-R22G62W-tQieA7XiZKZiOA8Hp2xewYhwwOS8wFh0Q@mail.gmail.com>
Subject: Checking Out Branches Containing Submodules With update=none and
 submodule.recurse=true Fails With fatal:not a git repository
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello git developers,

Firstly thanks for a great tool!

I have run into an issue that it would be good to get your advice on.

I have a git repository with multiple submodules.  A few of these
submodules are configured with update=none so that they point to a
specific commit but so that clone operations and submodule update
operations don't retrieve their contents.

When working with this repository and trying to change branches, git
is reporting a fatal error when changing branches.  This can be worked
around by deinit'ing the submodules before switching branches but that
doesn't seem like it should be necessary.

The reproduction steps are to:
- Clone the repo
- Checkout a branch containing submodules that are set with
update=none (git checkout branch-name)
- Update and init submodules (git submodule update --init)
- Attempt to switch to a different branch (git checkout other-branch)

At this point git will report an error at the first submodule with update=none:
fatal: not a git repository: ../.git/modules/no-update-submodule
fatal: could not reset submodule index

After doing some sleuthing it seems that this is because when
update=none the submodule repository is not cloned to
.git/module/<module name>, however when attempting to change branches
using a checkout, git then stumbles since it expects the repository to
be there.

This seems obvious when run with GIT_TRACE=1, git fails when it
attempts to run the read-tree command:

19:20:18.129343 run-command.c:663       trace: run_command: cd
no-update-submodule; unset GIT_PREFIX; GIT_DIR=.git git
--super-prefix= no-update-submodule/ read-tree -u --reset
4b825dc642cb6eb9a060e54bf8d69288fbee4904
fatal: not a git repository: ../.git/modules/no-update-submodule
fatal: could not reset submodule index

If my understanding of how update=none for a submodule and git is
correct, then it seems like it shouldn't be trying to do this since it
should know that the repository isn't there (update=none after all).
This behaviour occurs when I have submodule.recurse set to true,
however interestingly when I set it to false I don't run into this
issue.
So it seems like these two directives are providing mixed messages in
a sense, one says don't clone the submodule repo and the other says
look into the submodule repo and try to find more submodules.

I've tried the 2.20 version of git that comes prepackaged with my OS
and built git 2.26 from source with the same outcome.  I'm running on
Debian stretch on x64 in case that matters.

I'm happy to pursue trying to suggest a fix for this, but am new to
the git codebase and so would appreciate some feedback on whether this
is in fact an issue and some advice on how to best approach a
solution.

Thanks
Daniel
