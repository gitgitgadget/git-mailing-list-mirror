Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 509E020281
	for <e@80x24.org>; Fri, 29 Sep 2017 20:12:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752602AbdI2UMh (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Sep 2017 16:12:37 -0400
Received: from mail-pf0-f179.google.com ([209.85.192.179]:51727 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752621AbdI2UM3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Sep 2017 16:12:29 -0400
Received: by mail-pf0-f179.google.com with SMTP id b70so331671pfl.8
        for <git@vger.kernel.org>; Fri, 29 Sep 2017 13:12:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=WyYNSkXdZupU/+GTHFFxSlEM4zUz4OqII7YViZbBu00=;
        b=fKUqonnu1xDF5lvsOvxuElqSM+3ZSz/DU0mTDRh4UMu473HCf7i/H9hIzOREmBm5b8
         6AkAamNi1jYtSq5jmpPiiYHTtzaLskLn/w+F3WpIcSgWRdilwOSduVvKqpztcRa709K1
         qlL/RA9dFGab8k8jAHWljmgwaSIETXAIb5Md+MkzkOBJkp6WKYczRV5EDEFo9VXqhouO
         iDF8Q8dRvSB0ZaP32GAY1G/bUzbC/RenB6IZ73Qoer5UkIZVyNLs/A1M3noAn5rNYjn3
         8dIaZCpJtFVt5DolUrbXBdfEJledydhPIcTx5FnmZUbASWw/I8NdSn2rhNZ9Ut0kPdAU
         pVEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=WyYNSkXdZupU/+GTHFFxSlEM4zUz4OqII7YViZbBu00=;
        b=atXK+zoBfvf/e9dER+LOss5M7RkdH3iZel1AzbLugzmyfg4DIzIa7mitDuN7TnD8ZA
         JTrT0rZ/dFYaB9CYxWnpgLKhiLsE8yooERwe/1KDO90ZxDeEbBd0MYlPEHpX6uYZdEef
         opb2A5rp6GfM22+WC+qWpKZmv8r11z99hLOX1EtVHo7OjufNjlTW9RgsTFkAPmWN8GYk
         gZy+naPqZ9L+ngDmVEg54dziFNsj12VBV0AURdshs+dFSrYe6JTSxN8+kFaCdVeuj3a5
         zw0qzzYc6GLzm4u4wE3C46KIGX49JbSAe2iphKAtYZR9i9ntOkk8nY/puPa2GsY3IuLE
         RvKg==
X-Gm-Message-State: AHPjjUjHfRgWjDuzmSTe69WfTJMJPfwDUXVoMmY/6nYZO72bu95qlCA2
        l7Lb61U7SJRPV0sjLEjMvgw1kr4kyWw=
X-Google-Smtp-Source: AOwi7QBW5k+Tc1zPVX2fpZDmFPvvzeC7SNjwMIDOUz3P8anLguiEbK5R0fgl6duR2AiZsi7Po0paHg==
X-Received: by 10.84.248.144 with SMTP id q16mr8303624pll.345.1506715948373;
        Fri, 29 Sep 2017 13:12:28 -0700 (PDT)
Received: from twelve3.mtv.corp.google.com ([100.96.218.44])
        by smtp.gmail.com with ESMTPSA id g5sm9280561pgo.66.2017.09.29.13.12.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 29 Sep 2017 13:12:27 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com,
        git@jeffhostetler.com, peartben@gmail.com,
        christian.couder@gmail.com
Subject: [PATCH 16/18] clone: configure blobmaxbytes in created repos
Date:   Fri, 29 Sep 2017 13:11:52 -0700
Message-Id: <407a298b52a9e0a2ee4135fe844e35b9a14c0f7b.1506714999.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.14.1.748.g20475d2c7
In-Reply-To: <cover.1506714999.git.jonathantanmy@google.com>
References: <cover.1506714999.git.jonathantanmy@google.com>
In-Reply-To: <cover.1506714999.git.jonathantanmy@google.com>
References: <cover.1506714999.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teach clone to configure blobmaxbytes in any repos that it generates
when the --blob-max-bytes parameter is set. Also teach fetch to use this
parameter.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 builtin/clone.c       |  1 +
 builtin/fetch.c       |  4 ++++
 remote.c              |  2 ++
 remote.h              |  2 ++
 t/t5500-fetch-pack.sh | 64 ++++++++++++++++++++++++++++++++++++++++++++++-----
 5 files changed, 67 insertions(+), 6 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 4c2193dc4..58cbc8ae3 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -1179,6 +1179,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 		git_config_set("core.repositoryformatversion", "1");
 		git_config_set("extensions.partialclone", "origin");
 		repository_format_partial_clone = "origin";
+		git_config_set("remote.origin.blobmaxbytes", blob_max_bytes);
 	}
 
 	if (is_local)
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 07beaf5b5..ace238554 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1050,6 +1050,10 @@ static struct transport *prepare_transport(struct remote *remote, int deepen)
 	if (blob_max_bytes) {
 		set_option(transport, TRANS_OPT_BLOB_MAX_BYTES, blob_max_bytes);
 		set_option(transport, TRANS_OPT_FROM_PROMISOR, "1");
+	} else if (remote->blob_max_bytes) {
+		set_option(transport, TRANS_OPT_BLOB_MAX_BYTES,
+			   remote->blob_max_bytes);
+		set_option(transport, TRANS_OPT_FROM_PROMISOR, "1");
 	}
 	return transport;
 }
diff --git a/remote.c b/remote.c
index 411309006..eade3c312 100644
--- a/remote.c
+++ b/remote.c
@@ -440,6 +440,8 @@ static int handle_config(const char *key, const char *value, void *cb)
 					 key, value);
 	} else if (!strcmp(subkey, "vcs")) {
 		return git_config_string(&remote->foreign_vcs, key, value);
+	} else if (!strcmp(subkey, "blobmaxbytes")) {
+		return git_config_string(&remote->blob_max_bytes, key, value);
 	}
 	return 0;
 }
diff --git a/remote.h b/remote.h
index 2ecf4c8c7..3d56e62b7 100644
--- a/remote.h
+++ b/remote.h
@@ -56,6 +56,8 @@ struct remote {
 	 */
 	char *http_proxy;
 	char *http_proxy_authmethod;
+
+	const char *blob_max_bytes;
 };
 
 struct remote *remote_get(const char *name);
diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
index b2682862f..ee533ea32 100755
--- a/t/t5500-fetch-pack.sh
+++ b/t/t5500-fetch-pack.sh
@@ -782,9 +782,9 @@ test_expect_success '--blob-max-bytes has no effect if support for it is not adv
 	test_i18ngrep "blob-max-bytes not recognized by server" err
 '
 
-fetch_blob_max_bytes () {
-	SERVER="$1"
-	URL="$2"
+setup_blob_max_bytes () {
+	SERVER="$1" &&
+	URL="$2" &&
 
 	rm -rf "$SERVER" client &&
 	test_create_repo "$SERVER" &&
@@ -794,7 +794,11 @@ fetch_blob_max_bytes () {
 	git clone "$URL" client &&
 	test_config -C client extensions.partialclone origin &&
 
-	test_commit -C "$SERVER" two &&
+	test_commit -C "$SERVER" two
+}
+
+do_blob_max_bytes() {
+	SERVER="$1" &&
 
 	git -C client fetch --blob-max-bytes=0 origin HEAD:somewhere &&
 
@@ -805,14 +809,62 @@ fetch_blob_max_bytes () {
 }
 
 test_expect_success 'fetch with --blob-max-bytes' '
-	fetch_blob_max_bytes server server
+	setup_blob_max_bytes server server &&
+	do_blob_max_bytes server
+'
+
+test_expect_success 'fetch respects configured blobmaxbytes' '
+	setup_blob_max_bytes server server &&
+
+	test_config -C client remote.origin.blobmaxbytes 0 &&
+
+	git -C client fetch origin HEAD:somewhere &&
+
+	# Ensure that commit is fetched, but blob is not
+	test_config -C client extensions.partialclone "arbitrary string" &&
+	git -C client cat-file -e $(git -C server rev-parse two) &&
+	test_must_fail git -C client cat-file -e $(git hash-object server/two.t)
+'
+
+test_expect_success 'pull respects configured blobmaxbytes' '
+	setup_blob_max_bytes server server &&
+
+	# Hide two.t from tip so that client does not load it upon the
+	# automatic checkout that pull performs
+	git -C server rm two.t &&
+	test_commit -C server three &&
+
+	test_config -C server uploadpack.allowanysha1inwant 1 &&
+	test_config -C client remote.origin.blobmaxbytes 0 &&
+
+	git -C client pull origin &&
+
+	# Ensure that commit is fetched, but blob is not
+	test_config -C client extensions.partialclone "arbitrary string" &&
+	git -C client cat-file -e $(git -C server rev-parse two) &&
+	test_must_fail git -C client cat-file -e $(git hash-object server/two.t)
+'
+
+test_expect_success 'clone configures blobmaxbytes' '
+	rm -rf server client &&
+	test_create_repo server &&
+	test_commit -C server one &&
+	test_commit -C server two &&
+	test_config -C server uploadpack.allowanysha1inwant 1 &&
+
+	git clone --blob-max-bytes=12345 server client &&
+
+	# Ensure that we can, for example, checkout HEAD^
+	rm -rf client/.git/objects/* &&
+	git -C client checkout HEAD^
 '
 
 . "$TEST_DIRECTORY"/lib-httpd.sh
 start_httpd
 
 test_expect_success 'fetch with --blob-max-bytes and HTTP' '
-	fetch_blob_max_bytes "$HTTPD_DOCUMENT_ROOT_PATH/server" "$HTTPD_URL/smart/server"
+	setup_blob_max_bytes "$HTTPD_DOCUMENT_ROOT_PATH/server" "$HTTPD_URL/smart/server" &&
+	do_blob_max_bytes "$HTTPD_DOCUMENT_ROOT_PATH/server"
 '
 
 stop_httpd
-- 
2.14.2.822.g60be5d43e6-goog

