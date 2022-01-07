Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36F8BC433EF
	for <git@archiver.kernel.org>; Fri,  7 Jan 2022 19:33:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232622AbiAGTdu (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Jan 2022 14:33:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232391AbiAGTdt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Jan 2022 14:33:49 -0500
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BC50C061574
        for <git@vger.kernel.org>; Fri,  7 Jan 2022 11:33:49 -0800 (PST)
Received: by mail-qt1-x833.google.com with SMTP id l17so6517156qtk.7
        for <git@vger.kernel.org>; Fri, 07 Jan 2022 11:33:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=y7WHMcPctVqjIjw3/Dd/KUc/DUNgvSq04r4ZjbD3WzU=;
        b=W9VOabz/qjfQrbtP2Qpt0H0c6HS9ExaPIjdCj8NjgqWz83PxlFvWRfnqDIgOdnGo/0
         6o9FyRymCWSdXmCerunT8JFXQzx5GNivFhJqJBOs7aAWTesy6hSFjc0AA9SCdx7wmmxu
         PPc1EfBKS+hrjBZd2oTaeqYtDAwKHjOMsuuK3iIqeZmYquPyFAOuxkPmPlDwQgB9mXf1
         UjSdMqx7HXV6NnvEaJunGt/TxCG/5ZQQEWoD0W5CFMghex4Nj+55msd2cwI0uDmgVuSy
         ixMoH4oOQa7X0r4AO7v8VWK+s/QS2qdgoZC3qpL19PAmrA6Yr5pyCYVc5NbY3r74IknF
         RnTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=y7WHMcPctVqjIjw3/Dd/KUc/DUNgvSq04r4ZjbD3WzU=;
        b=zB5UU07lGPESPY4vSoGW3/dfsQ0Iq6r9dMH/OzLIFjj0TLPf1oe2RtJSHygJFC1z5W
         RKgtcvTzXb1P16XRzIOo7+1RUdcrsnFN/6ETWMW/d1VlavsNNRIkXADgErHY7AqrpQ40
         uOK3f9O8nzzwZojJ0liDKaeLYMJiNAiIpb1Q7yZQX4XyhsjSuz3ZaJug+QCVcccTDFu5
         We88XFYRjYp5Ig3MebzOqGrQv2y6rLPWLvVFA0mByblf21vjd1bTljevFLZgEeKBvw52
         OYRharDns0THYcDQRL1ONkRBrHHs3b1Dltwq6uLXWy3ajaqEw9Uoj6DfC6UjCmZT/R/w
         TSuA==
X-Gm-Message-State: AOAM532pV9DjI8PokO8Ufg3vm5frI7juLyR+b5kjxhDHuWLQG8uOuXcc
        wCeecwIbiYDiG9voJCyc5uJwHKLDMBswNQ==
X-Google-Smtp-Source: ABdhPJxJk19vxAthjZENqezZNlVIMJOBds8TZo5fhLTTBWJOVvVyFPdEgCnvMGegWtEqN/8RiFZBqQ==
X-Received: by 2002:a05:622a:134e:: with SMTP id w14mr3186997qtk.394.1641584028310;
        Fri, 07 Jan 2022 11:33:48 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id l15sm4390566qtx.77.2022.01.07.11.33.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jan 2022 11:33:48 -0800 (PST)
Date:   Fri, 7 Jan 2022 14:33:46 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        gitster@pobox.com
Subject: Re: [PATCH 0/2] grep: introduce and use grep_and_expr()
Message-ID: <YdiVmgJYPzVrIYE1@nand.local>
References: <ea01f9b6-2ce3-57e8-533f-4cc29937f700@web.de>
 <cover.1641498525.git.me@ttaylorr.com>
 <c573cc00-d5b3-9af1-a627-6c2462cae3be@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c573cc00-d5b3-9af1-a627-6c2462cae3be@web.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 07, 2022 at 01:57:17PM +0100, René Scharfe wrote:
> Am 06.01.22 um 20:50 schrieb Taylor Blau:
> > René,
> >
> > Here are a couple of extra patches on top of your series which introduce
> > and use a new grep_and_expr() function.
> >
> > Like the final patch says, this isn't about reducing code duplication,
> > but rather about adding visual consistency with the other
> > `compile_pattern_xyz()` functions.
> >
> > Taylor Blau (2):
> >   grep: extract grep_binexp() from grep_or_expr()
>
> I considered extracting such a function as well.  I'd have called it
> grep_binary_expr(), though, to match the existing names.
>
> I decided against it because it can be misused by passing a non-binary
> kind to it.  (That's a weak objection, but the benefit of such a
> function was low already in my mind because it doesn't do much.)  You
> solve this by keeping grep_or_expr() and adding grep_and_expr(), which
> cannot be misused in this way -- OK.

That makes sense. If it's keeping you up at night, we could easily add a
check to ensure that `kind` is one of GREP_NODE_OR or GREP_NODE_AND. But
I think that any new code that looks like:

    grep_binexp(GREP_NODE_NOT, xyz, NULL);

would probably stick out like a sore thumb. So I doubt that such a check
would buy us much practically speaking.

But I agree that this whole thing probably isn't worth the minimal
effort required, since the couple of patches I posted on top are purely
about cosmetics.

All of that is to say that I'd be happy to see these patches picked up,
and I would also not be sad at all to see them left on the floor.

Thanks,
Taylor
