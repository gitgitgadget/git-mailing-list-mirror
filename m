Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBBF7C433E0
	for <git@archiver.kernel.org>; Thu, 21 Jan 2021 15:11:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D353239D4
	for <git@archiver.kernel.org>; Thu, 21 Jan 2021 15:11:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732577AbhAUPKl (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Jan 2021 10:10:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732578AbhAUPKd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jan 2021 10:10:33 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC09CC06174A
        for <git@vger.kernel.org>; Thu, 21 Jan 2021 07:09:52 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id b2so2895508edm.3
        for <git@vger.kernel.org>; Thu, 21 Jan 2021 07:09:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=references:user-agent:from:to:cc:subject:in-reply-to:message-id
         :date:mime-version;
        bh=hm1yCj02fxHzQhfbzoKjdCjbL46aG6qevAse+LgWePw=;
        b=jSrbXqmAUnB0G/A6gZz1k57rZBWGmqFEn5j3JP9IvH32+HAha8SImWtO3diXIYvS7N
         BtapL3lVlK/zs0tP18a18OgGU8BZh+98sB3I5l/wB1sydXhksBo8hSjBWm0gjKuzDjzC
         cdYPKRSNiIi+08VmMElGgPIN7NO/vm5ofmJqH327MsjJptmqQNCOSuxVwC+mer98UdNg
         MGujD3B16QEtVjBwGVNFcubx+Z9vavhxed805ZOxOeI0XAPGXY9EwnUidWAAbFIdYL0o
         k62UT59SLBrZ5yFKWfXhNcmtH5jO10Qjuje8Q93M4xe8i5yG1LzINMAdSSaHog73CRIe
         LAPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:message-id:date:mime-version;
        bh=hm1yCj02fxHzQhfbzoKjdCjbL46aG6qevAse+LgWePw=;
        b=FUZqDehgdi6PSLQ1Q6Ub6WBO6t0SeDDJPWHoDl3wxo+OeT4GV7TJZ+mrVXeGKKyvbS
         1Y8mbh2kUrmL9pV/H0ZpWPeslKESgKXvNGuQi6Zv/isQ81PcmuaaDJfG5v8RS7uPAweG
         tfGjmVOjLcfMcx7ByarpY9tNOsrnMQFdK5Vkw8s27lz+9Ndk1oaHuCH8ZkGxYYe4Ck7q
         tVBzL79872z2kytNaDVfTM41VMLOK+Wmy8oenAgOb/SAe8I9OdAYVAZuqxenrPzry5ds
         1//x5jO2mgfqDlksW7lfTG55hN0AZK/0j7RMFbAxLzzdl5MTS/IsLHEiCrzrrFIo9gHq
         dclA==
X-Gm-Message-State: AOAM533D38XZUXSUAGA8DIv0LjiAMUntkARqsd495e+E/RwUj+ssoWAl
        6rtybh3ItLB5w5aisQFEz2Y=
X-Google-Smtp-Source: ABdhPJxwkeohnIM9+o5OCY6ZTcluuUIxeGgQAggO25csY6ijH/PLP0LleACrx+bLGcVlXQlkpFEjPg==
X-Received: by 2002:a50:cc06:: with SMTP id m6mr11454745edi.14.1611241791523;
        Thu, 21 Jan 2021 07:09:51 -0800 (PST)
Received: from cpm12071.local ([79.140.115.135])
        by smtp.gmail.com with ESMTPSA id j3sm2320181eja.2.2021.01.21.07.09.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jan 2021 07:09:50 -0800 (PST)
References: <20210117234244.95106-1-rafaeloliveira.cs@gmail.com>
 <20210119212739.77882-1-rafaeloliveira.cs@gmail.com>
 <20210119212739.77882-7-rafaeloliveira.cs@gmail.com>
 <xmqqo8hjc6jx.fsf@gitster.c.googlers.com>
User-agent: mu4e 1.4.13; emacs 27.1
From:   Rafael Silva <rafaeloliveira.cs@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        "Phillip Wood" <phillip.wood123@gmail.com>
Subject: Re: [PATCH v3 6/7] worktree: teach `list` to annotate prunable
 worktree
In-reply-to: <xmqqo8hjc6jx.fsf@gitster.c.googlers.com>
Message-ID: <gohp6kr1me1g3r.fsf@gmail.com>
Date:   Thu, 21 Jan 2021 16:09:49 +0100
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Junio C Hamano writes:

> Rafael Silva <rafaeloliveira.cs@gmail.com> writes:
>
>>  Documentation/git-worktree.txt | 26 ++++++++++++++++++++++++--
>>  builtin/worktree.c             | 10 ++++++++++
>>  builtin/worktree.cc            |  0
>>  t/t2402-worktree-list.sh       | 32 ++++++++++++++++++++++++++++++++
>>  4 files changed, 66 insertions(+), 2 deletions(-)
>>  create mode 100644 builtin/worktree.cc
>
> What's the h*ck is that .cc file doing ;-)

Oops. I accidentally created and committed this file.

Re-rolling ...

Side note (joke): I wasn't trying to add C++ into Git codebase :)

-- 
Thanks
Rafael
