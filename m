Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 657C9C433EF
	for <git@archiver.kernel.org>; Fri, 19 Nov 2021 09:37:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 46B0161B31
	for <git@archiver.kernel.org>; Fri, 19 Nov 2021 09:37:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233544AbhKSJkD (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Nov 2021 04:40:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232969AbhKSJkD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Nov 2021 04:40:03 -0500
Received: from mail-ua1-x931.google.com (mail-ua1-x931.google.com [IPv6:2607:f8b0:4864:20::931])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93F2DC061574
        for <git@vger.kernel.org>; Fri, 19 Nov 2021 01:37:01 -0800 (PST)
Received: by mail-ua1-x931.google.com with SMTP id t13so19951371uad.9
        for <git@vger.kernel.org>; Fri, 19 Nov 2021 01:37:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KsprgxS8Um4786ct3hgpQ5dd7DmCoUEyvJrxDFAzbCY=;
        b=PjicaWnu/OWkcQxXVwGK3V3C+ildUnK+ah3u+ZwqBGvJZpOt274hh5zagNyqilcUuS
         ExGIyuE1OxIgfUe8gk5OeBwFXHmNZhAx5pGsZ97wpxK3Je5A88z9jXjHaWnvtwal6/ZH
         3LMu/AoKPRdSRf2GJ5RtpIu3cbnW0gUOC2HYCVgpdGj7L0mbnXiuWpOS5OOriUgk7xcS
         +wGTX2adzAsT5GJweEIRmRsYzkL21bi60C96iVEaq0OVMJRpwAFrNK9Ab6kbr4jnattQ
         uqTtlFSUznUtsYGpJZP7qpTNQdb3wr/9LozMuv0B+5hg20fYmjaoll7m+vC8rU6ANloj
         Z6Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KsprgxS8Um4786ct3hgpQ5dd7DmCoUEyvJrxDFAzbCY=;
        b=HSKpXymjo9ukIQJPKv78j5cvYtVifHLGhSHD5ycC7PmjwtexylAwg1A7fExUCBb6zI
         6AUFNiAcB0taEwChQEhy+Ah/gAtRMn2JlOCuugJSji28+OxEF0JhgeYFOjDuOugAG/Q0
         R86Gi2To4dM/uEXJvcFtu/fEx2e1G+JCT1GD6xk3WzFES/LYtTuE7E1r9FViZsOFp2xe
         m2bkHtBDbLEebYBNqdVXV6Tq9dbN8v+eFvrfXauq1x3e/DAxL0d98UkSfN92FY22fVDs
         ytiloL5wqxXlxRr4HlF6N3/NZ7mud/gzoi8u+YH7fXPe4Jtc0aFB5C2WFYtTm7WVDg/J
         VfUg==
X-Gm-Message-State: AOAM530xcUyoLGc0LeRRGIE2lkOHfe9SG6DzpF3kanLLPQHvimaOD7xt
        FJ3fmWxpZBdCVElKIK07lxF6TvsW2BO7taVRtvs=
X-Google-Smtp-Source: ABdhPJwz7wwkYzCpPLC4zIWTA0yec1JjaDh6SBmwoteBCL36xQ76a3CSl4JOE3fPIJNfmEHXxVyUSdafTUVwau5TlkM=
X-Received: by 2002:ab0:14a7:: with SMTP id d36mr47015303uae.96.1637314620629;
 Fri, 19 Nov 2021 01:37:00 -0800 (PST)
MIME-Version: 1.0
References: <20211005063936.588874-1-mh@glandium.org> <CAPUEspgLwLxavP3bC9OEJQTphoemQ+jxv+9Nkcvbf51uaBEpww@mail.gmail.com>
 <20211118030255.jscp2zda4p2ewact@glandium.org> <CAPUEspg-5+YdfTJ6zi9hdDqF=KV2LJFCtqmECSss9Kfpn6sGrQ@mail.gmail.com>
 <20211118053415.4axljmr4s6kmqmms@glandium.org> <CAPUEsphf0d90HGg64j=jZnt-Xuhs_bwmeOyoUnmzesp_k2c4JA@mail.gmail.com>
 <20211118090542.rcaggue6zpd7r3ht@glandium.org> <CAPUEspjZmwoOWSJHBrykOfNEv=zLi2nQLs1EkUPTPr-nSNf08Q@mail.gmail.com>
 <20211119072357.oxl5caye742blz5j@glandium.org>
In-Reply-To: <20211119072357.oxl5caye742blz5j@glandium.org>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Fri, 19 Nov 2021 01:36:49 -0800
Message-ID: <CAPUEspic-qgLWGgcJeO52A1XeUh7p+F_WKfH0NLYMmMRWL7Cnw@mail.gmail.com>
Subject: Re: [PATCH] Use mingw.h declarations for gmtime_r/localtime_r on msys2
To:     Mike Hommey <mh@glandium.org>
Cc:     git@vger.kernel.org, Johannes.Schindelin@gmx.de
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 18, 2021 at 11:24 PM Mike Hommey <mh@glandium.org> wrote:
>
> The ifdef around gmtime_r and localtime_r in mingw.h is for __MINGW64_VERSION_MAJOR.
> The ifdef around _POSIX_C_SOURCE in git-compat-util.h is for
> __MINGW64__.
> I'd imagine that plays a role.

Must be, and indeed you are right that my 32-bit compiler doesn't set
__MINGW64__ (only __MINGW32__) and I am not hitting that codepath, but
I have no problem building and it seems it is because
_POSIX_THREAD_SAFE_FUNCTIONS it is defined unconditionally at the end
of pthread_unistd.h, unlike what is done for x86_64.

somehow your version of headers might had that removed in both, and
that was "fixed" later.  I have 6346 in i386 and 6306 in x86_64.

Carlo
