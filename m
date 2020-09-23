Return-Path: <SRS0=8LOk=DA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8144C4727E
	for <git@archiver.kernel.org>; Wed, 23 Sep 2020 17:09:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 84EC020BED
	for <git@archiver.kernel.org>; Wed, 23 Sep 2020 17:09:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YS+DzXr4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726671AbgIWRJc (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Sep 2020 13:09:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726184AbgIWRJc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Sep 2020 13:09:32 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB8CCC0613CE
        for <git@vger.kernel.org>; Wed, 23 Sep 2020 10:09:31 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id x23so779927wmi.3
        for <git@vger.kernel.org>; Wed, 23 Sep 2020 10:09:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TrEK+9nPwg4Lxv+xCL9wMwmi1B7FodZ9i4VqhpuQhTM=;
        b=YS+DzXr46SG198JzD82KHpfiEhBUsPkxWLWPMDylj0nv3+kGaFC/8PRnBktF2GEw/S
         /gJnPlfjdk6cMzhRIq3/7SGHDblkFf9wPhaPYExSDyXtvLKg2msS69XpTEPCKSMUwlnx
         h2sR8VHgCXRUQrPPcsRkPo3f57x5xsWSDeYgzn3KkB7KRSmYeJjLR4UCPDosakTooqIG
         Nj+hKYnX2MDEmteiL1f/2+c351kuWVvN9fcAyMU2uK4GMBaTMD+FqOs+gIsZxSG5/uiI
         dgEIVTT6zHYqSqlUyrR6Hp/ogSc4Wa4sJvLsVfFwDdROWz0rLNNJjYM7aztBLW4mW6Vf
         G18A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TrEK+9nPwg4Lxv+xCL9wMwmi1B7FodZ9i4VqhpuQhTM=;
        b=YBZGkr7vilZKTF/E6y+IYsx7DVGc2bNCZn7pcIKF6mOuoXOuBVX+6mOaPSMFHGuNSH
         S9ty8Qr+FVvJlAh+MQalQqhldhXHdk65M8Nkcvmv8NFP3ib2UwatBRLMIKZClsE/aWzT
         27U9yv+IKtqBnlMvaCHQ4osCl5OHVbOPzIVlvG862PFmZ4N5419mTCD1I0BGUAlBTpWV
         l5NXCYcbsA1lKsdebRzTsAVdpQwPtmcdVhFT0cO1Y2liYXAFWNkinfn4roEY/RAMf8OH
         YcD5tGRqvAe26f/gHh/sRlJVuhBKSE8xwNQU1QaWjHxhgpY89vJ/VQDzuoHn48/nVQsf
         8O4Q==
X-Gm-Message-State: AOAM5335lMldOymCMEHQ2KXzAZvwwrk+khmer7mzyKQJIwoo9RvnXXAP
        kwhCAzpGS2Mm5/amLz8NyARP0I1bGNEdkA==
X-Google-Smtp-Source: ABdhPJz0gTFEqVqNUfI9JAY53Iiu5Mj02Vq5bqlNwetAzGLPKOwmAO1qXZz73cgsYYci3/GYJCVXmg==
X-Received: by 2002:a1c:a184:: with SMTP id k126mr535983wme.39.1600880970182;
        Wed, 23 Sep 2020 10:09:30 -0700 (PDT)
Received: from localhost.localdomain ([193.56.245.86])
        by smtp.gmail.com with ESMTPSA id 88sm382220wrl.76.2020.09.23.10.09.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2020 10:09:29 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Miriam Rubio <mirucam@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] bisect: don't use invalid oid as rev when starting
Date:   Wed, 23 Sep 2020 19:09:15 +0200
Message-Id: <20200923170915.21748-1-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.28.0.587.g1c7fdf1d8b
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
treated as a path restriction (which is wrong).

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
This is a bug fix for the bug Miriam talks about in:

https://lore.kernel.org/git/20200923072740.20772-1-mirucam@gmail.com/

and:

https://lore.kernel.org/git/CAN7CjDDVp_i7dhpbAq5zrGW69nE6+SfivJQ-dembmu+WyqKiQQ@mail.gmail.com/

 builtin/bisect--helper.c    | 14 +++++++++-----
 t/t6030-bisect-porcelain.sh |  7 +++++++
 2 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 7dcc1b5188..538fa6f16b 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -486,12 +486,16 @@ static int bisect_start(struct bisect_terms *terms, const char **argv, int argc)
 			return error(_("unrecognized option: '%s'"), arg);
 		} else {
 			char *commit_id = xstrfmt("%s^{commit}", arg);
-			if (get_oid(commit_id, &oid) && has_double_dash)
-				die(_("'%s' does not appear to be a valid "
-				      "revision"), arg);
-
-			string_list_append(&revs, oid_to_hex(&oid));
+			int res = get_oid(commit_id, &oid);
 			free(commit_id);
+			if (res) {
+				if (has_double_dash)
+					die(_("'%s' does not appear to be a valid "
+					      "revision"), arg);
+				break;
+			} else {
+				string_list_append(&revs, oid_to_hex(&oid));
+			}
 		}
 	}
 	pathspec_pos = i;
diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
index b886529e59..cb645cf8c8 100755
--- a/t/t6030-bisect-porcelain.sh
+++ b/t/t6030-bisect-porcelain.sh
@@ -82,6 +82,13 @@ test_expect_success 'bisect fails if given any junk instead of revs' '
 	git bisect bad $HASH4
 '
 
+test_expect_success 'bisect start without -- uses unknown stuff as path restriction' '
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
2.28.0.587.g1c7fdf1d8b

