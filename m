Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D89ECC433EF
	for <git@archiver.kernel.org>; Fri, 17 Sep 2021 03:38:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B7C5A61077
	for <git@archiver.kernel.org>; Fri, 17 Sep 2021 03:38:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244040AbhIQDjg (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Sep 2021 23:39:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242037AbhIQDjf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Sep 2021 23:39:35 -0400
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com [IPv6:2607:f8b0:4864:20::e33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41073C061574
        for <git@vger.kernel.org>; Thu, 16 Sep 2021 20:38:14 -0700 (PDT)
Received: by mail-vs1-xe33.google.com with SMTP id o124so8163244vsc.6
        for <git@vger.kernel.org>; Thu, 16 Sep 2021 20:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=dWIba+EchIb94aK7ZknzurztB0TAeLWWNuIAALRCBIY=;
        b=AOkRlIVXHMh0Oi/Ty5Z7qS7BKlaLjJytlZzjx8l3oEI9ipRW++29zEKruWzanXEjoM
         MB+duVgeHTGvZ40lpH2wEF20/af2FmbPFi8hQIj1NQB5ZtckBRKPUYvZQ+reVDO998pl
         l2o9a0tYOPqQrCxSrqURt9I+QHXH1vbiRCdWlyF2hHyd/fqJ4NVhj7Xxfk17LAYQf8P+
         egI9h9O4y0pyHJ2HY7CfWe8gApStJ3jP2mGekJo0XEv9869sWQoYVSoFov2mgV38pdol
         TkLXmdqArduiUyXUSmI7538kD92csfYf23kz7E3NMg2sFw0cCRHEqfFkxHwcH8+TlgJ+
         JgGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=dWIba+EchIb94aK7ZknzurztB0TAeLWWNuIAALRCBIY=;
        b=VKWFL000CVeStMSbLlV0VCmsDfE17KyOmqUycNPbEeBOavbxlKydJVxed+ipxshsuA
         Jl2ENn0O98hZsTXFEQ4C/7Hh6TcVGPEyZoZfBa/PtJhsxWsFsaJP/UHAj7ReO5TcMkpa
         GXixF5TCqFdOcA5Iza8iBfy4r6Sa2WEhciozCdS5AiV8L7Q9kzWXK3SqU98OyiRay0Gc
         +3kux3PB7t2EttBwottvlmcA2hfpUZH6vpB922FQfkZhnt4YgGxLmkUuvAEGLZwaKTiB
         oEtXszNUzUlREeOP+ClkoWsIdWsgo1g+uBgsgfr7FRO/lH8LbjIwTR3QO1EzeEm7WFg8
         a5og==
X-Gm-Message-State: AOAM532r2o5K3bOOfZYLOXQN0I5zySDRXFhBVpQLBxS8DXTV+YRvn4cp
        f7Jz8yGdau+lzOC6sy/rdtCNXju1qhVFtiVcVtmgQ44BtylvRA==
X-Google-Smtp-Source: ABdhPJyVEZpJ66/TsmpHQ5sMzIig6FyZZo8HaiAA97T9InZSZoIOJB0lVLc8xC4kG1O48nprlIEBV+qk1JkWkH5eG1M=
X-Received: by 2002:a67:f949:: with SMTP id u9mr6782661vsq.45.1631849893226;
 Thu, 16 Sep 2021 20:38:13 -0700 (PDT)
MIME-Version: 1.0
From:   Kurt von Laven <kurt.von.laven@gmail.com>
Date:   Thu, 16 Sep 2021 20:37:37 -0700
Message-ID: <CAO-Ogzs7vCtfgjZqp+cg1ERiu3bSwZM47arHJyyTrEqAQ=ZLcw@mail.gmail.com>
Subject: Don't Call commit-msg Hooks With Empty Commit Messages
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

The most common reason commit messages are left empty is to abort
them. commit-msg hooks that replace empty commit messages with
non-empty ones (i) make it impossible to abort commits, (ii) are
startling to developers joining a project configured in this manner,
and (iii) can offer no value that wouldn't be equally or better
offered another way. For instance, a default commit message would be
better implemented as a commit message template or prepare-commit-msg
hook. I propose that Git eventually cease calling commit-msg hooks
when the commit-message is empty, but I would understand if backwards
compatibility were the overriding concern. On the other hand, the
empty commit message case is easy to overlook when crafting a
commit-msg hook. One consequence of this behavior is that running the
popular pre-commit tool (https://pre-commit.com/) tends to lead to a
spew of false positives to the console on an aborted commit when
configured with commit-msg hooks.

Be well,
Kurt von Laven
