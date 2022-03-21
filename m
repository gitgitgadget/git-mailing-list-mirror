Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D86FAC433EF
	for <git@archiver.kernel.org>; Mon, 21 Mar 2022 09:21:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344138AbiCUJWu (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Mar 2022 05:22:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237150AbiCUJWq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Mar 2022 05:22:46 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F576F8442
        for <git@vger.kernel.org>; Mon, 21 Mar 2022 02:21:20 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id bi12so28573644ejb.3
        for <git@vger.kernel.org>; Mon, 21 Mar 2022 02:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=d0V4hYGUh0f0cWK9o5bcHq9A856HnQRBM1EozaMhrHc=;
        b=n3Mt37w+0OTvTLZIMOmbIU57V/SPkfbXymdFMWuDDiAn/8QSJCOAmJqMFOIXsRq9l/
         f19wf3eCzduXiePyxKGm9yGjeTagH46mtM78E9UyDxiybY9bf7n2jvLQyrbsrGfr7fE0
         smxu9naEo/4/VKVtBjW4sVzfXQwD4BPJs7WxyYjzwAeY2HesqsIZMIvuXuNg4wizRFVl
         EqyhRPjgnBCREOZrwm4+1mzgwm04akpSE6MnAIKL/Zo7UOcJkidieRFWOmG3xNlmjgug
         egePyBlSBy/uKo2Uq61HeXNchlHAxHd4c9evDol5m2QUyjS+D4EF+Ai3Unk+d+v8VPiB
         3w/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=d0V4hYGUh0f0cWK9o5bcHq9A856HnQRBM1EozaMhrHc=;
        b=8JBV6TdkIkSjNK8fYSBIuppRcQDN5Bgj/jhu/nf1dV3jkUxFxV8+v5mABH8SkGyOlw
         7+BB5MI+0DoW8/Xxc53rnrt3shD04bK7hZ9yS3rJf95w0B0XTp/8GLkVtJM06WPCu0SQ
         +dd0Fc3O37gD4ZvuoWLP0chcyqdtjH2GcKZIwopFAx0M3hrsMqbcukJfLR0MZtOLLLpV
         SwY8ZuokRT9eaYBxFB4JmSpSIhG/mRYWr2uvEZO5sRzUeYrourWZ7QdtHRHtRF1ttcTA
         4pXvWs/qmIpbHaUNZpLctLGEHjk+oJudmWabZG62UzW51IPz2tACtVGyzZ23FwPL2f4O
         J8eg==
X-Gm-Message-State: AOAM533tvAXkL4GQtdyKnG2D6A4kcZi2cqc0pAOMYmCUbXr1bKAIQw+a
        RgTan4AamOcw9ROHWwkj2KU=
X-Google-Smtp-Source: ABdhPJxRecNXmymewtFnqXfx1fu3rDPJuLYJOT/aH4RwipEb+w5WIMa+9aygn1Nc7Tn8418HkR6g4Q==
X-Received: by 2002:a17:907:3d87:b0:6e0:bef:c3cb with SMTP id he7-20020a1709073d8700b006e00befc3cbmr3960065ejc.503.1647854478936;
        Mon, 21 Mar 2022 02:21:18 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id s20-20020a056402015400b00418f9574a36sm5912910edu.73.2022.03.21.02.21.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 02:21:18 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nWEE1-0007N0-Pa;
        Mon, 21 Mar 2022 10:21:17 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Teng Long <dyroneteng@gmail.com>
Cc:     Johannes.Schindelin@gmx.de, congdanhqx@gmail.com,
        git@vger.kernel.org, gitster@pobox.com, martin.agren@gmail.com,
        peff@peff.net, tenglong.tl@alibaba-inc.com
Subject: Re: [PATCH v13 16/16] ls-tree: split up "fast path" callbacks
Date:   Mon, 21 Mar 2022 10:20:34 +0100
References: <cover.1647846935.git.dyroneteng@gmail.com>
 <010e3c0eceac0a936a447a6df7ba8c9abb7c77b2.1647846935.git.dyroneteng@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.10
In-reply-to: <010e3c0eceac0a936a447a6df7ba8c9abb7c77b2.1647846935.git.dyroneteng@gmail.com>
Message-ID: <220321.865yo7d5ki.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Mar 21 2022, Teng Long wrote:

> From: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
>
> Make the various if/else in the callbacks for the "fast path" a lot
> easier to read by just using common functions for the parts that are
> common, and have per-format callbacks for those parts that are
> different.

FWIW I didn't do any exhaustive benchmarks of this, but I checked a few
things against origin/master on linux.git and all the reported
"hyperfine" timings were the same/within the +/- interval.
