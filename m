Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 350501F576
	for <e@80x24.org>; Wed, 24 Jan 2018 09:39:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932825AbeAXJje (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Jan 2018 04:39:34 -0500
Received: from mail-pf0-f195.google.com ([209.85.192.195]:43648 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932877AbeAXJjQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Jan 2018 04:39:16 -0500
Received: by mail-pf0-f195.google.com with SMTP id y26so2608594pfi.10
        for <git@vger.kernel.org>; Wed, 24 Jan 2018 01:39:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JdHJS82TQhrQko5YQ/Ppz1bZkAynl2b7vdFWvBo8aW0=;
        b=hPG12XcWP3zOPs3vtecmaiN2D6fswujr7Rrs5tgJrxwFamLYEc4qASgxOHsNOvdmjA
         j/a0Ec9+5zOaz6ntkDY6TuUeC4cPbJsfqsBGdZrHm3lu+cD4B6OgRofID76kR+V5wxj4
         xXxnr/RO4wPVK5i+PDg4zqBsLK9xPa5IXF9CQo1seACNrMtMZu1igyfS3VE0GTmXMe6M
         NbUNnngCd3fLWKpi/gI6GKeiUkWHxW1jiNy+T2IHqhE2Aqrqmet+skCsSp622obnBAKi
         MLMEp5Yk6sY9w3qgSh3UMwLvFRBrkQSFN7govFVL2oiTE+ysIQN5Wp3kIrmEE6fFpaOl
         /rnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JdHJS82TQhrQko5YQ/Ppz1bZkAynl2b7vdFWvBo8aW0=;
        b=MTQh5s6vpBfG2IC/MOQ/L+zZvays2ftsy9Yq1HCqpFZVulYWmzfr9MOmSKuOKRwdAr
         60b+bNddPAQedz5wPB8u6c4IEUQkjsKmdtgUZbul1Twd4YVO3mEcrNjhW53H6Mxy+FKg
         oDAOm0pljiQqu18yGV2T2TDkadU2mqHyYTzT8v2JbL5rmYJbWCFC360p2zMgltv3iBu/
         1eEhNSJUEXRbIpZQygs/ObXysl1ur6M9kSyaCQvy9yvc579gzKX2O8PefN2dcKNM4itK
         ZkQnjuO6zeYqfgwjHhdFN909c8LXpBBOuceCw9l56l41xQprxKl2xxW4ZjCGQwDhbXzM
         E5pA==
X-Gm-Message-State: AKwxytfTyf0+UHcl20WXbSEpHTURTUTYAObyNMh41h4Ymy1pJz0dRyiV
        kQ5YRLydIeUoEyRT308Exo/w9w==
X-Google-Smtp-Source: AH8x224vSRnLZMskgwaQmtegOpYZnXX56ZigMBxSU89KyP+0vOGvxiZhK8LvzDqvP/4wwCdV0fW0Lg==
X-Received: by 10.99.163.2 with SMTP id s2mr10567837pge.264.1516786755946;
        Wed, 24 Jan 2018 01:39:15 -0800 (PST)
Received: from ash ([171.233.110.59])
        by smtp.gmail.com with ESMTPSA id x22sm10331692pfa.169.2018.01.24.01.39.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Jan 2018 01:39:15 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Wed, 24 Jan 2018 16:39:10 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 3/3] read-cache: don't write index twice if we can't write shared index
Date:   Wed, 24 Jan 2018 16:38:29 +0700
Message-Id: <20180124093829.12966-4-pclouds@gmail.com>
X-Mailer: git-send-email 2.16.0.47.g3d9b0fac3a
In-Reply-To: <20180124093829.12966-1-pclouds@gmail.com>
References: <xmqqfu6xjxrx.fsf@gitster.mtv.corp.google.com>
 <20180124093829.12966-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In a0a967568e ("update-index --split-index: do not split if $GIT_DIR is
read only", 2014-06-13), we tried to make sure we can still write an
index, even if the shared index can not be written.

We did so by just calling 'do_write_locked_index()' just before
'write_shared_index()'.  'do_write_locked_index()' always at least
closes the tempfile nowadays, and used to close or commit the lockfile
if COMMIT_LOCK or CLOSE_LOCK were given at the time this feature was
introduced.  COMMIT_LOCK or CLOSE_LOCK is passed in by most callers of
'write_locked_index()'.

After calling 'write_shared_index()', we call 'write_split_index()',
which calls 'do_write_locked_index()' again, which then tries to use the
closed lockfile again, but in fact fails to do so as it's already
closed. This eventually leads to a segfault.

Make sure to write the main index only once.

[nd: most of the commit message and investigation done by Thomas, I only
tweaked the solution a bit]

Helped-by: Thomas Gummerer <t.gummerer@gmail.com>
Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 read-cache.c           |  5 +++--
 t/t1700-split-index.sh | 19 +++++++++++++++++++
 2 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index c568643f55..c58c0a978a 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -2561,8 +2561,9 @@ int write_locked_index(struct index_state *istate, struct lock_file *lock,
 		if (!temp) {
 			hashclr(si->base_sha1);
 			ret = do_write_locked_index(istate, lock, flags);
-		} else
-			ret = write_shared_index(istate, &temp);
+			goto out;
+		}
+		ret = write_shared_index(istate, &temp);
 
 		saved_errno = errno;
 		if (is_tempfile_active(temp))
diff --git a/t/t1700-split-index.sh b/t/t1700-split-index.sh
index af9b847761..cbcefa6e5f 100755
--- a/t/t1700-split-index.sh
+++ b/t/t1700-split-index.sh
@@ -401,4 +401,23 @@ done <<\EOF
 0642 -rw-r---w-
 EOF
 
+test_expect_success POSIXPERM,SANITY 'graceful handling when splitting index is not allowed' '
+	test_create_repo ro &&
+	(
+		cd ro &&
+		test_commit initial &&
+		git update-index --split-index &&
+		test -f .git/sharedindex.*
+	) &&
+	cp ro/.git/index new-index &&
+	test_when_finished "chmod u+w ro/.git" &&
+	chmod u-w ro/.git &&
+	GIT_INDEX_FILE="$(pwd)/new-index" git -C ro update-index --split-index &&
+	chmod u+w ro/.git &&
+	rm ro/.git/sharedindex.* &&
+	GIT_INDEX_FILE=new-index git ls-files >actual &&
+	echo initial.t >expected &&
+	test_cmp expected actual
+'
+
 test_done
-- 
2.16.0.47.g3d9b0fac3a

