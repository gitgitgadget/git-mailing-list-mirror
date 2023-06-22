Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 477B5EB64D8
	for <git@archiver.kernel.org>; Thu, 22 Jun 2023 12:52:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231315AbjFVMwa (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Jun 2023 08:52:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjFVMw3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jun 2023 08:52:29 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25EAE19AF
        for <git@vger.kernel.org>; Thu, 22 Jun 2023 05:52:28 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-5700e993f37so9033717b3.0
        for <git@vger.kernel.org>; Thu, 22 Jun 2023 05:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1687438347; x=1690030347;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2JKgBj/huFZHoh+KXBGvc1oM0IHyERk8+U5IZT5PzwY=;
        b=I7q7aNx4c6asgHuCXmZNE2rvVIP5MkRVFcsb0iTUZnTkLteQZ4zIlIhaPRHAv3IDkx
         odvMFJNj90szL1THjXU3xN5aVfyWbpajj3sERidmEUfxw53jyoi2qVHth6wldTZFkqq6
         1zJ/dXyknogKzVYl1anw13kQwDV1iDCsOlT5KSOkv8MCEje55gGG3Q/Q7UjI/EJGEVEP
         05XJGvlGWktIm5RT/Imk0C0Wsr6ceYAdRZP0N95a3ckEeyern/OR2u1Ooo/Ho3V7rSlc
         O7KK6/zZ2Zvhh0xD52zBV8HIurwz0vaXubufrdAYnrs00afcSwmMqTj3BiOBpBWFfVDT
         TjiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687438347; x=1690030347;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2JKgBj/huFZHoh+KXBGvc1oM0IHyERk8+U5IZT5PzwY=;
        b=k7sbsEF3S55ybIRkSxaCwXigRWqsbJx7sdgc3VBfGlun9eoXPqpo5mXqMIyOHmSeCv
         UcCnnceSOEGb8QGN9JvZr5AffcCtjcTSyaaxGQs2t8rSa0b2mbNocEuSouDWmS3UIzvw
         2XrxEJK/6+tmqmqa0g0Ds8yluKOqghnnUHgwKMmkQKpFTCDUaYYNM7GAhQKJ4i/Vgkpc
         Y+JWUEDIncbDKqoACsifdZF0GcqJGs7ot5U9m13mt5sf8iKe7gTydSJFSo/PUN2z54E1
         LgOU3VNQQ8zBDSTBAMo1J652Bqm4LNdTuZItz+q9uNlB9vwvAsyaoDxaeP+Xoh2DQXhO
         fxzQ==
X-Gm-Message-State: AC+VfDwZedzZX7bJNQ/MPoTR+PtfAPntJ5qv11YroNL+vDZ6muiUDboW
        ocOoL/cd4iieP/QzqpJHILmpcg==
X-Google-Smtp-Source: ACHHUZ4r3fIx9mazUXEBWfMRn+JbzgUbz1c6YFUNTQOefSINoE+Ay9OViHFMFjlwUGTxNuKbfWMkBw==
X-Received: by 2002:a81:4813:0:b0:56d:460:6a0e with SMTP id v19-20020a814813000000b0056d04606a0emr28905682ywa.21.1687438346835;
        Thu, 22 Jun 2023 05:52:26 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id z7-20020a818907000000b0056d304e224dsm1798169ywf.90.2023.06.22.05.52.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 05:52:26 -0700 (PDT)
Date:   Thu, 22 Jun 2023 08:52:23 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     John Cai via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, John Cai <johncai86@gmail.com>
Subject: Re: [PATCH 0/3] revision: refactor ref_excludes to ref_visibility
Message-ID: <ZJREB4p4RA0T5cO2@nand.local>
References: <pull.1515.git.git.1687376112.gitgitgadget@gmail.com>
 <xmqqy1kcfsb6.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqy1kcfsb6.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 21, 2023 at 01:56:13PM -0700, Junio C Hamano wrote:
> "John Cai via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > The ref_excludes API is used to tell which refs should be excluded. However,
> > there are times when we would want to add refs to explicitly include as
> > well. 4fe42f326e (pack-refs: teach pack-refs --include option, 2023-05-12)
> > taught pack-refs how to include certain refs, but did it in a more manual
> > way by keeping the ref patterns in a separate string list. Instead, we can
> > easily extend the ref_excludes API to include refs as well, since this use
> > case fits into the API nicely.
>
> Hmph, how would this interact with the other topic in flight that
> touch the ref exclusion logic tb/refs-exclusion-and-packed-refs?

Good question. Besides trivial conflicts from John's patches to rename
this API, I think the sensible thing to do with my
tb/refs-exclusion-and-packed-refs topic would be to also refuse to use
the jump list if there are any non-trivial exclusion *or* inclusion
entries.

But I have some more general concerns about the approach taken by this
topic, namely that I do not understand a reference "foo" cannot be
included by adding a "!foo" entry to the excluded list.

Thanks,
Taylor
