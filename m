Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CFD7C433F5
	for <git@archiver.kernel.org>; Sat, 18 Dec 2021 10:29:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230032AbhLRK3b (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 18 Dec 2021 05:29:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbhLRK32 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Dec 2021 05:29:28 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 569F9C061574
        for <git@vger.kernel.org>; Sat, 18 Dec 2021 02:29:28 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id z5so17468539edd.3
        for <git@vger.kernel.org>; Sat, 18 Dec 2021 02:29:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=TkhH3EqkhwdPzT5tJNo/WKi2CVdEb5r/H1z1r3ME8yA=;
        b=bzrBeKCZMgoFBPtTVc0Mkzx4Vhwkby+wY0+O8unwJyfQvYNcyIYb+RiVguOOcGcIL+
         pEgWAwzelWZ9d1GzeCaKT7kQePsVLUy8L9NjTkPQAAglxDEuWC2gvdB+7NCZdaChnJWh
         7Xeg/GcImWdRU6FPx57PsDEwx3IgQn0pf3OBDOg/LzOgEVYtcb5OvV+etwHlkgmZ4fQ8
         +F93KXHkT0xxxGLUhHREKzWDNg+EtmqtVOLQGY7lhvTupb1yW/p69qomqif0tdVjqMum
         eyOM6ThFBDlk0SOWCa8uYesX1Hc9JXbI3MyrsaWK/rnzn6lyORphAxmf9kC4UyWxi7HG
         MkHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=TkhH3EqkhwdPzT5tJNo/WKi2CVdEb5r/H1z1r3ME8yA=;
        b=IO/eXH/bQuvMTabVw7cPPzjlx204AvCHxHPVCDgqJqkB+p77rqIZ7klMRtKEA3QWbA
         i6shMuG6xDMxhjMHL0Xe+oS9m6NRxjwLarvMO9CLiC8jn6EKC4T906V1AzQOPKnvoX0g
         hZidzy9jRiNlYqVerfGHFplu3dALSUv38GGuiLI0ohV9JcxJiFjidJ28KYlvcatXO/Ys
         TnnhQP17ZDPpuKZLNzIZWlylemJe+csE6wI2rh0/yWbzAyW32Xv35amMSQyoPaCmyTyH
         aBznlxklaGpm0JkCzs+YSz8EcqGp2tYGZbyiumLCeo2UoZk9fjotXgrg4GbN/MU9+cgu
         5kBw==
X-Gm-Message-State: AOAM533uhesvEIMqCX0a1K0WrNIhvD9WJybkADjcxMHLAET2X2+vxX9v
        BGMfveAu9L6NPs8pMpb4xAC9N8E0ZWJtKw==
X-Google-Smtp-Source: ABdhPJyRU1Iv/gDtVzkH7+zXTB/1tFlDI5Y2dNV+G+C1+1YdvGx6UbFNj7CV7Yc8c9FtC58fH3/c4g==
X-Received: by 2002:a17:906:6a90:: with SMTP id p16mr5575237ejr.342.1639823366731;
        Sat, 18 Dec 2021 02:29:26 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id 12sm3539163eja.187.2021.12.18.02.29.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Dec 2021 02:29:26 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1myWxx-000IQo-OO;
        Sat, 18 Dec 2021 11:29:25 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] merge: allow to pretend a merge into detached HEAD is
 made into a branch
Date:   Sat, 18 Dec 2021 11:27:34 +0100
References: <xmqqbl1ezq5j.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <xmqqbl1ezq5j.fsf@gitster.g>
Message-ID: <211218.86sfuqw6ii.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Dec 17 2021, Junio C Hamano wrote:

> +		OPT_STRING(0, "detached", &detached_head_name, N_("name"),
> +			   N_("use <name> instead of detached HEAD")),
> [...]
> +	OPT_STRING(0, "detached", &detached_head_name, N_("name"),
> +		   N_("use <name> instead of detached HEAD")),

Maybe OPT_STRING_F and PARSE_OPT_NONEG, or does --no-detached make
sense?
