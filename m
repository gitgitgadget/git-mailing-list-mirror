Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 895B8C433F5
	for <git@archiver.kernel.org>; Thu, 27 Jan 2022 17:15:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238757AbiA0RPO (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Jan 2022 12:15:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbiA0RPN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jan 2022 12:15:13 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57B62C061714
        for <git@vger.kernel.org>; Thu, 27 Jan 2022 09:15:13 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id t69-20020a627848000000b004cb24c27d5aso1870331pfc.21
        for <git@vger.kernel.org>; Thu, 27 Jan 2022 09:15:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=0gn4yr4N9sZB/xiYwUukocAFfHDk0wFBTKzGqme9pX8=;
        b=ERdLAUmsayQz5o7rgqLXRNqYkz/pJ5mpksbAIjKJReY1DfwmymOWWfJLTfomH0LxlL
         aJ2PLWvRPAodjfey3d8mKIcjP2NhopQhlnSeBtwvZlJJNcPRLF+DgcUqB9tuPoGO223T
         B10vzdGNHgHUBfL48xRoFMs+VQVI9sUvewuQBl3hw7+7lHG8HV7LNIobBHNtilipeHkR
         MHANTN5PQD2g1maFyS75BC2p1FtGhToU5hXnfYmcc9zIP0GGMqBnMzD8uvl7x86HQvds
         Lh0KmacaDALm2UU2LX7G7uW5Ak+eSAtWjVWZTfCpGcv/HyF8j6HniePfK8S/D0T7Kll7
         xFdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=0gn4yr4N9sZB/xiYwUukocAFfHDk0wFBTKzGqme9pX8=;
        b=G1pkAhoAInlA6CKqCp/666uOxnPYCH/o5W3ZbeuizdC9LIVom0BEwK1wswcJ8HupxB
         xwFXVN056/jlK2gDn5qu6bj2TwPOZIavx7OjmuH9jn6BE1dv2wNTPoT3E3iG64RtT0ZX
         thui4H3xC0/n7GACuy/UK1+s8ENjPFFzZGi7AVKFR6O40GGv3vYOPVOzcxMkQ7j6t30q
         mXpoRG/bcIcl4j9Rs8YDnpMKTLxMbw8ByNeuDhesLnjOsUaQ+aFsDdx9xsdPwfmRN2Yh
         AvxfXA+GmvBXNk+UWmB22NvoEYWtl6tR1Tq1irpb48AJdgwyF5rywtre7wRu9cOffR1p
         dNFA==
X-Gm-Message-State: AOAM532Ww02FCg2nZYfMWVrEwlLS51D7+oK20JeXHwbUE3uTIbSM/HgY
        9u8ABt8bot4XFQ6tOQkGhcWAPGB+5jCr9NIu4bfC
X-Google-Smtp-Source: ABdhPJw6S0yxXSlYa8I9n/0wLX0ds8onsroPLVNFYuNHNQv1HzocL6XqS8X2oAff7M2RY+UReHzFcx1q6s50wl1DGVIK
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:902:6b83:: with SMTP id
 p3mr4091892plk.55.1643303712792; Thu, 27 Jan 2022 09:15:12 -0800 (PST)
Date:   Thu, 27 Jan 2022 09:15:09 -0800
In-Reply-To: <YfGuC0wowQnYi/Eq@nand.local>
Message-Id: <20220127171509.3073226-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <YfGuC0wowQnYi/Eq@nand.local>
X-Mailer: git-send-email 2.35.0.rc0.227.g00780c9af4-goog
Subject: Re: [PATCH v4 0/9] midx: prevent bitmap corruption when permuting
 pack order
From:   Jonathan Tan <jonathantanmy@google.com>
To:     me@ttaylorr.com
Cc:     avarab@gmail.com, git@vger.kernel.org, gitster@pobox.com,
        jonathantanmy@google.com, stolee@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:
> Could I get an ACK from either Stolee or Jonathan Tan that this version
> looks OK?

I think Stolee has already given his ACK [1]. Here's my ACK:

Reviewed-by: Jonathan Tan <jonathantanmy@google.com>

[1] https://lore.kernel.org/git/8842fdd9-438d-43dc-b7b5-0d6bb456e313@gmail.com/
