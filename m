Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A891CC433F5
	for <git@archiver.kernel.org>; Wed,  2 Mar 2022 00:58:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238837AbiCBA7I (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Mar 2022 19:59:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238843AbiCBA7C (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Mar 2022 19:59:02 -0500
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C41BA90260
        for <git@vger.kernel.org>; Tue,  1 Mar 2022 16:58:16 -0800 (PST)
Received: by mail-il1-x129.google.com with SMTP id k7so233690ilo.8
        for <git@vger.kernel.org>; Tue, 01 Mar 2022 16:58:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=CIKN/CB83u6sQ1/KE0vEIeyTEwD5VnDa2rxArL8gDJ0=;
        b=FpGiuIdQ1YjcSSRXKNUicfiySgW9MgPXdXtdzBIIOudGQUUQUeLigf1Qq5Gb+PBZ5F
         x00dCwVlWj5MyAyeCa09bao1PUD/wg9lAj/LI8APchITNqEzaJzwkhA7GJ8DlSkCbvWJ
         8YX8IkA/JL5bhvAPt0DERLDbHBua424BcK3bH9KAFHmwyT8vuI93y6jRH8SU7fBKX2hO
         vlED7lQYWLTSdoBbwNAJ2QTgHQqbokAhJhD7Zm7cBwvvIurKytE5x9jZdew1XrSAyOXh
         8VLgwujIpFjnZWegqpBtUKBpyNRXTVQ092usNj6o8z7X0Nq5W9pDNv9vr1eIYHcclYoO
         QBgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CIKN/CB83u6sQ1/KE0vEIeyTEwD5VnDa2rxArL8gDJ0=;
        b=u73RHJG0LbdG2Zw5YQmWlxeBV82VIZ85tJ5DzireJ8XL0/aDuGK/7r4+YipAAiZstv
         9mG754SnMaeyoGPVypnpVbyyRr0sJr0rFegNYbt9GBRzKi7SbsICC4RiGR+3JlFPpIkw
         Dx508h4RsS1YTBhdrM3Oz4JP81Ssv3OLMAYRskd6sX6vVSgrWFuF0b4H8gcW0mcHz7vX
         OmFNC0aXFiyv4W7OLbeza2/0IMMZ1IG9w4raNytsV4MVQg67e3rInLsOy9bnajnqDheC
         fhbbzE7BvMqMIvNK3XzMGa73wRHP+CCb4WRCFfLedpYOTH8fA+p9trIE3GLFIDsKQFpf
         EkPw==
X-Gm-Message-State: AOAM533QGczG/DE9pcb9RR7wPwQeClHNX7301/Rv71/XMsdc8ija8GCf
        wi4KI6FpN+bTNfES5RmCjIgq2lAFM/fI/YKf
X-Google-Smtp-Source: ABdhPJyvy/m6ARLnccTsf+Q8VPCSIRPNLNFWhnOVJokscUI7mcDGvHM98Zkdw28UOe7kV0oaNpoUcw==
X-Received: by 2002:a92:c888:0:b0:2c2:fb23:1cf with SMTP id w8-20020a92c888000000b002c2fb2301cfmr8065416ilo.301.1646182696066;
        Tue, 01 Mar 2022 16:58:16 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id a4-20020a5d9544000000b00640a6eb6e1esm8445326ios.53.2022.03.01.16.58.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Mar 2022 16:58:15 -0800 (PST)
Date:   Tue, 1 Mar 2022 19:58:15 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     tytso@mit.edu, derrickstolee@github.com, gitster@pobox.com,
        larsxschneider@gmail.com
Subject: [PATCH v2 07/17] builtin/pack-objects.c: return from
 create_object_entry()
Message-ID: <142098668d1ff6feea69be328ccc55119d14bf13.1646182671.git.me@ttaylorr.com>
References: <cover.1638224692.git.me@ttaylorr.com>
 <cover.1646182671.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1646182671.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A new caller in the next commit will want to immediately modify the
object_entry structure created by create_object_entry(). Instead of
forcing that caller to wastefully look-up the entry we just created,
return it from create_object_entry() instead.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/pack-objects.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 385970cb7b..3f08a3c63a 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1508,13 +1508,13 @@ static int want_object_in_pack(const struct object_id *oid,
 	return 1;
 }
 
-static void create_object_entry(const struct object_id *oid,
-				enum object_type type,
-				uint32_t hash,
-				int exclude,
-				int no_try_delta,
-				struct packed_git *found_pack,
-				off_t found_offset)
+static struct object_entry *create_object_entry(const struct object_id *oid,
+						enum object_type type,
+						uint32_t hash,
+						int exclude,
+						int no_try_delta,
+						struct packed_git *found_pack,
+						off_t found_offset)
 {
 	struct object_entry *entry;
 
@@ -1531,6 +1531,8 @@ static void create_object_entry(const struct object_id *oid,
 	}
 
 	entry->no_try_delta = no_try_delta;
+
+	return entry;
 }
 
 static const char no_closure_warning[] = N_(
-- 
2.35.1.73.gccc5557600

