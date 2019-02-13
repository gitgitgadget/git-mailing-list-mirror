Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 406761F453
	for <e@80x24.org>; Wed, 13 Feb 2019 14:21:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732491AbfBMOVz (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Feb 2019 09:21:55 -0500
Received: from mail-lj1-f172.google.com ([209.85.208.172]:32803 "EHLO
        mail-lj1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732121AbfBMOVz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Feb 2019 09:21:55 -0500
Received: by mail-lj1-f172.google.com with SMTP id f24-v6so2187374ljk.0
        for <git@vger.kernel.org>; Wed, 13 Feb 2019 06:21:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=GOXqVWLl50xoqrJMZAAjk18c2Jo4gKVZwvc5JMP3kJs=;
        b=DhD+7YeGu8INFW1izYuGnlXyzdr+B9zRIq3NJ1GPUXxeTl9YAW8vfB4OAW82yw6Tpe
         ixKvOsHUWcojOw7rBqjx2bFZ7vGk/gLQ6ZhYIxfQoCn8EESq8jIjSgOUwbVkhLXtZksi
         MUKP+V9FMZP8/lyJB1vK4zXK1MSIQT3Ig3QyqFz320YdjIJ5Vf6WwBTGl1EvGkPnUWm2
         puU5RkGUv9hJIIqNuh5Esvts11RdfM9MPiJroQ9WIKvpk0ifcE3df6xwUTRqkeiDiGoU
         5RDBPiNNVkUDd1ERE5wg0L2jh/Fe/3KsbNIhs4RMwP+T7HAnM93yMXVRNNsoVmBJC6Zq
         SjOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=GOXqVWLl50xoqrJMZAAjk18c2Jo4gKVZwvc5JMP3kJs=;
        b=afTkqLOpdRmx9gkdc/JaqzHJ/sOtd9B53id2wzYOR0DtvlkzTQDHDZCTTG3/VfITVB
         rMM5MarNyp01LugOTA/VHP36zBMaAra8wkmRJoWRcqgyClmC0mbhgXN21yOiLSrgiXQn
         BIqpcpoRggDvdkIqiG8wiyeeb7cC8eJBQfwNozHbcipZtrq6J8rHDIuRssPuT0g3fIzj
         I420osc8r8B/RldOrDIos7s/eKsVLo6UwsHUpaTYzaSqt/9gqNdOe2vGhJdtPg3+FkL0
         UMzSbp9pVhRJxbeAZhkEaIDpAEKY/3AhndowNXrXB/lrTwNy2qapVBWS7YJGEms042G0
         Tlzg==
X-Gm-Message-State: AHQUAuZ/Gq9qg3XFKUBvPgjEleVAeYKEilMB/srgVr24bqm/8wBXR/6i
        e7DNiReK+IG+RP8qqZs1vEyxaCQ155EbpJlWI9/26vyS
X-Google-Smtp-Source: AHgI3IZALm/jCvFn+ZM+k/7cdhHq2Kh2NDGyaapVuJdWI3qk+RDFG/ulfyThCmARkTeEqSMzEk6sRQc+sRjKIM/FJQ8=
X-Received: by 2002:a2e:8788:: with SMTP id n8-v6mr442187lji.181.1550067712119;
 Wed, 13 Feb 2019 06:21:52 -0800 (PST)
MIME-Version: 1.0
From:   Jason Wenger <jcwenger@gmail.com>
Date:   Wed, 13 Feb 2019 08:21:41 -0600
Message-ID: <CAM6z=49Ku-JMJRvjqYT8cqN7PaUdBESQCdx_6tCB4e5zhA2Cog@mail.gmail.com>
Subject: Tailoring branch use case question
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

So I've got a use case that is cumbersome, and I'm wondering if it's a
common one, or if anyone has found a better way to manage it.

I have a repo that I work in where I make a set of changes to adapt it
to my environment -- some config file changes and a couple code
changes that help with debugging.  I want those changes always
applied, regardless of which branch I'm on, but they're specific to my
setup, so I don't want to commit them to the public repo's history.
The changes are in specific places that aren't in active development,
so the changes I apply never generate merge conflicts.

When I work, I've currently been keeping these changes in a couple
commits, that I call 'tailor'.

When I want to work on a branch 'foo', instead of checking out foo, I
manually rebase --onto foo tailor~~ tailor, so that the couple commits
in my tailor branch reapply, now on top of branch foo.

When I commit, I want to commit to foo, not my tailor branch.  So to
get that, I have to first commit on top of my tailor branch, then
checkout foo, cherry pick the new commit, and then checkout tailor
again, and rebase back on top of the new foo.  The other way I could
do that would be to commit on top of tailor, rebase --interactive to
reorder the commits, and manually update the foo ref.  Either way is
cumbersome.

It's not a use case for --assume-unchanged, because I sometimes do
make changes in those same files that get tailored, and I do want
those changes to be show in diff and git gui.

I thought about trying to do some stuff with git hooks, but the idea
of doing things like rebasing inside post-checkout seemed evil.

Really, the whole 'tailor' branch I've been using itself is really
just an artificiality.  Really, I'd rather be thinking just about the
branches I'm actually working with, not this artificial 'tailor'
branch.

Essentially, I want a way to work with branches normally, but to
ensure that, for a defined patchset:
=E2=80=A2 every time I update HEAD to a new ref, my working copy is actuall=
y
checked out as HEAD+patchset
=E2=80=A2 when I diff my working copy against any ref (including HEAD of
course), for patchset to not contribute to the diffs that are produced
=E2=80=A2 when I commit to HEAD, for patchset to remain applied in the work=
ing
copy only, and not be committed to HEAD.
=E2=80=A2 to be able to (very rarely) change the content of that patchset

I haven't' been able to come up with a way to automate that.  Is this
a use case others have encountered?  Has anyone found a better way to
manage this?

Thanks,
--Jason C. Wenger
