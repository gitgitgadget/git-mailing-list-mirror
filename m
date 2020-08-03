Return-Path: <SRS0=/7R8=BN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1BAEC433DF
	for <git@archiver.kernel.org>; Mon,  3 Aug 2020 16:31:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BCF4E20775
	for <git@archiver.kernel.org>; Mon,  3 Aug 2020 16:31:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="xzYVF1ux"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726688AbgHCQbO (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Aug 2020 12:31:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726370AbgHCQbO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Aug 2020 12:31:14 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07EDFC06174A
        for <git@vger.kernel.org>; Mon,  3 Aug 2020 09:31:14 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id t6so12683152qvw.1
        for <git@vger.kernel.org>; Mon, 03 Aug 2020 09:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=BWV+ZcMxRG7kkjLpfl/ThY0GdmiH1N+TE7xudk8ImUU=;
        b=xzYVF1uxAZWbw/lyrRO9Ep0q/qKOLmTOmHTW2PDqC1PTAjbnLYHJUXM6sKxi7folhA
         ubvMDG31bBNGqbZeckUYm/O0Pwn9SlpJPeV0Zcfmme8EXLRUm3hGYGpiVskyiQhlUMz/
         aFtt2IEUemzrKZgdH0IYl2mjuGvet/ND5HsCiXgrHQLGeysxKFvxGdT/Wpdo867yTNYF
         mOaL01C3Q3+GYxOkfNH1hCoC4WdGexgcTwUG2huzdgGccdcndIYXe1VOyHQ+2uR1pxZz
         4xzs4BR06/ol+zlxo/2Q+mBzseSTv3u7EU5rFxyS1w1eXK6++W999wfLUpSJXxjb54j1
         6Xdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=BWV+ZcMxRG7kkjLpfl/ThY0GdmiH1N+TE7xudk8ImUU=;
        b=ewZ6gKOWJWfL0gwvOr/Yvepkt1IOB6Oh+g5+6dALZawGwln+3YefrFOZuQmX6HF/W6
         vSHuXJA2+2keblOI00s9DTt88AT7ED/e+DmEkJxgWB/dmKqiTo2k3AdFB/XF3ZtwU3ER
         +Bhz4mxCsP4tWZGI6QsnTH3g0dN35EipdqiLRtaAt8jqbUfNQ1WoCwCWqKokYS57/PtO
         ZJv4PiP2S/Uum40dJtGfvywi7jozj99wUmZkV3ZIWbnAA/D/DKUzqmqEoLLJ85HNdvaJ
         ONaEYsMOD7L8Fk1f361Ap13U4wkfb3FhsxbbVMPfSZtPFCxoQv/tsx771jOIPZca1oWc
         AjGg==
X-Gm-Message-State: AOAM5304WJgJ/CwlvKdEzX9xYeS/czP2N8UBSm6nAxe6TcaZZE5AZunv
        zp4frVd9GjnH2dabFHw3eLed1A==
X-Google-Smtp-Source: ABdhPJxio8U0xibhk1Kh32bLmshqvFTM7B7xxG+FmvUnv02RNoBJkufD6mb/5fq+vQ0WwMKSPZ+0vQ==
X-Received: by 2002:a0c:b743:: with SMTP id q3mr17256108qve.229.1596472273134;
        Mon, 03 Aug 2020 09:31:13 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:3475:b417:c07c:c811])
        by smtp.gmail.com with ESMTPSA id 6sm18594165qkj.134.2020.08.03.09.31.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 09:31:12 -0700 (PDT)
Date:   Mon, 3 Aug 2020 12:31:10 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Noam Yorav-Raphael via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Noam Yorav-Raphael <noamraph@gmail.com>
Subject: Re: [PATCH v2] docs: improve the example that illustrates git-notes
 path names
Message-ID: <20200803163110.GC50799@syl.lan>
References: <pull.692.git.1596465817121.gitgitgadget@gmail.com>
 <pull.692.v2.git.1596471677167.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <pull.692.v2.git.1596471677167.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Noam,

On Mon, Aug 03, 2020 at 04:21:16PM +0000, Noam Yorav-Raphael via GitGitGadget wrote:
> From: Noam Yorav-Raphael <noamraph@gmail.com>
>
> Make it clear that the filename has only the rest of the object ID,
> not the entirety of it.

This looks great, thank you. I left one note below, but I don't think
that you should feel obligated to address it.

> Signed-off-by: Noam Yorav-Raphael <noamraph@gmail.com>
> ---
>     Improve the example that illustrates git-notes path names
>
>     docs: improve the example that illustrates git-notes path names
>
>     Make it clear that the filename has only the rest of the object ID, not
>     the entirety of it.
>
>     Changed: improved the commit message, according to comments by Taylor
>     Blau.
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-692%2Fnoamraph%2Fclearer-notes-path-doc-v2
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-692/noamraph/clearer-notes-path-doc-v2
> Pull-Request: https://github.com/gitgitgadget/git/pull/692
>
> Range-diff vs v1:
>
>  1:  76a674871a ! 1:  8b3defb657 docs: improve the example that illustrates git-notes path names
>      @@ Metadata
>        ## Commit message ##
>           docs: improve the example that illustrates git-notes path names
>
>      -    The existing git-notes doc says:
>      -
>      -    > Permitted pathnames have the form ab/cd/ef/…​/abcdef…​: a sequence of
>      -    > directory names of two hexadecimal digits each followed by a filename
>      -    > with the rest of the object ID.
>      -
>      -    Even though the text says that the filename has the rest of the object ID,
>      -    I felt the need to check this, since the example gives the impression that
>      -    the filename is the entire object ID (a schema which is quite prevalent).
>      -
>      -    The new example makes it clear that the filename has only the rest of the
>      -    object ID, and not the entire object ID.
>      +    Make it clear that the filename has only the rest of the object ID,
>      +    not the entirety of it.
>
>           Signed-off-by: Noam Yorav-Raphael <noamraph@gmail.com>
>
>
>
>  Documentation/git-notes.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/git-notes.txt b/Documentation/git-notes.txt
> index ced2e8280e..9fc1979531 100644
> --- a/Documentation/git-notes.txt
> +++ b/Documentation/git-notes.txt
> @@ -223,7 +223,7 @@ are taken from notes refs.  A notes ref is usually a branch which
>  contains "files" whose paths are the object names for the objects
>  they describe, with some directory separators included for performance
>  reasons footnote:[Permitted pathnames have the form
> -'ab'`/`'cd'`/`'ef'`/`'...'`/`'abcdef...': a sequence of directory
> +'12'`/`'34'`/`'56'`/`'...'`/`'789abc...': a sequence of directory

Sorry for not suggesting this earlier, but I think you could just as
easily start this with '01' instead of '12'. I don't think that it
matters, though, the point that you're trying to illustrate is perfectly
clear.

>  names of two hexadecimal digits each followed by a filename with the
>  rest of the object ID.].
>
>
> base-commit: 85b4e0a6dc8407de6f69808d9ee6debdf167ced3
> --
> gitgitgadget

  Reviewed-by: Taylor Blau <me@ttaylorr.com>

Thanks,
Taylor
