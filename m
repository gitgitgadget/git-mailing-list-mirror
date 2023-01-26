Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF9DAC27C76
	for <git@archiver.kernel.org>; Thu, 26 Jan 2023 02:38:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230233AbjAZCim (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Jan 2023 21:38:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjAZCik (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Jan 2023 21:38:40 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66D5C458A4
        for <git@vger.kernel.org>; Wed, 25 Jan 2023 18:38:39 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id br9so1042425lfb.4
        for <git@vger.kernel.org>; Wed, 25 Jan 2023 18:38:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hPq4i+ixfgerCgcgU/vuIoNF0rsDF5lMy/yh8IfM6XE=;
        b=UXqRrs8y7mVtACB726Nk1BwUl/nuDcOpo+AYQFggSkMDJRU0Qhwr0MfoiWH7FQaXkO
         j5QIqMMdxymp5iKFqNlXAtyiq5mQ87gc6IP4bR6ydxCT9mS3liukemVJMbQiBLaFiJ78
         PANHueSdqjRjImIr0RsS6vVZI9QXjPtpr6RTfSpja94fXkZJS48+llGRCPjM3gsn4uFj
         SG9R1ykHbSRkQnizi3Q67GKxcLy6V4GwakbpL4fYYJz0J9/37/iXfZFFXMgueSBteRGI
         5Q8pggfadNp2pgZSUUILE36S4faQQw3YzxLR2bclBIY/hbYVMgxtnOl0x2d9XhWNmf70
         2+/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hPq4i+ixfgerCgcgU/vuIoNF0rsDF5lMy/yh8IfM6XE=;
        b=COaDLIEHd6LGfhrcL2+GKyu/cT0jLmW0QFLt/AjinKsvwBweEFulTkfEly6JVh1FGA
         KQBwir05nKdJxOMNrSeUXecPcCe3kLgcaKz65fFkQIpWAbUB5Ay0FiTJMX/oykAXCv6y
         DPcwVnI5kc0snMZIEZPIZVAP8Z5bo8cfGzvpo5dnfvWLsHi6UMCQKBBDJbew5NIkQzq3
         x+DlDwXQL0OJCYQ100cUvogpdWWPzl4co7HKXL2QIE+xBvpXBlwb2vQTPWb7oKU4PXwv
         BNRcSkWl4+w1mYVTwudnJICkBOWopNN2L+v9K+c1UFeivrpYQ35Pi1ub6zsNWr6LNqW/
         F9rA==
X-Gm-Message-State: AFqh2kqM7PkdnIBMu7PJVDTPnIhqB2edLbpoulMNdlX3CAdxzvfKtt+W
        OfM82yxgQWDPfCD4RDQbV/QQqw3IJXO6uvjyW2Q25S/0
X-Google-Smtp-Source: AMrXdXvBR3SmuuSQ9wypf5Rxw373NvUoj7LCbKk1MwKDriA6tPLR9lFLLdzu9lT9vCU+hBbAuYq8Yhns9R31Gvh3snk=
X-Received: by 2002:a05:6512:2141:b0:4b5:7607:3191 with SMTP id
 s1-20020a056512214100b004b576073191mr1505427lfr.93.1674700717660; Wed, 25 Jan
 2023 18:38:37 -0800 (PST)
MIME-Version: 1.0
References: <cover-v4-00.19-00000000000-20230117T151201Z-avarab@gmail.com>
 <cover-v5-00.19-00000000000-20230118T120334Z-avarab@gmail.com> <patch-v5-18.19-3c3d48df04b-20230118T120334Z-avarab@gmail.com>
In-Reply-To: <patch-v5-18.19-3c3d48df04b-20230118T120334Z-avarab@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 25 Jan 2023 18:37:00 -0800
Message-ID: <CABPp-BFpmEDHXaeXcmXpAuC0xue2b8wrYA560aC7d7tnO25LTw@mail.gmail.com>
Subject: Re: [PATCH v5 18/19] receive-pack: free() the "ref_name" in "struct command"
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org, =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 18, 2023 at 4:54 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
> Fix a memory leak that's been with us since this code was introduced
> in 575f497456e (Add first cut at "git-receive-pack", 2005-06-29), see
> eb1af2df0b1 (git-receive-pack: start parsing ref update commands,
> 2005-06-29) for the later change that refactored the code to add the
> "ref_name" member.

This should be two sentences, not one.  s/), see/). See/ should do it.

> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> ---
>  builtin/receive-pack.c                 | 10 ++++++++++
>  t/t5405-send-pack-rewind.sh            |  1 +
>  t/t5406-remote-rejects.sh              |  1 +
>  t/t5507-remote-environment.sh          |  2 ++
>  t/t5522-pull-symlink.sh                |  1 +
>  t/t5527-fetch-odd-refs.sh              |  1 +
>  t/t5560-http-backend-noserver.sh       |  1 +
>  t/t5561-http-backend.sh                |  1 +
>  t/t5562-http-backend-content-length.sh |  2 ++
>  t/t5705-session-id-in-capabilities.sh  |  1 +
>  10 files changed, 21 insertions(+)
>
[...]

Code changes look good.
