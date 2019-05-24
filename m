Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3DECD1F462
	for <e@80x24.org>; Fri, 24 May 2019 09:15:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389732AbfEXJPE (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 May 2019 05:15:04 -0400
Received: from mail-ot1-f50.google.com ([209.85.210.50]:42779 "EHLO
        mail-ot1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389569AbfEXJPE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 May 2019 05:15:04 -0400
Received: by mail-ot1-f50.google.com with SMTP id i2so8053114otr.9
        for <git@vger.kernel.org>; Fri, 24 May 2019 02:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=NowovFGTLc0y4m8SFuXKhOavcPeTz5yV7kfsdwBEa+g=;
        b=chXMaIS+mhhixz9Ze79x4I94q9NgHTdGiZxnPOG+nINP9cOBxJZQpo7QX4FStFdxRY
         TS8qfSGxl2pdUUu8ZjJhbKmetCRqMbvVnCwleY4tEygQPgTVT2TQ2WfsN+H9gcRpcsJS
         HFgO9ZD6EqJJGdDui+tg2yKSCqUev/723Os3AF4iYOdGxWRGQlMIZDcw9zXyqCXqHEHt
         t9vDbMaTK5u8UbL0Zjg4ABvW8uy75R0Al6WQisYlyEodGnnRIDtzZfbuVFrjL7WFfQkk
         wP/aMyePuWCn4E6Urpn22I/d4BuQev7CXyYpkvnZ3i9UKZ5fIic3PzB0xz33PHDkY4Ci
         o73g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=NowovFGTLc0y4m8SFuXKhOavcPeTz5yV7kfsdwBEa+g=;
        b=Coyni1/WCtevHFmczZMEVs3FgiIo4Bjc/JCkQ+zDmuzBDxDsktKv29uvhziZY/Dsuv
         JsZkfgbgg5Wpp1u2foHkudCAk+FYR9WtbfjgT6VjKoFNs6kWIRhA2cVOCUQSA1VndrtO
         NB557RVSRN6xxLN1SoyU499x3f/I/g/J6GLrEXRZ9A18kbfb7mOQkM5Gjb63ZgwDH6P0
         hc0kYT4f6GhCyfcAG7KLDlwAOGLnVKAm/3pxmqmiNK/ZqMdFN8SIuBHFBn3P71XeCA5t
         ipZu0D5ts7HnBAvwIZ03O5fhxOB2fNCCQNn4ScA4ATjjNKowcL2X7jdByX4EYo/G+Z9E
         8uCg==
X-Gm-Message-State: APjAAAV3Bg3qE5HLWpFluZfC4RZK7jPgXzlGioO/thR42KhS4ipbxQUU
        O9jvYZaFhrKyFVhRwYG/wOi8OOi+Up3CkH4cw/Xone5TWvQ=
X-Google-Smtp-Source: APXvYqxwtDb4KVDq9gBgS5/zDcMwsNo8juF0eI8QrPUMi7pCW90D+ApjraRjSMYJOY0mnsrRkJMgs1UFvUHT60/Qx78=
X-Received: by 2002:a9d:58c5:: with SMTP id s5mr31821181oth.153.1558689303162;
 Fri, 24 May 2019 02:15:03 -0700 (PDT)
MIME-Version: 1.0
From:   Orgad Shaneh <orgads@gmail.com>
Date:   Fri, 24 May 2019 12:14:52 +0300
Message-ID: <CAGHpTBKSUJzFSWc=uznSu2zB33qCSmKXM-iAjxRCpqNK5bnhRg@mail.gmail.com>
Subject: Performance regression on git fetch in 2.21
To:     git <git@vger.kernel.org>, Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

git fetch in my repository *when nothing new is received* takes 2.5x
the time when comparing 2.20 against 2.21 (on Windows it's 4x).

I have 5 initialized submodules in this working directory.

I reported this issue on git-for-windows github:
https://github.com/git-for-windows/git/issues/2199 but there is also
an upstream change related.

I bisected and found this commit to blame:

Building... Fetching... Failed [10.7949124]
Bisecting: 0 revisions left to test after this (roughly 0 steps)
[a62387b3fc9f5aeeb04a2db278121d33a9caafa7] submodule.c: fetch in
submodules git directory instead of in worktree
running git-bisect.rb
Building... Fetching... Success [4.303592]
be76c2128234d94b47f7087152ee55d08bb65d88 is the first bad commit
commit be76c2128234d94b47f7087152ee55d08bb65d88
Author: Stefan Beller <sbeller@google.com>
Date:   Thu Dec 6 13:26:55 2018 -0800

    fetch: ensure submodule objects fetched

    Currently when git-fetch is asked to recurse into submodules, it dispatches
    a plain "git-fetch -C <submodule-dir>" (with some submodule related options
    such as prefix and recusing strategy, but) without any information of the
    remote or the tip that should be fetched.

    But this default fetch is not sufficient, as a newly fetched commit in
    the superproject could point to a commit in the submodule that is not
    in the default refspec. This is common in workflows like Gerrit's.
    When fetching a Gerrit change under review (from refs/changes/??), the
    commits in that change likely point to submodule commits that have not
    been merged to a branch yet.

    Fetch a submodule object by id if the object that the superproject
    points to, cannot be found. For now this object is fetched from the
    'origin' remote as we defer getting the default remote to a later patch.

    A list of new submodule commits are already generated in certain
    conditions (by check_for_new_submodule_commits()); this new feature
    invokes that function in more situations.

    The submodule checks were done only when a ref in the superproject
    changed, these checks were extended to also be performed when fetching
    into FETCH_HEAD for completeness, and add a test for that too.

    Signed-off-by: Stefan Beller <sbeller@google.com>
    Signed-off-by: Junio C Hamano <gitster@pobox.com>

:040000 040000 2bad86c248b79ef1e36ea5edaa423cd73445c9a2
ad989a8f3e6f80d4f5a84ec3db0ff1ab00a7e210 M      builtin
:100644 100644 d1b6646f42d5d12740a94f50a7d25aad4aa356bf
b88343d977d78364b417e2015eaa352dec1501b9 M      submodule.c
:040000 040000 a3c58919de0796b6467709a0f21fa21e28d4d13b
cdf9514c9085efcbfcdba8efc765174f6455ce5d M      t

Can you please suggest a fix? Is this the expected behavior?

Thanks,
- Orgad
