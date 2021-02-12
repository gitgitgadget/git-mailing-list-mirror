Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01D84C433E0
	for <git@archiver.kernel.org>; Fri, 12 Feb 2021 05:53:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9F9B64E70
	for <git@archiver.kernel.org>; Fri, 12 Feb 2021 05:53:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229575AbhBLFwm (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Feb 2021 00:52:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbhBLFwl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Feb 2021 00:52:41 -0500
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32764C061574
        for <git@vger.kernel.org>; Thu, 11 Feb 2021 21:52:01 -0800 (PST)
Received: by mail-io1-xd2d.google.com with SMTP id u20so8183398iot.9
        for <git@vger.kernel.org>; Thu, 11 Feb 2021 21:52:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iUgZ7V40T1els9lCFIJSVqI4PH03vAexkB9BAKaZ7K0=;
        b=R/ohRhxoMzeCspU/mA5F9WsApYTT1sDIStTorNfGVh6UuWVoD+Ayjs/Lk/x44a5SF+
         /t793e5sMdnuSLXOSm2V5eGWuRgna6Fzd1TiPTIQVn15XzOkN4eS3lZCC34wQ6ThTCK1
         MxRVdY62jM1Ypbr3HkiHdy/0htc74ZKU7bZFQzEn4dhRgNvFHHFlzwJ/4xlKF9aYbbSq
         gGM4PO6F90C1FzO8KLuNG9vVwWFCiFHRxHaHpGYhrud9qS05XF2IR7Jixl3ryxjkCNYC
         krCSwr0uunbxFxq8QgmyitWxV0TcrBum9CrrohPtGeGVrljZ3nGp+KYXxFctNCmS5dWE
         7ADQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iUgZ7V40T1els9lCFIJSVqI4PH03vAexkB9BAKaZ7K0=;
        b=FPL1KmcSNM5ohhichB5pf0s/BwZCgfBwTs8N72np0jEz90wBQ67YLZqQJU63gc3+w1
         rMAqkLZ9xxdYv11XnK1majxG26IsDLlDjMe++g8MXSCsQHuEpKhnFLhjm7RUXxxVgLv6
         8mJ6hGMkAD26DinJlhZwLA+qA5cJSUH4rYy8BvTi2K9hM8kbFB4kVLJOTJ1u5B8qTuHe
         Sdmb25Pi0bqKadjVQRTFMxH4IF0zZh44xmphD6qggAAVH/jNi0m8fUBH9ibVjPC2+Rdi
         SE/EdyxCJhb7jpQEQ0eOxr9RLGxHZ8syeQTxQL7XbwyPfW6jaeViRr30qeXk9+5OpxW7
         AQiA==
X-Gm-Message-State: AOAM533ikOK2QeXR0RTMWchBJaR3MPmfYoUiIuzmFJrHPVHzlx+mHzg5
        LDSMkq5azSj8LxABxfHD+5YtSBHfY+9oa4rhLnTXVmPmUuGfZA==
X-Google-Smtp-Source: ABdhPJyyw40f7q1gAJZmAyUToXs1LBLFdbK10qOpIsr4dzWuBK810QKC5dB0qVUpZ/g4LQ/IsBxA6T5LPNpUCczUMO0=
X-Received: by 2002:a05:6602:1693:: with SMTP id s19mr1031930iow.68.1613109120687;
 Thu, 11 Feb 2021 21:52:00 -0800 (PST)
MIME-Version: 1.0
References: <2fb58fd30ae730ccd3e88ec51b5fe6d80ab7a8c7.camel@guriev.su>
In-Reply-To: <2fb58fd30ae730ccd3e88ec51b5fe6d80ab7a8c7.camel@guriev.su>
From:   David Aguilar <davvid@gmail.com>
Date:   Thu, 11 Feb 2021 21:51:24 -0800
Message-ID: <CAJDDKr4zM1ZuNc+JpQnAtqwa5Ljv7_5bL3X-cC3e5Xg3z2Cbcw@mail.gmail.com>
Subject: Re: [RFC PATCH] mergetools: support difftool.tabbed setting
To:     Nicholas Guriev <nicholas@guriev.su>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 12, 2021 at 10:07 PM Nicholas Guriev <nicholas@guriev.su> wrote:
>
> I was asked how to configure "git difftool" to open files using several
> tabs and stop spawning diff application on every modified file. I looked
> into Git source and found no possibility to run diff tool at one step.
>
> The patch allows a user to view diffs in single window at one go. The
> current implementation is still poor and it can be used solely for
> demonstration purposes. To see it in action, tweak the local gitconfig:
>
>     git config difftool.prompt false
>     git config difftool.tabbed true
>
> Then run:
>
>     git difftool -t vimdiff
>
> Or:
>
>     git difftool -t meld
>
> The solution has some restrictions, diffing up to ten files works now (I
> did not bother with dynamic memory allocation), and it does not handle spaces
> in file names (I do not know how to pass them correctly to underlying tools
> without "xargs -0").
>
> I think the git-difftool--helper should be changed so that it could
> process many files in single invocation and it would not use a temporary
> file by itself. A similar behaviour can be done in git-mergetool, too.
>
> Do you have ideas how to better implement such a feature? Any comments
> are welcome.
>
> P.S.: I'm attaching screenshots for a clear demo what I mean.
> ---
>  diff.c                |  4 ++--
>  git-mergetool--lib.sh | 36 +++++++++++++++++++++++++++++++++++-
>  mergetools/meld       |  4 ++++
>  mergetools/vimdiff    | 17 +++++++++++++++++
>  4 files changed, 58 insertions(+), 3 deletions(-)
>
>
>

I'm not really sure if "tabbed" is the best name for what's going on,
though.  It's really more of a "diff everything in one shot" mode, and
it just so happens that the tools in question use tabs.

General note -- similar to the convention followed by
mergetool.hideResolved and other difftool things I think it would make
sense for tools to be able to override this on a per-tool basis.

That said, I wonder whether we need this new feature, or whether we
should instead improve an existing one.  I'm leaning towards improving
the existing dir-diff feature as a better alternative.

It's unfortunate that the "git difftool --dir-diff" feature doesn't
seem to mesh well with vimdiff.  It does work well with other tools
that support diffing arbitrary directories, notably meld, xxdiff, etc.

Regarding vimdiff + git difftool -d, there is this advice:
https://stackoverflow.com/questions/8156493/git-vimdiff-and-dirdiff

meld works just fine with "git difftool -d" (arguably nicer, since it
gives you a directory view and a diff view in separate tabs), so if
the only improvement is for vimdiff, then maybe the advice with the
DirDiff plugin might be a better way to go.

Having something like a "difftool.vimdiff.useDirDiff" configuration
variable could be a way for us to adopt the advice that they offer
there.  We could have the dir-diff difftool mode set a variable that
the vimdiff scriptlet could use to detect that we're in dir-diff mode.
Then, when that variable is set, vimdiff could use,

    vim -f '+next' '+execute \"DirDiff\" argv(0) argv(1)' $LOCAL $REMOTE

(as mentioned in the SO page) to invoke dir-diff mode in vim.

That way the user only needs to set:

git config difftool.vimdiff.useDirDiff

... and then "git diffftool -d" will integrate with the DirDiff plugin.

What do you think about improving the vimdiff scriptlet to better
integrate with "git difftool -d" instead?
-- 
David
