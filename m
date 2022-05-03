Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37D77C433F5
	for <git@archiver.kernel.org>; Tue,  3 May 2022 23:16:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244180AbiECXTm (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 May 2022 19:19:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244162AbiECXTf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 May 2022 19:19:35 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C2A44163C
        for <git@vger.kernel.org>; Tue,  3 May 2022 16:16:02 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 9-20020a250909000000b006484b89c979so16648371ybj.21
        for <git@vger.kernel.org>; Tue, 03 May 2022 16:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=BYOpGImO4YyLKWdada0z/XlNJAdosKaI1xmqs09SRmc=;
        b=W+OTdcUHDBvfehUNsdcO8CckEnckJt9KO30PlU2UiFxLUlYO3jW3ZM/EX/Pig2XMxt
         BvpkKkeo4K4toDuoD7TF41r6r8e+Fvvq6wFrAFIKOZucjfHv5aHOCVAF8UBznkgad3SO
         bVj/KCh4mF/5SIj6WZktNFJWIavYOTLKyif9u7lCmhKTr9sEdbDrwJuhEy/GN2zLrrJ8
         3FBoRRW2mhlO0vqV4IapAkK/Wyc0BPHC+AmqFUoJ3R7UpvtTVfRrTAz63ygpWtYE++pl
         tNMiT7UFNTQwMOq/Bt8vkc0GCHs9cERgqgOq+i0yBtYlPxk9xfwhaQC7vdkKDBT2U6Tt
         IJBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version:subject
         :from:to:cc:content-transfer-encoding;
        bh=BYOpGImO4YyLKWdada0z/XlNJAdosKaI1xmqs09SRmc=;
        b=jT9udPCtqjirXsOA+AtZoxWY0mQ776nlSES/91fxmaNdueuN10V63vF8lDwWJP2+10
         JvA9wXDLYhROooUh0WvrSseJYesGnxHncXmaCv/cplkmj00E5tPVvMLYeLMl9LMW4A2X
         GKky5aYD+Ui6W/XxjsXgjDlVRpD78pJcXG7avWZaUGOILSa1MPjXnqozMDfgiBvJNPbw
         8pRsa0wSYE6p63VvlzKD89wf8ADfBSrAQKsMO4DXOEpNX87DW61INebhHpLQmlObW3pK
         tDaOpWUkjVsnVnXaDDP8d6nvuQeuBjXXkV83RdDN8+ewm/wViFASl0+WLtg01Gpw54vf
         gdvg==
X-Gm-Message-State: AOAM533QlHaeSX73vQl3DGjOEykUDNUCSoB/g9eZm9B8UTIWEx2Kxc4f
        AUuzw/AQxpbUqJ/JO9levf0dizRJz+yeyxULt7Jh
X-Google-Smtp-Source: ABdhPJzCPDly8vd/YbfkOYLAAs37lBuspW2pLVtvE1P7uRos/Gthd2I5cBwnyLa9KkXE1CqNTtehmU7wxMWb9u1auruZ
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a05:6902:310:b0:641:79a:c5f with
 SMTP id b16-20020a056902031000b00641079a0c5fmr15388250ybs.95.1651619761415;
 Tue, 03 May 2022 16:16:01 -0700 (PDT)
Date:   Tue,  3 May 2022 16:15:58 -0700
In-Reply-To: <20220502170904.2770649-6-calvinwan@google.com>
Message-Id: <20220503231558.4172288-1-jonathantanmy@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.36.0.464.gb9c8b46e94-goog
Subject: Re: [PATCH v4 5/8] transport: add client side capability to request object-info
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Calvin Wan <calvinwan@google.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        gitster@pobox.com, philipoakley@iee.email, johncai86@gmail.com,
        me@ttaylorr.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Calvin Wan <calvinwan@google.com> writes:
> Sometimes it is useful to get information about an object without having
> to download it completely. The server logic has already been implemented
> as =E2=80=9Ca2ba162cda (object-info: support for retrieving object info,
> 2021-04-20)=E2=80=9D. This patch implements the client option for it. Cur=
rently,
> only 'size' is supported and the server must be v2, however future
> patches can implement additional options.
>=20
> The question of version mismatch often comes up with client/server
> relationships. There are two cases to consider here (assuming either
> client or server functionality for object-info changes between the
> different versions):
>=20
>  1. client version > server version
>  	- client can request additional attributes from server
>  2. server version > client version
>  	- server can return additional info to the client
>=20
> The second case is a non-issue since the client would never be able to
> request additional info from the server.  In order to solve the first
> case, recall an earlier patch where the server sends back the attributes
> even if no object ids are sent by the client. This allows the client to
> first check whether the server can accept the requested attributes
> before sending the entire request.

From this description, it seems like the intention is to send an
object-info request, and then if the server responds in a certain way
(here, sending back the attributes - presumably without sending any
actual information), then we know that the server doesn't support our
request and we need to fall back. As Junio says [1], this requires one
RTT more than necessary. We could just determine if the server supports
the attributes we want by using capabilities (without needing to send
the request to check).

[1] https://lore.kernel.org/git/xmqqilqnsaep.fsf@gitster.g/
