Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11703C43334
	for <git@archiver.kernel.org>; Tue, 28 Jun 2022 11:58:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344631AbiF1L6e (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jun 2022 07:58:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343885AbiF1L6Y (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Jun 2022 07:58:24 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC10CE8C
        for <git@vger.kernel.org>; Tue, 28 Jun 2022 04:58:22 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id eq6so17187320edb.6
        for <git@vger.kernel.org>; Tue, 28 Jun 2022 04:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=nvY1fAzRHlAioAf6/P8l6TE2QUPsLKmLPKylvt+NiBg=;
        b=WBrnFG24Ns4oY36MHjZBCGJ88QTxRf/ZDo1sFOeN/e0XLkn65zS2JwLvUN6q0X5cgw
         ISbiowh5Q/NMOzt8cd4fgL0nM0orCwZN3rGg6nzAknkwiSfkxW8XnutcoZi64na7VkVe
         eInZ4yAjHBmmwrwesLSVxsE3NCrAAttvWhcsv8Zj6On/NKw3Ka8YBgmRT37vSvuJgQ/L
         24yZBBYLaJmd/mUGUR6J2MsI357TeOSEQg05u2hY81SUtEh5qOVbLpT3b/qu4AgBoS3c
         VN29lTKQNormClBiAxCOe9jJg4i3yZPeUV5/JICjhdzXEt9WmP31BhGkRNIQyQQCxfqp
         X/WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=nvY1fAzRHlAioAf6/P8l6TE2QUPsLKmLPKylvt+NiBg=;
        b=B2gD/QIm4NA/aay21lcpOZZqa+ixZPeh+GjcEvG7HfIMVm0DEM73bitJ7NFt36+NQD
         RX8paD0wkUT3AkGLk+40G9nNSLy1EI0CURil253D53grwhlQ+0c7l/0cVtJZ6mmIcFjt
         jrnbiAGiDtI/MOqkc8ApJIDnCVBw0RNUe5VPbxzMf97MPDACF2vP+hdOB323xYM1HOXu
         QcxGAQm7IXSl2AK3yBLOba/Sj0NN0Rg6gFsiVCwMSTXjzqUI8OXLvh3ICOYg+UtD5FN+
         +rHxUyVYBPch5FzPta3nj7b7YBPZimRn+9aSmrOq7QvGM7pBP8Dxjmn+oYtsxUTNnbsJ
         TzHQ==
X-Gm-Message-State: AJIora+TigsVoUODb1Txm/HZ9dUpfDFzLH5tkn0Cl0FNJayOxWffhUtQ
        El8CLu8jbZIF8kcKmDii0j/miZcr9J9fCA==
X-Google-Smtp-Source: AGRyM1vC4l54zpIaqowXts3NwfSedAG3RrmNrLGwFW4UMY9WnZWxgAulfygDzuZqomOVxslOffzNHQ==
X-Received: by 2002:a05:6402:2051:b0:435:71b5:b627 with SMTP id bc17-20020a056402205100b0043571b5b627mr23324823edb.267.1656417501043;
        Tue, 28 Jun 2022 04:58:21 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id v18-20020a50a452000000b0043576d146f0sm9487803edb.54.2022.06.28.04.58.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 04:58:20 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1o69rH-001sIT-KX;
        Tue, 28 Jun 2022 13:58:19 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Pavel Rappo <pavel.rappo@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>
Subject: Re: How to reduce pickaxe times for a particular repo?
Date:   Tue, 28 Jun 2022 13:35:19 +0200
References: <CAChcVumN66OxOjag9gPqgLq7gQrgdaEkZAJabusE-gGC7LLVyw@mail.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <CAChcVumN66OxOjag9gPqgLq7gQrgdaEkZAJabusE-gGC7LLVyw@mail.gmail.com>
Message-ID: <220628.86bkudf19g.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Jun 28 2022, Pavel Rappo wrote:

> I have a repo of the following characteristics:
>
>   * 1 branch
>   * 100,000 commits
>   * 1TB in size
>   * The tip of the branch has 55,000 files
>   * No new commits are expected: the repo is abandoned and kept for
> archaeological purposes.
>
> Typically, a `git log -S/-G` lookup takes around a minute to complete.
> I would like to significantly reduce that time. How can I do that? I
> can spend up to 10x more disk space, if required. The machine has 10
> cores and 32GB of RAM.

In git as it stands now the main thing you can do is to limit your seach
by paths, and if you use the commit-graph and have a git that's using
"commitGraph.readChangedPaths" (defaults to true) doing e.g.:

    git log -p -G<rx> -- tests/

Can really help, or any other filter, such as --author or whatever.

But eventually you'll simply run into the regex engine being slow, if
you're feeling very adventurous I have a very WIP branch to make this a
lot faster by making -S and -G use PCREv2 as a backend:
http://github.com/avar/git/tree/avar/pcre2-conversion-of-diffcore-pickaxe

Bench mark results (made sometime last year) were:

    Test                                                                   =
   origin/next       HEAD
    -----------------------------------------------------------------------=
-------------------------------------------
    4209.1: git log -S'int main' <limit-rev>..                             =
   0.38(0.36+0.01)   0.37(0.33+0.04) -2.6%
    4209.2: git log -S'=C3=A6' <limit-rev>..                               =
        0.51(0.47+0.04)   0.32(0.27+0.05) -37.3%
    4209.3: git log --pickaxe-regex -S'(int|void|null)' <limit-rev>..      =
   0.72(0.68+0.03)   0.57(0.54+0.03) -20.8%
    4209.4: git log --pickaxe-regex -S'if *\([^ ]+ & ' <limit-rev>..       =
   0.60(0.55+0.02)   0.39(0.34+0.05) -35.0%
    4209.5: git log --pickaxe-regex -S'[=C3=A0=C3=A1=C3=A2=C3=A3=C3=A4=C3=
=A5=C3=A6=C3=B1=C3=B8=C3=B9=C3=BA=C3=BB=C3=BC=C3=BD=C3=BE]' <limit-rev>..  =
     0.43(0.40+0.03)   0.50(0.44+0.06) +16.3%
    4209.6: git log -G'(int|void|null)' <limit-rev>..                      =
   0.64(0.55+0.09)   0.63(0.56+0.05) -1.6%
    4209.7: git log -G'if *\([^ ]+ & ' <limit-rev>..                       =
   0.64(0.59+0.05)   0.63(0.56+0.06) -1.6%
    4209.8: git log -G'[=C3=A0=C3=A1=C3=A2=C3=A3=C3=A4=C3=A5=C3=A6=C3=B1=C3=
=B8=C3=B9=C3=BA=C3=BB=C3=BC=C3=BD=C3=BE]' <limit-rev>..                    =
   0.63(0.54+0.08)   0.62(0.55+0.06) -1.6%
    4209.9: git log -i -S'int main' <limit-rev>..                          =
   0.39(0.35+0.03)   0.38(0.35+0.02) -2.6%
    4209.10: git log -i -S'=C3=A6' <limit-rev>..                           =
        0.39(0.33+0.06)   0.32(0.28+0.04) -17.9%
    4209.11: git log -i --pickaxe-regex -S'(int|void|null)' <limit-rev>..  =
   0.90(0.84+0.05)   0.58(0.53+0.04) -35.6%
    4209.12: git log -i --pickaxe-regex -S'if *\([^ ]+ & ' <limit-rev>..   =
   0.71(0.64+0.06)   0.40(0.37+0.03) -43.7%
    4209.13: git log -i --pickaxe-regex -S'[=C3=A0=C3=A1=C3=A2=C3=A3=C3=A4=
=C3=A5=C3=A6=C3=B1=C3=B8=C3=B9=C3=BA=C3=BB=C3=BC=C3=BD=C3=BE]' <limit-rev>.=
.   0.43(0.40+0.03)   0.50(0.46+0.04) +16.3%
    4209.14: git log -i -G'(int|void|null)' <limit-rev>..                  =
   0.64(0.57+0.06)   0.62(0.56+0.05) -3.1%
    4209.15: git log -i -G'if *\([^ ]+ & ' <limit-rev>..                   =
   0.65(0.59+0.06)   0.63(0.54+0.08) -3.1%
    4209.16: git log -i -G'[=C3=A0=C3=A1=C3=A2=C3=A3=C3=A4=C3=A5=C3=A6=C3=
=B1=C3=B8=C3=B9=C3=BA=C3=BB=C3=BC=C3=BD=C3=BE]' <limit-rev>..              =
     0.63(0.55+0.08)   0.62(0.56+0.05) -1.6%

So it's much faster on some queries in particular, I don't think that
code is ready for git.git in its current form, but if you're desperate
for performance and need to run ad-hoc queries...

I don't know the full shape of your repo but 1TB in size probably means
some very big files? I think you might want to experiment with e.g. a
filtered repo to filter out big blobs or something else you may be
needlessly searching though (binaries?).

I.e. I think you're probably getting a lot of OS cache churn, where we
can't have the working data in memory for your whole search, so you're
mainly I/O bound.

I did want to (as a future infinite time project) create a search index
for regexes in git for -S and -G, i.e. we'd store something like
trigrams of potentially matchable content, so we could skip commits &
trees quickly if the diff e.g. didn't. contain the fixed string "int" or
whatever.

But that's a much bigger project...

If you're really desperate for performance & willing to hack on
somtething custom you could emulate that with a hacky solution, e.g.:

 1. Create a COMMIT=3DDIFF pair for all commits in your repo, or e.g.
    PATH=3DDIFF (so one concat'd diff with all modifications ever to a
    given path)

 2. Stick that into Lucene with trigram indexing, e.g. ElasticSearch
    might make this easy. Make sure not to "store documents" in the
    index, you just want the reverse index from say "int" to "documents"
    that contain it.

 3. Do a two-step search, where a search like "foo.*bar" is first
    against tha index, where you find say all commits that have "foo" in
    the diff OR "bar" in the diff, ditto changed paths.

 4. Feed that list into the "real" git log -S or -G search, either
    limiting by commits, or by paths (taking advantage of the
    commit-graph path index).

For someone familiar with the tools involved that should be about a day
to get to a rough hacky solution, it's mostly gluing existing OTS
software together.

You should be able to get your searches down to the tens of millisecond
range with that if also carefully manage which parts are in cache, but
it depends a lot on the exact shape of data in your repo, how much
memory you have etc.
