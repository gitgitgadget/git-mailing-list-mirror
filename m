Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 463A3C433E6
	for <git@archiver.kernel.org>; Fri,  8 Jan 2021 18:21:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1560C23A7E
	for <git@archiver.kernel.org>; Fri,  8 Jan 2021 18:21:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728806AbhAHSVJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Jan 2021 13:21:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728505AbhAHSVI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Jan 2021 13:21:08 -0500
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78589C061381
        for <git@vger.kernel.org>; Fri,  8 Jan 2021 10:20:28 -0800 (PST)
Received: by mail-io1-xd2a.google.com with SMTP id o6so10611945iob.10
        for <git@vger.kernel.org>; Fri, 08 Jan 2021 10:20:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BobO7G9NRKAb9dtVec1L1u9TJeFc1s0PLLQlW9/BBA8=;
        b=dtvfjqYnQnqtpZVSGl5sEyBzc0cR322GReyh0E2DDfYeL0JltNuorwlEVC5mdML/K9
         ohc8iTminVxbrZleGa/j9xxpziXrx6NgIonuPaKSds7TfyUc9c+k7SMDvRnxvyktFX5Y
         itS4a4SpPeER0mIoZi4Vy82olecQKBcIa4BQThWsMv5dA/AgpFvcaD1aGU1GvNmAE+59
         ymZU90xJUT3JRN0gBe7TbSNwmVWMQzw2NRy2koZLzuPiMDlBEKGk4sOBN8yrrTTwM3jk
         NkQtp6u+NG0lKm1DL6TIYlLQHw6rxLKdcpV6PEJ3sBTo7l33MfNmSdBO3XRNSLVma+Xl
         0Gkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BobO7G9NRKAb9dtVec1L1u9TJeFc1s0PLLQlW9/BBA8=;
        b=i0Y01tDayeyA1teNJV0KMYxJoDmStHrEh5syOqCcG6aXyMxwvcY//0PPRWm9u45jwv
         TUCxDkn7GL2H33b3Q1tRT8qcP/08VUK9wUDrYvxEIZnuI+OIkFp+vVF9I77B8xXTD2XT
         C9PP4U9BDhDdc7zQVTwHWSEBKHJOeiL3S+pkejl1GuUk69Rz7kk5HGjr7TvfE+aasrvB
         S7JPXZnZPB0RHMZ9/SC1m0cIOQ7MJh9+prUBtNjUT+QOjdrDbMvvdn9Iy3XvI2GYQ+Gt
         pO1u3dx/X9m70zwZzO8LSH+Z4n1h0jWpQEObjtwkVUDTwKUm5591BLUIqstiqXGZ1/yF
         9IYA==
X-Gm-Message-State: AOAM532Yka8IRLBY3pHai/8Z63AfOxa0raW2KOP2MTNKt8VhMAFce34I
        lMO1RB4/EMqnAOijWHJ+do+GxEp3+RhLwQ==
X-Google-Smtp-Source: ABdhPJwppcKq6MFD1rWHl0cgfsfD1goYCyAqkSvRO74oZ/MqPmXTxgg7Z6N8s9lrRaZAHOs5VbfKBg==
X-Received: by 2002:a05:6638:1243:: with SMTP id o3mr4475338jas.129.1610130027662;
        Fri, 08 Jan 2021 10:20:27 -0800 (PST)
Received: from localhost ([8.9.92.205])
        by smtp.gmail.com with ESMTPSA id m8sm5562896ioh.16.2021.01.08.10.20.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jan 2021 10:20:27 -0800 (PST)
Date:   Fri, 8 Jan 2021 13:20:25 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, jrnieder@gmail.com
Subject: [PATCH 7/8] t: support GIT_TEST_WRITE_REV_INDEX
Message-ID: <3525c4d114c8655953aca44d8effa1652ccc93d3.1610129989.git.me@ttaylorr.com>
References: <cover.1610129989.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1610129989.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a new option that unconditionally enables the pack.writeReverseIndex
setting in order to run the whole test suite in a mode that generates
on-disk reverse indexes.

Once on-disk reverse indexes are proven out over several releases, we
can change the default value of that configuration to 'true', and drop
this patch.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/index-pack.c   | 5 ++++-
 builtin/pack-objects.c | 2 ++
 pack-revindex.h        | 2 ++
 t/README               | 3 +++
 4 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 03408250b1..0bde325a8b 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -1748,7 +1748,10 @@ int cmd_index_pack(int argc, const char **argv, const char *prefix)
 	if (prefix && chdir(prefix))
 		die(_("Cannot come back to cwd"));
 
-	rev_index = !!(opts.flags & (WRITE_REV_VERIFY | WRITE_REV));
+	if (git_env_bool(GIT_TEST_WRITE_REV_INDEX, 0))
+		rev_index = 1;
+	else
+		rev_index = !!(opts.flags & (WRITE_REV_VERIFY | WRITE_REV));
 
 	for (i = 1; i < argc; i++) {
 		const char *arg = argv[i];
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 80adce154a..5b3395bd7a 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -3597,6 +3597,8 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 
 	reset_pack_idx_option(&pack_idx_opts);
 	git_config(git_pack_config, NULL);
+	if (git_env_bool(GIT_TEST_WRITE_REV_INDEX, 0))
+		pack_idx_opts.flags |= WRITE_REV;
 
 	progress = isatty(2);
 	argc = parse_options(argc, argv, prefix, pack_objects_options,
diff --git a/pack-revindex.h b/pack-revindex.h
index b501a7cd62..d2d466e298 100644
--- a/pack-revindex.h
+++ b/pack-revindex.h
@@ -1,6 +1,8 @@
 #ifndef PACK_REVINDEX_H
 #define PACK_REVINDEX_H
 
+#define GIT_TEST_WRITE_REV_INDEX "GIT_TEST_WRITE_REV_INDEX"
+
 struct packed_git;
 
 int load_pack_revindex(struct packed_git *p);
diff --git a/t/README b/t/README
index c730a70770..0f97a51640 100644
--- a/t/README
+++ b/t/README
@@ -439,6 +439,9 @@ GIT_TEST_DEFAULT_HASH=<hash-algo> specifies which hash algorithm to
 use in the test scripts. Recognized values for <hash-algo> are "sha1"
 and "sha256".
 
+GIT_TEST_WRITE_REV_INDEX=<boolean>, when true enables the
+'pack.writeReverseIndex' setting.
+
 Naming Tests
 ------------
 
-- 
2.30.0.138.g6d7191ea01

