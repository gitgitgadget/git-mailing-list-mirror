Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A7D8C54EE9
	for <git@archiver.kernel.org>; Tue, 20 Sep 2022 14:42:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229982AbiITOkK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Sep 2022 10:40:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbiITOkJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Sep 2022 10:40:09 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 565241B797
        for <git@vger.kernel.org>; Tue, 20 Sep 2022 07:40:08 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-3487d84e477so29482547b3.6
        for <git@vger.kernel.org>; Tue, 20 Sep 2022 07:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=fWj3akc9Ht75MTHx8JoUNK0j66sogUPVCQlsADKEBBg=;
        b=RGB0ICHiRZpWbGx+4H/i3SN2mFPxqOA0X+Ugacwtiggx5q0v7lK4+L4W9RAoQctWcq
         zobvuh8MqPjq7ASExGSQi/7K/hEe7JRNS4xivcHJWA1o+0/zVTsbKlpZJl0XEedRTPEL
         nfdXXsnSQmQeruB4PMCPfmvS7eGyXOezlt4hwwZoTZC99Kj4UvmsYVbn6IZAFe9TjX+P
         v8IhtPu5qSQnE/K2XM+swVmuLgQ3cNtURyEkeY3G2k2pQvG0ijMvHEVygm6W68X+PRFo
         Ssuu3KRROjZSA5iNAPJkReVFeZ1GFOtkXB7znHGNIXQSaEoS9/9so9VKYDQZlEGJIHjX
         AGjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=fWj3akc9Ht75MTHx8JoUNK0j66sogUPVCQlsADKEBBg=;
        b=MQFqCc5pyOakHEd/liBi3lEGhz/Pqf8f2NPHEyvrznD/PFv9PI1yPubrzN/bwr+Zgm
         UXlG0OHiDGo74uX/ovqiToVKFnFoBt1I5I4bvBbJyjU/vpA/2YSwCsYd4JF/WTeBPYCb
         5GC194EUB/n+r4wiTPu7eXzbNr30oAcA/UX2DXp4IEX46BmGCWt7vcE0QWgcyPPcEnNF
         ABSYfSy/8wXSqR7jXbOFYPyT0VvCR9UylGhA2a9HJOcRiJ4G3DvCFykjNhEeJKdI4AgV
         cJRenK0091IeXerrE5mDgkHg+tx6tPExNMXCHj56VKn53lF2RxHEZbrEQ2sbeUsZa+VY
         Fs7g==
X-Gm-Message-State: ACrzQf0Ysr8nqO8B2D9xDuM6T/lZl7+WSsYDT5vqyD4/YsWFNEiDPfYs
        5JpSPS1VeWlfjFxR2rtlWOBjMkrDiR+SVRyWsN0VF7h1ytOWLoUf
X-Google-Smtp-Source: AMsMyM72dz87q8aN8BJsnYHta7maXMclbw8RzMvBVMl9iHhPZi1xLxt6XUVG8njJgEuK1mjJs07Tg63BFZuXvpGT79o=
X-Received: by 2002:a81:3941:0:b0:345:594e:ef06 with SMTP id
 g62-20020a813941000000b00345594eef06mr19656480ywa.179.1663684807557; Tue, 20
 Sep 2022 07:40:07 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1663638929.git.me@ttaylorr.com>
In-Reply-To: <cover.1663638929.git.me@ttaylorr.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Tue, 20 Sep 2022 16:39:56 +0200
Message-ID: <CAP8UFD3AE_qcQ2jLodKjoUE_wfEmXMLm5B9VbG52e10+XnhkbA@mail.gmail.com>
Subject: Re: [PATCH 0/7] midx: ignore cruft pack with `repack`, `expire`
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, derrickstolee@github.com,
        gregory.szorc@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 20, 2022 at 4:59 AM Taylor Blau <me@ttaylorr.com> wrote:

> This series teaches both sub-commands to avoid any cruft pack(s),
> preserving their metadata.

Maybe:

s/to avoid any cruft pack(s)/to avoid removing any cruft pack(s)/

or:

s/to avoid any cruft pack(s)/to avoid absorbing any cruft pack(s)/
