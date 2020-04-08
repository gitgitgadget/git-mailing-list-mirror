Return-Path: <SRS0=ek70=5Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DDD4C2BA16
	for <git@archiver.kernel.org>; Wed,  8 Apr 2020 04:08:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7FA420747
	for <git@archiver.kernel.org>; Wed,  8 Apr 2020 04:08:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p7yWCZoh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726409AbgDHEIO (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Apr 2020 00:08:14 -0400
Received: from mail-pj1-f67.google.com ([209.85.216.67]:55746 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725763AbgDHEIN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Apr 2020 00:08:13 -0400
Received: by mail-pj1-f67.google.com with SMTP id a32so40282pje.5
        for <git@vger.kernel.org>; Tue, 07 Apr 2020 21:08:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eIyCo9hj8X+13VsamV1Mk5QgJwWUw5JtH8oQaQtMLlE=;
        b=p7yWCZohNPoMgM8JmVH3C8+JgfjYNggP1B6+SxiiKsMa/ajFLrSzbUq/Axy3+59uwX
         1X4z9VpDCLBaXbCamMQpH67C0VIYFAJkCWwy5kxEfCV+RgKsuP5Q1C+RSIbjp5hq/XRA
         M8VNYoKhFkzm558MwIGvU/MGiZNOV5rKa/rLwNkf00fjHm098FEpXdKCMAyFCcnrBa+r
         KWdJ8LqAOcpOLYNsl/oFFEphXRu2O7TARlfR+6fDx3QRmMbPJ6l31M9M2cCEPtUGU5lf
         6pT8gU0Gz+4zA65KnT5DxncltwaQiwKaIIKholzkydLCZPNepSaDhru6CNnu+6TkvwKc
         g2fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eIyCo9hj8X+13VsamV1Mk5QgJwWUw5JtH8oQaQtMLlE=;
        b=ESva2UfkbZk/3Snh2gLwp8houQlE20vY2pHK70AZsBo2LzX54zg5edsFStzqyrEESk
         sdtSPxjDeffFPfB3D093q2nGHADIIck//DnoFxeGIoJ5R+sx7DNFHgZdkJ2OEkN09G4B
         ki9iXcs7OnvgJ5hBmpSR/wL31NLUpSG9sUzZsj3zL9HNZkET/XBrn9B5rD3Io3pC64bm
         fGvqXs8EiiwYhyU/DIM3baQKjiToUZ1Fi6S7WrpjrmceafZfRgcyx2Be+DigDZQPTXBZ
         l5IBo7TXaNiv75ewCr5wKAdoF2Nu2vWxRvsVg2FSEHJByLdGXyjqgMxQ6ah4+M+cxwwH
         CKgg==
X-Gm-Message-State: AGi0PuZrphB44F6+DuSmPcJn2gxYwK+cajT7WxTRp4zTDmU8DPD5X0B7
        aXJcgotdzNZrkuLOhjuwLR7ej8OjHGw=
X-Google-Smtp-Source: APiQypLcl5J1ZVYZazpWhIu38TlHc0yfcPApTQX+F2hjGJVZ+CvCvKlljiiKj77rac3OtjKNe+84zA==
X-Received: by 2002:a17:902:ac85:: with SMTP id h5mr5216431plr.76.1586318892732;
        Tue, 07 Apr 2020 21:08:12 -0700 (PDT)
Received: from localhost.localdomain ([2409:4064:2182:8a2e:a277:ba54:a2ce:8862])
        by smtp.gmail.com with ESMTPSA id t23sm2997571pjq.27.2020.04.07.21.08.09
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2020 21:08:11 -0700 (PDT)
From:   Abhishek Kumar <abhishekkumar8222@gmail.com>
To:     git@vger.kernel.org
Subject: [PATCH 1/2] oidmap: make oidmap_free independent of struct layout
Date:   Wed,  8 Apr 2020 09:36:58 +0530
Message-Id: <20200408040659.14511-1-abhishekkumar8222@gmail.com>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

c8e424c introduced hashmap_free_entries, which can free any struct
pointer, regardless of the hashmap_entry field offset.

oidmap does not make use of this flexibilty, hardcoding the offset to
zero instead. Let's fix this by passing struct type and member to
hashmap_free_entries.

Additionally, removes an erroneous semi-colon at the end of
hashmap_free_entries macro.

Signed-off-by: Abhishek Kumar <abhishekkumar8222@gmail.com>
---
 hashmap.h | 2 +-
 oidmap.c  | 6 ++++--
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/hashmap.h b/hashmap.h
index 79ae9f80de..6d0a65a39f 100644
--- a/hashmap.h
+++ b/hashmap.h
@@ -245,7 +245,7 @@ void hashmap_free_(struct hashmap *map, ssize_t offset);
  * where @member is the hashmap_entry struct used to associate with @map
  */
 #define hashmap_free_entries(map, type, member) \
-	hashmap_free_(map, offsetof(type, member));
+	hashmap_free_(map, offsetof(type, member))
 
 /* hashmap_entry functions */
 
diff --git a/oidmap.c b/oidmap.c
index 423aa014a3..65d63787a8 100644
--- a/oidmap.c
+++ b/oidmap.c
@@ -26,8 +26,10 @@ void oidmap_free(struct oidmap *map, int free_entries)
 	if (!map)
 		return;
 
-	/* TODO: make oidmap itself not depend on struct layouts */
-	hashmap_free_(&map->map, free_entries ? 0 : -1);
+	if (free_entries)
+		hashmap_free_entries(&map->map, struct oidmap_entry, internal_entry);
+	else
+		hashmap_free(&map->map);
 }
 
 void *oidmap_get(const struct oidmap *map, const struct object_id *key)
-- 
2.26.0

