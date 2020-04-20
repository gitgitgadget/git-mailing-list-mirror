Return-Path: <SRS0=xG8z=6E=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4763C3A5A0
	for <git@archiver.kernel.org>; Mon, 20 Apr 2020 19:54:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90D5C206A1
	for <git@archiver.kernel.org>; Mon, 20 Apr 2020 19:54:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iFTkWYEm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726439AbgDTTyl (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Apr 2020 15:54:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726161AbgDTTyl (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 20 Apr 2020 15:54:41 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A425DC061A0C
        for <git@vger.kernel.org>; Mon, 20 Apr 2020 12:54:40 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id nv1so8977410ejb.0
        for <git@vger.kernel.org>; Mon, 20 Apr 2020 12:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=YjqNNlMdaz4Hda1S8UyZ58pJPBvOqEVsiIpHkrldYpQ=;
        b=iFTkWYEmZjfkehhlJwCFHWQr/GKoIL9T9wSS9p8LmX3OTu/p4aregTWWuv3u1XmfbN
         UkCezK9t1IYxXaCFWitzTZks8uPUOSVvGgL4CbP7mEv4Wnssuu9B4ZYTTUCmtinGocG5
         q4VKtk8duX4O6R/ES7Aq8Y+oFhSHzOxeddymHvmP3r1klPEoRNwPtgY1i1HrIWCNVifj
         NlpHA7uG1P1eUJOy5PYapq0J6wnpvjR1aRmkLg7tfEq+baDMgowk84GxSwIQ/j7mcNmW
         E5m7HPc5PT+VTnh4pGCQzGOxkso6cHi86Z307ctvrU2XmseaXOaCdns5GWhlHiB/CAt5
         zFWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=YjqNNlMdaz4Hda1S8UyZ58pJPBvOqEVsiIpHkrldYpQ=;
        b=VU41xoWB7xJtpLEmOAdWEImknQ3UyesfBZiLXyxSGARXfydw83UbwfGXLIl2j3/eJa
         aRkMlqaRp2nbCvjCa8vz8CH5ZTB6n1K0O2UUvAL9ZJr3B6xcG46kmSfd8faiemnp0S73
         13j7TwKV8bQLfngyC+kvq8M8KM2tG//sQt2Fnl8wDxG6MXwIN2CpL1t87r5CMGupkoml
         n9mM6k/VnL1SLTcUkOJW1PTVBvt5Zi+HlwvJIb89w4GTcEHhX2xDYAmQXpkyL2+v/yGP
         VIM8P3lfzhF96WHhBc2PjFZnRNQ7VS4Lj6AB7qXYaTyd8V2bZgxmFVwhyGMF+QQVggzV
         LXhQ==
X-Gm-Message-State: AGi0Pub049hvG2KYeT7HgAZniCJa92WGpvp4jzOwpHrkC0xxKv+peKj1
        eI9hI7Y29GME6MMm39a0hJSvH1rg
X-Google-Smtp-Source: APiQypJePYbZiNv+UYZdfUFftxhlzev9lKlHqGt/eC6VUU8hHe5skQ+vXBmRVgqtryXuMimjHk9mfg==
X-Received: by 2002:a17:906:4003:: with SMTP id v3mr17422343ejj.144.1587412479273;
        Mon, 20 Apr 2020 12:54:39 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g1sm29340ejs.51.2020.04.20.12.54.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 12:54:38 -0700 (PDT)
Message-Id: <eb0cbeeeed080596c130f657186894999ae6121b.1587412477.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.606.git.1587412477.gitgitgadget@gmail.com>
References: <pull.606.git.1587412477.gitgitgadget@gmail.com>
From:   "Hariom Verma via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 20 Apr 2020 19:54:36 +0000
Subject: [PATCH 1/2] fetch-pack: remove fetch_if_missing=0
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Hariom Verma <hariom18599@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Hariom Verma <hariom18599@gmail.com>

Commit 6462d5e ("fetch: remove fetch_if_missing=0", 2019-11-08)
strove to remove the need for fetch_if_missing=0 from the fetching
mechanism, so it is plausible to attempt removing fetch_if_missing=0
from fetch-pack as well.

Signed-off-by: Hariom Verma <hariom18599@gmail.com>
---
 builtin/fetch-pack.c | 2 --
 fetch-pack.c         | 2 +-
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
index dc1485c8aa1..38a45512918 100644
--- a/builtin/fetch-pack.c
+++ b/builtin/fetch-pack.c
@@ -57,8 +57,6 @@ int cmd_fetch_pack(int argc, const char **argv, const char *prefix)
 	struct packet_reader reader;
 	enum protocol_version version;
 
-	fetch_if_missing = 0;
-
 	packet_trace_identity("fetch-pack");
 
 	memset(&args, 0, sizeof(args));
diff --git a/fetch-pack.c b/fetch-pack.c
index 1734a573b01..1ca643f6491 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -1649,7 +1649,7 @@ static void update_shallow(struct fetch_pack_args *args,
 		struct oid_array extra = OID_ARRAY_INIT;
 		struct object_id *oid = si->shallow->oid;
 		for (i = 0; i < si->shallow->nr; i++)
-			if (has_object_file(&oid[i]))
+			if (has_object_file_with_flags(&oid[i], OBJECT_INFO_SKIP_FETCH_OBJECT))
 				oid_array_append(&extra, &oid[i]);
 		if (extra.nr) {
 			setup_alternate_shallow(&shallow_lock,
-- 
gitgitgadget

