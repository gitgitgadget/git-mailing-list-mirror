Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD392C77B7C
	for <git@archiver.kernel.org>; Mon,  1 May 2023 22:11:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232494AbjEAWLo (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 May 2023 18:11:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbjEAWLm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 May 2023 18:11:42 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07E991FEB
        for <git@vger.kernel.org>; Mon,  1 May 2023 15:11:42 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-5144043d9d1so2058363a12.3
        for <git@vger.kernel.org>; Mon, 01 May 2023 15:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682979101; x=1685571101;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4Wp/gnkeSs46sks5vc6WL+aaXkgIeaxwdmzd89Nj1f4=;
        b=d1HzSs8qclSWasQ7/zn4Oy+AJ/cdfaVW/DVjqj1JNu0P1BnRbX5WEJGDmJwmF4UM5x
         QG0ZCyRcFBOE8r3l39S2TImxdVFcPLnX1D1qTY9K3EBxF9mMvfARl3HFozrq/oHttRHi
         KC9N2AN23ig2G4JYATNlUPmQjqk8bVBOTAbVtq5c5xKkf8+DWgP9UtRdNve8gmHuqqh9
         bFNe/KfhUrIJvlcWOfsw2eDa1nCQpScX1HqgLZowC6UTiAh6wmksAx9jhgwdPOg26H7M
         fztJ01ky2ngpjEdy/sZ5EnPlfZugjfYrLug0KISwjTcROP0ZVUGKwzgmgHjtV//gvY8P
         p8Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682979101; x=1685571101;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4Wp/gnkeSs46sks5vc6WL+aaXkgIeaxwdmzd89Nj1f4=;
        b=W63hqmzqDE8/iz2qm+U7aXjzOOyV09vKdstAlJ0yzK/BqAHZLg2FUf+mLRZrb+Cxg0
         we16ef107vYzvUJsg3h3wtYK2ltWm8rGcF7P97M49s4H437Snh1RMzvfRL/awLV85tih
         BQ+H6WPrtZHNalI4R1jVXR22hLJwg9LE34/ZQlYEK5T+ngy7nqE/ih7gFoq/xaLtNVCN
         rLDgkeu2GxCj+th5QhJ7dY+zVZYB7sItnkM6OkAKLLB6GhzB4wvHBCybuU8Ch5IRK4d5
         Bpl1cYgMFtNaUtvynkmnTBMQNH5YVxGFOLura4mASuqShfLBYkzNpPx3NUSS7ELehLeI
         7PkQ==
X-Gm-Message-State: AC+VfDxYrreU+s0mVWXQ/eSZhTeRMZY1g7McqZm3smPWrZsVHwClJvvC
        Ovg9hqk9iRDDAzDBuedeE8Y=
X-Google-Smtp-Source: ACHHUZ7DKGMaUoYO5D8n0bKd4jHSONVzvxl5Pyh8a7AKay7BphSpW38h69j0n6jCGefb1TfKDUzQug==
X-Received: by 2002:a17:903:228c:b0:1aa:d292:3814 with SMTP id b12-20020a170903228c00b001aad2923814mr9800636plh.67.1682979101320;
        Mon, 01 May 2023 15:11:41 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id p1-20020a170902a40100b001a95c7742bbsm15325333plq.9.2023.05.01.15.11.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 May 2023 15:11:40 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Han Xin <hanxin.hx@bytedance.com>
Cc:     git@vger.kernel.org, xingxin.xx@bytedance.com,
        jonathantanmy@google.com, derrickstolee@github.com
Subject: Re: [PATCH v2 0/2] negotiator/default: avoid stack overflow
References: <cover.1682473718.git.hanxin.hx@bytedance.com>
        <cover.1682513384.git.hanxin.hx@bytedance.com>
Date:   Mon, 01 May 2023 15:11:40 -0700
In-Reply-To: <cover.1682513384.git.hanxin.hx@bytedance.com> (Han Xin's message
        of "Wed, 26 Apr 2023 21:15:02 +0800")
Message-ID: <xmqqildb3dnn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Han Xin <hanxin.hx@bytedance.com> writes:

> This series avoid stack overflow in negotiator/default.c and memory leak
> in negotiator/skipping.c.
>
> Changes since v2:
> * Rewrite the commit link in the typical format.
> * Fix the incorrect check for the COMMON bit introduced in v2.

I see Derrick pointed out a logic error during the review of v2 and
this round corrects it.  Is everybody happy with this iteration and
considers it safe to merge it to 'next'?

Thanks.

