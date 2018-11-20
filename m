Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D7FC01F87F
	for <e@80x24.org>; Tue, 20 Nov 2018 06:14:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731421AbeKTQly (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Nov 2018 11:41:54 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:36142 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730652AbeKTQly (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Nov 2018 11:41:54 -0500
Received: by mail-pl1-f195.google.com with SMTP id y6-v6so477961plt.3
        for <git@vger.kernel.org>; Mon, 19 Nov 2018 22:14:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=czKKctsjZPaanumPTLI0mweRRcFUGrjfM19q4DkYANk=;
        b=UOQPeRXDNuIDJpPolIN1U4Nmj6Xm1qAvmcmno+KJkjRhNYrXCTyX5zG00pd+jzxw2+
         j93h9Q65We9KzX8uEfazlIrR5ZEUPiZjY1Rd9ySfTGenTSpTVVo5qO3Cj3HM+o9MbnoH
         KrpDTsMn3lzEp1uf7Ily/j4fqDm60K+bc0htiSN8xJCwXydGXxWGg4/Hzx52HjOtXIp2
         otbRD8fUCHqitWpTSNiu36cuGdHlAEE36omRYSBWJnINW4OafSSEwoAeZwkfamTmjkXz
         sjbs2eUSegdzt95qyPZBiy3X62O2nVOK7cpmOhJIOxq2n12N3ryfW2LuO9A+/fuCUmJ3
         j3TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=czKKctsjZPaanumPTLI0mweRRcFUGrjfM19q4DkYANk=;
        b=hQPqfps3wUAF5f2864wcZji4djPJOPzjykfvK6kpYZdY17q1ytkroYl5oP76vHucQ8
         lUBMvaXoUmmYj4geFvSz0vaqbjrnUkMS6LpD5lnNMqJbAHUzLFBnhtycalr8g2DdomUc
         NJrr7B2noSNSqkYiSzymoEEsVH6Bql/11HMknqlReKjaduTzbdhLeV60DHTdVm6adrJc
         3aI8haM/A7Op2h7BIypgs1IzdgCyKcoAdVkwZduh3A/x5ZPD0IO0uDQ6nqa17bQDI2Wy
         Mr7Qd30ac4nKeT4dWCS97KWSB6wbbX87UF5Q/8wABsM882yWM/lj1EJ9j0uuOlpGXXkz
         p9yg==
X-Gm-Message-State: AA+aEWaK3iGwacDJ9o1JC7h1oG+52l3siGIKaHxVD4I4l5+RLRD2GIKe
        pzoIgSwCez2OZxJ2xpEvaAE=
X-Google-Smtp-Source: AFSGD/WDDTT1cNA0oo5qBCFcq9To+o+inUKG9Wum9Y1268RZpXIFfr2Bcqvi4rtN180rYI4Lt3wvGQ==
X-Received: by 2002:a17:902:1a8:: with SMTP id b37-v6mr883474plb.314.1542694469658;
        Mon, 19 Nov 2018 22:14:29 -0800 (PST)
Received: from google.com ([2620:0:100e:913:3fb0:1473:cdbf:42])
        by smtp.gmail.com with ESMTPSA id t90sm28000472pfj.23.2018.11.19.22.14.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 19 Nov 2018 22:14:29 -0800 (PST)
Date:   Mon, 19 Nov 2018 22:14:26 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Ben Peart <peartben@gmail.com>, git@vger.kernel.org,
        pclouds@gmail.com, Ben Peart <benpeart@microsoft.com>,
        jonathantanmy@google.com
Subject: [PATCH 4/5] index: make index.threads=true enable ieot and eoie
Message-ID: <20181120061426.GE144753@google.com>
References: <20180823154053.20212-1-benpeart@microsoft.com>
 <20181010155938.20996-1-peartben@gmail.com>
 <20181113003817.GA170017@google.com>
 <20181113003938.GC170017@google.com>
 <f2f8cec8-d770-a1e9-b5a1-83653575122e@gmail.com>
 <xmqqo9asqrxu.fsf@gitster-ct.c.googlers.com>
 <20181120060920.GA144753@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181120060920.GA144753@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If a user explicitly sets

	[index]
		threads = true

to read the index using multiple threads, ensure that index writes
include the offset table by default to make that possible.  This
ensures that the user's intent of turning on threading is respected.

In other words, permit the following configurations:

- index.threads and index.recordOffsetTable unspecified: do not write
  the offset table yet (to avoid alarming the user with "ignoring IEOT
  extension" messages when an older version of Git accesses the
  repository) but do make use of multiple threads to read the index if
  the supporting offset table is present.

  This can also be requested explicitly by setting index.threads=true,
  0, or >1 and index.recordOffsetTable=false.

- index.threads=false or 1: do not write the offset table, and do not
  make use of the offset table.

  One can set index.recordOffsetTable=false as well, to be more
  explicit.

- index.threads=true, 0, or >1 and index.recordOffsetTable unspecified:
  write the offset table and make use of threads at read time.

  This can also be requested by setting index.threads=true, 0, >1, or
  unspecified and index.recordOffsetTable=true.

Fortunately the complication is temporary: once most Git installations
have upgraded to a version with support for the IEOT and EOIE
extensions, we can flip the defaults for index.recordEndOfIndexEntries
and index.recordOffsetTable to true and eliminate the settings.

Helped-by: Ben Peart <benpeart@microsoft.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
New, based on Ben Peart's feedback.  Turned out simpler than I feared
--- thanks, Ben, for pushing for this.

 Documentation/config/index.txt |  6 ++++--
 config.c                       | 17 ++++++++++-------
 config.h                       |  2 +-
 read-cache.c                   | 23 +++++++++++++++++------
 4 files changed, 32 insertions(+), 16 deletions(-)

diff --git a/Documentation/config/index.txt b/Documentation/config/index.txt
index de44183235..f181503041 100644
--- a/Documentation/config/index.txt
+++ b/Documentation/config/index.txt
@@ -3,14 +3,16 @@ index.recordEndOfIndexEntries::
 	Entry" section. This reduces index load time on multiprocessor
 	machines but produces a message "ignoring EOIE extension" when
 	reading the index using Git versions before 2.20. Defaults to
-	'false'.
+	'true' if index.threads has been explicitly enabled, 'false'
+	otherwise.
 
 index.recordOffsetTable::
 	Specifies whether the index file should include an "Index Entry
 	Offset Table" section. This reduces index load time on
 	multiprocessor machines but produces a message "ignoring IEOT
 	extension" when reading the index using Git versions before 2.20.
-	Defaults to 'false'.
+	Defaults to 'true' if index.threads has been explicitly enabled,
+	'false' otherwise.
 
 index.threads::
 	Specifies the number of threads to spawn when loading the index.
diff --git a/config.c b/config.c
index 04286f7717..ff521eb27a 100644
--- a/config.c
+++ b/config.c
@@ -2294,22 +2294,25 @@ int git_config_get_fsmonitor(void)
 	return 0;
 }
 
-int git_config_get_index_threads(void)
+int git_config_get_index_threads(int *dest)
 {
-	int is_bool, val = 0;
+	int is_bool, val;
 
 	val = git_env_ulong("GIT_TEST_INDEX_THREADS", 0);
-	if (val)
-		return val;
+	if (val) {
+		*dest = val;
+		return 0;
+	}
 
 	if (!git_config_get_bool_or_int("index.threads", &is_bool, &val)) {
 		if (is_bool)
-			return val ? 0 : 1;
+			*dest = val ? 0 : 1;
 		else
-			return val;
+			*dest = val;
+		return 0;
 	}
 
-	return 0; /* auto */
+	return 1;
 }
 
 NORETURN
diff --git a/config.h b/config.h
index a06027e69b..ee5d3fa7b4 100644
--- a/config.h
+++ b/config.h
@@ -246,11 +246,11 @@ extern int git_config_get_bool(const char *key, int *dest);
 extern int git_config_get_bool_or_int(const char *key, int *is_bool, int *dest);
 extern int git_config_get_maybe_bool(const char *key, int *dest);
 extern int git_config_get_pathname(const char *key, const char **dest);
+extern int git_config_get_index_threads(int *dest);
 extern int git_config_get_untracked_cache(void);
 extern int git_config_get_split_index(void);
 extern int git_config_get_max_percent_split_change(void);
 extern int git_config_get_fsmonitor(void);
-extern int git_config_get_index_threads(void);
 
 /* This dies if the configured or default date is in the future */
 extern int git_config_get_expiry(const char *key, const char **output);
diff --git a/read-cache.c b/read-cache.c
index 83d24357a6..002ed2c1e4 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -2176,7 +2176,8 @@ int do_read_index(struct index_state *istate, const char *path, int must_exist)
 
 	src_offset = sizeof(*hdr);
 
-	nr_threads = git_config_get_index_threads();
+	if (git_config_get_index_threads(&nr_threads))
+		nr_threads = 1;
 
 	/* TODO: does creating more threads than cores help? */
 	if (!nr_threads) {
@@ -2695,7 +2696,13 @@ static int record_eoie(void)
 
 	if (!git_config_get_bool("index.recordendofindexentries", &val))
 		return val;
-	return 0;
+
+	/*
+	 * As a convenience, the end of index entries extension
+	 * used for threading is written by default if the user
+	 * explicitly requested threaded index reads.
+	 */
+	return !git_config_get_index_threads(&val) && val != 1;
 }
 
 static int record_ieot(void)
@@ -2704,7 +2711,13 @@ static int record_ieot(void)
 
 	if (!git_config_get_bool("index.recordoffsettable", &val))
 		return val;
-	return 0;
+
+	/*
+	 * As a convenience, the offset table used for threading is
+	 * written by default if the user explicitly requested
+	 * threaded index reads.
+	 */
+	return !git_config_get_index_threads(&val) && val != 1;
 }
 
 /*
@@ -2765,9 +2778,7 @@ static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
 	if (ce_write(&c, newfd, &hdr, sizeof(hdr)) < 0)
 		return -1;
 
-	if (HAVE_THREADS)
-		nr_threads = git_config_get_index_threads();
-	else
+	if (!HAVE_THREADS || git_config_get_index_threads(&nr_threads))
 		nr_threads = 1;
 
 	if (nr_threads != 1 && record_ieot()) {
-- 
2.20.0.rc0.387.gc7a69e6b6c

