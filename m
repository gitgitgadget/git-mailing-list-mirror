Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73CCAC433F5
	for <git@archiver.kernel.org>; Tue, 11 Oct 2022 00:34:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229903AbiJKAer (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Oct 2022 20:34:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbiJKAef (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Oct 2022 20:34:35 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 894438276C
        for <git@vger.kernel.org>; Mon, 10 Oct 2022 17:34:18 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id q11so6422214ilj.10
        for <git@vger.kernel.org>; Mon, 10 Oct 2022 17:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dH4RXaQleMV4vqAcnl0TrkuOgGtF9qxGWMubhk/2cLQ=;
        b=udEjzCPAaipXMq9+VWZ9WxyiY9nDAxdVKNPP1K0yxf21Wd1m35E+Gx2c2Dxy/yE1q8
         kYLzZbh6aXvugNfIzJtDgsFY3PFIVuoANQmM5Jon34ui4rAL1nriPqTiIyFpTyuBOUfl
         jNlroOPjcI5tY6y6e54vR5MQ2CFef8aGcupQXrL9KoxX+LY9qoo5csIh84XGCyYJDn2d
         57TrSFXk9XfW4tQ4/LG+QuTSIId5ctYPeyLYdNzSYy+7B3eurcTni4mk2kZIqfMPVdSC
         5WTLVTJyc7Nj7xKXhD9PP2jL0q9Drs1W2/8FR7GonM6znJd5Grw5VvIeb3fe1XE3ZB0s
         GYig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dH4RXaQleMV4vqAcnl0TrkuOgGtF9qxGWMubhk/2cLQ=;
        b=lj/BFjpiilY3cw42zldNntB3IIoQK5FX2DmXdgBsLiqJgPVqy8dPrURZhLa12co0g+
         q3t0kFJjDLcsRzLl8FRWyJeaclfGUBXxGk1gjGLTK26sgEdhMbj2fB8wH8ygsLONGiiE
         QotHVI07p/RigrD1MMoad2y7ibfSVaSQFcRhyqlyBt9UyupsBN1M9f98Q7g9XgjcyEQh
         BJyALnuxzeum4U7FKDQH6pDweM4IHPHKcXnVvleJYlJ/HttkK/JM1NVSX1Nsms5ys5SQ
         YrEHFwHitfs78n6MmLKjYCfM6VwDNlS3pslKRtfm5oQBB1J8FvhA0Gy0sBOwLfGyMYL3
         ifSw==
X-Gm-Message-State: ACrzQf349kBjdpPrb7SeiwfnWLwaDRsmcGoOFoDIWxjo5uEjxFCNBJo6
        gt1lnhbXSEJN2EyBxA5waVcwFWLKlQKqTjan
X-Google-Smtp-Source: AMsMyM4puycx+sJMO7XP3DTAf2iMWestYKrKFKwDXzRiXK3PZxGOeQouamqBw9fYWhfi1BY2Ny6osQ==
X-Received: by 2002:a05:6e02:15c9:b0:2da:c33e:49c7 with SMTP id q9-20020a056e0215c900b002dac33e49c7mr10420762ilu.26.1665448456457;
        Mon, 10 Oct 2022 17:34:16 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id r14-20020a02aa0e000000b0036357c6a65bsm4562833jam.118.2022.10.10.17.34.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Oct 2022 17:34:15 -0700 (PDT)
Date:   Mon, 10 Oct 2022 20:34:15 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     jacob@initialcommit.io, peff@peff.net, gitster@pobox.com
Subject: [PATCH 5/7] shortlog: implement `--group=author` in terms of
 `--group=<format>`
Message-ID: <55a6ef7bc0082818fa51a0915c43002ede5c449f.1665448437.git.me@ttaylorr.com>
References: <cover.1665448437.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1665448437.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Instead of handling SHORTLOG_GROUP_AUTHOR separately, reimplement it as
a special case of the new `--group=<format>` mode, where the author mode
is a shorthand for `--group='%aN <%aE>'.

Note that we still need to keep the SHORTLOG_GROUP_AUTHOR enum since it
has a different meaning in `read_from_stdin()`, where it is still used
for a different purpose.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/log.c      |  1 +
 builtin/shortlog.c | 23 ++++++++++++-----------
 shortlog.h         |  1 +
 3 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index ee19dc5d45..6b77e520b5 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1334,6 +1334,7 @@ static void make_cover_letter(struct rev_info *rev, int use_separate_file,
 	log.in2 = 4;
 	log.file = rev->diffopt.file;
 	log.groups = SHORTLOG_GROUP_AUTHOR;
+	shortlog_init_group(&log);
 	for (i = 0; i < nr; i++)
 		shortlog_add_commit(&log, list[i]);
 
diff --git a/builtin/shortlog.c b/builtin/shortlog.c
index f708d96558..aac8c7afa4 100644
--- a/builtin/shortlog.c
+++ b/builtin/shortlog.c
@@ -245,15 +245,6 @@ void shortlog_add_commit(struct shortlog *log, struct commit *commit)
 	}
 	oneline_str = oneline.len ? oneline.buf : "<none>";
 
-	if (log->groups & SHORTLOG_GROUP_AUTHOR) {
-		strbuf_reset(&ident);
-		format_commit_message(commit,
-				      log->email ? "%aN <%aE>" : "%aN",
-				      &ident, &ctx);
-		if (!HAS_MULTI_BITS(log->groups) ||
-		    strset_add(&dups, ident.buf))
-			insert_one_record(log, ident.buf, oneline_str);
-	}
 	if (log->groups & SHORTLOG_GROUP_COMMITTER) {
 		strbuf_reset(&ident);
 		format_commit_message(commit,
@@ -372,6 +363,16 @@ void shortlog_init(struct shortlog *log)
 	log->format.strdup_strings = 1;
 }
 
+void shortlog_init_group(struct shortlog *log)
+{
+	if (!log->groups)
+		log->groups = SHORTLOG_GROUP_AUTHOR;
+
+	if (log->groups & SHORTLOG_GROUP_AUTHOR)
+		string_list_append(&log->format,
+				   log->email ? "%aN <%aE>" : "%aN");
+}
+
 int cmd_shortlog(int argc, const char **argv, const char *prefix)
 {
 	struct shortlog log = { STRING_LIST_INIT_NODUP };
@@ -439,8 +440,8 @@ int cmd_shortlog(int argc, const char **argv, const char *prefix)
 	log.file = rev.diffopt.file;
 	log.date_mode = rev.date_mode;
 
-	if (!log.groups)
-		log.groups = SHORTLOG_GROUP_AUTHOR;
+	shortlog_init_group(&log);
+
 	string_list_sort(&log.trailers);
 
 	/* assume HEAD if from a tty */
diff --git a/shortlog.h b/shortlog.h
index 4850a8c30f..e52f001fb7 100644
--- a/shortlog.h
+++ b/shortlog.h
@@ -33,6 +33,7 @@ struct shortlog {
 };
 
 void shortlog_init(struct shortlog *log);
+void shortlog_init_group(struct shortlog *log);
 
 void shortlog_add_commit(struct shortlog *log, struct commit *commit);
 
-- 
2.37.0.1.g1379af2e9d

