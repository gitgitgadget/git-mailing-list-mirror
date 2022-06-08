Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 407F1C43334
	for <git@archiver.kernel.org>; Wed,  8 Jun 2022 09:29:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234800AbiFHJ3N (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Jun 2022 05:29:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235539AbiFHJ2l (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Jun 2022 05:28:41 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3C6BA3092
        for <git@vger.kernel.org>; Wed,  8 Jun 2022 01:53:30 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id u3so27396200wrg.3
        for <git@vger.kernel.org>; Wed, 08 Jun 2022 01:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=yWfzgpPuvmqKzFu7UDgz3L0TOcvBLP3br/YCvTraoN8=;
        b=havJ6bj0lmOLbBa4RDTWr/cwjTHvo1I7+D13IDPtyU9qopRGDP8U84j8f/EL5Cpzdb
         S3dd5LN2GA9zV7qD0iFLZ53ZX8H2LnrU25PCt6ULKXyYac3gxcUVE9kj0hoCQnfQbN68
         2qlcC98flfHT7ntKa0jht7E7Lv1WcRIbUx2Uko/E0Ok4ytXfIGny99oeI3AnpahpYurx
         cqqV66GQRMkLxpcSgMkdYdwTyEIu+xNFy9JrJHM+vJrF0YgsKv/jyLwZ1SexqC1k+sah
         j/4MbjmwBXdQ/TAtOoFsRF5DlzHUfdaLENBmt94lDHJpuaKiYhd2LPr0h/Wqa8c38z9k
         A1KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=yWfzgpPuvmqKzFu7UDgz3L0TOcvBLP3br/YCvTraoN8=;
        b=Y14bkNo/J2W/t/Wt2q9F6R4h1Z21TnPif7ChAoE0UQvpEj/Ayv396PmoXcFG49eZvJ
         fGTTOtfFq0Xsj0bCSXpZJwpSqrUF2C1CIjGaYWhbQ53hXACFK3N1m8+XuoHaxA3pzWjw
         EsNmY/ldSl5tUs2Ev59O1WRM+daFyREQjRFdkloRkp4TaAx9c/B01j8GtUY0h2Z904dR
         j/gElaAYiJ82hOCzVtTe0c57stVzs0xFFWz+DhvO+i8LnaRk0M+HKJm+tnEE6siWYSm/
         bNT6Nkkn6ADZCSqzHFVu6K/XCHUs9C7xUd7C7t76JoJJSAOMjL1hHk3Z0DpOTvOOISyW
         +a+A==
X-Gm-Message-State: AOAM530eKrN2Ihn88PKqBu3QrNoXamycu3Y6KKnUw3jTFL5iwndN0eQ/
        6pobQJTyUdASvykz/GYd+1Web2VnYUShE/HM
X-Google-Smtp-Source: ABdhPJxvydr9WUDOQNML2Tf27DHt7PjGZ85mqfK+byRRYbofpKT0C/n6ZAQ6wpX7ix2GaY3yCZ48qg==
X-Received: by 2002:a5d:52c7:0:b0:210:ac6:3956 with SMTP id r7-20020a5d52c7000000b002100ac63956mr32387358wrv.379.1654678409042;
        Wed, 08 Jun 2022 01:53:29 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y6-20020adfee06000000b0021004d7d75asm20915470wrn.84.2022.06.08.01.53.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jun 2022 01:53:28 -0700 (PDT)
Message-Id: <pull.1251.git.1654678407365.gitgitgadget@gmail.com>
From:   "Li Linchao via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 08 Jun 2022 08:53:27 +0000
Subject: [PATCH] remote-curl: send Accept-Language header to server
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Li Linchao <lilinchao@oschina.cn>,
        Cactusinhand <lilinchao@oschina.cn>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Cactusinhand <lilinchao@oschina.cn>

Git server end's ability to accept Accept-Language header was introduced
in f18604bbf2(http: add Accept-Language header if possible), but this is
only used by very early phase of the transfer, that's HTTP GET request to
discover references. For other phases, like POST request in the smart HTTP
the server side don't know what language client speak.

This patch teaches git client to learn end-user's preferred language and
throw accept-language header to server side. Once server get this header
it have ability to talk to end-user with language they understand, this
would be very helpful for many non-English speakers.

Signed-off-by: Li Linchao <lilinchao@oschina.cn>
---
    remote-curl: send Accept-Language header to server
    
    Teach git client to learn end-user's preferred language and throw
    accept-language header to server side. As git is developmented and
    maintained by English, many developer may ignore Non-English speaker
    experience. This patch give git server the ability to speak to client
    end with their preferred language, which can be very helpfuly and
    friendly to understand the exact meaning of some prompt messages sent by
    git.
    
    TODO: For SSH tranport, give it an environment variable to understand
    locale language.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1251%2FCactusinhand%2Fllc%2Fsend-Accept-Language-header-to-HTTP-server-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1251/Cactusinhand/llc/send-Accept-Language-header-to-HTTP-server-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1251

 http.c                      |  2 +-
 http.h                      |  3 +++
 remote-curl.c               | 18 +++++++++++++++++-
 t/t5541-http-push-smart.sh  | 19 +++++++++++++++++++
 t/t5550-http-fetch-dumb.sh  |  2 +-
 t/t5551-http-fetch-smart.sh | 10 ++++++++--
 6 files changed, 49 insertions(+), 5 deletions(-)

diff --git a/http.c b/http.c
index 11c6f69facd..0654e111d1d 100644
--- a/http.c
+++ b/http.c
@@ -1775,7 +1775,7 @@ static void write_accept_language(struct strbuf *buf)
  *   LANGUAGE= LANG=en_US.UTF-8 -> "Accept-Language: en-US, *; q=0.1"
  *   LANGUAGE= LANG=C -> ""
  */
-static const char *get_accept_language(void)
+const char *get_accept_language(void)
 {
 	if (!cached_accept_language) {
 		struct strbuf buf = STRBUF_INIT;
diff --git a/http.h b/http.h
index ba303cfb372..c5039a0208e 100644
--- a/http.h
+++ b/http.h
@@ -178,6 +178,9 @@ int http_fetch_ref(const char *base, struct ref *ref);
 int http_get_info_packs(const char *base_url,
 			struct packed_git **packs_head);
 
+/* Helper for getting Accept-Language header */
+const char *get_accept_language(void);
+
 struct http_pack_request {
 	char *url;
 
diff --git a/remote-curl.c b/remote-curl.c
index 67f178b1120..8acf506705c 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -580,6 +580,7 @@ struct rpc_state {
 	char *service_url;
 	char *hdr_content_type;
 	char *hdr_accept;
+	char *hdr_accept_language;
 	char *protocol_header;
 	char *buf;
 	size_t alloc;
@@ -932,6 +933,10 @@ static int post_rpc(struct rpc_state *rpc, int stateless_connect, int flush_rece
 	headers = curl_slist_append(headers, needs_100_continue ?
 		"Expect: 100-continue" : "Expect:");
 
+	/* Add Accept-Language header */
+	if (rpc->hdr_accept_language)
+		headers = curl_slist_append(headers, rpc->hdr_accept_language);
+
 	/* Add the extra Git-Protocol header */
 	if (rpc->protocol_header)
 		headers = curl_slist_append(headers, rpc->protocol_header);
@@ -1058,6 +1063,7 @@ static int rpc_service(struct rpc_state *rpc, struct discovery *heads,
 		       struct strbuf *rpc_result)
 {
 	const char *svc = rpc->service_name;
+	const char *accept_language;
 	struct strbuf buf = STRBUF_INIT;
 	struct child_process client = CHILD_PROCESS_INIT;
 	int err = 0;
@@ -1080,6 +1086,12 @@ static int rpc_service(struct rpc_state *rpc, struct discovery *heads,
 	strbuf_addf(&buf, "%s%s", url.buf, svc);
 	rpc->service_url = strbuf_detach(&buf, NULL);
 
+	accept_language = get_accept_language();
+	if (accept_language) {
+		strbuf_addstr(&buf, accept_language);
+		rpc->hdr_accept_language = strbuf_detach(&buf, NULL);
+	}
+
 	strbuf_addf(&buf, "Content-Type: application/x-%s-request", svc);
 	rpc->hdr_content_type = strbuf_detach(&buf, NULL);
 
@@ -1400,7 +1412,7 @@ static int stateless_connect(const char *service_name)
 	struct discovery *discover;
 	struct rpc_state rpc;
 	struct strbuf buf = STRBUF_INIT;
-
+	const char *accept_language;
 	/*
 	 * Run the info/refs request and see if the server supports protocol
 	 * v2.  If and only if the server supports v2 can we successfully
@@ -1418,6 +1430,10 @@ static int stateless_connect(const char *service_name)
 		printf("\n");
 		fflush(stdout);
 	}
+	accept_language = get_accept_language();
+	if (accept_language) {
+		rpc.hdr_accept_language = xstrfmt("%s", accept_language);
+	}
 
 	rpc.service_name = service_name;
 	rpc.service_url = xstrfmt("%s%s", url.buf, rpc.service_name);
diff --git a/t/t5541-http-push-smart.sh b/t/t5541-http-push-smart.sh
index 2f09ff4fac6..4288a279e9e 100755
--- a/t/t5541-http-push-smart.sh
+++ b/t/t5541-http-push-smart.sh
@@ -80,6 +80,25 @@ test_expect_success 'push to remote repository (standard)' '
 	 test $HEAD = $(git rev-parse --verify HEAD))
 '
 
+test_expect_success 'push to remote repository (standard) with sending Accept-Language' '
+	cat >exp <<-\EOF &&
+	=> Send header: Accept-Language: zh-CN, en;q=0.9, *;q=0.8
+	=> Send header: Accept-Language: zh-CN, en;q=0.9, *;q=0.8
+	EOF
+
+	cd "$ROOT_PATH"/test_repo_clone &&
+	: >path_lang &&
+	git add path_lang &&
+	test_tick &&
+	git commit -m path_lang &&
+	HEAD=$(git rev-parse --verify HEAD) &&
+	GIT_TRACE_CURL=true LANGUAGE="zh_CN:en" git push -v -v 2>err &&
+	! grep "Expect: 100-continue" err &&
+
+	grep "=> Send header: Accept-Language:" err >err.language &&
+	test_cmp exp err.language
+'
+
 test_expect_success 'push already up-to-date' '
 	git push
 '
diff --git a/t/t5550-http-fetch-dumb.sh b/t/t5550-http-fetch-dumb.sh
index f0d9cd584d3..bc308519af5 100755
--- a/t/t5550-http-fetch-dumb.sh
+++ b/t/t5550-http-fetch-dumb.sh
@@ -369,7 +369,7 @@ ja;q=0.95, zh;q=0.94, sv;q=0.93, pt;q=0.92, nb;q=0.91, *;q=0.90" \
 		ko_KR.EUC-KR:en_US.UTF-8:fr_CA:de.UTF-8@euro:sr@latin:ja:zh:sv:pt:nb
 '
 
-test_expect_success 'git client does not send an empty Accept-Language' '
+test_expect_success 'git client send an empty Accept-Language' '
 	GIT_TRACE_CURL=true LANGUAGE= git ls-remote "$HTTPD_URL/dumb/repo.git" 2>stderr &&
 	! grep "^=> Send header: Accept-Language:" stderr
 '
diff --git a/t/t5551-http-fetch-smart.sh b/t/t5551-http-fetch-smart.sh
index b9351a732f6..6f65131a4e4 100755
--- a/t/t5551-http-fetch-smart.sh
+++ b/t/t5551-http-fetch-smart.sh
@@ -31,6 +31,7 @@ test_expect_success 'clone http repository' '
 	> GET /smart/repo.git/info/refs?service=git-upload-pack HTTP/1.1
 	> Accept: */*
 	> Accept-Encoding: ENCODINGS
+	> Accept-Language: zh-CN, en;q=0.9, *;q=0.8
 	> Pragma: no-cache
 	< HTTP/1.1 200 OK
 	< Pragma: no-cache
@@ -40,13 +41,15 @@ test_expect_success 'clone http repository' '
 	> Accept-Encoding: ENCODINGS
 	> Content-Type: application/x-git-upload-pack-request
 	> Accept: application/x-git-upload-pack-result
+	> Accept-Language: zh-CN, en;q=0.9, *;q=0.8
 	> Content-Length: xxx
 	< HTTP/1.1 200 OK
 	< Pragma: no-cache
 	< Cache-Control: no-cache, max-age=0, must-revalidate
 	< Content-Type: application/x-git-upload-pack-result
 	EOF
-	GIT_TRACE_CURL=true GIT_TEST_PROTOCOL_VERSION=0 \
+
+	GIT_TRACE_CURL=true GIT_TEST_PROTOCOL_VERSION=0 LANGUAGE="zh_CN:en" \
 		git clone --quiet $HTTPD_URL/smart/repo.git clone 2>err &&
 	test_cmp file clone/file &&
 	tr '\''\015'\'' Q <err |
@@ -94,7 +97,10 @@ test_expect_success 'clone http repository' '
 		test_cmp exp actual.smudged &&
 
 		grep "Accept-Encoding:.*gzip" actual >actual.gzip &&
-		test_line_count = 2 actual.gzip
+		test_line_count = 2 actual.gzip &&
+
+		grep "Accept-Language: zh-CN, en" actual >actual.language &&
+		test_line_count = 2 actual.language
 	fi
 '
 

base-commit: ab336e8f1c8009c8b1aab8deb592148e69217085
-- 
gitgitgadget
