Return-Path: <SRS0=9JxE=D5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DBBAC4363A
	for <git@archiver.kernel.org>; Thu, 22 Oct 2020 17:40:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BFECE24641
	for <git@archiver.kernel.org>; Thu, 22 Oct 2020 17:40:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="G8X76+ak"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S369228AbgJVRkr (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Oct 2020 13:40:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S368094AbgJVRkr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Oct 2020 13:40:47 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C66EC0613CE
        for <git@vger.kernel.org>; Thu, 22 Oct 2020 10:40:47 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id c5so1775290qtw.3
        for <git@vger.kernel.org>; Thu, 22 Oct 2020 10:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3eof7ATnKq3mS0dKgZvp78S6ndgo/X4NF9gWDrc/YkE=;
        b=G8X76+akUxUKWdcjHSjzG1LyjNDS0ADDKqIT6z6E1/ZQyysdi9SwXXLvIKefXF8hDx
         XB8HBUg/q5pzzB8J3Tii6Y2OlOmhz0kTsgFxn4roKq1e4fSLJJmb+V0Wp4raNyJrRDDj
         Nd2LmlGUrPs4dW3PcHZSFckLJNKFqQiBx3mVeukcC0xUIEZ+ZbPN1TXb+IS84XQqGXPo
         iY4xMOG/hJV5eaDtcvo0pL/eYW127AUQ5YnBod6Ni9TqCrYjQz3+R+rJf631SnaKe77s
         T1up4AKQC7Pj2erZOhSebpib4Wt7OoOIDON6LlmS0NsEeMIzBiTo/UIZQ2DHmIOEGMMI
         c64A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3eof7ATnKq3mS0dKgZvp78S6ndgo/X4NF9gWDrc/YkE=;
        b=r1K9KpLxcam6xNIq201CcFBTkzLixe8qw/LC83GyKzKd5fP/n4+Bo7WdxIiAuergpY
         TPJlYQMpOoCemhLO3go8JkVGYXne9kE0ovyCbFaZrn0iPY+wI6UbwEnMD3cx12Mo783o
         IBE8LsEH0tnKhKYD3jwlNptVw3DKwxAmYVO4IxmVbAErJNqhEy+lsqB38orJue3RjDVK
         fQXTT3jtVbnq90RdVANqGbvnSFGX+2vAuI9AUW6aujMgvmf72REZoRm/nZ9z/kXPyLzh
         T1ryZcc1ySsS4exr2aAKU66akQk1g9BJHWkX63GTw3B3dTr4FepzMluKFY8yjTuGqu2W
         TnRw==
X-Gm-Message-State: AOAM532ZrJDfiR4U5D0zQ7JCHWn6613aRrD46QzZyuMmipdAEeUIqLKu
        9lFGq4AOTGcMjONtK89VjTvQ3A==
X-Google-Smtp-Source: ABdhPJzY3EjsTMzDf48E6dMPM+cdUL9VlZb6Yf0fn1qlxoFkO/HxkcU648KoZEv/HsWCih1zgln/+g==
X-Received: by 2002:ac8:1910:: with SMTP id t16mr2916131qtj.351.1603388446282;
        Thu, 22 Oct 2020 10:40:46 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:fdf3:f65:ad7d:8324])
        by smtp.gmail.com with ESMTPSA id t3sm1455004qtq.24.2020.10.22.10.40.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2020 10:40:45 -0700 (PDT)
Date:   Thu, 22 Oct 2020 13:40:43 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Nipunn Koorapati via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Nipunn Koorapati <nipunn1313@gmail.com>
Subject: Re: [PATCH v2 0/2] fsmonitor inline / testing cleanup
Message-ID: <20201022174043.GA775513@nand.local>
References: <pull.767.git.1603303474.gitgitgadget@gmail.com>
 <pull.767.v2.git.1603326066.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.767.v2.git.1603326066.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Nipunn,

On Thu, Oct 22, 2020 at 12:21:04AM +0000, Nipunn Koorapati via GitGitGadget wrote:
> UPDATE SINCE v1
>
>  * Removed include of dir.h from fsmonitor.h as it's no longer needed

This version all looks sensible to me.

I'm still iffy on whether or not this series makes sense to apply
without the rest of the code that depends on it, but I'll leave that up
to Junio whether he wants to take the series as it is now, or wait for
other patches to come in on top.

In either case, these two patches are:

  Reviewed-by: Taylor Blau <me@ttaylorr.com>

Thanks,
Taylor
