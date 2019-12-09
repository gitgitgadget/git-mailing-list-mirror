Return-Path: <SRS0=90au=Z7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E9ABC04E30
	for <git@archiver.kernel.org>; Mon,  9 Dec 2019 11:53:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2248120828
	for <git@archiver.kernel.org>; Mon,  9 Dec 2019 11:53:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QPml6zdH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727628AbfLILxG (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Dec 2019 06:53:06 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54146 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727572AbfLILxG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Dec 2019 06:53:06 -0500
Received: by mail-wm1-f66.google.com with SMTP id n9so14639894wmd.3
        for <git@vger.kernel.org>; Mon, 09 Dec 2019 03:53:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9mupzvCgS/xIzZPP2Or6CXweNF6BFj867V7VzBIJkKU=;
        b=QPml6zdHPGOZBV3I3B3e2SX6NCn+6ugK5N+rROaXcNihnJCBUiiiI9ov9FXXgZnYpj
         5mulcZoHpqQynVrEiWTKuqN4Er9rTP+6+0JHoTODMB2NG9+p0t1XkC7wfdhYEzkc9H4h
         q0DdQflESTsLo9fssDYZqe15ycL9zU/VebQZtx2QLVbMa0xpiucgJXxm4OVhuVv8fhvH
         2UKT2/zI74UsgWqgUWPUPixhsQvQfQw34hz/x2MBFmEJydX/M4ceUkAlS+8AFV6njeFF
         LU+nNxHDVFerikXltMpkfNAa1sqEb1ImucgJgItCrese+IUdALejEyxTDkcf0SUsO0Fe
         yeYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9mupzvCgS/xIzZPP2Or6CXweNF6BFj867V7VzBIJkKU=;
        b=C1K5T6H2IGzh8ROn3UTNBh2GtvF44H1Xy39Z7znRDoxnn5BLSm9lNijUqcYMbaDcxh
         H903oPnkKv5D4u1cpHSpAFumnQtyeSX24dYLB1bNxSpB/QzZwgbJvs9Ozg6AbaCEZMIy
         bOSGezSsmi9dPx6cmF9gQMhm9mBX3YaCDKZjquK7DtQpgzeNcN4YqiVokVkeK5v0v+UV
         5wBID21Q95kg2cAK01+k+TpvXg7vepwLtJF1FlASGQoBkSnaU/KG111JrLKh6OlxzBDI
         kUM1TIIOcH7BqQqsvuowBj0rJpJP858ydVn2QcpWGOgpFptA1IfDU4iQk8iSL4Mt6x9o
         3sjA==
X-Gm-Message-State: APjAAAUgQLsSS9VJ2EhDRIgvB6AOhroqvEiZ2M5OUuTIvwPnO5xbzCGi
        QwFzDQOpdJ3MZEGXGDHJb6A=
X-Google-Smtp-Source: APXvYqzvD96xAc7HbuprGuFK7NUz/mRSFwg2fuG4DHnS0mO9BVMcIh7f49XiFEarkQQ6R7Cqdpip/Q==
X-Received: by 2002:a7b:c0d8:: with SMTP id s24mr25690016wmh.30.1575892384246;
        Mon, 09 Dec 2019 03:53:04 -0800 (PST)
Received: from localhost.localdomain (x4db55b9c.dyn.telefonica.de. [77.181.91.156])
        by smtp.gmail.com with ESMTPSA id k8sm27239621wrl.3.2019.12.09.03.53.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 09 Dec 2019 03:53:03 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v3 01/14] t6120-describe: correct test repo history graph in comment
Date:   Mon,  9 Dec 2019 12:52:45 +0100
Message-Id: <20191209115258.9281-2-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.24.0.801.g241c134b8d
In-Reply-To: <20191209115258.9281-1-szeder.dev@gmail.com>
References: <20191112103821.30265-1-szeder.dev@gmail.com>
 <20191209115258.9281-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

At the top of 't6120-describe.sh' an ASCII graph illustrates the
repository's history used in this test script.  This graph is a bit
misleading, because it swapped the second merge commit's first and
second parents.

When describing/naming a commit it does make a difference which parent
is the first and which is the second/Nth, so update this graph to
accurately represent that second merge.

While at it, move this history graph from the 'test_description'
variable to a regular comment.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 t/t6120-describe.sh | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/t/t6120-describe.sh b/t/t6120-describe.sh
index 45047d0a72..9b184179d1 100755
--- a/t/t6120-describe.sh
+++ b/t/t6120-describe.sh
@@ -1,15 +1,16 @@
 #!/bin/sh
 
-test_description='test describe
+test_description='test describe'
+
+#  o---o-----o----o----o-------o----x
+#       \   D,R   e           /
+#        \---o-------------o-'
+#         \  B            /
+#          `-o----o----o-'
+#                 A    c
+#
+# First parent of a merge commit is on the same line, second parent below.
 
-                       B
-        .--------------o----o----o----x
-       /                   /    /
- o----o----o----o----o----.    /
-       \        A    c        /
-        .------------o---o---o
-                   D,R   e
-'
 . ./test-lib.sh
 
 check_describe () {
-- 
2.24.0.801.g241c134b8d

