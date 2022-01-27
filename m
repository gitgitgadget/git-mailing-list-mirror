Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CBE7C433EF
	for <git@archiver.kernel.org>; Thu, 27 Jan 2022 03:21:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233507AbiA0DVi (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Jan 2022 22:21:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233233AbiA0DVi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jan 2022 22:21:38 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FF8EC06161C
        for <git@vger.kernel.org>; Wed, 26 Jan 2022 19:21:37 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id x23so2805444lfc.0
        for <git@vger.kernel.org>; Wed, 26 Jan 2022 19:21:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5+7ws4gM8UFc3yTdq26Zf0FviwoLLrytQItUk7lKa8k=;
        b=YiaKodUjtM0gxfqtIU/Rqom3Pt3tgBUPO31nkzI41QlweVnfqU6iNBQyjiYMteA1jX
         2/7cb5YxUaR7Z2a6fNgjIq7X1eBOuSXByjbCnsiH1d8/RMcoLkm+cVUb8u39VCRlBPqQ
         eiGeRzbHPuhcRD1j6r9KTO4ywpk7jOWDefuf+ClRlbOskvWNHY0ETHjsiwPbadpVz0JG
         5v8t5Zi/EEVGRI47bfkmDOQfuKkJSowMfezkoD6N6IIwZFNnEIekI6UHJac6nSaqXbAA
         Ubp9AGMAJPxbjuudlgTz7OiGMDIc8SmfC+Hp//VVo9AD9B+c2q9z3VSoLd+nG2RTd1P6
         WmnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5+7ws4gM8UFc3yTdq26Zf0FviwoLLrytQItUk7lKa8k=;
        b=uZroiL4/Lq+o2ejwLToL3t756czuaAmOwRSDykPRHTuNH6HLhdOYDmRPMXpz7fkIUU
         n/mc7/EfNlzjR0afbohU0x9MK1skPbSDDTPEd1jR85nYcGeB9if4L8xQc0yljF9AosBi
         copaFuHOV0e+4U4g+qrwQXFTVL79bI4WxtceP5OF7gMLWs4HH2KZrm/yTY83hlmkeels
         gusY6iHgVCeqX6OZ8TojvPQ+w85f80fQjAYgejfSfDgRC5whg0ra6fA7pO2hMnP4l7Q8
         9lkVaIShRKn/f0ZG8epjzNwFAjf2CY3DNiGs6ZJ3HWBZea7Mn1BCBVIKcf/B6Sg96iee
         1uQQ==
X-Gm-Message-State: AOAM5317a0VYaptb9W9Hj5Z7MGf5WyouNkyayRF+CSOobXf+bR5k5prZ
        w1GF4oI3NiZcSO4CSPeyHsqWacQGRputqVAdHkI=
X-Google-Smtp-Source: ABdhPJwORFptBj7idM2nEancihLJAc2GbjpJVo6AmDFgRbL/S1KduSlQpHS2262JSL3un5dB1lB8ZBolEr2Acd7RhbM=
X-Received: by 2002:a05:6512:3faa:: with SMTP id x42mr1639875lfa.664.1643253695660;
 Wed, 26 Jan 2022 19:21:35 -0800 (PST)
MIME-Version: 1.0
References: <20220125095445.1796938-1-robin.jarry@6wind.com> <20220126214438.3066132-1-robin.jarry@6wind.com>
In-Reply-To: <20220126214438.3066132-1-robin.jarry@6wind.com>
From:   Jiang Xin <worldhello.net@gmail.com>
Date:   Thu, 27 Jan 2022 11:21:23 +0800
Message-ID: <CANYiYbGME-=w4raiwW3w1_gHzVpsvdStz7xVpKqAwx2r_Vezzw@mail.gmail.com>
Subject: Re: [PATCH v2] receive-pack: add option to interrupt pre-receive when
 client exits
To:     Robin Jarry <robin.jarry@6wind.com>
Cc:     Git List <git@vger.kernel.org>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>,
        Patryk Obara <patryk.obara@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 27, 2022 at 10:03 AM Robin Jarry <robin.jarry@6wind.com> wrote:
> @@ -800,6 +806,19 @@ static void prepare_push_cert_sha1(struct child_process *proc)
>         }
>  }
>
> +static volatile pid_t hook_pid;

Can we use a flag instead of hook_pid to distinguish the source of the
SIGPIPE signal?
1. "pre-receive" hook exits early without consuming stdin.
2. "pre-receive" hook hangs after receiving commands from stdin, until
client quits by receiving a "ctrl-c".

> +static void kill_hook(int signum)
> +{
> +       if (hook_pid != 0) {
> +               kill(hook_pid, signum);
> +               waitpid(hook_pid, NULL, 0);
> +               hook_pid = 0;

Can we let the signal handler in "pre-receive" to do it job? And we
can show some user friendly error message here. E.g.:

    die("broken pipe: seems like the pre-receive hook exits early
without consuming its stdin");

--
Jiang Xin
