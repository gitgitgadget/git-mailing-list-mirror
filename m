Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 007A11F4C0
	for <e@80x24.org>; Sat, 19 Oct 2019 10:36:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726120AbfJSKgD (ORCPT <rfc822;e@80x24.org>);
        Sat, 19 Oct 2019 06:36:03 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44265 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726103AbfJSKgC (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Oct 2019 06:36:02 -0400
Received: by mail-wr1-f65.google.com with SMTP id z9so8724021wrl.11
        for <git@vger.kernel.org>; Sat, 19 Oct 2019 03:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QGaq1AZHL3X9vsrwZoXNz1Ga/GP3WjkYvKoin45GkPQ=;
        b=kQrR0GDdFBA8exu1z1UDDxZCW4sBAcefqia/E3Teq8C91ndC6M6dgbZcb9y2B6730X
         eKEo3l1jmLUTAlt6wFFW3JSDGsNr4LWYrFGYotjhBC/LZ0hh5VliKn0uDw+sV9q/0F7W
         0ltNFQbvrXFpewNywgdUgcMGI+CcxgR80ZymIlXBBpskkJZ10H/RAajAdYoLcS9DTzzc
         uzxoo7S7BAWn4ZD3fz46miOVI6DIQhUxRmp3AZp/05TA2xbTEMqe5nrSn9N+Nrwa8NMH
         wvtEsqeO0MDS3pSyNYNWGTFhm5TsSEoV30D0abdhXxwtd70GOJa0PYXW6/xeq9PWeHvr
         plfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QGaq1AZHL3X9vsrwZoXNz1Ga/GP3WjkYvKoin45GkPQ=;
        b=UAcL0tQcxrJbKUx2sX0hLyta8jkMQexpJxEtHBuYl/A3n2GluX6c3sXyRYle/Dci26
         rQMA5hgdQ9FJUq2Ky2jUu7TKC95rkqZARhKb1In0hOaWsP7PJ/zWxavszZ0hQwFxyfC7
         zmS+uioHSocQlgROOZrWFgm5VtkVfP17Txn7Xj+4ARv46+2AXks7hUm2p8pJU1IA/2+M
         N6O3qn9HCNn5qgDty1Mfi/hCp2ZTc7ixthpbqWuR5W+XOwkKbFXrTPVM//bDgwH6r65Z
         v5oB9QtmyvTwqAnEH/NwiZf1oZyBYBIfOD4/Qpyy+ggW1zP/ifzWsWuX9aqW1vP3uR94
         Oq1Q==
X-Gm-Message-State: APjAAAXAnHbtE1zGr/OS6YQd+EyJPQAFJDT3FyAtv4gmetugkdCYY7uO
        VCRrwQrJzw3XMj2oQ1paPqrF/75Z75gE3g==
X-Google-Smtp-Source: APXvYqytPpOk7bICxJlER1flb92kKLtE+RBstlI0OrB+LO/KJjJJ3jKm9Q7G0HdejWrUAOKsA92CpQ==
X-Received: by 2002:adf:cd87:: with SMTP id q7mr1401640wrj.216.1571481359941;
        Sat, 19 Oct 2019 03:35:59 -0700 (PDT)
Received: from localhost.localdomain ([80.214.68.206])
        by smtp.gmail.com with ESMTPSA id p68sm6383086wme.0.2019.10.19.03.35.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Oct 2019 03:35:59 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: [PATCH v2 8/9] builtin/pack-objects: introduce obj_is_packed()
Date:   Sat, 19 Oct 2019 12:35:30 +0200
Message-Id: <20191019103531.23274-9-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.24.0.rc0.9.gef620577e2
In-Reply-To: <20191019103531.23274-1-chriscool@tuxfamily.org>
References: <20191019103531.23274-1-chriscool@tuxfamily.org>
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
index 4fcfcf6097..08898331ef 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -2553,6 +2553,11 @@ static void ll_find_deltas(struct object_entry **list, unsigned list_size,
 	free(p);
 }
 
+static int obj_is_packed(const struct object_id *oid)
+{
+	return !!packlist_find(&to_pack, oid);
+}
+
 static void add_tag_chain(const struct object_id *oid)
 {
 	struct tag *tag;
@@ -2564,7 +2569,7 @@ static void add_tag_chain(const struct object_id *oid)
 	 * it was included via bitmaps, we would not have parsed it
 	 * previously).
 	 */
-	if (packlist_find(&to_pack, oid))
+	if (obj_is_packed(oid))
 		return;
 
 	tag = lookup_tag(the_repository, oid);
@@ -2588,7 +2593,7 @@ static int add_ref_tag(const char *path, const struct object_id *oid, int flag,
 
 	if (starts_with(path, "refs/tags/") && /* is a tag? */
 	    !peel_ref(path, &peeled)    && /* peelable? */
-	    packlist_find(&to_pack, &peeled))      /* object packed? */
+	    obj_is_packed(&peeled)) /* object packed? */
 		add_tag_chain(oid);
 	return 0;
 }
-- 
2.24.0.rc0.9.gef620577e2

