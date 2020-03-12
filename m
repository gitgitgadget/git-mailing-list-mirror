Return-Path: <SRS0=YYoh=45=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BA85C1975A
	for <git@archiver.kernel.org>; Thu, 12 Mar 2020 17:10:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D047A206F1
	for <git@archiver.kernel.org>; Thu, 12 Mar 2020 17:10:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VEz+CazG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726526AbgCLRKP (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Mar 2020 13:10:15 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38701 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726464AbgCLRKP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Mar 2020 13:10:15 -0400
Received: by mail-wm1-f65.google.com with SMTP id t13so840384wmi.3
        for <git@vger.kernel.org>; Thu, 12 Mar 2020 10:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9GBnKL8VQGIyVS9jdwxsv0Pj7oTt9d2vYIPkbs/VG0E=;
        b=VEz+CazGgwm2ZnmPKe6edcy5wybqomwrfqbx1v4ampXn2YoaHiACQC7BCxMD79Jol9
         2beMj9pAi9ZpD4LSWVFtRiWcrzMWoeopQci8gGZFGaG+FP+KVj5Rfl4QprNCKcMSe2qx
         3XEJrb1tv03tJnK52YsCise0hU9sItzkTKk59S7aIP+Ka9DRhzINrQiRzn646uSbamjL
         bHdrGJsUIqYQ505cM/XUnoklqTSFYTe7P8bMy9LNi6MwupBbhAdHnOhVRNMk2m5H7Jm+
         PNmyAV83g7eoxa4OdGVf34plJqzkyG02+63bzex8VTyXrrvRIex1LQLQ76JDBcICzNp3
         9Z1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9GBnKL8VQGIyVS9jdwxsv0Pj7oTt9d2vYIPkbs/VG0E=;
        b=lfMaaPJwlf49xsw3TSxPje0LbzCOeVP5Dazv03LtF9HrBCLgXfAzjD+1bRVQJ4ej/E
         LCFVMfZca/ooOlGsJtg03ZdPFQGSnudcankcfy2SHYaTX7ivPWGI3WHFC4KEMC2f3ymf
         NNcELdQ5ppTSCOsp1Ukqu1XA7VIgK+W3sdswW9+rKg/On8Tx9zTiqFi6eGHF12gKbz5f
         fCFAUJZO42fSJn3HuJSpFi2iUHwoLos8KpcsBru1xJCzQzv4/280/g8+rEz5R+6KRG0t
         a4E+fl7sUqaphXTcz/0sbs71YrKbj58kKA4kKny3FUXXWyVHQ3ctoCzdvPs7jFiRnjN8
         0Czw==
X-Gm-Message-State: ANhLgQ253xQCSDwtqEVK7EhdA1c4tLLFxHWgNxoyKC1YFvdqH9q+XXMm
        V97C8sox8RU0v3Kotka9qX8=
X-Google-Smtp-Source: ADFU+vulkShXan4cCWU8fyYL3aWpC9+VCq/8m3wDjfjyi/yA/1eBjtZjEPy8Dd+7PSTOlYjtj6zQZg==
X-Received: by 2002:a1c:e341:: with SMTP id a62mr6068631wmh.121.1584033013890;
        Thu, 12 Mar 2020 10:10:13 -0700 (PDT)
Received: from localhost.localdomain (87-231-246-247.rev.numericable.fr. [87.231.246.247])
        by smtp.gmail.com with ESMTPSA id r12sm21593430wrx.26.2020.03.12.10.10.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2020 10:10:13 -0700 (PDT)
From:   Damien Robert <damien.olivier.robert@gmail.com>
X-Google-Original-From: Damien Robert <damien.olivier.robert+git@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Cc:     Damien Robert <damien.olivier.robert+git@gmail.com>
Subject: [PATCH v2 1/3] pack-objects: change the name of add_objects_in_unpacked_packs
Date:   Thu, 12 Mar 2020 18:09:29 +0100
Message-Id: <20200312170931.2392490-2-damien.olivier.robert+git@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200312170931.2392490-1-damien.olivier.robert+git@gmail.com>
References: <20200228154357.1710521-2-damien.olivier.robert+git@gmail.com>
 <20200312170931.2392490-1-damien.olivier.robert+git@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

`add_objects_in_unpacked_packs` was added in commit
08cdfb13374f31b0c1c47444f55042e7b72c3190 (Sep 2007) to handle the
`--keep-unreachable` option.

Back then this function would iterate through packs associated to a list
of revs, and add all objects that was not already in the object list,
hence the name.

Now the function simply iterate through all packs (more precisely all
local packs not marked as .keep), and add all objects not already in the
object list.

So rename the function to add_unreachable_packed_objects, to mimic the
naming of add_unreachable_loose_objects.

Signed-off-by: Damien Robert <damien.olivier.robert+git@gmail.com>
---
 builtin/pack-objects.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 02aa6ee480..7c563d636c 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -3033,7 +3033,7 @@ static int ofscmp(const void *a_, const void *b_)
 		return oidcmp(&a->object->oid, &b->object->oid);
 }
 
-static void add_objects_in_unpacked_packs(void)
+static void add_unreachable_packed_objects(void)
 {
 	struct packed_git *p;
 	struct in_pack in_pack;
@@ -3293,7 +3293,7 @@ static void get_object_list(int ac, const char **av)
 	}
 
 	if (keep_unreachable)
-		add_objects_in_unpacked_packs();
+		add_unreachable_packed_objects();
 	if (pack_loose_unreachable)
 		add_unreachable_loose_objects();
 	if (unpack_unreachable)
-- 
Patched on top of v2.26.0-rc1-6-ga56d361f66 (git version 2.25.1)

