Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4203EB64D7
	for <git@archiver.kernel.org>; Fri, 23 Jun 2023 19:23:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229540AbjFWTXJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Jun 2023 15:23:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231504AbjFWTXG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Jun 2023 15:23:06 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2624A271E
        for <git@vger.kernel.org>; Fri, 23 Jun 2023 12:23:03 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id d9443c01a7336-1b7d877af61so341615ad.2
        for <git@vger.kernel.org>; Fri, 23 Jun 2023 12:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687548182; x=1690140182;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bCfrYYGztoRe1n2SgwyKKcuX9Po2epmAAQSTjZlbsag=;
        b=f4zO8vidjNcmK4VbjThPV/C6oB5D3sWQQaO/T1t5W2w3kD98h7RQtrV+AKDThkkTiP
         eiPFpJAgWqHoDldfcZ3c3NHRlwQHvMTxaMNYKKDKegWHUzpoSSrgx24LV+AShMu36uii
         ixVypVGrQkWNwR3cvlZZRgJ9lCYiBEZCAwXg1yv1y4Rk0Vkt6yM60/TubGXJ4Jz9X6HZ
         O0B+t+Wb4kxMKmzbG7qGX93g9k9pflkdqJh3kiilppp1i+2RzlCRLeadPmCeMN50yAeH
         lKpARHVg6tF++XdTk3+CmHCdpCM7BKVzueOCIPYFEVCH/z/MmEVfg3SZfUfTaRxwF8AU
         OCGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687548182; x=1690140182;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bCfrYYGztoRe1n2SgwyKKcuX9Po2epmAAQSTjZlbsag=;
        b=O9e/GTiZB6hGWyEZoWctDy3sla16OCm+NvqK1xOQ162laMtUYPXcrOxFbuQ+04vulT
         Qo6B+UwUz9/f/C68NTl/YwM4lVGUsUYebD2ifLuWZpE20xAiRgUiYuQBmvQj+pgQZaWx
         SgtwVZLhtWHsXCoTXGzymZt9Tur+FkM6nuiOUQw1Z/dsC/jForcSs+K0YcICXVHpimRV
         3P1BO719kYZ2U34TiK0JnhxjuFZTxiDUzw847ZwacAdWvvY721+2MLfXx5b3WAvFo8ih
         VUkhpd66d7Au4VHzsKEpZ/D/fxwIuEc8UHzO3EESo9CI1OyJZnoG0I6uLxy26U+oz4M9
         IDtQ==
X-Gm-Message-State: AC+VfDw9JldyKNJCIX0Uupy/8f7PxeHy0Mt/rvCYtsN/PwrKrAPDyabG
        SVIKo+zXf60JYtnZr5HhSkKGAsdId+CZtw==
X-Google-Smtp-Source: ACHHUZ4vXEtyXcRHJ74Oc5lRQeNmFQ6eWkzT0S5retGazK8qISZofO+XnFN6uOqNtXASGiaqaPu5Xgdri0rG9w==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3a07])
 (user=chooglen job=sendgmr) by 2002:a17:902:b789:b0:1b6:8a70:9c8a with SMTP
 id e9-20020a170902b78900b001b68a709c8amr1622pls.11.1687548182609; Fri, 23 Jun
 2023 12:23:02 -0700 (PDT)
Date:   Fri, 23 Jun 2023 12:22:53 -0700
In-Reply-To: <6961779f-9fd8-28cb-6046-cc24b6869cbc@github.com>
Mime-Version: 1.0
References: <CAJSLrw6qhHj8Kxrqhp7xN=imTHgg79QB9Fxa9XpdZYFnBKhkvA@mail.gmail.com>
 <6961779f-9fd8-28cb-6046-cc24b6869cbc@github.com>
Message-ID: <kl6lh6qyrnjm.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: BUG: config.c:129: kvi should not be set while parsing a config source
From:   Glen Choo <chooglen@google.com>
To:     Derrick Stolee <derrickstolee@github.com>, jkasky@slack-corp.com,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks Jesse for the bug report, and thanks Stolee for looping me in!

Derrick Stolee <derrickstolee@github.com> writes:

> On 6/21/2023 7:45 PM, Jesse Kasky wrote:
>> Thank you for filling out a Git bug report!
>> Please answer the following questions to help us understand your issue.
>> 
>> What did you do before the bug happened? (Steps to reproduce your issue)
>> 
>> git clone --no-checkout --sparse --filter=blob:none --depth=1 <repo> <dir>
>> cd <dir>
>> git sparse-checkout add <dir1> <dir2>
>> git fetch --depth=1 origin <commit>
>> Received the following error:
>> 
>> BUG: config.c:129: kvi should not be set while parsing a config source
>> [1]    5842 abort      /opt/homebrew/bin/git fetch --depth=1 origin

It took me some fiddling around to find a reproducing case, because, as
it turns out, the choice of repo is important. This bug occurs when you
have submodules + partial clone, _and_ .gitmodules has not been fetched
yet (e.g. because --no-checkout skipped the fetch).

E.g. you can see this for yourself with:

  rm -fr test-breakage &&
  git clone --filter=blob:none --no-checkout https://github.com/git/git test-breakage &&
  cd test-breakage &&
  git fetch

This BUG() assertion is meant to guard against reading config in an
unsafe nested way - the information about the config source we are
reading (i.e. the key_value_info/kvi) is global state in the config
machinery, and certain kinds of nesting will produce undefined
behavior if we try to read it.

What happens is that "git fetch" tries to read .gitmodules, which
triggers a partial clone fetch because .gitmodules is missing. But to do
this, the partial clone code reads config to figure out where to fetch
from, leading to a nested config-read-in-a-config-read.

For Git devs: the 'unsafe' thing is reading a config set while reading a
config file/params/blob/etc. In this case, we are trying to read
repo_config() (the config set in the_repository->config) while reading
.gitmodules from a blob. Reading from files while reading files is safe
(e.g. that's what we do when evaluating includes).

This should go away in my in-flight series:

  https://lore.kernel.org/git/pull.1497.v3.git.git.1687290231.gitgitgadget@gmail.com

because that removes all of the problematic global state. That's a very
big refactor, so I'm not sure we should wait until that goes in to fix
this bug. And while I'd like to fix this bug now, I don't see a point in
making the existing code 'safer' by making small changes in the
machinery that will just go away anyway.

So I think the best fix is for me to get rid of the BUG() check and go
back to the 'unsafe' behavior. It won't matter in this specific scenario
(since we don't actually need the config source information AFAICT), and
at least it doesn't make _other_ use cases worse off than before.

> I've come across this error while playing around with things in
> the config space, and the case I figured out was due to nested
> iterations over config.
>
> In my case, I was adding dynamic config loading when certain
> global variables were used, and some were used during config
> parsing causing this nesting.

Presumably this is how you were coming across this bug too: since your
experiments added config set lookups, maybe some of them were happening
in the middle of reading a config file.
