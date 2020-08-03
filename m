Return-Path: <SRS0=/7R8=BN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B7C9C433E0
	for <git@archiver.kernel.org>; Mon,  3 Aug 2020 15:48:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 599C820825
	for <git@archiver.kernel.org>; Mon,  3 Aug 2020 15:48:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="QzNfQeBM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726548AbgHCPs4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Aug 2020 11:48:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725945AbgHCPs4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Aug 2020 11:48:56 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F049FC06174A
        for <git@vger.kernel.org>; Mon,  3 Aug 2020 08:48:55 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id l23so35584894qkk.0
        for <git@vger.kernel.org>; Mon, 03 Aug 2020 08:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=wj6/OrMKoVdyGIOS/+WtNrJxifTyKtvY0yAoc1wLicg=;
        b=QzNfQeBM3IDxvjjhnKu/V0UJPL7Tli6YcSKyd3cmJpk0NK1zPo7S0A9O6XUWRliEaX
         HTW0BfQmcyiE07I9VY0wlIcxtAXoz10zjsz9q5e91TUb1yKcbctFr49FYraftKHauV2i
         PMEPHshkS00j86OkjYKOpQzmDTFm5f9J3Slbt+2KwA2hqNVeGnzew3bVOe4HdQBK+HZn
         HIX5yXKFZolL5k7b8yJGW4eXxuzBKXY6foNDqUfzxjLKDTgg5m1FhB8XU9bkPP+bKXQ1
         oCWXf1DIY+I8uroYOFduUsbleNYH7JPu/82jf5s2reiYiTjhhPkkStcaym+WYZyR7/PL
         7GJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=wj6/OrMKoVdyGIOS/+WtNrJxifTyKtvY0yAoc1wLicg=;
        b=dJACVCMHQHq10aka4ckirNZdgVEOIwDdrB6lIdqIKq4iCK5yhIiKf6cVamtXMzWH86
         6nFrf6ESNerfWHvp4PsBT9TrxTZZKQrrul8ZTB51XBZ1SbLLbVihvmf8aeiD1IO3+Vvt
         wyLbKEOScH1G0Bst3MlXrsrdFMmhqZ7ji+06we42Td9kMiu9p/WKRUHkeatllpDyqeLg
         EvFJbKQxxQCAqnAK3Yv6t4l7FRD8l/EMkM4aDvc8uW9pGAqjsSyDpStGRo/nL4v3jCfi
         u15hPm9TGxJrGVQ1yFrYNHIT5Lf5FAgAdP/gEUcmuXiWJPRoMAgoV8cxmJgdDzNVLKU7
         a+sA==
X-Gm-Message-State: AOAM532YJKAC1ZnEJpIdfNhkIcm5kS9PBDiuFpSgMq9eRfBo+U5Ku+Mg
        CLC8qx6gJSwa0SL1nck1zgeiH1RR1qcRLg==
X-Google-Smtp-Source: ABdhPJxdPKrGkMPLMo0sRcezMQ+aprG6wsURq7XbRpnMbniiHDI4UMnhkVC+vzSX9uht79/Eb97z9w==
X-Received: by 2002:a05:620a:52f:: with SMTP id h15mr16193505qkh.156.1596469735006;
        Mon, 03 Aug 2020 08:48:55 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:3475:b417:c07c:c811])
        by smtp.gmail.com with ESMTPSA id t8sm23616304qtc.50.2020.08.03.08.48.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 08:48:54 -0700 (PDT)
Date:   Mon, 3 Aug 2020 11:48:52 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Noam Yorav-Raphael via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Noam Yorav-Raphael <noamraph@gmail.com>
Subject: Re: [PATCH] docs: improve the example that illustrates git-notes
 path names
Message-ID: <20200803154852.GA48612@syl.lan>
References: <pull.692.git.1596465817121.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <pull.692.git.1596465817121.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 03, 2020 at 02:43:36PM +0000, Noam Yorav-Raphael via GitGitGadget wrote:
> From: Noam Yorav-Raphael <noamraph@gmail.com>
>
> The existing git-notes doc says:
>
> > Permitted pathnames have the form ab/cd/ef/…​/abcdef…​: a sequence of
> > directory names of two hexadecimal digits each followed by a filename
> > with the rest of the object ID.

This part of the commit message is unnecessary, since it can easily be
read off from the diff.

>
> Even though the text says that the filename has the rest of the object ID,
> I felt the need to check this, since the example gives the impression that
> the filename is the entire object ID (a schema which is quite prevalent).
>
> The new example makes it clear that the filename has only the rest of the
> object ID, and not the entire object ID.

Please use the imperative mood here. Instead of the above, consider:

  Make it clear that the filename has only the rest of the object ID,
  not the entirety of it.

> Signed-off-by: Noam Yorav-Raphael <noamraph@gmail.com>
> ---
>     Improve the example that illustrates git-notes path names
>
>     The existing git-notes doc says:
>
>     > Permitted pathnames have the form ab/cd/ef/…​/abcdef…​: a sequence of
>     > directory names of two hexadecimal digits each followed by a filename
>     > with the rest of the object ID.
>
>     Even though the text says that the filename has the rest of the object
>     ID, I felt the need to check this, since the example gives the
>     impression that the filename is the entire object ID (a schema which is
>     quite prevalent).
>
>     The new example makes it clear that the filename has only the rest of
>     the object ID, and not the entire object ID.
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-692%2Fnoamraph%2Fclearer-notes-path-doc-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-692/noamraph/clearer-notes-path-doc-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/692
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

I had to read this twice to figure out why the first 'ab' changed to
'12'. It appears that this is to avoid having to use 'gh...' in the
last directory, since 'g', 'h' and so on aren't hexadecimal digits.

Makes sense.

>  names of two hexadecimal digits each followed by a filename with the
>  rest of the object ID.].
>
>
> base-commit: 85b4e0a6dc8407de6f69808d9ee6debdf167ced3
> --
> gitgitgadget

The patch looks fine, but the commit message needs some tweaking.
Thanks.

Thanks,
Taylor
