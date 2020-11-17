Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB613C6379F
	for <git@archiver.kernel.org>; Tue, 17 Nov 2020 23:54:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A810622266
	for <git@archiver.kernel.org>; Tue, 17 Nov 2020 23:54:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726597AbgKQXyt (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Nov 2020 18:54:49 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:35599 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725774AbgKQXyt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Nov 2020 18:54:49 -0500
Received: by mail-ed1-f65.google.com with SMTP id ay21so72201edb.2
        for <git@vger.kernel.org>; Tue, 17 Nov 2020 15:54:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+0xsN6Oqogkmp4Z1edM9vuIUqdfTQxsIf01pX9Qi7BQ=;
        b=DcPyVe8oCnNFCX8/UvAjU8dD6soalJRmWwEAZ5+gIFtmx1AWVD6QSPifwutxNm8+eN
         saALMSLhCajKZgDNmJtkLEEEiPpzILO7gSwDzzxZl7qbbgA4u3zhA0HJzYUQlqN0cYhm
         kAkhoEKZZeKs0FGrYsppl7UpSLGyEZXO9Ke8hs3gCQ4W+BSSVa0KR0XZGMc+NijgEJtC
         nBsYVv029CTMtTzul21MenuyMitk9VIp9pWSnqZ3eN+TJYmY3FGVRNS4zkqxR8W0szmV
         rsy5qTOVBfQzM9woxe8+TNDm8G0+rnIMtDyCpm6e+zCJKKVWKUG3MIjFIEGl5JUJSpPt
         xDlA==
X-Gm-Message-State: AOAM5303OXdoQxeQPuvPZ823FkKyvyxawUznsJPU+Tfy318v7xbpXFfW
        9Cxo6Rq1cCafbrCaWmxs/LLcuBe7rX/Lz3/KVcA=
X-Google-Smtp-Source: ABdhPJwmXha0SxV6t4Tx1XPdLfgzEG8NOklfD94pdTHJEUKNChPdY326uXK4T1k9UgerfI6Lht+wJEXNTXfXFXsXVAo=
X-Received: by 2002:aa7:cc0e:: with SMTP id q14mr23365652edt.181.1605657287274;
 Tue, 17 Nov 2020 15:54:47 -0800 (PST)
MIME-Version: 1.0
References: <pull.776.v3.git.1605276024.gitgitgadget@gmail.com> <pull.776.v4.git.1605647598.gitgitgadget@gmail.com>
In-Reply-To: <pull.776.v4.git.1605647598.gitgitgadget@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 17 Nov 2020 18:54:36 -0500
Message-ID: <CAPig+cQCyWKzhm-LUBJ8Xm71KMq=6F+xpeLTCRXNoagtgXAwUg@mail.gmail.com>
Subject: Re: [PATCH v4 0/4] Maintenance IV: Platform-specific background maintenance
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 17, 2020 at 4:13 PM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>  * I noticed far too late that while my example XML files had been edited
>    with UTF-8 encoding, Git is actually writing them as US-ASCII. Somehow
>    xmllint and launchd are not complaining, but schtasks does complain.
>    Unfortunately, I cannot find a way to catch this problem other than to
>    install my tip version on all three platforms and go through the entire
>    git maintenance start process, and double-check that the processes are
>    running on the hour.

I'm having trouble understanding what problem is being described here
and whether or not it has been solved by v4.

I might guess that you are saying that `schtasks` insists upon seeing
a UTF-8 BOM at the start of the XML file since the XML file declares
itself as UTF-8, but that Git is (quite naturally) writing out the
file without the UTF-8 BOM.

> -    xml = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n"
> +    xml = "<?xml version=\"1.0\" encoding=\"US-ASCII\"?>\n"

If the above speculation is correct, and if `schtasks` is happy with
the plain text file (lacking UTF-8 BOM) declaring itself as US-ASCII,
then this seems a reasonable solution. And it's easy to test that this
doesn't get broken. After validating the file with `xmllint`, also
grep it for US-ASCII, perhaps like this:

    test_xmllint "schedule-$frequency.xml" &&
    grep "encoding=.US-ASCII." "schedule-$frequency.xml"
