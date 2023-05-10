Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9563BC7EE22
	for <git@archiver.kernel.org>; Wed, 10 May 2023 23:21:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236801AbjEJXVb (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 May 2023 19:21:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236281AbjEJXV3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 May 2023 19:21:29 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 827F95255
        for <git@vger.kernel.org>; Wed, 10 May 2023 16:21:27 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-55a10577911so114602207b3.0
        for <git@vger.kernel.org>; Wed, 10 May 2023 16:21:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1683760886; x=1686352886;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5L8/AYmAH3dACYZtbq78hZlZYw9WlOKPUMkenpfp4ho=;
        b=I9mVeWtpkSJjwX2zcPGGCKMnbl3cHY76Me+a77IMgMaJXDqZIhYJkt69KwxLptnH0s
         rxPUVaFumJ1ooa2XUOAkwL2Dgv8VdOY60yDs5adPdyHmN+T5NTFyrjOtNbx9VBRoHbb5
         EbJvGjxYdI0obrzUC1/RQvxgsEzRSecOStTdfLR0o1RguXSeEf4pFn0LEk9YWm2hiQq0
         4fzJ1ODAW8pc4Uu3WGXFDsi6v2X8AVNxny4UNUcGd9HIuqCFr/5ciKjiCVw8PM4fdKF+
         MINb6KtEKCpr+3BDfge9Y4l7hrJh/WAxWDoH7Pm4Bu8oarqUVrpTC3rs1c8Hg7jM0QgV
         JAcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683760886; x=1686352886;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5L8/AYmAH3dACYZtbq78hZlZYw9WlOKPUMkenpfp4ho=;
        b=NuEVf+1HsmfDAyOMJ6sJ/kDL8xBdWPAzjuMBnTKeqF52/mRVDwcvJkxzcN/rfBgLxJ
         WNeJqbTPuBAaLGkFyyLIgrHLwB6RxLhLd9MnhKeXM4rPLjopJfgK7+fQ8dr16Wwl3w1l
         1S2Ovslxvs4MtZicHLUUALNE4U8Ptd6UOTM3PF3SbXJBun0BXGyE7h6c5DMzynAH7X82
         Lb2lngzohPlpFUqVdpo1wVQCbe+fUzj3bPIraPSReo+F4wSF0EAf2YK6kzLkl6H8hgJA
         uigejdAFUPGjcyUUdDPjkDQg+JYekQuEW5yu5BgQc3of56TwoMFbJnR83qH0mPM9cYNj
         /f5A==
X-Gm-Message-State: AC+VfDxmtjq/QYYDg8QVNT9IB1DEM8/z90YGFA2T9oBm4boPponLqmvZ
        L2i0S8v7l1o8adD7GVyqMy/Xvg==
X-Google-Smtp-Source: ACHHUZ67n4ZoulSixJCOGG1nsMr4Asx3I6D6sBJGfgBhXc4SUDFVEudpk+D65PPbBnp4TEvEhvS1JA==
X-Received: by 2002:a0d:d8d4:0:b0:54f:adeb:9898 with SMTP id a203-20020a0dd8d4000000b0054fadeb9898mr21792544ywe.10.1683760886709;
        Wed, 10 May 2023 16:21:26 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id k189-20020a816fc6000000b0055ac779d894sm4424215ywc.83.2023.05.10.16.21.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 May 2023 16:21:26 -0700 (PDT)
Date:   Wed, 10 May 2023 19:21:25 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, christian.couder@gmail.com,
        Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH] merge-tree: load default git config
Message-ID: <ZFwm9ZZN57opWbra@nand.local>
References: <pull.1530.git.1683745654800.gitgitgadget@gmail.com>
 <xmqqsfc43si0.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqsfc43si0.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 10, 2023 at 12:18:15PM -0700, Junio C Hamano wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> >     This patch was reviewed on the Git security list, but the impact seemed
> >     limited to Git forges using merge-ort to create merge commits. The
> >     forges represented on the list have deployed versions of this patch and
> >     thus are no longer vulnerable.
>
> Let's queue directly on 'next' (unlike 'master', where we want to
> merge only commits that had exposure in 'next' for a week or so,
> there is no formal requirement for topics to enter 'next' before
> spending any time in 'seen') and fast-track to 'master', as I've
> seen it already reviewed adequately over there.

Agreed. I also participated in the earlier rounds of review and the
resulting patch looks obviously correct to me. I would be happy to see
it merged.

I added Elijah to the CC list, since he is likely to be interested in
this topic and may have thoughts to share.

Thanks,
Taylor
