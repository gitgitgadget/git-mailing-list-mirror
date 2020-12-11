Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07985C1B0D8
	for <git@archiver.kernel.org>; Fri, 11 Dec 2020 12:04:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C281A23F58
	for <git@archiver.kernel.org>; Fri, 11 Dec 2020 12:04:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390367AbgLKMEV (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Dec 2020 07:04:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390445AbgLKMEF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Dec 2020 07:04:05 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE6F6C0613CF
        for <git@vger.kernel.org>; Fri, 11 Dec 2020 04:03:24 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id m12so12989051lfo.7
        for <git@vger.kernel.org>; Fri, 11 Dec 2020 04:03:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=g1rau5KanA11f2mVor6LU/lQOyF0rtX59b18huQP37s=;
        b=vQ2D+XFOwFNhog5aSTHDQ1+P3aRHPBCaj560fniR/7TTrR0XrSk3f+wu75GfUUh8ea
         /btQa964uBzUFrw/owH34vN+D01/hN7ueCbc6o0wEcAPGmXDm7BYo8NIMlndPqYW0T3E
         5keq5lLEMLUWfbG3HR/hYfxkj8ZmVx1g7CNEZVMXDmWxzsxhdtoxBYR7gPxVaQpvC54J
         vRyTCW8GNlWtSXayhLOLrC8KqqIolqvHm6J3W5hh7VWsFJE2tyfDCa8HBycueyGGsJzg
         CvNyng2b7OKO4h2TXqWt61EiogkGZ38G1Vveoxz2ypK0ObXGC2XUvcgyy0VlVnSzBihi
         P5xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=g1rau5KanA11f2mVor6LU/lQOyF0rtX59b18huQP37s=;
        b=EZwVqydrsV8Po0DFy0uo6nOFEnipvNDmZGkeombFFcPC2eE5kZG+RUL/uuOezhy6Ez
         K5RlVTFD+9g8y6yHIhRbevjM9r7fhbikItUUImWoaCPgRlHh+GmbKdJ2sJjb8GvSBpc5
         Ny0x8Ex0F0CMx1sfrru/qLa8IbDdyG7dA3avGSeiiLwTUiH/TFelkl4K1fBmmhKnlFrr
         ChvCT5h13lrgmVw/9ruhFmfe5UHGd+n9E0hyw2/h8++9nzaOnaRANNslIyHH55voyk6Y
         k/u0qs+qkeRAQtRTDOx9IrFkvMlPCHPqXfBt9kKU6Oa0PI6QXBSUVRtd5qGm2QE9l8m+
         ek5A==
X-Gm-Message-State: AOAM532Gr1wPPDirTXN9HEjZs9/3De782RoQ2orTSPApcbZkqQc/9Dc1
        hFq2HO2J56tfJQrp0huB4HRsJlniUAHQkg==
X-Google-Smtp-Source: ABdhPJzon/f0Xj5hQXYTU4CXYdUiX3SlsJEItsOlCzheeCtQenmOrwj/BV13WgXP0w4otq7GwxHoCg==
X-Received: by 2002:a19:6e0e:: with SMTP id j14mr4985263lfc.374.1607688202992;
        Fri, 11 Dec 2020 04:03:22 -0800 (PST)
Received: from [10.0.0.3] (host-213-5-210-87.wtvk.pl. [213.5.210.87])
        by smtp.googlemail.com with ESMTPSA id x198sm861083lfa.228.2020.12.11.04.03.21
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Dec 2020 04:03:22 -0800 (PST)
To:     git@vger.kernel.org
From:   =?UTF-8?Q?Mi=c5=82osz_Kosobucki?= <mikom3@gmail.com>
Subject: Cleanup tool for old blobs in partial clone
Message-ID: <6446f471-87ed-9fc4-fd54-61c5cf95a218@gmail.com>
Date:   Fri, 11 Dec 2020 13:03:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

I recently looked into the partial clone functionality and how it could 
be used to replace Git LFS.

Let's say that I use partial clone where one directory is filtered out 
through --filter=sparse:oid=XXX. Let's also say it's a directory with 
big assets for a computer game.

Now, as the project progresses and new versions of assets are checked 
in, I'll accumulate many version of these assets as I get new versions. 
I won't need them though, because most of the time I'm interested only 
in the latest version.

So my question is: is there some tool (probably similar to git lfs 
prune) that will let me get rid of the blobs that I don't need anymore?

I couldn't find information about it anywhere in the docs. I vaguely 
remember a mention of something like that possibly being done in the 
future in partial clone (or maybe promisor remote?) patch mails but I 
couldn't find it again.

Best regards,
-- 
Miłosz Kosobucki
