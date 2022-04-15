Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05B78C433F5
	for <git@archiver.kernel.org>; Fri, 15 Apr 2022 23:14:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352424AbiDOXQh (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Apr 2022 19:16:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230460AbiDOXQf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Apr 2022 19:16:35 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 556E25EDC7
        for <git@vger.kernel.org>; Fri, 15 Apr 2022 16:14:05 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id r85so4356220oie.7
        for <git@vger.kernel.org>; Fri, 15 Apr 2022 16:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=O2wGTw8XD8uVBBu+VOoNNUb7kpbk3TYdK4ayWiscQZc=;
        b=LPmyFjNRSpGQbZwh8wHfOFc94ZTuua/CE7S3Al3is/4zm+8fwmz+ce4GA650ECcHPd
         yuR27e7q4bl4ccJIgrCvXDLY4C4/6KNlA648f9HXKiz7fRTWohanfPibh580VJH7zUzW
         Ev2MS3yj3nKmmDU020pKV/Gemvn9meh2l3CKkdPCInitzehVorjfYIRQhLItJNO2ywcj
         nqxb2qjJaMytshFHQl0sjKKHS/Niofmi0l36s42ZhnDsu5mayy3QWOcdU5x3KRSOORWg
         sktRysVLUAoIFD94Bcr/L7nxA0JhbQY3pnxJ4T6WO3We2XRW4CL+YOGCSyyx8EXJ7Gut
         RO7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=O2wGTw8XD8uVBBu+VOoNNUb7kpbk3TYdK4ayWiscQZc=;
        b=CoSa9gwHnBxdRvQm8CHzxsoJkx3tslgHmCLkB+sC/ap/TsOb0RHFUtf51mIZX7e7q5
         O+5Bff4t5X9YZ6CddlvSJjY5eoGcjTojtE52Njew1Ev6tEl8DOTAKD5S8UTRQK1aR5Qi
         aqT8FWDnrzCzl2CwgWrytTN0OU5XZJ4xm0T7lDDY2zLf28tFxipn0WKfgE7WDq8ZIFsN
         yxurjUsgzDV1PfmgOaZ+b8lF6+5+5CKFQejwjh6sO6UKMmosa2+mvcT4CpVADJRITr3X
         8AHoMKRKDPnRYPC4eisuYu0xv2+mj6NFOtAVOzkQbYV3YfIYC7CrlmSB/y6+SCnOrepa
         uYQg==
X-Gm-Message-State: AOAM533iGPfyn5xa4sZw36AZrGQ5uUwCmip8FCB2wUHjEwJdIRu+ugkP
        Dq63ESw/SG0hq6JPpbeMbHAYH71ANY4=
X-Google-Smtp-Source: ABdhPJxs+IoLjqJxMAaIINMPggqsoHSVe8K43jqfJ1owBaYbhGvElceA+Zz+IghAj94i8TEqayZQRg==
X-Received: by 2002:a05:6808:3009:b0:2f9:6119:d676 with SMTP id ay9-20020a056808300900b002f96119d676mr472338oib.205.1650064444482;
        Fri, 15 Apr 2022 16:14:04 -0700 (PDT)
Received: from carlos-mbp.lan (104-1-92-200.lightspeed.sntcca.sbcglobal.net. [104.1.92.200])
        by smtp.gmail.com with ESMTPSA id l14-20020a4ac60e000000b0032993003287sm1584720ooq.38.2022.04.15.16.14.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Apr 2022 16:14:04 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, phillip.wood@talktalk.net, avarab@gmail.com,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: [PATCH 0/2] ci: avoid failures for pedantic job with fedora 36
Date:   Fri, 15 Apr 2022 16:13:40 -0700
Message-Id: <20220415231342.35980-1-carenas@gmail.com>
X-Mailer: git-send-email 2.36.0.rc2.283.gbef64175c85
In-Reply-To: <20220415123922.30926-1-carenas@gmail.com>
References: <20220415123922.30926-1-carenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series makes a hopeful safe attempt to workaround issues that will
affect the pedantic CI job after Fedora 36 gets released, and that could
be alternatively handled by locking that job to keep using Fedora 35
until all issues with gcc 12 (which is used as the system compiler) are
addressed.

Carlo Marcelo Arenas Belón (2):
  config.mak.dev: workaround gcc 12 bug affecting "pedantic" CI job
  config.mak.dev: alternative workaround to gcc 12 warning in http.c

 config.mak.dev | 6 ++++++
 1 file changed, 6 insertions(+)

-- 
2.36.0.rc2.283.gbef64175c85

