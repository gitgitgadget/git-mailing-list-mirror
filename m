Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 810BCC433DB
	for <git@archiver.kernel.org>; Fri,  8 Jan 2021 07:50:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 38CA523447
	for <git@archiver.kernel.org>; Fri,  8 Jan 2021 07:50:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728008AbhAHHub (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Jan 2021 02:50:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726863AbhAHHua (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Jan 2021 02:50:30 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F295BC0612F4
        for <git@vger.kernel.org>; Thu,  7 Jan 2021 23:49:49 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id cw27so10279006edb.5
        for <git@vger.kernel.org>; Thu, 07 Jan 2021 23:49:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=references:user-agent:from:to:cc:subject:message-id:in-reply-to
         :date:mime-version;
        bh=bIxmeiaYBbyIyS0z10xVyioLbPyqnSPIWgU6I1qZQqs=;
        b=K4bJTytDmnC9TOmd7Hsh6RH78e3VSx3tYh1A4eTrOb43ESfHQ7MnJnaT3QNBK0omhZ
         3CTEcjojh1WcTSpb1u81Tio+b6SBH4l/0upuBWYfv13nbxuH9cZtizv2isCD9MSE2/t8
         TeIi8WBE4rdFmBTWHCO6KfMUTO+qA3E5a72Zm1hBqQdzABinvKCBRFaU27DkA38bH2yG
         SVNhwX3UVtZk6vVi50g36fcOyIjkGMNDAEgMncfX0vPkezYRyLuCifGGiMj2qb09F7ZK
         i5EK/SKxKAHoWvkVq0xu6Vpz0tfyXiMVAEPCXd6JQiqPeKrLZVk8cLsKqc/Nzij4A2KL
         9stQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :message-id:in-reply-to:date:mime-version;
        bh=bIxmeiaYBbyIyS0z10xVyioLbPyqnSPIWgU6I1qZQqs=;
        b=AmHPRjdGJwFz5ZXCr+ENRaPD30hkckMLnOFYfqWCo3sG99RxctE+zQVz4//BdcpR6m
         2TUVdeE1cIUfYM8A3+dtLLQjOtCUqcxXfNqaq9eYW5AXZum8xgY/Avi7q1qoQh3sEfRp
         Vp9Kd3IQc0rq10oJ1J5AzralBH+VLxS+0Ze+FEjBzJGTw7EXo2bF/JDdG5CdKhZD2vQW
         SPR6i7ehrQNW70qrx8fhe6aI/ZHkWbufZWcjpNkf8bp4ld3PigRAxa6FO4XtTBuJ07cn
         EdVaPA2Ma3wdMIh+CCJL8A4YGHjcMG45+OE1UPRKuzRTehZhSm5ykbwCqGBa2cEB/huO
         G0Hw==
X-Gm-Message-State: AOAM5317G3utsa/XRe7fuJhQq2ACLPi1kx/RlWrHMwm4WD+PKateRLlG
        wJ1pzk0McGrGBjbaBQ1tem6dbmOkXyl+VA==
X-Google-Smtp-Source: ABdhPJyJmFTKAtIltY+3qnxc07i6Eko1AA4Duz1pwZER6wbEb1GT8P+8wXZZ5FVgw20Gh2uPlnHAbg==
X-Received: by 2002:a05:6402:40e:: with SMTP id q14mr4372576edv.85.1610092188351;
        Thu, 07 Jan 2021 23:49:48 -0800 (PST)
Received: from cpm12071.local ([212.86.35.64])
        by smtp.gmail.com with ESMTPSA id n4sm3497735edt.46.2021.01.07.23.49.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jan 2021 23:49:47 -0800 (PST)
References: <20210104162128.95281-1-rafaeloliveira.cs@gmail.com>
 <20210104162128.95281-8-rafaeloliveira.cs@gmail.com>
 <CAPig+cRtd9V_ko1gNmueKWbJvna80mMgdvj6_06afK8JzypAOg@mail.gmail.com>
User-agent: mu4e 1.4.13; emacs 27.1
From:   Rafael Silva <rafaeloliveira.cs@gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: [PATCH 7/7] worktree: document `list` verbose and prunable
 annotations
Message-ID: <gohp6kturrc2fk.fsf@gmail.com>
In-reply-to: <CAPig+cRtd9V_ko1gNmueKWbJvna80mMgdvj6_06afK8JzypAOg@mail.gmail.com>
Date:   Fri, 08 Jan 2021 08:49:47 +0100
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Eric Sunshine writes:

> On Mon, Jan 4, 2021 at 11:22 AM Rafael Silva
> <rafaeloliveira.cs@gmail.com> wrote:
>> Update the documentation with "git worktree list" verbose mode, prunable
>> and locked annotations for the default and porcelain format as part of
>> teaching the command to show prunable working trees and verbose mode.
>>
>> Signed-off-by: Rafael Silva <rafaeloliveira.cs@gmail.com>
>> ---
>> diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
>> @@ -226,9 +227,12 @@ This can also be set up as the default behaviour by using the
>>  -v::
>>  --verbose::
>>         With `prune`, report all removals.
>> +       With `list`, output additional information for working trees.
>
> This leaves the reader wondering what additional information is output
> for `list`. Perhaps a small tweak will help:
>
>     With `list`, output additional information about worktrees (see below).
>

Make sense.

>>  --expire <time>::
>>         With `prune`, only expire unused working trees older than `<time>`.
>> +       With `list`, annotate unused working trees older than `<time>` as prunable
>> +       candidates that will be remove by `prune` command if the same option is used.
>
> Perhaps just minimal:
>
>     With `list`, annotate missing worktrees as prunable if they
>     are older than `<time>`.
>

Sounds reasonable.

>> @@ -367,13 +371,48 @@ $ git worktree list
>> +The command also shows annotations for each working tree, according to its state.
>> +These annotations are:
>> +
>> + * "locked", if any working tree is locked
>> + * "prunable", if any working tree can be pruned via "git worktree prune".
>
> s/any/the/g
>
> We might want to use backticks around these annotations rather than
> double quotes, and we certainly do want to use backticks around the
> `git worktree prune` command to ensure it is styled consistently with
> other commands in this document.
>

Yes, good catch. It make sense to have backticks here.

>> +Note that, the annotation is only moved to the next line only if the
>> +additional text is available, otherwise the text is kept on the same.
>
> Drop the comma between "that, the". Also, too many "only"s in this
> sentence. You can actually drop both of them and the sentence will
> still read fine:
>
>    Note that the annotation is moved to the next line if the
>    additional information is available, otherwise it stays on
>    the same line as the worktree itself.
>
> or something.
>

Thanks for the alternative suggestion. It reads better like this will
add change the patch message to something more close to your suggestion.

>>  Porcelain Format
>>  ~~~~~~~~~~~~~~~~
>>  The porcelain format has a line per attribute.  Attributes are listed with a
>>  label and value separated by a single space.  Boolean attributes (like `bare`
>>  and `detached`) are listed as a label only, and are present only
>>  if the value is true.  The first attribute of a working tree is always
>> -`worktree`, an empty line indicates the end of the record.  For example:
>> +`worktree`, an empty line indicates the end of the record.
>> ++
>> +In case any of the working trees are locked or is a candidate for pruning
>> +(See DESCRIPTION above) the labels "locked" and "prunable" is also shown
>> +followed by a reason, if available, otherwise only the labels are listed.
>> +For example:
>
> s/(See/(see/
> s/is also/are also/
>
> Let's also use backticks rather than double quotes around `locked` and
> `prunable` to ensure consistent formatting with the other porcelain
> labels `bare` and `detached` which are already in backticks.
>

Nice catch. 

> Also, the unnecessary `+` line (seen as `++` in the diff) makes this
> render incorrectly. It renders as:
>
>     +In case any...
>
> To fix it, just leave the line blank between paragraphs.
>
> (If possible, install `asciidoc` and `xmlto` and then run `make html`
> to render the documentation yourself, and open
> Documentation/git-worktree.html in your browser to check the output.)

Sure thing. thanks for the suggestion. I should have rendered the
documentation before sending. Apologize for that.

-- 
Thanks
Rafael
