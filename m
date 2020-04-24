Return-Path: <SRS0=LF8V=6I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB07EC54FD0
	for <git@archiver.kernel.org>; Fri, 24 Apr 2020 11:50:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9224C20728
	for <git@archiver.kernel.org>; Fri, 24 Apr 2020 11:50:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cx1GPl85"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726888AbgDXLuB (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Apr 2020 07:50:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726831AbgDXLt6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Apr 2020 07:49:58 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 517F3C09B047
        for <git@vger.kernel.org>; Fri, 24 Apr 2020 04:49:58 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id t14so10400983wrw.12
        for <git@vger.kernel.org>; Fri, 24 Apr 2020 04:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=aFMzCmek53MxhHFVVQcqTiwX0cdUD5NVh36qYidNBrM=;
        b=Cx1GPl85ftKJoJ95JgyZASiUIlNAVt+4OeUEkSW9QXEtKk4t2FTcAQzNYBSzMh3GAY
         v2IF2Vx6XIi630WhQIyQSN7X1gq95uVHshbvqCfaaOfSlLjX75lLkFLuZkg3pNnBLFXe
         kTbrTC7022QMuOh3k8PAyarur30is8CRrqEOK6CH5f9R21P1DNtFvEMLp1u1KrR888lk
         wGUDXVu11Xc6ys6cJ9bn2xcyF3QB5oqgzCkw9fTD91wqEVwff/YzHIt7vaD58xECJvD8
         lKsj0F4Bo8g0g3IYEqlXktqft9M27jKgUd5Gz0b5wrC4dYuL4A5Cf0HIGdZZRmCQ9y90
         UaGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=aFMzCmek53MxhHFVVQcqTiwX0cdUD5NVh36qYidNBrM=;
        b=NHEnpJrCy1S2RCR/JG6UVcTirIdR95lumLJzfY9IbZiOqv5s3VfXcrljYyQ1J6Hnq0
         w8iLK8FSVcTUDm0FQLXtSFhO/Sv+qwSVR3rSMeA7eR97wW8SuOFcwjn8Net9adUYl32q
         Rh0bMMucCP6tn8SeFdLrtd8/0IdfzMUKCQImsK9CDsNNN9x2zD47EinQcqPWRLaVdu98
         LRr2TEG4SVqzm5jhr6kcvODdf0z1T7GyA+rMMMFa9kIzzhlvBIHnv6GtGsu6EoANG4j/
         jmX98nIfHL4IRS0wSOOjn6Z8MHb9ll+We4r0rShuRKROxAC4RzfKwZCJ3TKQX9YOShT1
         ijiw==
X-Gm-Message-State: AGi0Pub1pUVnE2aPBUNjnbM4FJKgil6CTi/hQmL6RT2lbYzKDKJnG9fu
        TslckPm+r29hti9srSYpWrxZSNNj
X-Google-Smtp-Source: APiQypLsnPAbmLEDYe+JIEH3iu5p1LKD+pGChofe2nQJsinEA2/SNf23gcfAoBDKNR8FUs9JJJxuHw==
X-Received: by 2002:a5d:6acc:: with SMTP id u12mr11533880wrw.198.1587728996879;
        Fri, 24 Apr 2020 04:49:56 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r18sm4711462wrj.70.2020.04.24.04.49.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2020 04:49:56 -0700 (PDT)
Message-Id: <0535908dd7ea4487b342c0f86182579279c57b34.1587728992.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.615.v3.git.1587728992.gitgitgadget@gmail.com>
References: <pull.615.v2.git.1587685397.gitgitgadget@gmail.com>
        <pull.615.v3.git.1587728992.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 24 Apr 2020 11:49:52 +0000
Subject: [PATCH v3 3/3] credential: handle `credential.<partial-URL>.<key>`
 again
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Ilya Tretyakov <it@it3xl.ru>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

In the patches for CVE-2020-11008, the ability to specify credential
settings in the config for partial URLs got lost. For example, it used
to be possible to specify a credential helper for a specific protocol:

	[credential "https://"]
		helper = my-https-helper

Likewise, it used to be possible to configure settings for a specific
host, e.g.:

	[credential "dev.azure.com"]
		useHTTPPath = true

Let's reinstate this behavior.

While at it, increase the test coverage to document and verify the
behavior with a couple other categories of partial URLs.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 credential.c           | 18 +++++++++++++++++-
 t/t0300-credentials.sh | 39 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 56 insertions(+), 1 deletion(-)

diff --git a/credential.c b/credential.c
index 7dbbf26f174..c1a9ca4e485 100644
--- a/credential.c
+++ b/credential.c
@@ -35,6 +35,10 @@ int credential_match(const struct credential *want,
 #undef CHECK
 }
 
+
+static int credential_from_potentially_partial_url(struct credential *c,
+						   const char *url);
+
 static int credential_config_callback(const char *var, const char *value,
 				      void *data)
 {
@@ -53,7 +57,13 @@ static int credential_config_callback(const char *var, const char *value,
 		char *url = xmemdupz(key, dot - key);
 		int matched;
 
-		credential_from_url(&want, url);
+		if (credential_from_potentially_partial_url(&want, url) < 0) {
+			warning(_("skipping credential lookup for key: %s"),
+				var);
+			credential_clear(&want);
+			free(url);
+			return 0;
+		}
 		matched = credential_match(&want, c);
 
 		credential_clear(&want);
@@ -430,6 +440,12 @@ static int credential_from_url_1(struct credential *c, const char *url,
 	return 0;
 }
 
+static int credential_from_potentially_partial_url(struct credential *c,
+						   const char *url)
+{
+	return credential_from_url_1(c, url, 1, 0);
+}
+
 int credential_from_url_gently(struct credential *c, const char *url, int quiet)
 {
 	return credential_from_url_1(c, url, 0, quiet);
diff --git a/t/t0300-credentials.sh b/t/t0300-credentials.sh
index efed3ea2955..f796bbfd48b 100755
--- a/t/t0300-credentials.sh
+++ b/t/t0300-credentials.sh
@@ -448,4 +448,43 @@ test_expect_success 'credential system refuses to work with missing protocol' '
 	test_i18ncmp expect stderr
 '
 
+test_expect_success 'credential config with partial URLs' '
+	echo "echo password=yep" | write_script git-credential-yep &&
+	test_write_lines url=https://user@example.com/repo.git >stdin &&
+	for partial in \
+		example.com \
+		user@example.com \
+		https:// \
+		https://example.com \
+		https://example.com/ \
+		https://user@example.com \
+		https://user@example.com/ \
+		https://example.com/repo.git \
+		https://user@example.com/repo.git \
+		/repo.git
+	do
+		git -c credential.$partial.helper=yep \
+			credential fill <stdin >stdout &&
+		grep yep stdout ||
+		return 1
+	done &&
+
+	for partial in \
+		dont.use.this \
+		http:// \
+		/repo
+	do
+		git -c credential.$partial.helper=yep \
+			credential fill <stdin >stdout &&
+		! grep yep stdout ||
+		return 1
+	done &&
+
+	git -c credential.$partial.helper=yep \
+		-c credential.with%0anewline.username=uh-oh \
+		credential fill <stdin >stdout 2>stderr &&
+	test_i18ngrep "skipping credential lookup for key" stderr
+
+'
+
 test_done
-- 
gitgitgadget
