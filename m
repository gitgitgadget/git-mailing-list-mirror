Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75E24ECAAA1
	for <git@archiver.kernel.org>; Mon, 31 Oct 2022 16:06:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231776AbiJaQGg (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 Oct 2022 12:06:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231235AbiJaQGf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Oct 2022 12:06:35 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06DCDC78
        for <git@vger.kernel.org>; Mon, 31 Oct 2022 09:06:34 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id l6so10798211pjj.0
        for <git@vger.kernel.org>; Mon, 31 Oct 2022 09:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fkttgzDXIAy0Su/PuJsaG8XW+vo8k7cbUB3P0RujAIg=;
        b=ItjgARuFQp7ks5aMR+Sl3P84PQvK+qj3kxmneizEfMJY4EbD5CKws37HHlsT6P2jbe
         2p3hLUO21qL51YRKbhH+V0Wy4NTVafJOUBB5jSn9z8O7IkVOTzCN/g1CAgtfZSzBHgzZ
         d5V0oz1ro0Aqp3CP0v9Cb9ZCNAF6IelBOMXit8lZ36cHRMwxhplg/ZJiB8C4zkp1T9r9
         XWbV8RxNAsKzWFDVMs1JgZfwrnV2cZzGbCheRnlsNeBP8j6SHQ9D00Z9lONGd7bXIPih
         a+dRDdnWy/J9AlYFiT8F7lQgrpAPD1YRKZalGne3rTCk/3Jx+VnwFMZGWKzWzcoaHZuS
         6YMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fkttgzDXIAy0Su/PuJsaG8XW+vo8k7cbUB3P0RujAIg=;
        b=toQcEOusvPhSWBWwt86hR67oJl4xY1kcC/Xg/wXdr7ndWsCwA/KzCMWw7vJ/1HfJf6
         C3kKzUfodRTexuoil1qshbvn/Iy7kKbEV7mNXZ9fu7qPS9n9JTHj0rPjxn9JDi+HJ0lV
         eIWfc8ERsUbutqDp3NkRd+QAb/ebmFnAL376dKmZXnGaUjQy+Kx4bcPRYHJMwElgd4Kb
         4YmIsKFF7QYMgliuXXMYgz4Mgj2y6gIKP3uVCPLAk55J5TZk9BVelHc6qcBqvfYhBaIh
         xnJ5VmqcGhLKgxndf9or9smA4VduYMg1y47PW9lYovRuyK8RMJvVTRJZJ+l7NOiQG+07
         wmGQ==
X-Gm-Message-State: ACrzQf1/kTc0w5Aty8F9ush+6z/V7nUUFXXKDvcxYK1cpXINYv7F2Zil
        hf4BW6XE/mt+D45dREwAvWQ=
X-Google-Smtp-Source: AMsMyM5ju7wIclHxxv01m5kGYA0LnJRT9PyhZ43UijaNWitQywMcbq8xuVNu98inyisIEt0UYLku4Q==
X-Received: by 2002:a17:902:a506:b0:186:8272:bb50 with SMTP id s6-20020a170902a50600b001868272bb50mr14938656plq.45.1667232393394;
        Mon, 31 Oct 2022 09:06:33 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id w141-20020a627b93000000b00560bb4a57f7sm4919553pfc.179.2022.10.31.09.06.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 09:06:32 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>,
        Abhradeep Chakraborty via GitGitGadget 
        <gitgitgadget@gmail.com>, git@vger.kernel.org,
        Taylor Blau <me@ttaylorr.com>,
        Kaartic Sivaram <kaartic.sivaraam@gmail.com>
Subject: Re: [PATCH 3/5] roaring: teach Git to write roaring bitmaps
References: <pull.1357.git.1663609659.gitgitgadget@gmail.com>
        <4364224f9bddc8f1e40875ebc540b28225317176.1663609659.git.gitgitgadget@gmail.com>
        <xmqqczbdl6wl.fsf@gitster.g>
        <CAPOJW5yxRETdVk014gQYFud9_Nrt+OQGSVNQ8Pw2wDEMMFMm1Q@mail.gmail.com>
        <CAPOJW5z_ZRChNo8PGBmJu=vvjTL2cYL8oTdVwoDRh-UHt2Dy4w@mail.gmail.com>
        <58841dcd-e732-416f-5ab0-fd5a5d8de4c7@github.com>
Date:   Mon, 31 Oct 2022 09:06:32 -0700
In-Reply-To: <58841dcd-e732-416f-5ab0-fd5a5d8de4c7@github.com> (Derrick
        Stolee's message of "Sun, 30 Oct 2022 15:46:20 -0400")
Message-ID: <xmqqcza8dlkn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <derrickstolee@github.com> writes:

> I HAVE OPINIONS! :D
>
> Mostly, there are two things I'd like for you to keep in mind:

Nicely summarised.

Stepping back a bit, we do not care about how the sources to some
pieces of software we depend on, say OpenSSL, match our style guide.
It is because we do not even have to see them while working on Git,
but also because we do not have to maintain it.

So a third-option could be to fill pieces missing from the upstream
(e.g. big endian support) and contribute them back, and after that
treat them as just one of the external dependencies, just like we
happen to have a copy of sha1dc code for convenience but have an
option to use the upstream code as a submodule.

Assuming that such a "they are just one of our external
dependencies, just like OpenSSL or cURL libraries" happens, I would
not worry too much about C11, as long as use of roaring bitmaps can
be made an optional feature that can be disabled at compile time.
Bitmaps are used only for local optimization and never transferred
across repositories, so you having only ewah would not prevent you
from talking with other people with both ewah and roaring.

