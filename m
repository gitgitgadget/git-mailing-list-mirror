Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 978F4C433EF
	for <git@archiver.kernel.org>; Wed, 15 Jun 2022 10:53:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347856AbiFOKx4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Jun 2022 06:53:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347630AbiFOKxs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Jun 2022 06:53:48 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A9D9522CC
        for <git@vger.kernel.org>; Wed, 15 Jun 2022 03:53:44 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id z17so6098665wmi.1
        for <git@vger.kernel.org>; Wed, 15 Jun 2022 03:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=901X0ygKxiNWdCwnvWDRPcFB+leBdtBX9EdDLWwUJgE=;
        b=QE+e4AKUnZ5j8yMYjnea0WSuyress6wP/Bw/0mrNyLzI7IYxdNDkzUjG7+RG04wv1W
         xvegFTd4xAVLWzcULHnqm/hxY8lE/YamBBvpOULQUt1iDR8yZGwliX61HAJLy3yRsyqu
         CvsiJBnqTQvZ9bhStMMLprOnUs0IHWyOZYvjH4XeJgLnUwQRhLU2mUKXrhnNwdJVNLSb
         uk0jrJR+pyeFCraWHedCUDTRwnu6gFxakYaqXiK8ZoB9rv6tjkZlJlXj/523nskXk/ho
         O9DkV19liUqtXeS5WIDJI7BYtxk7mpWnqPZ+e/R1upLHEqP/OChP9tFlKL8MeKpZY9Ew
         Tyew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=901X0ygKxiNWdCwnvWDRPcFB+leBdtBX9EdDLWwUJgE=;
        b=ozXRpZj+87zue2sT9M0a71zx7ntKpcrgU8v98TDf0r56dcG1+PklSYTNh2/M5WE/2y
         eblunkYyVffwVpYrevZQuZvLJ2ILHb2y7aV2Jn6ugPjtCbEUaNG4sEg5AWJBsKkvCoUd
         Up6P7ELjt5AAkt3/RLFGqML3eyqyZnZmp10781zfO1c5oDZumFD4WhU/f/EiqCkEKDbj
         3KoGzZu0MKlXDyUWiY59DFxbjXgU4CAbxiZgTioWWbvmRTiNo4e+pEAsNNDcxW72IjD6
         JwE1YeK2yZSlCBkzuW+qHvc+TgvpikZOYWMx58uLyLuNVj31+5tSJcL/1ZP9+kQ9hEeL
         IaLw==
X-Gm-Message-State: AOAM530A124E18vGvuF1OmcbtZPM8z2OJvcNF8hUHjAWqiyeUjQxGpHN
        pq7UiCb/II7arYIfwQzrlyDpjBH6bSLuGg==
X-Google-Smtp-Source: ABdhPJxgCY8sy3x8vBh0/RtL0Du4Mzj+XMuK89tCVKT0k+EJMPykP03+9BZ4dxip+W0zQw48/EfG4w==
X-Received: by 2002:a05:600c:6020:b0:39c:96ec:5014 with SMTP id az32-20020a05600c602000b0039c96ec5014mr9221786wmb.57.1655290422499;
        Wed, 15 Jun 2022 03:53:42 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id g12-20020a7bc4cc000000b0039bc95cf4b2sm1786747wmk.11.2022.06.15.03.53.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 03:53:41 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Derrick Stolee <derrickstolee@github.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC PATCH 5/5] transport: check remote.<name>pushurl with transfer.credentialsInUrl
Date:   Wed, 15 Jun 2022 12:53:32 +0200
Message-Id: <RFC-patch-5.5-6cafd6368a2-20220615T104503Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.1.1239.gfba91521d90
In-Reply-To: <RFC-cover-0.5-00000000000-20220615T104503Z-avarab@gmail.com>
References: <RFC-cover-0.5-00000000000-20220615T104503Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Expand the checks added in 6dcbdc0d661 (remote: create
fetch.credentialsInUrl config, 2022-06-06) to also check the
remote.<name>.pushurl setting. Before this it would only check the
remote.<name>.url setting, and would thus miss potential passwords in
the config.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 remote.c              | 63 ++++++++++++++++++++++++-------------------
 t/t5516-fetch-push.sh |  3 ++-
 2 files changed, 37 insertions(+), 29 deletions(-)

diff --git a/remote.c b/remote.c
index 61add35be2f..d4dcc02a827 100644
--- a/remote.c
+++ b/remote.c
@@ -642,6 +642,37 @@ enum credentials_in_url get_credentials_in_url(void)
 	return cred_in_url;
 }
 
+static void validate_one_remote_url(enum credentials_in_url cfg,
+				    const char *url, struct strbuf *redacted)
+{
+	struct url_info url_info = { 0 };
+
+	if (!url_normalize(url, &url_info) || !url_info.passwd_off)
+		goto cleanup;
+
+	strbuf_reset(redacted);
+	strbuf_add(redacted, url_info.url, url_info.passwd_off);
+	strbuf_addstr(redacted, "<redacted>");
+	strbuf_addstr(redacted, url_info.url + url_info.passwd_off +
+		      url_info.passwd_len);
+
+	switch (cfg) {
+	case CRED_IN_URL_WARN:
+		warning(_("URL '%s' uses plaintext credentials"), redacted->buf);
+		break;
+	case CRED_IN_URL_DIE:
+		die(_("URL '%s' uses plaintext credentials"), redacted->buf);
+		break;
+	case CRED_IN_URL_ALLOW:
+	case CRED_IN_URL_UNKNOWN:
+		BUG("unreachable");
+		break;
+	}
+cleanup:
+	free(url_info.url);
+}
+
+
 static void validate_remote_url(struct remote *remote)
 {
 	int i;
@@ -653,34 +684,10 @@ static void validate_remote_url(struct remote *remote)
 	if (cfg == CRED_IN_URL_ALLOW)
 		goto done;
 
-	for (i = 0; i < remote->url_nr; i++) {
-		struct url_info url_info = { 0 };
-
-		if (!url_normalize(remote->url[i], &url_info) ||
-		    !url_info.passwd_off)
-			goto loop_cleanup;
-
-		strbuf_reset(&redacted);
-		strbuf_add(&redacted, url_info.url, url_info.passwd_off);
-		strbuf_addstr(&redacted, "<redacted>");
-		strbuf_addstr(&redacted,
-			      url_info.url + url_info.passwd_off + url_info.passwd_len);
-
-		switch (cfg) {
-		case CRED_IN_URL_WARN:
-			warning(_("URL '%s' uses plaintext credentials"), redacted.buf);
-			break;
-		case CRED_IN_URL_DIE:
-			die(_("URL '%s' uses plaintext credentials"), redacted.buf);
-			break;
-		case CRED_IN_URL_ALLOW:
-		case CRED_IN_URL_UNKNOWN:
-			BUG("unreachable");
-			break;
-		}
-	loop_cleanup:
-		free(url_info.url);
-	}
+	for (i = 0; i < remote->url_nr; i++)
+		validate_one_remote_url(cfg, remote->url[i], &redacted);
+	for (i = 0; i < remote->pushurl_nr; i++)
+		validate_one_remote_url(cfg, remote->pushurl[i], &redacted);
 
 	strbuf_release(&redacted);
 done:
diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index c7a21d7cfb5..cdecc1c049c 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -1905,7 +1905,8 @@ test_expect_success CURL 'push warns or fails when using username:password in co
 	git -C repo remote set-url pwd-url https://localhost &&
 
 	test_must_fail git -C repo -c transfer.credentialsInUrl=warn push pwd-url HEAD:refs/heads/branch 2>err &&
-	! grep "warning: $message" err
+	grep "warning: $message" err >warnings &&
+	test_line_count = 1 warnings
 '
 
 test_done
-- 
2.36.1.1239.gfba91521d90

