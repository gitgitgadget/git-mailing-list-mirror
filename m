Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 56B561F406
	for <e@80x24.org>; Mon,  8 Jan 2018 10:25:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755257AbeAHKZJ (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 Jan 2018 05:25:09 -0500
Received: from mail-ot0-f178.google.com ([74.125.82.178]:36248 "EHLO
        mail-ot0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751600AbeAHKZH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Jan 2018 05:25:07 -0500
Received: by mail-ot0-f178.google.com with SMTP id w4so8819926otg.3
        for <git@vger.kernel.org>; Mon, 08 Jan 2018 02:25:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=/LUgj/D4HkVumjclG72H7+k9Y2ywCisbklvJ3TKTEPQ=;
        b=ovXzQFSLKCjXLd0tWwvEe/j9QwJNV50yK1jJavtqghYBgvgm1FfiA6vn7DKaYxrHb+
         OnPE7ISAUUKWW26PCrr+Hsa5y1eqVlI+ljGPDnPPgsn6WBTngbEOb4/pylqhHfZ76Hg/
         DksPGaPtVUfj1/LspXqpg973+KcijxrTi3/FIXtYUvbdbMNBzKE/+8GKkqBzcIMGToy+
         uRso9CR5ARlWHwBjDOAyKMwELJpihBm59IHv5r8QM/a8PP7RH1dIZ9SdyKtjiW5zRZtV
         XzGTmElBqxhRVinaMauv/QrDyb5QEStsBYfHfrw/+sQmU9dhKckcUG+o/+1mk/5+GdOd
         i4Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=/LUgj/D4HkVumjclG72H7+k9Y2ywCisbklvJ3TKTEPQ=;
        b=jkBguw9S1qC+ID26leJYp4vFPlAcngRSotrRzYQrR5M25rS7ke08p2JJG8ZnrL0Ba5
         gF4b6izRFDDofUKe/ykaqaSS/gnLeaxFQ5GLxVHQToazvxjVglzQ1NMnx+kQCheMSUo4
         U/ba2wDROCXy1YlPs+lN5vEUvWnt+PSsHIfFsgpjDrLnfoa3uxApYTXm/pjR4Ocap8WT
         X9QCas5QfRCtHsUj9WzDOJih578KsU7yJRyEsuCseOfWO/dRSHLw7lcHCf2fT7dxlnei
         L0n0IgZcsqR2V5dfULajgkLp/8jM9ePLH9qbuUJbw+7wO/owchkVB9p/xqEG7VddIloT
         f3BQ==
X-Gm-Message-State: AKwxyte5IUZ0hQXAxS1uuWI5Hgqw00Lon3mk+EFKf/ZV3aAbZTL9Kmej
        k2UF0XMCC/YDY+Wwo2lgqJ1XLEbHK60C3mE0UiGDlg==
X-Google-Smtp-Source: ACJfBoubf801s+o/Ev1nfO60/LQklZV+oIMbo7XdduXFAG2xR57DErx7R5TzPD8se30sKtMIcQyOI0qXn2G6iNFqL6k=
X-Received: by 10.157.13.233 with SMTP id 96mr1965762ots.331.1515407106319;
 Mon, 08 Jan 2018 02:25:06 -0800 (PST)
MIME-Version: 1.0
Received: by 10.157.73.21 with HTTP; Mon, 8 Jan 2018 02:24:45 -0800 (PST)
From:   "Matwey V. Kornilov" <matwey.kornilov@gmail.com>
Date:   Mon, 8 Jan 2018 13:24:45 +0300
Message-ID: <CAJs94Eas59UxZ+490AUSOuB37i+JBEvbCnGBMVpKi1G469OTbw@mail.gmail.com>
Subject: rebase preserve-merges: incorrect merge commits
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

I think that rebase preserve-merges algorithm needs further
improvements. Probably, you already know it.

I was playing with rebasing linux kernel tree and found that rebase
preserve-merges works in counterintuitive way while handling
merge-commits. I don't want to discuss arising merge conflicts which
can be illuminated with help of rerere trained at original branch. An
major issue here with silently auto-merging, some merge commits were
silently rebased with different content and it breaks the build :)

I crafted toy example to demonstrate an issue:
https://github.com/matwey/example-git-rebase-pm
Here I have commit range v0.1..v0.2, then I return to v0.1 and
introduce new commit abc-0.1 with new file on v0.1. Then I want to
rebase v0.1..v0.2 onto new abc-0.1. It is obvious that as soon as I
introduced single new file the difference between old v0.2 and new
v0.2 should have only this new file. However it actually contains
other changes.

Reproduce as the following:

git checkout v0.2
git branch abc-0.2
git checkout v0.1
git branch abc-0.1
git checkout abc-0.1
vim LICENSE
git add LICENSE
git commit -a
git rebase --preserve-merges --onto abc-0.1 v0.1 abc-0.2

Actual result:

diff --git a/LICENSE b/LICENSE
deleted file mode 100644
index 297edb3..0000000
--- a/LICENSE
+++ /dev/null
@@ -1,2 +0,0 @@
-Hello, world!
-
diff --git a/mod.c b/mod.c
index e6fa107..e339597 100644
--- a/mod.c
+++ b/mod.c
@@ -2,5 +2,5 @@
 #include "mod.h"

 int mod_fun(char* buf, int len) {
-       return -calc_fun(buf, len);
+       return -calc_fun(buf, len, 0);
 }

Expected result:

diff --git a/LICENSE b/LICENSE
deleted file mode 100644
index 297edb3..0000000
--- a/LICENSE
+++ /dev/null
@@ -1,2 +0,0 @@
-Hello, world!
-


As far as I understand the root cause of this that when new merge
commit is created by rebase it is done simply by git merge
$new_parents without taking into account any actual state of the
initial merge commit. This is why all manually introduced changes in
merge-commits are lost at rebase stage. I think that the following
improvement of merge-commit recreating stage would be possible:

1) Let we have merge commit in the source tree

-- A --\
        M--
-- B --/

And we want to rebase M to the new tree where new parents A' and B'
already existing.

-- A'

-- B'

2) Then I suggest to perform it in three steps. First, lets take all
possible differences between A and M, B and M and so on... and then
try to cherry-pick the diffs on A' and B' respectively. Here AM' and
BM' are temporary commits which is very close in their states (in
ideal case, equal).

-- A' -- (AM)'

-- B' -- (BM)'

3) Then we do git merge (AM)' (BM)' and ask user to resolve the
conflicts if any. Here we obtain the following tree. Where M" is
produced by git merge.

-- A' -- (AM)' --\
                  M"
-- B' -- (BM)' --/

4) Then we do merge between A' and B' but reset the state to be the
same as in M" before new merge commit is created:

-- A' -- (AM)' --\
     \            \
       M' (==M")    M"
     /            /
-- B' -- (BM)' --/

5) Then (AM)' (BM)' and M" are discarded from the tree.


Probably, I missed something important or incorrectly read
git-rebase--interactive.sh

-- 
With best regards,
Matwey V. Kornilov
