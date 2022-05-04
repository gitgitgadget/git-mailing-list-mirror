Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A072C433F5
	for <git@archiver.kernel.org>; Wed,  4 May 2022 10:46:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348238AbiEDKuA (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 May 2022 06:50:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235739AbiEDKt7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 May 2022 06:49:59 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98F181A047
        for <git@vger.kernel.org>; Wed,  4 May 2022 03:46:23 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id d5so1441301wrb.6
        for <git@vger.kernel.org>; Wed, 04 May 2022 03:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7o2w/lEZXUmuYDooCFBi6SWsj+oqT8aR5vd7jewpJR4=;
        b=olPP4DCrcfY12Ir8ogIX3rel+h5D6gcqKpOG42X2qEkQXsyl/nlNacimCIyrRwdX+K
         rQ24aSkyRrhdQkrOxEog5uSdCRxGD+96gHv4cSjW+BhAkt9/ySDZlnPIBWVCdEUkKMj0
         anCVRYGY31bePjAGt2z1raBS6FXY+KNTeQt2DkgHKG+Vji3sPOLJdGP44OPOuAiz+viq
         bQzzR0NPbE6ocJ52ihfj4Lg0Y/Cynm2A1XDuKglt3xc+rc2LFzVHi32HSMGfKNAI4Rau
         PrvOqec9XgFA/9v3NXyAvH+cUWvD8J0so0F68wBx96ey31ZyslU/F0lb4mxsSsOJRCVM
         /wMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7o2w/lEZXUmuYDooCFBi6SWsj+oqT8aR5vd7jewpJR4=;
        b=SJjffD5JfW99hwhfl2lpF+j65vdicJmPm+RAFMHbsw2Zeva80TApc8r0rub4CDaA4Z
         6rj1KUBHAekDME5LBYh+3pWkYMfrVycTBvD7sP0aW1rkPz80ZAVMnpdXIS3QGMb3NwvB
         BxzfOEsgR/+vUgYbxP/jkgjbNzzfHTQEer91KxgJMptY/p5d4VHfDmlqGSj3kO+V2MjF
         aJkwmz3eLedp9noqjO9LVysiBBSPPP/9Kym00MXzlD6mSlT3G2k5LBrO21FFt31aJY3p
         GhDwWbAZMfNYNXRYcc7OlxDbs730YvhzJjN1uO66v47Smehbd6EfcjMTicPOPLBZJUE/
         7NYg==
X-Gm-Message-State: AOAM532A1Y5oCxuxujUSD31hz9tb6qtbrXbfMCV/E1FN+aE2iz7FGk8+
        Nz/g/XmkNXTykthxm18uvSZYrGiEFrM=
X-Google-Smtp-Source: ABdhPJwktRxdp+MbBIE6py3uAJXUUsHQ3OKUW22PdTC4md3MuGWjkisMuPDO4vHOLgDWEJd+Ik39wA==
X-Received: by 2002:a5d:678b:0:b0:20a:db0b:7395 with SMTP id v11-20020a5d678b000000b0020adb0b7395mr16249713wru.668.1651661181576;
        Wed, 04 May 2022 03:46:21 -0700 (PDT)
Received: from localhost.localdomain ([2001:861:3005:2510:8136:b85d:849b:69cd])
        by smtp.gmail.com with ESMTPSA id 11-20020a05600c264b00b0039444973258sm3979704wmy.0.2022.05.04.03.46.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 May 2022 03:46:20 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Derrick Stolee <derrickstolee@github.com>,
        Carlo Arenas <carenas@gmail.com>
Subject: [PATCH v2] http: add custom hostname to IP address resolutions
Date:   Wed,  4 May 2022 12:46:01 +0200
Message-Id: <20220504104601.136403-1-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.36.0.1.g9c537b8458.dirty
In-Reply-To: <20220502083639.610279-1-chriscool@tuxfamily.org>
References: <20220502083639.610279-1-chriscool@tuxfamily.org>
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

Let's add a corresponding "http.resolve" config option
that takes advantage of CURLOPT_RESOLVE.

Each value configured for the "http.resolve" key is
passed "as is" to curl through CURLOPT_RESOLVE, so it
should be in one of the above 2 formats. This keeps the
implementation simple and makes us consistent with
libcurl's CURLOPT_RESOLVE, and with curl's corresponding
`--resolve` command line option.

The implementation uses CURLOPT_RESOLVE only in
get_active_slot() which is called by all the HTTP
request sending functions.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---

Changes since v1 are the following:

  - rename the new config option to "http.resolve" 
  - use "resolution" instead of "resolve" for the noun
  - use "format" instead of "form"
  - improved commit message and documentation
  - stop using a string_list and remove unnecessary
    related variables and functions
  - add a simple test

Thanks to Junio and Carlo for the suggestions.

As this version is very different from v1, I am not
sure a range diff would be very useful as it would
be very long compared to the size of the patch.

 Documentation/config/http.txt | 16 ++++++++++++++++
 http.c                        | 18 ++++++++++++++++++
 t/t5551-http-fetch-smart.sh   |  7 +++++++
 3 files changed, 41 insertions(+)

diff --git a/Documentation/config/http.txt b/Documentation/config/http.txt
index 7003661c0d..86f8a5978f 100644
--- a/Documentation/config/http.txt
+++ b/Documentation/config/http.txt
@@ -98,6 +98,22 @@ http.version::
 	- HTTP/2
 	- HTTP/1.1
 
+http.resolve::
+	Hostname resolution information that will be used first when sending
+	HTTP requests.  This information should be in one of the following
+	formats:
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
index 229da4d148..7f3b7403ce 100644
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
 
+	if (!strcmp("http.resolve", var)) {
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
index f92c79c132..d97380be87 100755
--- a/t/t5551-http-fetch-smart.sh
+++ b/t/t5551-http-fetch-smart.sh
@@ -567,4 +567,11 @@ test_expect_success 'client falls back from v2 to v0 to match server' '
 	grep symref=HEAD:refs/heads/ trace
 '
 
+test_expect_success 'passing hostname resolution information works' '
+	BOGUS_HOST=gitbogusexamplehost.com &&
+	BOGUS_HTTPD_URL=$HTTPD_PROTO://$BOGUS_HOST:$LIB_HTTPD_PORT &&
+	test_must_fail git ls-remote "$BOGUS_HTTPD_URL/smart/repo.git" >/dev/null &&
+	git -c "http.resolve=$BOGUS_HOST:$LIB_HTTPD_PORT:127.0.0.1" ls-remote "$BOGUS_HTTPD_URL/smart/repo.git" >/dev/null
+'
+
 test_done
-- 
2.36.0.1.g9c537b8458.dirty

