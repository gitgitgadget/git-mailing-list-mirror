Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC6F0C433F5
	for <git@archiver.kernel.org>; Wed,  2 Feb 2022 01:45:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243729AbiBBBpb (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Feb 2022 20:45:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243698AbiBBBpa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Feb 2022 20:45:30 -0500
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71C48C061714
        for <git@vger.kernel.org>; Tue,  1 Feb 2022 17:45:30 -0800 (PST)
Received: by mail-qv1-xf31.google.com with SMTP id d8so17748718qvv.2
        for <git@vger.kernel.org>; Tue, 01 Feb 2022 17:45:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=khhie17eomZjSqevlI1fUsslbZa1dHaWP/w9HmYT0Q4=;
        b=DdxtHFkFo0HFk8hWdTDqkCMG+u8y7qITpOVbyfHRZ+jsAfIKLsTZ2pbwuGPpnfUzWJ
         LixZNWIDsE5ibBtgUPG+Digg1Blnu+hC5TXYEY4XlsyBF0Ae6G5BOkJ3C4TBTVpFX7qK
         T6mQkkVxF1aewnyjGDAmYttinK9nmfpWXYpMd3/fqM0mVfAbLKAWHjGVdbQQA9x3iMQ9
         ztvZgwxYEXSP4cUlrrEWTZUpx+9g1lLVy9xaYtAxYJu64gtWsq4eMiEvSqUXGBGWO8TI
         D4NVM2d0kuW7dMNrXUOzjGNfUjCL20wKK1Afy3/7MsY8w5K41T7J61bLlWRSVeDJVdtn
         JrTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=khhie17eomZjSqevlI1fUsslbZa1dHaWP/w9HmYT0Q4=;
        b=4/gvWz9fs/FlYkWgtjIqKLDbK9dospShwXjTIiGNd+3zPHW+1TBcboTHs5fv0bl1fV
         5SOVvDbHW9BQ8+yIW4Neeqlv9aCWaiD90u5FDd2HghkmAFjAzaBXkjBTTsHtTu+bMkzk
         sDA1Er781xD0Q2uz2yOX6zdn+L5ZeLh/Hlk5NDj5XhvogCKhD7Ub477JmljQARiaB0PI
         raUA2loKudWwH0HqQMINXIcNnLY5aoopbgkQ+2E1MFd2c5fk8X6HUlk2jf6yWttjPnMq
         /aw7l0GskrR1Geqbah1VtUhHi8PQYZ7c6/Eb2Ak/TNdM7UbEZr1HM+86ri12WKo2WhcY
         gS+A==
X-Gm-Message-State: AOAM532225x/DCElCqu0sHtk/jXMoQO/G829/iRwkzVNLiyIfF20L8dl
        QR95j3klr4haaPL9dhK5HqdV/g==
X-Google-Smtp-Source: ABdhPJxntE/Y4Icfc1r6YJj0S6zBF+LkHvVy1aLnNwJRyhaz4QfM7p0f8i/35yQQOJjIh7I1XdOckA==
X-Received: by 2002:a05:6214:27ce:: with SMTP id ge14mr24910144qvb.24.1643766329556;
        Tue, 01 Feb 2022 17:45:29 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id bk19sm10024006qkb.125.2022.02.01.17.45.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Feb 2022 17:45:28 -0800 (PST)
Date:   Tue, 1 Feb 2022 20:45:27 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     John Cai <johncai86@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>,
        Christian Couder <christian.couder@gmail.com>,
        git <git@vger.kernel.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Eric Wong <e@80x24.org>
Subject: Re: [RFC v3] cat-file: add a --stdin-cmd mode
Message-ID: <YfniNw/PoBeei+33@nand.local>
References: <20220128183319.43496-1-johncai86@gmail.com>
 <CAP8UFD3sHvA3Gx9+d=VjQ11sEqWF47AEeo-m4bGsVO3OUJ4dLw@mail.gmail.com>
 <YflzZsb/txsopusP@nand.local>
 <674CD40F-7060-4892-97CD-1940AEF7C3D7@gmail.com>
 <YfmUiXJ//ZC5NZU+@nand.local>
 <3FE1D509-8AD0-4F0E-9298-DFD3552A98EF@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3FE1D509-8AD0-4F0E-9298-DFD3552A98EF@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 01, 2022 at 08:34:06PM -0500, John Cai wrote:
> > So maybe a signal isn't the way to go. But I don't think `--stdin-cmd`
> > is the simplest approach either. At the very least, I don't totally
> > understand your plan after implementing a flush command. You mention
> > that it would be nice to implement other commands, but I'm not totally
> > convinced by your examples[1].
>
> I agree that if flush were the only use case for a new flag, it might not
> be worth it. But, the flush command is only one of the use cases that a
> --stdin-cmd (now changed to --batch-command per Phillip's suggestion)
>
> There are two other commands in this RFC
>
> object <rev>
> info <rev>
>
> These are described in [1] that are also a motivation for a command
> interface.
> The description in [1] explains why a command interface would be necessary.

This seems like a more realistic and well-motivated proposal, IMHO. I am
a little curious that having the ability to switch between asking for an
object's contents and its metadata would lead to saving thousands of
processes per server.

(Apropos of this series, I am curious: how long does GitLab keep a pair
of cat-file programs running for each repository?)

In any case, I'll take a closer look over the aforementioned version and
let you know what my thoughts are, probably tomorrow.

> 1. https://lore.kernel.org/git/20220128183319.43496-1-johncai86@gmail.com/

Thanks,
Taylor
