Return-Path: <SRS0=/7R8=BN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07AC6C433E0
	for <git@archiver.kernel.org>; Mon,  3 Aug 2020 19:11:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5643320A8B
	for <git@archiver.kernel.org>; Mon,  3 Aug 2020 19:11:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="E2UWB+x6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726968AbgHCTLm (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Aug 2020 15:11:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726007AbgHCTLm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Aug 2020 15:11:42 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21953C06174A
        for <git@vger.kernel.org>; Mon,  3 Aug 2020 12:11:42 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id dd12so12837020qvb.0
        for <git@vger.kernel.org>; Mon, 03 Aug 2020 12:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6OQs0mSjqCDJKkVIWTd7Opxv5sbOD352KsHf4fnReFY=;
        b=E2UWB+x63tkVkxN73SGI90xJ6wGJ+SK+6oMW0o4VsMlx9iTG+FA0Sm6n65La8owLRe
         1IJh7PTBt88MQ+7C1mOo9PvKav8iQ3xe3vuN56x+Pa/Y9cGxxrfAW4fzLRLbDvdustuY
         M8khXgC/cyYJvm7sURVexXMjvDm8p0SxRdXZCWxWER3JB7RB4oJY8rGto+VHGAM4nU9u
         LUzkpAI0cVr67BS/uUDKIfvjoi106QOmhgyVJd9vxquSc3lrpHdghzCHQrPm+KojyXAa
         jblfYehIIKg4Q1+CqDb06sFsNbTOKIjPWRsO8qEn3HQc0BPFwws+FOKA2iLtRXEv9RmX
         Bhdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6OQs0mSjqCDJKkVIWTd7Opxv5sbOD352KsHf4fnReFY=;
        b=XJYQhvOOUsIbA33/gNr1iFY/3ugPKWToKH11F65eh8pLTivyh2TNJZouaPo+0d/z1A
         Z85/5zSIhP3/Za/kVe7oLJfRt1h8Yxh6S917DJ+7a4umORHWCijeMA+obqihclUhwACe
         Gd5YoB8Zo8PgaIs0Q8TfAk3aaZHuNdwkl5qL8gJmf3HQ+g7K7akKszdNO+BXLPYkeceU
         vzTsMPED5hY+XS4vaur+toENjhDh4hGfwtwNqM1S9VJEPRMLvQEBwNjRvDL3uohz0GJE
         Uwwr4VesyWulL91S6G3iYo/XX0zi1Y9f3w0nyYNDAFw3bjhEWRtXpp+ecKqw6cS9q4iC
         QSrg==
X-Gm-Message-State: AOAM531hPvcQbU7rzsYNfdI3acjrXRXVeSKYxoU47QeVV9af5JVofqOU
        lywJhbgBJXWZoDJa0yceq0oADIEpl//j7w==
X-Google-Smtp-Source: ABdhPJyDnoMh+gjKF4KapHxxaMlinYQaPsPjrdNuimXbrlIheJxOxRTLO3zzDSpMGfni/t9khciN5Q==
X-Received: by 2002:a0c:b891:: with SMTP id y17mr18580331qvf.2.1596481901218;
        Mon, 03 Aug 2020 12:11:41 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:3475:b417:c07c:c811])
        by smtp.gmail.com with ESMTPSA id 139sm19008264qkl.13.2020.08.03.12.11.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 12:11:40 -0700 (PDT)
Date:   Mon, 3 Aug 2020 15:11:39 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Noam Yorav-Raphael via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Noam Yorav-Raphael <noamraph@gmail.com>
Subject: Re: [PATCH v3] docs: improve the example that illustrates git-notes
 path names
Message-ID: <20200803191139.GA68002@syl.lan>
References: <pull.692.v2.git.1596471677167.gitgitgadget@gmail.com>
 <pull.692.v3.git.1596481815803.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.692.v3.git.1596481815803.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 03, 2020 at 07:10:15PM +0000, Noam Yorav-Raphael via GitGitGadget wrote:
> From: Noam Yorav-Raphael <noamraph@gmail.com>
>
> Make it clear that the filename has only the rest of the object ID,
> not the entirety of it.
>
> Signed-off-by: Noam Yorav-Raphael <noamraph@gmail.com>
> ---
>     Improve the example that illustrates git-notes path names
>
>     docs: improve the example that illustrates git-notes path names
>
>     Make it clear that the filename has only the rest of the object ID, not
>     the entirety of it.
>
>     Changes since v1:
>
>      * Improved the commit message, according to comments by Taylor Blau.
>      * Changed the parts to random hex, so the '...' won't be confusing,
>        according to suggestion by Junio C Hamano.
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-692%2Fnoamraph%2Fclearer-notes-path-doc-v3
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-692/noamraph/clearer-notes-path-doc-v3
> Pull-Request: https://github.com/gitgitgadget/git/pull/692
>
> Range-diff vs v2:
>
>  1:  8b3defb657 ! 1:  e973e321d8 docs: improve the example that illustrates git-notes path names
>      @@ Documentation/git-notes.txt: are taken from notes refs.  A notes ref is usually
>        they describe, with some directory separators included for performance
>        reasons footnote:[Permitted pathnames have the form
>       -'ab'`/`'cd'`/`'ef'`/`'...'`/`'abcdef...': a sequence of directory
>      -+'12'`/`'34'`/`'56'`/`'...'`/`'789abc...': a sequence of directory
>      ++'bf'`/`'fe'`/`'30'`/`'...'`/`'680d5a...': a sequence of directory
>        names of two hexadecimal digits each followed by a filename with the
>        rest of the object ID.].
>
>
>
>  Documentation/git-notes.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/git-notes.txt b/Documentation/git-notes.txt
> index ced2e8280e..0a4200674c 100644
> --- a/Documentation/git-notes.txt
> +++ b/Documentation/git-notes.txt
> @@ -223,7 +223,7 @@ are taken from notes refs.  A notes ref is usually a branch which
>  contains "files" whose paths are the object names for the objects
>  they describe, with some directory separators included for performance
>  reasons footnote:[Permitted pathnames have the form
> -'ab'`/`'cd'`/`'ef'`/`'...'`/`'abcdef...': a sequence of directory
> +'bf'`/`'fe'`/`'30'`/`'...'`/`'680d5a...': a sequence of directory
>  names of two hexadecimal digits each followed by a filename with the
>  rest of the object ID.].
>
>
> base-commit: 85b4e0a6dc8407de6f69808d9ee6debdf167ced3
> --
> gitgitgadget

Looks good to me, but Junio should chime in, too.

  Acked-by: Taylor Blau <me@ttaylorr.com>

Thanks,
Taylor
