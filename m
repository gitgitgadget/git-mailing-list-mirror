Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6237C38A02
	for <git@archiver.kernel.org>; Sun, 30 Oct 2022 18:14:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbiJ3SO2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 30 Oct 2022 14:14:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiJ3SO0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 Oct 2022 14:14:26 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A1B1DCB
        for <git@vger.kernel.org>; Sun, 30 Oct 2022 11:14:26 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id q142so2235056iod.5
        for <git@vger.kernel.org>; Sun, 30 Oct 2022 11:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=k1TeHm6AQ1EUnvZGRPhfU4xc5/emo4y6oBCK1ObFNbY=;
        b=LV2b7SOmuroYG6lcIb0Rf/smbXwJIhf1+vEcnBnh2AQixA0zveO/nkFzKgpuh3xsO/
         j4WO85JBzT3RenU6jjH803aNatlZqEpvGHThG+6kwPuCdwyK3rAsxCcNH8IegwC6XNNB
         pT/au6GOVRkV5VzKIOESIoL4gw7y8KtFYq0/0ucu1QEzWM21RmuzUozjHTk057J1WV0y
         Ti52LaFZTuN9zbiBv7rYlioptg9JsiKYzdPy+/GnqepWUT+BzuvtBJL8gIJpWLwmkBO/
         AfMGb2U01ukiNd20DDEWSELRZ0J8ErKTl9/vYyq9ApT5Scw9+51hgWr3l6omk8hR7DWB
         GyFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k1TeHm6AQ1EUnvZGRPhfU4xc5/emo4y6oBCK1ObFNbY=;
        b=xTRUtS/2vg5Q0nzOwR2GHc+Cnc2Z2RTLp6xre6CCAdjZN0kcQPlH3STnv0oYkcY9c7
         yW/Y0dWRb5qypqi3DmkU/q3qGgdyhSWd/Ye2uqdWStIrPe01B67twp45HaPGlD58L6GJ
         2ioDuSnsbFlbMrDzQ/764d0E3aIz1gejGbpYRaEtj6zSfSF99dCCRTMKgHlXM7e0cXW2
         /HLLgjwNYIllLBHwpGtqFMyUjJ/iz6dj5XY1FWk5j5WhVt+t+VBLVhHeE28xaHjb5tK3
         CqvXkrXsrgB/A8Wnh2CEkacuoZfx93o9F2o3LU33hcK3x1dFpwweiGbGXaMiQEwOEDUP
         yOHg==
X-Gm-Message-State: ACrzQf3Kjoo6BKjCZf3wpgUdVXa//A25EXBpk4cs2mfR9ZzfJ82Y96Ze
        TlrrnUitjHZuqUlDZXL0cnEx2w==
X-Google-Smtp-Source: AMsMyM6HI/tGjV45t5plVt3atCCExVJVINaPuhR3IczVpMt22XKMuVqrYnCnvvQyoPlwjsC6204fRw==
X-Received: by 2002:a05:6638:150c:b0:363:a4f4:fdc6 with SMTP id b12-20020a056638150c00b00363a4f4fdc6mr5396842jat.185.1667153665525;
        Sun, 30 Oct 2022 11:14:25 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id o11-20020a056e02068b00b002f9f001de24sm1772109ils.21.2022.10.30.11.14.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Oct 2022 11:14:25 -0700 (PDT)
Date:   Sun, 30 Oct 2022 14:14:24 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Glen Choo <chooglen@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH v3 1/8] clone: teach --detach option
Message-ID: <Y16/AMeVYgERJuj6@nand.local>
References: <pull.1321.v2.git.git.1666297238.gitgitgadget@gmail.com>
 <pull.1321.v3.git.git.1666988096.gitgitgadget@gmail.com>
 <432bc7cb3a42cf39d0033701c2cc677c9109b3dd.1666988096.git.gitgitgadget@gmail.com>
 <xmqqmt9fhbjt.fsf@gitster.g>
 <xmqq7d0jhaw6.fsf@gitster.g>
 <kl6lbkpvd0de.fsf@chooglen-macbookpro.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <kl6lbkpvd0de.fsf@chooglen-macbookpro.roam.corp.google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 28, 2022 at 03:55:25PM -0700, Glen Choo wrote:
> So a better way forward is to add the new flag, which I imagine might
> be useful to certain end users.

Disappointing, though I understand why such a new flag was needed. Do we
really care about whether or not the branch exists so long as we are
detached from it, though?

Thanks,
Taylor
