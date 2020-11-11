Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CBBDC4742C
	for <git@archiver.kernel.org>; Thu, 12 Nov 2020 01:50:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3488B205ED
	for <git@archiver.kernel.org>; Thu, 12 Nov 2020 01:50:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hsix0zsH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728425AbgKLBca (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Nov 2020 20:32:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727923AbgKKXaS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Nov 2020 18:30:18 -0500
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00ED2C061A47
        for <git@vger.kernel.org>; Wed, 11 Nov 2020 15:29:47 -0800 (PST)
Received: by mail-qv1-xf49.google.com with SMTP id m11so2047263qvu.6
        for <git@vger.kernel.org>; Wed, 11 Nov 2020 15:29:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to;
        bh=nLiYW/2IgWYFFH2gz421GCoVsN1fZ0JN5aKM7M8F1ew=;
        b=hsix0zsHScS3eE6fRgWC7chCB0DV/xMc5vorqKSvJ5Y3EjJ5zwktmCwFfPIIoqltj/
         XCHMvlFQ8pggKb5q1/iX5ZjPeBf1KOxeLDzJtd6RUNezuoGfJn8RjKQhpFbuk5q+FFM7
         CpFwzO1Z4OwDphC3wg8Xj6PejuSiij4f1Ci2QjwqXOZ7CDgA/fMKCg8bAIchpBwrEnoz
         nVCiYFV6jFLbSmYZcTMU/R6UlAotHCUhNMuYOtf2B6p1oLKxaSpAKwn5roND69htAzvj
         hj8EaDCkrGdCBNRYsvFMNb77FgzIZ4Bsbr1a9NBYkbixEGf+DcClXgPQ08O5ql07j+1U
         Kigg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to;
        bh=nLiYW/2IgWYFFH2gz421GCoVsN1fZ0JN5aKM7M8F1ew=;
        b=lUGrvkefk2YivnQq5uk5s5wGWAmt1KaQrmjeoi6/47m8uT6iMwrZVtc5sCpmlfrRaG
         eOIk9Efh0d4kNNtEkwaUE6X9oR6ND0ykEwOXQGXqlVO7AbHvmjvq2L977H67dMnVEzrY
         YLUmMK7kePgekhlYeEmfvK4/iUsxecE1W12DoxTMXA27t5rP28sFE2U0G/OF/RREbw38
         QSx91jDZv5+7mENmTw9dwFe1ojjSl+7l63zpe88Vc6/VsR0rVUgRKjZ88AMnWh9eONx2
         /ebHk/YIGtBpUJ9jO4TggeLXkpztgusY6F5FyXlzobHHLhC6tj0xxT5p1hnYPq/AKKU3
         9NZg==
X-Gm-Message-State: AOAM5321h+td3xnpaLQmTHVVaTr9Qb5QO79LxTA19hV5UqmUz9zLmQDj
        1p15we1WkDNg463WR0LD7GIs6+pwXBkPkBLytmLLdwi3Ct9BhTwz4Z6zXfZff6sOwgyOq/nQAir
        f3lSPDGM+4FWeKrY30nKFNXv5gVmAbpILu+Z0JPFFDivpfJLngyirhyUii5KVREU=
X-Google-Smtp-Source: ABdhPJzVGamHO3ZsToVb9fGi37UoETwWs1uUhAXi/YiG2Po+6TRk0R6oEvU/KKVJRT8majYxo4qBwqolGqQRMg==
Sender: "steadmon via sendgmr" <steadmon@lunarfall.svl.corp.google.com>
X-Received: from lunarfall.svl.corp.google.com ([2620:15c:2ce:200:1ea0:b8ff:fe74:b4c1])
 (user=steadmon job=sendgmr) by 2002:a0c:f050:: with SMTP id
 b16mr21553767qvl.34.1605137385969; Wed, 11 Nov 2020 15:29:45 -0800 (PST)
Date:   Wed, 11 Nov 2020 15:29:28 -0800
In-Reply-To: <cover.1605136908.git.steadmon@google.com>
Message-Id: <32fe78f3e95334197e73230169a9b0a292ec47bf.1605136908.git.steadmon@google.com>
Mime-Version: 1.0
References: <cover.1604006121.git.steadmon@google.com> <cover.1605136908.git.steadmon@google.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8-goog
Subject: [PATCH v3 05/11] receive-pack: advertise session ID in v0 capabilities
From:   Josh Steadmon <steadmon@google.com>
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When transfer.advertiseSID is true, advertise receive-pack's session ID
via the new session-id capability.

Signed-off-by: Josh Steadmon <steadmon@google.com>
---
 builtin/receive-pack.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index bb9909c52e..6ed498b6c7 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -54,6 +54,7 @@ static int receive_unpack_limit = -1;
 static int transfer_unpack_limit = -1;
 static int advertise_atomic_push = 1;
 static int advertise_push_options;
+static int advertise_sid;
 static int unpack_limit = 100;
 static off_t max_input_size;
 static int report_status;
@@ -248,6 +249,11 @@ static int receive_pack_config(const char *var, const char *value, void *cb)
 		return 0;
 	}
 
+	if (strcmp(var, "transfer.advertisesid") == 0) {
+		advertise_sid = git_config_bool(var, value);
+		return 0;
+	}
+
 	return git_default_config(var, value, cb);
 }
 
@@ -268,6 +274,8 @@ static void show_ref(const char *path, const struct object_id *oid)
 			strbuf_addf(&cap, " push-cert=%s", push_cert_nonce);
 		if (advertise_push_options)
 			strbuf_addstr(&cap, " push-options");
+		if (advertise_sid)
+			strbuf_addf(&cap, " session-id=%s", trace2_session_id());
 		strbuf_addf(&cap, " object-format=%s", the_hash_algo->name);
 		strbuf_addf(&cap, " agent=%s", git_user_agent_sanitized());
 		packet_write_fmt(1, "%s %s%c%s\n",
-- 
2.29.2.222.g5d2a92d10f8-goog

