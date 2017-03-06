Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DCAAD1FBEC
	for <e@80x24.org>; Mon,  6 Mar 2017 09:49:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753165AbdCFJtR (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Mar 2017 04:49:17 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33443 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752991AbdCFJtP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Mar 2017 04:49:15 -0500
Received: by mail-wm0-f65.google.com with SMTP id n11so12761033wma.0
        for <git@vger.kernel.org>; Mon, 06 Mar 2017 01:49:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XGtI1jUqimZeSG6hakqb7NFAfI6RJV0tEMpjJRQaPkM=;
        b=u/BC+9x5+L720Tafiyw0pJK0UYlsx1zDMV/aNEkQ67j+B5cwbQECCxW1OuBpHnW9Au
         M1vUq8bI0YjvQIAVXUS0ERWfqtty19+LV0JmPl7MLiOV5fXrEVVcaH7l67To7503XHuV
         MCZQRY1utrGxZD73xEqvqebyFG0eWpqUkJyuoexg+GKpc+Yout1ByEMTYYf4rm2Lo5wp
         ol1twmmLR4aP6JaEsy7HqpzjzW0/5qUPFfExJZqxgs3hS2brmSicqgAQkMNOe4kiO7TI
         aBVipDc0YDWUoeJc9iTcZYSc9jkETSgSbbVwsBlAOOydp1KbROKAQjlKNoXYCm54FRwv
         KIAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=XGtI1jUqimZeSG6hakqb7NFAfI6RJV0tEMpjJRQaPkM=;
        b=OhCc0W1kgHOkkq71FRJXlmcs3AKr6i3KFyIrI3bTT4w3RB35/pn9PUiZGIXMHwFrGk
         rRPc8Py0wm1n/U2Q1ix+2M5Y44wEGOr6eNSrlPme5gfb2ekF0i8oFxv15UeGLVikd3SO
         Rtrtrm5v3/Zu9cyoz0eX3GAcRB7WjhtZbQ83eMPaTijhguiugR+8htsOtOf7jiMnabh1
         eQCXFUBd76uBdMJP4ejx7YzEK/cjnGhSflyJmsZ3+V66+tl3h5M1t8EK+Bqsng37E7Ux
         e0YnlMQzqrvHSEhbtZV2buPCFyLYbKJdP+Zi//zZcaWLamKXyT2RG9KAtm8LpFWUFcsJ
         /8EQ==
X-Gm-Message-State: AMke39kKxCw2IvNvIrxJlWFZ7bjVyQV+JuJ0Yi505alVnzYamqVdmkCfXzBNU4NC88JK6g==
X-Received: by 10.28.5.72 with SMTP id 69mr12161882wmf.6.1488793361122;
        Mon, 06 Mar 2017 01:42:41 -0800 (PST)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id 191sm14144086wmo.21.2017.03.06.01.42.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 06 Mar 2017 01:42:40 -0800 (PST)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v5 17/22] read-cache: unlink old sharedindex files
Date:   Mon,  6 Mar 2017 10:41:58 +0100
Message-Id: <20170306094203.28250-18-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.12.0.206.g74921e51d6.dirty
In-Reply-To: <20170306094203.28250-1-chriscool@tuxfamily.org>
References: <20170306094203.28250-1-chriscool@tuxfamily.org>
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
index 13375fa0ff..16c05f359b 100644
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
+static int should_delete_shared_index(const char *shared_index_path)
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
+		if (should_delete_shared_index(shared_index_path) > 0 &&
+		    unlink(shared_index_path))
+			warning_errno(_("unable to unlink: %s"), shared_index_path);
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
2.12.0.206.g74921e51d6.dirty

