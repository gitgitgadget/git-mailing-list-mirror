Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2F80C433F5
	for <git@archiver.kernel.org>; Fri,  7 Jan 2022 18:46:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230222AbiAGSqc (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Jan 2022 13:46:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230193AbiAGSqa (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Jan 2022 13:46:30 -0500
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB95BC06173E
        for <git@vger.kernel.org>; Fri,  7 Jan 2022 10:46:29 -0800 (PST)
Received: by mail-yb1-xb34.google.com with SMTP id m6so8926055ybc.9
        for <git@vger.kernel.org>; Fri, 07 Jan 2022 10:46:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1fJmyTfGvhdQImLIMjFkqH5pdwbHQkh8QySRXxr2vxU=;
        b=n7FeT7mD4fNGwDP/b6g+V9op8T0QRtapVp7i1P+cZGP8Oturl/pugOiZSMWX1BGEy2
         pwmpuv9K4r85Sepddg89AKbdRh98YJYToTxdCBLuOwZRBx1YZOZxzC92uYdEhHhY1nus
         zZZcmmoUPRrpVocV6aGoG0Ybs2aVBCXTpeBvoHjMEvaSw/uy61bcMNuRDvXANMJzxgu7
         bHm/eD9OVi48oooNc9dCi0MVU99paldZpd1LDtA07eSfOVdmgr8sNeJniAXFC9SDg7+H
         s85Gq+iwXtrYeLduBqWnWsKDKgkSyq6X5blb13nm5WmzIo3ulUGlwqdArl64C/f7xq/B
         caxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1fJmyTfGvhdQImLIMjFkqH5pdwbHQkh8QySRXxr2vxU=;
        b=x/j+6nTVjhtb2ldOkrzpduh7/qP+LQUn0L1Tq67DeUQlaxRObNbRbmORDmitrgakyj
         NGPVC7gLia4Ed9A+51lUZnSlZTbLvTvOnBeywQOxNYUBy6K1u8uyNHcaR+L0FBEq6Ghd
         r2WpjwChk4LR2rVkQgwE/PViN/CDa0zw3v/4XvDEyP/sylBHqCv7bk3j/nXjVd8kLZmS
         QtE592+FdUSQIeuImbkGlwK8kDm9bnvhDu1bWQaNkHvdIdXoTlExZtk4adU5pdfD4iH2
         N4GDp/mYXcYbGPVFeVrWZqp45NMN2ezbnGdmKHxd66QbCPrPbPlu32VjNPKPJsFwYfk8
         ub9A==
X-Gm-Message-State: AOAM533tX1nFSCsiQixRJwUk5VSGO0WqTCvxvfYIyW7TA0a97ZwjzLko
        eD1hPuZZDHBPEoMFlp60zfG29jHolUd6P3xzkAC/L7yrr4Q=
X-Google-Smtp-Source: ABdhPJyJO04Pka0Mma1lbdoKd3mDs7hguvNu7gAPjEJUJZ+FKR2y+ZTnZdaZoJQ5hzljoA/tRVGdfMMEwH4OGIcnZ+o=
X-Received: by 2002:a25:d749:: with SMTP id o70mr79355590ybg.415.1641581188945;
 Fri, 07 Jan 2022 10:46:28 -0800 (PST)
MIME-Version: 1.0
References: <pull.1114.git.git.1640927044.gitgitgadget@gmail.com> <pull.1114.v2.git.git.1641403655.gitgitgadget@gmail.com>
In-Reply-To: <pull.1114.v2.git.git.1641403655.gitgitgadget@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Fri, 7 Jan 2022 19:46:17 +0100
Message-ID: <CAP8UFD1Z74yuUmzPCr6X8-i2B1zaiT8kPxNDHxK5MeHw8OcnRg@mail.gmail.com>
Subject: Re: [PATCH v2 0/8] RFC: Server side merges (no ref updating, no
 commit creating, no touching worktree or index)
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git <git@vger.kernel.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Altmanninger <aclopte@gmail.com>,
        Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 5, 2022 at 6:27 PM Elijah Newren via GitGitGadget
<gitgitgadget@gmail.com> wrote:

> This series attempts to guess what kind of output would be wanted, basically
> choosing:
>
>  * clean merge or conflict signalled via exit status

(Maybe s/signalled/signaled/)

Not sure that's the best way by default. I think it's very likely that
many users will be interested in parsing the command ouput, and they
might prefer that merge related errors be signaled in a different way
than other errors.

>  * stdout consists solely of printing the hash of the resulting tree (though
>    that tree may include files that have conflict markers)

Maybe users will want diffs, the conflicted list and other things on
stdout, as they might want to parse it anyway, and it would be a
burden to have to perform diffs, or get other interesting info in a
different way or using a different process or call.

>  * new optional --messages flag for specifying a file where informational
>    messages (e.g. conflict notices and files involved in three-way-content
>    merges) can be written; by default, this output is simply discarded
>  * new optional --conflicted-list flag for specifying a file where the names
>    of conflicted-files can be written in a NUL-character-separated list

It would be nice if output was printed on stdout when the above flags
are used without argument.

Thanks for working on this!
