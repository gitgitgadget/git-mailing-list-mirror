Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 39D3F1FF76
	for <e@80x24.org>; Sat, 17 Dec 2016 14:56:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758112AbcLQO40 (ORCPT <rfc822;e@80x24.org>);
        Sat, 17 Dec 2016 09:56:26 -0500
Received: from mail-wj0-f196.google.com ([209.85.210.196]:36739 "EHLO
        mail-wj0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758008AbcLQO4X (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Dec 2016 09:56:23 -0500
Received: by mail-wj0-f196.google.com with SMTP id j10so18022928wjb.3
        for <git@vger.kernel.org>; Sat, 17 Dec 2016 06:56:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2KOPIEM37Pzfsf7xOdvPXEtXzJts19s8xe4nSwyd2/0=;
        b=nC/lrLngyF4zLObNSv9wIxA/YVa8t1Aw0AJOXyly77tjdqLoggPd6a/YDqvvqPtUvv
         cV7XXA9GErDccOjucg/2+D6WGsDTPjEtjxfUWTIISWw0a+EFdrGhuWgeMZi2/fgr7kv0
         mO05UVsj/cMvl8Ub+B4VN/0Ub7/yOL0aHT60Ca/EMh6BEkGNNDj6WBxoB0InygVVMpGG
         vkqfj9KXgoglT3WiOH2vJvPpV1VoIPqufd3iCfAqrDIn7E+xOHNIbCCpa7zjN8LalQck
         NVhwsdfnp4hWN8QIzADHB1oQe8K3yeNCbyqBb0XzMq0EBV7fYn/TvkwfC32aIf1YNRhE
         gpCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2KOPIEM37Pzfsf7xOdvPXEtXzJts19s8xe4nSwyd2/0=;
        b=IjywG/hXi/gXRwavl/mvH7DJgokXQPeiETgQQTd0hYZa6dheMkcARVP35EMe1YXE09
         693o7VucfkOG5RQqpahJkA8epg3uvLGtUlNJ5cTIJ+mNvg7d9fWiA2aPIR+EsR/1SjyG
         OOzqUo85NXixCU/j4Qwxo4BBXSUqjs8KLLmFunRjjSWJlJnMxmmQfZ+y0IQUhh8QDhNX
         VHuJetsvUzZsNlyOxeJ8rUtaFjz0FxwoPY3oNCcEWfxDjo9IFrvUiuKmCBTErI94L7Y3
         98JH07wlKwBF2sb73W2Bh0UdaGVMbpypJcg0ndAHHCSCeVKNf/lPei2vqJzuLxsYccbs
         1ezA==
X-Gm-Message-State: AIkVDXLNgR6TILaQR4sCZhmQSh3+wevXPi9heCJR68n5JDtCpL8fss94cBbupV5oGt/xTw==
X-Received: by 10.194.123.201 with SMTP id mc9mr8402976wjb.47.1481986581625;
        Sat, 17 Dec 2016 06:56:21 -0800 (PST)
Received: from localhost.localdomain (85.198.126.78.rev.sfr.net. [78.126.198.85])
        by smtp.gmail.com with ESMTPSA id y4sm11823449wjp.0.2016.12.17.06.56.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 17 Dec 2016 06:56:20 -0800 (PST)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2 16/21] read-cache: unlink old sharedindex files
Date:   Sat, 17 Dec 2016 15:55:42 +0100
Message-Id: <20161217145547.11748-17-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.11.0.49.g2414764.dirty
In-Reply-To: <20161217145547.11748-1-chriscool@tuxfamily.org>
References: <20161217145547.11748-1-chriscool@tuxfamily.org>
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
deleted. It defaults to "1.week.ago".

A previous commit made sure that each time a split index file is
created the mtime of the shared index file it references is updated.
This makes sure that recently used shared index file will not be
deleted.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 read-cache.c | 63 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 62 insertions(+), 1 deletion(-)

diff --git a/read-cache.c b/read-cache.c
index 42688261f7..8e99a7c325 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -2210,6 +2210,64 @@ static int write_split_index(struct index_state *istate,
 	return ret;
 }
 
+static const char *shared_index_expire = "1.week.ago";
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
+static int can_delete_shared_index(const char *shared_sha1_hex)
+{
+	struct stat st;
+	unsigned long expiration;
+	const char *shared_index = git_path("sharedindex.%s", shared_sha1_hex);
+
+	/* Check timestamp */
+	expiration = get_shared_index_expire_date();
+	if (!expiration)
+		return 0;
+	if (stat(shared_index, &st))
+		return error_errno(_("could not stat '%s"), shared_index);
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
+		if (!skip_prefix(de->d_name, "sharedindex.", &sha1_hex))
+			continue;
+		if (!strcmp(sha1_hex, current_hex))
+			continue;
+		if (can_delete_shared_index(sha1_hex) > 0 &&
+		    unlink(git_path("%s", de->d_name)))
+			error_errno(_("unable to unlink: %s"), git_path("%s", de->d_name));
+	}
+	closedir(dir);
+
+	return 0;
+}
+
 static struct tempfile temporary_sharedindex;
 
 static int write_shared_index(struct index_state *istate,
@@ -2231,8 +2289,11 @@ static int write_shared_index(struct index_state *istate,
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
2.11.0.49.g2414764.dirty

