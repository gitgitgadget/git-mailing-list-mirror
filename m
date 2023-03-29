Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81B53C6FD18
	for <git@archiver.kernel.org>; Wed, 29 Mar 2023 18:45:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbjC2SpT (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Mar 2023 14:45:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjC2SpS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Mar 2023 14:45:18 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04FC74498
        for <git@vger.kernel.org>; Wed, 29 Mar 2023 11:45:17 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id u10so15817434plz.7
        for <git@vger.kernel.org>; Wed, 29 Mar 2023 11:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680115516;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WMMX1zTsJUy0M2PWwlCXaZlyIWmnnivfbv1+0r3QrxE=;
        b=JU8GQ+zuab6ReZgDhyji8DpRlHI3ZraCC/qzasNGe2Gdnuz4mCgeCUhvowWKbn2zBF
         DYHquEOXvW/mk9+mUXtwru8MQl3C2e6AjhCbpbQOtdQe9/zWgw4sYUphlt0gNnASu34S
         zPYgelIsy3ewH4lXMx3B7KizMvsJut3V2XYu3HaxwxHzbjct9incFB3uNAXr2Lq0lvwJ
         7Runwc9yzlB6HcnAieqsQ2yffbQAnlPV5rk9bWKNk1Ij6lDwkoL5fuRbgWE7m7uHOGni
         MGs7XByY0n+paHuao/+aFdn4WL3DnZ/J8enoTIrm/uLol6v51TTQV2s3jR+cxNIjFP9Z
         2lWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680115516;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WMMX1zTsJUy0M2PWwlCXaZlyIWmnnivfbv1+0r3QrxE=;
        b=SArhZb5zAvkeKhtqRP0HmlX2aQ2MEsEjSYuCV+1FrPrLPirOHDothO2pl0lCFuYBNn
         +j3snF57bSxCbLS/wnsNEOFI8g461xpbEDciztyiu0sRjm3nV3o202vvZB/DvMYug/eL
         BMOAMDwNtZIB8bvuPZbs+a8xkb7zn0CD3h/MNRRPWwXB5n2QKiGl/tcADHknVpCgMgym
         vYHwgUHscB1ITqKfYZZCdhqRfRQ0wWJJ07yOp9/momiMRKJ35raYR1xufJZ54QwcHOKa
         M7nJRBknSEFCm467lyJXe7KsN1C5X3pJ6E+ivqj9OwT1rwMCZ5VR86Ei1gJ0XumpQR9L
         Lwlw==
X-Gm-Message-State: AAQBX9cUBTkrd9qrQ9AcVwOSN59i3QoiEAbLYmOMdDbiqLrGCXxEy6dr
        dqlfq/eq1JPA2jSOQBdg1Mk=
X-Google-Smtp-Source: AKy350aRlPT5s5qHoZqofIBfWVSXaHsM6I2amRWCvNO4OpsavDd4mx6TWcixDOus2Z1mfG/q+MF1dQ==
X-Received: by 2002:a17:902:d482:b0:19f:27fe:95c3 with SMTP id c2-20020a170902d48200b0019f27fe95c3mr22791438plg.41.1680115516303;
        Wed, 29 Mar 2023 11:45:16 -0700 (PDT)
Received: from localhost (83.92.168.34.bc.googleusercontent.com. [34.168.92.83])
        by smtp.gmail.com with ESMTPSA id m10-20020a1709026bca00b001a24e2eec75sm5892731plt.193.2023.03.29.11.45.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 11:45:15 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Subject: Re: [PATCH v2 6/6] fetch: centralize printing of reference updates
References: <20230320225702.1471172-1-jonathantanmy@google.com>
Date:   Wed, 29 Mar 2023 11:45:15 -0700
In-Reply-To: <20230320225702.1471172-1-jonathantanmy@google.com> (Jonathan
        Tan's message of "Mon, 20 Mar 2023 15:57:02 -0700")
Message-ID: <xmqqlejf9z2c.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> Thanks. Patches 1-5 look good to me. As for this patch, I'm still not
> convinced (I thought that the new mode would still print to stderr), but
> if other reviewers are OK with it then that's fine. Alternatively, patch
> 6 could go with the next set of patches that implement the new mode of
> printing ref updates.

When further changes to the display_ref_update() starts doing
something iffy, we may still want to block them at that time, but
unless I am grossly misreading this patch, I do not think this one
changes the behaviour to start showing the ref update notification
to anywhere other than the standard error stream at this stage, and
the changes in this step can be evaluated for its "clean-up" value
alone.  

So I am inclined to say that we should take it as-is.

Thanks.

