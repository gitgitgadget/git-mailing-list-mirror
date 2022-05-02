Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17EBCC433F5
	for <git@archiver.kernel.org>; Mon,  2 May 2022 08:37:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359440AbiEBIkj (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 May 2022 04:40:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231486AbiEBIki (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 May 2022 04:40:38 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58E3718396
        for <git@vger.kernel.org>; Mon,  2 May 2022 01:37:09 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id k2so18666606wrd.5
        for <git@vger.kernel.org>; Mon, 02 May 2022 01:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=I8b8EX/LkGYCZ3VzAni8CJwscrhZk4B6UO0z2oqVeLo=;
        b=PbflyxjX0L2DANqMq2F+JlAz/LxPPzsBKJC/etX7BjblIO+JA5UpuXPPtbCy+wcjxl
         PCdQ8ytgyq/VRQDiO/aRdtw4fR9i0Yr+9RGW4/6yVq8begCIFAVBnAtZeEZuypupVjlh
         uwINL7YHg/0RKjj8tDHi0YgrhbQyjWJyQFKAjzHhhafsk41mNVUc0m0ca8a+IPKJ4fYk
         3JXrzVL68Lndpa+mUcwuxCA4eNJsDAbDLMmuiw4mOu7myOK8/sZB6S5drEL51FW0Cxu2
         28cTZN3DM7zM1/A2Z9ovxWmdzJnZCLRtFQVsJ77TIWiTLaOWTC6tGqyxZ0dxhliGtQWT
         jETg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=I8b8EX/LkGYCZ3VzAni8CJwscrhZk4B6UO0z2oqVeLo=;
        b=PKUXWGXXHl72lHIgIm2eApmIDOi4rIxYugQ6IDpcxHA6OWP16E6iglT7zm5idRsjEC
         MOKgnfJmx98wQV/c0EoSpg0Vs/S+oUqMZRMkuxXuFXr85TROBZpREZTmYMC2sqsxVCBs
         0VxcCmVAQZCKEWC/snV8vk0Gl4KlNQYXfbIxdItl6tldaHr9it3kS5d7pK4hsOy1LLJI
         ShAr60eFV93OT0lJ0B9wU+FWBCjSxJ8Lw3okqzq6gZovmm6JUZ3Skv4OFLcQGRQUkCVt
         vJNTVA0LmUhOby5LIFfGmXrHRqaydUkBYqPdV5YHzxNRLYh7kjxI+EtIG2KhzO7JjmsK
         oo+A==
X-Gm-Message-State: AOAM530yb2PPCN9D2mt6wQzIzml3yFnrgnhQpzJqx9Y36TCtfmgYBN5Z
        4yxkaChrE7Oks1eJPcqUFSzLBSUEQPM=
X-Google-Smtp-Source: ABdhPJw9L7/i5zn5T4nkyur8lOkX8J1wyKnKCHcTPJnfvoLF9sVFg+imUWDQ9CS7nx2F2X0wpiZfsA==
X-Received: by 2002:a05:6000:156e:b0:20c:5218:8907 with SMTP id 14-20020a056000156e00b0020c52188907mr8503039wrz.297.1651480625924;
        Mon, 02 May 2022 01:37:05 -0700 (PDT)
Received: from localhost.localdomain ([2001:861:3005:2510:99f9:595b:7922:a98b])
        by smtp.gmail.com with ESMTPSA id k8-20020a05600c0b4800b003942a244ee9sm5749571wmr.46.2022.05.02.01.37.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 May 2022 01:37:05 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Derrick Stolee <derrickstolee@github.com>,
        Jacob Vosmaer <jacob@gitlab.com>
Subject: [PATCH] http: add custom hostname to IP address resolves
Date:   Mon,  2 May 2022 10:36:39 +0200
Message-Id: <20220502083639.610279-1-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.36.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Libcurl has a CURLOPT_RESOLVE easy option that allows
hostname resolve information in the following form to
be passed:

	[+]HOST:PORT:ADDRESS[,ADDRESS]

This way, redirects and everything operating against the
HOST+PORT will use the provided ADDRESS(s).

The following form is also allowed to stop using these
resolves:

	-HOST:PORT

Let's add a corresponding "http.hostResolve" config
option that takes advantage of CURLOPT_RESOLVE.

Each value configured for the "http.hostResolve" key
is passed "as is" to curl through CURLOPT_RESOLVE, so it
should be in one of the above 2 forms. This keeps the
implementation simple and makes us consistent with
libcurl's CURLOPT_RESOLVE, and with curl's corresponding
`--resolve` command line option.

The implementation is similar to what is done for the
"http.extraHeader" config option, except that we use
CURLOPT_RESOLVE only in get_active_slot() which is
called by all the HTTP request sending functions.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---

I am not sure if some tests could/should be added. Ideas about how to
test this are welcome.

Documentation/config/http.txt | 16 ++++++++++++++++
 http.c                        | 32 ++++++++++++++++++++++++++++++++
 2 files changed, 48 insertions(+)

diff --git a/Documentation/config/http.txt b/Documentation/config/http.txt
index 7003661c0d..37b293a73b 100644
--- a/Documentation/config/http.txt
+++ b/Documentation/config/http.txt
@@ -98,6 +98,22 @@ http.version::
 	- HTTP/2
 	- HTTP/1.1
 
+http.hostResolve::
+	Hostname resolve information that will be used first when sending
+	HTTP requests.  This information should be in one of the following
+	forms:
+
+	- [+]HOST:PORT:ADDRESS[,ADDRESS]
+	- -HOST:PORT
+
++
+The first form redirects all requests to the given `HOST:PORT`
+to the provided `ADDRESS`(s). The second form clears all previous
+config values for that `HOST:PORT` combination.  To allow easy
+overriding of all the settings inherited from the system config,
+an empty value will reset all resolve information to the empty
+list.
+
 http.sslVersion::
 	The SSL version to use when negotiating an SSL connection, if you
 	want to force the default.  The available and default version
diff --git a/http.c b/http.c
index 229da4d148..e9cc46ee52 100644
--- a/http.c
+++ b/http.c
@@ -128,6 +128,9 @@ static struct curl_slist *pragma_header;
 static struct curl_slist *no_pragma_header;
 static struct string_list extra_http_headers = STRING_LIST_INIT_DUP;
 
+static struct curl_slist *host_resolves;
+static struct string_list http_host_resolve = STRING_LIST_INIT_DUP;
+
 static struct active_request_slot *active_queue_head;
 
 static char *cached_accept_language;
@@ -393,6 +396,17 @@ static int http_options(const char *var, const char *value, void *cb)
 		return 0;
 	}
 
+	if (!strcmp("http.hostresolve", var)) {
+		if (!value) {
+			return config_error_nonbool(var);
+		} else if (!*value) {
+			string_list_clear(&http_host_resolve, 0);
+		} else {
+			string_list_append(&http_host_resolve, value);
+		}
+		return 0;
+	}
+
 	if (!strcmp("http.followredirects", var)) {
 		if (value && !strcmp(value, "initial"))
 			http_follow_config = HTTP_FOLLOW_INITIAL;
@@ -985,6 +999,17 @@ static void set_from_env(const char **var, const char *envname)
 		*var = val;
 }
 
+static struct curl_slist *http_copy_host_resolve(void)
+{
+	struct curl_slist *hosts = NULL;
+	const struct string_list_item *item;
+
+	for_each_string_list_item(item, &http_host_resolve)
+		hosts = curl_slist_append(hosts, item->string);
+
+	return hosts;
+}
+
 void http_init(struct remote *remote, const char *url, int proactive_auth)
 {
 	char *low_speed_limit;
@@ -1048,6 +1073,8 @@ void http_init(struct remote *remote, const char *url, int proactive_auth)
 	no_pragma_header = curl_slist_append(http_copy_default_headers(),
 		"Pragma:");
 
+	host_resolves = http_copy_host_resolve();
+
 	{
 		char *http_max_requests = getenv("GIT_HTTP_MAX_REQUESTS");
 		if (http_max_requests != NULL)
@@ -1124,6 +1151,7 @@ void http_cleanup(void)
 	curl_global_cleanup();
 
 	string_list_clear(&extra_http_headers, 0);
+	string_list_clear(&http_host_resolve, 0);
 
 	curl_slist_free_all(pragma_header);
 	pragma_header = NULL;
@@ -1131,6 +1159,9 @@ void http_cleanup(void)
 	curl_slist_free_all(no_pragma_header);
 	no_pragma_header = NULL;
 
+	curl_slist_free_all(host_resolves);
+	host_resolves = NULL;
+
 	if (curl_http_proxy) {
 		free((void *)curl_http_proxy);
 		curl_http_proxy = NULL;
@@ -1211,6 +1242,7 @@ struct active_request_slot *get_active_slot(void)
 	if (curl_save_cookies)
 		curl_easy_setopt(slot->curl, CURLOPT_COOKIEJAR, curl_cookie_file);
 	curl_easy_setopt(slot->curl, CURLOPT_HTTPHEADER, pragma_header);
+	curl_easy_setopt(slot->curl, CURLOPT_RESOLVE, host_resolves);
 	curl_easy_setopt(slot->curl, CURLOPT_ERRORBUFFER, curl_errorstr);
 	curl_easy_setopt(slot->curl, CURLOPT_CUSTOMREQUEST, NULL);
 	curl_easy_setopt(slot->curl, CURLOPT_READFUNCTION, NULL);
-- 
2.36.0

