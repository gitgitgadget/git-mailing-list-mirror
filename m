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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3BDEC433DB
	for <git@archiver.kernel.org>; Mon, 22 Mar 2021 11:52:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B32A861990
	for <git@archiver.kernel.org>; Mon, 22 Mar 2021 11:52:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230050AbhCVLvk (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Mar 2021 07:51:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbhCVLvT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Mar 2021 07:51:19 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0575C061574
        for <git@vger.kernel.org>; Mon, 22 Mar 2021 04:51:18 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id e9so16360115wrw.10
        for <git@vger.kernel.org>; Mon, 22 Mar 2021 04:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ZM9jRCD6GVQl+xmumRoUicfPoVSx+Dr8XRlKKYhC9lo=;
        b=e0mXZuxLPSh26Ga8MeJjfiBFSvUU/ynwEQ0K0Gqtd9HwAh0YSMna4BGH+K8wlngjQz
         jE6N06lJZrnCtPyMEb8L+VjXyJNBFdcVVh5W5/jSOJywqHXrUHPCYvWB6UpsVx72eiG8
         TzXNNzR3N2iH6loil33xJHXbia59RyERyUmFRyQA48CRt1+iQ1XUVmBV3PpB/M5r2s6P
         gAACn35T83Fn3KjgaHn8CSSKB/GQ5IIS5jODG+CZUU3EBGEmtCMKTbvZS4CiU2vOb6We
         hv0S0wJYcDcl7o6Yd+nPtIZzv4g/6hlsIFPzAEOBoUbx7Jw6gRzHZ74TQaYxJoWNsK48
         FXXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ZM9jRCD6GVQl+xmumRoUicfPoVSx+Dr8XRlKKYhC9lo=;
        b=LBGoEgK1vJZnXXKJUy1Ukf+fxg1GRA09fOS/lXDbcoAmro3i5Ma1o4qDkiYV3S0cy4
         dbsxt72+bITR2wL4UnXaY+jssLose4s9SOZk1ikWcb+qHFCbslUQu61dNXqcqZ7VsU/8
         OADiBkFiRTU6BQT4hsbFMI/rivBsI1TTShBd5P20xXxtDj1J6rM+lFZ4/WV/L/RTrGIv
         hXFa8u2E2KtHvOq5O+vRkMwHtJwsm0j7/HvrFmleZwsGNJJBXp8tR7uOPe70X4Ztb1gI
         cXJoW23Q78M+liqBkrEY84n1OtnrTapadwQQ/J2dr/LVbyYsxosly1QiXulv2PIpiuq4
         rKTg==
X-Gm-Message-State: AOAM532da43oQj6HOtjzcQK2jVexorTxE5X6iv/WSTQcFWjnas7XZfRs
        qEy30f7Pt/rPqXf1rbqiCM4r/HchZew=
X-Google-Smtp-Source: ABdhPJz8TvGe/ffDBKTpRhuSec0CXJ6Fn0p4rEvWP9c9SKpngLptl3y+63FKpRLqT1Olk4d33zQ2Cw==
X-Received: by 2002:a5d:4341:: with SMTP id u1mr17896698wrr.88.1616413877664;
        Mon, 22 Mar 2021 04:51:17 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z2sm22174753wrm.0.2021.03.22.04.51.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 04:51:17 -0700 (PDT)
Message-Id: <pull.849.v3.git.1616413876663.gitgitgadget@gmail.com>
In-Reply-To: <pull.849.v2.git.1613494656636.gitgitgadget@gmail.com>
References: <pull.849.v2.git.1613494656636.gitgitgadget@gmail.com>
From:   "Christopher via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 22 Mar 2021 11:51:16 +0000
Subject: [PATCH v3] remote-curl: fall back to basic auth if Negotiate fails
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Eric Wong <e@80x24.org>, Christopher <christopher@cschenk.net>,
        Christopher Schenk <christopher@cschenk.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Christopher Schenk <christopher@cschenk.net>

When the username and password are supplied in a url like this
https://myuser:secret@git.exampe/myrepo.git and the server supports the
negotiate authenticaten method, git does not fall back to basic auth and
libcurl hardly tries to authenticate with the negotiate method.

Stop using the Negotiate authentication method after the first failure
because if it fails on the first try it will never succeed.

Signed-off-by: Christopher Schenk <christopher@cschenk.net>
---
    remote-curl: fall back to basic auth if Negotiate fails
    
    When the username and password are supplied in a url like this
    https://myuser:secret@git.exampe/myrepo.git and the server supports the
    negotiate authenticaten method git does not fall back to basic auth and
    libcurl hardly tries to authenticate with the negotiate method.
    
    Stop using the Negotiate authentication method after the first failure
    because if it fails on the first try it will never succeed.
    
    Signed-off-by: Christopher Schenk christopher@cschenk.net

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-849%2Fchschenk%2Fkerberos-basic-fallback-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-849/chschenk/kerberos-basic-fallback-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/849

Range-diff vs v2:

 1:  7bfc0b431910 ! 1:  52de7fa42f88 remote-curl: fall back to basic auth if Negotiate fails
     @@ Commit message
      
          When the username and password are supplied in a url like this
          https://myuser:secret@git.exampe/myrepo.git and the server supports the
     -    negotiate authenticaten method git does not fall back to basic auth and
     +    negotiate authenticaten method, git does not fall back to basic auth and
          libcurl hardly tries to authenticate with the negotiate method.
      
          Stop using the Negotiate authentication method after the first failure
          because if it fails on the first try it will never succeed.
      
     -    V1 of this patch somehow did not make it to the mailing list so i will
     -    try to send this patch again
     -
          Signed-off-by: Christopher Schenk <christopher@cschenk.net>
      
       ## http.c ##
      @@ http.c: static int handle_curl_result(struct slot_results *results)
     + 	} else if (missing_target(results))
       		return HTTP_MISSING_TARGET;
       	else if (results->http_code == 401) {
     - 		if (http_auth.username && http_auth.password) {
      +#ifdef LIBCURL_CAN_HANDLE_AUTH_ANY
     -+			if (results->auth_avail & CURLAUTH_GSSNEGOTIATE) {
     -+				http_auth_methods &= ~CURLAUTH_GSSNEGOTIATE;
     -+				http_auth_methods &= results->auth_avail;
     -+				http_auth_methods_restricted = 1;
     -+				return HTTP_REAUTH;
     -+			}
     ++		http_auth_methods &= ~CURLAUTH_GSSNEGOTIATE;
     ++		if (results->auth_avail) {
     ++			http_auth_methods &= results->auth_avail;
     ++			http_auth_methods_restricted = 1;
     ++			return HTTP_REAUTH;
     ++		}
      +#endif
     + 		if (http_auth.username && http_auth.password) {
       			credential_reject(&http_auth);
       			return HTTP_NOAUTH;
       		} else {
     +-#ifdef LIBCURL_CAN_HANDLE_AUTH_ANY
     +-			http_auth_methods &= ~CURLAUTH_GSSNEGOTIATE;
     +-			if (results->auth_avail) {
     +-				http_auth_methods &= results->auth_avail;
     +-				http_auth_methods_restricted = 1;
     +-			}
     +-#endif
     + 			return HTTP_REAUTH;
     + 		}
     + 	} else {


 http.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/http.c b/http.c
index 8b23a546afdf..4b4cfee8185c 100644
--- a/http.c
+++ b/http.c
@@ -1641,17 +1641,18 @@ static int handle_curl_result(struct slot_results *results)
 	} else if (missing_target(results))
 		return HTTP_MISSING_TARGET;
 	else if (results->http_code == 401) {
+#ifdef LIBCURL_CAN_HANDLE_AUTH_ANY
+		http_auth_methods &= ~CURLAUTH_GSSNEGOTIATE;
+		if (results->auth_avail) {
+			http_auth_methods &= results->auth_avail;
+			http_auth_methods_restricted = 1;
+			return HTTP_REAUTH;
+		}
+#endif
 		if (http_auth.username && http_auth.password) {
 			credential_reject(&http_auth);
 			return HTTP_NOAUTH;
 		} else {
-#ifdef LIBCURL_CAN_HANDLE_AUTH_ANY
-			http_auth_methods &= ~CURLAUTH_GSSNEGOTIATE;
-			if (results->auth_avail) {
-				http_auth_methods &= results->auth_avail;
-				http_auth_methods_restricted = 1;
-			}
-#endif
 			return HTTP_REAUTH;
 		}
 	} else {

base-commit: 71ca53e8125e36efbda17293c50027d31681a41f
-- 
gitgitgadget
