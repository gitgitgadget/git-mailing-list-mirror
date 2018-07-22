Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9305E208E9
	for <e@80x24.org>; Sun, 22 Jul 2018 09:58:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728414AbeGVKyJ (ORCPT <rfc822;e@80x24.org>);
        Sun, 22 Jul 2018 06:54:09 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:41861 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728082AbeGVKyI (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Jul 2018 06:54:08 -0400
Received: by mail-io0-f193.google.com with SMTP id q9-v6so13247169ioj.8
        for <git@vger.kernel.org>; Sun, 22 Jul 2018 02:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cOIRlFJmYDE0+P4+QSgBRMb0NVck3Ja0Lly0M82TyMY=;
        b=c/3uDaGx+7sFoFWmDWG5+0BAnb0gHYdiGtoRNkXu+BCALiqsTcNkOFHji8dPDEiAvO
         oJa5DeM6pHJCDGRcwqS12NwrXMWPVWOGnQ0L7Y9wj/9R7izgBbyZmyAqU9ErqS5s+kxC
         xaqQMYLPsHu5pXMZZkJY6qtafj+CrR0oBkKya0WxS/etgXzaKgGJ3PqDaubbjju6DhzO
         IogNRxdDe6iCh8oqjNqQYP5T1jWsBeYjUYFyVG1cJ060JxfJChcQNjJZ1GtWNY3c2Wpt
         TqPJ1wV/Iog0gh1abW8020plqBD4MGLZr7ariQmznqy6iGkfp1Ua0dWROd5wtg2dns2I
         hGEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=cOIRlFJmYDE0+P4+QSgBRMb0NVck3Ja0Lly0M82TyMY=;
        b=hrw5yk/bWYAr7qXQGrkoqf1FoWimUFLSvxIZIGniA0ZnJBX236RbE+oirhx6+azeRp
         oL3MLeSzEyQV755kKgYzbQMVpNd4c8azkWnL7EuThqo53HEtwulRCUB+FPixoBJAueQK
         2UrGlyGBTr2zg9zP4cx4pk3MPXzyI2X0gjGU6Ss4SPAiaK3UrnFb2MlRBpQFbuc4tDNF
         vD/7bfW9qhIyCdEkHdBSsBY0mpAbUwViIczlyhi5YUm/h4ilD+9H5l9qKGJ+/oXrr4L/
         IfA0BvEA7BWzTRpRcGRnZBQqMfJMjJKsfkwhgisL8FJpJlwrI8/kzSv4Fv7ETpVScr1G
         h2lw==
X-Gm-Message-State: AOUpUlGhxPep79QhUttuMU4gi1j0SOOqhT7nou0wd9EQYFef46r5MA7H
        aoRBXtIDiCWwhtKQGYHhEgxuf/1p
X-Google-Smtp-Source: AAOMgpfzJB4aGVNrsmeyYIcKby4/JM0WgR9Xe9knK2zGF9o6610SObe7whdEmTMu5jbcA3Ske36oQg==
X-Received: by 2002:a6b:e519:: with SMTP id y25-v6mr6586191ioc.285.1532253479105;
        Sun, 22 Jul 2018 02:57:59 -0700 (PDT)
Received: from localhost.localdomain (user-12l2cs3.cable.mindspring.com. [69.81.51.131])
        by smtp.gmail.com with ESMTPSA id w13-v6sm3681298itb.29.2018.07.22.02.57.58
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Sun, 22 Jul 2018 02:57:58 -0700 (PDT)
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Duy Nguyen <pclouds@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Stefan Beller <sbeller@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 03/14] format-patch: teach --interdiff to respect -v/--reroll-count
Date:   Sun, 22 Jul 2018 05:57:06 -0400
Message-Id: <20180722095717.17912-4-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.18.0.345.g5c9ce644c3
In-Reply-To: <20180722095717.17912-1-sunshine@sunshineco.com>
References: <20180722095717.17912-1-sunshine@sunshineco.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The --interdiff option introduces the embedded interdiff generically as
"Interdiff:", however, we can do better when --reroll-count is specified
by emitting "Interdiff against v{n}:" instead.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 builtin/log.c           | 17 ++++++++++++++++-
 revision.h              |  1 +
 t/t4014-format-patch.sh |  5 +++++
 3 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/builtin/log.c b/builtin/log.c
index 1020b78477..99ddfe8bb0 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1085,7 +1085,7 @@ static void make_cover_letter(struct rev_info *rev, int use_stdout,
 		show_diffstat(rev, origin, head);
 
 	if (rev->idiff_oid1) {
-		fprintf_ln(rev->diffopt.file, "%s", _("Interdiff:"));
+		fprintf_ln(rev->diffopt.file, "%s", rev->idiff_title);
 		show_interdiff(rev);
 	}
 }
@@ -1427,6 +1427,16 @@ static void print_bases(struct base_tree_info *bases, FILE *file)
 	oidclr(&bases->base_commit);
 }
 
+static const char *diff_title(struct strbuf *sb, int reroll_count,
+		       const char *generic, const char *rerolled)
+{
+	if (reroll_count <= 0)
+		strbuf_addstr(sb, generic);
+	else /* RFC may be v0, so allow -v1 to diff against v0 */
+		strbuf_addf(sb, rerolled, reroll_count - 1);
+	return sb->buf;
+}
+
 int cmd_format_patch(int argc, const char **argv, const char *prefix)
 {
 	struct commit *commit;
@@ -1455,6 +1465,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	int show_progress = 0;
 	struct progress *progress = NULL;
 	struct oid_array idiff_prev = OID_ARRAY_INIT;
+	struct strbuf idiff_title = STRBUF_INIT;
 
 	const struct option builtin_format_patch_options[] = {
 		{ OPTION_CALLBACK, 'n', "numbered", &numbered, NULL,
@@ -1758,6 +1769,9 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 			die(_("--interdiff requires --cover-letter"));
 		rev.idiff_oid1 = &idiff_prev.oid[idiff_prev.nr - 1];
 		rev.idiff_oid2 = get_commit_tree_oid(list[0]);
+		rev.idiff_title = diff_title(&idiff_title, reroll_count,
+					     _("Interdiff:"),
+					     _("Interdiff against v%d:"));
 	}
 
 	if (!signature) {
@@ -1880,6 +1894,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 
 done:
 	oid_array_clear(&idiff_prev);
+	strbuf_release(&idiff_title);
 	return 0;
 }
 
diff --git a/revision.h b/revision.h
index 61931fbac5..ffeadc261a 100644
--- a/revision.h
+++ b/revision.h
@@ -215,6 +215,7 @@ struct rev_info {
 	/* interdiff */
 	const struct object_id *idiff_oid1;
 	const struct object_id *idiff_oid2;
+	const char *idiff_title;
 
 	/* commit counts */
 	int count_left;
diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index 57b46322aa..5950890d30 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -1734,4 +1734,9 @@ test_expect_success 'interdiff: cover-letter' '
 	test_cmp expect actual
 '
 
+test_expect_success 'interdiff: reroll-count' '
+	git format-patch --cover-letter --interdiff=boop~2 -v2 -1 boop &&
+	test_i18ngrep "^Interdiff ..* v1:$" v2-0000-cover-letter.patch
+'
+
 test_done
-- 
2.18.0.345.g5c9ce644c3

