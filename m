Return-Path: <SRS0=EnZj=DB=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F149CC2D0E2
	for <git@archiver.kernel.org>; Thu, 24 Sep 2020 06:04:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E1AD235FD
	for <git@archiver.kernel.org>; Thu, 24 Sep 2020 06:04:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kLF829BL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726853AbgIXGEF (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Sep 2020 02:04:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726828AbgIXGEF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Sep 2020 02:04:05 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B69CC0613CE
        for <git@vger.kernel.org>; Wed, 23 Sep 2020 23:04:05 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id c18so2359209wrm.9
        for <git@vger.kernel.org>; Wed, 23 Sep 2020 23:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LSfzgWNfdiMriB+k97V4Z+oXNIfC7g3j7dSIBu2/R0A=;
        b=kLF829BLA/rggUhB3P/8fryKznBwmS9RN/9oT4yRrLDwjDYTMBiaQzgGcvwjb1zwMG
         kyoQZL9aAEEIMCge2bHAEfJAHxlY+YR8SD9bIWP/S+6E1Lgb766wNE9R+2dzgeoul2I4
         WuO8jAuflwte6CeeeTL1DikbB3csfkNo9BLBc2TnDmDjPRgNAKHl/UytKPSUI8tRJRoZ
         J+RGZ5SqCn15FiMFMZVqhNVmcidj0BXfGt9qrUphcciNos/lFMK4+bFL1Bt1YDy2o3vV
         /5befxiqaguAGRNZBT3YwZocv5pPeOwpNCmFcabWXcwXEVexBFIMUrHGZCCrfOqrHrtn
         ciRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LSfzgWNfdiMriB+k97V4Z+oXNIfC7g3j7dSIBu2/R0A=;
        b=VuQVC6pfjgYTcXWXEqEcw0IvDeXP8wypggLJlR8KkPLkKn+GRzRbeUSLBxbqdMLYiy
         IITdfyXAiXMuDg2xaTkXc/Gbmx/qz0sDjLXvBTRc+XjpACDoMZPzg7OqqJf1s2CpPHGv
         6jv+JsbV9R4xJhIdFIAYyaDbHoYMxFNP54KWJMnKfS5QMxAzci/QUL7QdEgAJsxd8TZ/
         adWI6quNpGJTUUe0zoFa0V0DdRgsSf22X23PuOjLN1vzqfOOBi+zDY/jgSg2f2dTXC/3
         /1KFoXlEIfbaFmEo0QtZCMAhSm8zhxVCh7yoyagbcSN/uqVVO8Yp8ksgUBM6A8pxnylf
         BTIw==
X-Gm-Message-State: AOAM531VoaVI/zTgb7Iwi2084LoBgu8+fdUKnJlDERKFtlIvG0d17Ns/
        DSz7aN1ivHZg71mz8nPIbrpDFsoKDWjMSA==
X-Google-Smtp-Source: ABdhPJwwAVhZ6Q2Cz9vmUkHJqTv/LICYt0dBs0tJEovTg3bbMhmurw+YXvH+gOsTNuDw3CEEyXiFcg==
X-Received: by 2002:a5d:69c2:: with SMTP id s2mr3092633wrw.389.1600927443287;
        Wed, 23 Sep 2020 23:04:03 -0700 (PDT)
Received: from localhost.localdomain ([193.57.124.13])
        by smtp.gmail.com with ESMTPSA id h204sm2042058wmf.35.2020.09.23.23.04.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2020 23:04:02 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Miriam Rubio <mirucam@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v2] bisect: don't use invalid oid as rev when starting
Date:   Thu, 24 Sep 2020 08:03:44 +0200
Message-Id: <20200924060344.15541-1-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.28.0.586.gce332cc16b
In-Reply-To: <20200923170915.21748-1-chriscool@tuxfamily.org>
References: <20200923170915.21748-1-chriscool@tuxfamily.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In 06f5608c14 (bisect--helper: `bisect_start` shell function
partially in C, 2019-01-02), we changed the following shell
code:

-                       rev=$(git rev-parse -q --verify "$arg^{commit}") || {
-                               test $has_double_dash -eq 1 &&
-                               die "$(eval_gettext "'\$arg' does not appear to be a valid revision")"
-                               break
-                       }
-                       revs="$revs $rev"

into:

+                       char *commit_id = xstrfmt("%s^{commit}", arg);
+                       if (get_oid(commit_id, &oid) && has_double_dash)
+                               die(_("'%s' does not appear to be a valid "
+                                     "revision"), arg);
+
+                       string_list_append(&revs, oid_to_hex(&oid));
+                       free(commit_id);

In case of an invalid "arg" when "has_double_dash" is false, the old
code would "break" out of the argument loop.

In the new C code though, `oid_to_hex(&oid)` is unconditonally
appended to "revs". This is wrong first because "oid" is junk as
`get_oid(commit_id, &oid)` failed and second because it doesn't break
out of the argument loop.

Not breaking out of the argument loop means that "arg" is then not
treated as a path restriction.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
This patch is made on top of e1cfff6765 (Sixteenth batch, 2020-09-22)
and incorporates Dscho's suggestions.

Thanks to Junio and Dscho for reviewing the first version.

 builtin/bisect--helper.c    | 14 ++++++--------
 t/t6030-bisect-porcelain.sh |  7 +++++++
 2 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 7dcc1b5188..f4762e1774 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -484,15 +484,13 @@ static int bisect_start(struct bisect_terms *terms, const char **argv, int argc)
 			terms->term_bad = xstrdup(arg);
 		} else if (starts_with(arg, "--")) {
 			return error(_("unrecognized option: '%s'"), arg);
-		} else {
-			char *commit_id = xstrfmt("%s^{commit}", arg);
-			if (get_oid(commit_id, &oid) && has_double_dash)
-				die(_("'%s' does not appear to be a valid "
-				      "revision"), arg);
-
+		} else if (!get_oid_committish(arg, &oid))
 			string_list_append(&revs, oid_to_hex(&oid));
-			free(commit_id);
-		}
+		else if (has_double_dash)
+			die(_("'%s' does not appear to be a valid "
+			      "revision"), arg);
+		else
+			break;
 	}
 	pathspec_pos = i;
 
diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
index b886529e59..70c39a9459 100755
--- a/t/t6030-bisect-porcelain.sh
+++ b/t/t6030-bisect-porcelain.sh
@@ -82,6 +82,13 @@ test_expect_success 'bisect fails if given any junk instead of revs' '
 	git bisect bad $HASH4
 '
 
+test_expect_success 'bisect start without -- uses unknown arg as path restriction' '
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

