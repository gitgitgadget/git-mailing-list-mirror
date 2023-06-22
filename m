Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 878BFEB64D8
	for <git@archiver.kernel.org>; Thu, 22 Jun 2023 12:49:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231466AbjFVMtu (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Jun 2023 08:49:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231436AbjFVMtt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jun 2023 08:49:49 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 295FA19AF
        for <git@vger.kernel.org>; Thu, 22 Jun 2023 05:49:48 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id 3f1490d57ef6-bc476bf5239so6949277276.2
        for <git@vger.kernel.org>; Thu, 22 Jun 2023 05:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1687438187; x=1690030187;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KOIqfVjyLSrbqlNLEnE7jCbaP30jt0AlSlnvDTzls48=;
        b=QSD+WGDXDdKYc9wANo8LJerkqZnskDsE1Rc6ocqNQRUT1pb1lO8y4tllOZYNhNmpFI
         W5tAQ6RtLHesOTGWVfDnD883oI/uA1Wd0qeAJ54mAn/uxNYfo2yl6Uj/d7oXLP+2rSVu
         oMPCMzhxX48ZL7yaoY4AENmF4Ay5GTSmTE5FYDWXcoL6PQ4dyyYcDa+XmP0t1Xf4fqEg
         X/e5ImR+Dp/3n/E+cO9TJKCY84pFGHSKC8XoBZz46WT9BEcj3yfof6U6fN9lgd0loOA8
         dDYP0Z8H+pgkZUFVIIwpEQTe6AceTtguv2D5REhhtiXhUCRdWdh/3NeFh9HSpshm+WiT
         2tqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687438187; x=1690030187;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KOIqfVjyLSrbqlNLEnE7jCbaP30jt0AlSlnvDTzls48=;
        b=SMsxoRwM4XFAue1wOWGOvwQnQ+uypbgj9/TAn/3ryR6QOkSZGriDTKAtJ8K7jZw1GK
         Qiq2cS+5/98QO9PGvqgOHTd66tQCnmV/9lCjgH7aVjY609H72g8xHdKhVBcvZ8mFBnje
         XuOmwl1hD1EYZgrLi+su1MOYDzLvkZwtt8qpB1CcvHW4U/TE1qpecGP5HwwFXmAMcPoj
         uaqNQKqN6Dc9uup1hY0USVvhR8zovh8a7r2ssYuuPiaSPT/LxIkHI2FtpJg66ymGAA+a
         gXx3uwqqI4KoYMj7UZZ+8/YZSM9H4fva6vizZhDmUrssteGrIterIpvq4iMSoHMKWke6
         Ql8A==
X-Gm-Message-State: AC+VfDyY4JaNpPkFIqZLhxf0iYa+zIP2XK4esREGusN+UNGU/zlha4e2
        Qinp00ovC0WYshycMAYSxb6vuSnSfXLXKZwSJpDjeelp
X-Google-Smtp-Source: ACHHUZ6yYu3nFtzFPKHTCOUqXsUUOICKFZBrJWBJ66lutO1Gmyst24imuXqHoeYti5TGqZjWTMlX0Q==
X-Received: by 2002:a25:b199:0:b0:bcc:a9b4:c1f8 with SMTP id h25-20020a25b199000000b00bcca9b4c1f8mr14089221ybj.33.1687438187037;
        Thu, 22 Jun 2023 05:49:47 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id i127-20020a256d85000000b00bca531ddce4sm1515916ybc.31.2023.06.22.05.49.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 05:49:46 -0700 (PDT)
Date:   Thu, 22 Jun 2023 08:49:43 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     John Cai via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, John Cai <johncai86@gmail.com>
Subject: Re: [PATCH 0/3] revision: refactor ref_excludes to ref_visibility
Message-ID: <ZJRDZ7NhyNpTV8jD@nand.local>
References: <pull.1515.git.git.1687376112.gitgitgadget@gmail.com>
 <ZJRBsDq8NI9EInel@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZJRBsDq8NI9EInel@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 22, 2023 at 08:42:24AM -0400, Taylor Blau wrote:
> On Wed, Jun 21, 2023 at 07:35:09PM +0000, John Cai via GitGitGadget wrote:
> > The ref_excludes API is used to tell which refs should be excluded. However,
> > there are times when we would want to add refs to explicitly include as
> > well. 4fe42f326e (pack-refs: teach pack-refs --include option, 2023-05-12)
> > taught pack-refs how to include certain refs, but did it in a more manual
> > way by keeping the ref patterns in a separate string list. Instead, we can
> > easily extend the ref_excludes API to include refs as well, since this use
> > case fits into the API nicely.
>
> After reading this description, I am not sure why you can't "include" a
> reference that would otherwise be excluded by passing the rules:
>
>   - refs/heads/exclude/*
>   - !refs/heads/exclude/but/include/me
>
> (where the '!' prefix in the last rule is what brings back the included
> reference).
>
> But let's read on and see if there is something that I'm missing.

Having read this series in detail, I am puzzled. I don't think that
there is any limitation of the existing reference hiding rules that
wouldn't permit what you're trying to do by adding the list of
references you want to include at the end of the exclude list, so long
as they are each prefixed with the magic "!" sentinel.

I think splitting the list of excluded references into individual
excluded and non-excluded references creates some awkwardness. For one:
excluded references already can cause us to include a reference, so
splitting that behavior across two lists seems difficult to reason
about.

For example, if your excluded list contains:

  - refs/heads/foo
  - refs/heads/bar
  - !refs/heads/foo/baz

and your included lists contains:

  - refs/heads/bar/baz/quux

I am left wondering: why doesn't the rule pertaining to
refs/heads/foo/baz show up in the included list? Likewise, what happens
with refs/heads/bar/baz/quux? It is a child of an excluded rule, so the
question is which list takes priority.

Mostly, I am wondering if I am missing something that would explain why
you couldn't modify the above example's excluded list to contain
something like "!refs/heads/bar/baz/quux", eliminating the need for the
include list entirely.

Thanks,
Taylor
