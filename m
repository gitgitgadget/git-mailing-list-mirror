Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 219291F5FB
	for <e@80x24.org>; Mon, 27 Feb 2017 18:59:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751563AbdB0S6T (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Feb 2017 13:58:19 -0500
Received: from mail-wr0-f194.google.com ([209.85.128.194]:36399 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751531AbdB0S57 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Feb 2017 13:57:59 -0500
Received: by mail-wr0-f194.google.com with SMTP id l37so2616885wrc.3
        for <git@vger.kernel.org>; Mon, 27 Feb 2017 10:57:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=aRua29i+napk86mlKp8eOrj3EY/h7NxFX9GDnpzTmMk=;
        b=puwJ1p8EVYdlp0v4vT5Wh0ZSjfpdbBGGORbmEzveAlG8LH5CsIwLyo5OUNYlEIFpq5
         YxIu+ho6CAdG+TNix9AIyCvkr4dZU4ellVH9Ceof84ZVWfaeqU3E6b+sapXcAiS1NJTl
         B90M6BJcBi2+GdFZnT8gT3YgSpzSmg6C97mYEptuMqPTtWWWaX6YFDUoYEBlhEAkv18G
         NBCdvDgJE1/cdJ6w4vnrLpJwr2/NRLQPPKAqlL76vzTd1Jv4b5GZD2/vvZHsJRneFlnP
         XsBHMn/+hHYln4z5V3XfeP/cmwHtnzIjaeN7MAyhOMmSkvcEqk1KsTfQv+t8J3VuJWUm
         9Oww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=aRua29i+napk86mlKp8eOrj3EY/h7NxFX9GDnpzTmMk=;
        b=U/4yIFeRFnCRcaqpgdHgfO94kli62t8GHkuclrghIXhFCu2Rc6zNozg5UMTFqbseZj
         mYqHDDgboXnvAi6Ds/xpkiZz9DQXcWFSB766RFc7ZtsTb3BtKOpTm8x0mZ76xzYmFusn
         eYE9yyhJ/Nbu1r0oC73j2E+t8wSIiT0R3m/DQ6b8g7xKV3+YpicMJ1um0TV8zuliumPp
         qiLMtdNF/9P7N2TT3r41uiv1w6Iz+OvlmqchaF/L7R6477TuQXuzibk26d+WON4qBrHZ
         4wqmdmSL6JofX0K6QZMAkUjkWRRCWDs/6oPdHJd4kgKZH7YEOP9ERM4W29luvkhrwIVi
         HZuQ==
X-Gm-Message-State: AMke39nRh7Rvn3esRWbks768Z5SWrjSXeMWHEuC6gyIE5oVPfAXUPQP/T7t24cwUijPZLw==
X-Received: by 10.223.145.193 with SMTP id 59mr15744740wri.82.1488218460206;
        Mon, 27 Feb 2017 10:01:00 -0800 (PST)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id e73sm15226798wmi.32.2017.02.27.10.00.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 27 Feb 2017 10:00:59 -0800 (PST)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v4 17/22] read-cache: unlink old sharedindex files
Date:   Mon, 27 Feb 2017 19:00:14 +0100
Message-Id: <20170227180019.18666-18-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.12.0.22.g0672473d40
In-Reply-To: <20170227180019.18666-1-chriscool@tuxfamily.org>
References: <20170227180019.18666-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Everytime split index is turned on, it creates a "sharedindex.XXXX"
file in the git directory. This change makes sure that shared index
files that haven't been used for a long time are removed when a new
shared index file is created.

The new "splitIndex.sharedIndexExpire" config variable is created
to tell the delay after which an unused shared index file can be
deleted. It defaults to "2.weeks.ago".

A previous commit made sure that each time a split index file is
created the mtime of the shared index file it references is updated.
This makes sure that recently used shared index file will not be
deleted.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 read-cache.c | 64 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 63 insertions(+), 1 deletion(-)

diff --git a/read-cache.c b/read-cache.c
index 5f295af4c6..45fc831010 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -2199,6 +2199,65 @@ static int write_split_index(struct index_state *istate,
 	return ret;
 }
 
+static const char *shared_index_expire = "2.weeks.ago";
+
+static unsigned long get_shared_index_expire_date(void)
+{
+	static unsigned long shared_index_expire_date;
+	static int shared_index_expire_date_prepared;
+
+	if (!shared_index_expire_date_prepared) {
+		git_config_get_expiry("splitindex.sharedindexexpire",
+				      &shared_index_expire);
+		shared_index_expire_date = approxidate(shared_index_expire);
+		shared_index_expire_date_prepared = 1;
+	}
+
+	return shared_index_expire_date;
+}
+
+static int can_delete_shared_index(const char *shared_index_path)
+{
+	struct stat st;
+	unsigned long expiration;
+
+	/* Check timestamp */
+	expiration = get_shared_index_expire_date();
+	if (!expiration)
+		return 0;
+	if (stat(shared_index_path, &st))
+		return error_errno(_("could not stat '%s"), shared_index_path);
+	if (st.st_mtime > expiration)
+		return 0;
+
+	return 1;
+}
+
+static int clean_shared_index_files(const char *current_hex)
+{
+	struct dirent *de;
+	DIR *dir = opendir(get_git_dir());
+
+	if (!dir)
+		return error_errno(_("unable to open git dir: %s"), get_git_dir());
+
+	while ((de = readdir(dir)) != NULL) {
+		const char *sha1_hex;
+		const char *shared_index_path;
+		if (!skip_prefix(de->d_name, "sharedindex.", &sha1_hex))
+			continue;
+		if (!strcmp(sha1_hex, current_hex))
+			continue;
+		shared_index_path = git_path("%s", de->d_name);
+		if (can_delete_shared_index(shared_index_path) > 0 &&
+		    unlink(shared_index_path))
+			error_errno(_("unable to unlink: %s"), shared_index_path);
+	}
+	closedir(dir);
+
+	return 0;
+}
+
 static struct tempfile temporary_sharedindex;
 
 static int write_shared_index(struct index_state *istate,
@@ -2220,8 +2279,11 @@ static int write_shared_index(struct index_state *istate,
 	}
 	ret = rename_tempfile(&temporary_sharedindex,
 			      git_path("sharedindex.%s", sha1_to_hex(si->base->sha1)));
-	if (!ret)
+	if (!ret) {
 		hashcpy(si->base_sha1, si->base->sha1);
+		clean_shared_index_files(sha1_to_hex(si->base->sha1));
+	}
+
 	return ret;
 }
 
-- 
2.12.0.22.g0672473d40

