Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0F19C433EF
	for <git@archiver.kernel.org>; Wed, 18 May 2022 15:40:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239526AbiERPkR (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 May 2022 11:40:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239512AbiERPkH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 May 2022 11:40:07 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2C3A17CE43
        for <git@vger.kernel.org>; Wed, 18 May 2022 08:40:06 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id tk15so4594660ejc.6
        for <git@vger.kernel.org>; Wed, 18 May 2022 08:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ftw2Z3zo0lUpYyH52I48ZZSQpKtm3eje5zm6X2Nq0Jg=;
        b=NXTImLtg6z9gygobPv+ZhCdRrVvgaeI+9+tR5cqlrPeoMbCRcZs/nsoUQybjrrxQcr
         U9z01JSvR/kegpFZlxYMddR5KQmkLZoPRsMB/w0MXaXetZ1Ni4z+78n6FHVvgHrWpW+g
         DHGlB+cdeLK+yTRsZ9lYfHl+5tSNMBmVuDjx3C/Og5BaUn/jl9LKFOegq5KILdnywLeE
         ba0XhxKsUiZKmzSM9+a538BHx5sUglKxJojGO8ALcK4YFaiqpEPOHBDcZ6d/tZD9NMsw
         wVQj/J01XPKBme4qpnf+fkKFQ6WJF+PH0Usa4FnhKFG+RcIhf7JEPzMf6+uLItLq27TG
         /dKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ftw2Z3zo0lUpYyH52I48ZZSQpKtm3eje5zm6X2Nq0Jg=;
        b=X+BRC7VBauL80j0Q5d8VVAei3PjXXGlxEiEA60c0mtb8RNjaquXPaOI4uURyjEPuz2
         /gePujxrMtkJIm4UDLoDfTD5Npc2fedSvJMLVJPRngtFZ3GZOsCHmDC/f80wEUJnJOVD
         9Vh/rTDIPBOej6Jd28bQ1YS1GfVE9lupIVtyMtyFdp85OD+LGHGNKx5yL40N9gPfNo3x
         UtYXoYQWAypjNP7zBIFi0kjbaNPYcQs79Voa4sV1kAWclCvCv+LoQszGmzMseZyHMi3X
         C8W76xtbfn2DWL7bNG/ITyaRIZMbcrpKoYNDx5UJe3jInfD0kZphdCC2QUMylx0hs5VR
         hgvw==
X-Gm-Message-State: AOAM533jgrl5PDUtHld1Q8W+YzftWXO+iytpYfIBghEiN2+Y44ySJ0r6
        nW1b7chRZXM75RQaHOu/L3s=
X-Google-Smtp-Source: ABdhPJwdFVP7+8AQQhr7eMzttD9IW9c9Hfy6HEWblq6RMePUNJ0Rd+nXgwq58QMn7gxSWbhprugynA==
X-Received: by 2002:a17:907:a428:b0:6fa:9253:6f88 with SMTP id sg40-20020a170907a42800b006fa92536f88mr200318ejc.518.1652888404632;
        Wed, 18 May 2022 08:40:04 -0700 (PDT)
Received: from localhost ([2a02:2149:8aa1:7500:dc1c:e29b:83a4:b580])
        by smtp.gmail.com with ESMTPSA id rk9-20020a170907214900b006fe816bf08asm1063278ejb.60.2022.05.18.08.40.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 May 2022 08:40:04 -0700 (PDT)
Date:   Wed, 18 May 2022 18:39:51 +0300
From:   Plato Kiorpelidis <kioplato@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, phillip.wood123@gmail.com, avarab@gmail.com
Subject: Re: [PATCH v2 10/15] dir-iterator: refactor dir_iterator_advance()
Message-ID: <20220518153951.ebmcd5nsnwwdrebz@compass>
References: <20220509175159.2948802-1-kioplato@gmail.com>
 <20220509175159.2948802-11-kioplato@gmail.com>
 <xmqqr152be4n.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqr152be4n.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 22/05/09 02:16PM, Junio C Hamano wrote:
> Plato Kiorpelidis <kioplato@gmail.com> writes:
> 
> > Simplify dir_iterator_advance() by converting from iterative to
> > recursive implementation. This conversion makes dir-iterator more
> > maintainable for the following reasons:
> >   * dir-iterator iterates the file-system, which is a tree structure.
> >     Traditionally, tree traversals, in textbooks, lectures and online
> >     sources are implemented recursively and not iteratively. Therefore
> >     it helps reduce mental load for readers, since it's easier to follow
> >     as it reminds of the same tree traversals we use on tree structures.
> 
> Careful.
> 
> Many algorithms that are taught in the recursive form in textbooks
> are turned into iterative in production systems for a reason.  To
> avoid too deep a recursion wasting too much stack space.  A loop
> with management of work items using in-program data structures like
> stack or queue often makes a large traversal bearable.
> 
> The most obvious example is our history traversal code.  History
> stored in Git is a tree structure, but no sane reimplementation of
> Git (well, at least those that want to be able to deal with a
> history larger than a toy project) would implement "git log" using a
> recursive algorithm.

That's a good point, I didn't think about that. It's also something that's
objective, so it's easier to reach a conclusion. This whole refactoring of
dir_iterator_advance() is a matter of opinion on what's more readable or not.

In this case, however, the dir_iterator_advance() is performing tail recursion
which doesn't require stack space. It reuses the stack frame from the current
call for the next call. Does this still pose a problem and why? If it does, I've
got no problem to work with the existing iterative implementation.

Thanks,
Plato
