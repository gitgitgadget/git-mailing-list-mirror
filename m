Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9D0601F463
	for <e@80x24.org>; Fri, 13 Sep 2019 13:03:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388218AbfIMNC7 (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Sep 2019 09:02:59 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:45975 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388206AbfIMNC6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Sep 2019 09:02:58 -0400
Received: by mail-ed1-f68.google.com with SMTP id f19so26938871eds.12
        for <git@vger.kernel.org>; Fri, 13 Sep 2019 06:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ES7lEP9eyIvOOHzZKKec59nJYdx78UblLRKgS/tqyUg=;
        b=Jeht5qBqsRFOi6TlzG4feicPJ2dfQ+wyP/pKSIoKJMm056+gbmwDmBvOG63rOOUgTG
         PVwKlcjWeonCk9D3XNlZ7MXxtcixoBFFW1j8j4HUcgy0XnpJ1aUFoFWgJA+re2zsoxiV
         J6o0iQGmQTu63RCPpeb7IYoRcpNE+IpK2w1kP46sJe+okqvA5jMckl2RIyy/2H8vB/Tn
         iQn22RdPMyqz228cjlRVG86bZFy2CBljtkmSwcfZc8hIlhYeuhITfz3T10lSk8tBoMhR
         icHJuvaxQXjDVFIEh2E9nB045MnOwG/h65Sozoqax+0xo0OqM3MJQ/9F2UM15um1cYBo
         DRZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ES7lEP9eyIvOOHzZKKec59nJYdx78UblLRKgS/tqyUg=;
        b=Zh8odMFXk9UJ9KjCItLGwr8Fg9sMgOz1SUQgu6AiXZEg1MQk136xh/xqf+HZtqsrww
         Dc4pH68a3+3sByruoI2U9scw6/ZH7wHehMFYPmw13BJv4adYXuYXSiYlSO9mAx7v4B0m
         pnDB/f4OtGaULhDV6vBnM+T0ZKXYI0pJ9BD2n5xpNcEaxYIxt+lzN0sBhdUOUHKIwEZP
         o5/5nbmSUpohNjJbSlheLfoxc7UlYyGdBqP1R9l4Q88eSd1lh8dJHZ9VqqqAIGGPYnpt
         9geGdJTlEJWW4RnfgjdlPDF0ymGUc18jZ+MNQXZS7HLh7YBB3uCNLFUAjHbvSeH1NuSw
         O8Yw==
X-Gm-Message-State: APjAAAVp3HkCjtPzhXRRSVSW62lKd/rCGvdVxQCOrFYRpPh/lIaFluOA
        kgBfvFtvu2hlumIctQHKjcquscTH
X-Google-Smtp-Source: APXvYqyOa2BlO2NLpAMTPninmGmuaRXJESu6Rh89sO+tYoS8sdQx/xAphyN0My7nC1A6lbhMtAyAfQ==
X-Received: by 2002:aa7:dc59:: with SMTP id g25mr48119944edu.183.1568379776468;
        Fri, 13 Sep 2019 06:02:56 -0700 (PDT)
Received: from ubuntu-N150ZU.booking.pcln.com (access-114.38.rev.fr.colt.net. [213.41.38.114])
        by smtp.gmail.com with ESMTPSA id c14sm2846570ejx.31.2019.09.13.06.02.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2019 06:02:55 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [RFC PATCH 09/10] builtin/pack-objects: introduce obj_is_packed()
Date:   Fri, 13 Sep 2019 15:02:25 +0200
Message-Id: <20190913130226.7449-10-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.23.0.46.gd213b4aca1.dirty
In-Reply-To: <20190913130226.7449-1-chriscool@tuxfamily.org>
References: <20190913130226.7449-1-chriscool@tuxfamily.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff King <peff@peff.net>

Let's refactor the way we check if an object is packed by
introducing obj_is_packed(). This function is now a simple
wrapper around packlist_find(), but it will evolve in a
following commit.

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/pack-objects.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 1664969c97..5ee0b3092d 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -2569,6 +2569,11 @@ static void ll_find_deltas(struct object_entry **list, unsigned list_size,
 	free(p);
 }
 
+static int obj_is_packed(const struct object_id *oid)
+{
+	return !!packlist_find(&to_pack, oid, NULL);
+}
+
 static void add_tag_chain(const struct object_id *oid)
 {
 	struct tag *tag;
@@ -2580,7 +2585,7 @@ static void add_tag_chain(const struct object_id *oid)
 	 * it was included via bitmaps, we would not have parsed it
 	 * previously).
 	 */
-	if (packlist_find(&to_pack, oid, NULL))
+	if (obj_is_packed(oid))
 		return;
 
 	tag = lookup_tag(the_repository, oid);
@@ -2604,7 +2609,7 @@ static int add_ref_tag(const char *path, const struct object_id *oid, int flag,
 
 	if (starts_with(path, "refs/tags/") && /* is a tag? */
 	    !peel_ref(path, &peeled)    && /* peelable? */
-	    packlist_find(&to_pack, &peeled, NULL))      /* object packed? */
+	    obj_is_packed(&peeled)) /* object packed? */
 		add_tag_chain(oid);
 	return 0;
 }
-- 
2.23.0.46.gd213b4aca1.dirty

