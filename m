Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58A4DC77B61
	for <git@archiver.kernel.org>; Thu, 27 Apr 2023 21:10:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344017AbjD0VKo (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Apr 2023 17:10:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbjD0VKm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Apr 2023 17:10:42 -0400
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5E06524F
        for <git@vger.kernel.org>; Thu, 27 Apr 2023 14:10:15 -0700 (PDT)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-187b07ad783so7292112fac.0
        for <git@vger.kernel.org>; Thu, 27 Apr 2023 14:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682629815; x=1685221815;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DkTdPkIKfK/17vwp+3Gfle2gFE9jLljrEu2Fom8lF74=;
        b=j1HQCY6QqJoqHp123lpoReBUe+rvGoPR9Im5GWfX3KL3l5sPTfRMsRhaOKO8OfUeiU
         U0G+SWlZLdmGm2DjypPFWP9fq6ILwYvhNqoU2RjXa3E+APu2O4PFBYnM4zwpKsbna5M2
         S62sPaHK/hJfzJ2lI5LBzMGokMO61GYd9MOF6Cu5K3iyyxp9lNGDqNRi0gGiI+UCiFe1
         THEIU1G4p8X/m5/iTuAcnpmOHKRPKAqeAR+3DXsoYU/TLj0ZbcpLZSa30ohbN4VDWeBZ
         /qF6nv3LvT/uGASRS7cLofLrYDv9y/a/RTlJr7d9y13WqRttXH/XbWa5M3ZW8PqVpSAD
         H9qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682629815; x=1685221815;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DkTdPkIKfK/17vwp+3Gfle2gFE9jLljrEu2Fom8lF74=;
        b=b6+3Ineox23kXSNNw8cF6tIx8+Xiwo7mx+6jwXMLemEqkvXCg8fj1WyXTpTSRCVx/D
         Q8eMk1SYMU2YfG0YUvIiuLTeeZZu+dDW3UhZEGZXsoBR3kTR1wZ/ehKJpDJgFhN+nQVm
         LOs3fYhEinbj1LTT1Jzh9MsI6naUXF/c+mAUBgXsiyQ6t37Xh0LEHi9En/YBnR58xMwq
         c+N/mx+e3D+Mj03oHMCy7LhFUG+BNWZA5GIQONNcqFDLXoUA2CuoGT/VkkzPnm1NSjy+
         XQ/hx7oNZl1xA8/ZALZn0XiSJ9RFxg7hTyx5K5CR/usRB+UckZ9W/aj/P1q69cSXam30
         wj8w==
X-Gm-Message-State: AC+VfDyyPwBFcjbNCAZ0gvH/T6va6V1oH/F2wivwvHS9qSFo/YbYGoyn
        I0V3ZAMlzZi+KSKoMSZ+Uy5oMYhpzIk=
X-Google-Smtp-Source: ACHHUZ4DstuyWDt53uLjTT9GjqVig7BfKmcDOtP4h/52bqlSyRXFCgSf/ct1iWPrYULOK6B/UzWFjQ==
X-Received: by 2002:a05:6870:5305:b0:17a:d73c:e983 with SMTP id j5-20020a056870530500b0017ad73ce983mr1440886oan.18.1682629814801;
        Thu, 27 Apr 2023 14:10:14 -0700 (PDT)
Received: from localhost ([2806:230:6026:c32c:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id z6-20020a056870e14600b0018b182ce317sm8078858oaa.55.2023.04.27.14.10.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Apr 2023 14:10:14 -0700 (PDT)
Date:   Thu, 27 Apr 2023 15:10:13 -0600
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     i o <lvsil4@outlook.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Message-ID: <644ae4b537ec2_7f4f2949@chronos.notmuch>
In-Reply-To: <DB9PR09MB6506FD114211F3806C48954AB0649@DB9PR09MB6506.eurprd09.prod.outlook.com>
References: <PA4PR09MB65161C38AEFBC07B3D7A1C62B0679@PA4PR09MB6516.eurprd09.prod.outlook.com>
 <6446f5824dd5d_cd6129459@chronos.notmuch>
 <DB9PR09MB6506FD114211F3806C48954AB0649@DB9PR09MB6506.eurprd09.prod.outlook.com>
Subject: Re: Proposal: adding --soft and --mixed options to git checkout
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

i o wrote:
> Felipe Contreras wrote:
> > In my opinion it's pretty clear `--soft` and `--mixed` were terrible names and
> > I suggested in the past to rename them to `--no-stage` and `--stage` [1]. We
> > should not repeat those mistakes with `git checkout`.
> 
> No problem with renaming, but this might also be an oppurtunity to reconsider
> the meaning of the two options to incorporate `--keep-index`. Maybe
> `--no-stage` should mean 'switch HEAD and the working tree but leave the
> staging area' (i.e. the equivalent of `--keep-index`), and `--no-work` should
> mean 'switch HEAD and the staging area but leave the working tree' (i.e. the
> equivalent of `--mixed`). `--soft` could then be achieved by combining these
> options: `--no-stage --no-work`, but it could be a worthwhile convenience to
> add a separate option for that (just moving the HEAD), so maybe `--head` or
> something like that.

Of course, many options could be considered, but unfortunately the outcome will
be the same regardless of the consensus: no change will happen. As you can see
that's what happened in that previous thread, regardless of the overwhelming
consensus.
 
> > In my mind the whole point of `git checkout` is to update the work-tree, if the
> > command is not going to do that, then I don't think it should be `git
> > checkout`.
> 
> I suppose something similar could also be said about `git reset` though?

I don't know. To me `git reset` is too vague. Resetting what? The "HEAD"? That
to me has no meaning whatsoever, as "HEAD" is git-only semantic invention that
roughly translates to "the current branch" (but not quite).

So with `git reset` we are "resetting the current branch"? That doesn't tell me
much.

> Maybe this would support the general move away from those legacy commands
> towards the new set of commands, so putting these new options in `git switch`
> instead seems reasonable.

I would rather change the semantics of `git checkout` and `git reset` but that
seems rather impossible.

So yeah, I would focus on what has a remote chance of actually get done.

Cheers.

-- 
Felipe Contreras
