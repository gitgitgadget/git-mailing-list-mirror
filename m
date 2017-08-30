Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 608CC208CD
	for <e@80x24.org>; Wed, 30 Aug 2017 07:14:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751336AbdH3HO3 (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Aug 2017 03:14:29 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:35511 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751242AbdH3HO2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Aug 2017 03:14:28 -0400
Received: by mail-pg0-f67.google.com with SMTP id r133so4496229pgr.2
        for <git@vger.kernel.org>; Wed, 30 Aug 2017 00:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3mD0CfchupwrEI2zJD5f1jyKnVliXnLAbKasi/oAHLM=;
        b=fcLrFte0FpOEOmM0Aimk2IUUFn1mIGwqPsNFMCRdFYA7pCN++RYZWDTt/lpFa3cxe1
         DnF+4Cvd/ypqc1ENlwWe3q1ksvoSvV1ITHBiHOqXROvj+oJDh/BA2vrMV3fN21DLjCm1
         m3eEJdEIrfvfZA1ZlAP6YgDolNVGDw9U+ymMmURdI1PX+sj/sjELxUK4ut09CpsXaLZf
         /j1oZVxp4olOA5y+xYAI2r/G9HIJdZzEYKoq5Q7xQerIKPo9CTYMXCb2valInVY2EFJn
         Rpx4avPPCqhJYoYxy3xa2UzfbZzbUwVeY0E9PrrmJTEG68BAEznJ4HlXMEq3klwD6vs+
         1mrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3mD0CfchupwrEI2zJD5f1jyKnVliXnLAbKasi/oAHLM=;
        b=gD20XAcWd7+NZhA0Th5RFYS2VBdtemKj239G18Bj6rntIVtzMrvzDMb3mA/uxPrKri
         VlyZLLI4UwVfET/IfS5Kdafe2t85W5GD2fESnahVIhEJNe5LXkCRrywWqnu0Ej+XIuJI
         MReOq/rhCf4L80pcBmoXrzV5cU9dKzSJLeXStcO/aff1C8YiQHAFg4xb7SU6F5N4a6lu
         pa3JrE2tGQm2uSDkd0rQKUDaxjA5ebZNvjvyMawkpUvbxzs2+KrruoGpT7ZVGWge27GF
         +SIIQTxsSXhlbRADRFWWSt006KIsJITYijFEMI8kjTrH3lDH/jq6jpESBRnnIM4H8KdG
         nuVg==
X-Gm-Message-State: AHYfb5iophzFOLPtxeZLd07hxYMpFBp4HWzwss2NdAvcTIs13Qlacgfz
        vttjYnRMnvxzDWF8gg0=
X-Received: by 10.84.210.143 with SMTP id a15mr832501pli.20.1504077267718;
        Wed, 30 Aug 2017 00:14:27 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:402:5042:50b1:56af:6f3d])
        by smtp.gmail.com with ESMTPSA id a15sm7983944pfl.1.2017.08.30.00.14.27
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 30 Aug 2017 00:14:27 -0700 (PDT)
Date:   Wed, 30 Aug 2017 00:14:25 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH 33/39] pack: allow reprepare_packed_git to handle arbitrary
 repositories
Message-ID: <20170830071425.GH153983@aiede.mtv.corp.google.com>
References: <20170830064634.GA153983@aiede.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170830064634.GA153983@aiede.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 packfile.c | 8 ++++----
 packfile.h | 3 +--
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/packfile.c b/packfile.c
index 23a835f7fb..67274d01fd 100644
--- a/packfile.c
+++ b/packfile.c
@@ -880,11 +880,11 @@ void prepare_packed_git(struct repository *r)
 	r->objects.packed_git_initialized = 1;
 }
 
-void reprepare_packed_git_the_repository(void)
+void reprepare_packed_git(struct repository *r)
 {
-	the_repository->objects.approximate_object_count_valid = 0;
-	the_repository->objects.packed_git_initialized = 0;
-	prepare_packed_git(the_repository);
+	r->objects.approximate_object_count_valid = 0;
+	r->objects.packed_git_initialized = 0;
+	prepare_packed_git(r);
 }
 
 unsigned long unpack_object_header_buffer(const unsigned char *buf,
diff --git a/packfile.h b/packfile.h
index 75be3cb877..b3138816e7 100644
--- a/packfile.h
+++ b/packfile.h
@@ -33,8 +33,7 @@ extern struct packed_git *parse_pack_index(unsigned char *sha1, const char *idx_
 extern void (*report_garbage)(unsigned seen_bits, const char *path);
 
 extern void prepare_packed_git(struct repository *r);
-#define reprepare_packed_git(r) reprepare_packed_git_##r()
-extern void reprepare_packed_git_the_repository(void);
+extern void reprepare_packed_git(struct repository *r);
 extern void install_packed_git(struct repository *r, struct packed_git *pack);
 
 /*
-- 
2.14.1.581.gf28d330327

