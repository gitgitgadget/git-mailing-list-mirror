Return-Path: <SRS0=ZKiS=2H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59CFBC2D0CD
	for <git@archiver.kernel.org>; Tue, 17 Dec 2019 12:02:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29FF3207FF
	for <git@archiver.kernel.org>; Tue, 17 Dec 2019 12:02:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AHxxMNuQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727761AbfLQMB6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Dec 2019 07:01:58 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:34479 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726709AbfLQMBw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Dec 2019 07:01:52 -0500
Received: by mail-pf1-f193.google.com with SMTP id l127so5642288pfl.1
        for <git@vger.kernel.org>; Tue, 17 Dec 2019 04:01:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=afpKYb9KH9PSYs6ZS7QULiLYjGm9fTj9ThuhSVylIoY=;
        b=AHxxMNuQ0qJ27hF86Il1SKqYaa47P/U/0bfglGSnPlx91lgQ5yjZ5vC5ED/1FPhfqg
         UIofs6/rqbr/mGqdQrfEBklsE3C6mrJqYBcu3f1fWJ9lhZ3ePmfx1B59OYgf7O5u70Mz
         I4saQFOl2z2RSpvaYra6+WV+MijuNiq8XqssiRub1GQOaEOhTp+SEjB5KHD6yJoGzlrq
         B1XFR0qjQ/tAETaZhG3gIWNqBDCcjz75oaUdCkC52M55BFlCPaPgEdNQwvHWBG1xK7zi
         zLr3qNpNReB5quTIgTvKaUgt26qp8jjNFrrM4QtVB0A69dPcIxFCWD4o6laz9/daZacO
         EHlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=afpKYb9KH9PSYs6ZS7QULiLYjGm9fTj9ThuhSVylIoY=;
        b=Pqx2zmhzKZD/TdWc23yGHkhdp/0WfpORiEC29y4HTYNZ3JNWgOodWPImAFPvaR4EGW
         etS4Zv22DNzYQzlGTkaqHmiVIUnv7QLphwmuulZHkJ9QXz0w8gC43wPoeTbMdTkbeht6
         qyXui5S+c3u9NkkX8UyAihaiVnyILASJZiI6QgHYw44kRmjG/FN5yDZlGEk45X+v0EQz
         /IcYjHkteC2WzY0irJmnSrTRMHOaxqt+mvxyechewiolQszEKyZ9wWRFN1FCTjtZK9pi
         PxJ+v+mOBP6/QdAXnZN40ihyN2x7fFOKmbtgclaK8I2ehFUn4WswmT80sb/OqBauJ+1b
         EDzA==
X-Gm-Message-State: APjAAAVZ7H8d8o09P9MZCrm66XZ6dTWbAzfjwJjAweMRnCHn+6ulVhAE
        mNSEvsEOc5BXDysnfCesa/v9/d9F
X-Google-Smtp-Source: APXvYqxPTz8khZJY592DrYARxVQbDk0NSORft8Z5RKoyRpwb8unawvP8EuHXkSMGIXjy6/3V86yplg==
X-Received: by 2002:a63:ce50:: with SMTP id r16mr24652737pgi.32.1576584111880;
        Tue, 17 Dec 2019 04:01:51 -0800 (PST)
Received: from archbookpro.hsd1.ca.comcast.net ([2601:646:280:1b30:b0bc:639f:d5c8:2bcf])
        by smtp.gmail.com with ESMTPSA id a15sm27531723pfh.169.2019.12.17.04.01.51
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2019 04:01:51 -0800 (PST)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 12/15] t1409: let sed open its own files
Date:   Tue, 17 Dec 2019 04:01:37 -0800
Message-Id: <0b7d19a7e1498238f3d6d4d9bb07b3345cbb345f.1576583819.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.24.0.627.geba02921db
In-Reply-To: <cover.1576583819.git.liu.denton@gmail.com>
References: <cover.1576583819.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In one case, we were using a redirection operator to feed input into
sed. However, since sed is capable of opening its own files, make sed
open its own files instead of redirecting input into it.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t1409-avoid-packing-refs.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t1409-avoid-packing-refs.sh b/t/t1409-avoid-packing-refs.sh
index c46848eb8e..f74d890e82 100755
--- a/t/t1409-avoid-packing-refs.sh
+++ b/t/t1409-avoid-packing-refs.sh
@@ -8,7 +8,7 @@ test_description='avoid rewriting packed-refs unnecessarily'
 # shouldn't upset readers, and it should be omitted if the file is
 # ever rewritten.
 mark_packed_refs () {
-	sed -e "s/^\(#.*\)/\1 t1409 /" <.git/packed-refs >.git/packed-refs.new &&
+	sed -e "s/^\(#.*\)/\1 t1409 /" .git/packed-refs >.git/packed-refs.new &&
 	mv .git/packed-refs.new .git/packed-refs
 }
 
-- 
2.24.0.627.geba02921db

