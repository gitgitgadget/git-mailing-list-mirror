Return-Path: <SRS0=90au=Z7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 789A1C00454
	for <git@archiver.kernel.org>; Mon,  9 Dec 2019 11:53:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FB72207FF
	for <git@archiver.kernel.org>; Mon,  9 Dec 2019 11:53:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DroHumxQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727646AbfLILxN (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Dec 2019 06:53:13 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40395 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727629AbfLILxM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Dec 2019 06:53:12 -0500
Received: by mail-wr1-f65.google.com with SMTP id c14so15855918wrn.7
        for <git@vger.kernel.org>; Mon, 09 Dec 2019 03:53:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QrX7df9gsdQ60K203c9+tqg6YksYfzuqMXfI1+OFi+o=;
        b=DroHumxQjM+OcIw5h0oobHBnXWadLdmpBD2Knxj/ifCVrOaH+E00lhVhCgNtNz+LYY
         iMPVIb6Rk3oJyTHDwWX31X0mJHZPMrIqzCbFPtHrtH0VOrjNOMdY8vpowijGP09EkIhi
         jw0ykpahME7WZ0DVDPDeZ3fd2pl6Sp9jp6PCbeojUjUxOs/lunfHqomtoD1q4A6o9mkl
         Jpa5rQx2cKKWNaBFszIESpe50XX7G/t11g5zrY9LB4qyzMQIQ7Ruv6xzr57cHNu0+ORJ
         neCW5QJE9JhktKSmr1JzHubYrVPMe00RhEUCvqsg7Hv+NGdTsU0ssdPY4YA+b081Xuux
         glKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QrX7df9gsdQ60K203c9+tqg6YksYfzuqMXfI1+OFi+o=;
        b=ti260no/PSOCObRB/TT9UXFg0RNt5YuZduXHRW8M5R/gYBc+LDkjGlYI7ggSeZpjo0
         r8dTyH6C5JV40sQzOSX2whnoEmS9TSVlk0sHFmX3sZs138A59/yZ0OUeCqUN7adDtXBC
         WA8dBCJ29/oLS0wrawxHAKguKO7wD7osGDe0T80O/q1anyauWCvFD3iEWBqHiLeYXUlE
         ThHW1blfYq51WTmJ/OjW63kCMaWWNsO3dpLb3BKsim6YI1PsXzmxbbjEhfvAg/7tGVPF
         /GrtzZwZ6MizScf/D2pPL0L4LOZ72vhr0hnzVJX0pr8EGIJDDKl+R9yBQsS3Nrvua1PR
         6vFQ==
X-Gm-Message-State: APjAAAVourcSPVXptCOKg3xElIIW+cJz2DR1+Dx4XoaboQ1JnmZacs5K
        VnF1ZsWAuAPqznQAW38Ds/6ddVpI
X-Google-Smtp-Source: APXvYqxpvoovbKoxwkQykhaQmuBZZP37vPVn2d3ekm8/JmxSfOeiVrcOyzNlQobyW3iEkaLvPz3lvA==
X-Received: by 2002:a5d:6748:: with SMTP id l8mr1799023wrw.188.1575892391018;
        Mon, 09 Dec 2019 03:53:11 -0800 (PST)
Received: from localhost.localdomain (x4db55b9c.dyn.telefonica.de. [77.181.91.156])
        by smtp.gmail.com with ESMTPSA id k8sm27239621wrl.3.2019.12.09.03.53.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 09 Dec 2019 03:53:10 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v3 07/14] name-rev: extract creating/updating a 'struct name_rev' into a helper
Date:   Mon,  9 Dec 2019 12:52:51 +0100
Message-Id: <20191209115258.9281-8-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.24.0.801.g241c134b8d
In-Reply-To: <20191209115258.9281-1-szeder.dev@gmail.com>
References: <20191112103821.30265-1-szeder.dev@gmail.com>
 <20191209115258.9281-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In a later patch in this series we'll want to do this in two places.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 builtin/name-rev.c | 40 +++++++++++++++++++++++++++-------------
 1 file changed, 27 insertions(+), 13 deletions(-)

diff --git a/builtin/name-rev.c b/builtin/name-rev.c
index 7e003c2702..e43df19709 100644
--- a/builtin/name-rev.c
+++ b/builtin/name-rev.c
@@ -79,12 +79,36 @@ static int is_better_name(struct rev_name *name,
 	return 0;
 }
 
+static struct rev_name *create_or_update_name(struct commit *commit,
+					      const char *tip_name,
+					      timestamp_t taggerdate,
+					      int generation, int distance,
+					      int from_tag)
+{
+	struct rev_name *name = get_commit_rev_name(commit);
+
+	if (name == NULL) {
+		name = xmalloc(sizeof(*name));
+		set_commit_rev_name(commit, name);
+		goto copy_data;
+	} else if (is_better_name(name, taggerdate, distance, from_tag)) {
+copy_data:
+		name->tip_name = tip_name;
+		name->taggerdate = taggerdate;
+		name->generation = generation;
+		name->distance = distance;
+		name->from_tag = from_tag;
+
+		return name;
+	} else
+		return NULL;
+}
+
 static void name_rev(struct commit *commit,
 		const char *tip_name, timestamp_t taggerdate,
 		int generation, int distance, int from_tag,
 		int deref)
 {
-	struct rev_name *name = get_commit_rev_name(commit);
 	struct commit_list *parents;
 	int parent_number = 1;
 	char *to_free = NULL;
@@ -101,18 +125,8 @@ static void name_rev(struct commit *commit,
 			die("generation: %d, but deref?", generation);
 	}
 
-	if (name == NULL) {
-		name = xmalloc(sizeof(*name));
-		set_commit_rev_name(commit, name);
-		goto copy_data;
-	} else if (is_better_name(name, taggerdate, distance, from_tag)) {
-copy_data:
-		name->tip_name = tip_name;
-		name->taggerdate = taggerdate;
-		name->generation = generation;
-		name->distance = distance;
-		name->from_tag = from_tag;
-	} else {
+	if (!create_or_update_name(commit, tip_name, taggerdate, generation,
+				   distance, from_tag)) {
 		free(to_free);
 		return;
 	}
-- 
2.24.0.801.g241c134b8d

