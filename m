Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B76BFEB64D7
	for <git@archiver.kernel.org>; Fri, 23 Jun 2023 21:45:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232182AbjFWVpo (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Jun 2023 17:45:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231828AbjFWVpn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Jun 2023 17:45:43 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A6EB135
        for <git@vger.kernel.org>; Fri, 23 Jun 2023 14:45:42 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id 41be03b00d2f7-517bad1b8c5so863323a12.0
        for <git@vger.kernel.org>; Fri, 23 Jun 2023 14:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687556742; x=1690148742;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=whmkXk3K4ZyPnZXQHlCS3TjA6OPNIXGWdya06/sScHA=;
        b=GoT79ahmCOvrR6zWVBqTbk29EO2/NmXcGIm/zvKvtnOz5FcNKcGOSXzzlbr3Yfhk76
         FYTAYRdeQNhKtkHR0lMRaz3rqDeY+/GLOvsnNvxEXIhfMxWM4ZI8gJlHCb+HbU1kjQwX
         AEQ9q64W3WkQrQqlX6gO755hG5Q7MoQ/eTHSETHJDFWDVEb8+58IM0Kul50qQXOi7wgR
         2F/yMnQjYqrcWTSd+4bI80FZRtcqhKoZJdgsKmo7shXSneyq6YKO6MxJxYDNeQA6EqkK
         jRZce7i7b2cyq4rdgFosQp6YzzKefumcbLFyrTZpw3Qv7Qf1y2LZSfeLH5VdW9bePxO7
         J+5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687556742; x=1690148742;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=whmkXk3K4ZyPnZXQHlCS3TjA6OPNIXGWdya06/sScHA=;
        b=UPHWlf7z8lbEay2T6rcdZ/zqzbulOiwekoWx+JTeywMKQUeTIpSjACi8UDHkRDZhf4
         h61Q7Y9k4yCj7BuLXPiKLIflw4Ukin6G9UWPMo9N8NHCxm+3evRaiwcPziQqUlw77Q/p
         pOhODpJ10fMkSkghDYt2YZQyeiqtk50Cis4rmLPLj7tk5gBbKWeUDxt5vOPVqWTT9gwJ
         G6UP1L0euFUVW+ROthDqKin9o9aOiaAhj9mu/CFfEPNuEEJykRyTmUv1//AHd4U1cmOD
         PoFGzvpnCQP/njFIUjn+fGpE3zSAmMPHN0wyBQk5AnAwlxMBhhtBnfGZ4AjnO+OGXjlR
         hKZQ==
X-Gm-Message-State: AC+VfDwwsXskqvPFe6U9LycbT8hAQZx1JIw86kgNBhZhgKqXIszLfV4T
        XLEvVJZDaocgqpCAsRqDUkWEJRR/Sl4wnA==
X-Google-Smtp-Source: ACHHUZ4xxkUg3LzPmw4Sich5iWA0wFdW25qrUuq7xWdzxRuUZhE/NXmNBURVZLZfUwRMQN/JUv4FP/PLf80rpA==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3a07])
 (user=chooglen job=sendgmr) by 2002:a65:48c3:0:b0:553:3b6c:b3b3 with SMTP id
 o3-20020a6548c3000000b005533b6cb3b3mr2507306pgs.4.1687556741793; Fri, 23 Jun
 2023 14:45:41 -0700 (PDT)
Date:   Fri, 23 Jun 2023 14:45:40 -0700
In-Reply-To: <20230623210217.3259337-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <20230623210217.3259337-1-jonathantanmy@google.com>
Message-ID: <kl6lbkh5svi3.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [PATCH v3 00/12] config: remove global state from config iteration
From:   Glen Choo <chooglen@google.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Glen Choo via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>,
        Emily Shaffer <nasamuffin@google.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

>> Sounds good. I suppose it would also be worthwhile to base it on
>> conflicting topics queued for 'next'.
>
> Glen, if you can, rebase the patches *before* updating them based on my
> comments so that it's easier for reviewers to see if my comments have
> been addressed. (My comments are minor, so they should still be relevant
> even after rebasing.)

Good idea. Fortunately, I already have that prepared, so there's not
much extra work for me.
