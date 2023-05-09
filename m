Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2C9FC77B75
	for <git@archiver.kernel.org>; Tue,  9 May 2023 01:23:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233643AbjEIBXA (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 May 2023 21:23:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232571AbjEIBW5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 May 2023 21:22:57 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB53483EE
        for <git@vger.kernel.org>; Mon,  8 May 2023 18:22:54 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-6439df6c268so2937247b3a.0
        for <git@vger.kernel.org>; Mon, 08 May 2023 18:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683595374; x=1686187374;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z5pdowwoZcn6PuaoqYZDCmMrCBOSYYds9SF6FNRRS4A=;
        b=n6m7NljLTiqy1JnSJ4pJlX7pZ24NVm69+Tw0K+eTaIXDwtnsqq0JvfX7izaJwL/5xf
         sY2dI1YR2yMUHp3IiHltDdYEGx4JQbK+AIEUuPeqCavmoI8o3c26Rx3bW5NgdvswXJaI
         CvKVqRCB6KZ/ULTc2iq1caU03XQ8pVRgH82jsicskemadEqE5mV9MmYDSPiik/BMrFif
         TfXZEO5bAhyvT3r2dycgpIoNHdluVRhI41rIeieNUFbAlm9c1jNQbp0psSGZBa0EILhg
         UctO8gzmgffKb5oH2fctgaB2NdoBjbiKEEcMljB1sDzGCBA2dlUP3iRgReHMUt1/91MT
         9o/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683595374; x=1686187374;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Z5pdowwoZcn6PuaoqYZDCmMrCBOSYYds9SF6FNRRS4A=;
        b=RAJ1t5cCcevAcfv92CPM9+to9bXExawL+Gz78imQ5xU7Vpov2Ysg9Z5psd/xvBE2rp
         nERHsyRm1GeYJSbQnIsHCfKlZKGhBDJzWrgzcg1WfbB6aBv2MADr23/YPYyiiAFDaTwR
         HVlleuojJtlHs6KxbrI9aqfdyVsc92wjRE6HGaFTD2nSDaCFSRl1l8XNSzZmw2UTYHxc
         GiIkPc/8IqAY8D4nm/ZXNe9JWQhu7BY+uJD/c50qhMhWTApG2pn8c71RUDAaGVZllfxJ
         d+UlpM24gT0gDFkgYcHKGD3eyQ09sgKU+qgD8x0LFRKD+o/uHWEGBPZbUBvKcHsSXABr
         B+nQ==
X-Gm-Message-State: AC+VfDz8ycTv/edNneZGMRrlThiPDWEr5k1D4sF1vC3GP8gZV6Lxfuda
        fxAgQY8bjj4jGgPgTYq7QdnmQ7MRtkU=
X-Google-Smtp-Source: ACHHUZ7AE9COTZEcddS1ExWTmtzbn+o3wQSL+QWpna5ekM6EyRcRlWYGM5Qxtvw5hlPoyJnQLpgoLQ==
X-Received: by 2002:a05:6a20:8f13:b0:101:3fe5:8776 with SMTP id b19-20020a056a208f1300b001013fe58776mr867570pzk.17.1683595374119;
        Mon, 08 May 2023 18:22:54 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id y9-20020a63de49000000b0051b7bcb6162sm106877pgi.81.2023.05.08.18.22.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 18:22:53 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2] diff: fix interaction between the "-s" option and
 other options
References: <xmqqfs8bith1.fsf_-_@gitster.g>
        <20230505165952.335256-1-gitster@pobox.com>
        <645995f53dd75_7c6829483@chronos.notmuch>
Date:   Mon, 08 May 2023 18:22:53 -0700
In-Reply-To: <645995f53dd75_7c6829483@chronos.notmuch> (Felipe Contreras's
        message of "Mon, 08 May 2023 18:38:13 -0600")
Message-ID: <xmqqsfc62t8y.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Felipe Contreras <felipe.contreras@gmail.com> writes:

>> Let's fix the interactions of these bits to first make "-s" work as
>> intended.
>
> Is it though?

Yes.

If the proposed log message says "as intended", the author thinks it
is.  Throwing a rhetorical question and stopping at that is not
useful; you'd need to explain yourself if you think differently.
Unless the only effect you want is to be argumentative and annoy
others, that is.

I've dug the history and as I explained elsewhere in the earlier
discussion, I know that the "--no-patch" originally was added as a
synonym for "-s" that makes the output from the diff machinery
silent---I have a good reason to believe that it is making "-s" and
"--no-patch" both work as intended.

I would not say that we should *not* move further with a follow up
topic, but I think we should consider doing so only after the dust
settles from this round.

