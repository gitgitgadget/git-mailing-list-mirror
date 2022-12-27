Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9D9EC46467
	for <git@archiver.kernel.org>; Tue, 27 Dec 2022 18:40:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230220AbiL0Sje (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Dec 2022 13:39:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230424AbiL0SjQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Dec 2022 13:39:16 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 606A065F6
        for <git@vger.kernel.org>; Tue, 27 Dec 2022 10:39:15 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id z8-20020a05600c220800b003d33b0bda11so9279897wml.0
        for <git@vger.kernel.org>; Tue, 27 Dec 2022 10:39:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Agf6xne8B2w7l8yrqBrpL1rLJvMgyB9UnEuhKhmMau4=;
        b=cknH68MErKGHuNBeJ15tnk1uZiLxKbuuZk/XjoPYJ8PTLbYsfvr9lSGZ2imgxfB0hx
         opN7x3fViXa2ATiDqdB0LT+RPKbXRuj1SfzfIcwykl6iIGBQe9AvRmqysLO3Q7fmq0vX
         Qap7Wh85WgGeWT0XfCOZoLUzVKdW/tBk354vrwCrKZDEXHd3te04sDpfzFk3SZ02Dpjy
         pyE5tRUTdqerhdD4bbXNtQwt7gWXbBsfuMDTlkSsLjQpwMsgHNO4OlLDy2GfJxkOOFM7
         0AqszHwh8vbzFNxl1TbjOzoq0zSs6rHFewqDQqhq5bUQVn/jGo09JHMEmXFQraitY+Dy
         OwWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Agf6xne8B2w7l8yrqBrpL1rLJvMgyB9UnEuhKhmMau4=;
        b=ETOPWvuNRGfk0TnWPt5HuvwYetWUk8wIWSr83PcKW7C6uYmoNfujzi520ViHSLZNC8
         vskfCqKb4AwwMhNm9g5b8Tv0KJp0ncdzHnmmHlXDeh6I2y5K1mKi8LnrubGCR9pbjFCO
         eL8/0gM/T1oM8kENPj0J9NUfayRTBKUafpZdtd7gkC+724ksC8HoWxeMCYQ3YV+dFpYq
         vWuDTgyp7dAXTtuTItBkhRHZ9VviEOtVxdPErmeei78KFpHccNlo68qfvgJZt+g6Ojbe
         /kNzy0KO+yDG8/nxXCohLqeLZtNAtw4acydIHuhXWKjRbw/FRAhpECryxpb9RUZr+TbB
         m7fw==
X-Gm-Message-State: AFqh2kr1GFdfV7qW/tbnJ929uhBldcjRG+e7GTTZc8IQm7YKH76vJuv9
        5txI7WNRCW0LJaYO8gbxLlkghRR9Vh4=
X-Google-Smtp-Source: AMrXdXs1YQrMX2LTVDNrUm47OEZYPnHlbmEELTd3HmO4Tomo/8Uwz3v5d3Kv1eY44bSvMgwBIzbnMg==
X-Received: by 2002:a7b:c3c6:0:b0:3d2:3376:6f37 with SMTP id t6-20020a7bc3c6000000b003d233766f37mr15653042wmj.10.1672166353587;
        Tue, 27 Dec 2022 10:39:13 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id q2-20020a1cf302000000b003d1cc0464a2sm18118770wmq.8.2022.12.27.10.39.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Dec 2022 10:39:13 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Hubert Jasudowicz <hubertj@stmcyber.pl>,
        Derrick Stolee <derrickstolee@github.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 0/2] builtin/bundle.c: segfault fix style & error reporting follow-up
Date:   Tue, 27 Dec 2022 19:39:08 +0100
Message-Id: <cover-0.2-00000000000-20221227T183708Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.1106.gf45ba805d1a
In-Reply-To: <xmqq5ydzpwtk.fsf@gitster.g>
References: <xmqq5ydzpwtk.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Dec 25 2022, Junio C Hamano wrote:

> That would actually make the intent much clearer and if the code
> were written to update argc instead of introducing a separate
> varilable, this bug would not have happened.

Here's a couple of general improvements on top of ab/bundle-wo-args,
we should also report to the user that they were missing the <file>
argument, as 2/2 here fixes.

Ævar Arnfjörð Bjarmason (2):
  builtin/bundle.c: remove superfluous "newargc" variable
  bundle <cmd>: have usage_msg_opt() note the missing "<file>"

 builtin/bundle.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

-- 
2.39.0.1106.gf45ba805d1a

