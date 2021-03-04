Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B75DDC433DB
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 02:35:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7FDB464EF9
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 02:35:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231351AbhCDCfI (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Mar 2021 21:35:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232805AbhCDCDy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Mar 2021 21:03:54 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C239C061574
        for <git@vger.kernel.org>; Wed,  3 Mar 2021 18:03:08 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id u17so29300992ybi.10
        for <git@vger.kernel.org>; Wed, 03 Mar 2021 18:03:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=Fd6Wmyy0G03AErErc0oHY7pAnePqH1CT0Q+koejxkeY=;
        b=bLcNDyjQLGJAQC43RfDbBUaGzcBoqLxyX5LsrDBtx/xvmuyNQXUNRs+92eid/oWPCS
         droAql1fyVT5yAX0vJHVAwCcBZzc/YwvFwaw0BC7VpzezCbT/Kqxt2+6tbyw+vyjzRLt
         21o31ZBFF1BIVfrIU41ajKAVkYJZtHjdCCPeO+Qr29N62BbzkX8I8hREYRXyCoC0lxEG
         dFUfWD4Q2eZQDlo0FPizjfFo2XxYmkPVAMQj7Wu6y9JmyrSJuho2eXuAMCIzv7beUCit
         AfRB2spuKveEnJA0J3loQJrx5WsSBHsbUHRoeRdha0u96/R/URpoLIwo4cFrAUdACwIh
         IE5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Fd6Wmyy0G03AErErc0oHY7pAnePqH1CT0Q+koejxkeY=;
        b=OoMGTakkQ6Xjv+o+/UpGeEKKFjBEwVT+8+/81qG7sSLV3FmU7FpnFUoo4gOeJiTo8y
         6iZ85utvnYwMot2l9RA3mHBhatChRf8Xvxt1xcNH8muKUS//3Sp5fKmd+3PODpqTKTER
         GHmQnczDkIqL2PXeBm+jF6Qy8kf3rCyc8xSeGo3HhW00EhkimmHueBDidmulDQorDDgF
         8sygBzI3QoziizjKW46irI1U5Z80mNnbgXOH/xCBy82Gi647W4NJ5OZyWJJyXui9awYl
         Xn8Sl7jvP/I1k8Y9OOv2OW30tC5zuDsJ8aUtWwNfjLAC0gI1jZ6tGBRJWNDbKAOh14Mo
         nxnQ==
X-Gm-Message-State: AOAM530sLGGFrpPnkjYl1lNXe0UPTHZYL/xMAlRDX9F4xoY4J/6pyllE
        gqwd4PVhjodwKEs/h5WHTES+9f70/kh4F13oMEA3
X-Google-Smtp-Source: ABdhPJzuPlD0kp2x5SAg4j3nTY9RSWkS2JuMFnLxdOB+ygO9EiOEDPucGArUgI01AroYQmtPdaMY3971OHaq0XhcaPmd
Sender: "jonathantanmy via sendgmr" <jonathantanmy@twelve4.c.googlers.com>
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a25:18a:: with SMTP id
 132mr3593667ybb.91.1614823387939; Wed, 03 Mar 2021 18:03:07 -0800 (PST)
Date:   Wed,  3 Mar 2021 18:03:05 -0800
In-Reply-To: <YD6OxwU936MRKa1I@nand.local>
Message-Id: <20210304020305.1802814-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <YD6OxwU936MRKa1I@nand.local>
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
Subject: Re: [PATCH v2 12/15] Documentation/technical: describe multi-pack
 reverse indexes
From:   Jonathan Tan <jonathantanmy@google.com>
To:     me@ttaylorr.com
Cc:     jonathantanmy@google.com, git@vger.kernel.org, peff@peff.net,
        dstolee@microsoft.com, avarab@gmail.com, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> diff --git a/Documentation/technical/pack-format.txt b/Documentation/technical/pack-format.txt
> index 77eb591057..4bbbb188a4 100644
> --- a/Documentation/technical/pack-format.txt
> +++ b/Documentation/technical/pack-format.txt
> @@ -387,12 +387,15 @@ be used to generate a reverse index.
> 
>  Instead of mapping between offset, pack-, and index position, this
>  reverse index maps between an object's position within the MIDX, and
> -that object's position within a pseudo-pack that the MIDX describes.
> +that object's position within a pseudo-pack that the MIDX describes
> +(i.e., the ith entry of the multi-pack reverse index holds the MIDX
> +position of ith object in pseudo-pack order).
> 
> -To clarify these three orderings, consider a multi-pack reachability
> -bitmap (which does not yet exist, but is what we are building towards
> -here). Each bit needs to correspond to an object in the MIDX, and so we
> -need an efficient mapping from bit position to MIDX position.
> +To clarify the difference between these orderings, consider a multi-pack
> +reachability bitmap (which does not yet exist, but is what we are
> +building towards here). Each bit needs to correspond to an object in the
> +MIDX, and so we need an efficient mapping from bit position to MIDX
> +position.
> 
>  One solution is to let bits occupy the same position in the oid-sorted
>  index stored by the MIDX. But because oids are effectively random, there

Thanks - this diff makes sense.
