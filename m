Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D127CC636D7
	for <git@archiver.kernel.org>; Tue, 21 Feb 2023 20:15:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229558AbjBUUPp (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Feb 2023 15:15:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjBUUPo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Feb 2023 15:15:44 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F1E52FCD8
        for <git@vger.kernel.org>; Tue, 21 Feb 2023 12:15:41 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id g12so3236041pfi.0
        for <git@vger.kernel.org>; Tue, 21 Feb 2023 12:15:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bUH+xyLiKBmPsxb/HCrW3PYuy85IrQVYBOQpYwvY5lE=;
        b=WDIML5kuMZxDohXZmcZ5iqCDAsmy52QPR7TLEREM0lwzmOHihHNcnW+67WM+4YqrCW
         I0VBAIYvkzuKquEQWgaIhyEdPn+cJnicTJ5Mh95heHSWKWAthk8v8goyBy1QPBQJBrdu
         PQpikZtKDdNJ/AEqRuksUZKyfgcq+BM4FMWRAXtV4P5KI2nYInR3PXsV86rQdbpPmbYt
         X8dPPM7xj4/SZYRJdwbFQtaM7kic0tZj3CvhlWJJs4IoocV/osgvn0WStOrkVxFgqMfS
         8q4BhKF0KRwIwpHwjcTd+lMwaacoX0cIA1yXHQ7y4k2XclBtK/7HA5OMjZuka/T5W3hA
         M6Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bUH+xyLiKBmPsxb/HCrW3PYuy85IrQVYBOQpYwvY5lE=;
        b=e85UCuUuhrmzpK9wMULy2Y1VP2RXSrGWbqtWTJpTKpiTQVF/+J3bGmQWO1fwW11ciL
         /WQKG7f2N0iWbtYI+EPK7/7n9esutOHs9PPat4BKeWlW2SctMkBXo3/9DNWMdJNhHBx+
         wtRlI8vrZRplbMeJYz20P9CJWujLK7OrHmF8crOEFyt+sfzmxOrWsqUVGpfDDcpRoin/
         OIGOwyeZha7yM2yF1+Ya/TjE/ZAQ/rPWO8PLQB9iqK/MnjA89p5VaObXULdGs/1s4LfZ
         9ZelmtlJP1hhg7zZPoiuTNB+qaId0WyOezQWVxTVl39+0pYStizCyir4rbjDAnYPFSE3
         Dvyw==
X-Gm-Message-State: AO0yUKX6WPc6xd82JTpE+wQLPAAOFO+MK4JhfUGlSlrjlSB3t4DLtaqs
        kEER6+1E144p7Q+DEQaXAQU=
X-Google-Smtp-Source: AK7set9bKrDYTLDNO7LYHxF8A6iJP0Mob/N0+v76P53atQuz3lSgZ8CvS2Rv2kaKEwBE67ZW9B4Fgg==
X-Received: by 2002:aa7:9e1b:0:b0:5d2:7988:2b80 with SMTP id y27-20020aa79e1b000000b005d279882b80mr1334942pfq.14.1677010540765;
        Tue, 21 Feb 2023 12:15:40 -0800 (PST)
Received: from localhost (252.157.168.34.bc.googleusercontent.com. [34.168.157.252])
        by smtp.gmail.com with ESMTPSA id q16-20020a62ae10000000b005939de7104asm9905895pff.215.2023.02.21.12.15.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Feb 2023 12:15:40 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Matthias_A=C3=9Fhauer_via_GitGitGadget?= 
        <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Drew Noakes <drnoakes@microsoft.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Matthias =?utf-8?Q?A=C3=9Fhauer?= <mha1993@live.de>
Subject: Re: [PATCH] fetch: choose a sensible default with --jobs=0 again
References: <pull.1483.git.1676928805555.gitgitgadget@gmail.com>
Date:   Tue, 21 Feb 2023 12:15:40 -0800
In-Reply-To: <pull.1483.git.1676928805555.gitgitgadget@gmail.com> ("Matthias
        =?utf-8?Q?A=C3=9Fhauer?= via GitGitGadget"'s message of "Mon, 20 Feb 2023
 21:33:25
        +0000")
Message-ID: <xmqqcz62epw3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Matthias Aßhauer via GitGitGadget"  <gitgitgadget@gmail.com>
writes:

> From: =?UTF-8?q?Matthias=20A=C3=9Fhauer?= <mha1993@live.de>
>
> prior to 51243f9 (run-command API: don't fall back on online_cpus(),
> 2022-10-12) `git fetch --multiple --jobs=0` would choose some default amount
> of jobs, similar to `git -c fetch.parallel=0 fetch --multiple`. While our
> documentation only ever promised that `fetch.parallel` would fall back to a
> "sensible default", it makes sense to do the same for `--jobs`. So fall back
> to online_cpus() and not BUG() out.

Yup, the way I read 51243f9f (run-command API: don't fall back on
online_cpus(), 2022-10-12) is that it wanted to make it a best
practice for the callers of the API to be making an explicit choice
of scaling with online_cpus() or other metrics depending on their
needs.  The problematic commit does touch some fetch-related code
paths and make them call online_cpus() themselves, so we probably
are looking at an inadequate tests, and this is a fix that is in
line of the spirit, completing what 51243f9f started to do.

Thanks, will queue.
