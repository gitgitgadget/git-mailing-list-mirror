Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FC0EC433E1
	for <git@archiver.kernel.org>; Thu, 25 Mar 2021 10:24:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01DBE61A27
	for <git@archiver.kernel.org>; Thu, 25 Mar 2021 10:24:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230147AbhCYKXm (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Mar 2021 06:23:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230156AbhCYKXZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Mar 2021 06:23:25 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76A8BC06174A
        for <git@vger.kernel.org>; Thu, 25 Mar 2021 03:23:24 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id c8so1682200wrq.11
        for <git@vger.kernel.org>; Thu, 25 Mar 2021 03:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7Ql/rxzkmkcs8FV1o735Sm62HWeS6s3XmCyGFw2GbTI=;
        b=qrSDYRXW4fIChJ5eS4gWOezbnqTdkpk7xzT6/vfvYDOdSYU6ugsFD6m3GPxcutHaYM
         5nngg77K17IhBqwpw6OewLcrlXW/nWqjE2ByHj/vGAPDG8lllvjHLB85ucpjrKBh13Ya
         s5/lFGBs6f9SJXuD1M4ec2Sy/tJj/r0+kaadeelwDRKURIFeVrWsVc9dH7yG56tqOR2m
         jp3Iu2RunZmis7quQUDkjuwnb6q2js8mnR9pxMjAqMmxiJsCEQ1U6w8jwBcU8FdA7XUX
         AjI1al2rBBuw//dBEYaHUD5ikQ5XTghu/AS2mLrG67DWUzpgHUg7Dt9pmWdQ7Ke78DK5
         aI2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7Ql/rxzkmkcs8FV1o735Sm62HWeS6s3XmCyGFw2GbTI=;
        b=B7QAqqep3ObTwJ9aNsrDrLqwwogjhCOHoEhDaLdOYndV3IlaaVldN0F4DS4taALL6r
         /VURm+b+45pO8hPs/FILSjqI2FcM2fSullCh4H6Iy0mwbEv0by3EsKIs/mtbw0CPWQdO
         z1zbcjTNRPvDqsUUzS78sXhvw6AcqIcdJbVpzugG0/K9kdKLuZV6awIzs4okU+JFh9dN
         +yL/sufJ0Ym/1t6xozI/9rAFBgHnNr/eSe1DkRbb73ssVv6sizpKIEyj3hiZ5sN9zZFj
         KrxYahuVMu7KcQ1VKwnpSm4vjlK0DEwY9IPcpPeEGLEHaRxpNyRckyogWWxVZO06i3HQ
         iHPA==
X-Gm-Message-State: AOAM531brK7aOtwueB2hX8eqNeTYeUCYF1rKXxBijbqytC1edS7L14jM
        /orb0jToJRhIkmZOCashGvwVfQLbr8eKElXwN60=
X-Google-Smtp-Source: ABdhPJw4KsG8Rn87+KCV3t0Q1UdJNARvKhyXQ7K8XGQyruw+ZWmqyq0jNWgUsh88fu7FZ8oSv03hpg==
X-Received: by 2002:a5d:404d:: with SMTP id w13mr8106209wrp.230.1616667802806;
        Thu, 25 Mar 2021 03:23:22 -0700 (PDT)
Received: from localhost.localdomain ([2a02:85f:2a0a:9300:501f:ca6d:3b18:1e72])
        by smtp.googlemail.com with ESMTPSA id k13sm7633376wri.27.2021.03.25.03.23.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Mar 2021 03:23:22 -0700 (PDT)
From:   =?UTF-8?q?=CE=A3=CF=84=CE=B1=CF=8D=CF=81=CE=BF=CF=82=20=CE=9D=CF=84=CE=AD=CE=BD=CF=84=CE=BF=CF=82?= 
        <stdedos@gmail.com>
To:     git <git@vger.kernel.org>
Cc:     =?UTF-8?q?=CE=A3=CF=84=CE=B1=CF=8D=CF=81=CE=BF=CF=82=20=CE=9D=CF=84=CE=AD=CE=BD=CF=84=CE=BF=CF=82?= 
        <stdedos@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        Stavros Ntentos <133706+stdedos@users.noreply.github.com>
Subject: [PATCH v1 1/1] pathspec: warn for a no-glob entry that contains `**`
Date:   Thu, 25 Mar 2021 12:22:28 +0200
Message-Id: <20210325102228.14901-2-stdedos@gmail.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210325102228.14901-1-stdedos@gmail.com>
References: <xmqqft1iquka.fsf@gitster.g>
 <20210325102228.14901-1-stdedos@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Stavros Ntentos <133706+stdedos@users.noreply.github.com>

If a pathspec is given that contains `**`, chances are that someone is
naively expecting that it will do what the manual has told him that `**`
will match (i.e. 0-or-more directories).

However, without an explicit `:(glob)` magic, that will fall out the sky:
the two `**` will merge into one star, which surrounded by slashes, will
match any directory name.

These changes attempt to bring awareness to this issue.

Signed-off-by: Stavros Ntentos <133706+stdedos@users.noreply.github.com>
---
 pathspec.c                 | 13 +++++++++++++
 pathspec.h                 |  1 +
 t/t6130-pathspec-noglob.sh | 13 +++++++++++++
 3 files changed, 27 insertions(+)

diff --git a/pathspec.c b/pathspec.c
index 7a229d8d22..9b5066d9d9 100644
--- a/pathspec.c
+++ b/pathspec.c
@@ -1,3 +1,4 @@
+#include <string.h>
 #include "cache.h"
 #include "config.h"
 #include "dir.h"
@@ -588,6 +589,8 @@ void parse_pathspec(struct pathspec *pathspec,
 
 		init_pathspec_item(item + i, flags, prefix, prefixlen, entry);
 
+		check_missing_glob(entry, item[i].magic);
+
 		if (item[i].magic & PATHSPEC_EXCLUDE)
 			nr_exclude++;
 		if (item[i].magic & magic_mask)
@@ -739,3 +742,13 @@ int match_pathspec_attrs(const struct index_state *istate,
 
 	return 1;
 }
+
+void check_missing_glob(const char *entry, int flags) {
+	if (flags & (PATHSPEC_GLOB | PATHSPEC_LITERAL)) {
+		return;
+	}
+
+	if (strstr(entry, "**")) {
+		warning(_("Pathspec provided contains `**`, but no :(glob) magic.\n\tIt will not match 0 or more directories!"));
+	}
+}
diff --git a/pathspec.h b/pathspec.h
index 454ce364fa..913518ebd3 100644
--- a/pathspec.h
+++ b/pathspec.h
@@ -157,5 +157,6 @@ char *find_pathspecs_matching_against_index(const struct pathspec *pathspec,
 int match_pathspec_attrs(const struct index_state *istate,
 			 const char *name, int namelen,
 			 const struct pathspec_item *item);
+void check_missing_glob(const char* pathspec_entry, int flags);
 
 #endif /* PATHSPEC_H */
diff --git a/t/t6130-pathspec-noglob.sh b/t/t6130-pathspec-noglob.sh
index ba7902c9cd..1cd5efef5a 100755
--- a/t/t6130-pathspec-noglob.sh
+++ b/t/t6130-pathspec-noglob.sh
@@ -157,4 +157,17 @@ test_expect_success '**/ does not work with :(literal) and --glob-pathspecs' '
 	test_must_be_empty actual
 '
 
+cat > expected <<"EOF"
+warning: Pathspec provided contains `**`, but no glob magic.
+EOF
+test_expect_success '** without :(glob) warns of lacking glob magic' '
+	test_might_fail git stash -- "**/bar" 2>warns &&
+	grep -Ff expected warns
+'
+
+test_expect_success '** with    :(literal) does not warn of lacking glob magic' '
+	test_might_fail git stash -- ":(literal)**/bar" 2>warns &&
+	! grep -Ff expected warns
+'
+
 test_done
-- 
2.31.0

