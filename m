Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB6A1C636D3
	for <git@archiver.kernel.org>; Tue,  7 Feb 2023 21:28:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbjBGV23 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Feb 2023 16:28:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjBGV22 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Feb 2023 16:28:28 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36081198
        for <git@vger.kernel.org>; Tue,  7 Feb 2023 13:28:27 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id v6-20020a17090ad58600b00229eec90a7fso2482169pju.0
        for <git@vger.kernel.org>; Tue, 07 Feb 2023 13:28:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M6Zbu2uJoXzUbnLXGEwrz9bsh3fBx/st0NR8GzyGf/Y=;
        b=SEjayroM6kR5CLbL2H3uvfCPZwdZ2dmNaoF25GwutG90DzCGawHr1/hYIW/JiU//eY
         roRn59p3s6CJKSIrATl/ohI+XL+xbzZF7c50WeIJkp472IMB58Il7+59Fh0ThUVMMRFK
         W6UGGHJ5dd0TaAmUk1a4XPJMusH/fHAn2l3I2jgkqd4LD615dNgIKo+tduD3cTmCKchl
         VpsxsV1eGHvrkfLCw+hbQPgjAF3Out0qsFaQjcYzq6bk6RFepyfhJctAXXHmSA8q/qSL
         wR9+b6PVb/VscTi2HOBllmnVol2BsTdJOwnMNwjZUeZkXbPOfzTELF4n1iydKWZJYQYC
         0W5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M6Zbu2uJoXzUbnLXGEwrz9bsh3fBx/st0NR8GzyGf/Y=;
        b=RPBXat95mQC+Lrz+w5jVSkMVvJ+9O2m8SNY1gClnFzmL6WFKRabM5rsX2H5r3xaGDb
         b3CAdp9q2WxdP2Q1sijtQHgzaW6Wq0XJvibiYw4wFFfUYYwe02vYpn744gnW3Z9TvcfJ
         FPoQti3l3P9AAju/Fu/elPDccYBGMZAl/osbHobDkeegfX3umLlZk+ajSUfGN71I4KbL
         Bq6dVoJ1i6SqIoDJCNIhWlQp/BhOLC/sMrT4kCvUN0GeN4WSUfeEKITFRjT/3iXqz6UZ
         xyu1jdxU1hfVXF3+pgqoqd9A81HGqV7U1vDJelkiqQKwacvLGLNalX2DJD7dcRkOTBUf
         PGWQ==
X-Gm-Message-State: AO0yUKV680Ud3khkXWfWBZ8/3NShtZ5/5PRh30MFpcFGCq3/q15A/vUC
        XmjLj0pd6fA60knzpT+Buzo=
X-Google-Smtp-Source: AK7set+FRsy/AiZAkAV9wYyHedF0pv1lHXGx972jeqaPlix2b6HkZ/oJPOJkPnBvZs3J1juWFmHxBg==
X-Received: by 2002:a05:6a20:7da2:b0:b5:a231:107f with SMTP id v34-20020a056a207da200b000b5a231107fmr6553223pzj.12.1675805306571;
        Tue, 07 Feb 2023 13:28:26 -0800 (PST)
Received: from localhost (137.22.168.34.bc.googleusercontent.com. [34.168.22.137])
        by smtp.gmail.com with ESMTPSA id t23-20020a639557000000b004ecd14297f2sm8379021pgn.10.2023.02.07.13.28.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Feb 2023 13:28:26 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Jeff King <peff@peff.net>,
        John Cai via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, John Cai <johncai86@gmail.com>
Subject: Re: [PATCH 2/2] diff: teach diff to read gitattribute diff-algorithm
References: <pull.1452.git.git.1675568781.gitgitgadget@gmail.com>
        <8e73793b0db3e84366a9c6441cc0fdc04f9614a5.1675568781.git.gitgitgadget@gmail.com>
        <Y+KQtqNPews3vBS8@coredump.intra.peff.net>
        <230207.86k00t2owm.gmgdl@evledraar.gmail.com>
        <xmqqcz6lyzhw.fsf@gitster.g>
        <230207.86bkm52n8x.gmgdl@evledraar.gmail.com>
Date:   Tue, 07 Feb 2023 13:28:25 -0800
In-Reply-To: <230207.86bkm52n8x.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Tue, 07 Feb 2023 22:05:29 +0100")
Message-ID: <xmqq4jrxyxl2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

> To clarify, I'm not suggesting that we ever read arbitrary parts of the
> "diff.<driver>.<key>" config space, but that we could whitelist one set
> of "diff.<driver>.<known-key>"="<known-values>".

When the value names the path to an executable or the command line
to invoke a program, there is no "portable" value that is useful.
Whitelisting macOS only program only because its pathname is one of
the known values does not help me running something else.
