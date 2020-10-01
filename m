Return-Path: <SRS0=yenB=DI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 056B1C4741F
	for <git@archiver.kernel.org>; Thu,  1 Oct 2020 03:46:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C34CF21D46
	for <git@archiver.kernel.org>; Thu,  1 Oct 2020 03:46:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kr4Jwqet"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730537AbgJADqZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Sep 2020 23:46:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730415AbgJADqY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Sep 2020 23:46:24 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C5CAC0613D2
        for <git@vger.kernel.org>; Wed, 30 Sep 2020 20:46:24 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id q9so1445943wmj.2
        for <git@vger.kernel.org>; Wed, 30 Sep 2020 20:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=vQqBZ6n4yoJvFdWDcAg0rtHyyez4I2x9VidEL47I2n4=;
        b=Kr4JwqetAlYtgVWFanZqv9EpNUc97EhDNzjVXhKAHCkOlto23JJKZF8ygTOhf+8NQ7
         aH/hGZB0BxGK8Axu/KyzwuGotAVAJHBYUFted64liC1FYBHYugadi9+U5ypy0IjDKvUV
         SBsr5hRRdRfCE0xnIzq9RaAYubSSIMKQqpw1UEaaeor0bxjVEWqNaw0vpFMtEkdu5Yqc
         uGpUIwhr5iC/3XmX0sfIQitbjEBjOcDNRHB4IVsimSjpDjzMo6kL/Sf/8TSmO+lfQ66F
         rvoHTXB/1VHqFPsGrqvO1MJCr85TcEHKaL5iNGsJf14jLSybuCuynPTK7bf6/h2kbVcf
         ownA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=vQqBZ6n4yoJvFdWDcAg0rtHyyez4I2x9VidEL47I2n4=;
        b=ZctP1VYdzNJ3/0+QyeI+228K2Pj6KrSugliHNmnhQckbft++Ymd616ANLQZ6+H/6SY
         P+EFuVkKNtC1Xl8wQUVG7aK8pKTd1Qi7NMTb0YAiMczYUSsL8gdrXuWqsAjr/Dm7DnJT
         ZuEgg1ZWLTyahfePcvzYBBJAmhQZcJ31ZhmUvtplROi1GrcoyLrMQnBnntOSm2qZMeJw
         MZyWDjkN+gJxsS2EIfZBXmGTSkdIyNxaWol7aix6cpfXU2YF10++0x32tP4MM8fo6njV
         +ZK6jOIMoi6pzCef6HFz/y3O6bSZ5f/erLTGnZpPCBuij7XRfVZMHot7Zf0FYlvSDkWH
         7Fbg==
X-Gm-Message-State: AOAM533a2Il0vQipeUwgF4BZn+KAhDNKKlz+sg5JvD2GA8SbbGXPX0Zd
        E5ZeZjC8fqsFj3SqC+9R6Hm+VsDV6H8=
X-Google-Smtp-Source: ABdhPJzx07zChtSLHvKBf00c0/MHyp+pEOyMG6s9qeaAf/OIABYF4zq5dfMjF7ApHeap50u03OzPYw==
X-Received: by 2002:a05:600c:216:: with SMTP id 22mr5790426wmi.149.1601523982627;
        Wed, 30 Sep 2020 20:46:22 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h76sm6949272wme.10.2020.09.30.20.46.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2020 20:46:22 -0700 (PDT)
Message-Id: <e1d3b54fdc6a2dbf10eb1fc75e41b9dc233a5383.1601523977.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.727.v3.git.1601523977.gitgitgadget@gmail.com>
References: <pull.727.v2.git.1601350615.gitgitgadget@gmail.com>
        <pull.727.v3.git.1601523977.gitgitgadget@gmail.com>
From:   "Sean Barag via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 01 Oct 2020 03:46:14 +0000
Subject: [PATCH v3 5/7] clone: validate --origin option before use
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Derrick Stolee <stolee@gmail.com>, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Taylor Blau <me@ttaylorr.com>, Sean Barag <sean@barag.org>,
        Andrei Rybak <rybak.a.v@gmail.com>,
        Sean Barag <sean@barag.org>, Sean Barag <sean@barag.org>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Sean Barag <sean@barag.org>

Providing a bad origin name to `git clone` currently reports an
'invalid refspec' error instead of a more explicit message explaining
that the `--origin` option was malformed.  This behavior dates back to
since 8434c2f1 (Build in clone, 2008-04-27).  Reintroduce
validation for the provided `--origin` option, but notably _don't_
include a multi-level check (e.g. "foo/bar") that was present in the
original `git-clone.sh`.  `git remote` allows multi-level remote names
since at least 46220ca100 (remote.c: Fix overtight refspec validation,
2008-03-20), so that appears to be the desired behavior.

Helped-by: Junio C Hamano <gitster@pobox.com>
Helped-by: Derrick Stolee <stolee@gmail.com>
Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Sean Barag <sean@barag.org>
---
 builtin/clone.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/builtin/clone.c b/builtin/clone.c
index a76dacd988..bd67ff7b01 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -1011,6 +1011,9 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	if (!option_origin)
 		option_origin = "origin";
 
+	if (!valid_remote_name(option_origin))
+		die(_("'%s' is not a valid remote name"), option_origin);
+
 	repo_name = argv[0];
 
 	path = get_repo_path(repo_name, &is_bundle);
-- 
gitgitgadget

