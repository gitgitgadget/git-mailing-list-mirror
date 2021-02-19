Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE1CAC433DB
	for <git@archiver.kernel.org>; Fri, 19 Feb 2021 00:47:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B00AF64EC4
	for <git@archiver.kernel.org>; Fri, 19 Feb 2021 00:47:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbhBSAq7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Feb 2021 19:46:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbhBSAq5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Feb 2021 19:46:57 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E0A3C061756
        for <git@vger.kernel.org>; Thu, 18 Feb 2021 16:46:17 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id f3so2306192plg.21
        for <git@vger.kernel.org>; Thu, 18 Feb 2021 16:46:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc:content-transfer-encoding;
        bh=ZdRY2PyNxQlwV15uDEs9ZVCGAbW7qLUD82+Wx+TLqqY=;
        b=h7b1WG7DX3WXg0cs0MJ7NqaBa0ElIUJ/KN1/vBtq64gZM8eywULZLkSVfdfSfUgSO+
         ROl3AXOww0FhZLtJl39LJ168k+eOTWqJqGbNRdRl39407cmOZhWWzQmuBv1HTGw5NLx/
         i2NR+Lu/LpgEshwQTDdpLSi1uG8TZn3KXDbVYMK3/cW94Yo++gnK1+eVwsLicXNcTujN
         QCCCCS2oM91I495AIApPm6MprArnMF+OUrvw3m+UMB5dMgikeSLkO3PJ3cAH7ORJ0kV8
         1P2h0r6+ac5oCSUXvI4pcmdqqVZNfWLuYf6zk/0FVbWEtsTEE1KnMESnC8Gw1+59+aMR
         5G2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=ZdRY2PyNxQlwV15uDEs9ZVCGAbW7qLUD82+Wx+TLqqY=;
        b=AJ6LEN6B/eQFcCafoOw7QSf/ofVfC1R2XUbI8ZKi/4ekRdOeia22++uXmv5pi8Riup
         vHtWmfae9Ofo0+qnu/gtEQrfk9DdQJivZYymq6wK5HwcR2wfJmgNbh4OutzZjMcGMnsv
         6vfx60JmqsPKcfVMfRx0CMtPqZzCHzs13VpZ5K/p3ox+RCGX417fG9ezKtl6aiIqgBe1
         3w16//34UNGUiEKYrZ61RKA7t0gg5FaaacD+Pw4ic7eiMHerGbMh982RSko72mD3sNCN
         tvP7h7B/v5e3fTFWVDzdqt1gBjOkh4fvwzRLU32pnT6E42J8X5ukt/BtfX6QD3aS2Fm0
         7TsQ==
X-Gm-Message-State: AOAM531KZeBWQHXeiHOg6d/B8o6d9Bjc4VAWzs/dxpLIbDULq6N8x0WZ
        NIAGQ6HkM6n4o19uoPh3+U0XLBK5BTKM/DYpZDkx
X-Google-Smtp-Source: ABdhPJy2+YDG+JwBx7HFlCy0DUGiRZwyPJif5SsxcQq2Qr/A8eENYUVJuEqiG/jiLBWF2UqLC6ZD7QgL9yWqgmYmP/2d
Sender: "jonathantanmy via sendgmr" <jonathantanmy@twelve4.c.googlers.com>
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:902:c40d:b029:e2:c0c3:75c9 with
 SMTP id k13-20020a170902c40db02900e2c0c375c9mr6284680plk.46.1613695574610;
 Thu, 18 Feb 2021 16:46:14 -0800 (PST)
Date:   Thu, 18 Feb 2021 16:46:12 -0800
In-Reply-To: <xmqqzh01ar2s.fsf@gitster.g>
Message-Id: <20210219004612.1181920-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <xmqqzh01ar2s.fsf@gitster.g>
X-Mailer: git-send-email 2.30.0.617.g56c4b15f3c-goog
Subject: Re: [PATCH 0/4] Check .gitmodules when using packfile URIs
From:   Jonathan Tan <jonathantanmy@google.com>
To:     gitster@pobox.com
Cc:     jonathantanmy@google.com, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> This seems to have been stalled but I think it would be a better
> approach to use a custom callback for error reporting, suggested by
> =C3=86var, which would be where his fsck API clean-up topic would lead
> to.
>=20
> If it is not ultra-urgent, perhaps you can retract the ones that are
> queued right now, work with =C3=86var to finish the error-callback work
> and rebuild this topic on top of it?  Thanks.

OK - that works. My original idea was to rewrite it using an
error-callback but using starts_with() instead of the ID that =C3=86var's
work will provide, but seeing that at least one other contributor (Peff)
seems OK with the patches, rebasing mine on top of his works too. I'll
also take a look at his patches.
