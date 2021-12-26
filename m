Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CB2AC433F5
	for <git@archiver.kernel.org>; Sun, 26 Dec 2021 17:27:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232879AbhLZR1b (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 26 Dec 2021 12:27:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230484AbhLZR1b (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Dec 2021 12:27:31 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECBF8C06173E
        for <git@vger.kernel.org>; Sun, 26 Dec 2021 09:27:30 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id x15so53479958edv.1
        for <git@vger.kernel.org>; Sun, 26 Dec 2021 09:27:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=SzR3fL6b1XMEGJOIrJK0rfOLLIzupoXMOZPbCEheN+Q=;
        b=p69c8A3zD8QiHih7QkuDRJHd2QFIDkGbqj7A1y72ThAlIP7aTYyE6fFWi3SzeJUULi
         d2WAYHooH7uaMEQnmDvhB3qLX2gdWsEPJzVF8AF+5uU8/AKf9yUIl9P4XTQ5yhSPl1/d
         59HFSVu+LVdSl3oJafHmxh2UpehY8XYFjcZmOFEWDepUFqpXdnFcLVShf1I3KY+vcVqg
         avzbiY15x7tp0Zl+ccTL01ax0ZLty4fwziUDOfNHZjBkDd5DB99vgZGYnPZA2OW2wGrX
         5AaD/pzzcnPyxOGs3QHzrbcXO1/v2tqjDBefwA38Qo4TZ0ASCQKbZQTkZ+ugBM2oK3L+
         e+xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=SzR3fL6b1XMEGJOIrJK0rfOLLIzupoXMOZPbCEheN+Q=;
        b=B2Wpj4e9iJI9EbI5QygX30hcTH0ZxvlBXb1/GdugEj/0QAhfjgKpixo5c2UJfO6cEA
         dtcwVSg70YjLfz3j8UPBQwj1pAozITLAo/HHTioc9oMvwCEJRX1ld/kjflo7W4y0dmQo
         wmYkS4zQyG3/6PNu/03cHyL60MnPnmYdpFCA1LtN1JKI/YwLBJKmsfP02vX3hccoMvYH
         CIsMIqsNpE+Ta32QFjgnbExOmLbNlkPk2X+hscIn+pXoekp9ou5aqlrSQf785+efjd3D
         IyipWZu1JN4kezRe0WdKbR7wn4BlEj7MG2mVrA8eUDnCpzQ7cyLve4Y97cUs7J6bxMrT
         o2LQ==
X-Gm-Message-State: AOAM533vKqW9dMhuGTsBRgwfsPyQM1BCjUdaR5eeO80RZKWTURy2lrdp
        7fkIfHghyCzsKGap3Kln2kaSSPceqGMIqA==
X-Google-Smtp-Source: ABdhPJzrneAJ0XhL4n5Sc5Nb/F9Wi3s5sQDTcXCuNzQRFQr7H7StZs0s4gCRwYsDt2hvzETOAO2Hqg==
X-Received: by 2002:a17:906:1643:: with SMTP id n3mr11025948ejd.733.1640539649355;
        Sun, 26 Dec 2021 09:27:29 -0800 (PST)
Received: from gmgdl (157-157-127-103.dsl.dynamic.simnet.is. [157.157.127.103])
        by smtp.gmail.com with ESMTPSA id dd5sm4436740ejc.59.2021.12.26.09.27.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Dec 2021 09:27:29 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1n1XIu-0009YU-Ai;
        Sun, 26 Dec 2021 18:27:28 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: ab/only-single-progress-at-once (was: What's cooking in git.git
 (Dec 2021, #05; Thu, 23))
Date:   Sun, 26 Dec 2021 18:24:11 +0100
References: <xmqqsfui6g7q.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <xmqqsfui6g7q.fsf@gitster.g>
Message-ID: <211226.86y247ff9b.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Dec 23 2021, Junio C Hamano wrote:

> * ab/only-single-progress-at-once (2021-11-03) 8 commits
>  - progress.c: add & assert a "global_progress" variable
>  - various *.c: use isatty(0|2), not isatty(STDIN_FILENO|STDERR_FILENO)
>  - pack-bitmap-write.c: don't return without stop_progress()
>  - progress.c: add temporary variable from progress struct
>  - progress.c tests: test some invalid usage
>  - progress.c tests: make start/stop commands on stdin
>  - progress.c test helper: add missing braces
>  - leak tests: fix a memory leaks in "test-progress" helper
>
>  Further tweaks on progress API.
>
>  Needs review.
>  The last three rounds has seen little reaction, even though earlier
>  round saw a lot of responses. The latest round needs a serious
>  review or at least Acks from past commentors.
>  source: <cover-v6-0.8-00000000000-20211102T122507Z-avarab@gmail.com>

This is the v6, but I submitted a v7 on December 17th that should
address the outstanding questions about this series, i.e. it ejected the
controversial last patch adding the BUG(). I can pursue that later,
which should make its review easier.

I inadvertently broke threading in the v7 submission, sorry about that,
but here it is:
https://lore.kernel.org/git/cover-v7-0.7-00000000000-20211217T041945Z-avarab@gmail.com/

And the old v6 you've got here is at:
https://lore.kernel.org/git/cover-v6-0.8-00000000000-20211102T122507Z-avarab@gmail.com/
