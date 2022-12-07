Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DC5AC352A1
	for <git@archiver.kernel.org>; Wed,  7 Dec 2022 04:57:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229696AbiLGE5r (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Dec 2022 23:57:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbiLGE5q (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Dec 2022 23:57:46 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64B1EB1DD
        for <git@vger.kernel.org>; Tue,  6 Dec 2022 20:57:43 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id jl24so15995571plb.8
        for <git@vger.kernel.org>; Tue, 06 Dec 2022 20:57:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NTOCuozI/pPA90f+UDZ74AqsygZE8nQxWbNC4+c3bl8=;
        b=mJJEQrL1ZaxVLSeMNe3hBU6VNernlXYsKmI9V8KwKbLYq86vlieWLW31lahc4jChCa
         26AyGtA54W4zCpAj8BbYsTnmlaK7hPciSqzXusQ1+L8T4lmgTDlXxDqmuQwPcXzEfesV
         pqGxqUdcitoE8BbHZas9eADAHH6LmMuEB4FTIPgWD4dPbv/lHwbRtQsxSEfj55YfDq+X
         T5I0cv+32/UDAN5SkzuwiUxMAjmUCS0UKnpiKkt9OZarqLicIUw3nZ7sP1TccQgGIh2e
         hROiCrd+Y7/IhFJQjQCz9BZLogVmkaLmqYUbFZByw9sf56JjeYW/NjFu3/BxEpBbu1ue
         LgpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NTOCuozI/pPA90f+UDZ74AqsygZE8nQxWbNC4+c3bl8=;
        b=1Lo1pDIOAugYta/VQouQ2VRdFDp9gvs0pSdMD6k6XTXj4ImZPyPIZzKv086ENpuygx
         iFUo+XO7GMvp74KwXmIyFnz2I4p61HLRnjhw8cbHBn4qpsCrPeGZJrnGGXakc94FP9Yo
         IHKKrnD9bESxo+02/+0gis0+2Eo8UhGSC5OoWuETm3fjKu8A7BFCzXccVAqwIKxe+6Av
         xrJBmM4fhNtIU8jH7VTal+fW31pinFb+Uf3GQgwwZcfZxmct5MXzwJsSkyNF3emU2d2G
         79EQ4IYjNlYgTUFKNtDPukD57nkXtIpcgSfpzfKZ+WBpzX+K6EfDoTCe7SfPF4vQZJ+0
         pIIw==
X-Gm-Message-State: ANoB5pkOjTU26PBXBA788JbQKDAQafLTK51/7R7m03ee2Dzb6LonZXI8
        BckjIM5DAANkdVDRKg8MIsk=
X-Google-Smtp-Source: AA0mqf7AqpBWV/JROPnUnx0I9HOvkksugYAklddM/6KLZUPxSmWmcb2OWx5x/g9pcVtJaipd+F+mAw==
X-Received: by 2002:a17:90a:5b09:b0:218:a0cd:5a99 with SMTP id o9-20020a17090a5b0900b00218a0cd5a99mr87181140pji.76.1670389062831;
        Tue, 06 Dec 2022 20:57:42 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id z18-20020a170902d55200b00186b138706fsm13498042plf.13.2022.12.06.20.57.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 20:57:42 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, David Caro <dcaro@wikimedia.org>,
        git@vger.kernel.org
Subject: Re: Skipping adding Signed-off-by even if it's not the last on git
 commit
References: <20221206170646.6lnpr6h7oprziy5b@vulcanus>
        <Y4/xSObs9QXvE+xR@nand.local>
        <221207.86y1rjako8.gmgdl@evledraar.gmail.com>
Date:   Wed, 07 Dec 2022 13:57:42 +0900
In-Reply-To: <221207.86y1rjako8.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Wed, 07 Dec 2022 05:31:18 +0100")
Message-ID: <xmqq7cz37qux.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

> But if I submit three versions of my own patch with the same growth
> pattern over those three iterations shouldn't I have 3 of my own SOB
> lines: Ævar, Ævar, Ævar?

The difference, I think, is that it is not worth recording if it is
just you regurgitated the same idea a few times yourself without
input from others.
