Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFAC5C77B6E
	for <git@archiver.kernel.org>; Wed, 12 Apr 2023 05:43:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229630AbjDLFnF (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Apr 2023 01:43:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjDLFnD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Apr 2023 01:43:03 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA1A85B82
        for <git@vger.kernel.org>; Tue, 11 Apr 2023 22:42:39 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id c3so11327141pjg.1
        for <git@vger.kernel.org>; Tue, 11 Apr 2023 22:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681278130; x=1683870130;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g6ic/QfIRxXKe9AlGOVkQ9rWmolrxVZEOdiLji47WzY=;
        b=jV2sCJA6DL2wbWP6zMivP2GfTkrGCLAe81GYzykwLNhZjjnuFyZOIEK+PUtCayvoyc
         3S/Lp/yw1k5dmEhvTFd5g9R7f2fPgxvZyRDFT6/hVz9mb/0/nrd9N9n7C87rKsSVdIe6
         Is3NhpGKdAkWUuGeSNZUisdaf19QtvfVz4fzv7jQp9vGs98Gd9YQOwdlLBiNI3GVt3Wt
         6GSe+4NTZm5HBFOPcHvqrGImnV54hJtDaJNbPBCkgn3ONkorsXBoLw+SVbPpCJTkvVcE
         8k0st+OX8Z6QnjOMglGuSGsJMAeyrghy/849TndsJuVM0wF+kCw2PHGBQIOC6h3y//+I
         Sm5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681278130; x=1683870130;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=g6ic/QfIRxXKe9AlGOVkQ9rWmolrxVZEOdiLji47WzY=;
        b=z9LUj45+pzbBej+aUW9sESmffBMYkz0+tDrCNBqF+BNqFwzddZvZYOSJUg5xuvq5KA
         TEQNKlNOs6obtqeSV2JEOvVIDkQmVdq+gHu1DgvwxuvnoKmmc0tXBdrxkARvb9sR9j9f
         7/IINhjiTiy5tbJbfU3TzP45M9ZBgPFrnGqrCUaMzUswk92gnt6gO/X7WBDD6LrCFgr4
         Ord8ZriyUUxpuiJT0d5jelsKjPBrUd3Mpxf+r4nHTDvqb1/OStsKetZGkOCWxJn0blnc
         mbintan9c8PSz/yd0tvsCNM0WY+ZT731Qg3lyL6yzaZqaCyYiGCzTuFsPG9PvAkscT3Q
         rLSQ==
X-Gm-Message-State: AAQBX9e2+RFYs6l5O5/V1bidm6A7IYtTg+ZzGIYqyGE7ItXXL0oVFAzh
        wGZKj+mjEeTiBGJJTkPnZTo=
X-Google-Smtp-Source: AKy350Z86W3d/ljGDNxQHF/qBRMQWzoX/Fi1QnVDgcABuzXzz9bxsMTB8HfGMHndgosjXDIA52MuwQ==
X-Received: by 2002:a17:902:d4ce:b0:1a0:6bd4:ea78 with SMTP id o14-20020a170902d4ce00b001a06bd4ea78mr16705306plg.31.1681278130478;
        Tue, 11 Apr 2023 22:42:10 -0700 (PDT)
Received: from localhost (254.80.82.34.bc.googleusercontent.com. [34.82.80.254])
        by smtp.gmail.com with ESMTPSA id ix10-20020a170902f80a00b001a64c4023aesm628251plb.36.2023.04.11.22.42.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Apr 2023 22:42:09 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "Eric DeCosta via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Glen Choo <chooglen@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Taylor Blau <me@ttaylorr.com>,
        Eric DeCosta <edecosta@mathworks.com>
Subject: Re: [PATCH v5 0/6] fsmonitor: Implement fsmonitor for Linux
References: <pull.1352.v4.git.git.1669230044.gitgitgadget@gmail.com>
        <pull.1352.v5.git.git.1670882286.gitgitgadget@gmail.com>
Date:   Tue, 11 Apr 2023 22:42:09 -0700
In-Reply-To: <pull.1352.v5.git.git.1670882286.gitgitgadget@gmail.com> (Eric
        DeCosta via GitGitGadget's message of "Mon, 12 Dec 2022 21:57:59
        +0000")
Message-ID: <xmqqzg7d8xn2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Eric DeCosta via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Goal is to deliver fsmonitor for Linux that is on par with fsmonitor for
> Windows and Mac OS.
>
> This patch set builds upon previous work for done for Windows and Mac OS to
> implement a fsmonitor back-end for Linux based on the Linux inotify API.
> inotify differs significantly from the equivalent Windows and Mac OS APIs in
> that a watch must be registered for every directory of interest (rather than
> a singular watch at the root of the directory tree) and special care must be
> taken to handle directory renames correctly.
>
> More information about inotify:
> https://man7.org/linux/man-pages/man7/inotify.7.html
>
> v4 differs from v3:
>
>  * Code review feedback

This has been dormant for full four months, and it seems to break
linux-asan CI job when merged to 'seen',

  https://github.com/git/git/actions/runs/4672116751/jobs/8273938089

while the same 'seen' excluding this topic passes everything.

  https://github.com/git/git/actions/runs/4674694371

For now, I'll drop this topic from 'seen'.

Thanks.

