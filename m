Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBD55C433EF
	for <git@archiver.kernel.org>; Mon, 16 May 2022 08:39:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238562AbiEPIjP (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 May 2022 04:39:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231559AbiEPIjL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 May 2022 04:39:11 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EC1CE0D1
        for <git@vger.kernel.org>; Mon, 16 May 2022 01:39:09 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id a5so15662833wrp.7
        for <git@vger.kernel.org>; Mon, 16 May 2022 01:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GYKNFgyzOSnscfbsVVJLXAG58PzEbOPA2lV4+2nL5R8=;
        b=ZEpKPr/wwvyRSAdQH3U9J0tCKXSYr5BThDhqYDyvFoHbJBz8vtK2TsYqB9qi99ircA
         UqG1oD6v+CDHrHMY693NAztLpROhQO+hq3bXM0hSIHf/6TVbAEeVjeBXQIxIGfmNJn3e
         DibMpOj8yIgFlG5E2jNlzozWunOEHee9zFsxRoiRau4TKfWrUaGLTmjt/pz7fLkY6nER
         evMjlFvWD3BWQgugW4bDCJQAS69HTm48dxkF8Zuvio6Ft6jIFo0HhY4WGsq8j+I3m0fe
         nJuepnvjm/3/boK4OIt5YXGIoNKjWoUiuATlrW7VjtAEzYrME9Ck3RNZHdPqLwkXWm24
         4W7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GYKNFgyzOSnscfbsVVJLXAG58PzEbOPA2lV4+2nL5R8=;
        b=z0tbF+mMsY8BLzSQSKpQTBWvb09Q9pP0DBDkGZBxZ4+ptgMlxyr1qjXk87A1IJWT8y
         ZwIy4PIBLd9y97AYr73vYSl/HO1eGo1k2+JS6tiLw7OAGZ+cn7WITJ6tvh6WZ09d9Q7G
         QU6NovBwFFn4X2UpTYvl/nUitmq2xvpjlZPS9OomL3hRDcCaci1+wgtEn7CBBW2fgQhN
         dKjyfqT8kKCQDbxNXTqYJfAaiD3KCsueOnX3o7QYrzWj8q1hvGsikR7NoNNFfSIP8tfh
         Fp426FZpuduNq0fkirDWVvfFrvGvkwKde9c3oouGX7MQlwiTouxW0z2JLyTuKwuue+HW
         fO/g==
X-Gm-Message-State: AOAM533Ph3QmGhchQe+epj1z1KX67h8H6d+ziF9gsYCKO/QacgSEPmOp
        9SlJnkItB7bGlJBjv8urEaFzH2iXK14=
X-Google-Smtp-Source: ABdhPJy/LbJYOAz1Rq/lymcFNgevgcSPZ6Dm0S3r8Q2O4rbGptUTbOd0YKZsTaD5qmniEpEkO3VXsg==
X-Received: by 2002:adf:fb12:0:b0:20c:79b2:a200 with SMTP id c18-20020adffb12000000b0020c79b2a200mr13518206wrr.617.1652690347178;
        Mon, 16 May 2022 01:39:07 -0700 (PDT)
Received: from localhost.localdomain ([2001:861:3005:2510:8d3:1902:531f:83c1])
        by smtp.gmail.com with ESMTPSA id i10-20020a05600c354a00b003942a244f37sm14359720wmq.16.2022.05.16.01.39.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 01:39:06 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Derrick Stolee <derrickstolee@github.com>,
        Carlo Arenas <carenas@gmail.com>,
        Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v4] http: add custom hostname to IP address resolutions
Date:   Mon, 16 May 2022 10:38:51 +0200
Message-Id: <20220516083851.202057-1-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.36.1.75.ga27ebf5988
In-Reply-To: <20220509153834.485871-1-chriscool@tuxfamily.org>
References: <20220509153834.485871-1-chriscool@tuxfamily.org>
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

Changes since v3:

  - Use gitbogusexamplehost.invalid instead of gitbogusexamplehost.com
    in the test.
  - Rebased on top of master at 277cf0bc36 (second 0th batch of topics
    from the previous cycle, 2022-05-11).

Range diff:

1:  3d689f8a6f ! 1:  a27ebf5988 http: add custom hostname to IP address resolutions
    @@ t/t5551-http-fetch-smart.sh: test_expect_success 'client falls back from v2 to v
      '
      
     +test_expect_success 'passing hostname resolution information works' '
    -+  BOGUS_HOST=gitbogusexamplehost.com &&
    ++  BOGUS_HOST=gitbogusexamplehost.invalid &&
     +  BOGUS_HTTPD_URL=$HTTPD_PROTO://$BOGUS_HOST:$LIB_HTTPD_PORT &&
     +  test_must_fail git ls-remote "$BOGUS_HTTPD_URL/smart/repo.git" >/dev/null &&
     +  git -c "http.curloptResolve=$BOGUS_HOST:$LIB_HTTPD_PORT:127.0.0.1" ls-remote "$BOGUS_HTTPD_URL/smart/repo.git" >/dev/null

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
index f92c79c132..b9351a732f 100755
--- a/t/t5551-http-fetch-smart.sh
+++ b/t/t5551-http-fetch-smart.sh
@@ -567,4 +567,11 @@ test_expect_success 'client falls back from v2 to v0 to match server' '
 	grep symref=HEAD:refs/heads/ trace
 '
 
+test_expect_success 'passing hostname resolution information works' '
+	BOGUS_HOST=gitbogusexamplehost.invalid &&
+	BOGUS_HTTPD_URL=$HTTPD_PROTO://$BOGUS_HOST:$LIB_HTTPD_PORT &&
+	test_must_fail git ls-remote "$BOGUS_HTTPD_URL/smart/repo.git" >/dev/null &&
+	git -c "http.curloptResolve=$BOGUS_HOST:$LIB_HTTPD_PORT:127.0.0.1" ls-remote "$BOGUS_HTTPD_URL/smart/repo.git" >/dev/null
+'
+
 test_done
-- 
2.36.1.75.ga27ebf5988

