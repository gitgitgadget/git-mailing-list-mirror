Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CEF1C47092
	for <git@archiver.kernel.org>; Mon, 31 May 2021 03:11:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 12FFA61003
	for <git@archiver.kernel.org>; Mon, 31 May 2021 03:11:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230108AbhEaDNX (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 30 May 2021 23:13:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbhEaDNW (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 May 2021 23:13:22 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFDD5C061574
        for <git@vger.kernel.org>; Sun, 30 May 2021 20:11:40 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id x18so3251188ila.10
        for <git@vger.kernel.org>; Sun, 30 May 2021 20:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=BdodbjpNRAmCAqZG9H7vKPZdinriZ7cTsEiknMRimJ4=;
        b=Nzp/4X/f1OawpoS5Nxg+vvVPNGJQ7ibzIsAEJX+wH2Hquo8j6rk/vpoMjeYQbuGeHd
         OTzxOVtLeBg69CRdp+ZDfvTtfJJwjxh9Jef+ashinctGE3Ve5bMlieHi6Wcw2TU5SVkO
         O4Or3W6+4SlRi5GpPqa3KlVvsUDnWMhtI1a2QVuwW+qPSS1uQ3z1KOZQv/LOkpIZsoii
         EgN4yE9Uq6vX9fuEDc0pzgvcAqKE+CYcBtvJVyu+6bJh7+CUTC1xdTohTAkZ87+pxozv
         gxVNckQc9MUEASx7EN+arfQXTyNXV08+njWC7bqVGC4fCQPIrCpdoZQq+rUfunyKHXVd
         Nn/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=BdodbjpNRAmCAqZG9H7vKPZdinriZ7cTsEiknMRimJ4=;
        b=ovWVkUK/eNe9BwMOWZJiN+W/FHCNxY0h3c3LdWoNmkEvTvtpZDurWmUq9OxGJ/kiSD
         3FhSPfNDCGZBl3U82UF1R3o1lNEMbQXYYQChghzCFkXeHPDW6B5b1npH7enbNnbRhkUn
         HJ/M3fBbKPHWjvKkNs6061lyn5kq5NaIZwCJIxjW46pUPMf1GlZfIGghLQjsJfOEmE6O
         i0iXaEuD6VHXWkuqaU3XYJoo+ImZQkTbD8pFOKDT6tweVxomVMW/kma2Zx2y0g802nJZ
         IqSlsy0hj4Uz0LSW83Qruldkc7E39yLjJxNvIByKVDMGMXlxWJUBNh4dF2OJzKvJ4U5U
         eZMA==
X-Gm-Message-State: AOAM533DVNawnQUC1aSiPnyZBLhmUqykpZvLR3faTzh+YZDEKx3wGfmM
        erp1YkrDIQkNYqRyoNSs8qgR/aKnyjMb52v8y6/6p/fo7wQNaQ==
X-Google-Smtp-Source: ABdhPJx257FWKr0Gm4SQazwxYYK0Jlawv0mLv1CqyE5mqh2WUC1OzBitQ+sqAyIKfylv7qrjO5R90S39vgf8BIr2B7A=
X-Received: by 2002:a92:d90c:: with SMTP id s12mr15497378iln.96.1622430700060;
 Sun, 30 May 2021 20:11:40 -0700 (PDT)
MIME-Version: 1.0
References: <CAFOYHZBAg7pkise8bir7Z3qApw9mJB8Z99p6z71-_T6=7rFV7w@mail.gmail.com>
In-Reply-To: <CAFOYHZBAg7pkise8bir7Z3qApw9mJB8Z99p6z71-_T6=7rFV7w@mail.gmail.com>
From:   Chris Packham <judge.packham@gmail.com>
Date:   Mon, 31 May 2021 15:11:28 +1200
Message-ID: <CAFOYHZAfQivHvs5=hGt-A1CbtwW-iJSwC1iFk7FY3wnNcVNVrQ@mail.gmail.com>
Subject: Re: [BUG] gitk error - can't read "arcnos()": no such element in array
To:     GIT <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 4, 2021 at 9:16 AM Chris Packham <judge.packham@gmail.com> wrote:
>
> Hi,
>
> I'm hitting an error with gitk (gitk 1:2.31.1-0ppa1~ubuntu18.04.1) on
> a specific git repository.
>
> The repository is slightly odd in that it has some replace refs
> configured and multiple root commits. Although another similarly
> configured repo doesn't hit the error.
>
> The text from the application error pop-up is:
>
> can't read "arcnos()": no such element in array
> can't read "arcnos()": no such element in array
>     while executing
> "lsearch -exact $arcnos($l) $a"
>     (procedure "splitarc" line 21)
>     invoked from within
> "splitarc $olds"
>     (procedure "getallclines" line 33)
>      invoked from within
> "getallclines file11"
>      ("eval" body line 1)
>      invoked from within
> "eval $script"
>     (procedure "dorunq" line 11)
>     invoked from within
> "dorunq"
>     ("after" script)
>
> I've not been able to narrow down a specific reproduction method yet.

This seems to have fallen on the floor (so I pick memorial weekend in
the US to give it a ping).

I have tried building gitk from source (git://ozlabs.org/~paulus/gitk)
and still see the same problem. Still haven't reproduced it on
anything other than my one repository.
