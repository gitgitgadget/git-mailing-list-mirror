Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D179EC00144
	for <git@archiver.kernel.org>; Fri, 29 Jul 2022 22:52:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239533AbiG2WwF (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Jul 2022 18:52:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239213AbiG2WwE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Jul 2022 18:52:04 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1D884B4A3
        for <git@vger.kernel.org>; Fri, 29 Jul 2022 15:52:02 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id x34-20020a056a000be200b0052b7f102681so2356164pfu.5
        for <git@vger.kernel.org>; Fri, 29 Jul 2022 15:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:from:to:cc;
        bh=YMfJ00wynwHzSQwRMRsS7DnoLkLHOP/yQqF54IwB7Pc=;
        b=JW1E3zc8OsM6HgG8aVgJBS+f/l4gPf568jh1HwU3Y1iF3L7kw+8RxZx0xNtcYnHJ0M
         BS7oQb3VKfGbo6eH8zaegvTQb8SL/PmmhVAcZ00FybhTiHu8i1dWWhUw72j6r/TO6YlK
         157oa7d89PNkEZALG+HWofVKD5nOtziSD/s4aYdYaTeCQSIlNtTkphv3SJsb6gpe0m+Y
         BYcY+4kumIsPHAC5XoHChBt/KdSy2yvJr9nfwcPdkN5mQ/kVWC6ObL5rmswYaT9hZCIR
         uD2xyfSMtflql00FsszBKj9CDev2LiwmQ9M/jxFmZDL8yHw1EJRupXk6ECXfPezFx8Xr
         nIbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:x-gm-message-state:from:to
         :cc;
        bh=YMfJ00wynwHzSQwRMRsS7DnoLkLHOP/yQqF54IwB7Pc=;
        b=4+acyOfmWrg6A8PPg+xmXi/qOqyUsT9JYl5m4+ND3tA40gp5RrxasGKjEWqECZnn5v
         W7E5O7Y+B5O4fTJsvaqLr+vnuXGDA5+in+wR05gL/rng7828P3/0IWfxg8W+I/IsFOOM
         e1yQwgg5N2mJ9Gl2ncSIIQn3V7PY2jUO8hurFm2pF6zPRZUyk/uKRtBwuR6DOkt7bjon
         hSw7Mf5nm3D4JLJ4L4oPRWJFp7VBBXSeiwAhnMnaTRJtzhmaSF06lIkTlHdKJmPl2Pky
         deLFXsLHJukwowJby+3qkxIk6p1lysdOpmtjirsiWfYuZhyvHujnHy1EToT3CnT9IKTF
         v4dQ==
X-Gm-Message-State: AJIora8iiiUEJ0mxTYDL54xR/KHVH79xxJwwQoBPn56br+TDGi/WQs+1
        y0HjeG7v9Q5ACFjt1pLcQHPBhnr36dtvgQ==
X-Google-Smtp-Source: AGRyM1srIPRts7791PAhuRLS97Blw5XAMGt/Km6NSdgdVNTRmdmOw9SZLIHyg0ppEX6CpExiEIgX9oP6FGyguA==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a62:ea01:0:b0:52b:39ec:a72f with SMTP id
 t1-20020a62ea01000000b0052b39eca72fmr5653021pfh.52.1659135122366; Fri, 29 Jul
 2022 15:52:02 -0700 (PDT)
Date:   Fri, 29 Jul 2022 15:52:00 -0700
In-Reply-To: <cover-00.20-00000000000-20220728T161116Z-avarab@gmail.com>
Message-Id: <kl6lfsijr0q7.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <cover-00.20-00000000000-20220728T161116Z-avarab@gmail.com>
Subject: Re: [PATCH 00/20] submodule--helper: add tests, rm dead code,
 refactor & leak prep
From:   Glen Choo <chooglen@google.com>
To:     "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> This new series based on "master" splits out the non-leak fixes from
> v3 of the submodule leaks series [1]. Sorry about the churn, but with
> e.g. the thread at [2] the "leaks" series was accumulating a lot of
> non-leaks related fixes, just so that we could get to the point of
> fixing various leaks.
>
> The immediate reason I split this off was because of the new
> "remove..helper" and "test-tool" patches here. I.e. some things that
> the leaks series was changing was test-only code, or code that was
> simply unused (or we had no business using anymore).
>
> The [1] series will then be re-rolled on top of this series, which
> will hopefully make it a lot easier to digest, as it'll now *just*
> focus on leak fixes.


Thanks! I was worried about the churn at first, but most of these
patches are just the ones we already reviewed in previous versions, and
the leaks series looks a lot easier to review.

I left the bigger comments in-thread. Some themes I saw in the patches:

>   submodule tests: test usage behavior
>   submodule tests: test for "add <repository> <abs-path>"

I assume these tests are meant for catching regressions?

>   submodule--helper: remove unused "name" helper
>   submodule--helper: remove unused "list" helper

Hooray for rm-ing dead code!

>   test-tool submodule-config: remove unused "--url" handling
>   submodule--helper: move "is-active" to a test-tool
>   submodule--helper: move "check-name" to a test-tool
>   submodule--helper: move "resolve-relative-url-test" to a test-tool

Each of these commands are only used in _their own_ tests as opposed to
be used in tests for _other_ commands (or, to borrow the language of
garbage collection, the only references we have are weak references ;)),
which makes me think that we could:

a) be more ruthless in considering these dead code
b) be more explicit in calling them "unit tests"
c) (somewhere down the line) absorb them into the rest of the test suite
instead of creating a special testing escape hatch.

>   submodule--helper: add "const" to copy of "update_data"
>   submodule--helper: pass a "const struct module_clone_data" to
>     clone_submodule()

I suspect these changes to ownership make more sense in the leaks
series. For the former patch, it would explain why we don't have to
plug leaks in "update_data". For latter, the ownership rules are still a
bit confusing (for historical reasons, not anything you introduced), so
the leak fix might help explain why the new ownership is better than
what we had before.

>   submodule--helper: stop conflating "sb" in clone_submodule()
>   submodule--helper: add skeleton "goto cleanup" to update_submodule()
>   submodule--helper: don't exit() on failure, return

IMO this refactoring doesn't really stand on its own unless we also take
the leaks fixes. Might be nice to move these to that series, but I don't
feel strongly about it.

>   submodule--helper: refactor "errmsg_str" to be a "struct strbuf"
>   submodule--helper style: don't separate declared variables with \n\n
>   submodule--helper style: add \n\n after variable declarations
>   submodule--helper: rename "int res" to "int ret"
>   submodule--helper: replace memset() with { 0 }-initialization
>   submodule--helper: convert a strbuf_detach() to xstrfmt()
>   submodule--helper: fix bad config API usage

Style and API fixes that make sense on their own :)

Since we now have an extra topic for cleanup, I wonder what you think
about incorporating [1], i.e. refactor out init_submodules() to be
called from module_update(). It's a bit big, but it would make [2]
obsolete.

[1] https://lore.kernel.org/git/kl6lbktitf6e.fsf@chooglen-macbookpro.roam.c=
orp.google.com
[2] https://lore.kernel.org/git/patch-v4-04.17-683d327752f-20220728T162442Z=
-avarab@gmail.com
