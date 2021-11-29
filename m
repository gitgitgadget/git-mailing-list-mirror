Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39EBDC433FE
	for <git@archiver.kernel.org>; Mon, 29 Nov 2021 22:37:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232006AbhK2WlE (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Nov 2021 17:41:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233525AbhK2WkB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Nov 2021 17:40:01 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B136C06139B
        for <git@vger.kernel.org>; Mon, 29 Nov 2021 10:49:49 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id d24so39029877wra.0
        for <git@vger.kernel.org>; Mon, 29 Nov 2021 10:49:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=N9Pw+KJFqlPSRHC+rN/E7nMPjs/w9fhIXuw+GJ8Nu44=;
        b=aj6ghjX+DS5VJA3YwUU6uipVjNVBpSTbiP1IBe8WjiTP/G/NCMCBXEPZRbGMFNe6aN
         Cr5eCzYH+KZPlftZ7YtGAxdJAaILDBRW+nDHwT4uUEzo4ynnORQaLh6SmSVeVE7v9grS
         +kz47pmLvLXhdx1xu59L1sWeGGcdBGJoJpylnQvaucad7rojLEPP6lZAQdDoBPpbwKDm
         9+kF4bDno9cP22FKCv/tf6vLt8G1HPTyE29LFEsmeIhz8KVazCNgaktFPS2BIWVX6rQ4
         iolD69ftDlCTbk9OWEUlfqPITNh3iv8Kyxb2Lngjeo21++9bq/BLisUFo54FYuGeHmj/
         zDYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=N9Pw+KJFqlPSRHC+rN/E7nMPjs/w9fhIXuw+GJ8Nu44=;
        b=xgIxYy7ETgr7UakwjPd9gbjJ0Dv/6nk9pE5USaCgEWTuN37s2O31IGr4EYXLhFRxHf
         Lh7Bu9cOqsr+QHJXKI2886ADVGgKtfQo7HBur0fenfgqwO2+Upp43EQ0A0cLNv1zx4r+
         z7b6XDJ2EMFneLbGw5aqaDBkuRdg5RP0oGMraYGEYzmAN1VWIlrUGFF1j0S/XrrwncM9
         wBDpib4hI+dXoLPIjy2IZ97G3WXuIidGRQ1padzA33qJ4NfSZe3eruLeOqi+nqv+ldsx
         TqbGMr7TeAuwaV6H0rN+uBoYgYzrzi+FTtfO8i9FwkRdv7qhlVUAzm7QBmRQKEW0oiUO
         axGg==
X-Gm-Message-State: AOAM5337AXPNrCeB8+xQACz4N35WZG2mxDGBLudt5GIQHwFWO5zTnJug
        lnGGs+Lv7tg03HcnZHcL+NX3CMdM3RA=
X-Google-Smtp-Source: ABdhPJxVEBlOb+LpHY/yscUKPA6xFQhTNeaXrpf/2PxNUEZrVbBv9pdZXhhY7Y9aZk1IRieirzhgIw==
X-Received: by 2002:a5d:514a:: with SMTP id u10mr35865370wrt.321.1638211787639;
        Mon, 29 Nov 2021 10:49:47 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h15sm112335wmq.32.2021.11.29.10.49.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 10:49:47 -0800 (PST)
Message-Id: <7fa5c247c8b1cdeb4fcd166cfb6e98425d21e5ae.1638211786.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1147.v2.git.git.1638211786.gitgitgadget@gmail.com>
References: <pull.1147.git.git.1637855761.gitgitgadget@gmail.com>
        <pull.1147.v2.git.git.1638211786.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 29 Nov 2021 18:49:41 +0000
Subject: [PATCH v2 1/6] test-ref-store: plug memory leak in cmd_delete_refs
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 t/helper/test-ref-store.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/t/helper/test-ref-store.c b/t/helper/test-ref-store.c
index b314b81a45b..ccc2bb01bf3 100644
--- a/t/helper/test-ref-store.c
+++ b/t/helper/test-ref-store.c
@@ -86,11 +86,13 @@ static int cmd_delete_refs(struct ref_store *refs, const char **argv)
 	unsigned int flags = arg_flags(*argv++, "flags");
 	const char *msg = *argv++;
 	struct string_list refnames = STRING_LIST_INIT_NODUP;
-
+	int result;
 	while (*argv)
 		string_list_append(&refnames, *argv++);
 
-	return refs_delete_refs(refs, msg, &refnames, flags);
+	result = refs_delete_refs(refs, msg, &refnames, flags);
+	string_list_clear(&refnames, 0);
+	return result;
 }
 
 static int cmd_rename_ref(struct ref_store *refs, const char **argv)
-- 
gitgitgadget

