Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44426C636CC
	for <git@archiver.kernel.org>; Mon, 13 Feb 2023 23:07:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbjBMXHQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Feb 2023 18:07:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbjBMXHO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Feb 2023 18:07:14 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5E461C5BB
        for <git@vger.kernel.org>; Mon, 13 Feb 2023 15:07:13 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id nh19-20020a17090b365300b00233ceae8407so6197362pjb.3
        for <git@vger.kernel.org>; Mon, 13 Feb 2023 15:07:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bHFP06LjQCHtEnm3HWAV15Lb+VKlhOOyEhxzkRen7Uw=;
        b=lQkDRojzNiv5HZxq9hvGlHqX7LwdbXzRTlBU+96tfXv3YSWaq199tkb0umj68ZpuvX
         a4m90e3d2Yc1COqGbNFaIw2t1UvDbPo5B1GpYxYCCoUDUI95FTyqtcZlO4ciPIsVITIN
         yRppJ4TrzFJ3DZ3CDoQWczWbx7M+UHAhj+Hv1UkLhNm7iswCq3X9xS4Wqyr4D/hpqSug
         9Q8BdJ/dtd41NcvvF/eJd/ppVjSuXOVnmEEB8zh5sVINbMaCAu1iS6Phzi6ddcG6now1
         py73yMa8CpvkWMPKYlpEeLhPJkZjXdDGI75ntxq6tIbOLUgCxDqipF6HkJa/hxqB/mxW
         7TDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bHFP06LjQCHtEnm3HWAV15Lb+VKlhOOyEhxzkRen7Uw=;
        b=qLFJOxQZRqk82TKK19ReOZu+vV6h9gm7ttF1sFVJU28rVcWk4blPk6JzzoToXBns6R
         TDmrQAX2S3xXcFyuizi8Xh13+wTnwT4LjeztL+CVoWvlm/Ma7CPJ4ezTmQM8Lo85kdS8
         7wlaQoVWNDm1al+4IJJDT4FuS3C+KKlBUSYw7pKS8/mYNtjK95+hMZbUfg4JfNphIUM0
         YqTLIWWdWtaRTlxPh6snngdjqPRg1tr26EbqBZHECDYGG2QqBor/xoOmg3oMljOT+qsM
         I9mzRRG8uMyJIdwfz6McKozAfsxZ4yl29EXb3ffAjz3TqV/P8IbnqS+I4IC1bedI38/Y
         dTUw==
X-Gm-Message-State: AO0yUKVE0sYyZ2b5Mu1sYMTQOhJz1OiIHHq1+DMza3fCS2oG2o7Vz0Ln
        Mz5gr17YgpsFtu0+MhYlhldHk0tirtg=
X-Google-Smtp-Source: AK7set/jfyRmUbGadpGY3Em83zI4YoeMcPYrzyonlSvXQZuaN1alxMLFH4l1WZmey0O83khLG8qlcw==
X-Received: by 2002:a17:902:c408:b0:19a:9610:b237 with SMTP id k8-20020a170902c40800b0019a9610b237mr656305plk.45.1676329633307;
        Mon, 13 Feb 2023 15:07:13 -0800 (PST)
Received: from localhost (252.157.168.34.bc.googleusercontent.com. [34.168.157.252])
        by smtp.gmail.com with ESMTPSA id iw3-20020a170903044300b0019ab3308554sm477945plb.85.2023.02.13.15.07.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Feb 2023 15:07:12 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Calvin Wan <calvinwan@google.com>
Cc:     git@vger.kernel.org, Josh Steadmon <steadmon@google.com>
Subject: Re: [RFC PATCH 4/6] tests: use `git submodule add` and fix expected
 diffs
References: <20230213182134.2173280-1-calvinwan@google.com>
        <20230213182134.2173280-5-calvinwan@google.com>
Date:   Mon, 13 Feb 2023 15:07:12 -0800
In-Reply-To: <20230213182134.2173280-5-calvinwan@google.com> (Calvin Wan's
        message of "Mon, 13 Feb 2023 18:21:32 +0000")
Message-ID: <xmqqy1p188rj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Calvin Wan <calvinwan@google.com> writes:

> From: Josh Steadmon <steadmon@google.com>
>
> This commit continues the previous work of updating the test suite to
> use `git submodule add` to create submodules instead of using `git add`
> to include embedded repositories. Specifically, in this commit we update
> test cases where expected diffs must change due to the presence of a
> .gitmodules file.

Good that these "same" tasks are split into two steps, ones that
don't notice the additional presence of .gitmodules (i.e. the
previous step) and the result that do.

Strictly speaking, gitlink support in the index and trees does not
have to be used to record submodules, and changing all "git add" to
"git submodule add" is somewhat a sad change that closes the door to
those folks who want to use the mechanism for implementing "better
submodules" that do not depend on a separate .gitmodules files, for
example.  To leave the door open, "git add" may need to learn an
overriding mechanism allow adding a gitlink to the index without
anything else.  And then this step could use "git add -f" (or
whategver the overriding mechanism) instead of "git submodule add",
without changing the expected diff output.

Would such a tweak make this step better?  I dunno.

>  t/t3040-subprojects-basic.sh                 |   3 +-
>  t/t4041-diff-submodule-option.sh             | 153 ++++++++++++++++++-
>  t/t4060-diff-submodule-option-diff-format.sh | 125 +++++++++++++--
>  t/t7506-status-submodule.sh                  |  15 +-
>  4 files changed, 278 insertions(+), 18 deletions(-)
