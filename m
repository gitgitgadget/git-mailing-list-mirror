Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B893CC432BE
	for <git@archiver.kernel.org>; Fri, 30 Jul 2021 09:35:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90D1C60EFD
	for <git@archiver.kernel.org>; Fri, 30 Jul 2021 09:35:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238409AbhG3JfZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Jul 2021 05:35:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238395AbhG3JfM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Jul 2021 05:35:12 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1817FC061796
        for <git@vger.kernel.org>; Fri, 30 Jul 2021 02:35:08 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id p5so10473443wro.7
        for <git@vger.kernel.org>; Fri, 30 Jul 2021 02:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eEXeBKHIUwCUIIZc1vWFhEIlhiwH0AhirZzsUsDqYNk=;
        b=J0yB+qYfmYiUQqxU/SNL4n8UIMEDJ0lDyNhnQHAa/KibFtRD3X0waJOY46CCVvEPhm
         pzfcXl3uEQ+6js1/MyPk9i4qaOwwQJTHa1Bdt5GOlkFJ5ecmOjKY6rHi58vwCiE4C16/
         YFIMkLhC1o4e6FB90skYUJlhKLONb2mqGbA5q94zu3Sc5sh/xKe6mkqGgKHGI+xGf/2w
         DWovEWa3ZfujjcoZdhr+X1BhYvUypwPu5CUY1AFBi4xkeMR3s92V5SLVynmrq3/o2oq6
         VXDUi2hU4H/6fDotm03js6T/s85jmLDeswUYPvuNbEDDfBG9Y3UpA54LAFzw7gxoRULg
         dliQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eEXeBKHIUwCUIIZc1vWFhEIlhiwH0AhirZzsUsDqYNk=;
        b=LZr2S5QxAD/lak2SSLKDq0cvDU/k8JXxzUvi8zSzu+DagxeA4URY79RHOYq/tddhph
         WeOQbJVLD2LI2CXU/ooFxZCeurtXQ0FwsuF6IzBIPB6Ky5ZBaBnZp2fUYaz5cDFmpf25
         oFty7em+EyyG3mk5d+bQWx82spYueWdQbVX8iJs1k8GGSfcfFHmShGbU21XxT53GjjPC
         +Jz6m9C66RXa3hiwZ+ebZXGQB7+DrVkCliNbucc5xxsWIgD9fyXElCqbzfC4qyA8wspB
         V+XuzMb2NuEXKY3H8sckEaJvwsy2+LKUl0k4aUQhv1qIV9oWYIsXTT9mZv2tNUOmXK+9
         ByNg==
X-Gm-Message-State: AOAM531HrBYi/MMEW0KVG+jZuNvXwcWqHznPghBAxyH/aqM+alDzsHhU
        ZF8xV9CmZVy2BP6d7PUTlhPQ2Erl01U1qg==
X-Google-Smtp-Source: ABdhPJwNMh8iJm558TLvhPwl+YSOTfndHQvl/hMxJOk65hNKWUnIIH4ltE+3TWyeScF9H4UTO/MRGw==
X-Received: by 2002:adf:d20c:: with SMTP id j12mr2037143wrh.74.1627637706437;
        Fri, 30 Jul 2021 02:35:06 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id t17sm1089903wru.94.2021.07.30.02.35.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jul 2021 02:35:06 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Nicolas Morey-Chaisemartin <NMoreyChaisemartin@suse.de>,
        "Tom G . Christensen" <tgc@jupiterrise.com>,
        Mischa POSLAWSKY <git@shiar.nl>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 6/7] http: rename CURLOPT_FILE to CURLOPT_WRITEDATA
Date:   Fri, 30 Jul 2021 11:31:58 +0200
Message-Id: <patch-v3-6.7-95e42b17ce8-20210730T092843Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.1069.g516d52f3d85
In-Reply-To: <cover-v3-0.7-00000000000-20210730T092843Z-avarab@gmail.com>
References: <cover-0.5-00000000000-20210721T220402Z-avarab@gmail.com> <cover-v3-0.7-00000000000-20210730T092843Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The CURLOPT_FILE name is an alias for CURLOPT_WRITEDATA, the
CURLOPT_WRITEDATA name has been preferred since curl 7.9.7, released
in May 2002[1].

1. https://curl.se/libcurl/c/CURLOPT_WRITEDATA.html

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 http-push.c   | 6 +++---
 http-walker.c | 2 +-
 http.c        | 6 +++---
 remote-curl.c | 4 ++--
 4 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/http-push.c b/http-push.c
index aa3de7c1086..3309aaf004a 100644
--- a/http-push.c
+++ b/http-push.c
@@ -883,7 +883,7 @@ static struct remote_lock *lock_remote(const char *path, long timeout)
 	slot->results = &results;
 	curl_setup_http(slot->curl, url, DAV_LOCK, &out_buffer, fwrite_buffer);
 	curl_easy_setopt(slot->curl, CURLOPT_HTTPHEADER, dav_headers);
-	curl_easy_setopt(slot->curl, CURLOPT_FILE, &in_buffer);
+	curl_easy_setopt(slot->curl, CURLOPT_WRITEDATA, &in_buffer);
 
 	CALLOC_ARRAY(lock, 1);
 	lock->timeout = -1;
@@ -1142,7 +1142,7 @@ static void remote_ls(const char *path, int flags,
 	curl_setup_http(slot->curl, url, DAV_PROPFIND,
 			&out_buffer, fwrite_buffer);
 	curl_easy_setopt(slot->curl, CURLOPT_HTTPHEADER, dav_headers);
-	curl_easy_setopt(slot->curl, CURLOPT_FILE, &in_buffer);
+	curl_easy_setopt(slot->curl, CURLOPT_WRITEDATA, &in_buffer);
 
 	if (start_active_slot(slot)) {
 		run_active_slot(slot);
@@ -1216,7 +1216,7 @@ static int locking_available(void)
 	curl_setup_http(slot->curl, repo->url, DAV_PROPFIND,
 			&out_buffer, fwrite_buffer);
 	curl_easy_setopt(slot->curl, CURLOPT_HTTPHEADER, dav_headers);
-	curl_easy_setopt(slot->curl, CURLOPT_FILE, &in_buffer);
+	curl_easy_setopt(slot->curl, CURLOPT_WRITEDATA, &in_buffer);
 
 	if (start_active_slot(slot)) {
 		run_active_slot(slot);
diff --git a/http-walker.c b/http-walker.c
index 19e31623f04..910fae539b8 100644
--- a/http-walker.c
+++ b/http-walker.c
@@ -378,7 +378,7 @@ static void fetch_alternates(struct walker *walker, const char *base)
 	alt_req.walker = walker;
 	slot->callback_data = &alt_req;
 
-	curl_easy_setopt(slot->curl, CURLOPT_FILE, &buffer);
+	curl_easy_setopt(slot->curl, CURLOPT_WRITEDATA, &buffer);
 	curl_easy_setopt(slot->curl, CURLOPT_WRITEFUNCTION, fwrite_buffer);
 	curl_easy_setopt(slot->curl, CURLOPT_URL, url.buf);
 
diff --git a/http.c b/http.c
index 477bf591141..56856178bfe 100644
--- a/http.c
+++ b/http.c
@@ -1767,7 +1767,7 @@ static int http_request(const char *url,
 		curl_easy_setopt(slot->curl, CURLOPT_NOBODY, 1);
 	} else {
 		curl_easy_setopt(slot->curl, CURLOPT_NOBODY, 0);
-		curl_easy_setopt(slot->curl, CURLOPT_FILE, result);
+		curl_easy_setopt(slot->curl, CURLOPT_WRITEDATA, result);
 
 		if (target == HTTP_REQUEST_FILE) {
 			off_t posn = ftello(result);
@@ -2184,7 +2184,7 @@ struct http_pack_request *new_direct_http_pack_request(
 	}
 
 	preq->slot = get_active_slot();
-	curl_easy_setopt(preq->slot->curl, CURLOPT_FILE, preq->packfile);
+	curl_easy_setopt(preq->slot->curl, CURLOPT_WRITEDATA, preq->packfile);
 	curl_easy_setopt(preq->slot->curl, CURLOPT_WRITEFUNCTION, fwrite);
 	curl_easy_setopt(preq->slot->curl, CURLOPT_URL, preq->url);
 	curl_easy_setopt(preq->slot->curl, CURLOPT_HTTPHEADER,
@@ -2355,7 +2355,7 @@ struct http_object_request *new_http_object_request(const char *base_url,
 
 	freq->slot = get_active_slot();
 
-	curl_easy_setopt(freq->slot->curl, CURLOPT_FILE, freq);
+	curl_easy_setopt(freq->slot->curl, CURLOPT_WRITEDATA, freq);
 	curl_easy_setopt(freq->slot->curl, CURLOPT_FAILONERROR, 0);
 	curl_easy_setopt(freq->slot->curl, CURLOPT_WRITEFUNCTION, fwrite_sha1_file);
 	curl_easy_setopt(freq->slot->curl, CURLOPT_ERRORBUFFER, freq->errorstr);
diff --git a/remote-curl.c b/remote-curl.c
index 09f09aeece3..598cff7cde6 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -853,7 +853,7 @@ static int probe_rpc(struct rpc_state *rpc, struct slot_results *results)
 	curl_easy_setopt(slot->curl, CURLOPT_POSTFIELDSIZE, 4);
 	curl_easy_setopt(slot->curl, CURLOPT_HTTPHEADER, headers);
 	curl_easy_setopt(slot->curl, CURLOPT_WRITEFUNCTION, fwrite_buffer);
-	curl_easy_setopt(slot->curl, CURLOPT_FILE, &buf);
+	curl_easy_setopt(slot->curl, CURLOPT_WRITEDATA, &buf);
 
 	err = run_slot(slot, results);
 
@@ -1016,7 +1016,7 @@ static int post_rpc(struct rpc_state *rpc, int stateless_connect, int flush_rece
 	rpc_in_data.slot = slot;
 	rpc_in_data.check_pktline = stateless_connect;
 	memset(&rpc_in_data.pktline_state, 0, sizeof(rpc_in_data.pktline_state));
-	curl_easy_setopt(slot->curl, CURLOPT_FILE, &rpc_in_data);
+	curl_easy_setopt(slot->curl, CURLOPT_WRITEDATA, &rpc_in_data);
 	curl_easy_setopt(slot->curl, CURLOPT_FAILONERROR, 0);
 
 
-- 
2.32.0.1069.g516d52f3d85

