Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84782ECAAA1
	for <git@archiver.kernel.org>; Thu, 27 Oct 2022 22:48:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235623AbiJ0WsX (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Oct 2022 18:48:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234831AbiJ0WsR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Oct 2022 18:48:17 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F13EB4481
        for <git@vger.kernel.org>; Thu, 27 Oct 2022 15:48:15 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id b12so5363800edd.6
        for <git@vger.kernel.org>; Thu, 27 Oct 2022 15:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=67zFA2ghcGvHeFKDMdZDEazwp0eaI0BNmnDWdTGIqXY=;
        b=gxGMx9wQ0j2l0j2Vw1xe09Bv9eKinLyyXKsVJ8YeBU6sAJfiTp2kNLXQ5BRQCOLdP7
         epTQQ5hj7uBF2XTOUkBj+uc0bKZDW/KDIbzl5V5e/eRP8R+irM3h6AjD52MwmFgr5OJQ
         M1NWJrCfr0Y8EWBKjzsROlJ6sUtUJjFv/zC+D64yPo0EMWFqxF1Qhvt91hlDMAMqiG/G
         mhfffiDWeTmzdceL0H/KC1p/4I9+g9HDyJ7BdjlJaLlVcKhaBn4ZcpiJBzUgHqOStHrA
         QmLkCrcoijbG0R8FeOWywO2ZPRwF9a0Ov33EmZGG1CzRv7wgJv/G72eqopxkIVJRePkY
         yiqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=67zFA2ghcGvHeFKDMdZDEazwp0eaI0BNmnDWdTGIqXY=;
        b=P1mrszngKZ5QKfqL6ZNjWIGV6o21jbK9KyVaXGpVQsFXKSxuGnxMCpmV3vPvQD6XWG
         HaXS+gucfWjp5geEb0rH8Omj6sbOcomCUC08soFK4FC2DoN1amvcHBsey/++1iQIne7X
         +ufs15c0DGtvFdNWQTZlVNBwIjKjd+RzZoGrgCkhoxI+r+k9qEkG26zj8OLYgMPeUz85
         FhT8NVMmw0AUYgbiPXACcp6jgzbjokXv2BymSuUe7CSTeXlsnVQ2kk8FR/raLmC005sv
         2z3QUT3UtclUNFK69RvNP//iwi1+H9sdtr9o9myNrZO88gPM46+FSQGyQhNhJpxZiRZS
         VZnQ==
X-Gm-Message-State: ACrzQf38yX5tE62DaSJ2vRqFrpcTVNSmtCFWXgjHfYz/Nzf9ltLC9n+1
        7gm8eRObkXVlJLU6y0LtZ01C2nn9WukPFA==
X-Google-Smtp-Source: AMsMyM7LX7jrpW2PJMwngeyitZGYcsJV0ZM5kXX+436jsAsXTW4kmTamtLFh1ZHz7D4dYbVupIlNmw==
X-Received: by 2002:aa7:da03:0:b0:461:4fc2:3e0f with SMTP id r3-20020aa7da03000000b004614fc23e0fmr32312220eds.321.1666910894470;
        Thu, 27 Oct 2022 15:48:14 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id r10-20020a170906550a00b007812ba2a360sm1358802ejp.149.2022.10.27.15.48.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Oct 2022 15:48:13 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1ooBfY-009dtx-2s;
        Fri, 28 Oct 2022 00:48:12 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH 7/8] replace and remove run_command_v_opt_cd_env_tr2()
Date:   Fri, 28 Oct 2022 00:46:02 +0200
References: <7407e074-4bd8-b351-7fa4-baf59b41880c@web.de>
 <f26f7974-3e87-2ddf-6eeb-5d97f80a4e0d@web.de>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <f26f7974-3e87-2ddf-6eeb-5d97f80a4e0d@web.de>
Message-ID: <221028.86ilk4ano3.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Oct 27 2022, Ren=C3=A9 Scharfe wrote:

> diff --git a/run-command.h b/run-command.h
> index 482da7f60c..04bd07dc7a 100644
> --- a/run-command.h
> +++ b/run-command.h
> @@ -233,23 +233,15 @@ int run_auto_maintenance(int quiet);
>  #define RUN_CLOSE_OBJECT_STORE		(1<<7)
>
>  /**
> - * Convenience functions that encapsulate a sequence of
> + * Convenience function that encapsulate a sequence of

Maybe we shouldn't bother, because we remove this altogether in 8/8, but
this has a grammar error, should be:

	Convenience function that encapsulates a sequence of

Or:

	A convenience function that encapsulates a sequence of

Not:

	Convenience function that encapsulate a sequence of

If you're re-rolling I think just dropping this hunk is better.

It can just go away entirely in 8/8. The pre-image had bad grammar
anyway, so not worth fixing just to remove it later.
