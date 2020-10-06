Return-Path: <SRS0=+hCi=DN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9602EC46466
	for <git@archiver.kernel.org>; Tue,  6 Oct 2020 03:57:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 44F9D208B6
	for <git@archiver.kernel.org>; Tue,  6 Oct 2020 03:57:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ayyg2cNs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725909AbgJFD5O (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Oct 2020 23:57:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726858AbgJFD5O (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Oct 2020 23:57:14 -0400
Received: from mail-vk1-xa44.google.com (mail-vk1-xa44.google.com [IPv6:2607:f8b0:4864:20::a44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35803C0613CE;
        Mon,  5 Oct 2020 20:57:14 -0700 (PDT)
Received: by mail-vk1-xa44.google.com with SMTP id d125so1557558vkh.10;
        Mon, 05 Oct 2020 20:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HH7xhhlnmd3Dg58XEz48SP2OGgWs2Ku3LIn7+NT7bjM=;
        b=Ayyg2cNsss3TC8/XzOvjJfWBuW+gWaQfFYHV2Mq4P7hb7xGzJvOINM3oPb2VPA2fxF
         8DveQoAU0vh1gBH+6y90xZGKZstXd5cdPYTzvfzu/UNgUSIC7hB5a0xwlhoob2N6wDtK
         buP3W5ay9aIc8mEjzpRowyEWP4+DGdjlfrFRWCSDLoB0driy8YaFTyYlrtrDxGpbXQz+
         1Psklb1Ktj5zPJrqO0MsDQdh4W1LX5Wa6PqUht0fTIoSW6Zk5J8HDzlHmAYc8WmnY5xh
         K0rJI+zQ08PXT2cgoEE9xrdGc58RCEMRJZTvc6qrzloeFRqYR18y4K88A19crq3ZIxlq
         aB7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HH7xhhlnmd3Dg58XEz48SP2OGgWs2Ku3LIn7+NT7bjM=;
        b=h398eU/MVYIhhd610A2uYboA9/4ckggNw/heeR5QO8ox1JlGO2/Sz6o5nmAkjH6l8O
         L673KKn/IjSoeu0h7AVS1DY8aKMHAFZ5ODiogdb89WGdxGVcGEJec+WrizVq0oStA3JQ
         G4FElxHdfeRCljNqn2XtseqAR4JHjwoGp6ezD3BV0ubnfZ+/NDTCMpbvaN6UviwgyrNK
         I43ol1idWrPlbSXmEIwIQrsVe8xE9Zh/DhfxUfYg8qtghSQkE3g5OXP7Oz4Drf8NO5XP
         1zzzvH/ArTGGd5BobFCJ1UeM82AjCSGF7bi0oqd6G0sTuCZSZf6k7bNcGMCNL/QzU2Zo
         ZQ/Q==
X-Gm-Message-State: AOAM5312dV3FrVa1j/httTnxA5cqxpryLYaIOlZ0A/oyjH3I/zyO7kC9
        e0rav9SK+6L6Qn40ts7FnPMncMaNgHxpNL86plI=
X-Google-Smtp-Source: ABdhPJyrMJkL/lB7fMsFdh79DyNTsPpi0AcOzskikSuFaCZjatVVdBQ7wM7aU+DIflncfB9lZcpBFCQ+uutXgOVMU1o=
X-Received: by 2002:a1f:a5d2:: with SMTP id o201mr2047770vke.15.1601956633406;
 Mon, 05 Oct 2020 20:57:13 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqa6x070tn.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqa6x070tn.fsf@gitster.c.googlers.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Tue, 6 Oct 2020 05:57:02 +0200
Message-ID: <CAN0heSrKgNSHKDL07-BWrbF9n6fyWUZVDykdHPCD6CfwgV8QNA@mail.gmail.com>
Subject: Re: [ANNOUNCE] Git v2.29.0-rc0
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        git-packagers@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

Thanks for the release candidate!

Minor comments follow.

On Tue, 6 Oct 2020 at 01:00, Junio C Hamano <gitster@pobox.com> wrote:
>  * The final leg of SHA-256 transition plus doc updates.  Note that
>    there is no inter-operability between SHA-1 and SHA-256
>    repositories yet.

I suspect the dash in "inter-operability" should be dropped.

>  * Various callers of run_command API has been modernized.
>    (merge afbdba391e jc/run-command-use-embedded-args later to maint).

s/has/have/

>  * List of options offered and accepted by "git add -i/-p" were
>    inconsistent, which have been corrected.
>    (merge ce910287e7 pw/add-p-allowed-options-fix later to maint).
>
>  * Various callers of run_command API has been modernized.
>    (merge afbdba391e jc/run-command-use-embedded-args later to maint).

Here's that entry again from my previous comment.

>  * "git status" has trouble showing where it came from by interpreting
>    reflog entries that record certain events, e.g. "checkout @{u}", and
>    gives a hard/fatal error.  Even though it inherently is impossible
>    to give a correct answer because the reflog entries lose some
>    information (e.g. "@{u}" does not record what branch the user was
>    on hence which branch 'the upstream' needs to be computed, and even
>    if the record were available, the relationship between branches may
>    have changed), at least hide the error to allow "status" show its
>    output.

s/show/to &/ ?

>  * There is a logic to estimate how many objects are in the
>    repository, which is mean to run once per process invocation, but

s/mean/meant/, I think.

>  * The "unshelve" subcommand of "git p4" used incorrectly used

s/used // (without 'g' flag!)

Martin
