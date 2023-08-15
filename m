Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EC99C04A6A
	for <git@archiver.kernel.org>; Tue, 15 Aug 2023 16:45:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238565AbjHOQpD (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Aug 2023 12:45:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238554AbjHOQoq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Aug 2023 12:44:46 -0400
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com [IPv6:2607:f8b0:4864:20::c29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A0871B2
        for <git@vger.kernel.org>; Tue, 15 Aug 2023 09:44:45 -0700 (PDT)
Received: by mail-oo1-xc29.google.com with SMTP id 006d021491bc7-56dfe5ce871so2244943eaf.2
        for <git@vger.kernel.org>; Tue, 15 Aug 2023 09:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692117884; x=1692722684;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hlqdK8mi9K4eqdftEj6j7eZAaTOgD83yvwwiCkiRP54=;
        b=XGC0QBkSWUoxomNC8byfib9cpoOdiV6RFMruJKRa57QW2F7N4PKjtkfvckgLExNXw2
         ZO+CeKLPExx0lLoigg6bYsKnA7BZR7IaO4vYQV9j4SpInXxwDcndfi5yvEKqiiFU0nUc
         /dXTuybp+O86t1ljP5qtJEFPErpWltKsaFxvLnkxeyJP6lTrHxsqUo8oZeOrkaGVAvNA
         65kh6Rts1En2u4Pn7PEF1F0uP212wDd2R6EIux40l2ixrcAjYVQXtAu80ZaCo4vcgrLG
         FVBJIlPUuPXAFfh6mEaWediGdM9pFNu4c5AxpD8Z1j0/KUB4nafco2xHDVEgHvvLTY87
         Cvew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692117884; x=1692722684;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hlqdK8mi9K4eqdftEj6j7eZAaTOgD83yvwwiCkiRP54=;
        b=N8uaoJhKcOTlYEeUDlWNdn4ty1OgrjQuxM1F7WeLRMIl4orgz0V6Iq4FyOvc792UhM
         hY+hdtV6DH0cPal8Niye0fxI+UUznGwoiZlGW12TjGI6Yria2NwBAUib6dYAHD8JehJk
         oJ6TsPpicUQ5n4vGg70vqKshz2BBt2ydIwqOX8h9SF4HEhDsHzatowRqZdVecHQtpZZx
         Mmqkr/ra62oUp/mexcdVyqSMPSbhm4hCYBHn3+P2Dvppe3FRBcg7Sz+Wjka5o9jAAxHJ
         VXJer0ZZU3bZ80JMagc+1k1Ptz41pSIjHths1EOKLsd+D4sxDXSoGKBvzV9y3pJSb1LK
         XQ5Q==
X-Gm-Message-State: AOJu0YznH1nd/B815rxtHfuUt9dxwZqDvbr4KRjHd0DyVxS7FN0eCW0X
        E+RyeImexAl15PRv9jNoNO/fDkDDeLxTAnGTBZ9SBaLyyYSUBw==
X-Google-Smtp-Source: AGHT+IEFntmI7S11WT3xrNl6jd5q6CBw1PF6LREJt8yGgw47ulHS/vtrrTeiOmtM+H+63KLdFt/idt1WGBcFCEoa/Bk=
X-Received: by 2002:a05:6870:168d:b0:1be:cf5d:6f7b with SMTP id
 j13-20020a056870168d00b001becf5d6f7bmr14095824oae.17.1692117884165; Tue, 15
 Aug 2023 09:44:44 -0700 (PDT)
MIME-Version: 1.0
From:   Karthik Nayak <karthik.188@gmail.com>
Date:   Tue, 15 Aug 2023 18:44:18 +0200
Message-ID: <CAOLa=ZQmjroDiOcUsu_MHtQ-88QHU9qeZPOPh+KJJ3dFoF2q0A@mail.gmail.com>
Subject: [Bug] In `git-rev-list(1)`, using the `--objects` flag doesn't work
 well with the `--not` flag, as non-commit objects are not excluded
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello!

What did you do before the bug happened? (Steps to reproduce your issue)

Assume a repository structure as follows:

- commit1 9f2aa2eb987c2281bb4901dbccd1398ad2c39722
  - tree: 205f6b799e7d5c2524468ca006a0131aa57ecce7
    - 100644 blob 257cc5642cb1a054f08cc83f2d943e56fd3ebe99    foo
      - content: foo
- commit2 9e02481f4df3a8997335b0a68882580e3b9b588f (parent:
9f2aa2eb987c2281bb4901dbccd1398ad2c39722)
  - tree: 672d0aa883d095369c56416587bc397eee4ac37e
    - 100644 blob 257cc5642cb1a054f08cc83f2d943e56fd3ebe99    foo
      - content: foo
    - 100644 blob eec8c88a93f6ee1515fb8348f2c122cfda4302cd    moo
      - content: moo
- commit3 91fa9611a355db77a07f963c746d57f75af380da (parent:
9e02481f4df3a8997335b0a68882580e3b9b588f)
   - tree 0c16a6cc9eef3fdd3034c1ffe2fc5e6d0bba2192
     - tree 086885f71429e3599c8c903b0e9ed491f6522879    bar
       - 100644 blob 7a67abed5f99fdd3ee203dd137b9818d88b1bafd    goo
         - content: goo
     - 100644 blob 257cc5642cb1a054f08cc83f2d943e56fd3ebe99    foo
       - content: foo
     - 100644 blob eec8c88a93f6ee1515fb8348f2c122cfda4302cd    moo
       - content: moo
     - 100644 blob 8baef1b4abc478178b004d62031cf7fe6db6f903    abc
       - content: abc
- commit4 6b52ed5b176604a0740689b5bb9be7bd79f4bced (parent:
9f2aa2eb987c2281bb4901dbccd1398ad2c39722)
  - tree ff05824d2f76436c61d2c971e11a27514aba6948
    - tree 086885f71429e3599c8c903b0e9ed491f6522879    bar
      - 100644 blob 7a67abed5f99fdd3ee203dd137b9818d88b1bafd    goo
        - content: goo
    - 100644 blob 257cc5642cb1a054f08cc83f2d943e56fd3ebe99    foo
      - content: foo
    - 100644 blob 8baef1b4abc478178b004d62031cf7fe6db6f903    abc
      - content: abc

What did you expect to happen? (Expected behavior)

In such a repository, the output for the command, should have the
output provided below

=E2=9D=AF git rev-list --objects 6b52ed5b176604a0740689b5bb9be7bd79f4bced
--not 91fa9611a355db77a07f963c746d57f75af380da
6b52ed5b176604a0740689b5bb9be7bd79f4bced
ff05824d2f76436c61d2c971e11a27514aba6948

What happened instead? (Actual behavior)

Instead, the output is as follows:

=E2=9D=AF git rev-list --objects 6b52ed5b176604a0740689b5bb9be7bd79f4bced
--not 91fa9611a355db77a07f963c746d57f75af380da
6b52ed5b176604a0740689b5bb9be7bd79f4bced
ff05824d2f76436c61d2c971e11a27514aba6948
8baef1b4abc478178b004d62031cf7fe6db6f903 abc
086885f71429e3599c8c903b0e9ed491f6522879 bar
7a67abed5f99fdd3ee203dd137b9818d88b1bafd bar/goo

What's different between what you expected and what actually happened?

If you notice here, the objects
`8baef1b4abc478178b004d62031cf7fe6db6f903`,
`086885f71429e3599c8c903b0e9ed491f6522879` and
`7a67abed5f99fdd3ee203dd137b9818d88b1bafd` are included in the output,
these objects are reachable from
`91fa9611a355db77a07f963c746d57f75af380da` and shouldn't have been
included since we used the `--not` flag.

Anything else you want to add:

I did some preliminary walkthrough of the code to understand why this
happens, and my understanding is as follows:
1. In rev-list.c: we first set up the revisions provided via the
`setup_revisions()` function. Here, any revision provided under the
`--not` flag is marked as `UNINTERESTING`.
2. In rev-list.c: we then call `prepare_revision_walk()`, this
function internally goes through the commits and calls
`handle_commit()` on each of the commit. In our case
(6b52ed5b176604a0740689b5bb9be7bd79f4bced,
91fa9611a355db77a07f963c746d57f75af380da).
3. In revision.c: In `handle_commit()` we set `revs->limited =3D 1`
since one of our commits is marked as `UNINTERESTING`.
4. In revision.c: Back in `prepare_revision_walk()`, since
`revs->limited` is set, we call `limit_list()`.
5. In revision.c: Not sure what the purpose of `limit_list()` is, but
seems like it is to optimize the revision walk to reduce the traversal
later on. In our case, we can mark all parents of the commit as
uninteresting and remove the commit from the rev list entirely.
6. In rev-list.c: Finally, when we call
`traverse_commit_list_filtered` for the traversal, we recursively show
commit/object unless we come across something `UNINTERESTING`. Since
only the commits were marked as `UNINTERESTING`, any shared
trees/blobs will still be printed to output.

The diff below fixes the issue:

@@ -3790,11 +3833,12 @@ int prepare_revision_walk(struct rev_info *revs)
         commit_list_sort_by_date(&revs->commits);
     if (revs->no_walk)
         return 0;
-    if (revs->limited) {
+    if (revs->limited && !revs->tree_objects) {
         if (limit_list(revs) < 0)
             return -1;
         if (revs->topo_order)

But this is definitely a very _naive_ fix. Before diving into fixing
this, it would be nice to hear some thoughts on this.

[System Info]
git version:
git version 2.41.0
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
uname: Linux 6.4.9-200.fc38.x86_64 #1 SMP PREEMPT_DYNAMIC Tue Aug  8
21:21:11 UTC 2023 x86_64
compiler info: gnuc: 13.1
libc info: glibc: 2.37
$SHELL (typically, interactive shell): /bin/fish


[Enabled Hooks]
not run from a git repository - no hooks to show

- Karthik
