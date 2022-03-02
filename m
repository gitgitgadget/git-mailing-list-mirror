Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7BF3C433FE
	for <git@archiver.kernel.org>; Wed,  2 Mar 2022 17:10:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243668AbiCBRLR (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Mar 2022 12:11:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243659AbiCBRLO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Mar 2022 12:11:14 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70A2B4C7AF
        for <git@vger.kernel.org>; Wed,  2 Mar 2022 09:10:30 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id a5-20020a05600c224500b003832be89f25so1683447wmm.2
        for <git@vger.kernel.org>; Wed, 02 Mar 2022 09:10:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+HG9Hm146CEQQjR32qq3KjXs0RGFYK03/Q7VHDWUO3I=;
        b=PWQt9h4AQEP6WprnWNPz1QL7nQc1Bevij9h3jsPVsxiAZgH/ChsQNbV/K4bqS4B2fD
         X3Xqfd12ZU536FeOZFNN0NSm8mAo0s0fu//xUrO5QE90SPjJpEqhnLr7lV6xc28EHk2Z
         XmkOfC2MknYYys4mDGuL4+FHQ+6R5dWQ22ePNzgmHVyPFRTTgvCQenPB5O6yF1hIsNkB
         cMA3tBTujwvwQ3sMeIONJmGUQXqdl+mGa5J6w8+rGnr8qDKXE23LRjejUT6HLEH1CkEz
         AnIGOFqM/CzTa4CjX3GzgsYT+kPEPAiRpn8xTXCAazvSoPCfPsU+16XQoXTw2p+ZntMF
         tkoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+HG9Hm146CEQQjR32qq3KjXs0RGFYK03/Q7VHDWUO3I=;
        b=s6cMpLtbYxvKDsUotYmfZ7qxzSoRB3L8YqyyP3Y7xJLb46BfXteGkUrV3G3N5yYGWq
         8OVkyPBxVsVhNLYduyucPTmo+tPGMY1FZ00vXy3o8zW7AnIwoQ/Z8AV32WkNUR7zNKyC
         mxzIBtrCG9/m9hLKrIClZ3wSz4E5sLJIz8muakqCxPIuzzeLwJr98UDaTJYUyDv0aitI
         RbdFJPX7GwifU/IGgE59XGRTjUwigz2P020c3luM7/YcPZQykhoMFDUj9FBHI4kKpWiT
         LZkdlA3lBI7Sr8ejtkmE5Zy2jEnCIKtYZEzOXDlp8D44rfOdbIEA/nZ2mVHMdVAsAqS0
         6jTg==
X-Gm-Message-State: AOAM533TB0UUd4Niys88JzslWxn5Bm+voluoEX/dZAGw6+1tAFkyKwOU
        xrIijDlijAQjh7T1DcgYS7YNDdp9j426sA==
X-Google-Smtp-Source: ABdhPJz0szF0XcEFgvXFGZWghfjWBgp2UM3exBO6uBaI+txBYd4Qf0g/APg1/NhKHf8PKNopS7R44Q==
X-Received: by 2002:a05:600c:4f04:b0:381:6ea1:8d7 with SMTP id l4-20020a05600c4f0400b003816ea108d7mr618881wmq.164.1646241028807;
        Wed, 02 Mar 2022 09:10:28 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id p9-20020a05600c1d8900b003813b489d75sm6178001wms.10.2022.03.02.09.10.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 09:10:28 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 05/14] remote-curl.c: free memory in cmd_main()
Date:   Wed,  2 Mar 2022 18:10:11 +0100
Message-Id: <patch-05.14-8891fd44c7c-20220302T170718Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1228.g56895c6ee86
In-Reply-To: <cover-00.14-00000000000-20220302T170718Z-avarab@gmail.com>
References: <cover-00.14-00000000000-20220302T170718Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Plug a trivial memory leak in code added in a2d725b7bdf (Use an
external program to implement fetching with curl, 2009-08-05).

To do this have the cmd_main() use a "goto cleanup" pattern, and to
return an error of 1 unless we can fall through to the http_cleanup()
at the end.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 remote-curl.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/remote-curl.c b/remote-curl.c
index 0dabef2dd7c..ff44f41011e 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -1472,11 +1472,12 @@ int cmd_main(int argc, const char **argv)
 {
 	struct strbuf buf = STRBUF_INIT;
 	int nongit;
+	int ret = 1;
 
 	setup_git_directory_gently(&nongit);
 	if (argc < 2) {
 		error(_("remote-curl: usage: git remote-curl <remote> [<url>]"));
-		return 1;
+		goto cleanup;
 	}
 
 	options.verbosity = 1;
@@ -1508,7 +1509,7 @@ int cmd_main(int argc, const char **argv)
 		if (strbuf_getline_lf(&buf, stdin) == EOF) {
 			if (ferror(stdin))
 				error(_("remote-curl: error reading command stream from git"));
-			return 1;
+			goto cleanup;
 		}
 		if (buf.len == 0)
 			break;
@@ -1556,12 +1557,15 @@ int cmd_main(int argc, const char **argv)
 				break;
 		} else {
 			error(_("remote-curl: unknown command '%s' from git"), buf.buf);
-			return 1;
+			goto cleanup;
 		}
 		strbuf_reset(&buf);
 	} while (1);
 
 	http_cleanup();
+	ret = 0;
+cleanup:
+	strbuf_release(&buf);
 
-	return 0;
+	return ret;
 }
-- 
2.35.1.1228.g56895c6ee86

