Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 011CBC77B7C
	for <git@archiver.kernel.org>; Fri,  5 May 2023 17:30:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232030AbjEERau (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 May 2023 13:30:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231920AbjEERas (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 May 2023 13:30:48 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F05417FDE
        for <git@vger.kernel.org>; Fri,  5 May 2023 10:30:47 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-559debdedb5so29893957b3.0
        for <git@vger.kernel.org>; Fri, 05 May 2023 10:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1683307846; x=1685899846;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=t+Yw5la5ejo328QUX9CIvOA3RWMEEeC4azcN66khL60=;
        b=AiC4sPL+wdD5l7evHr4TUuUOvNgK3OaJNbkl+5JChGQf3rFxFBkleWPn98ydajh+Yf
         g9OhkezbfgVBwxsF61zNYAt6e0thmQ6FTr21sot/eeiX+kM7nnVAwDmAOxC2dEveGaTG
         Zlfbgz08B+S7FEoXIqkN/DRSvNNRDSDBkG8SWK8d/UC7GokmkO977LfZKH8PXCxSLbte
         j+zpBCQ02Y3cWvHM9HZVdlIEVaAHjnxfiI20SJvQSyVQtHpkzYmUr8l2iWGBk/OhJ6NN
         GfAChxQdEpfaoQsBkTYP3BFZmhllwTdRltLZSBOqAV6U5GmcKdWse+XgPzieYE4fpeUR
         L88w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683307846; x=1685899846;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t+Yw5la5ejo328QUX9CIvOA3RWMEEeC4azcN66khL60=;
        b=k/jJLFccXmaRUYYWlYRfIog2/0w9vpGy0xWnfxxqVQdmCWRpvjyrQkT+0xkUWRAd6t
         +odKQFG4FZWvia0a6CgiGGdjiy7bFVIDLqOuQRHMCzVcJ1Cxw3Jq1nuXdsMWuVU9oqks
         +WBTCJq2WqnLWTuDmIljgl8j+Sp6a2h6a1s0Ub0J2/e8Z5L/wWlnoJXxwM6Xr2/9yv5H
         lzfQPsHFD6TyqNcirlg2MVKHQ06CUkp0Z/AxEgc7WHaqYHKtyWc3uVioT9+IyIg2YtEk
         kdyMpZLFvI6FA/JVXv/1+2ag22Cx9O6x4RXAccVLZOHU8Zgxbi/fg3bBaINrtySRgp0O
         s6pA==
X-Gm-Message-State: AC+VfDzDsACeSV6iTbKL9ltbzqIZZGAo1PthYEuIjIRYJfypoF3JZ5Oo
        /wMCEfvoRI4P20eSog6L6/w8/Q==
X-Google-Smtp-Source: ACHHUZ6DIE2Pp3tR1SMzrMdvTOVJBncTwdBDREy2UiE03fb59WalEQsEBLctG643PuLvnUMBvMAbbQ==
X-Received: by 2002:a0d:cdc6:0:b0:544:9180:3104 with SMTP id p189-20020a0dcdc6000000b0054491803104mr2359107ywd.34.1683307846193;
        Fri, 05 May 2023 10:30:46 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id l127-20020a0dfb85000000b0054c082bad36sm586665ywf.120.2023.05.05.10.30.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 May 2023 10:30:45 -0700 (PDT)
Date:   Fri, 5 May 2023 13:30:45 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] revision: support tracking uninteresting commits
Message-ID: <ZFU9Ra4br6NTi4Cg@nand.local>
References: <cover.1682380788.git.me@ttaylorr.com>
 <a643678c0ff7d1a910b1d6c33a839166e2a6a7b2.1682380788.git.me@ttaylorr.com>
 <0b8884ea-f37b-b7d4-6edb-825ca935a893@github.com>
 <ZFLbXTKOK6KTEy7q@nand.local>
 <7a0ea3d7-f67b-8f9d-f9ea-550fcc05108d@github.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7a0ea3d7-f67b-8f9d-f9ea-550fcc05108d@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 04, 2023 at 09:59:32AM -0400, Derrick Stolee wrote:
> It's interesting that it walked more commits than you wanted. I
> suppose it's somehow related to the boundary condition you're
> implying by enabling the construction of this list.
>
> Could you describe the situation where more commits are walked
> than you want? I imagine we can't actually stop at the boundary
> because we need to know that certain commits are actually reachable
> from those boundary commits.

I honestly cannot remember, and was unable to reproduce it when I
reworked the substantive portion of this series last night.

For posterity, Stolee and I had an off-list discussion yesterday where
he walked me through his suggestion to implement the boundary search via
a straightforward revision walk, instead of grafting onto cherry-picked
components of the revision internals.

It works great, and I have been unable to trick it into "walking too
much".

Thanks,
Taylor
