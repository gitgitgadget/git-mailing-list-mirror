Return-Path: <SRS0=/7R8=BN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 287FFC433E0
	for <git@archiver.kernel.org>; Mon,  3 Aug 2020 17:13:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F3C8422B40
	for <git@archiver.kernel.org>; Mon,  3 Aug 2020 17:13:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="epBeXehY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728166AbgHCRNR (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Aug 2020 13:13:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726878AbgHCRNQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Aug 2020 13:13:16 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0864C06174A
        for <git@vger.kernel.org>; Mon,  3 Aug 2020 10:13:16 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id l6so35806435qkc.6
        for <git@vger.kernel.org>; Mon, 03 Aug 2020 10:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dHaTP1BlHNseKXRqGLKbTER1nZZVrb8qnXu0MYBzigs=;
        b=epBeXehYLlDoZJfhQtlrCmOiU1ZKsBcSb95ypjhGcoIViLZNAXByPqxbnlFTQ0Z9n3
         G4bVABnOEo7FWeDvl5IQ5SohkfTxGiITjdNOp4uYOZZzCe9/cyK+nJOnH5bRaivMOxJh
         eERotUp9pK+wM5pcGgHEDiBrAC2P09wGoKPu+QNYWpTBSMFKHMrKZJV7S4cbp3ocg3OC
         ELtZw/IArYNHcUJ5JNeLyx4QBWGBe0SnkocnnD9MiLnwGmY1BKFiTMPy/FFKgCWZwjBf
         +ay4fapPlTVJ5mvuj/AtG0Cqup6IFGlxQmscAOcYmhs1JDEJxuR64VRo7mV856xnyun4
         +RPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dHaTP1BlHNseKXRqGLKbTER1nZZVrb8qnXu0MYBzigs=;
        b=VdFhdA3EmSfXZxITfPGs+mIO8QXxRRg359EGTF6hhRwAyYPanIeFZbSJLT4LIeZ+Ea
         1pqS6wKzNWkGpWGXX48HL5/c6XDG6hlfLmv0//8sNdVTnlqgF4gPS2q7g6XEXfQVIlbe
         s7hi+ysOVxt73VSSwbjC4r4nTNsXG+Y5fQcHDuqV6QxLdAYC5bCkwx1F/5rgWQ0ON7FJ
         lzLS8T0vhq6JBiEHY9iTjBboISqB0Kzq0YcyfuOCpuVzTvO+aQ2OMZmS8yyXtGDJIqK6
         4Q1Cg0pBJd99699C4+w06YgcupEdXClovpgGaYvzR+B4q+J2pbEiO7Ixd/Cjk1GsTF+4
         5F3A==
X-Gm-Message-State: AOAM533zcpN7i1qTqF8D2SImKfcsYXGSWS66JnoSoOAmMZ90LlrLlgHv
        7qZzPL1JsYmsl9iQMMF1KHpVa2VJay/Xog==
X-Google-Smtp-Source: ABdhPJxn4QhK9jjpTNqaur+xk1j1OXLvurRP5bMwgmlC66gLDiEi8f68+UJV5Zy36TJ/9iKaiy0Nvg==
X-Received: by 2002:a05:620a:1264:: with SMTP id b4mr2584362qkl.141.1596474795833;
        Mon, 03 Aug 2020 10:13:15 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:3475:b417:c07c:c811])
        by smtp.gmail.com with ESMTPSA id v2sm11955240qte.25.2020.08.03.10.13.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 10:13:15 -0700 (PDT)
Date:   Mon, 3 Aug 2020 13:13:13 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>,
        Noam Yorav-Raphael via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Noam Yorav-Raphael <noamraph@gmail.com>
Subject: Re: [PATCH] docs: improve the example that illustrates git-notes
 path names
Message-ID: <20200803171313.GE50799@syl.lan>
References: <pull.692.git.1596465817121.gitgitgadget@gmail.com>
 <20200803154852.GA48612@syl.lan>
 <xmqq7dufwtio.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq7dufwtio.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 03, 2020 at 10:04:15AM -0700, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>
> >> diff --git a/Documentation/git-notes.txt b/Documentation/git-notes.txt
> >> index ced2e8280e..9fc1979531 100644
> >> --- a/Documentation/git-notes.txt
> >> +++ b/Documentation/git-notes.txt
> >> @@ -223,7 +223,7 @@ are taken from notes refs.  A notes ref is usually a branch which
> >>  contains "files" whose paths are the object names for the objects
> >>  they describe, with some directory separators included for performance
> >>  reasons footnote:[Permitted pathnames have the form
> >> -'ab'`/`'cd'`/`'ef'`/`'...'`/`'abcdef...': a sequence of directory
> >> +'12'`/`'34'`/`'56'`/`'...'`/`'789abc...': a sequence of directory
> >
> > I had to read this twice to figure out why the first 'ab' changed to
> > '12'. It appears that this is to avoid having to use 'gh...' in the
> > last directory, since 'g', 'h' and so on aren't hexadecimal digits.
>
> You can wrap-around to '0' after counting up to 'f', no ;-)?

;-).

> Having '/.../' between '56' and '789' to indicate "there are more
> levels possible here" is somewhat misleading with the new example.
> We could argue that the original objectname does not have to be
> "123456789abc.." but then the whole exercise becomes somewhat
> pointless as the objectname could have been 'abcdef...abcdef...'.
>
> Another minor nit: it probably makes it read more natural to start
> counting from '0' when writing hexadecimal, if we really want to
> use sequence of ascending hexdigits.
>
> Using a seemingly random example 85/b4/.../808d9ee6debdf167ced3
> might be less confusing, because ...
>
> >>  names of two hexadecimal digits each followed by a filename with the
> >>  rest of the object ID.].
>
> ... I think these two lines is pleanty clear than any example, so I
> am OK with either the old or the updated example, but I think a
> seemingly random example as long as the leaf level does not share
> the leading hexdigits as the pathname would work the best.

I agree with your reasoning (it didn't occur to me as a problem before,
but seeing it spelled out in front of me I could understand how such an
example might be confusing).

Thanks,
Taylor
