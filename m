Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96C13C433B4
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 22:44:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75272611AE
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 22:44:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235051AbhDIWo1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Apr 2021 18:44:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235069AbhDIWo1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Apr 2021 18:44:27 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37119C061762
        for <git@vger.kernel.org>; Fri,  9 Apr 2021 15:44:12 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id w203-20020a1c49d40000b029010c706d0642so6047697wma.0
        for <git@vger.kernel.org>; Fri, 09 Apr 2021 15:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ETDtbvTidvgjs4ULXfoGNCTJzsipRKvSDURm4EkrSW4=;
        b=aWOXEP6QR4vD3NFfzp3rwozXaWjNDlFRrxnGKqNOzjMY+go9Iu4phurLGqoKcn3pGm
         N0myBWZ+hLqM00000mTZrk/lglrkEs5Tex1u47Gh6VGvN4Nvkgk2gpbQOoSZL3dcw3R0
         38hB0F64QJB/bpe2zwqQeoGYzcAtKGGdllyeixmKWRRAIrOeyiLWhcmxtQDj5fzc4IAU
         ErFUu89ywhffnLWlyXdUDoaUzU4XOmE3XSC/JMTiP+E7Y5slBLrF6s1nGaB52xCDyf/E
         5U2AohPQxA70yOxozgiO2lQ9wL7MCO9AQbFoLnItZz94KQ0iO2HgZm3275kjIH4Dmrtu
         Lg4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ETDtbvTidvgjs4ULXfoGNCTJzsipRKvSDURm4EkrSW4=;
        b=a/RuQ2hNIl0FfXIdIRcGc7/1jgFJTLTWA/zeWf+Bexb3YOcPstGAA/OgRx6vGpbkh9
         ybMTHWvl25YFX7TnxqnK1Iz4rEbjCiOY5mneE+823dusMC71/SMfGEZ4nEYG+ojNOu53
         Y8Z1RNz9Z09SroNszSUt8XU5HP1OdbIl79fSE22IWn1v1my8VuWNd2i6tCybfWUQ+Ydv
         60GKrwAjw/l+/gHBaf+sJltxKn5MH5OIgpwEJbXW4o4zQndcUZPOryKijB7uxgDAwEEf
         6WD55B7RRtVqnpZWhS2WV3W48gbIRi5d6m5iPxdZ2BWtnJQHlfKgMKJNY3+wuBuZ9W/a
         CWMw==
X-Gm-Message-State: AOAM533IQwT4EuxgBjtuWTxEXd5Sn4cJud5/+g3BWc/Pj5SNKZTU9Gml
        8P+vYNA5smMDhlyup1r5d04qxOKytEI=
X-Google-Smtp-Source: ABdhPJz/3vO5ZI1rPPLaCEEZ6nIMROtVmFjgR814Vh3WDNeNyfhOpJ+07Une+QMjKK/P7lPVigAAfQ==
X-Received: by 2002:a1c:b689:: with SMTP id g131mr15252828wmf.138.1618008250681;
        Fri, 09 Apr 2021 15:44:10 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j6sm7241157wru.18.2021.04.09.15.44.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 15:44:10 -0700 (PDT)
Message-Id: <pull.907.v2.git.1618008249632.gitgitgadget@gmail.com>
In-Reply-To: <pull.907.git.1616007794513.gitgitgadget@gmail.com>
References: <pull.907.git.1616007794513.gitgitgadget@gmail.com>
From:   "Albert Cui via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 09 Apr 2021 22:44:09 +0000
Subject: [PATCH v2] fetch: show progress for packfile uri downloads
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Albert Cui <albertqcui@gmail.com>,
        Albert Cui <albertqcui@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Albert Cui <albertqcui@gmail.com>

Git appears to hang when downloading packfiles as this part of the
fetch is silent, causing user confusion. This change implements
progress for the number of packfiles downloaded; a progress display
for bytes would involve deeper changes at the http-fetch layer
instead of fetch-pack, the caller, so we do not do that in this
patch.

Signed-off-by: Albert Cui <albertqcui@gmail.com>
---
    fetch: show progress for packfile uri downloads
    
    Git appears to hang when downloading packfiles as this part of the fetch
    is silent, causing user confusion. This change implements progress for
    the number of packfiles downloaded; a progress display for bytes would
    involve deeper changes at the http-fetch layer instead of fetch-pack,
    the caller.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-907%2Falbertcui%2Fprogress-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-907/albertcui/progress-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/907

Range-diff vs v1:

 1:  d6cf8c195111 ! 1:  aedb1b33d0c4 fetch: show progress for packfile uri downloads
     @@ Commit message
          fetch is silent, causing user confusion. This change implements
          progress for the number of packfiles downloaded; a progress display
          for bytes would involve deeper changes at the http-fetch layer
     -    instead of fetch-pack, the caller.
     +    instead of fetch-pack, the caller, so we do not do that in this
     +    patch.
      
          Signed-off-by: Albert Cui <albertqcui@gmail.com>
      
     @@ fetch-pack.c: static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
       		const char *uri = packfile_uris.items[i].string +
       			the_hash_algo->hexsz + 1;
       
     -+		display_progress(packfile_uri_progress, i+1);
     ++		display_progress(packfile_uri_progress, i + 1);
       		strvec_push(&cmd.args, "http-fetch");
       		strvec_pushf(&cmd.args, "--packfile=%.*s",
       			     (int) the_hash_algo->hexsz,
     @@ fetch-pack.c: static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
      
       ## t/t5702-protocol-v2.sh ##
      @@ t/t5702-protocol-v2.sh: test_expect_success 'part of packfile response provided as URI' '
     - 	GIT_TRACE=1 GIT_TRACE_PACKET="$(pwd)/log" GIT_TEST_SIDEBAND_ALL=1 \
     + 	configure_exclusion "$P" my-blob >h &&
     + 	configure_exclusion "$P" other-blob >h2 &&
     + 
     +-	GIT_TRACE=1 GIT_TRACE_PACKET="$(pwd)/log" GIT_TEST_SIDEBAND_ALL=1 \
     ++	GIT_PROGRESS_DELAY=0 GIT_TRACE=1 GIT_TRACE2_EVENT=1 \
     ++	GIT_TRACE_PACKET="$(pwd)/log" GIT_TEST_SIDEBAND_ALL=1 \
       	git -c protocol.version=2 \
       		-c fetch.uriprotocols=http,https \
      -		clone "$HTTPD_URL/smart/http_parent" http_child &&


 fetch-pack.c           | 8 ++++++++
 t/t5702-protocol-v2.sh | 8 ++++++--
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/fetch-pack.c b/fetch-pack.c
index 6a61a464283e..7ca85f40cf23 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -23,6 +23,7 @@
 #include "fetch-negotiator.h"
 #include "fsck.h"
 #include "shallow.h"
+#include "progress.h"
 
 static int transfer_unpack_limit = -1;
 static int fetch_unpack_limit = -1;
@@ -1585,6 +1586,7 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
 	struct fetch_negotiator *negotiator;
 	int seen_ack = 0;
 	struct string_list packfile_uris = STRING_LIST_INIT_DUP;
+	struct progress *packfile_uri_progress;
 	int i;
 	struct strvec index_pack_args = STRVEC_INIT;
 	struct oidset gitmodules_oids = OIDSET_INIT;
@@ -1689,6 +1691,8 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
 		}
 	}
 
+	packfile_uri_progress = start_progress(_("Downloading packs"), packfile_uris.nr);
+
 	for (i = 0; i < packfile_uris.nr; i++) {
 		int j;
 		struct child_process cmd = CHILD_PROCESS_INIT;
@@ -1696,6 +1700,7 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
 		const char *uri = packfile_uris.items[i].string +
 			the_hash_algo->hexsz + 1;
 
+		display_progress(packfile_uri_progress, i + 1);
 		strvec_push(&cmd.args, "http-fetch");
 		strvec_pushf(&cmd.args, "--packfile=%.*s",
 			     (int) the_hash_algo->hexsz,
@@ -1739,6 +1744,9 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
 						 get_object_directory(),
 						 packname));
 	}
+
+	stop_progress(&packfile_uri_progress);
+
 	string_list_clear(&packfile_uris, 0);
 	strvec_clear(&index_pack_args);
 
diff --git a/t/t5702-protocol-v2.sh b/t/t5702-protocol-v2.sh
index 2e1243ca40b0..0476b3f50455 100755
--- a/t/t5702-protocol-v2.sh
+++ b/t/t5702-protocol-v2.sh
@@ -848,10 +848,12 @@ test_expect_success 'part of packfile response provided as URI' '
 	configure_exclusion "$P" my-blob >h &&
 	configure_exclusion "$P" other-blob >h2 &&
 
-	GIT_TRACE=1 GIT_TRACE_PACKET="$(pwd)/log" GIT_TEST_SIDEBAND_ALL=1 \
+	GIT_PROGRESS_DELAY=0 GIT_TRACE=1 GIT_TRACE2_EVENT=1 \
+	GIT_TRACE_PACKET="$(pwd)/log" GIT_TEST_SIDEBAND_ALL=1 \
 	git -c protocol.version=2 \
 		-c fetch.uriprotocols=http,https \
-		clone "$HTTPD_URL/smart/http_parent" http_child &&
+		clone "$HTTPD_URL/smart/http_parent" http_child \
+		--progress 2>progress &&
 
 	# Ensure that my-blob and other-blob are in separate packfiles.
 	for idx in http_child/.git/objects/pack/*.idx
@@ -875,6 +877,8 @@ test_expect_success 'part of packfile response provided as URI' '
 	test -f hfound &&
 	test -f h2found &&
 
+	test_i18ngrep "Downloading packs" progress &&
+
 	# Ensure that there are exactly 3 packfiles with associated .idx
 	ls http_child/.git/objects/pack/*.pack \
 	    http_child/.git/objects/pack/*.idx >filelist &&

base-commit: a5828ae6b52137b913b978e16cd2334482eb4c1f
-- 
gitgitgadget
