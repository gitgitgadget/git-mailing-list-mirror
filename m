Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B6EDC433F5
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 02:08:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E50AF61242
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 02:08:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351512AbhJACKC (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Sep 2021 22:10:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230293AbhJACJ6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Sep 2021 22:09:58 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19C46C06176A
        for <git@vger.kernel.org>; Thu, 30 Sep 2021 19:08:15 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id l7so5354851edq.3
        for <git@vger.kernel.org>; Thu, 30 Sep 2021 19:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WOnzhM/4+SNSv081L2tPOKhoH3476TsybrHiR5bTRNA=;
        b=dtkUVTI22KQ1HGEkSxLm1/gPP1L+sLzayAJSZvvHyboK/X9xnIdwAtmA61/pH5Msom
         VmTAzLx8SGQG5TGFDePa8GcMJR9oz9jNI1yFzo3/liFXLC32kR76TknQn9LKtDRx/f5D
         b0AeT3p8Cg6m3UeBIISaFkvdjrn/Sf79Tc3HHDAcZwLt22sI4KEqXPSqs/6SoMUIVCL4
         PDR3XNjXgEJwpEBsloCsT9qprI9eSv307mTJIJw6GLo0Dr1TlEZZzj8QTozsqoOL4Wvj
         tNejzukL2VBIqUetA5cfYYhP/nwLPpIIT0EdG7E0JVbd4VM4Y9QrjfTy478QfmODmAYw
         MvlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WOnzhM/4+SNSv081L2tPOKhoH3476TsybrHiR5bTRNA=;
        b=tl098VJ2SrCVLwHuCDR1P6in37SUWuOLI4FC1n//UhlzeIGZNkcvSzliV4EMwXiGpq
         Cm8pm5zHNTtUMHW8P0S6K43DNcuXRTHCZsSda3rU0y0XT5kXR3dFFhZI5prF6CCgCnvO
         hu1ecKxa80qvz9L36p6kfww87QZZ8aZh7RoydBS2rB15MZbHlqXuBWFp2o9oiTNio/8I
         xgiMMiWFAyzzk+Qn40pjT2zp2iwD006Iu0fAyRpV8dPGmh9z/lyp/Ne3ag/lDzVchGLu
         yVSQxnQNjxBjphuVlMpJyYgi1/O5s3FY6cvEhWsDwyagp2N1ODoYa9Hob6ScK1aSMSjt
         wGIA==
X-Gm-Message-State: AOAM533GWZ+fgcuoI0fsfnOVWt4rvawy+RRVf3Rt7cO92o5drQyuEJMg
        fBs7Tkkq0vgIq/czus7x6TmqE65xUAYPNS8FTTaEZFGjCA8=
X-Google-Smtp-Source: ABdhPJyEVdk6LuBIZFq7gpvbqt2Tyil0Ddr1QQV06WAOf0hAkK6Ri3og8obi1VoPW/dYM0vdiXAtsBCqCLP/Inu3RJ0=
X-Received: by 2002:a05:6402:1d9c:: with SMTP id dk28mr6159452edb.241.1633054093654;
 Thu, 30 Sep 2021 19:08:13 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1036.v2.git.1632465429.gitgitgadget@gmail.com>
 <pull.1036.v3.git.1632760428.gitgitgadget@gmail.com> <aaa8ea3b-0902-f9e6-c1a4-0ca2b1b2f57b@gmail.com>
In-Reply-To: <aaa8ea3b-0902-f9e6-c1a4-0ca2b1b2f57b@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 30 Sep 2021 19:08:01 -0700
Message-ID: <CABPp-BHLyGP_V0P3jav2d6WR4CUpzZ4QwgazQJggG1diDJEaww@mail.gmail.com>
Subject: Re: [PATCH v3 00/11] Fix various issues around removal of untracked files/directories
To:     Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Fedor Biryukov <fedor.birjukov@gmail.com>,
        Philip Oakley <philipoakley@iee.email>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

On Thu, Sep 30, 2021 at 3:08 AM Phillip Wood <phillip.wood123@gmail.com> wrote:
>
> Hi Elijah
>
> On 27/09/2021 17:33, Elijah Newren via GitGitGadget wrote:
> > We have multiple codepaths that delete untracked files/directories but
> > shouldn't. There are also some codepaths where we delete untracked
> > files/directories intentionally (based on mailing list discussion), but
> > where that intent is not documented. We also have some codepaths that
> > preserve ignored files, which shouldn't. Fix the documentation, add several
> > new (mostly failing) testcases, fix some of the new testcases, and add
> > comments about some potential remaining problems. (I found these as a
> > side-effect of looking at [1], though [2] pointed out one explicitly while I
> > was working on it.)
> >
> > Note that I'm using Junio's declaration about checkout -f and reset --hard
> > (and also presuming that since read-tree --reset is porcelain that its
> > behavior should be left alone)[3] in this series.
> >
>
> I've had a read through and I don't have any specific comments, I like
> the way you have simplified adding the standard excludes for callers and
> making the existing value of reset invalid when converting to an enum. I
> think there is a small risk someone will complain about read-tree
> changing how it handles ignored files, but hopefully everyone was just
> passing ".gitignore" to --exclude-per-directory and they wont mind
> 'read-tree -m -u' removing ignored files now.

Thanks for taking a look!
