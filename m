Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7885720229
	for <e@80x24.org>; Sun, 23 Oct 2016 09:27:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756436AbcJWJ1u (ORCPT <rfc822;e@80x24.org>);
        Sun, 23 Oct 2016 05:27:50 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:32933 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756354AbcJWJ13 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 Oct 2016 05:27:29 -0400
Received: by mail-wm0-f66.google.com with SMTP id d128so5249219wmf.0
        for <git@vger.kernel.org>; Sun, 23 Oct 2016 02:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GiEI2WRJRjeku13FVsb/GZ14gWyARmhXRX/NYQo5MDs=;
        b=TBBSzWUkHrME6Nons6xjaRU9d9XJWJV1AYSdBBTZ1YY3LYWY6vtmMLlZGhdtKYh/qx
         4NSd8NQOrskPXLQ2itqge8SBTYqyM5XUgYraXPakK1zAxfmZ7Xymvhwt2LQWlvhXFeIL
         ZR8RVAR6RWoNhYkpa9yqrWUvprPUzur+/0Ds+peyKi/dQoCJn7mNyY+FtYyFoV5MBvkP
         ESxbu7KaDzK9UdJuj1CYvPhQcxIl2Cxdm3RWp1A0u/Bz07pR4cYu3HZ1gCv1PNVpKYU3
         GmzOozzm6CrBb8llEMwNPIIUTEReu0T/jOCpksI5KSTUdFdowgLZ8i0udcF+KxIJhV07
         WnrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GiEI2WRJRjeku13FVsb/GZ14gWyARmhXRX/NYQo5MDs=;
        b=iGw0DB8rFQfeMK2HrFir09Qxkno3K8HVIsRhJtOkHS0IeKTJBQsXZTy9QQBjq0B8yD
         gOnGccxooIg1qnb3sk1PggalJdhMDsUY+0VuJ9ifD/EIp5tyeVT4fMe9I7KhDhQ11SrF
         SbhvsgxwMsCBB6MpCGMsmwlJf/R+F49QFjBRX+uIW1fE3RLVgGyfFgJskGPZFEE4OcXv
         I1c7H8ahlpSgjkcv5kPzPegsEyLm/+s+QEwK4ChIgSu4Rz7pjxh7sVM/8pUpooc4Hiz3
         IDPSZyvchGmqEE4em/GGXYkiL8AenAXbkkgnwr2w6FmHUVEVBhikhMOpUcsclAUetSa2
         LzOg==
X-Gm-Message-State: AA6/9RlgUfEJU2yhReM8YolGB+xG4tli2MCbj96twlGEnvbQw+RjQnlHCmtJkv8dB7YfaQ==
X-Received: by 10.28.132.130 with SMTP id g124mr17896101wmd.37.1477214847918;
        Sun, 23 Oct 2016 02:27:27 -0700 (PDT)
Received: from localhost.localdomain (183.187.113.78.rev.sfr.net. [78.113.187.183])
        by smtp.gmail.com with ESMTPSA id x138sm8257569wme.14.2016.10.23.02.27.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 23 Oct 2016 02:27:27 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v1 16/19] read-cache: unlink old sharedindex files
Date:   Sun, 23 Oct 2016 11:26:45 +0200
Message-Id: <20161023092648.12086-17-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.10.1.462.g7e1e03a
In-Reply-To: <20161023092648.12086-1-chriscool@tuxfamily.org>
References: <20161023092648.12086-1-chriscool@tuxfamily.org>
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
index 3aeff77..65ceb29 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -2190,6 +2190,64 @@ static int write_split_index(struct index_state *istate,
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
+		git_config_get_date_string("splitindex.sharedindexexpire",
+					   &shared_index_expire);
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
+		return error_errno("could not stat '%s", shared_index);
+	if (st.st_mtime > expiration)
+		return 0;
+
+	return 1;
+}
+
+static void clean_shared_index_files(const char *current_hex)
+{
+	struct dirent *de;
+	DIR *dir = opendir(get_git_dir());
+
+	if (!dir) {
+		error_errno("unable to open git dir: %s", get_git_dir());
+		return;
+	}
+
+	while ((de = readdir(dir)) != NULL) {
+		const char *sha1_hex;
+		if (!skip_prefix(de->d_name, "sharedindex.", &sha1_hex))
+			continue;
+		if (!strcmp(sha1_hex, current_hex))
+			continue;
+		if (can_delete_shared_index(sha1_hex) > 0 &&
+		    unlink(git_path("%s", de->d_name)))
+			error_errno("unable to unlink: %s", git_path("%s", de->d_name));
+	}
+	closedir(dir);
+}
+
 static struct tempfile temporary_sharedindex;
 
 static int write_shared_index(struct index_state *istate,
@@ -2211,8 +2269,11 @@ static int write_shared_index(struct index_state *istate,
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
2.10.1.462.g7e1e03a

