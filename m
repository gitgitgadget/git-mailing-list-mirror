Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9A30C77B7C
	for <git@archiver.kernel.org>; Tue, 25 Apr 2023 23:39:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236697AbjDYXjZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Apr 2023 19:39:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236661AbjDYXjR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Apr 2023 19:39:17 -0400
Received: from mail-vk1-xa33.google.com (mail-vk1-xa33.google.com [IPv6:2607:f8b0:4864:20::a33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F2481546D
        for <git@vger.kernel.org>; Tue, 25 Apr 2023 16:39:13 -0700 (PDT)
Received: by mail-vk1-xa33.google.com with SMTP id 71dfb90a1353d-441134c09cdso4341071e0c.0
        for <git@vger.kernel.org>; Tue, 25 Apr 2023 16:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682465952; x=1685057952;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yZ47hqeA7VusBNcvXxKf5/uX5gqNZhTdqtpHzYDmjJI=;
        b=Y26qaXrj8sojhGCV5fNvFY4HxbOqoRTuTPavpzwvLYDb7hvh0Msb04VfpTsd7nMG61
         GBDERbM4QC/xyQcanX1z6uUDOSOZ0PoMUlwt5ZDMFgnse4R/ikcYdLl7kLDvFpIuk54i
         5daY5AUF0uHxhsOe1TCbJJJf1NkTc/MaOMRM6WLyGYQE8EcTs5kw1phdcDtaHtp/4eaw
         mtMD1vlBkkpJT3Cpw0s8s8jytjxwYzlW1b2zinaOHgKiAtRtrqqf17norfs2m3LUP+Xm
         kU/bRh1PrbsOhNoiXZ31bs7uOdDivMELY5ZFSx0CbGkFZWe3WhtXS6PiiNzbfQm0w+pv
         qVMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682465952; x=1685057952;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yZ47hqeA7VusBNcvXxKf5/uX5gqNZhTdqtpHzYDmjJI=;
        b=RSimKM4cJ4xu5+3urBmeoeWZIRVwLBlkJrIUVavOFAWNmvgInhq2PgTxV6+SE2Jtdj
         q485azVqlvj1iEz5uOscCkpzv/+2ogvCB4p/3H5hRMo18swDPJ5lyz+gtQW3rRzbeA5l
         aQAc2/ii8fEs+KMf2YhdNBlwJBL2EGXHx82bKE6yyLDqQdv2UCi6MwqkOPm5ZCFfDgNR
         2bTPoxcJWGfj36gc/gwEckNNa2SrLFsF/QGZPgnK+A4ecHqh95/vjKJIT63wTRBaCu5a
         927bGw/hI8tY475xeK8kKNMT/wDGJnVjHSh+jKL/0/sGdiZxNHJcqqrE6Kd6ahRjrVnk
         S8IQ==
X-Gm-Message-State: AAQBX9eibq3L4mYDUxJmnrlomE+iv7g8SDL4EHo3Z7ec45Oioom+sFEM
        dbiyCnn/0m6hkqh8J/EkYN6q27UTH5sYxqQLTLozqJ3Uen8cmw==
X-Google-Smtp-Source: AKy350bgW8PZymxs+DISBfA9swJ57tL1ycHJGA6d2jE5RQjV3r6cT6xqIDIZWc7PvvyeluHsAT5ju9o8r88i4erMWpM=
X-Received: by 2002:a1f:4146:0:b0:43f:bcad:db6b with SMTP id
 o67-20020a1f4146000000b0043fbcaddb6bmr5890797vka.10.1682465952122; Tue, 25
 Apr 2023 16:39:12 -0700 (PDT)
MIME-Version: 1.0
From:   Javier Mora <cousteaulecommandant@gmail.com>
Date:   Wed, 26 Apr 2023 00:39:01 +0100
Message-ID: <CAH1-q0hReZoDWmXo7St10Dk6uc+6ZUQSxqvu1cJ7w3r7ftR9PQ@mail.gmail.com>
Subject: Commit graph not using minimal number of columns
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is something that annoys me a lot whenever I'm maintaining a git
repo with two branches - a main development one and a "fork" or
alteration of the main one, which periodically merges changes from the
main one while at the same time maintaining some additional feature.

When I display the commit graph with `git log --graph` or `gitk`, this
type of graph shows up really nice, with two parallel "tracks"
corresponding to the two branches with periodic merges between them.
However, if for some reason I merge an early version of the main
branch when there's already a newer commit in that branch, then the
entire graph becomes an ugly mess that uses a lot of horizontal space,
and I lose the visual representation of "two parallel tracks".
This seems to be due to git relying on commit dates to decide which
commit goes first, rather than relying solely on topological order.

Example:
```
mkdir TEST_git
cd TEST_git
git init -b main

touch A
git add A
git commit -m 'First commit'

git switch -c fork
touch Z
git add Z
git commit -m 'Introduced feature Z'

for i in B C D E F; do
    git switch main
    touch "$i"
    git add "$i"
    git commit -m "Add $i"
    git switch fork
    git merge --no-edit main
done

git log --all --decorate --oneline --graph
# ^ displays a pretty "two-track" graph

git switch main
for i in G H; do
    touch "$i"
    git add "$i"
    git commit -m "Add $i"
done
git switch fork
git merge --no-edit main~1

git log --all --decorate --oneline --graph
# ^ displays a complete mess that doesn't resemble two tracks
```

This seems to happen because commit H was created after G but before
merging G into `fork`, and can be mitigated by updating the committer
date of H so that it is newer than the merge of G into `fork`, but
that is not always an option.  It also seems to go away after merging
H into `fork`, but that won't work if H is part of a
temporary/abandoned branch I don't plan to merge yet.  And I found
that calling `git log main --all ...` somehow fixes the graph as well.
In these cases, the option `--date-order` actually seems to yield
better graphs than the default (`--topo-order`), but that option is
not ideal, since it may interleave commits from two separate branches,
whereas the default will group commits "semantically".

What do you think?  Do you agree that this sort of thing looks
annoying?  Do you think there might be a way to solve this kind of
issue by improving the graph generation algorithm, so that it
minimizes the number of columns in the graph (for example, preferring
to display merge commits as late as possible)?  Or is this actually
intentional, because the developers consider that in this sort of
situation it would be preferable to group all the merges together?
