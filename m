Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B0E3C433EF
	for <git@archiver.kernel.org>; Wed, 23 Feb 2022 18:31:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243878AbiBWSbn (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Feb 2022 13:31:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243871AbiBWSbk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Feb 2022 13:31:40 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0619E4B421
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 10:31:12 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id d3so25437109wrf.1
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 10:31:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=2WQN9xs7IjLHHOx2h4dk6qc3hKyFx/uqIjlbjTom1KA=;
        b=guFhpzwJLQT4GF9jsuVmH7YcbJNxW1UcSztfUCsXdHVlUHO8HIxWe8Owq1tnXZW5o2
         s0mWRdIbRyYIE7ZtOQ1p9TdJ63/b9/sgzcYJyi9/6slXbiJuVlGVif5rjU58fTIwok6f
         RsCrmxqVhknComgOmSK3TCYl2n3WErYtO36xP/ddDg0az1JPHyKgXDHntiBv9L9rTU4K
         kJnqTTvkpOF+m6v0IlXhtVT5gnieb6WvjC8Ntkuyy2p3BF848fnN0i9Ei4irNpZhPY7o
         cAKyndJJgLtwQ4QtO3KT5H4Rxp0mjFHF8r288Gn+864bk/foxLJV3WoIOWp/5shmR3lR
         LFig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=2WQN9xs7IjLHHOx2h4dk6qc3hKyFx/uqIjlbjTom1KA=;
        b=Esa+tO7QN3bRDujYDuuCAIddFokcFVWM4ctq1pX8eMXQee1HHE9vZLVfrRZImMK1oo
         72FItazYi2xszh1OpDXLCOVhqIjsXWBSvQIBOtG8hyt9abhZ+o6lYjOguNCpDwxV58HD
         IFc5p0z/JWwHcNuObcLCNZq1VEu5W0br4PIDydVA8CFcpi/KGCOvmskcpuuAR++x3HJh
         KkIEebL+WOPxFDG7z7eifttVnVmOd4tx4I/c7fCZbMQ7VGJBxXgyzG5Ahuh4fcMlHK16
         pWREuGNFgrx1IHVk9kRBuG6g5k2cainRDn66xj9KIh3mjKzJ2QQesHUZYzkzk2ICK0uV
         Yw1g==
X-Gm-Message-State: AOAM533lSmU9CKwYR8y2ip2u7y87ml8h0d4OcmvhTc3rGkKBA8ByECE5
        0/kcNx50NhMxgSWBmNxKi7GnIuAz+Og=
X-Google-Smtp-Source: ABdhPJyCtVcHfVes8oel0GkEOP6FZQsCXfbMAASCwomIK/IKWTTsWlXTToQcgjQHa9Pdd+cXfgS4TA==
X-Received: by 2002:a05:6000:1364:b0:1ed:b65a:da45 with SMTP id q4-20020a056000136400b001edb65ada45mr681996wrz.680.1645641070403;
        Wed, 23 Feb 2022 10:31:10 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r12sm339156wrz.50.2022.02.23.10.31.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 10:31:10 -0800 (PST)
Message-Id: <60a8d52af64cdc3ca8b374c714cd3af1fc74f5ec.1645641063.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1160.git.1645641063.gitgitgadget@gmail.com>
References: <pull.1160.git.1645641063.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 23 Feb 2022 18:30:43 +0000
Subject: [PATCH 05/25] remote: allow relative_url() to return an absolute url
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com, aevar@gmail.com,
        newren@gmail.com, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

When the 'url' parameter was absolute, the previous implementation would
concatenate 'remote_url' with 'url'. Instead, we want to return 'url' in
this case.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 remote.c | 12 ++++++++++--
 remote.h |  1 +
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/remote.c b/remote.c
index c4a56749e85..ac1d98ae922 100644
--- a/remote.c
+++ b/remote.c
@@ -2766,10 +2766,18 @@ char *relative_url(const char *remote_url,
 	int is_relative = 0;
 	int colonsep = 0;
 	char *out;
-	char *remoteurl = xstrdup(remote_url);
+	char *remoteurl;
 	struct strbuf sb = STRBUF_INIT;
-	size_t len = strlen(remoteurl);
+	size_t len;
+
+	if (!url_is_local_not_ssh(url) || is_absolute_path(url))
+		return xstrdup(url);
+
+	len = strlen(remote_url);
+	if (!len)
+		BUG("invalid empty remote_url");
 
+	remoteurl = xstrdup(remote_url);
 	if (is_dir_sep(remoteurl[len-1]))
 		remoteurl[len-1] = '\0';
 
diff --git a/remote.h b/remote.h
index 91c7f187863..438152ef562 100644
--- a/remote.h
+++ b/remote.h
@@ -434,6 +434,7 @@ void apply_push_cas(struct push_cas_option *, struct remote *, struct ref *);
  * http://a.com/b  ../../../c       http:/c          error out
  * http://a.com/b  ../../../../c    http:c           error out
  * http://a.com/b  ../../../../../c    .:c           error out
+ * http://a.com/b  http://d.org/e   http://d.org/e   as is
  */
 char *relative_url(const char *remote_url,
 		   const char *url,
-- 
gitgitgadget

