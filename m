Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2F3441F404
	for <e@80x24.org>; Tue, 30 Jan 2018 20:25:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752028AbeA3UZe (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Jan 2018 15:25:34 -0500
Received: from mail-ua0-f171.google.com ([209.85.217.171]:45410 "EHLO
        mail-ua0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751728AbeA3UZd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Jan 2018 15:25:33 -0500
Received: by mail-ua0-f171.google.com with SMTP id z3so7939614uae.12
        for <git@vger.kernel.org>; Tue, 30 Jan 2018 12:25:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=2n4zbfyeGwb+37ISqBexl4zJVJ9+EB5FeEVbUtFfg8Q=;
        b=umW7SPyP9ojpZqJ5HhtDDFKT6k+92LWMj7Es7k4KgFIx3zod5aKKyn4yZSuctmD+Ly
         v7PABpEMd5LYAK8HgOuPhc1VIvGWHBR9lqDQ938tp2jt+6j3+ctLckdn0Wv7awwgYs/P
         s0HqAgvhk8fjPF532DLL+GqrFConJZn7SnWKypWjUwY0N7KJCjE6xRx8z3YeFUk/Qkqz
         OqXFqjDVLAqvW4/HvYdv5WOhyDfQ2R6EgU51WIo30faZu7fj5cYcXjGtgVpPaDDjjYjS
         HvvQHHuT8Bm8ibNSIecNQ7NKLlUQM07R8g3MJ9yS/7NhyaeOy8Fz0tNyM2xiuWs+Yn9i
         bUxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=2n4zbfyeGwb+37ISqBexl4zJVJ9+EB5FeEVbUtFfg8Q=;
        b=YY0yFaB/56arso0ZqbWtZPDoZwbr0cG4uTPERvOVP2aq/kaVZbNZV+XhapfgE4mRT+
         TWW66THtzS0PNQQpz8KZZkQuaqCTpjB9+HPrHYSIGRYVLE+Ufl7Q3JQiMB/e7CGpuQBU
         38wR1P5l+3XU0RQlbjN3AGqfnsEaPjCC87dtJ2zbAOs3Zue95a9BnQ9uzRzAG6o7vPcm
         YrHyG4ZkdQaC5AyHKwNnxOnhm9sRDJLVh7nlYM3GqsYoL9PxlFnQlvX9he5sb/R1Vykf
         eUCrCrkP8ThU8wpV0jBy/AXSGmOWdywHkuLoT68M8UH+AbkfNXWggvrlRWTrx6obr2Um
         +soA==
X-Gm-Message-State: AKwxytdWUtsPkSnMmcdwjxabaktOGPA7i22nO++GDMMZXh7lut0IzyIa
        mihx/jM1LHZ2GOOP8e2eUU5/PRnC9wJfp4H/5W8NcrTE
X-Google-Smtp-Source: AH8x226kDLs104JY+wr4fW3ObYlzKfhqhd8wdty0iNPWTAhQN1rp7vVvj3tVwIttdYOWakAcjSmp1lIHP188FzaeO84=
X-Received: by 10.176.29.135 with SMTP id l7mr23756030uak.64.1517343932254;
 Tue, 30 Jan 2018 12:25:32 -0800 (PST)
MIME-Version: 1.0
Received: by 10.176.95.97 with HTTP; Tue, 30 Jan 2018 12:25:31 -0800 (PST)
From:   Michael Scott-Nelson <mscottnelson@gmail.com>
Date:   Tue, 30 Jan 2018 15:25:31 -0500
Message-ID: <CAMZgS+GT8pSx8rDy1KmzFV3LObA_bAkw25LMz5Oodb88QOXY5A@mail.gmail.com>
Subject: git add --all does not respect submodule.<name>.ignore
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Giving a submodule "ignore=all" or "ignore=dirty" in .gitmodule
successfully removes that module from `git status` queries. However,
these same diffs are automatically added by git-add, eg `git add .` or
`git add --all` adds the submodules that we want ignored. This seems
inconsistent and confusing.

Workflow reason:
We want to be able to have supers and subs checked-out, make changes
to both, but only update the SHA-1 pointer from super to sub when
explicitly forced to do so, eg `git add -f subName`. This workflow
prevents continuous merge conflicts from clashing SHA-1 pointers while
still allowing `git add --all`, allowing a sort of middle ground
between submodules and an untracked library.

Teaching git-add about submodule.ignore and/or teaching .gitignore
about submodules would be awesome.

Also experimented with `git update-index --assume-unchanged subName`,
but I believe that it does not get committed and besides also does not
seem to have a way to `git add -f`.
---
Note: currently on git version 2.14.1, but looking through the
changelogs, did not see any changes since then that would enable this
workflow.

-Michael Scott-Nelson
