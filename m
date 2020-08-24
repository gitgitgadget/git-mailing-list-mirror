Return-Path: <SRS0=3swP=CC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 684FAC433E1
	for <git@archiver.kernel.org>; Mon, 24 Aug 2020 19:17:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C02820578
	for <git@archiver.kernel.org>; Mon, 24 Aug 2020 19:17:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="FsloDqJM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726435AbgHXTRL (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Aug 2020 15:17:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725976AbgHXTRD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Aug 2020 15:17:03 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E941C061574
        for <git@vger.kernel.org>; Mon, 24 Aug 2020 12:17:03 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id x13so2554612pgf.17
        for <git@vger.kernel.org>; Mon, 24 Aug 2020 12:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=673kli77OXF/5l/XX1PvacZP+aZRKnbI4iG9bNFC32A=;
        b=FsloDqJMXIQrCdCRlh5mXTC+RqRyORw+evrxihMzy3dpYscSCo/j/bvQxoZtWDc7fE
         Uw1KxAsrf8HqMLzYznh1UBzTpXY09ImitN7lX4mTbNpca46iISvU/4zMmllgEmeXXoNX
         MmOO6whfdUm47niT0+ex5EUGW2hB0lCgAQav3PcaWBWowaRiZDrg9JJ1AZiA+xUbBIlA
         eL2QO9Yyl/7KzQ+OIdeEFWNPWyvXKffCS/95hQmMAD+RVsQa65PaJ1ADah5YZ9vV9huM
         NB78jKJd+z/Bq4wdcXcUtfAqHbR+8G61/kePqW59z8YvTINRabnyEGaGCaV9uMMYQIh9
         62Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=673kli77OXF/5l/XX1PvacZP+aZRKnbI4iG9bNFC32A=;
        b=S2jG62O1tn0oF9as7CswMlTwAlMRXuOqNJIP++jIJPt75NmajsdyQUNRbN9Xqk6R/C
         lE98B5kIXIUr53Na304abJ90IN7AS4FAPFx0RDmKBp/oHpG3IXMIFZgxQro70rK6Bdfp
         w4KaHX1xJYhejXJ/HRIz5/hLkLFaN7sthlcUvz8/Do3IZed35V2L2K2MS7qsKE4RuvxP
         RiMIYYeuYrBfWvb5YhsjGi+SUdNMp/ZRyUatjH0Fc1Z2x7ryxEq3VpG5g8OWSxFAO9rB
         x+0XrBpgjfIp23gqhhQKMjQo+eCZuCR9p5C8LXF9dWW3P/CCqF1A1z65byne5jHdGKjp
         8Jdg==
X-Gm-Message-State: AOAM5335RultMP+w9ARww+Rv/eBMq33zeppYzlt88Bh1a6mYIU5eTNSq
        MsfBBxD2sGyMO1ropmc8yFHBtyU6knu+xL0lQ/fgjBHKtiBmXUIO/jLnsOBkUnEy1LBTnMHtXjn
        51mduqt3lcrjeA3LWVbRH1nrS0uZx4Ncu7Y7hEj9zu76fjxjRbPQ2WLOuKjWqz+G4llg+iedimc
        nH
X-Google-Smtp-Source: ABdhPJzqWyeDAm2XIpZf4CfMIFmLS+EQkF1m8Ayn79HTPs3ND0ZmvPbnFLwJeEhRIOoxjQkC6H9JhlijnYD/PXeXYAz2
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:18d])
 (user=jonathantanmy job=sendgmr) by 2002:a17:90a:fb4a:: with SMTP id
 iq10mr598508pjb.90.1598296620923; Mon, 24 Aug 2020 12:17:00 -0700 (PDT)
Date:   Mon, 24 Aug 2020 12:16:34 -0700
In-Reply-To: <cover.1598296530.git.jonathantanmy@google.com>
Message-Id: <2e7baaabf0ad9d724f5a81495213f4626b8c04ab.1598296530.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1598296530.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.28.0.297.g1956fa8f8d-goog
Subject: [PATCH 3/7] index-pack: unify threaded and unthreaded code
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, peff@peff.net,
        steadmon@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 builtin/index-pack.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index a8444d550b..357e03b5aa 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -1211,15 +1211,7 @@ static void resolve_deltas(void)
 		cleanup_thread();
 		return;
 	}
-
-	for (i = 0; i < nr_objects; i++) {
-		struct object_entry *obj = &objects[i];
-
-		if (is_delta_type(obj->type))
-			continue;
-		resolve_base(obj);
-		display_progress(progress, nr_resolved_deltas);
-	}
+	threaded_second_pass(&nothread_data);
 }
 
 /*
-- 
2.28.0.297.g1956fa8f8d-goog

