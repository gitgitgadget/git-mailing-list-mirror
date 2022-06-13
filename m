Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8CA0C43334
	for <git@archiver.kernel.org>; Mon, 13 Jun 2022 21:36:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347266AbiFMVgs (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Jun 2022 17:36:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347095AbiFMVgq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Jun 2022 17:36:46 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F878194
        for <git@vger.kernel.org>; Mon, 13 Jun 2022 14:36:45 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id l3so3532044qtp.1
        for <git@vger.kernel.org>; Mon, 13 Jun 2022 14:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gMgLd0WD3scKj9WAwzOml44jtbimMum0ZTVvfEE3x9U=;
        b=Awrq4IkaojqehRSn+SysjMJHSjyDOban7eS5IS9eEun+lQ3DT5IUE9/GNwO5NFHGfv
         h8WqJKPkPxeiDvkaALdTVZUq2SYJsR4cItZgSl9fmcprlXEWg/T6tFTBgYByImm2kQ4A
         9u6svYPTbyAVPJFzYFT4PvPX4niRdVx/zlZAgydCX53Te0/PbGNbICHvq27v0PRm8A5W
         fRUIqMc8Gh3N/RJTYQmcoA0cgn0RZmJeDVJC6CQjEHFP7ciJDfWTC+MJOujRkTIv4GoU
         OJftJAM4fvjRrV0ME4w6KXanxter2cGy8T6ep1Bf/iwnQCojHWAcibuAGJiv0wXKUE07
         Qpmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gMgLd0WD3scKj9WAwzOml44jtbimMum0ZTVvfEE3x9U=;
        b=A87ty50qjD5uBbLoEWmOz8ysSfz0KTqkXBz9iG06T43Owdo3y+vXGPdT5bVDwQeoeF
         iqRCNEYVE9qK9Qzq+Yt9vYF95B5sdxCFtKzmsoWSkE1w6VV4QuwBkYQG7DvjQuukP56+
         muQPwY/5MM9Z2apfcRfeHbwj287a+Xjw7ux85bcL4xfGb/9jYj4AnPs6FvwWkXlZtLP9
         Ic7TYdQKwrIjfaWI+7MlqBxt6Get3l484hWFyYn3dUZj2YQbl+VpnjzL7YtvPk4Pe3s1
         XoNdzp0E7ZKZ4NtkZoOd3EvZNPg/CwjA+QskDwF0XGpfNVCt+hoBJgalraGiDSSqJtyp
         kZ8g==
X-Gm-Message-State: AOAM532Gc+vLlxJPK1Y+LBxW6cfDLrEO3ZqA0+wsh9gHUQuxpMWtPyOU
        RfKr9Xfzwp8hu5olIN0bu2uEtxjxCOQwI8my
X-Google-Smtp-Source: ABdhPJwP0miYgMvEbk5HYj9dE1b/C+0N8i7Ya9I+TLGIpE5AhfV4bWZG41+/yKLTe1IImfjwhyZOEQ==
X-Received: by 2002:a05:622a:100a:b0:304:eb7b:5e1b with SMTP id d10-20020a05622a100a00b00304eb7b5e1bmr1679386qte.393.1655156204754;
        Mon, 13 Jun 2022 14:36:44 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 14-20020a37030e000000b006a6b498e23esm8067693qkd.81.2022.06.13.14.36.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 14:36:44 -0700 (PDT)
Date:   Mon, 13 Jun 2022 17:36:43 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc:     git@vger.kernel.org
Subject: Re: Repository corruption if objects pushed in the middle of repack
Message-ID: <Yqet68Sll1cz+ySY@nand.local>
References: <20220613203145.wbpi2m3ys3hchw6c@meerkat.local>
 <YqepoUMb3rkKgWqB@nand.local>
 <YqerC883GiwHiiZU@nand.local>
 <20220613213221.iekmfjihho5ujfq2@meerkat.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220613213221.iekmfjihho5ujfq2@meerkat.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 13, 2022 at 05:32:21PM -0400, Konstantin Ryabitsev wrote:
> On Mon, Jun 13, 2022 at 05:24:27PM -0400, Taylor Blau wrote:
> > A much more likely explanation for what is going on has to do with the
> > `--unpack-unreachable` option you're using.
> >
> > In your example, any unreachable object written within the last day is
> > written loose, and anything else older than that is simply discarded. If
> > the following happens, in order:
> >
> >   - an unreachable object is detected, and marked for deletion
> >   - that object then becomes reachable via some ref-update
> >   - then the object becomes an ancestor of some push which depends on it
> >   - _then_ the object is deleted by repack
> >
> > ...then the repository will be missing some objects which are in its
> > reachable set, and thus corrupt. IOW, the `--unpack-unreachable` option
> > (and its successor, cruft packs) are both racy with respect to
> > ref-updates.
> >
> > Are you able to find evidence of that race in your logging? I would bet
> > that is likely what is going on here.
>
> I'm not sure that's the case, because the object that is missing is the one
> that didn't exist before the repack started. In the scenario you describe, the
> pre-existing unreachable ancestor of it would be missing, not the newly
> incoming object. Right?

Aren't we reporting that the newly pushed tree was broken _because_ it
had some links to sub-trees that no longer existed?

Thanks,
Taylor
