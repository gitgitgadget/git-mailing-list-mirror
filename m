Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 294A6200E0
	for <e@80x24.org>; Mon, 26 Dec 2016 10:23:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755700AbcLZKXO (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Dec 2016 05:23:14 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35912 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751154AbcLZKWx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Dec 2016 05:22:53 -0500
Received: by mail-wm0-f66.google.com with SMTP id m203so52438545wma.3
        for <git@vger.kernel.org>; Mon, 26 Dec 2016 02:22:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3rfr50j8oHQbqMt5UL2cUm40UT3kOv3zJ6rZ8W5yYhg=;
        b=mbeehAPXhFtRegiIPAWbqy9+Zt/aNpfo+B3NRDbJ7TpjKpv+oPncdSDXGoC/Rna+1F
         XX8/+P5nqnDUxESgemmt4pYt7j/VzW4sTCaJYrFxAz6gm+soyls5sC2tS509hh9w5ROc
         rdT4yvbWKySAT0S9NRzT00e62YV/dMHGMQpK5Dbg6XebUC1YvzQADVLmVE6DrS4fh2rz
         kgoohV/EKEp9wac2Ab8ufjH5AqEQ4W66q5DSP93XnFL/CrX2fqqtzgJbcaMJuMjs3Tqu
         UuY1/s1ruwGwGUesx3qcdOUnf48dj5/+DH+86fjNAiONxFVQR6IQHHHEsVKBcnITjyqj
         x96A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3rfr50j8oHQbqMt5UL2cUm40UT3kOv3zJ6rZ8W5yYhg=;
        b=iroHU/Crr2yBVfIyW7SSfVlvTJW8F8o/Tsz0oM6eu7acoX5lOjTE5UudUXIZKiJ2vB
         JDY7gK15WyTWHJQw9K8zeJC6b7+qwhcPBAQPBPi22a6rxRkvgUQj18+nm0XV87sL0WR1
         vj23LVdNDENbVCW/2hM5GUC/Qe0W8TbAV7pmgTe4DHTDmeRFYTQIqHdwtCEoNFX5oVxC
         +qhErCCQbn7fIggimAyQ04gWCkwBiJEV5xMgK4FRxK8reTi2fzhyFpqxlIeATUuAPP8K
         ijRHjTd5JO3Y8Fautge8Vr02Ua2zXiG6Nquzbwq3RlKGvybLrHJ/Fvwtlait/ttCfQ/9
         vlGQ==
X-Gm-Message-State: AIkVDXIuMP+j4aZ2BfoljQXPSM5GLG9ap26ZaIUaxBkgMkWzCHUiAB3aV1gyXS8XcknRiw==
X-Received: by 10.28.73.136 with SMTP id w130mr24057220wma.82.1482747772270;
        Mon, 26 Dec 2016 02:22:52 -0800 (PST)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id kp5sm54259010wjb.8.2016.12.26.02.22.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 26 Dec 2016 02:22:51 -0800 (PST)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v3 16/21] read-cache: unlink old sharedindex files
Date:   Mon, 26 Dec 2016 11:22:17 +0100
Message-Id: <20161226102222.17150-17-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.11.0.209.gda91e66374.dirty
In-Reply-To: <20161226102222.17150-1-chriscool@tuxfamily.org>
References: <20161226102222.17150-1-chriscool@tuxfamily.org>
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
 read-cache.c | 64 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 63 insertions(+), 1 deletion(-)

diff --git a/read-cache.c b/read-cache.c
index 9fbad2044b..e62a6c742d 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -2207,6 +2207,65 @@ static int write_split_index(struct index_state *istate,
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
@@ -2228,8 +2287,11 @@ static int write_shared_index(struct index_state *istate,
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
2.11.0.209.gda91e66374.dirty

