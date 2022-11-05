Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B9A3C433FE
	for <git@archiver.kernel.org>; Sat,  5 Nov 2022 17:09:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229995AbiKERJD (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 5 Nov 2022 13:09:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230084AbiKERIh (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Nov 2022 13:08:37 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DDF1E0CC
        for <git@vger.kernel.org>; Sat,  5 Nov 2022 10:08:31 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id b21so7553903plc.9
        for <git@vger.kernel.org>; Sat, 05 Nov 2022 10:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/4SSqEtqlK1Fuz7wIYIxL89UjWGi22og4g/OSC1SzYc=;
        b=fr03NqbexZUT4/loFp7F+PZ3sTV1oOkF7eR/l8pLcB5fEXbHbtoUjDbg/wBRrPfckd
         aZEHYFQpcyauBUypvJGnylgYG2jxc79jgNJ1Wz5p+AAPL1YBKwPecCf4TnueKdMrtNkb
         FEPSrs0zkVk8vAjooproPb8vIqCpnPJhwrt921y9zx5tDTq2eycSYvNlZiam+ncRsiuC
         GmhSN9WGSd98MRUEOIEh4msNCrVl24SQNtEph7eAFziyruhLaoh4v1DqWnfG/vQPMuG6
         PozmvHz5wYCf+6tha4zR2Es9WbBfNPk0aQwGR91+b+rkavMBFJclrEK4MWMLmjOy/hcJ
         Bg+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/4SSqEtqlK1Fuz7wIYIxL89UjWGi22og4g/OSC1SzYc=;
        b=dggHPgAjhcbd9zqQ8JJ5Cn4/5Fi1pBZ5iQK7z2+2Cj+v3Gttqj3RpBZvcGJPRNqbW4
         hctEJ4pVt2HsS6/Xq0LXef2u3Grjj2HpuvV1u1VgHdgAfZMN/OdHitPGHRdSxNQYUuob
         SUB2CePEHtyfoFUXliehNLAVSdaElzRg17/AcVSU3gI7UeJPWmBD+uw7ZsYEzeypFxk4
         2CrVgJZEsfJYqDZPxaMavYhi9gwgwS0pK9GbRAys1u3GauXU5ylQO5ZAw13bpFOmb/5a
         FOcIMHjMGHP4plomAFTyp5Fr0YMW6F00Zco7+5tD6j86hI4tfOTFAXjCqCtDKAMW4l9t
         y4iw==
X-Gm-Message-State: ACrzQf18aqZRsQ0fpHwr1cDTWhjhXDFsGTB7D74J4ZUWUkIiDcUmStz3
        XuLhcVwaUgCUWXHI/vzBpIU0LtVFNF0=
X-Google-Smtp-Source: AMsMyM77umXmLisjR7yoAX98ILgiWk3iiBuEx9crpgux+51UPgxgLRGXWocu+7Hk5k7GFy/j4tbODA==
X-Received: by 2002:a17:90b:f06:b0:212:cb07:fb82 with SMTP id br6-20020a17090b0f0600b00212cb07fb82mr58092335pjb.221.1667668110304;
        Sat, 05 Nov 2022 10:08:30 -0700 (PDT)
Received: from localhost.localdomain ([2001:ee0:500b:6370:da47:cda5:dbd5:6e77])
        by smtp.gmail.com with ESMTPSA id c16-20020a056a00009000b0056299fd2ba2sm1513192pfj.162.2022.11.05.10.08.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Nov 2022 10:08:29 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
Subject: [PATCH 13/13] Turn `git bisect` into a full built-in
Date:   Sun,  6 Nov 2022 00:07:44 +0700
Message-Id: <0441cf255473ea3d2ca8bb2fc46874ec207bbcee.1667667460.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.38.1.157.gedabe22e0a
In-Reply-To: <cover.1667667460.git.congdanhqx@gmail.com>
References: <cover.1667667058.git.congdanhqx@gmail.com> <cover.1667667460.git.congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Now that the shell script hands off to the `bisect--helper` to do
_anything_ (except to show the help), it is but a tiny step to let the
helper implement the actual `git bisect` command instead.

This retires `git-bisect.sh`, concluding a multi-year journey that many
hands helped with, in particular Pranit Bauna, Tanushree Tumane and
Miriam Rubio.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
---
 Makefile                               | 3 +--
 builtin.h                              | 2 +-
 builtin/{bisect--helper.c => bisect.c} | 2 +-
 git.c                                  | 2 +-
 4 files changed, 4 insertions(+), 5 deletions(-)
 rename builtin/{bisect--helper.c => bisect.c} (99%)

diff --git a/Makefile b/Makefile
index 4927379184..78785c6b84 100644
--- a/Makefile
+++ b/Makefile
@@ -627,7 +627,6 @@ THIRD_PARTY_SOURCES =
 # interactive shell sessions without exporting it.
 unexport CDPATH
 
-SCRIPT_SH += git-bisect.sh
 SCRIPT_SH += git-difftool--helper.sh
 SCRIPT_SH += git-filter-branch.sh
 SCRIPT_SH += git-merge-octopus.sh
@@ -1137,7 +1136,7 @@ BUILTIN_OBJS += builtin/am.o
 BUILTIN_OBJS += builtin/annotate.o
 BUILTIN_OBJS += builtin/apply.o
 BUILTIN_OBJS += builtin/archive.o
-BUILTIN_OBJS += builtin/bisect--helper.o
+BUILTIN_OBJS += builtin/bisect.o
 BUILTIN_OBJS += builtin/blame.o
 BUILTIN_OBJS += builtin/branch.o
 BUILTIN_OBJS += builtin/bugreport.o
diff --git a/builtin.h b/builtin.h
index 8901a34d6b..aa955466b4 100644
--- a/builtin.h
+++ b/builtin.h
@@ -116,7 +116,7 @@ int cmd_am(int argc, const char **argv, const char *prefix);
 int cmd_annotate(int argc, const char **argv, const char *prefix);
 int cmd_apply(int argc, const char **argv, const char *prefix);
 int cmd_archive(int argc, const char **argv, const char *prefix);
-int cmd_bisect__helper(int argc, const char **argv, const char *prefix);
+int cmd_bisect(int argc, const char **argv, const char *prefix);
 int cmd_blame(int argc, const char **argv, const char *prefix);
 int cmd_branch(int argc, const char **argv, const char *prefix);
 int cmd_bugreport(int argc, const char **argv, const char *prefix);
diff --git a/builtin/bisect--helper.c b/builtin/bisect.c
similarity index 99%
rename from builtin/bisect--helper.c
rename to builtin/bisect.c
index e61ce6556c..fc13f683a1 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect.c
@@ -1403,7 +1403,7 @@ static int cmd_bisect__run(int argc, const char **argv, const char *prefix UNUSE
 	return res;
 }
 
-int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
+int cmd_bisect(int argc, const char **argv, const char *prefix)
 {
 	int res = 0;
 	parse_opt_subcommand_fn *fn = NULL;
diff --git a/git.c b/git.c
index 6662548986..a2deb15e46 100644
--- a/git.c
+++ b/git.c
@@ -492,7 +492,7 @@ static struct cmd_struct commands[] = {
 	{ "annotate", cmd_annotate, RUN_SETUP },
 	{ "apply", cmd_apply, RUN_SETUP_GENTLY },
 	{ "archive", cmd_archive, RUN_SETUP_GENTLY },
-	{ "bisect--helper", cmd_bisect__helper, RUN_SETUP },
+	{ "bisect", cmd_bisect, RUN_SETUP },
 	{ "blame", cmd_blame, RUN_SETUP },
 	{ "branch", cmd_branch, RUN_SETUP | DELAY_PAGER_CONFIG },
 	{ "bugreport", cmd_bugreport, RUN_SETUP_GENTLY },
-- 
2.38.1.157.gedabe22e0a

