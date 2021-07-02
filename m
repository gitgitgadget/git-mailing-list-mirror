Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A4EBC07E95
	for <git@archiver.kernel.org>; Fri,  2 Jul 2021 20:44:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17F6C613E0
	for <git@archiver.kernel.org>; Fri,  2 Jul 2021 20:44:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230373AbhGBUqw (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Jul 2021 16:46:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230274AbhGBUqv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Jul 2021 16:46:51 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D714C061762
        for <git@vger.kernel.org>; Fri,  2 Jul 2021 13:44:18 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id 22so12743526oix.10
        for <git@vger.kernel.org>; Fri, 02 Jul 2021 13:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=Ektk86d4uv2elCRttQOIxIz/Gt+yy5mYxRgufdWmiuI=;
        b=PUKSiB7K+S/zbXFUcSCKL6Y+e29Czn1J4YxpLzVHM9oq9uu4vNpOU59D2tpxeH2zbO
         WN01+HRxMN6Z9rCFYVNvQbQf0KA/JspyDjbk0xgp1+2wvSM6kNeWahtqWuLv91ZDz0um
         8To/BgFpRLI3m68cabw48kj8AgK4M2BSugxBUFd1n43amqohiz/hLJtTTqPBtst+0s5b
         xmLNwoSXsFmx987i3lsJj+ufPfpaEpMJOcEK+dXpX4aoA3WYagAQ+WCunIXYc/G0l0Fq
         ugUzeCLwOJ3qxk7rn3rAH1vLHihmtf7xCJEZzeB1Xw2vs9f5tNklh6X5b3F+wRM5Xqos
         RXeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=Ektk86d4uv2elCRttQOIxIz/Gt+yy5mYxRgufdWmiuI=;
        b=EGDXV8uyqOfaX7pYLUdS/B6ppUKgDMQ1houZ8Gl5oxWz8N0rqUZhPNKGSRWUsEVxff
         23was7tjKKYM6+prtd8tof8mA7kS509vp40TQbhb2UgFMtwbmLegkAGHEQ3lbVa5GpYV
         gBEz3bzyZKga8hmHmeAf05flc2OPx74BjB84ry/5r3yaZlrc4RCvahIN8DxwoP8B3JqK
         sb27O/cZ6I+NNl9IRkddoG+SCTE/vr5Ly7qqOlvFw2n1Hb21fVHceSnaYExPnsTRbRXm
         2tyDeYqHOgu1QA2SUTxF97iktaI6u4bFco6jNktmj/6HT5X8eucShkmZgMffpsO8Qts8
         ghJA==
X-Gm-Message-State: AOAM530S2jME8vx/gnCl29aQOtPYHnGs6wJljzfC/Rzl6MbxybHyPMi9
        eO5JbF1TcULn7ZG9fp6u6Og=
X-Google-Smtp-Source: ABdhPJzzERTIsJGkZ5qFFP2X7gz+ZIDJ9HcYBZWYLOhT/XYX2p+FfJsywky+nqnT1xeb1CbC4fTBVg==
X-Received: by 2002:aca:5f8b:: with SMTP id t133mr267347oib.15.1625258657763;
        Fri, 02 Jul 2021 13:44:17 -0700 (PDT)
Received: from localhost (fixed-187-189-187-231.totalplay.net. [187.189.187.231])
        by smtp.gmail.com with ESMTPSA id q26sm805101ota.20.2021.07.02.13.44.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jul 2021 13:44:17 -0700 (PDT)
Date:   Fri, 02 Jul 2021 15:44:16 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     martin <test2@mfriebe.de>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        =?UTF-8?B?J8OGdmFyIEFybmZqw7Zyw7AgQmphcm1hc29uJw==?= 
        <avarab@gmail.com>
Cc:     'Felipe Contreras' <felipe.contreras@gmail.com>,
        'Andreas Schwab' <schwab@linux-m68k.org>, git@vger.kernel.org,
        'Junio C Hamano' <gitster@pobox.com>
Message-ID: <60df7aa04575_28bb20875@natae.notmuch>
In-Reply-To: <8f847f31-5c5d-0236-997c-bd07040f7ea7@mfriebe.de>
References: <20210702100506.1422429-1-felipe.contreras@gmail.com>
 <20210702100506.1422429-6-felipe.contreras@gmail.com>
 <871r8hauvi.fsf@igel.home>
 <60dee7d4e27bf_2964b20817@natae.notmuch>
 <65b1d215-c3ab-e0e3-f4ac-a30131541f9b@mfriebe.de>
 <60def07e686c7_7442083a@natae.notmuch>
 <3e82a574-fdcc-08b8-8fb5-1ff15f8ae564@mfriebe.de>
 <03a401d76f45$e1c6fce0$a554f6a0$@nexbridge.com>
 <874kdcal1k.fsf@evledraar.gmail.com>
 <03ac01d76f4c$ad23a130$076ae390$@nexbridge.com>
 <8f847f31-5c5d-0236-997c-bd07040f7ea7@mfriebe.de>
Subject: Re: [PATCH 5/5] config: add default aliases
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

martin wrote:
> On 02/07/2021 16:15, Randall S. Becker wrote:
> > Without knowing the full history of why the duplication, yes. That
> > would be my preference. If it is a git command, it should be handled
> > like one as closely as possible. Presumably, it also would show up
> > in git help -a. I would not expect aliases to show in help.
> 
> But, if it is a git command, can you still overwrite it with your on
> alias?

No, you won't. That's why they need to be implemented as aliases.

-- 
Felipe Contreras
