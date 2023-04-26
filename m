Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B6B4C7618E
	for <git@archiver.kernel.org>; Wed, 26 Apr 2023 17:38:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234835AbjDZRia (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Apr 2023 13:38:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233692AbjDZRi2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Apr 2023 13:38:28 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DE68107
        for <git@vger.kernel.org>; Wed, 26 Apr 2023 10:38:28 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id 41be03b00d2f7-518d325b8a2so7338265a12.0
        for <git@vger.kernel.org>; Wed, 26 Apr 2023 10:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682530708; x=1685122708;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ilyibX9B7+xFqpuwj45Vvab96/qvXFiS9NrGwEGuFfk=;
        b=WYjYdgiuWDavrhmyugTN9+tll0coKBjihSCsAGychvHXe9lygHsYxWADvLzrGL4jkb
         lXhkHaFndjMRXEe/wjZnxjU8DArmMmf76fxv4NNnVcdVpJbdo/gzfDbzsZmaN3LJfSmU
         v8YwKu7/EFnlXI6MXtcUAq1Hd2F4MEbnYytLwgC3xbl3/baziIZ1FYkKDUEMta8pfHre
         cBvrxkfndb1Z/cRj9XZjgndI2NNI+JBWmkiz3RdJXIHD3ouWgXg/mEgU6K6y4ZYDt1Pz
         UayOONuWaep0mLDDoPLpHAMsy5LygnDAAlNjRvLyi+tcUiAIn3Ud3HO6oFqYE/fQ2mZN
         TUDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682530708; x=1685122708;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ilyibX9B7+xFqpuwj45Vvab96/qvXFiS9NrGwEGuFfk=;
        b=bsn/fb3xzN4iQUb2kx9p5CjCWP0Fe4ZkS6f39RQ4viPZd5eoh//r4EfCJARWuJExOI
         2d/on/9URdIKKY/f23FkaDtJeYm4tJdGhmkpYP2p2XS8uAD8uME8WuqQJFV0OIgTuhX2
         2Umdf18/zrfAt6wPzqYNXaDs0zYx871XVL4iCtOuJBazQufE43oEjPfJl4CDJtLokzfj
         sSI/ArODAOGCNq5aTLxoGNYPqCYTJjYvrm4U763MXvqY4RJdcB37KBHvck01zgGrpuSp
         65XdI2oOj2II+CBs/kTxSn+zDxRz0iL41xqBagb+MrVbKDA7VsyuGhEo4fUgUX+aH6yg
         uN8A==
X-Gm-Message-State: AAQBX9denw+qgh5e1mDt2Y6Agw7pSAEPnhtlUzPx/elvxGEo9eJhDwz0
        yp9ZMi2klnvl6uJmtN6WbLo=
X-Google-Smtp-Source: AKy350Y730X3xmHeg7GFxI3iav7Oyd0Agq8ebX7LvJn8+moRoxCQQfpNlkx3Xctgjm1afxqSqBpcJA==
X-Received: by 2002:a17:902:c945:b0:1a6:7f14:707e with SMTP id i5-20020a170902c94500b001a67f14707emr25893596pla.9.1682530707577;
        Wed, 26 Apr 2023 10:38:27 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id 5-20020a170902ee4500b001a064282b11sm10253008plo.151.2023.04.26.10.38.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Apr 2023 10:38:27 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Han Xin <hanxin.hx@bytedance.com>, git@vger.kernel.org,
        xingxin.xx@bytedance.com, jonathantanmy@google.com
Subject: Re: [PATCH v3 1/2] negotiator/default: avoid stack overflow
References: <cover.1682473718.git.hanxin.hx@bytedance.com>
        <cover.1682513384.git.hanxin.hx@bytedance.com>
        <0e69d70805e6da684e6e17642a1cf0d59a03dfc0.1682513384.git.hanxin.hx@bytedance.com>
        <xmqqedo6tvkj.fsf@gitster.g>
        <49695ce0-b9f9-0fc7-ed16-093dc7f12b7e@github.com>
Date:   Wed, 26 Apr 2023 10:38:27 -0700
In-Reply-To: <49695ce0-b9f9-0fc7-ed16-093dc7f12b7e@github.com> (Derrick
        Stolee's message of "Wed, 26 Apr 2023 13:30:21 -0400")
Message-ID: <xmqq354mtugc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <derrickstolee@github.com> writes:

> It is unfortunate that the logic for nw->common_revs is duplicated,
> but I think this is a cleaner approach than other considered
> approaches.

It is subjective and as long as the result works correctly, I am
fine with it ;-).

Thanks.
