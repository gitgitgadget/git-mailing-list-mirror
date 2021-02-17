Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21C2FC433E0
	for <git@archiver.kernel.org>; Wed, 17 Feb 2021 19:45:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5D6864DF0
	for <git@archiver.kernel.org>; Wed, 17 Feb 2021 19:45:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233991AbhBQTpH (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Feb 2021 14:45:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233874AbhBQTol (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Feb 2021 14:44:41 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27E65C061793
        for <git@vger.kernel.org>; Wed, 17 Feb 2021 11:43:11 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id n13so17742785ejx.12
        for <git@vger.kernel.org>; Wed, 17 Feb 2021 11:43:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6G52t8Rfu7Wdt6m5/mgN4vZp9G3xuh+VHhZbl9A7XQY=;
        b=eMKBbta8Dy4ljqZsICMMvveOGQRdZMNsqEBCwYwuHYpyIVypam4smI+FKI9ChrR1MJ
         0u+v6NdjJj7JmI+twb0MzPWVcaZGfdPUe/PE3as6/B5MbBxujOAXCt0vOO3E/oy9DT55
         7B4eY+cO63pvZdsguVZb/NpFGBLPnRpv5Bpw9ZHHFo2qRu+w8hdCO5iBYaUH6/NSX7oN
         6Y/vrp5sM9H4wBm3VF7mijZPaktucOU7xsb28tttg+S7n9vD0mMn9SwWwAHj5ZG/6+Vn
         gLgsGSj3l/p8a0OM/xgS7hna7PQrMDmv+6hXzAm+SAxP0EL/Psp8+iv9ZwQq/HbSHFQY
         a0xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6G52t8Rfu7Wdt6m5/mgN4vZp9G3xuh+VHhZbl9A7XQY=;
        b=UlJ+6BwCZ3InVFx+IhRxXVxZJ6T6N/c3S5Io/wgJZ3Nx1SOOnhe10K4USsKhZvIDPT
         terLbyHib6kHQmmj6fJFU1xoAWqVJdgmsQLquknyKbpHP1xjc+nzXc+xc2oIV03FWcz7
         CHEsk9musxoLccsK3e3htKaKejFUQ7ZSf8SHFfyOWmZznZVvjb3IqybAfdvcGiO1RkNz
         9J+5xYY8HiuR3INk17tFyhxBQXNlwNTClf8TrDVMiqx7Vw86/mnotkq73xz7FSwRhUf2
         vNyYWXKbqsTqGUeYhqQCrtX2geaXubZIHyFOEZzGFtxPynfHvqI1Vtx+jNkZzloDDs/h
         wiAA==
X-Gm-Message-State: AOAM533sLMQlvDCmrHYbQvyxJuBl4LrQGTXiqTRhjXNxhNnZOkrEFxil
        sYMqA6NqVY5MY4YvZ2WELb2rHboDDWLpmw==
X-Google-Smtp-Source: ABdhPJybiYOrSsLYk8IH96Oz7EDOt+2l9VJk2LTLzDBsiHjI3FOGVbvsuSoornipfcQPrzB+oFBZug==
X-Received: by 2002:a17:906:b6cc:: with SMTP id ec12mr539731ejb.520.1613590989660;
        Wed, 17 Feb 2021 11:43:09 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o10sm1479706eju.89.2021.02.17.11.43.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Feb 2021 11:43:09 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 08/14] fsck.c: undefine temporary STR macro after use
Date:   Wed, 17 Feb 2021 20:42:40 +0100
Message-Id: <20210217194246.25342-9-avarab@gmail.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7
In-Reply-To: <87blcja2ha.fsf@evledraar.gmail.com>
References: <87blcja2ha.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In f417eed8cde (fsck: provide a function to parse fsck message IDs,
2015-06-22) the "STR" macro was introduced, but that short macro name
was not undefined after use as was done earlier in the same series for
the MSG_ID macro in c99ba492f1c (fsck: introduce identifiers for fsck
messages, 2015-06-22).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 fsck.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fsck.c b/fsck.c
index 7c53080ad48..88884e91c89 100644
--- a/fsck.c
+++ b/fsck.c
@@ -100,6 +100,7 @@ static struct {
 	{ NULL, NULL, NULL, -1 }
 };
 #undef MSG_ID
+#undef STR
 
 static void prepare_msg_ids(void)
 {
-- 
2.30.0.284.gd98b1dd5eaa7

