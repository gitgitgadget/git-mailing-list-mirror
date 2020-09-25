Return-Path: <SRS0=RFRG=DC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82F36C4363D
	for <git@archiver.kernel.org>; Fri, 25 Sep 2020 13:01:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 395D320756
	for <git@archiver.kernel.org>; Fri, 25 Sep 2020 13:01:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nq+V576O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728453AbgIYNBy (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Sep 2020 09:01:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727982AbgIYNBx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Sep 2020 09:01:53 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECE4FC0613CE
        for <git@vger.kernel.org>; Fri, 25 Sep 2020 06:01:52 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id t10so3560976wrv.1
        for <git@vger.kernel.org>; Fri, 25 Sep 2020 06:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bhzGX+s8U+EGW741J5+RA4y48tFoy6CvnClohlnqd98=;
        b=Nq+V576Ok5gTPNnmGon9CETqRhvyDhgvo+i4XoXuVn+vijx+RfkS/LahhTfJjKbJNY
         7YMxJVE2LRRwBQICjTeZIufcHKtR7JV6DOEmzZqgv2A2KzT2uxPAQF03yxzWtQVLj/tu
         G6VGEYEwfF8cWwYlH6QU2aKkBcujf/EfZCKJYK7OU08Rtf/S4+map43SadO74aF/cY84
         80rvXC1sjvWAYAmsMU9S/aZ4ebt4yat3uXmRU3D2WGLLmtjPwZ1ZiFN/PYNn8SzW2U8b
         1CIY6BwwdkLxxJK+THBnIxKxNrbvdmLXeKPWRm+nBh3au7v9v0/mr1bpwl6YpYAevC4d
         592g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bhzGX+s8U+EGW741J5+RA4y48tFoy6CvnClohlnqd98=;
        b=S5OLVynRymcUJnPjl0H1KfMAHPiQfvtteh1AdtoVyfAvCZ3cNAlNaPL3rBPcIGZsOF
         IrzLSFxBh44gXh/3b0ojYMJC+YfH5wff59AH2mPESs9gInUHF8modHVYxyjoR/8gADVN
         lwojuonaRyIu9fG1+yYjut25FT2StCwWcRY3IgsqIF0bBpxTvGQmr367tuHNqWviUwEs
         3qxcgBDrfymwJqef9x7EiO+ayRJ7M1ACnlD/+ayvVfqdZQfd2dXLZOlUB8BXG9+5HoF2
         9VieKb6nS0kGRpD2k1xbG4UnzNGCsGMoSjmYYRuWwaL3hS8bCI2dBQZmYNL0/2NMNvCw
         FqRA==
X-Gm-Message-State: AOAM531UkurUu1uaaNwO79y71mO+ZSS5eG1CdVTvk90xPmYQJ+ucMkOF
        pmAXbt+Q9Iw5MpN2cJa2wUan719m4XgZog==
X-Google-Smtp-Source: ABdhPJzXyFi4qpCQLVMc9muA7BWOoLs8WT0zZ+ToaFN3jSnw6EML7VTcU+dCaG0YJvMeTcJRS+Z0nA==
X-Received: by 2002:adf:a49d:: with SMTP id g29mr4698928wrb.219.1601038911242;
        Fri, 25 Sep 2020 06:01:51 -0700 (PDT)
Received: from localhost.localdomain ([185.228.230.159])
        by smtp.gmail.com with ESMTPSA id t15sm2746519wrp.20.2020.09.25.06.01.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2020 06:01:50 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Miriam Rubio <mirucam@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v3] bisect: don't use invalid oid as rev when starting
Date:   Fri, 25 Sep 2020 15:01:28 +0200
Message-Id: <20200925130128.5589-1-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.28.0.586.g1380a357b8
In-Reply-To: <20200924060344.15541-1-chriscool@tuxfamily.org>
References: <20200924060344.15541-1-chriscool@tuxfamily.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In 06f5608c14 (bisect--helper: `bisect_start` shell function
partially in C, 2019-01-02), we changed the following shell
code:

-      rev=$(git rev-parse -q --verify "$arg^{commit}") || {
-              test $has_double_dash -eq 1 &&
-              die "$(eval_gettext "'\$arg' does not appear to be a valid revision")"
-              break
-      }
-      revs="$revs $rev"

into:

+      char *commit_id = xstrfmt("%s^{commit}", arg);
+      if (get_oid(commit_id, &oid) && has_double_dash)
+              die(_("'%s' does not appear to be a valid "
+                    "revision"), arg);
+
+      string_list_append(&revs, oid_to_hex(&oid));
+      free(commit_id);

In case of an invalid "arg" when "has_double_dash" is false, the old
code would "break" out of the argument loop.

In the new C code though, `oid_to_hex(&oid)` is unconditonally
appended to "revs". This is wrong first because "oid" is junk as
`get_oid(commit_id, &oid)` failed and second because it doesn't break
out of the argument loop.

Not breaking out of the argument loop means that "arg" is then not
treated as a path restriction (which is wrong).

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
Compared to V2, this applies Junio's `SQUASH???` commit and improves
indentation in the commit message.

 builtin/bisect--helper.c    | 13 ++++++-------
 t/t6030-bisect-porcelain.sh |  7 +++++++
 2 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 7dcc1b5188..2f8ef0ea30 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -484,14 +484,13 @@ static int bisect_start(struct bisect_terms *terms, const char **argv, int argc)
 			terms->term_bad = xstrdup(arg);
 		} else if (starts_with(arg, "--")) {
 			return error(_("unrecognized option: '%s'"), arg);
-		} else {
-			char *commit_id = xstrfmt("%s^{commit}", arg);
-			if (get_oid(commit_id, &oid) && has_double_dash)
-				die(_("'%s' does not appear to be a valid "
-				      "revision"), arg);
-
+		} else if (!get_oidf(&oid, "%s^{commit}", arg)) {
 			string_list_append(&revs, oid_to_hex(&oid));
-			free(commit_id);
+		} else if (has_double_dash) {
+			die(_("'%s' does not appear to be a valid "
+			      "revision"), arg);
+		} else {
+			break;
 		}
 	}
 	pathspec_pos = i;
diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
index b886529e59..aa226381be 100755
--- a/t/t6030-bisect-porcelain.sh
+++ b/t/t6030-bisect-porcelain.sh
@@ -82,6 +82,13 @@ test_expect_success 'bisect fails if given any junk instead of revs' '
 	git bisect bad $HASH4
 '
 
+test_expect_success 'bisect start without -- takes unknown arg as pathspec' '
+	git bisect reset &&
+	git bisect start foo bar &&
+	grep foo ".git/BISECT_NAMES" &&
+	grep bar ".git/BISECT_NAMES"
+'
+
 test_expect_success 'bisect reset: back in the master branch' '
 	git bisect reset &&
 	echo "* master" > branch.expect &&
-- 
2.28.0.585.ge1cfff6765

