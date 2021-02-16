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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48172C43381
	for <git@archiver.kernel.org>; Tue, 16 Feb 2021 16:58:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A38964E7A
	for <git@archiver.kernel.org>; Tue, 16 Feb 2021 16:58:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230501AbhBPQ6W (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Feb 2021 11:58:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230376AbhBPQ6T (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Feb 2021 11:58:19 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEDC8C061574
        for <git@vger.kernel.org>; Tue, 16 Feb 2021 08:57:38 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id t15so13914545wrx.13
        for <git@vger.kernel.org>; Tue, 16 Feb 2021 08:57:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=1y/j7+zxJKc3ZVewU6Xjn7gqiZy+02IJfZUvaEjAchg=;
        b=JuEKZnouF9vX9wTWp8Mz/tUmH61dMnJvkQGhFGGDvhLu64Ed3+sxH4dJ18N+hJNDpF
         SAhz5ndg4CaXzx+LYpXLcC9X9IDIeNy1xJ+ibAzTtfCd/ATGbTeY9cPlA9JxvGG0mAno
         KcNN+e+GNM4e/LOnAdFTQC0ZEuvk7uKpiwOTF7nASqdaYxoGBB/RsGGVfXKTp97uWQaU
         OqksKJKhpvn83HzurjQTP9gBEo1irp/bkSC73Qe0scMXQembr7ZWHCWwtv+5I8gh4500
         p/4+OXdYnQPvkFNBD5qvBpKPh1YJUXfawb1NyyaEVvaCy/MiTqDTRYOKjuCCHVjBsCVm
         /NCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=1y/j7+zxJKc3ZVewU6Xjn7gqiZy+02IJfZUvaEjAchg=;
        b=D6qcaJqz9UXKLeNC6tOHDL0S0YsXg8BLIrv1Kn+Hp8GqUOGj/jUpCUaix0r8cc5jk/
         r29QgAR26KQcIHIO1UxoWKkIws9VWk2TM/n+DwD/cqFQvmA3NGNRgUSpBnpSEP3WZ1Do
         5H5j3IePAwbSyrHRr05J1uyDrbkgj1EQ0JeBDZkiZy7cAu0qCpE+QEO6b9pjGcPK4VuX
         8o+HoY2wCnBS3eL8OIHQoXs8HC0/eX8hUzZRUketFzWllWWYpAZc333GTyujbM2Am/fe
         lAPW2Js2v2Wdt5N6b7xLfRwV6FrS+gxKFLfDAqF7yixrK5IeL3n3qThZ+EY1VadaDKag
         A+aw==
X-Gm-Message-State: AOAM533Qi1j+jSWLoGayOQoXXX0isbfSyNCI9C6I6p8Y3kY7xC+qxC2p
        RU29a8Nr6wPWuuIcTMyBfKGiKpvcYxA=
X-Google-Smtp-Source: ABdhPJxnVuWmFptLjlvSkEvJ53hh+AEIVBNxw/k9QP1H2hd1KKTXtUc/TByhGAIlkd26tNTGEobXLQ==
X-Received: by 2002:adf:8445:: with SMTP id 63mr8330566wrf.222.1613494657323;
        Tue, 16 Feb 2021 08:57:37 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x18sm17161031wrs.16.2021.02.16.08.57.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Feb 2021 08:57:37 -0800 (PST)
Message-Id: <pull.849.v2.git.1613494656636.gitgitgadget@gmail.com>
In-Reply-To: <pull.849.git.1611921008282.gitgitgadget@gmail.com>
References: <pull.849.git.1611921008282.gitgitgadget@gmail.com>
From:   "Christopher via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 16 Feb 2021 16:57:36 +0000
Subject: [PATCH v2] remote-curl: fall back to basic auth if Negotiate fails
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
negotiate authenticaten method git does not fall back to basic auth and
libcurl hardly tries to authenticate with the negotiate method.

Stop using the Negotiate authentication method after the first failure
because if it fails on the first try it will never succeed.

V1 of this patch somehow did not make it to the mailing list so i will
try to send this patch again

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

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-849%2Fchschenk%2Fkerberos-basic-fallback-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-849/chschenk/kerberos-basic-fallback-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/849

Range-diff vs v1:

 1:  285a8a568444 ! 1:  7bfc0b431910 remote-curl: fall back to basic auth if Negotiate fails
     @@ Commit message
          Stop using the Negotiate authentication method after the first failure
          because if it fails on the first try it will never succeed.
      
     +    V1 of this patch somehow did not make it to the mailing list so i will
     +    try to send this patch again
     +
          Signed-off-by: Christopher Schenk <christopher@cschenk.net>
      
       ## http.c ##


 http.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/http.c b/http.c
index 8b23a546afdf..36f113d46c23 100644
--- a/http.c
+++ b/http.c
@@ -1642,6 +1642,14 @@ static int handle_curl_result(struct slot_results *results)
 		return HTTP_MISSING_TARGET;
 	else if (results->http_code == 401) {
 		if (http_auth.username && http_auth.password) {
+#ifdef LIBCURL_CAN_HANDLE_AUTH_ANY
+			if (results->auth_avail & CURLAUTH_GSSNEGOTIATE) {
+				http_auth_methods &= ~CURLAUTH_GSSNEGOTIATE;
+				http_auth_methods &= results->auth_avail;
+				http_auth_methods_restricted = 1;
+				return HTTP_REAUTH;
+			}
+#endif
 			credential_reject(&http_auth);
 			return HTTP_NOAUTH;
 		} else {

base-commit: 71ca53e8125e36efbda17293c50027d31681a41f
-- 
gitgitgadget
