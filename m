Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B67F920248
	for <e@80x24.org>; Sat,  6 Apr 2019 11:37:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726676AbfDFLhm (ORCPT <rfc822;e@80x24.org>);
        Sat, 6 Apr 2019 07:37:42 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37072 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726036AbfDFLhm (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Apr 2019 07:37:42 -0400
Received: by mail-pf1-f193.google.com with SMTP id 8so4767611pfr.4
        for <git@vger.kernel.org>; Sat, 06 Apr 2019 04:37:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1353qhiBFkvg4CjMPjTgaQAM7MfVk9j47bxGFKrEJdQ=;
        b=Peq1eYnpBSK+Gu+mxkjAx5UwG8pzJcwfD2aq0K7+2yDo1GpcGtgoYKvT+QkOGaL6dK
         JWAhA/RmWd7405PQJdrCK6a3tANiGalMqnW7xyVEERDgvIU1Li5efJ47fWnRzIFsRUSE
         iKL7XYaM7qYz5EiOggqKij4j04cedC2MGu9Lcr2MjSvc1gKFhwMN6uEqX8xzHfL6nYlx
         kRJG+ZMfAZgymq+qnxT10Yx8fkigbdVqD/yPke9QYGyQ1j38/TgbZa1W6UzdSSBa1Xmx
         cL2QAkHiOHiaojjXvixwtEe8agPgAvAG/F4oHGa60CRgE0sw1DMT8yHqg/tVBvavXfUZ
         0MfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1353qhiBFkvg4CjMPjTgaQAM7MfVk9j47bxGFKrEJdQ=;
        b=KyQS8o7e8vawWiPXmwMKTkZ0vNWlhzdrODELhyfl6NxKL6Xylo/UZxuRnv8lTH+WRV
         ioyT+jfkkDrBjJkaZ1VWuU7JfwepzckPiYvS5lhPQFhA59reZ4teFSjDmKdo8OWJkDGK
         ++icyhBIAAiciUiR7hwindTAKQN7WKAfH0ZmvUdzhCt9WPMyOSH91ULoeePQL4yymZqz
         l1x9WJ22YJoG78Qyx/umd1+hG12JkgmJ4/FQNcm/at5dhuS+ks01L6ssfdnDpnXAu/Ug
         jILogWMUXY7mnOprdpFP/h4mbIl9uKmKsKumWibDP/3E5DRuXp3bdEszqVzJIVVdDJbX
         Vr8w==
X-Gm-Message-State: APjAAAW2pyH4o481suqxX9tdW+vR0b5bdTLOWXERQITlg60ukQ+0zeAg
        Vnao99/wAb8xrb25aK3BQiA=
X-Google-Smtp-Source: APXvYqw4N/VkuN0Uq7Ki96RQpk4mQ0ntPTCzjSxZs828d/aImiIPrnyjWxF/80WWMDitZDmfroQaTA==
X-Received: by 2002:a63:465b:: with SMTP id v27mr17722260pgk.165.1554550661964;
        Sat, 06 Apr 2019 04:37:41 -0700 (PDT)
Received: from ash ([116.102.217.71])
        by smtp.gmail.com with ESMTPSA id w18sm39504247pfg.75.2019.04.06.04.37.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 06 Apr 2019 04:37:41 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Sat, 06 Apr 2019 18:37:36 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, stefanbeller@gmail.com,
        szeder.dev@gmail.com,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v3 27/33] sha1-name.c: remove the_repo from resolve_relative_path()
Date:   Sat,  6 Apr 2019 18:34:47 +0700
Message-Id: <20190406113453.5149-28-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.479.g47ac719cd3
In-Reply-To: <20190406113453.5149-1-pclouds@gmail.com>
References: <20190403113457.20399-1-pclouds@gmail.com>
 <20190406113453.5149-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"remove" is not entirely correct. But at least the function is aware
that if the given repo is not the_repository, then $CWD and
is_inside_work_tree() means nothing.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 sha1-name.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sha1-name.c b/sha1-name.c
index 6caf3f4e3a..6b53ea2eeb 100644
--- a/sha1-name.c
+++ b/sha1-name.c
@@ -1719,12 +1719,12 @@ static void diagnose_invalid_index_path(struct repository *r,
 }
 
 
-static char *resolve_relative_path(const char *rel)
+static char *resolve_relative_path(struct repository *r, const char *rel)
 {
 	if (!starts_with(rel, "./") && !starts_with(rel, "../"))
 		return NULL;
 
-	if (!is_inside_work_tree())
+	if (r != the_repository || !is_inside_work_tree())
 		die("relative path syntax can't be used outside working tree.");
 
 	/* die() inside prefix_path() if resolved path is outside worktree */
@@ -1785,7 +1785,7 @@ static enum get_oid_result get_oid_with_context_1(struct repository *repo,
 			stage = name[1] - '0';
 			cp = name + 3;
 		}
-		new_path = resolve_relative_path(cp);
+		new_path = resolve_relative_path(repo, cp);
 		if (!new_path) {
 			namelen = namelen - (cp - name);
 		} else {
@@ -1839,7 +1839,7 @@ static enum get_oid_result get_oid_with_context_1(struct repository *repo,
 			const char *filename = cp+1;
 			char *new_filename = NULL;
 
-			new_filename = resolve_relative_path(filename);
+			new_filename = resolve_relative_path(repo, filename);
 			if (new_filename)
 				filename = new_filename;
 			if (flags & GET_OID_FOLLOW_SYMLINKS) {
-- 
2.21.0.479.g47ac719cd3

