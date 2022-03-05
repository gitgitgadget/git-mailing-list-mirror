Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEF57C433EF
	for <git@archiver.kernel.org>; Sat,  5 Mar 2022 00:22:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230083AbiCEAXE (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Mar 2022 19:23:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiCEAXD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Mar 2022 19:23:03 -0500
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B2CE274034
        for <git@vger.kernel.org>; Fri,  4 Mar 2022 16:22:15 -0800 (PST)
Received: by mail-pg1-x549.google.com with SMTP id bm16-20020a656e90000000b00372932b1d83so5294402pgb.10
        for <git@vger.kernel.org>; Fri, 04 Mar 2022 16:22:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=7r0fkYWYVsXU7JHRJcEfbMEs5M2Il/dSEDQtOnG+07o=;
        b=rn6YBYMhhrON03rBMkBWbDlmXPAhJjIY/PeuwHDMlaP6WW/AaSYtdAhJg8CFsgmC2J
         Z5dSH3DZKdNmtx2FlhyeMdIK8Numvd72UpkuUPsiC7YI9Jpkq0n/e39LMe6rrOe4KiUy
         GdGoS/JEqnh3tuWJCVtgYbVlqUBR2es7819VZQ3ziK0Zg8Cp0hzfC/P0TMD23LAThBaO
         xAkV3gV0AUj7Lcx6Xq3yWBghUEbdcHD7Ti8rfTOsP82s+bqbn1XbSDHsi4MGB8gW4NMM
         qe5ColQOItpDbX40amR3ME8JgJtumJkzcYLFpcJ5txYU3bO1s1eYuPyWlMHbI2T5EphO
         +TsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=7r0fkYWYVsXU7JHRJcEfbMEs5M2Il/dSEDQtOnG+07o=;
        b=2QvqiSYNnZJApjgZT9VGq/9P4cmrLQzVJY8z1OWut1mCcbvs38+/a8qAlltMjKPOwr
         Fx1VNNIf2IfD73Jl1HQexgjTv7HoLllEDA4FNys9dWvNbs2rdMnMxmIAmAoUE5NLlamW
         Lc5fIU9K2/pdS4HMFcugqEtXNOZpotHhkdF1XWaoxWREYJQFvxs86CKD/w2E34IpxO5P
         a0lVOmj+Jfmm1F0XqEZ3OMJ58tRUY21UOIc5kfiYDi+0advsNPtZ69sWjErSUv/XzVxm
         fI3MMYOUX1XVSYnvKV80N6cGyc18eLNBEIBDbqWBcePmV/1itO7Fal33/CZTZ/KectdS
         N+4A==
X-Gm-Message-State: AOAM533+V0d9B/PAENZSdOgDxm0kMEnOy9xUzKD3uCh3IqJdAXEks9xm
        aKAYLb4LZ59DG5tSL24InQYTniNV+sPpPw==
X-Google-Smtp-Source: ABdhPJy2IwIbxkX/wTVE6B7een8Ol/pBFbQTkmtm/33k0OoUYJDOjP++L6j5eACyuLgQtFSiAFwnFSjyZsfBxw==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a05:6a00:1a8f:b0:4e1:cde3:7bf7 with SMTP
 id e15-20020a056a001a8f00b004e1cde37bf7mr1323515pfv.52.1646439734599; Fri, 04
 Mar 2022 16:22:14 -0800 (PST)
Date:   Fri, 04 Mar 2022 16:22:12 -0800
In-Reply-To: <20220304234622.647776-1-jonathantanmy@google.com>
Message-Id: <kl6l4k4d45aj.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <20220304234622.647776-1-jonathantanmy@google.com>
Subject: Re: [PATCH v3 09/10] fetch: fetch unpopulated, changed submodules
From:   Glen Choo <chooglen@google.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> Glen Choo <chooglen@google.com> writes:
>> > What's the error message printed to the user here? (Just from reading
>> > the code, I would have expected this to succeed, with the submodule
>> > fetch being from same-name-1's submodule since we're fetching submodules
>> > by name, but apparently that is not the case.)
>> 
>> Yeah, I think this might trip up some readers. The message is:
>> 
>>   From ../same-name-2
>>     b7ebb59..944b5ac  master     -> same-name-2/master
>>   Fetching submodule submodule
>>   fatal: git upload-pack: not our ref 7ff6874077503acb9d0a52e280aaed9748276319
>>   fatal: remote error: upload-pack: not our ref 7ff6874077503acb9d0a52e280aaed9748276319
>>   Errors during submodule fetch:
>>           submodule
>> 
>> Which, I believe, comes from how we fetch commits by oid:
>> 
>>   static int get_next_submodule(struct child_process *cp, struct strbuf *err,
>>               void *data, void **task_cb)
>>   [...]
>>     oid_array_for_each_unique(task->commits,
>>           append_oid_to_argv, &cp->args);
>> 
>> When the following is true:
>> 
>> - the submodule is found in the index
>> - we are fetching submodules unconditionally (--recurse-submodules=yes")
>> - no superproject commit "changes" the submodule
>> 
>> task->commits is empty, and we just fetch the from the submodule's
>> remote by name. But as long as any superproject commit "changes" the
>> submodule, we try to fetch by oid, which, as this test demonstrates, may
>> fail.
>
> Ah, so we try to fetch an OID from a submodule given by a fetched
> commit, which is different from the submodule the client already has
> locally. This might be a sign that we need to store more information
> about the submodule so that we can print a clearer message. I haven't
> looked into this deeply, but this might be possible by putting more
> information in the util of changed_submodule_names, and when we have
> already seen that submodule, to add more information to the util instead
> of skipping it.

Storing the submodule URL might achieve this purpose, but if the URL
doesn't match, I think we'd want to skip the commit instead of trying to
fetch a commit from an unrelated URL. I don't know if this is a good
idea though yet - I haven't looked deeply into what Git uses the URL for
and whether users might want to change the URL even though the submodule
is the 'same' (e.g. pointing the URL to another remote instead of having
two completely different repos with the same submodule name).
