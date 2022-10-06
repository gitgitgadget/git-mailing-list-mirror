Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BA3FC433FE
	for <git@archiver.kernel.org>; Thu,  6 Oct 2022 16:21:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230141AbiJFQVA (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Oct 2022 12:21:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231345AbiJFQU5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Oct 2022 12:20:57 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB9B0A50D8
        for <git@vger.kernel.org>; Thu,  6 Oct 2022 09:20:53 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id 3so954329pfw.4
        for <git@vger.kernel.org>; Thu, 06 Oct 2022 09:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UiEGbHCb1g/+RU+nfWcBhUdO5ISxYOahqOxk4/FG4m0=;
        b=c1YMjyeFK1/WURjaI7TuMJxnGdYlbvoYAKvLCwU6++7BpoW1mJ4MesVsX7ecE8vGJf
         0XHIqnP40Jl/qklyUrOthMW+NJmSNqpqdfsn0pMcBwAj73EcvSoylYA5Cf6yjhF3O8e9
         rPqA1jYaZJs3wMAh4ELeIYADclYsJCQhmEXtLlQ51MRDaFRV7fICqiuszx7yJYOX6QQf
         V7HZ89YVuPU7CVVrGOlGsWc7u/MuMtJeeSxR7/rWxMXFrWItT0mi1FfpTkIniI+BP/Zm
         AgMf4tW+P4i/ToM6YICI3FJEsnn6Sr13HFr4ywjwcqFI50HZjQjTAbcdmQJiMTLjgOyH
         qj1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UiEGbHCb1g/+RU+nfWcBhUdO5ISxYOahqOxk4/FG4m0=;
        b=14xm2yGDpmrizBIEvRYdaKcdIfRLeKX/hyS+dBu+dz+EVTJUvx51JktX5RWe8MgTHq
         Mz3qZE1HvMrcVeqkUUZMIkOXo6IiJLBUQlsS926NNdNR2NRC/gRwjxW1+ubro/KLpf/8
         /ySD87KntLT5YasYiFetxUSPNZsGgFAVLlMszqNRGZ2pelWyaw+6OANS9ophv4R12fWj
         0R5Y6VHI77Frj1nd1wA3sF4SMY79MbxKfbtVvS+mBPBbFNTcT37pku5ucEwjVIXIQmxH
         Bs/ljebsXao0/SZ9s8/2gN7F41XLs6CNpwIRWSmuqNr05jBP3xBiDDUp90/esyr/dME8
         FO5A==
X-Gm-Message-State: ACrzQf3qrcYw/4A2Y+I+t/87Qy7APTH5N/lWCJ4E9AEfGVLtUjfpmaec
        TpJzgdhNPuJDCt2mOwfr9bcxzh5WJps=
X-Google-Smtp-Source: AMsMyM5xREnYsmKvsfVSy53zDaZSsvz3JVmp5gDiNM3glTL+rMcpZLXrmB/5XgGGhjo7llNeh1d1Sw==
X-Received: by 2002:a63:f556:0:b0:44e:12bf:2dd8 with SMTP id e22-20020a63f556000000b0044e12bf2dd8mr566118pgk.400.1665073252522;
        Thu, 06 Oct 2022 09:20:52 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id y1-20020a62ce01000000b00562496395besm3209014pfg.170.2022.10.06.09.20.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 09:20:51 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Git List <git@vger.kernel.org>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: Re: [PATCH] t/lib-httpd: pass LANG to Apache
References: <3b370f7b-df84-0629-d334-aa9dfbca1c05@web.de>
        <xmqqtu4inj6q.fsf@gitster.g>
        <Yz31Lv+97z9p/0TK@coredump.intra.peff.net>
Date:   Thu, 06 Oct 2022 09:20:51 -0700
In-Reply-To: <Yz31Lv+97z9p/0TK@coredump.intra.peff.net> (Jeff King's message
        of "Wed, 5 Oct 2022 17:20:46 -0400")
Message-ID: <xmqqy1tsnct8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>> Shouldn't we be doing the same here?
>
> I think setting both probably is overkill. But if we are going to set
> one, the important one is LC_ALL. It overrides specific LC_* variables,
> which in turn override LANG. So just setting LANG would get confused if
> LC_MESSAGES were set, for example.
>
> That said, there probably is no downside to passing through both, so we
> might as well do so.

Yup.  I suspect that the habit dates back to before LC_* was widespread
and some platforms needed LANG.  On modern systems that understand i18n
and do not need to set NO_GETTEXT, forcing LC_ALL should be sufficient.

> Other than that, the patch is obviously the right thing to be doing. I'm
> surprised it took this long for it to be a problem. ;)

Thanks.
