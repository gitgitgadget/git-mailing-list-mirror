Return-Path: <SRS0=nPiP=6T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 910C8C47247
	for <git@archiver.kernel.org>; Tue,  5 May 2020 03:53:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7CA4320661
	for <git@archiver.kernel.org>; Tue,  5 May 2020 03:53:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727931AbgEEDxp (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 May 2020 23:53:45 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46274 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726345AbgEEDxp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 May 2020 23:53:45 -0400
Received: by mail-wr1-f68.google.com with SMTP id f13so922713wrm.13
        for <git@vger.kernel.org>; Mon, 04 May 2020 20:53:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=e/C4KmENhWiX9Ww5ccb0vtcn7fwwasEZdgn7yvtgwn4=;
        b=csoVxNlafpl4XSdtObEyEukbf+g6SGTH0FINBPGBp45B1YE0+J9pkkBduA2vFYHets
         iOSv+fi5CKPgIDljmNc4LqSd+dWI7SHOs1VbS7ysglMirZD2gkdf2NuL/wbTZIpDoAVG
         Nep3Gv95IqKQdB6WLhzAkjYX18cU7rloAe0bsbHx84o+i2sWdldVp1HMKG8hyOvdD9aJ
         t3sZhI66lBxu17cHYBsPyvGE56rmzR/UUq3dIwt7GFTK7Ij05B4SoA5n1tgLmjBpQvmJ
         NnMLG2RX2+s8KPoGQCLd4zLKTwCyEinBj9nC00jmsz09BjTAZde79IlafZJf6FKcLOdy
         7k9w==
X-Gm-Message-State: AGi0PuYr96cseOPyRdPtD5xJKT8ZpShJAwytassbMKA5W9srsvlhH0kE
        SdFdBwKEUChQvmXP7hROMDrTO1MxdF+o3AGEWrxcRjYn
X-Google-Smtp-Source: APiQypLFX3iwe6RkKWiiyQw2S0nHDWPu9vRXTq5mif6DRz5hXH60qy7FqSuAXZ0r+CGwfb5UXOdbFEgcrIZECLa6qNY=
X-Received: by 2002:adf:fccd:: with SMTP id f13mr1277139wrs.386.1588650822925;
 Mon, 04 May 2020 20:53:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200501082746.23943-1-sunshine@sunshineco.com>
 <20200501082746.23943-3-sunshine@sunshineco.com> <xmqqimhfoelf.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqimhfoelf.fsf@gitster.c.googlers.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 4 May 2020 23:53:31 -0400
Message-ID: <CAPig+cT62cEx9Zk+DN02xGfAmqZD258Toa3PArSxEf8QDFeDww@mail.gmail.com>
Subject: Re: [PATCH 2/2] restore: default to HEAD when combining --worktree
 and --staged
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>,
        =?UTF-8?B?SGFycmkgTWVodMOkbMOk?= <harri.mehtala@finago.com>,
        Duy Nguyen <pclouds@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 1, 2020 at 11:33 AM Junio C Hamano <gitster@pobox.com> wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
> > [...] This requirement
> > makes it cumbersome to restore a file in both the worktree and the
> > index.
> >
> > However, HEAD is also a reasonably intuitive default restore source when
> > --worktree and --staged are combined. After all, if a user is asking to
> > throw away all local changes to a file (on disk and in the index)
> > without specifying a restore source explicitly -- and the user expects
> > the file to be restored from _somewhere_ -- then it is likely that the
> > user expects them to be restored from HEAD, which is an intuitive and
> > logical place to find a recent unadulterated copy of the file.
>
> I also found that these two paragraphs a bit too long, and by the
> time I finished reading them I forgot that you mentioned that HEAD
> is the default when --staged is given. [...]
>
>   ... This requirement makes it cumbersome to restore a file in
>   both the worktree and the index.
>
>   As we are *not* going to restore the index and the working tree
>   from two different sources, we need to pick a single default
>   when both options are given, and the default used for restoring
>   the index, HEAD, is a reasonable one in this case, too. Another
>   plausible source might be the index, but that does not make any
>   sense to the user who explicitly gave the `--staged` option.
>
>   So, make HEAD the default source when --staged is given, whether
>   --worktree is used at the same time.

Thanks. I was having trouble writing it without being overly
subjective (and using words like "intuitive" and "logical"). I'll
probably drop the "Another plausible..." bit from the rewrite, though.

> > +By default, the restore source for `--worktree` is the index, and the
> > +restore source for `--staged` is `HEAD`. When combining `--worktree` and
> > +`--staged`, the restore source is `HEAD`. `--source` can be used to specify
> > +a different commit as the restore source.
>
> Clear enough, but I wonder if we can simplify it even further.
>
>   By default, if `--staged` is given, the contents are restored
>   from `HEAD`. Otherwise, the contents are restored from the
>   index.
>
> because `--worktree` is the default for the command when neither
> `--staged` or `--worktree` is given.

Makes sense. I wasn't terribly happy with it either.
