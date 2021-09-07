Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 397F7C433EF
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 16:30:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1748961102
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 16:30:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244800AbhIGQbQ convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Tue, 7 Sep 2021 12:31:16 -0400
Received: from mail-lj1-f177.google.com ([209.85.208.177]:35604 "EHLO
        mail-lj1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237074AbhIGQbQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Sep 2021 12:31:16 -0400
Received: by mail-lj1-f177.google.com with SMTP id y6so17512946lje.2
        for <git@vger.kernel.org>; Tue, 07 Sep 2021 09:30:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=QpDNWRL6St+Y5wBS4UUEY1sFAsVyI1ch2EQX5TU377I=;
        b=Bww1skOityuZvscfjRDqiSJKeN2LcFcfqwLVpC/WUXdTZnqlz6Fp8trlgM5zTBx+Tf
         WL2VW/Dimh2DjPFZAPfsF5djnysA5C9F7NSKeM0JonC/XnLEakEv0HJJhw3YGN2XrJyz
         2c74yJv6/uR29Auyz7kP6fwWXcaWv+ClWDf90eVEf9D23COHGF/YT23rA6Y/bxZbYgCb
         rYj7mA1WpZgyGf0rMy6HyXNUOIrGupv4NQIyih2kpZ8cUljYbpIdc9f2lhQleEwEtMon
         jqnNGbbgKeTMPi3PPVz8PSRObuYKUPYNurHZVMiyELfJAEK9RKmTqEA8N7Vh1zSV4RE3
         p4sg==
X-Gm-Message-State: AOAM5327JVpSx6Qi+J5RE0e+sHStpfcxWPtFbe+8IAAkcSlIGELyPO7a
        gLbyF29StfbAQUo5JQwhxP4f4eda0Dx3n40ubPcHuJ3V
X-Google-Smtp-Source: ABdhPJx5he1NFwkvkyMH1exkxVTMEF7z+uBsTfVErc2YDLxxa+cxTxi3WzFm/Ya+3LPnf0KmxsVv8LgMIji3OqUu6qo=
X-Received: by 2002:a05:651c:2125:: with SMTP id a37mr15155969ljq.317.1631032208473;
 Tue, 07 Sep 2021 09:30:08 -0700 (PDT)
MIME-Version: 1.0
References: <cover-v3-0.8-00000000000-20210831T132546Z-avarab@gmail.com>
 <cover-v4-0.3-00000000000-20210907T151855Z-avarab@gmail.com> <patch-v4-3.3-fffbfc35c00-20210907T151855Z-avarab@gmail.com>
In-Reply-To: <patch-v4-3.3-fffbfc35c00-20210907T151855Z-avarab@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 7 Sep 2021 12:29:57 -0400
Message-ID: <CAPig+cSPwd4XviefDUieoKPXQKnONhb5dqPWZ-+NQtS74ottMw@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] tests: add a test mode for SANITIZE=leak, run it
 in CI
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Andrzej Hunt <andrzej@ahunt.org>,
        =?UTF-8?B?TMOpbmHDr2MgSHVhcmQ=?= <lenaic@lhuard.fr>,
        Derrick Stolee <dstolee@microsoft.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 7, 2021 at 11:33 AM Ævar Arnfjörð Bjarmason
<avarab@gmail.com> wrote:
> [...]
> On the topi of "LSAN_OPTIONS": It would be nice to have a mode to
> aggregate all failures in our various scripts, see [2] for a start at
> doing that which sets "log_path" in "LSAN_OPTIONS". I've punted on
> that for now, it can be added later, and that proposed patch is also
> hindered by us wanting to test e.g. test-tool leaks (and by proxy, any
> API leaks they uncover), not just the "common-main.c" entry point.

s/topi/topic/
