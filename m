Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C58E7C433F5
	for <git@archiver.kernel.org>; Thu, 16 Sep 2021 08:55:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF03961164
	for <git@archiver.kernel.org>; Thu, 16 Sep 2021 08:55:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235270AbhIPI47 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Sep 2021 04:56:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233839AbhIPI47 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Sep 2021 04:56:59 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03172C061574
        for <git@vger.kernel.org>; Thu, 16 Sep 2021 01:55:39 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id cf2so3647615qvb.10
        for <git@vger.kernel.org>; Thu, 16 Sep 2021 01:55:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KxxVZYp2LzVtWFOK0UCt1dYcO+V8IIOaol7faK7J3R0=;
        b=iKGO5+GbFJlgL7tHmwoxVrpxabkjtYVyWAxkflTfvryWSFAqlvqHt8ShhTQtuhDKSA
         +iUS/BiO03Ba9USdkkeJ8lhx7LomRC8Fv+8vnB0eh01TOBatf76t79x2z6AY1wE/t+0L
         zu79/8bBX29zA4Zoc/kmhANY3HmF9sjjBhsi0YGYWLkoujqfdeYuVR2skQ2v4e3BN3WS
         Z+bn0faLN356LkNYxrgAaSs5Jxg13SnL9xRnPhVKscvBnUtR+F21YQ8Hw492AijxHzzk
         kmRYHDvrT2fzPx1qLcv+k/3inOPYX0bBBuMrNuy2GKJP1/9zgFbjL0+nGrHrrC2RP9SP
         K8Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KxxVZYp2LzVtWFOK0UCt1dYcO+V8IIOaol7faK7J3R0=;
        b=rk673j++Gy9F+j6ILzdrQ5uqyqRurNGXZwemB38+lsib9p6W2qNFIBjuTNeXk65Pwc
         dqjgBwlpbitEklCzvUvWAH1++WxD1v7akl016ar8s0nw0cxv79d0k7KtCT1GXSo/EGvZ
         u0snpKsCfcag/yivQPhLKDnr+t0TQ3eU1XGPY1A9P3kaPMEZMOxiQAhAGh753xNnafPw
         x3zVbxNCiJQD8t8Q13QrHOojV577kVEhL5zWG0qnfiuFXSsIrVYlPTXdCaWJJPvFbG+q
         69mJiy2tsByometweTs8FR92Jk/0+D6PWBjudKBwpiR+0zwzGxeGQ3nKnRB32QW6XzbB
         EBwQ==
X-Gm-Message-State: AOAM530NWtF9VYzXnMc4ikcYx1z/z36X8/Q6AceU+4BYyHuVazdmRtDi
        YhJN9pW02elyHDw3fvwsunc3rt1cPcQ=
X-Google-Smtp-Source: ABdhPJwQZvRSxMm3sd/HJ82jwlI6EwACwhDhoESbgXhPk3BFa575KwDHzM9L2CLXAmF/+8/GITVERA==
X-Received: by 2002:a05:6214:1394:: with SMTP id g20mr4134748qvz.21.1631782537917;
        Thu, 16 Sep 2021 01:55:37 -0700 (PDT)
Received: from carlos-mbp.lan (104-1-92-200.lightspeed.sntcca.sbcglobal.net. [104.1.92.200])
        by smtp.gmail.com with ESMTPSA id e22sm1663868qtm.10.2021.09.16.01.55.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Sep 2021 01:55:37 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     me@ttaylorr.com, gitster@pobox.com,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: [PATCH v2 0/2] reroll for cb/plug-leaks-in-alloca-emu-users
Date:   Thu, 16 Sep 2021 01:55:21 -0700
Message-Id: <20210916085523.68581-1-carenas@gmail.com>
X-Mailer: git-send-email 2.33.0.481.g26d3bed244
In-Reply-To: <20210916023706.55760-1-carenas@gmail.com>
References: <20210916023706.55760-1-carenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

While looking at the leaks reported by our new CI job, noticed there
was a hidden one when running t0000 in macOS.

The first one fixes the leak and the second one the reason why it was
silent.

v2 includes all suggestions and feedback, and tries probably too hard
to modify the last test in a way that wouldn't require long lines.

Carlo Marcelo Arenas Belón (2):
  tree-diff: fix leak when not HAVE_ALLOCA_H
  t0000: avoid masking git exit value through pipes

 t/t0000-basic.sh | 23 ++++++++++++-----------
 tree-diff.c      |  4 +++-
 2 files changed, 15 insertions(+), 12 deletions(-)

-- 
2.33.0.481.g26d3bed244

