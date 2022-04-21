Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3FABC433EF
	for <git@archiver.kernel.org>; Thu, 21 Apr 2022 15:34:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1390133AbiDUPg5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Apr 2022 11:36:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349454AbiDUPgy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Apr 2022 11:36:54 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F7222ED4D
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 08:34:04 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id w4so7198635wrg.12
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 08:34:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IhMGDPAKhoaaNHA5FpXStrnjZFZ5rm5/2QyhN1Dj3Ng=;
        b=eNHnL4lAV8kFeMeJjcpd2Z3EQT48B6fcDSaITeqHD2SB15bsgq1xAqafK9rsMaBdl4
         sHT3MKJz9YRy6CUpFlmzu3sfGhWB3BxNNxdEA5tHnYqkwDNkSpGcPMXAPvvONkjf6/fQ
         dkryW08Yviy5EjSN6j8+xpsOA8EySBf/mYonelQditntElXbc5Mhxc0NPLNdZcQTeyDM
         IiIjT945l3Nm4Vd0Lb0wMthtZvd+5/exMP03HjJ5ZH5vUOgrhHEhyIOGyOmQti2bmEq9
         YR1bmRb8B/ojWgdVtp2wDe1780Q9q44VCATHrmw/HHkJN8aeBMy1DOXz8TDgOCkbtsoa
         TImA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IhMGDPAKhoaaNHA5FpXStrnjZFZ5rm5/2QyhN1Dj3Ng=;
        b=8RVLq+6/jWzG1ECj+FovIX+eZ/ddHQJosVM6eJZKivwzB9lEKSDuPgGsMW5rSzeeWU
         UFdHcuDfSvJp++S0todSjqELcnakmGZXWHB0MVpe4fbQnobrv0CQktWYwEMoPHdwNN9K
         tbTegRQCOf3OjffWiN5ITrMgb49EBlQl4mot7tpYLIx1IW+b81EJRlBwSwtgWOrQqWoZ
         EMpgiQJd3dtPBmC3P5ljS1TIHjdydNnAqPHAx3zc4zGUTFZl9ZUlYQU2oSSgS6CWozc0
         LovH34J4aP5ijHor9fdAyXSWWCAzLnOlhXcGOJuBV7AHTATVmtHoR9qjLkLDF5IL61k0
         Wb4g==
X-Gm-Message-State: AOAM530pG9Z2PKNNE1yNl9g+Ppjlf8l8ld85rKac3rMovunIS++hOxdr
        s4OvpIbgP9zoFLyEzD7F+ueC4Mi3RhEyBg==
X-Google-Smtp-Source: ABdhPJxoFfVwgLPEgPD82in8S5svYO9Rt2UMY0ZsGUEeNd9XvJr49KYihInAFUS1jfV8ecDfo8QJ4A==
X-Received: by 2002:a5d:518a:0:b0:20a:c249:5ef5 with SMTP id k10-20020a5d518a000000b0020ac2495ef5mr253626wrv.368.1650555242874;
        Thu, 21 Apr 2022 08:34:02 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l126-20020a1c2584000000b00387d4f35651sm2370516wml.10.2022.04.21.08.34.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 08:34:02 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Gregory David <gregory.david@p1sec.com>,
        ptm-dev <ptm-dev@p1sec.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 1/2] show-branch: refactor in preparation for next commit
Date:   Thu, 21 Apr 2022 17:33:47 +0200
Message-Id: <patch-v3-1.2-879930b7a66-20220421T152704Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.0.876.g7efc8a7728c
In-Reply-To: <cover-v3-0.2-00000000000-20220421T152704Z-avarab@gmail.com>
References: <225b410d-2d98-8c0b-c289-22f753c175d4@p1sec.com> <cover-v3-0.2-00000000000-20220421T152704Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Move the code in cmd_show_branch() that formats a reflog message for
us into a function, and change the "flags" variable that we never
change into a "const", in addition to moving it up a scope in
preparation for the subsequent commit.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/show-branch.c | 34 +++++++++++++++++++++-------------
 1 file changed, 21 insertions(+), 13 deletions(-)

diff --git a/builtin/show-branch.c b/builtin/show-branch.c
index 330b0553b9d..499ef76a508 100644
--- a/builtin/show-branch.c
+++ b/builtin/show-branch.c
@@ -618,6 +618,24 @@ static int parse_reflog_param(const struct option *opt, const char *arg,
 	return 0;
 }
 
+static char *fmt_reflog(char *const logmsg, const timestamp_t ts, const int tz,
+			const char *fmt)
+{
+	char *const end = strchr(logmsg, '\n');
+	const char *msg;
+	char *ret;
+
+	if (end)
+		*end = '\0';
+
+	msg = *logmsg ? logmsg : "(none)";
+
+	ret = xstrfmt(fmt, show_date(ts, tz, DATE_MODE(RELATIVE)), msg);
+	free(logmsg);
+
+	return ret;
+}
+
 int cmd_show_branch(int ac, const char **av, const char *prefix)
 {
 	struct commit *rev[MAX_REVS], *commit;
@@ -640,6 +658,7 @@ int cmd_show_branch(int ac, const char **av, const char *prefix)
 	int topics = 0;
 	int dense = 1;
 	const char *reflog_base = NULL;
+	const unsigned int flags = 0;
 	struct option builtin_show_branch_options[] = {
 		OPT_BOOL('a', "all", &all_heads,
 			 N_("show remote-tracking and local branches")),
@@ -720,7 +739,6 @@ int cmd_show_branch(int ac, const char **av, const char *prefix)
 		struct object_id oid;
 		char *ref;
 		int base = 0;
-		unsigned int flags = 0;
 
 		if (ac == 0) {
 			static const char *fake_av[2];
@@ -761,8 +779,6 @@ int cmd_show_branch(int ac, const char **av, const char *prefix)
 		for (i = 0; i < reflog; i++) {
 			char *logmsg;
 			char *nth_desc;
-			const char *msg;
-			char *end;
 			timestamp_t timestamp;
 			int tz;
 
@@ -773,16 +789,8 @@ int cmd_show_branch(int ac, const char **av, const char *prefix)
 				break;
 			}
 
-			end = strchr(logmsg, '\n');
-			if (end)
-				*end = '\0';
-
-			msg = (*logmsg == '\0') ? "(none)" : logmsg;
-			reflog_msg[i] = xstrfmt("(%s) %s",
-						show_date(timestamp, tz,
-							  DATE_MODE(RELATIVE)),
-						msg);
-			free(logmsg);
+			reflog_msg[i] = fmt_reflog(logmsg, timestamp, tz,
+						   "(%s) %s");
 
 			nth_desc = xstrfmt("%s@{%d}", *av, base+i);
 			append_ref(nth_desc, &oid, 1);
-- 
2.36.0.876.g7efc8a7728c

