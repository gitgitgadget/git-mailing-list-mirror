Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFFC5EB64D0
	for <git@archiver.kernel.org>; Tue, 13 Jun 2023 19:15:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230498AbjFMTPa convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Tue, 13 Jun 2023 15:15:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240618AbjFMTP3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jun 2023 15:15:29 -0400
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28E691BE8
        for <git@vger.kernel.org>; Tue, 13 Jun 2023 12:15:26 -0700 (PDT)
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-5ed99ebe076so11433646d6.2
        for <git@vger.kernel.org>; Tue, 13 Jun 2023 12:15:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686683725; x=1689275725;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TcQeZz3XsHW54BL7d5M9thZ268ZZNKKOW1FV0CedOIM=;
        b=EOSfp1vJ1VCAXEJVsVieH0AIRttzHv4vpjotKmUHATJ+wDwXWAJmRwlbR1/PKBM2Yt
         9t7fx4dOUZzpCV96Sz44PScjf/EYDJd/RcII1d+XnEUITtjsC+9B2e+2YH5XBT7c18wg
         U0j/myiyOuJUXQHvJcJYTGr2nPqnJz7UdtUV3+6bacDnuaJEE+b0DRrymyUCrejaVBiD
         AsLruxcqM7IFu10zYXGe8D/cUW/tqzPZaYcgCpudTgcdgJ0I1JAlNBbdv0tWcNyFcsKK
         8quS2/fktLCf901uFlsDmPnFBPCK+yK8QyZfOarc40rBD+YYxUCNxKC7aCb5r7BYk+5U
         Q97A==
X-Gm-Message-State: AC+VfDxOiLYMwkvb3fktqc/yFCRyd1j0vuzDofZ7raBZSIPb9VwtlZYd
        AwzUtTlHNgL7prDwvC2hRgNtdSPqr30azT86T/DARcZH8Bw=
X-Google-Smtp-Source: ACHHUZ7T77LrKwBhicR29wx6S9tucQ5/HNRyeaRvAW1nWyqU5b2W7aqHui1BCu2TbgEd73sYGPXHr3oHUtkBcDOUOQk=
X-Received: by 2002:a05:6214:400b:b0:626:2177:2fd with SMTP id
 kd11-20020a056214400b00b00626217702fdmr16756385qvb.19.1686683725190; Tue, 13
 Jun 2023 12:15:25 -0700 (PDT)
MIME-Version: 1.0
References: <CAPig+cRS=cpV1e4QoSy5uypA+-hECyPe2rEg3scV8LVBfzZ5hA@mail.gmail.com>
 <20230613184304.36482-1-jonathantanmy@google.com>
In-Reply-To: <20230613184304.36482-1-jonathantanmy@google.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 13 Jun 2023 15:15:14 -0400
Message-ID: <CAPig+cQnyL8-9EHVe5P_oRbUdsXA9WBiK_W4LHq7HOF4-ek5Pg@mail.gmail.com>
Subject: Re: [PATCH] CodingGuidelines: use octal escapes, not hex
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 13, 2023 at 2:43 PM Jonathan Tan <jonathantanmy@google.com> wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
> > On Tue, Jun 13, 2023 at 1:44 PM Jonathan Tan <jonathantanmy@google.com> wrote:
> > > + - Use octal escape sequences (e.g. "\302\242"), not hexadecimal (e.g.
> > > +   "\xc2\xa2"), as the latter is not portable.
> >
> > The shell itself doesn't interpret these sequences, so this
> > description feels too generic. Perhaps it would make more sense to
> > cite specific tools for which octal sequences are needed for
> > portability reasons, such as `printf`, `sed`, `tr`, etc.
>
> Ah...good point. I checked with "echo" in "dash" and assumed that it
> was "dash" that was interpreting the escapes, but indeed it is the
> "echo" (and "printf") builtins in "dash" that are actually interpreting
> them. What do you think of the following in the commit message:
>
>   Hexadecimal escapes in shell scripts are not portable across shell builtins (in
>   particular, the "printf" of "dash" does not support them). Write in the CodingGuidelines
>   document that we should be using octal escapes instead.
>
> and in the CodingGuidelines doc:
>
> + - Use octal escape sequences (e.g. "\302\242"), not hexadecimal (e.g.
> +   "\xc2\xa2"), as the latter is not portable across some shell builtins like printf.

The portability concern is not specific to a certain shell or whether
a command is builtin, so it feels misleading to single out "dash" and
builtins. The same portability problems can crop up, as well, with
older (non-"dash") shells, and with commands which may or may not be
builtins (such as "echo" which, historically, was not always a
builtin), and non-builtins commands, such as "sed" and "tr".

So, for the commit message, perhaps simply:

    Extend the shell-scripting section of CodingGuidelines to suggest
    octal escape sequences (e.g. "\302\242") over hexadecimal
    (e.g. "\xc2\xa2") since the latter can be a source of portability
    problems.

As for the change to CodingGuidelines, this would probably be sufficient:

    Use octal escape sequences (e.g. "\302\242"), not hexadecimal
    (e.g. "\xc2\xa2"), since the latter is not portable across some
    commands, such as `printf`, `sed`, `tr`, etc.
