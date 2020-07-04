Return-Path: <SRS0=Nv7C=AP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAB9BC433E0
	for <git@archiver.kernel.org>; Sat,  4 Jul 2020 15:28:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B0B020747
	for <git@archiver.kernel.org>; Sat,  4 Jul 2020 15:28:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ONNy8/3W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726639AbgGDP2L (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 4 Jul 2020 11:28:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726405AbgGDP2L (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Jul 2020 11:28:11 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44576C061794
        for <git@vger.kernel.org>; Sat,  4 Jul 2020 08:28:11 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id b92so15166090pjc.4
        for <git@vger.kernel.org>; Sat, 04 Jul 2020 08:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=OdqNOigt2646h440xohwIqk2NPAxywhysgs22rVatMs=;
        b=ONNy8/3WTUtEk8NFAK50/zCcrjzhCw1DNWfjb0sa2hx+h1M5Zg1r5Ws64No50va1zN
         aVill8gQ5gf+vZ3kvfjep6GhPH9sEb60JtvCOFdthsKdo7TfWSfoioGw6MngQpbLFan0
         L/XvbqMer1cjCOVxN1vkFopfSDerLtSzVibmTadwkkKIsWgULSQHfflEZ9lcRM6B18U5
         J4Hsohijrd+fcfmMFjjvq7p7ga93NjSaGUnKCl3IwntacKKP2JLbvVzvhAFct4rCwCt4
         Pp/LIGy4/hd6v78OPXa/b1HWujQFS9rKa46QiBbz+lTYFuqWzyY7rIu3X9JqODjGNKYQ
         G8+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OdqNOigt2646h440xohwIqk2NPAxywhysgs22rVatMs=;
        b=S8AiKO8FdzKlJwtq+l4GtTTjM9l4lvxOcOuLcN1x8y7pFX3Zm8la6d5utIhBHlgZiM
         Aje3B94CEDDRbM3WImSBHhCfQ/RwpK/92UYVwFBVFBoXkySd4hcolVxWutyKc/OWWOyb
         3a8gWFkfvCjP/d7BX4ybQOR/NtSGviex9N/K+oVapckNOPlBz3lA0VdR46ORS2gzG6DW
         EULFNE0u3cbQFkTmdvM0FXRUjXeQsCCSbjbSjXtfrNOJVZiFDbj/gxlCNq+a7n95nlRJ
         HANF/Vhky54tSKf3n3LVWyk4ymei2Lmx2RJpX7IZtuQckO1Dp0jKuB8pi8aIgvtkhqga
         QfKg==
X-Gm-Message-State: AOAM531kqoFlOMpqQr7/gzfxm69lkjfqYTgKAt654sJ2ZZ+EmLB7pl5L
        yJcmGL3vwPlx733F3vuVlhuAZintjXg=
X-Google-Smtp-Source: ABdhPJw1qHBJpQRWEPQFdhnQvZDNIjxNqP2ftmhlG6PlT3/Q8L5GOxDDvj9NjJUQO2QcS+lEgc9fPw==
X-Received: by 2002:a17:90a:ea86:: with SMTP id h6mr41357936pjz.167.1593876489586;
        Sat, 04 Jul 2020 08:28:09 -0700 (PDT)
Received: from konoha ([45.127.46.159])
        by smtp.gmail.com with ESMTPSA id o10sm4524976pjs.27.2020.07.04.08.28.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jul 2020 08:28:08 -0700 (PDT)
Date:   Sat, 4 Jul 2020 20:58:02 +0530
From:   Shourya Shukla <shouryashukla.oo@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     christian.couder@gmail.com, gitster@pobox.com,
        liu.denton@gmail.com, kaartic.sivaraam@gmail.com,
        pclouds@gmail.com, git@vger.kernel.org
Subject: Re: [PATCH 3/4] diff: change scope of the function count_lines()
Message-ID: <20200704152802.GA46571@konoha>
References: <20200702192409.21865-1-shouryashukla.oo@gmail.com>
 <20200702192409.21865-4-shouryashukla.oo@gmail.com>
 <nycvar.QRO.7.76.6.2007031659580.50@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.2007031659580.50@tvgsbejvaqbjf.bet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/07 05:07, Johannes Schindelin wrote:
> Hi Shourya,
> 
> On Fri, 3 Jul 2020, Shourya Shukla wrote:
> 
> > From: Prathamesh Chavan <pc44800@gmail.com>
> >
> > Change the scope of function count_lines for allowing the function
> > to be reused in other parts of the code as well.
> 
> It may be just me, but I'd rather see the word "visibility" instead of
> "scope" here. I mistook the subject line to indicate that the function is
> changed to serve an (at least slightly) different purpose than before,
> which is not actually the case.
> 
> Another alternative to "visibility" might be to imitate existing commit
> messages, such as e4cb659ebdd (diff: export diffstat interface,
> 2019-11-13), 22184497a36 (factor out refresh_and_write_cache function,
> 2019-09-11) or ef283b3699f (apply: make parse_git_diff_header public,
> 2019-07-11).

These are some excellent commit messages! I will take inspiration from
these. Thanks Dscho! :)

> In addition, as with all such changes, we need to be careful to consider
> whether unrelated function names coming in from system headers might
> clash. In this case, I think `count_lines()` is a bit too generic, but
> will probably not clash. Personally, I would probably have opted for
> `count_lines_in_string()`.

I do not see it clashing with any other functions. Do we need to change
the name still (maybe to make the functions purpose even more clear)?
