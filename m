Return-Path: <SRS0=Z/Vr=2I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E539C43603
	for <git@archiver.kernel.org>; Wed, 18 Dec 2019 11:26:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24BBA21D7D
	for <git@archiver.kernel.org>; Wed, 18 Dec 2019 11:26:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eQsMALcK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726842AbfLRL0K (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Dec 2019 06:26:10 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40113 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725930AbfLRL0J (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Dec 2019 06:26:09 -0500
Received: by mail-wm1-f68.google.com with SMTP id t14so1472264wmi.5
        for <git@vger.kernel.org>; Wed, 18 Dec 2019 03:26:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sNKzsfCZv+59wRMREPLBIM/8tQ5sQr8zX7izXDKn/SA=;
        b=eQsMALcK/dRQLorbjSjDRyx6N+6NqletazGega37VISC9YV3WVb/hGyovVrykbPqJ0
         m/Bek/YpfaU8/C0f+H0T8pZbX5BdF5wbPNwxZcEwhwrWEjtGUP2IhaIrLdCQHDkp0DFN
         nOB6wW1ATWSrhLpTUdlHp3hK4SAkDYZzaS8v3hboC2UBLEp/w2DmBenjItOi/66qR135
         7mqM/yzIcR7trnuqLqlM9zwpCxDAlfqtGHG9X20HGg5Gqv5e5QFPdfvSo0vZjDDTPsxH
         kX2us09MjEzQBf2R8IUa0VKWqpff4Mg476pXfTJy7Kj5Nn8EPubKj2wbDAKrjhEiFcvj
         sGog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sNKzsfCZv+59wRMREPLBIM/8tQ5sQr8zX7izXDKn/SA=;
        b=nVuuJe0VpDzzaCl9zjhHsEq93o3REGgpn2Nm9S0S7HvDxv3v8nvh5wvYqXOtww9PHK
         x+S9FBVkpONFmdivc2Ws2fcN12wYPkrux8QLkN7ZKtHdY5EzJ1ce9dUFf0E1fo5Qf51a
         lhBm3rceS+L4QHc0j2Vcq9Af+doqwKqtu9OTE3vOuPs2QzN96NkC58hLBXUb/2sYutQ/
         8Y4kH0DTzdugYq66ycPWsKzRNBzn9nj+EInX0OmepZKYRM8WMOWe+5/MIqgDciQWyPUK
         2v7IdKTstef2M7HHQFoqdDj0ivdjlnQIQh8QUaFw99qolsZboUuIgstAIDiLZb30haSE
         6oaw==
X-Gm-Message-State: APjAAAWMwbuUcTrEh8Pg+ahV9FHMHdHpkTFHQDYhTpsuatx39no6/q6x
        MeqAa2iCRXiUUjN8sK/d55IpZVFy
X-Google-Smtp-Source: APXvYqxupVZbGsIuOCo8Je4FZpr0JU3/ZNikD4tY3o5HO2wpJgK2Ey5TDjwZf+EQ92dN+9OQmh1HzQ==
X-Received: by 2002:a05:600c:2218:: with SMTP id z24mr2698072wml.50.1576668367431;
        Wed, 18 Dec 2019 03:26:07 -0800 (PST)
Received: from localhost.localdomain ([2a04:cec0:116b:f417:15eb:66f2:c98d:a463])
        by smtp.gmail.com with ESMTPSA id f127sm1204647wma.4.2019.12.18.03.26.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2019 03:26:06 -0800 (PST)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        James Ramsay <james@jramsay.com.au>
Subject: [PATCH v4 01/12] builtin/pack-objects: report reused packfile objects
Date:   Wed, 18 Dec 2019 12:25:36 +0100
Message-Id: <20191218112547.4974-2-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.24.1.498.g561400140f
In-Reply-To: <20191218112547.4974-1-chriscool@tuxfamily.org>
References: <20191218112547.4974-1-chriscool@tuxfamily.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff King <peff@peff.net>

To see when packfile reuse kicks in or not, it is useful to
show reused packfile objects statistics in the output of
upload-pack.

Helped-by: James Ramsay <james@jramsay.com.au>
Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/pack-objects.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 393c20a2d7..369f46fbc5 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -3509,7 +3509,9 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 	if (progress)
 		fprintf_ln(stderr,
 			   _("Total %"PRIu32" (delta %"PRIu32"),"
-			     " reused %"PRIu32" (delta %"PRIu32")"),
-			   written, written_delta, reused, reused_delta);
+			     " reused %"PRIu32" (delta %"PRIu32"),"
+			     " pack-reused %"PRIu32),
+			   written, written_delta, reused, reused_delta,
+			   reuse_packfile_objects);
 	return 0;
 }
-- 
2.24.1.498.g561400140f

