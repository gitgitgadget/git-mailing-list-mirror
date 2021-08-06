Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2C4EC4338F
	for <git@archiver.kernel.org>; Fri,  6 Aug 2021 13:33:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5FC061181
	for <git@archiver.kernel.org>; Fri,  6 Aug 2021 13:33:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344087AbhHFNdY (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Aug 2021 09:33:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243664AbhHFNdY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Aug 2021 09:33:24 -0400
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com [IPv6:2607:f8b0:4864:20::e30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45EFDC061798
        for <git@vger.kernel.org>; Fri,  6 Aug 2021 06:33:07 -0700 (PDT)
Received: by mail-vs1-xe30.google.com with SMTP id t29so5234695vsr.5
        for <git@vger.kernel.org>; Fri, 06 Aug 2021 06:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aptB6WdJNekXtX0BcsHWA0zDQlgFSvGD2OFuXn7cFYA=;
        b=vF4YH8tEZUMzpQ+cj8Z4AI4kuX6BKpKd68A3NueenM0wFR2Sv03W01ZAZsS440WWBU
         p5w3sGQVF9R0k9hK/eapyJrKNp/PPRya0hFbOCwE61F1W9O3yekzpiDZc2RW8FfDt4XM
         M2fkKKYffwIurZw3ZDDjE3QXo3SpIbSIMQF2kuAoSfPhNCCDPsX69ayGaPuTpYh1/Rgo
         4+bhOV7sZCK0SiYGObTVKhmJO9oqZlMrMTVGbLqpdmNwBHd91PPwZDbLmBTNTPl9BCvT
         qogkzNUpW3cPfJ+9XMVYfAItn5VL4FPt5nvjJxmcE4+hU+Tplkv0WVQ9v2KJbf2F5L/I
         YOfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aptB6WdJNekXtX0BcsHWA0zDQlgFSvGD2OFuXn7cFYA=;
        b=a6gRLIwGZ96Mtf6Xiq3wC8FdVMaS0Rgu1Lz0bqR7LESidkCsPVYFnPffybzZpbnIDV
         0P5qKHVyXCah84cEYSUUPDyWMbmTnO/U7Y4K4dcd6ch+B38GLahxQ69adNOUHwwcbClN
         R/L8qMRdPdkiJIyh8MIYNeFHbqf/MbFrqRNav/95An4Ensv8aHA/4Ya7H3U8qZuQa/5Q
         hxZuSjmvLGSvtdNXTHuno+D5Je1tbmB9lMvIHgkwrdAsGtx57k0FViGy7TdiFZ0Fg1Ai
         BSUGv3xn/AIpJtsyqJ7bEajGAncUp9utEy34D9LiXIyV5E2BjlueAanm2qpS+P7BpS8V
         3DBw==
X-Gm-Message-State: AOAM531ZxXevARMrEkK1VA+onIAKn7fmnHT8FhCdQSBEnIEPyyFVo26r
        z8sZa/1GhbnuPNBdmVqFMuQ0pTHjHw+X5sA82qPtQFEX
X-Google-Smtp-Source: ABdhPJzCop4mlXwHFdoszgOuQHrJefS3un/Q4rFCeaoEC02RVua0T1HOe/ApFXbY8KpZXntXv5z7o86kUgJzXlvYD1Y=
X-Received: by 2002:a67:f144:: with SMTP id t4mr8991564vsm.44.1628256786332;
 Fri, 06 Aug 2021 06:33:06 -0700 (PDT)
MIME-Version: 1.0
References: <20210806080634.11869-1-carenas@gmail.com> <8d3d5d2e-cad9-2b02-13d0-b6be1b96f730@gmail.com>
In-Reply-To: <8d3d5d2e-cad9-2b02-13d0-b6be1b96f730@gmail.com>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Fri, 6 Aug 2021 06:32:55 -0700
Message-ID: <CAPUEspgV3KoUOo=EDss+PTdHO6+Cp=ODDjYm7WRm8F0HHgJ08w@mail.gmail.com>
Subject: Re: [PATCH] makefile: update detect-compiler for newer Xcode version
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     git@vger.kernel.org, pclouds@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 6, 2021 at 5:00 AM Bagas Sanjaya <bagasdotme@gmail.com> wrote:
>
> Why not just s/Apple LLVM/Apple clang/?

because that would break it for older versions of Xcode that reported
themselves as "Apple LLVM" and I am not even sure when the change was
made to even consider those versions as obsolete.

Either way, I am sure once we figure out which versions are affected
and which versions macOS developers care enough for, that would be the
obvious next step.

note that DEVELOPER=1 was broken for a while in macOS and that also
affects CI, and it is still known to be suboptimal, since version
numbers for Xcode compilers are not always representative of what
features can be found in the opensource version with similar numbers.

Carlo

Carlo
