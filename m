Return-Path: <SRS0=oWbz=C5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF010C43463
	for <git@archiver.kernel.org>; Sun, 20 Sep 2020 04:25:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95D8B207D3
	for <git@archiver.kernel.org>; Sun, 20 Sep 2020 04:25:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AcY5fx4N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726831AbgITEZq (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 20 Sep 2020 00:25:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726760AbgITEZq (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Sep 2020 00:25:46 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC655C061755
        for <git@vger.kernel.org>; Sat, 19 Sep 2020 21:25:45 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id w2so8940706wmi.1
        for <git@vger.kernel.org>; Sat, 19 Sep 2020 21:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=OImPAH2mbIe/NZ/JVwsfrV82E5qg+quS8wEgOpaIKmE=;
        b=AcY5fx4N/2VKat8ANkUPSAfLFSi3siaUP4n8XrBMHzimG8TMFGNpdS4bO6E2u+3Vrs
         W8NZ4sBktY7RH+LIr65uQ4PDK4nOhRetnAnA0CyLM8fYxhih2rrXGECZ2q6NYsiwarHv
         ROboMRgt4L/dSfESTeEdcuad0mYUHxnepw9Y1WEpGAQyy+anlKmeWv5LFDMoJVlRpjFl
         7ATIZf7YcrTSvlW4qNI/Jvrz3ln58C38K2S7xxZpuDsb80g84aEFZUufJaFUUPBCZbzy
         peYhg269viaqkEFfDl0pliyHwRrGgM7vZhzGt8FrckBDOzQQda5e9f1DinlI4wFngMub
         pYfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=OImPAH2mbIe/NZ/JVwsfrV82E5qg+quS8wEgOpaIKmE=;
        b=QiPxrONqtZQKhC4Zfgr05EWSZIg4C5EarpnKSAWyfkhB8fMFr4jPiR2XLRQuCff8dq
         EirjcaAx466omSqMKO0oZjvT+dJuO12+xRb4SnwFn838983hyRXNT08fqQMFGP1OBy9r
         T4eH0qME+rQ8UDSMRlkJlr3LwbUG958gBOZA6sgZ1gc9pYKE9dSTLTy2poLZ7pUFEzff
         FafoiFNnifrHMhmzl+Ej0Npg7aaTk1OKpYNAosbyOh8kaQWn0hipwOVH5R9vEI7r05Z4
         PZKOhE5L6eQhOVdmw8Vh8yJHb9LAHopgxEpPEwPlpDsDXNVfaXGsI/iZnYb9N3jpcZkU
         o0Eg==
X-Gm-Message-State: AOAM533kwsqFyyqmTfuXOBVSfv3hMt9gCgzcwB0GETAuTxA32HEb/0In
        B0dJ8Z4kLO25hv7us2Skc2GF23tTj3A4qsMyFo0=
X-Google-Smtp-Source: ABdhPJx4DgArV3TXRsXr1cn8GX4vyIKf+JlsiaZ9Uypw8DKynMD4W6Jsjjkm4Zs3BJPhcdP3OKssdBNm79sBeG6eFxE=
X-Received: by 2002:a05:600c:2283:: with SMTP id 3mr22447817wmf.37.1600575944414;
 Sat, 19 Sep 2020 21:25:44 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1600427894.git.liu.denton@gmail.com> <004f2e4c92918a7a4e452d49e98ef15f1c5ac545.1600427894.git.liu.denton@gmail.com>
 <20200918141125.GB1602321@nand.local> <20200918212609.GC67496@camp.crustytoothpaste.net>
In-Reply-To: <20200918212609.GC67496@camp.crustytoothpaste.net>
From:   Chris Torek <chris.torek@gmail.com>
Date:   Sat, 19 Sep 2020 21:25:33 -0700
Message-ID: <CAPx1Gvd6vcvM410wZUZygr4-2Ob6gaScF3DnBtWWsT95XDmKSQ@mail.gmail.com>
Subject: Re: [PATCH 2/4] builtin/rev-parse: learn --null-oid
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Taylor Blau <me@ttaylorr.com>,
        Denton Liu <liu.denton@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 18, 2020 at 2:34 PM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
> So I definitely want to distinguish between the null (all-zeros) OID and
> the OID of an empty object, and I think using "null" and "empty" are
> fine.

(I like this myself)

> What I typically do when I write shell scripts, and which may obviate
> the need for this patch is turn this:
>
>   [ "$oid" = 0000000000000000000000000000000000000000 ]
>
> into this:
>
>   echo "$oid" | grep -qsE '^0+$'
>
> This is slightly less efficient, but it's also backwards compatible
> with older Git version assuming you have a POSIX grep.

Note that a lot of `grep`s do not have `-q` and/or `-s` so the
portable variant of this is `grep '^0+$' >/dev/null` (you only need
the `2>&1` part if you're concerned about bad input files or
an error on a pipe or something).

> I'm not sure we need an empty tree and empty blob object, because it's
> pretty easy to write these:
>
>   git hash-object -t tree /dev/null
>   git hash-object -t blob /dev/null
>
> That's what I've done in some of the transition code at least.

That's what's recommended in my 2012 stackoverflow Q&A, too.
The use of `/dev/null` directly here is perhaps unsatisfactory on
old Windows systems, though...?

Chris
