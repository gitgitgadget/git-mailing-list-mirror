Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67D45C678D4
	for <git@archiver.kernel.org>; Thu,  2 Mar 2023 22:03:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229748AbjCBWDd (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Mar 2023 17:03:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbjCBWD3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Mar 2023 17:03:29 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 915B05A6E6
        for <git@vger.kernel.org>; Thu,  2 Mar 2023 14:03:06 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id z2-20020a170903018200b0019cfc0a566eso315903plg.15
        for <git@vger.kernel.org>; Thu, 02 Mar 2023 14:03:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=0w0JSky0wue+bAdzXqkRUkKqNS3LfA2qZNiuvavmOKs=;
        b=FT8LU7CDVcvOCheoqOsPARuU6Vlf61QiwYXNte3tKd2qScPPDuJLSvUW/SOZHUN6Ao
         SVGr33ybXEiqnuv1JpiLnNAGw6sYdw52m4NLtveUU+ej+TLnWcW6YCC6cwCBNAlJqD0i
         21Z/mBsDjkr7cfYj71PnsW6j06Ij5VE+nEDoo9QNK2p57622XfYEh5df4AmJE4qca3BZ
         PoFgOYD2Qz6koE5R+K2mjRcx7yPfkeLUGUGWLiVtVyCKv0gUkV+7KgRXIDmxod90Zeye
         hBTli82brVXrsEA2/+PiXrmRcOWw+QgWfYXSgyrQImEcWLXCMNGi+JjDHnZ232eEFOnr
         VaVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0w0JSky0wue+bAdzXqkRUkKqNS3LfA2qZNiuvavmOKs=;
        b=kXeE5d9CNgQeAj0NZWOgfCfmOFvH20gTW/qZrEdWO9wWoRApEGDYhWDt/yhUHmTTuE
         ZSI+kYgCIxz7LGNr++nar5W9eZ2V7aoJnjOYplKcrPO6XeDrCbz6LIVw/KTgOx3M8lIr
         kAqHwFFTn6dC5SyBEXI3wEC6dTHix2EDEwakNQjbp+HE6Mf4+1kYaAS0yWazmQt5raUo
         9CAEYhBVtHlD4XJ71B3W7KRx/zHPTfBau+GXETwnyUi8hvZmXEYnCthTDCWeWU+82G4i
         +2PNUCc9RDM6F2L+1dGVuwABss5WA+94rYfHXpEvfkAlO1eSprulKmae8gcCCLMKPH/N
         nEZg==
X-Gm-Message-State: AO0yUKU0v4Q+YZxsKAbFHs5ZGprlnYI8xZgb+uH9BuXH6gS4DImGRyvd
        RLaLCI2Wu+U7LGwp8t0oyP/OjdIG9UKX+qpRIm6lNBGdvk+gLu1BQr9QZeWOFR/YEl+7k6qjZbn
        YeN7BuVrPBcrjTR1mQKUlvl5/ZhqD211uKaASkFsptVCMTu6fXkRTw/OFHtZ3IjLbGw==
X-Google-Smtp-Source: AK7set8FSf7pLL0qSkgoDPz606uOzrHp7AVPqrY94XEK9IbnY/32KazuH7w5sbjo7ZXb/PqSFTVw8fumGcehkaQ=
X-Received: from barleywine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3bd4])
 (user=calvinwan job=sendgmr) by 2002:a62:dbc5:0:b0:5df:9809:621f with SMTP id
 f188-20020a62dbc5000000b005df9809621fmr22598pfg.0.1677794581418; Thu, 02 Mar
 2023 14:03:01 -0800 (PST)
Date:   Thu,  2 Mar 2023 22:02:47 +0000
In-Reply-To: <20230302215237.1473444-1-calvinwan@google.com>
Mime-Version: 1.0
References: <20230209000212.1892457-1-calvinwan@google.com>
X-Mailer: git-send-email 2.40.0.rc0.216.gc4246ad0f0-goog
Message-ID: <20230302220251.1474923-2-calvinwan@google.com>
Subject: [PATCH v9 2/6] submodule: rename strbuf variable
From:   Calvin Wan <calvinwan@google.com>
To:     git@vger.kernel.org
Cc:     Calvin Wan <calvinwan@google.com>, avarab@gmail.com,
        chooglen@google.com, newren@gmail.com, jonathantanmy@google.com,
        phillip.wood123@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A prepatory change for a future patch that moves the status parsing
logic to a separate function.

Signed-off-by: Calvin Wan <calvinwan@google.com>
---
 submodule.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/submodule.c b/submodule.c
index fae24ef34a..faf37c1101 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1906,25 +1906,28 @@ unsigned is_submodule_modified(const char *path, int ignore_untracked)
 
 	fp = xfdopen(cp.out, "r");
 	while (strbuf_getwholeline(&buf, fp, '\n') != EOF) {
+		char *str = buf.buf;
+		const size_t len = buf.len;
+
 		/* regular untracked files */
-		if (buf.buf[0] == '?')
+		if (str[0] == '?')
 			dirty_submodule |= DIRTY_SUBMODULE_UNTRACKED;
 
-		if (buf.buf[0] == 'u' ||
-		    buf.buf[0] == '1' ||
-		    buf.buf[0] == '2') {
+		if (str[0] == 'u' ||
+		    str[0] == '1' ||
+		    str[0] == '2') {
 			/* T = line type, XY = status, SSSS = submodule state */
-			if (buf.len < strlen("T XY SSSS"))
+			if (len < strlen("T XY SSSS"))
 				BUG("invalid status --porcelain=2 line %s",
-				    buf.buf);
+				    str);
 
-			if (buf.buf[5] == 'S' && buf.buf[8] == 'U')
+			if (str[5] == 'S' && str[8] == 'U')
 				/* nested untracked file */
 				dirty_submodule |= DIRTY_SUBMODULE_UNTRACKED;
 
-			if (buf.buf[0] == 'u' ||
-			    buf.buf[0] == '2' ||
-			    memcmp(buf.buf + 5, "S..U", 4))
+			if (str[0] == 'u' ||
+			    str[0] == '2' ||
+			    memcmp(str + 5, "S..U", 4))
 				/* other change */
 				dirty_submodule |= DIRTY_SUBMODULE_MODIFIED;
 		}
-- 
2.40.0.rc0.216.gc4246ad0f0-goog

