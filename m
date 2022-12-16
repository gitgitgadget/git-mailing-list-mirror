Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 476E6C4332F
	for <git@archiver.kernel.org>; Fri, 16 Dec 2022 23:26:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229905AbiLPX0c (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Dec 2022 18:26:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiLPX0b (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Dec 2022 18:26:31 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07C8E1EC4F
        for <git@vger.kernel.org>; Fri, 16 Dec 2022 15:26:30 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id f9so2769575pgf.7
        for <git@vger.kernel.org>; Fri, 16 Dec 2022 15:26:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4NW01+sL5/T7GvHwZUiVLDHAZfSBvOFSB6leUn4Pg5I=;
        b=lHySd6f30YbF/OykokJnxNtVAjNMWoBE7O2vpD9yG34oxfNTGxXR0j7xRmsjrIOu4k
         q8d049ZSi2LBaYOXFv1OH9U8TXCCwBNYoHwuDtfAhNIMb2QXVrJYDVHbn4iWDfuV9xWt
         L663KCpnG+Ed7NBRTBI5aNFIUT6bqK7uRWMErDwzqfWk49ieDsC4RA+CSwjQ45d1htVC
         KTTJYBjglSHJTaJVwbRTQ4sODsbq/XCL6Qh2XMg7Ean2MV8uDNE7lcnNv6EWbB4y/o1I
         jGtimBMkODJIC+2n5Qhy3L9JUatEOJWD6UN7uqkdDU6g7BL28ceSXmHnErjYneaaWf6C
         RCCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4NW01+sL5/T7GvHwZUiVLDHAZfSBvOFSB6leUn4Pg5I=;
        b=KiitVGxIfOMDGCuQylA013RVdatIsS2aZpCHOQpQXsLiGTYB+uNq58/JcQGO7MtgNv
         5pG1UON2BQA+UvVVpOBofansQGdGJsSD1ELCfvvUzkzMkZFnCTHIYaEl4ITJLDHJ0q5W
         adJ0ux2NYNTQHuOEVx7Mv161IqDO5G4yLpoq6AiiE9iuE2QggPGP38a6+xCw1dY/kdTW
         mDf6vOhL6H7PgBGC2Px4M096fA9WjumOT34H9yn7PYy6+Ybg3KMRQqfAGBUsmJk/K6XY
         0PK6CkpolGVdPlKv6HZbXXsbMrN7D0urN1LJy6Y+YH5VxaMdmnjn6JHiWXGRnYWTuX82
         kCSA==
X-Gm-Message-State: AFqh2kqNx/1z2nJ/jI6XWGc/VpvN/kB9OnUC1nMDopPT8hR/TgkvmYf8
        pLHg3qTdoNVqFm9NV8BsSkE=
X-Google-Smtp-Source: AMrXdXs1VsCD3Do400hMXT96Hk475g+Vf+lvOh8VGMIyrUsnk5eTVT75dni0FDO/BvAabJ+jeraNFA==
X-Received: by 2002:aa7:9e02:0:b0:57f:7d69:8d94 with SMTP id y2-20020aa79e02000000b0057f7d698d94mr1720104pfq.22.1671233189431;
        Fri, 16 Dec 2022 15:26:29 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id e2-20020a056a0000c200b005774f19b41csm1996154pfj.88.2022.12.16.15.26.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Dec 2022 15:26:28 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Karthik Nayak <karthik.188@gmail.com>
Cc:     git@vger.kernel.org, toon@iotcl.com
Subject: Re: [PATCH v3 0/2] check-attr: add support to work with revisions
References: <20221216093552.3171319-1-karthik.188@gmail.com>
Date:   Sat, 17 Dec 2022 08:26:28 +0900
In-Reply-To: <20221216093552.3171319-1-karthik.188@gmail.com> (Karthik Nayak's
        message of "Fri, 16 Dec 2022 10:35:50 +0100")
Message-ID: <xmqq8rj7kk0r.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Karthik Nayak <karthik.188@gmail.com> writes:

> Changes since version 2:
> - Changes to the commit message [1/2] to use more specific terms and to
>   be more descriptive.
> - Moved the flag's position in the documentation to be before the unbound
>   list of non-options.
>
> Range-diff against v2:
>
> 1:  2e71cbbddd < -:  ---------- Git 2.39-rc2
> -:  ---------- > 1:  57e2c6ebbe Start the 2.40 cycle

Does this new iteration use something that was added between these
two bases?  Asking because the choice of new base is questionable.
I would understand it if the rebase were on top of v2.39.0 tag,
though.

 * If the updated series depends on new APIs and features added
   since the old base, do rebase on the new one to take advantage of
   them.

 * A bugfix patch series may want to avoid using the newest and
   greatest if it allows the series to be applied to the older
   maintenance track, and keeping the older base may make more
   sense.

 * If a series based on an older base no longer merges cleanly to
   'master' and/or 'next', but rebasing on a newer base makes it
   merge cleanly, do rebase.

 * Otherwise, keeping the same base is preferred.

When rebasing is appropriate, choosing a well-known base (e.g. a
tagged release) helps others.
