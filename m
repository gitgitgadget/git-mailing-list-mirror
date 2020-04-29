Return-Path: <SRS0=05is=6N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 283D0C83004
	for <git@archiver.kernel.org>; Wed, 29 Apr 2020 13:37:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 06F28206D6
	for <git@archiver.kernel.org>; Wed, 29 Apr 2020 13:37:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Myo1eTpz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727866AbgD2Nhf (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Apr 2020 09:37:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727865AbgD2Nhc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Apr 2020 09:37:32 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BC91C03C1AD
        for <git@vger.kernel.org>; Wed, 29 Apr 2020 06:37:32 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id j3so2618987ljg.8
        for <git@vger.kernel.org>; Wed, 29 Apr 2020 06:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=3KVsaHw+mfayuAnyncThUjThA1MopmzV10gkCsGUeCI=;
        b=Myo1eTpz3sG7GU0ti4WWKwNONCe1YDQeUgxEKiVcptp6qDO4qmHYDVj5O+e5KX1JBG
         Ljwa43g+ft8wRVwtaJu4mrNwg2ngEKdCRP8NdPM2ZuRl4rGm1UNqUYKr7r1hjWGkXhxd
         BR4Bg5B/ZQnaDeEzuAPhFj7VZQNCnkRFk6nJ/mSagDPVx+3GHNrqSvXKOyzic8YrwzfA
         EPXEA/OCXbncnjH5CCucjlN44uquY9vbfyDwxv0yCwaWQbu/kPJFizO7Z+z383NpUyG3
         nDQ1atyeHVVpEdqSy6antPlrfNN9hdQIFS8mzufCuU69oc6iY9MV0qFAlw0PHbs8SYBE
         9Skg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=3KVsaHw+mfayuAnyncThUjThA1MopmzV10gkCsGUeCI=;
        b=kkm1EYPoljesFlI+tBBLO6+SInzRoLHjP5mxSM+63vjrefDmEA4sgE2ODDJh574NDm
         FmxH67wQzzqglGC9kYmyQaebreAWnakFW7gLBrYodaLuj4ohqk4+R1THwlUAV3NA7qTm
         9Kz9OQiYbosdfNYpX1D2zavpoGe19kJsXEA+i3eulyxIDWAs3FtWukUG/CAKTYkZnFHT
         B4Tta+I34JGad0YEJj85kMbvI4E05fRAGOEpmDmgmZXV0F8ng8pezO0EKlBF/7PsUsOR
         6CQ2TUQb7T/V7/rbOGDBhybipB4RI+wFgwQrojIQ9jKqoqVvjM4rGyNsHhIWE6gerYHO
         M2fA==
X-Gm-Message-State: AGi0PuZvdKZzTyLscnIs86tdKGpsiay4JuJMt+soxcw7n7FIou238WUg
        IBHm3LtCb5EyULXp8iYi6h8=
X-Google-Smtp-Source: APiQypKxxibrOdlVOtUU/180NSCKPDmtGWE7jhSaVLMWuRj/QPCCxKYdjlXEkP2W2CTxj4iG/5fz2g==
X-Received: by 2002:a2e:9712:: with SMTP id r18mr21061084lji.225.1588167450642;
        Wed, 29 Apr 2020 06:37:30 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id u3sm2831192lff.26.2020.04.29.06.37.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2020 06:37:28 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Ivan Tham <pickfire@riseup.net>
Cc:     git@vger.kernel.org,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH] branch: add '-' to delete previous branch
References: <20200429130133.520981-1-pickfire@riseup.net>
Date:   Wed, 29 Apr 2020 16:37:27 +0300
In-Reply-To: <20200429130133.520981-1-pickfire@riseup.net> (Ivan Tham's
        message of "Wed, 29 Apr 2020 21:01:33 +0800")
Message-ID: <877dxyo1k8.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ivan Tham <pickfire@riseup.net> writes:

> Add support to delete previous branch from git checkout/switch to have
> feature parity with git switch -.

Maybe I'm late on this, but to me, who leaves in the Linux world,
"a_command -" strongly suggests a_command will read further input
from stdin.

[...]

> +To delete the previous branch::
> ++
> +------------
> +$ git branch -D -

... so this suggests that the command, when used like this:

$ echo "branch_name" | git branch -D -

will delete "branch_name" rather than some "previous" branch, whatever
that means.

Is this short-cut /that/ important to create yet another confusion?

-- Sergey
