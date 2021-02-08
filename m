Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C5CFC433E6
	for <git@archiver.kernel.org>; Mon,  8 Feb 2021 19:38:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CEDD964E85
	for <git@archiver.kernel.org>; Mon,  8 Feb 2021 19:38:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235180AbhBHTid (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Feb 2021 14:38:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235343AbhBHThE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Feb 2021 14:37:04 -0500
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 299FDC061786
        for <git@vger.kernel.org>; Mon,  8 Feb 2021 11:36:49 -0800 (PST)
Received: by mail-qk1-x72e.google.com with SMTP id 19so5495293qkc.13
        for <git@vger.kernel.org>; Mon, 08 Feb 2021 11:36:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=m3NGYO8JJsmMi2ZaW6qCbIStIq3WtfabDC9OFTTJkE0=;
        b=rIk5DeT7nV1+oSD1WGPSCt9FbkSOBkLIWvadlXV6BnHwgGM4+eIHDp5oVg5RNNs1xY
         EYJ+AjrzJqVpqoOTPbOXn9NsO+HK3PQB+EgwQRhdMjfthRLxBGTdUV83GMeEtbHXfa+U
         4NLWddhI4VBpfUD/aY/MzLeAChKUL2+niVcOCV61SdydPwZXBrhKiH5/dlXXFjsrov5I
         AM31opDaHWavwq/i7M9DBUoYHwTyv/ef0xIDDDTlfQQHocnMd501pwCaI7+0riOG9yTY
         ywVIpc9MTYH36CXme80RwQ0Ao9QkqD5N+rM8usIK0Wn0zY+OtA2lMqEl7lyMKXONakYO
         K8vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=m3NGYO8JJsmMi2ZaW6qCbIStIq3WtfabDC9OFTTJkE0=;
        b=nvhRyHvz8o/EpdTB+ITr4skKk+tZMNPIlT9SlurAwW0jGwgUXcKgowwb4yWwY4bjGR
         bOBLXds9tOi+cARU1vqcxl+EAaURyO0NaOs1C4wWyL7hsNxzXvNVf9UNTaS1gQE7tGOq
         ebKvnAfXW/yGoMJFnaDGIXdtx79wpAdAmA8CiWBatIhSpBIlc+8hspgAIqbDYU31dwHA
         5L01CB+tLP/L8voVzxcYfwPsJcxmEFquz0g56h/lPy3JEvZXtgbjyjA5vy9ZgIEE8prD
         CIdeP/Lh9ukv3MV8FFcj+qSn5tUpcEk+M39qoPQGiMAcb5HZ+StVcEyLNiVHuw8EFWp6
         0UWg==
X-Gm-Message-State: AOAM53041sL1iK1/adXJD7kx9bZDALxjgXc0C8CAWCdUi7KYEiUEViQg
        3rFeza1s8wCMvaAX8i5hlRuwXu5so687LA==
X-Google-Smtp-Source: ABdhPJwlFT2eZyAAuN0osUIPtvafCvaR2JvPiHs+CMPR/fmA4tmMFCBLlzdMQRcYTopovQpWPmd0og==
X-Received: by 2002:a05:620a:16b9:: with SMTP id s25mr18043580qkj.347.1612813007845;
        Mon, 08 Feb 2021 11:36:47 -0800 (PST)
Received: from mango.meuintelbras.local ([177.32.118.149])
        by smtp.gmail.com with ESMTPSA id h6sm15143808qtx.39.2021.02.08.11.36.45
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Feb 2021 11:36:47 -0800 (PST)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Subject: [PATCH 1/2] write_entry(): fix misuses of `path` in error messages
Date:   Mon,  8 Feb 2021 16:36:31 -0300
Message-Id: <d52bcad326ece6be2fcf87ca6b72e4ce8212e31f.1612812581.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1612812581.git.matheus.bernardino@usp.br>
References: <cover.1612812581.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The variables `path` and `ce->name`, at write_entry(), usually have the
same contents, but that's not the case when using a checkout prefix or
writing to a tempfile. (In fact, `path` will be either empty or dirty
when writing to a tempfile.) Therefore, these variables cannot be used
interchangeably. In this sense, fix wrong uses of `path` in error
messages where it should really be `ce->name`. (There doesn't seem to be
any misuse in the other way around.)

Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
 entry.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/entry.c b/entry.c
index a0532f1f00..7b9f43716f 100644
--- a/entry.c
+++ b/entry.c
@@ -282,7 +282,7 @@ static int write_entry(struct cache_entry *ce,
 		new_blob = read_blob_entry(ce, &size);
 		if (!new_blob)
 			return error("unable to read sha1 file of %s (%s)",
-				     path, oid_to_hex(&ce->oid));
+				     ce->name, oid_to_hex(&ce->oid));
 
 		/*
 		 * We can't make a real symlink; write out a regular file entry
@@ -309,7 +309,7 @@ static int write_entry(struct cache_entry *ce,
 			new_blob = read_blob_entry(ce, &size);
 			if (!new_blob)
 				return error("unable to read sha1 file of %s (%s)",
-					     path, oid_to_hex(&ce->oid));
+					     ce->name, oid_to_hex(&ce->oid));
 		}
 
 		/*
@@ -354,7 +354,7 @@ static int write_entry(struct cache_entry *ce,
 
 	case S_IFGITLINK:
 		if (to_tempfile)
-			return error("cannot create temporary submodule %s", path);
+			return error("cannot create temporary submodule %s", ce->name);
 		if (mkdir(path, 0777) < 0)
 			return error("cannot create submodule directory %s", path);
 		sub = submodule_from_ce(ce);
@@ -365,7 +365,7 @@ static int write_entry(struct cache_entry *ce,
 		break;
 
 	default:
-		return error("unknown file mode for %s in index", path);
+		return error("unknown file mode for %s in index", ce->name);
 	}
 
 finish:
-- 
2.29.2

