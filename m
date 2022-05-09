Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFD6FC433EF
	for <git@archiver.kernel.org>; Mon,  9 May 2022 15:38:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238382AbiEIPmv (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 May 2022 11:42:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238381AbiEIPmu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 May 2022 11:42:50 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A02D92B3F57
        for <git@vger.kernel.org>; Mon,  9 May 2022 08:38:51 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id m2-20020a1ca302000000b003943bc63f98so8503841wme.4
        for <git@vger.kernel.org>; Mon, 09 May 2022 08:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AaBYgvE0UDvI9CspZPrJ4/1i8UBwZs8mPIfNbu2ACpQ=;
        b=bgnEjDNEUsEKDQ7dY+GhXqygRXThCucLnv06WpBvHOFCErlZxnBIPb0j4AaEto+eiY
         xbjmk83GhDkkf6OexptiL1cr/Ojmewmj6g9wSVukCZhY3M0ZFq/CYi1eIiSenFmQl4EI
         h6/ola02cHgyVFOlpxracAQaN131raNJ8dnlL1hG/O2wDNJ59I9+NGXfB+jfnYo39CUC
         I82m+EVRJk+yNOZcYAcnjbPnf3IG9Y/4lJft0bJFKZpVDc/ZiMGEkuffoF0MoQBP0tOM
         TWtwAYN1BP2oJNf2PVTQD3n3x8rPP8/M/yURl6pJyVjqbBEYhNuYL0lQurq0dMDoTtuE
         lfUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AaBYgvE0UDvI9CspZPrJ4/1i8UBwZs8mPIfNbu2ACpQ=;
        b=tWET2DrqE/pyjKtrn4O9Fvp0CQvCgXOfkPwSjMPVKhlVYU77/0hZSs3py90+dPGT76
         5waOm8+iBYNf1lAheLHhvo5Qqbx0X/hy2pBW1uMECTIWityCzZcO1dsGz+HF7S1ltS7D
         moslWhmNvXE4/cXphPRC4c1/US2D0BLxVluzxtXT8BNht4QPDuqcPI0W+soZ9NjIsNoj
         uU/AkctXH7CJK8kZARgtdkQbcDdM5m9DTbKTb9LP2sIYgcuLm4iqOqRoP8VLjjeE0ypF
         9ARxNFW/xxATacsxxEbz/kSRvH85BnHf36MijYFXZj2gLVDmtoBCp5sl4KoVkVXQ/DTF
         EApQ==
X-Gm-Message-State: AOAM533oMHzV1VYU+pOy0zek1qmiWZxdTmby3IOBoimCh12msoM7EXs+
        Rluee94IRUiW2f4HvH/7Hom62ETw9XY=
X-Google-Smtp-Source: ABdhPJyAOSULpp+2ultHLRMwIxaeMcknUlyrtTG12/de548bTXDNZxnlUMHC8jblJBJuLoncuAT8cw==
X-Received: by 2002:a1c:f211:0:b0:381:6c60:742f with SMTP id s17-20020a1cf211000000b003816c60742fmr17199064wmc.130.1652110729750;
        Mon, 09 May 2022 08:38:49 -0700 (PDT)
Received: from localhost.localdomain ([2001:861:3005:2510:437:42e3:f7fd:f839])
        by smtp.gmail.com with ESMTPSA id r17-20020a05600c425100b003942a244ee2sm13935539wmm.39.2022.05.09.08.38.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 May 2022 08:38:49 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Derrick Stolee <derrickstolee@github.com>,
        Carlo Arenas <carenas@gmail.com>
Subject: [PATCH v3] http: add custom hostname to IP address resolutions
Date:   Mon,  9 May 2022 17:38:34 +0200
Message-Id: <20220509153834.485871-1-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.36.1.20.g51170867bd
In-Reply-To: <20220504104601.136403-1-chriscool@tuxfamily.org>
References: <20220504104601.136403-1-chriscool@tuxfamily.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Libcurl has a CURLOPT_RESOLVE easy option that allows
the result of hostname resolution in the following
format to be passed:

	[+]HOST:PORT:ADDRESS[,ADDRESS]

This way, redirects and everything operating against the
HOST+PORT will use the provided ADDRESS(s).

The following format is also allowed to stop using
hostname resolutions that have already been passed:

	-HOST:PORT

See https://curl.se/libcurl/c/CURLOPT_RESOLVE.html for
more details.

Let's add a corresponding "http.curloptResolve" config
option that takes advantage of CURLOPT_RESOLVE.

Each value configured for the "http.curloptResolve" key
is passed "as is" to libcurl through CURLOPT_RESOLVE, so
it should be in one of the above 2 formats. This keeps
the implementation simple and makes us consistent with
libcurl's CURLOPT_RESOLVE, and with curl's corresponding
`--resolve` command line option.

The implementation uses CURLOPT_RESOLVE only in
get_active_slot() which is called by all the HTTP
request sending functions.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---

Changes since v2 are the following:

  - option renamed from "http.resolve" to "http.curloptResolve"
  - mention "libcurl" instead of "curl" in the commit message
  - mention "libculr" in the doc to make it easier to understand
    the new option name

Range diff:

1:  28c3bf9d02 ! 1:  3d689f8a6f http: add custom hostname to IP address resolutions
    @@ Commit message
         See https://curl.se/libcurl/c/CURLOPT_RESOLVE.html for
         more details.
     
    -    Let's add a corresponding "http.resolve" config option
    -    that takes advantage of CURLOPT_RESOLVE.
    +    Let's add a corresponding "http.curloptResolve" config
    +    option that takes advantage of CURLOPT_RESOLVE.
     
    -    Each value configured for the "http.resolve" key is
    -    passed "as is" to curl through CURLOPT_RESOLVE, so it
    -    should be in one of the above 2 formats. This keeps the
    -    implementation simple and makes us consistent with
    +    Each value configured for the "http.curloptResolve" key
    +    is passed "as is" to libcurl through CURLOPT_RESOLVE, so
    +    it should be in one of the above 2 formats. This keeps
    +    the implementation simple and makes us consistent with
         libcurl's CURLOPT_RESOLVE, and with curl's corresponding
         `--resolve` command line option.
     
    @@ Documentation/config/http.txt: http.version::
        - HTTP/2
        - HTTP/1.1
      
    -+http.resolve::
    -+  Hostname resolution information that will be used first when sending
    -+  HTTP requests.  This information should be in one of the following
    -+  formats:
    ++http.curloptResolve::
    ++  Hostname resolution information that will be used first by
    ++  libcurl when sending HTTP requests.  This information should
    ++  be in one of the following formats:
     +
     +  - [+]HOST:PORT:ADDRESS[,ADDRESS]
     +  - -HOST:PORT
    @@ http.c: static int http_options(const char *var, const char *value, void *cb)
                return 0;
        }
      
    -+  if (!strcmp("http.resolve", var)) {
    ++  if (!strcmp("http.curloptresolve", var)) {
     +          if (!value) {
     +                  return config_error_nonbool(var);
     +          } else if (!*value) {
    @@ t/t5551-http-fetch-smart.sh: test_expect_success 'client falls back from v2 to v
     +  BOGUS_HOST=gitbogusexamplehost.com &&
     +  BOGUS_HTTPD_URL=$HTTPD_PROTO://$BOGUS_HOST:$LIB_HTTPD_PORT &&
     +  test_must_fail git ls-remote "$BOGUS_HTTPD_URL/smart/repo.git" >/dev/null &&
    -+  git -c "http.resolve=$BOGUS_HOST:$LIB_HTTPD_PORT:127.0.0.1" ls-remote "$BOGUS_HTTPD_URL/smart/repo.git" >/dev/null
    ++  git -c "http.curloptResolve=$BOGUS_HOST:$LIB_HTTPD_PORT:127.0.0.1" ls-remote "$BOGUS_HTTPD_URL/smart/repo.git" >/dev/null
     +'
     +
      test_done


 Documentation/config/http.txt | 16 ++++++++++++++++
 http.c                        | 18 ++++++++++++++++++
 t/t5551-http-fetch-smart.sh   |  7 +++++++
 3 files changed, 41 insertions(+)

diff --git a/Documentation/config/http.txt b/Documentation/config/http.txt
index 7003661c0d..179d03e57b 100644
--- a/Documentation/config/http.txt
+++ b/Documentation/config/http.txt
@@ -98,6 +98,22 @@ http.version::
 	- HTTP/2
 	- HTTP/1.1
 
+http.curloptResolve::
+	Hostname resolution information that will be used first by
+	libcurl when sending HTTP requests.  This information should
+	be in one of the following formats:
+
+	- [+]HOST:PORT:ADDRESS[,ADDRESS]
+	- -HOST:PORT
+
++
+The first format redirects all requests to the given `HOST:PORT`
+to the provided `ADDRESS`(s). The second format clears all
+previous config values for that `HOST:PORT` combination.  To
+allow easy overriding of all the settings inherited from the
+system config, an empty value will reset all resolution
+information to the empty list.
+
 http.sslVersion::
 	The SSL version to use when negotiating an SSL connection, if you
 	want to force the default.  The available and default version
diff --git a/http.c b/http.c
index 229da4d148..8beacb95cc 100644
--- a/http.c
+++ b/http.c
@@ -128,6 +128,8 @@ static struct curl_slist *pragma_header;
 static struct curl_slist *no_pragma_header;
 static struct string_list extra_http_headers = STRING_LIST_INIT_DUP;
 
+static struct curl_slist *host_resolutions;
+
 static struct active_request_slot *active_queue_head;
 
 static char *cached_accept_language;
@@ -393,6 +395,18 @@ static int http_options(const char *var, const char *value, void *cb)
 		return 0;
 	}
 
+	if (!strcmp("http.curloptresolve", var)) {
+		if (!value) {
+			return config_error_nonbool(var);
+		} else if (!*value) {
+			curl_slist_free_all(host_resolutions);
+			host_resolutions = NULL;
+		} else {
+			host_resolutions = curl_slist_append(host_resolutions, value);
+		}
+		return 0;
+	}
+
 	if (!strcmp("http.followredirects", var)) {
 		if (value && !strcmp(value, "initial"))
 			http_follow_config = HTTP_FOLLOW_INITIAL;
@@ -1131,6 +1145,9 @@ void http_cleanup(void)
 	curl_slist_free_all(no_pragma_header);
 	no_pragma_header = NULL;
 
+	curl_slist_free_all(host_resolutions);
+	host_resolutions = NULL;
+
 	if (curl_http_proxy) {
 		free((void *)curl_http_proxy);
 		curl_http_proxy = NULL;
@@ -1211,6 +1228,7 @@ struct active_request_slot *get_active_slot(void)
 	if (curl_save_cookies)
 		curl_easy_setopt(slot->curl, CURLOPT_COOKIEJAR, curl_cookie_file);
 	curl_easy_setopt(slot->curl, CURLOPT_HTTPHEADER, pragma_header);
+	curl_easy_setopt(slot->curl, CURLOPT_RESOLVE, host_resolutions);
 	curl_easy_setopt(slot->curl, CURLOPT_ERRORBUFFER, curl_errorstr);
 	curl_easy_setopt(slot->curl, CURLOPT_CUSTOMREQUEST, NULL);
 	curl_easy_setopt(slot->curl, CURLOPT_READFUNCTION, NULL);
diff --git a/t/t5551-http-fetch-smart.sh b/t/t5551-http-fetch-smart.sh
index f92c79c132..4a8dbb7eee 100755
--- a/t/t5551-http-fetch-smart.sh
+++ b/t/t5551-http-fetch-smart.sh
@@ -567,4 +567,11 @@ test_expect_success 'client falls back from v2 to v0 to match server' '
 	grep symref=HEAD:refs/heads/ trace
 '
 
+test_expect_success 'passing hostname resolution information works' '
+	BOGUS_HOST=gitbogusexamplehost.com &&
+	BOGUS_HTTPD_URL=$HTTPD_PROTO://$BOGUS_HOST:$LIB_HTTPD_PORT &&
+	test_must_fail git ls-remote "$BOGUS_HTTPD_URL/smart/repo.git" >/dev/null &&
+	git -c "http.curloptResolve=$BOGUS_HOST:$LIB_HTTPD_PORT:127.0.0.1" ls-remote "$BOGUS_HTTPD_URL/smart/repo.git" >/dev/null
+'
+
 test_done
-- 
2.36.1.20.g51170867bd

