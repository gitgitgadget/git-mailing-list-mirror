Return-Path: <SRS0=6awY=5X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AACBBC2BB55
	for <git@archiver.kernel.org>; Tue,  7 Apr 2020 14:28:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EAC32078C
	for <git@archiver.kernel.org>; Tue,  7 Apr 2020 14:28:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RDIr+tm3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729152AbgDGO2q (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Apr 2020 10:28:46 -0400
Received: from mail-qv1-f65.google.com ([209.85.219.65]:41058 "EHLO
        mail-qv1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728768AbgDGO2m (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Apr 2020 10:28:42 -0400
Received: by mail-qv1-f65.google.com with SMTP id t4so1875388qvz.8
        for <git@vger.kernel.org>; Tue, 07 Apr 2020 07:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zS0gld0GlFxWR031gLldH2Q+tnEzRcMviULWd6TSjdI=;
        b=RDIr+tm37rwIU1ixrvbp8rjPjnVdRllWzOtz5FMjSsPVTiz/TfvFnau9s4aqgRyhO+
         eBFeZrvzMNvPJjp8k5ej/NB8N5yHbQ68JJ9ika14FqhHQAWx6tWemxg4E8357rtgsfil
         10lBEQf+c93dkwFlgU1A4MDMsPxBQZ53cvAzN3xB4iDHDD+AtlJAosiZf1jEr+sioevU
         FfSIVcjvWjlhhlMxuLqwps0tXEmhVDh3eiVmb39FigXSRpJRVaAY4BrQWsSkCyFhTB/1
         WIJYOy4SoGusET0KVSGbyA8FRTQgTgoBam4gWFpEogm1EVolBtfPrDzYQWSu+7uFlez6
         ib2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zS0gld0GlFxWR031gLldH2Q+tnEzRcMviULWd6TSjdI=;
        b=l2q1v0nlvNAnAcyB0YgyK8DEDw1mVJ8HZcE5DSkeb0h1DC/nQSmZzH0GJNdQMfjxzf
         xBpomq+D4Nadcp0vwP8pCgZ19nHYUVsue7grQwVrdILCeA7NFtteh+v1H/uJnRL+F3RH
         2HKz7mN+9nvxAox/mTfoG5UjCaiyk0mwhI3+2nw+vAdwwpYW4XniYD6vRo09ISHLVLD5
         MkiMH+lD5I977yU01Vqm2CyniLBGbVoHGEieerolYjHeban6XiqB4Bd/yW62krbOw/AG
         kibt9e7aPcL255/AeAFF2yqjpSRIPjGPUdEfRg/LAXMWkOYZjU6gtf+zdp5XnfV6B3+1
         e9Fg==
X-Gm-Message-State: AGi0PuaE+oKqQd9pnSD72BhUh9lFyDjEBv0lBPXJeEb/qiR0t64HExOR
        BS2k5POPeITmxIiwu09HyhhZDC8K
X-Google-Smtp-Source: APiQypKQuEX/O1n83HL+l/P8OhGVgugfmN4O85HKMrR8PKq0xSSbUYdFHLBuGCT1HqF0Hp0z1Kz7yw==
X-Received: by 2002:a0c:c251:: with SMTP id w17mr2363677qvh.95.1586269719873;
        Tue, 07 Apr 2020 07:28:39 -0700 (PDT)
Received: from archbookpro.lan ([199.249.110.29])
        by smtp.gmail.com with ESMTPSA id j6sm17051736qti.25.2020.04.07.07.28.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2020 07:28:39 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Alban Gruin <alban.gruin@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v5 17/22] sequencer: unlink autostash in apply_autostash()
Date:   Tue,  7 Apr 2020 10:28:04 -0400
Message-Id: <129d5d97aefdc5b75046f0b9051c5fe9378f54ac.1586269543.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.26.0.159.g23e2136ad0
In-Reply-To: <cover.1586269542.git.liu.denton@gmail.com>
References: <cover.1585962672.git.liu.denton@gmail.com> <cover.1586269542.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Explicitly remove autostash file in apply_autostash() once it has been
applied successfully.

This is currently a no-op because the only users of this function will unlink
the state (including the autostash file) after this function runs.
However, in the future, we will introduce a user of the function that
does not explicitly remove the state so we do it here.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 sequencer.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sequencer.c b/sequencer.c
index e0b8262521..645bc47ce3 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -3748,6 +3748,7 @@ int apply_autostash(const char *path)
 				  " \"git stash drop\" at any time.\n"));
 	}
 
+	unlink(path);
 	strbuf_release(&stash_oid);
 	return ret;
 }
-- 
2.26.0.159.g23e2136ad0

