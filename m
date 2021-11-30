Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98A11C433F5
	for <git@archiver.kernel.org>; Tue, 30 Nov 2021 02:57:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232416AbhK3DBN (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Nov 2021 22:01:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229996AbhK3DBM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Nov 2021 22:01:12 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 310AFC061574
        for <git@vger.kernel.org>; Mon, 29 Nov 2021 18:57:54 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id bu18so50008699lfb.0
        for <git@vger.kernel.org>; Mon, 29 Nov 2021 18:57:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cLYBJbk+TNciwKSjH0UIKTGBj2ICsoIHzrWT9zkNrLg=;
        b=YapbvcQb+GSwRpugrwaRiojPVZBp5LBq8QO/HlYUpV3UHUOPY9t9CFc6WE0Sr77847
         +q3nERjcgGxibD+saxsyVkPL5CayaZnKje+CN+coRWAaFUNcUwpEK9xsGNC9+kYc6TPD
         9dvnfeqOnvfNwPHcChlsABhD99EKIFjBpdG8NI8FoLK93tGKHvSU+4uY7+6kNBGPTDjX
         7Z7SRaDKPUt/MUf1EbpwHojBL1CD+IAF9rgF0Uls6+QfAHpo+fqpV6qmZIW7fWqRcWTX
         BY3i0RJiGjR+qipNHbx50KR9zgzbVnb53nOhwxBvsxjc8VeukH4+i2TsZRVz9O4YjFof
         CDYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cLYBJbk+TNciwKSjH0UIKTGBj2ICsoIHzrWT9zkNrLg=;
        b=2uU3xVKgOR0FY9/rLPR200+8d3eqyR/M0Hx1TC+HbZcjse2FZsGV3sSOiB0J2GvPbO
         RYVOcFH02/YZD2T3tzvGj/mOi+3Ylr10dPxu/6H5lWdp+6Ds0bF1mKQOq7S2har2u5ef
         /R9ESiNe9zj5srJE4bquA2WxN2g16yJm1NLgVArUkrmuQ3Cg1LXIfogOXa2uCUmexh0w
         oM962BfWyOkzR0CmJOp3iONiKcWSKzHgCg0EkqW9JtQPZ24FJGfH9g5AKUbeQbndH0mH
         BduvVIMM06vGi/QAzYewfmx9Ai2OIWrk8O2jiI+9m16otdKMrzEJF+ahtrRP6+zZMWxq
         wNXw==
X-Gm-Message-State: AOAM531WqDMLMiMr71w80A7V/X+hzlXgu3Hvv1UbxTTHJaMj4jcvyuJz
        lBNBvNspG3wwD53aWYLl90I8l8Q+YaqymzwScoU=
X-Google-Smtp-Source: ABdhPJy51AMKSuflAv6ggyxLZdZN2IFjJWz63HthFA6dMN4o70G0erk3wYiL7dHCzTkyngoZyEc0jHgU4ososo0y3A8=
X-Received: by 2002:a05:6512:2314:: with SMTP id o20mr50090775lfu.51.1638241072397;
 Mon, 29 Nov 2021 18:57:52 -0800 (PST)
MIME-Version: 1.0
References: <20211009082058.41138-1-chiyutianyi@gmail.com> <20211122033220.32883-1-chiyutianyi@gmail.com>
 <CAO0brD3VPtUrpCE2kCJDram=bLMN=89++=bgf1TddriTYo-nsA@mail.gmail.com> <YaUmFpIeCvHdKixj@coredump.intra.peff.net>
In-Reply-To: <YaUmFpIeCvHdKixj@coredump.intra.peff.net>
From:   Han Xin <chiyutianyi@gmail.com>
Date:   Tue, 30 Nov 2021 10:57:40 +0800
Message-ID: <CAO0brD3bSaYabKgdDZjqJd97CJ2hN1XuxWGc+Ww1GZ2wpKA4ZQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/5] unpack large objects in stream
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Philip Oakley <philipoakley@iee.email>,
        Han Xin <hanxin.hx@alibaba-inc.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 30, 2021 at 3:12 AM Jeff King <peff@peff.net> wrote:
> We set transfer.unpackLimit to "1", so we never run unpack-objects at
> all. We always run index-pack, and every push, no matter how small,
> results in a pack.
>
> We also set GIT_ALLOC_LIMIT to limit any single allocation. We also have
> custom code in index-pack to detect large objects (where our definition
> of "large" is 100MB by default):
>
>   - for large blobs, we do index it as normal, writing the oid out to a
>     file which is then processed by a pre-receive hook (since people
>     often push up large files accidentally, the hook generates a nice
>     error message, including finding the path at which the blob is
>     referenced)
>
>   - for other large objects, we die immediately (with an error message).
>     100MB commit messages aren't a common user error, and it closes off
>     a whole set of possible integer-overflow parsing attacks (e.g.,
>     index-pack in strict-mode will run every tree through fsck_tree(),
>     so there's otherwise nothing stopping you from having a 4GB filename
>     in a tree).

Thank you very much for sharing.

The way Github handles it reminds me of what Shawn Pearce introduced in
"Scaling up JGit". I guess "mulit-pack-index" and "bitmap" must play an
important role in this.

I will seriously consider this solution, thanks a lot.
