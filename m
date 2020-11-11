Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F7AFC56201
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 19:43:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F8D0208B3
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 19:43:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="JGosVA1W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726904AbgKKTnm (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Nov 2020 14:43:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727817AbgKKTnj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Nov 2020 14:43:39 -0500
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72B03C0613D1
        for <git@vger.kernel.org>; Wed, 11 Nov 2020 11:43:37 -0800 (PST)
Received: by mail-qk1-x734.google.com with SMTP id n132so2936976qke.1
        for <git@vger.kernel.org>; Wed, 11 Nov 2020 11:43:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Vyxl/ZzskMDJlsODRF7Ik3qIATDvo6PKYLmRKflxJQg=;
        b=JGosVA1W6HsHthORVdGf9nwFFHx9nTY46Yshp9sI2ACo7GIq3cJPUKEDR+nurS+8Wy
         ofcdfFStJsaq5K008if9DArP1ZY60dBpNBTG8WtPrrzz7/YO+ezYoxUrhN0fqJaU5bH3
         OFD9ukru3c0eYOdiXInTJ8GLt+l9XKdpyIuzx1kkOMi2faNGl8zxhKqFJ0K0LYX3HIXv
         pUt5fz3zftz+zdloAwADLH5SJqiw90awI4RdXrMTwQiZLhPAWyftJzL0+PwSOVv1PQad
         sPOIofdd/oYCSBy2BN5W+02boypqj148wFY9y302Qlh6PDeag2yd+fAb2FgXm3iw03fb
         IWww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Vyxl/ZzskMDJlsODRF7Ik3qIATDvo6PKYLmRKflxJQg=;
        b=o/taia71IKpGHFH/0EbWMvhN+375Xid/nARR0gVUa2OAXHZsjzBOUkQTp98X2DYsSW
         YUSkaAwkyyzIAve8EAvcNhZw2jm7UoBkgrwMFJwL1lnZntjwdRha0m2PHaqgl75K85WX
         GG61GPD/BT61C6VDD+D0mfYCHAIx+7UJgYbWgsoRW3QTe8lsOncenBXDxhNa479UArDY
         Jm4qxi5RTpVzCJsm2CKMXlMfgqtZ70sHwYVgEbH94M4nUnDJfC4C8LnTSdlEQQabWXfq
         b6JRaF6QkB42c+zXgYHyrcBrkJuNPTtNrpojVzBEHMkXjKKlR/CaJNNZsokaGyLZGTYS
         CNuQ==
X-Gm-Message-State: AOAM531wQl9PHdPGF6QsOLyLRMJixp5tqdj8uHqdCO2ELY2gjVbBntWb
        JsBVqJZiX5462KUjPCirbAAJwsMQAL6A7teD
X-Google-Smtp-Source: ABdhPJyNpv4Qc4CR8tJatmjVTgCIdFTKDKZg0P6U6WqowJU9WrWQixq0ek/Yo+WZS00ffEa+GKki4w==
X-Received: by 2002:ae9:f714:: with SMTP id s20mr9140080qkg.45.1605123816377;
        Wed, 11 Nov 2020 11:43:36 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:7ccc:9a51:1ad:2057])
        by smtp.gmail.com with ESMTPSA id r125sm1548104qke.129.2020.11.11.11.43.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2020 11:43:35 -0800 (PST)
Date:   Wed, 11 Nov 2020 14:43:33 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     dstolee@microsoft.com, gitster@pobox.com, peff@peff.net
Subject: [PATCH 14/23] commit: implement commit_list_contains()
Message-ID: <7f9b45b118cdd48372dd60d5e2f3e9a588175dab.1605123652.git.me@ttaylorr.com>
References: <cover.1605123652.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1605123652.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

It can be helpful to check if a commit_list contains a commit. Use
pointer equality, assuming lookup_commit() was used.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 commit.c | 11 +++++++++++
 commit.h |  2 ++
 2 files changed, 13 insertions(+)

diff --git a/commit.c b/commit.c
index fe1fa3dc41..9a785bf906 100644
--- a/commit.c
+++ b/commit.c
@@ -544,6 +544,17 @@ struct commit_list *commit_list_insert(struct commit *item, struct commit_list *
 	return new_list;
 }
 
+int commit_list_contains(struct commit *item, struct commit_list *list)
+{
+	while (list) {
+		if (list->item == item)
+			return 1;
+		list = list->next;
+	}
+
+	return 0;
+}
+
 unsigned commit_list_count(const struct commit_list *l)
 {
 	unsigned c = 0;
diff --git a/commit.h b/commit.h
index 5467786c7b..742a6de460 100644
--- a/commit.h
+++ b/commit.h
@@ -167,6 +167,8 @@ int find_commit_subject(const char *commit_buffer, const char **subject);
 
 struct commit_list *commit_list_insert(struct commit *item,
 					struct commit_list **list);
+int commit_list_contains(struct commit *item,
+			 struct commit_list *list);
 struct commit_list **commit_list_append(struct commit *commit,
 					struct commit_list **next);
 unsigned commit_list_count(const struct commit_list *l);
-- 
2.29.2.156.gc03786897f

