Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F2A3C433E9
	for <git@archiver.kernel.org>; Tue, 30 Mar 2021 15:04:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33390619D7
	for <git@archiver.kernel.org>; Tue, 30 Mar 2021 15:04:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232237AbhC3PE1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Mar 2021 11:04:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231910AbhC3PEK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Mar 2021 11:04:10 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F004C061574
        for <git@vger.kernel.org>; Tue, 30 Mar 2021 08:04:10 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id d10so14428047ils.5
        for <git@vger.kernel.org>; Tue, 30 Mar 2021 08:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fK8WEtc2GFHptLJs2Vl6B9J5BbpyrxE1ckawIMUyd9Y=;
        b=RYFcR2QXXh3pyP5mx3e8IECsSFyHcW3rH73QVeXLcEM3Z9IGVsbALXQoISaJhA5UzE
         Yo1+kmKAbgtKfTQKrND6Hdb8dcLTy5H5LUQhILbdu/5EbMb/3+jCBXSa5XGDaNq+eqCG
         cqagp2d+9/vT7t5mcSy/i88qRNVM4vnB5sw4vYD61pJY8eq8RisKTA4hVnTIdiW0WaRZ
         SAMM1RA8ZpFBLpHMCIoEzFJ07hP7JzECMpG6I3j7prO7H9VQSUJcIdUKMXqCh2Eudanh
         WcBpZ+z2L8aF0CIC8Nr5WO8BkrxW9/1zS9tUcFMpigP5Orf9GCYcZ+Z/aBIPpxlT2+zd
         7g6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fK8WEtc2GFHptLJs2Vl6B9J5BbpyrxE1ckawIMUyd9Y=;
        b=TClxecaDoTa9s+PY9gqkvATdkLXfXNQGfa9tgs7OQYWoru0KC54nJgn45l2ZGUWCUm
         beN+SnZC6A7Qdh0dsVIz6YQ95ES7Sccu0Q5Uw2N38ma420ziCANRvQozbDFt+w4IzYiB
         35N4mAH24T/OWlONgDLCfSveUvMF53e5hj56XM+thfnfhkmqCPwtgFs8sGghd0i0TbVK
         ASgJaTlkg4O7Or/+a1NVjfI+6ONKne5WAycIK8hNRSjN9O8vh8mPTngjKyK64783poqu
         O739RIlTSloRUFM86dZ2EbZ7PBc2q8+uih4+xUsq5rIVJ9aHqn6SUiClgR70T/y84qDT
         71gA==
X-Gm-Message-State: AOAM532ilHyjoATpN5Hqxqb/Tz6Rsv5ZSLFvuEmLnB/ts9bTEw6STgot
        9lfuqh79mxPez1svsOcrb9U2Mhtj1W8qSA==
X-Google-Smtp-Source: ABdhPJz3r4QdsksKZHiQC2KXP54OowLjsagF701o+oCNN8m7axgo12pidDhiLth9WMHDAO4DrJaC5g==
X-Received: by 2002:a05:6e02:1a2f:: with SMTP id g15mr25740656ile.176.1617116649534;
        Tue, 30 Mar 2021 08:04:09 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:7b00:4f79:8763:6261])
        by smtp.gmail.com with ESMTPSA id 13sm11629830ioz.40.2021.03.30.08.04.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 08:04:09 -0700 (PDT)
Date:   Tue, 30 Mar 2021 11:04:07 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, dstolee@microsoft.com,
        jonathantanmy@google.com
Subject: [PATCH v4 07/16] t/helper/test-read-midx.c: add '--show-objects'
Message-ID: <37e073ea277045f00cdb3dfa2827f8c8d67ed9cb.1617116623.git.me@ttaylorr.com>
References: <cover.1612998106.git.me@ttaylorr.com>
 <cover.1617116623.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1617116623.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The 'read-midx' helper is used in places like t5319 to display basic
information about a multi-pack-index.

In the next patch, the MIDX writing machinery will learn a new way to
choose from which pack an object is selected when multiple copies of
that object exist.

To disambiguate which pack introduces an object so that this feature can
be tested, add a '--show-objects' option which displays additional
information about each object in the MIDX.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 t/helper/test-read-midx.c | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/t/helper/test-read-midx.c b/t/helper/test-read-midx.c
index 2430880f78..7c2eb11a8e 100644
--- a/t/helper/test-read-midx.c
+++ b/t/helper/test-read-midx.c
@@ -4,7 +4,7 @@
 #include "repository.h"
 #include "object-store.h"
 
-static int read_midx_file(const char *object_dir)
+static int read_midx_file(const char *object_dir, int show_objects)
 {
 	uint32_t i;
 	struct multi_pack_index *m;
@@ -43,13 +43,29 @@ static int read_midx_file(const char *object_dir)
 
 	printf("object-dir: %s\n", m->object_dir);
 
+	if (show_objects) {
+		struct object_id oid;
+		struct pack_entry e;
+
+		for (i = 0; i < m->num_objects; i++) {
+			nth_midxed_object_oid(&oid, m, i);
+			fill_midx_entry(the_repository, &oid, &e, m);
+
+			printf("%s %"PRIu64"\t%s\n",
+			       oid_to_hex(&oid), e.offset, e.p->pack_name);
+		}
+		return 0;
+	}
+
 	return 0;
 }
 
 int cmd__read_midx(int argc, const char **argv)
 {
-	if (argc != 2)
-		usage("read-midx <object-dir>");
+	if (!(argc == 2 || argc == 3))
+		usage("read-midx [--show-objects] <object-dir>");
 
-	return read_midx_file(argv[1]);
+	if (!strcmp(argv[1], "--show-objects"))
+		return read_midx_file(argv[2], 1);
+	return read_midx_file(argv[1], 0);
 }
-- 
2.30.0.667.g81c0cbc6fd

