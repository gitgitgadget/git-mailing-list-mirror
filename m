Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3C64D20248
	for <e@80x24.org>; Thu, 11 Apr 2019 17:36:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726944AbfDKRga (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Apr 2019 13:36:30 -0400
Received: from mail-yw1-f73.google.com ([209.85.161.73]:35985 "EHLO
        mail-yw1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726536AbfDKRga (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Apr 2019 13:36:30 -0400
Received: by mail-yw1-f73.google.com with SMTP id j62so5001922ywe.3
        for <git@vger.kernel.org>; Thu, 11 Apr 2019 10:36:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=OBMEx2MUFJs4LnA4+oPMM6ae9gCmGGN9eOE5VQgao8w=;
        b=uYewe63SOvng+0lhrouTeb1CsUJZM5qh6gv8rjJyudzEwPe1SGeeGbeQU039rrcngu
         tgJxSrvyKwmeFSYLE0Uvf1NLc1dtKNcboJ2J953VqeeW6BdHwP6eOn36ynGLwPAijC1N
         UEitNrA5W/LAp5dThWElLWMQE3iTXaHvxREsr6kzbKaKo6oj4QgnY5NgD8SHjqX/GjGp
         o7Jaho6/+OcUE/ipQx/7xzDkYr5ofIgnRF0rQ53S0YuXZVA/4eSxDUI/lqmCMGC4j48G
         1JniaSV+shIHCjfPYv4rm3m5Ry/Nf8W8HcnRPYy5e9pyRMfXAc4NhwbD6FDJLiUNPwUR
         0EUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=OBMEx2MUFJs4LnA4+oPMM6ae9gCmGGN9eOE5VQgao8w=;
        b=rQStv1GzqUyORhLIWKwBQ+AoRcAqVh+QGuv+bL6W/OExKarxc68Xwkokx8umYCuoFK
         D8pBYtvRjugVjs6lcL1QgxbkIq3f/t5BmGZNVKe+Bn7/xznhN4NC/OEbGViLcCY8Y4Hy
         o06aS05Vw9UUcckSr5rBzbyDNurnGRDJcbVZvHwqJ4BQkX8jEi/61n3VtEz3yvWo8I0B
         SoCS3pnlNQupzh7bJyGq5vy/+LyRFzfTXp7SLNt0EsadsO2NTPxEC5jvimegxatfEFoP
         o/88mkmHI3AtM3pgTYlTJNajCDJWVRo2RHu0G4LN/ZenXVhspJbr/VN4NTTccRooWHd1
         0VPA==
X-Gm-Message-State: APjAAAUwZGZvCiCt8BAFYUGVjrafurbGGhZcP4/KAEQccn6d1XYq0UUr
        2jYbE0G5rofmx4TiDnmxIsy8MfEpy5jPbbSCyxfIShSzVgNBiA3SkW1kEaxLceFewKmKExFgMx/
        J5QNWmGNkDLlU9AvxzISCuH85r3lTJRuzKc930cIYrAGIQQLITtwlahckozgeEy4ZPxeKsZBhcC
        M0
X-Google-Smtp-Source: APXvYqzDTRbDvbkql8JjqLwRQi/ZQ+rYg3Oa7kKmsqL6QzEMeGtCjRh3D4PjnxbAUSeZGcliV4sBPJLbU2DiRHv+1hYS
X-Received: by 2002:a25:7d03:: with SMTP id y3mr7402752ybc.67.1555004189572;
 Thu, 11 Apr 2019 10:36:29 -0700 (PDT)
Date:   Thu, 11 Apr 2019 10:36:26 -0700
In-Reply-To: <20190409214420.90898-1-jonathantanmy@google.com>
Message-Id: <20190411173626.61561-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <20190409214420.90898-1-jonathantanmy@google.com>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
Subject: [PATCH v2] pack-objects: write objects packed to trace2
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, pclouds@gmail.com,
        git@jeffhostetler.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is useful when investigating performance of pushes, and other times
when no progress information is written (because the pack is written to
stdout).

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
Thanks, Duy and Jeff for your comments. I've switched to Jeff's
suggestion (trace2_data_intmax), which also sidesteps Duy's concern
about PRIu32 vs %d.

As far as I can tell, with this change, the Git invocation needing to be
traced must be run with GIT_TR2_EVENT instead of GIT_TR2, but that's
fine.
---
 builtin/pack-objects.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index a154fc29f6..3326aeb497 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -964,6 +964,8 @@ static void write_pack_file(void)
 	if (written != nr_result)
 		die(_("wrote %"PRIu32" objects while expecting %"PRIu32),
 		    written, nr_result);
+	trace2_data_intmax("pack-objects", the_repository,
+			   "write_pack_file/wrote", nr_result);
 }
 
 static int no_try_delta(const char *path)
-- 
2.21.0.392.gf8f6787159e-goog

