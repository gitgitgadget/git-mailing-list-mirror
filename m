Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5715C2B9F2
	for <git@archiver.kernel.org>; Sat, 22 May 2021 11:17:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B19EB61164
	for <git@archiver.kernel.org>; Sat, 22 May 2021 11:17:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230393AbhEVLS3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 22 May 2021 07:18:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230236AbhEVLS2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 May 2021 07:18:28 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65CAFC061574
        for <git@vger.kernel.org>; Sat, 22 May 2021 04:17:04 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id 76so22390531qkn.13
        for <git@vger.kernel.org>; Sat, 22 May 2021 04:17:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ovAYrozp/cSvlm3TgxC09c/v5eVD6nYWdxojxiEFs0s=;
        b=V2Xr0UWyMm0cDAwR09INUZ9f1g1YMC9ocCgZ7Ht9T/xtPu+fJYuH9SMZYVr0D8ed4m
         YTxGQNt53vBSXTl3Cf0myJ62X+4WeMdxuFhBO/jJNlCQc7QyFlCLbC2jG8ScYUUQVtGv
         v8xFmmB6GbZzzTauVSGhVNBM9e+XoOS3J3xxOnP4PEnCOdkfe2b4BzBv7U0qbQEh75Dl
         ROns7G5lKGZavFkfOr9yguImabWLA4/RC+NdQEzXZEQjGvtDUggI4h/cNL2PckMt13oz
         EVdFiydDebXndUwIQh6LyqHhH4NIvV0biVlCGeKaM2EpsOyM380AJ6jofDd9HSt7JecF
         2KAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ovAYrozp/cSvlm3TgxC09c/v5eVD6nYWdxojxiEFs0s=;
        b=IIrnXAGfj/AsbUiZu8Ddc7u/lrfb6kVNMq7VXrtdW7vVJFok8OPmNKJ4rkpZykJl+C
         K2GWc5gIA7ndWieC/aACjBaffTXsjrdCIGHP04mSOS3sQO+1uNIANNsbdE2ityqfAi+L
         y4EBeUcObjzg4QrXmZCheEMNGclWnYLUca2ASQSBlSayVmW6i6ZrElWTRc9y2nLf1ueQ
         wIQp5PGhoAgw2QV5dMom3KBi6/Rk5kOvIY+qRPrA/QeK79fsUuW8d0Pq+5Z2ThaSTyVR
         +in7pov8zIhJJTaByR551pNtWIQx8oF8cx6Du4ddgkpzgyPi2RWvxS1NMINZDwdygxed
         p4wQ==
X-Gm-Message-State: AOAM531SIq7u80v1jIqF5hcprIkSBJGaBS7iVp3vGT7hQ98MMP5tVBh3
        oCUnI6ox56oFP/a222WsM2E=
X-Google-Smtp-Source: ABdhPJxlReV7+gg7B9QKH6V4gbCnrbsOT/ZMHgn196qj02JfAr0WjOsgq1p+Mng4sB0xxIElMi82+g==
X-Received: by 2002:a05:620a:12a6:: with SMTP id x6mr17106985qki.364.1621682223391;
        Sat, 22 May 2021 04:17:03 -0700 (PDT)
Received: from Derricks-MBP.attlocal.net ([2600:1700:e72:80a0:1d24:e7dd:dfbe:c524])
        by smtp.gmail.com with ESMTPSA id f13sm5933655qkk.107.2021.05.22.04.17.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 May 2021 04:17:02 -0700 (PDT)
Subject: Re: [PATCH v2 13/13] merge-ort, diffcore-rename: employ cached
 renames when possible
To:     Elijah Newren <newren@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <dstolee@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Taylor Blau <me@ttaylorr.com>
References: <pull.859.git.1616621553.gitgitgadget@gmail.com>
 <pull.859.v2.git.1620094339.gitgitgadget@gmail.com>
 <91b6768adf2d1777219fb2d83cc2363f1497dbbd.1620094339.git.gitgitgadget@gmail.com>
 <f0c50259-5627-482b-1daf-b73819cde108@gmail.com>
 <CABPp-BFdxn9f0-jUjY6Ake_6kX-jeN1EEzpeJeTg+TV4wfepwg@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <48f5d6f8-0ad9-0622-58a6-9887f797f4e7@gmail.com>
Date:   Sat, 22 May 2021 07:17:01 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <CABPp-BFdxn9f0-jUjY6Ake_6kX-jeN1EEzpeJeTg+TV4wfepwg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/19/21 8:36 PM, Elijah Newren wrote:
> On Mon, May 17, 2021 at 7:23 AM Derrick Stolee <stolee@gmail.com> wrote:>> As I was reading, I was also thinking that it would be good to
>> have some kind of tracing, if only a summary of how often we
>> relied upon the cached renames.
> 
> That's an interesting thought.  If there are renames that remain
> cached, the code always uses them (whether we need the cached rename
> or not doesn't matter since we already have it and it is cheap to
> use), so a summary would probably be the only thing that would make
> sense.
> 
> The easiest summary of how often we rely upon cached renames, is
> checking if we have enough to avoid calling diffcore_rename_extended()
> entirely.  That's precisely what the code above does that you are
> responding to.
> 
> What more information could we get out?  I guess we could get ever so
> slightly more information by tracking how many times we decide that
> the cache from a previous merge can be re-used (by tracking the number
> of times that cached_valid_side is set to 1 or 2 instead of 0).  Since
> we sometimes have some cached renames but not enough to skip rename
> detection (because source paths that were irrelevant in previous
> commits are marked relevant for the current commit), this would be an
> independent number from the region_enter-diffcore_rename count used
> above.
> 
>> That would present a mechanism
>> for the test cases to verify that the rename cache is behaving
>> as expected
> 
> How so?  I did check something like that above with verifying I was
> able to reduce the number of calls to diffcore_rename_extended() while
> still getting the expected result (which can only be done if renames
> are known).  The only additional thing I can think of we could check
> would be a testcase where renames are cached and can be re-used but
> it's not enough to avoid calling diffcore_rename_extended().  Did you
> have something else in mind?
> 
>> but also provides a way to diagnose any issues that
>> might arise in the future by asking a user to reproduce a
>> problematic rebase/merge with a GIT_TRACE2* target. Such a
>> change would fit as a follow-up, and does not need to insert
>> into an already heavy patch.
> 
> I'm not sure what information could be recorded that would help
> diagnose any such issues.  "9 out of 10 commits in your rebase reused
> cached renames" just doesn't seem granular enough to help.  Is there
> something else you were thinking of recording?

My initial thought was to include basic summary statistics, such
as "number of cached renames used" and "number of new renames" and
"number of invalidated cached renames" or something, summarized per
commit in the list. The information might not be a clear way to
find a root cause to a strange rebase, but it would help someone
looking for the root cause to know whether this rename cache is
involved or not.

As for the use in the test cases, we might be able to see the list
of trace2 results and extract the number of each type of statistic,
matching them to our expectations. That might make the tests too
fragile to future changes, though.

I'm commenting also on your v3 that we don't need to pursue the
trace2 idea right now, and can do it if we find it necessary to
diagnose any issues with the feature.

Thanks,
-Stolee
