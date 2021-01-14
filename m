Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90D2EC433E6
	for <git@archiver.kernel.org>; Thu, 14 Jan 2021 15:51:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E11223B2F
	for <git@archiver.kernel.org>; Thu, 14 Jan 2021 15:51:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729296AbhANPvL (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Jan 2021 10:51:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728328AbhANPvH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Jan 2021 10:51:07 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56261C0613D6
        for <git@vger.kernel.org>; Thu, 14 Jan 2021 07:50:27 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id w5so6259149wrm.11
        for <git@vger.kernel.org>; Thu, 14 Jan 2021 07:50:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=a+D/CZ7XXFSxfeWueHbUR9vG7dA0FCe8Pkqw/DzaESM=;
        b=QMNPZH1bqjtS7y5y+9G3HGRwPm92jh5h97CLTXycpLuCtKtiVrVAggysS0rC/kAw1m
         uxQN60qgbeQvV8G6MqFTXcy8Gwspn/kZWrPcwGlvQQ8u7Es4735C9IaEmH0wdMwT9HY9
         lsETfwmEh+LH4NugGp6fhcscsDRJvQmrh3V8Hrw9SK4o+eNSdGIBkUVhxOLgcMXHrwYS
         b4AwwFcpRCZxtbrswyPAPeDooUh09RUom/Z1vdk0lK4ImBGqI0iM38+iEZw0GRElutDq
         R1xARw0InRdWNW1jxrvUOUBIjq5OWNOfEK6jtdc2n8yBiyhEfv/3kPlx+iZpEGb+f95E
         WgUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=a+D/CZ7XXFSxfeWueHbUR9vG7dA0FCe8Pkqw/DzaESM=;
        b=hLsJ9yPghgKspADkaINvoZJu7nsZjQ2iqwCgL71sm/wgZiXk0Ca+Izc+Hi0Fecc20C
         f8M0PQP6OWmGV6bUOn5qjKTgCT4eRWM5q8bS74WqkSYKl9g0017BKqGjLVBDyVeHWnJl
         V7BNpbyaC9ulmMwYZHfP0FPk7QyREPuonUzq6IMZ3JO+PT+66qw0w2VrkBOh3qZVXdCZ
         TuQ9H+mTDT6Ewf7AixkTSoreYvBbwin2meLcxiXmIsPq9PUSiyy2PVGAL2tXCeg6HJLG
         fYJWB0bDmJpD7AC7Z8mz03Zv0lFJp1GVQARimC0mYIoGM8QQ2+Zl/rJ6ccVMGhb0C+U7
         oKGw==
X-Gm-Message-State: AOAM532UTwDcaT7lL8sMkpLsNgEmRgPupVLhYL4RVq2imkdWyGa3hqFe
        q3HB5/ehhd05Dt9XtYqs4gMmQsGwvyZRyw==
X-Google-Smtp-Source: ABdhPJxSZfy+OZVoManpUTQgyIo1O8d6E1/gE46lh4b8Rbdlf+KNahoQHTVLFPhJD982uJz0HVg9+w==
X-Received: by 2002:a05:6000:1788:: with SMTP id e8mr4891006wrg.171.1610639425931;
        Thu, 14 Jan 2021 07:50:25 -0800 (PST)
Received: from localhost.localdomain ([185.228.231.221])
        by smtp.gmail.com with ESMTPSA id q7sm10170489wrx.62.2021.01.14.07.50.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jan 2021 07:50:25 -0800 (PST)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>
Subject: [PATCH v2 3/3] pack-write: die on error in write_promisor_file()
Date:   Thu, 14 Jan 2021 16:50:16 +0100
Message-Id: <20210114155016.3005932-4-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.30.0.83.g36fd80b35a.dirty
In-Reply-To: <20210114155016.3005932-1-chriscool@tuxfamily.org>
References: <20210114155016.3005932-1-chriscool@tuxfamily.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

write_promisor_file() already uses xfopen(), so it would die
if the file cannot be opened for writing. To be consistent
with this behavior and not overlook issues, let's also die if
there are errors when we are actually writing to the file.

Suggested-by: Jeff King <peff@peff.net>
Suggested-by: Taylor Blau <me@ttaylorr.com>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 pack-write.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/pack-write.c b/pack-write.c
index db3ff9980f..e9bb3fd949 100644
--- a/pack-write.c
+++ b/pack-write.c
@@ -371,11 +371,15 @@ void finish_tmp_packfile(struct strbuf *name_buffer,
 
 void write_promisor_file(const char *promisor_name, struct ref **sought, int nr_sought)
 {
-	int i;
+	int i, err;
 	FILE *output = xfopen(promisor_name, "w");
 
 	for (i = 0; i < nr_sought; i++)
 		fprintf(output, "%s %s\n", oid_to_hex(&sought[i]->old_oid),
 			sought[i]->name);
-	fclose(output);
+
+	err = ferror(output);
+	err |= fclose(output);
+	if (err)
+		die(_("could not write '%s' promisor file"), promisor_name);
 }
-- 
2.30.0.83.g36fd80b35a.dirty

