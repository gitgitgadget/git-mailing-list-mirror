Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0837EB64DC
	for <git@archiver.kernel.org>; Tue, 11 Jul 2023 17:28:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230187AbjGKR2r (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Jul 2023 13:28:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230305AbjGKR2k (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Jul 2023 13:28:40 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5EA392
        for <git@vger.kernel.org>; Tue, 11 Jul 2023 10:28:39 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-57023c9be80so67994197b3.3
        for <git@vger.kernel.org>; Tue, 11 Jul 2023 10:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1689096519; x=1691688519;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OglLa9FOtCdyjUTPU0Dm1/LiQkiXzDsXW1cFGX1q6K4=;
        b=vxYDZbsKBE5Bs20YYjcbgqGGqnliwTqG4No8CDp2x6UKYW9nyItHgvNHxcAYxCzoOu
         hBW5ivhe0MWcFqBUluTaYObwnQrO/UFM8AGLKzRart1fZ/2pXEDm2VeBOjZDYW3kOzHI
         7Ua3XwOxiOQKSAzLtgZf87wfdevsDDzfjFqddYgFhkDMfuKCLsS1X+j0NMf3+xXL9T3P
         wxfKcx9YeVKvDK4xz8Xa/1M4eckaovoDkeWaYk267uQUTH4QRmy0JDqYcqxXQMjiuijN
         DWe8eWt6TY+d0yerPPQESNb26saK9BJwmvrngZjCIx/bQ3yglYUklQFQDN/crqaovZ8N
         yUOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689096519; x=1691688519;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OglLa9FOtCdyjUTPU0Dm1/LiQkiXzDsXW1cFGX1q6K4=;
        b=F0FaQi91VecI/trgqBjaby4tmtHG4Hu7HlbfFdExgD3g+yT037ZQq+KdcjIwc8e/kp
         cxjxGtuPTC2OCUJYjYZOaOBGuBPpQ5x4fn8qPhGD4oWN4UWLESoNz2JKqGDKX72dJazB
         If2VUZSAZFWtti0xIRPJpy1Ghq7538PwgofRE/ntY6KWQl+83iAYSqykO5/jMOoxz9Jl
         5HQkAUYDvuVLEu5JU+qSLWxIBVhWZl4+lSEbVwpHRtDqHY4gKtrjH3WIzOGhrE7oH05U
         cYltFg1S6BfUUDWGiKDs6oYNfUwKfwzQAxb/XNmHqIjQVxpim+etFALxW6UxoaASDbIv
         4Eog==
X-Gm-Message-State: ABy/qLaGi4UBlUEHs5DUpT81kH+MoWcg4KIocEHQOaGoqBOiIjJ07Fbk
        EAU5XOWMx+OOjfAlx+is+0bISA==
X-Google-Smtp-Source: APBJJlGsENtnZ24eb3tCVA5vdUQ/LWY+RcrFG/3J11+C7oL8JpXAlQlFnCSx0ou5B5JxYu2xkLG4JQ==
X-Received: by 2002:a0d:e007:0:b0:56d:3b91:7e76 with SMTP id j7-20020a0de007000000b0056d3b917e76mr15983040ywe.12.1689096519015;
        Tue, 11 Jul 2023 10:28:39 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id z6-20020a81c206000000b0057740526a83sm672394ywc.49.2023.07.11.10.28.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 10:28:38 -0700 (PDT)
Date:   Tue, 11 Jul 2023 13:28:37 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Victoria Dye <vdye@github.com>
Subject: Re: [PATCH 1/2] builtin/repack.c: only repack `.pack`s that exist
Message-ID: <ZK2RRdFYl6Vey7oV@nand.local>
References: <cover.1689017830.git.me@ttaylorr.com>
 <f14a88f1075093c870cd1d53b4e0cea10d5ab67d.1689017830.git.me@ttaylorr.com>
 <xmqqedlf4jg1.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqedlf4jg1.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 10, 2023 at 01:09:50PM -0700, Junio C Hamano wrote:
> >  		git config pack.window 0 &&
> >  		P1=$(commit_and_pack 1) &&
> >  		P2=$(commit_and_pack 2) &&
> >  		P3=$(commit_and_pack 3) &&
> >  		P4=$(commit_and_pack 4) &&
> > -		ls .git/objects/pack/*.pack >old-counts &&
> > +		find .git/objects/pack -name "*.pack" -type f | sort >old-counts &&
> >  		test_line_count = 4 old-counts &&
> >  		git repack -a -d --keep-pack $P1 --keep-pack $P4 &&
> > -		ls .git/objects/pack/*.pack >new-counts &&
> > +		find .git/objects/pack -name "*.pack" -type f | sort >new-counts &&
> >  		grep -q $P1 new-counts &&
> >  		grep -q $P4 new-counts &&
> >  		test_line_count = 3 new-counts &&
>
> I do not think "sort" in both of these added lines is doing anything
> useful.  Does the test break without this hunk and if so how?

This is an error on my part; I don't think I realized that a bare ls
gives sorted output, so changing these to 'find ... | sort' was
unnecessary. I'll send a version that removes that noise.

Thanks,
Taylor
