Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B69F11F597
	for <e@80x24.org>; Fri,  3 Aug 2018 00:34:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731600AbeHCC2M (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Aug 2018 22:28:12 -0400
Received: from mail-qt0-f201.google.com ([209.85.216.201]:54671 "EHLO
        mail-qt0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727053AbeHCC2M (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Aug 2018 22:28:12 -0400
Received: by mail-qt0-f201.google.com with SMTP id d1-v6so3001167qth.21
        for <git@vger.kernel.org>; Thu, 02 Aug 2018 17:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=Sfxio9JAipbjOLULrwUnRr7CQr9xzvsrz6OaQ89iTYg=;
        b=NP+aGmY9KsznQMx1jphUOAaqygzN2gZPz+FShee1TNM8QITyyavyWc3cLVwNpK9A+w
         WDdUiDh+7F/ZM5r3IxEoU5NoB/2ayOnLqppDzUxgDTZE0J11cbXdztTULUFSIzN4qvB5
         qXDPnjuO+CV0TmbLmwNsfdwTG5chhFgp+HAHHt57OggwPk8lnbnde9zUupexSONM7VM+
         /iDJ9GbSsxVb/xmW3acdXh5EDUbUGxKZJJyUDiJrhtroRKS608ZZRJVVoszp1PV23tBf
         Ynchci6vkXBM0RqvF61YnmFEJK/cGpiR+c0ERAVM6hfxqayLkpuQsJfWBbFAxynQxo7Z
         7kgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=Sfxio9JAipbjOLULrwUnRr7CQr9xzvsrz6OaQ89iTYg=;
        b=puevegaAyQiSx3Sm2J+FiQNsBywLngOBSRluJQHILrUXHR3hT9JmmbrD4J3mlU+sus
         Nj2KPNgMnQq9q+tJVs8g6FdVMsP0cGMr9lApdoTkeICX5HlNLMWi6cjj0gVs04SQ9VhF
         KgKHdif6ASEprHdEfrXrHSmXIB3XJWYmOMUTOxvHwjzylvcRJoRdmbFl7l05egatWmx0
         mvD5xW5pPeWLdqeKn1k6sm+hMCdty+EheJJrOyNcWRBN0mIkTZIUzwEBjn/E0moOCVC5
         fzwWbhF1qQJlaF/oQd+UmV4ryAnA0mVW4lzWukHb1PsoY5jhgGMxWng9S/CopgcvwtiL
         FASg==
X-Gm-Message-State: AOUpUlFDaD3oImnh5D02XTA7NMTZlZL2qPKCSLkH4KfV+HQha5RIszpT
        ilYPxB3XCXx6vdq690SvAlElyKtnwt7M
X-Google-Smtp-Source: AAOMgpf02gVWB6ftsIpvEBAAPdrxg6HnKcUnRLjl4LHeiFdi2w1XS4YyJShej/69XSWWlBQNAi0eTJBcNn7z
MIME-Version: 1.0
X-Received: by 2002:aed:3553:: with SMTP id b19-v6mr2709428qte.31.1533256473168;
 Thu, 02 Aug 2018 17:34:33 -0700 (PDT)
Date:   Thu,  2 Aug 2018 17:34:16 -0700
In-Reply-To: <20180803003417.76153-1-sbeller@google.com>
Message-Id: <20180803003417.76153-3-sbeller@google.com>
References: <20180801193413.146994-1-sbeller@google.com> <20180803003417.76153-1-sbeller@google.com>
X-Mailer: git-send-email 2.18.0.132.g195c49a2227
Subject: [PATCH 2/3] config: fix case sensitive subsection names on writing
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     bmwill@google.com, git@vger.kernel.org, gitster@pobox.com,
        johannes.schindelin@gmx.de, peff@peff.net
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A user reported a submodule issue regarding a section mix-up,
but it could be boiled down to the following test case:

  $ git init test  && cd test
  $ git config foo."Bar".key test
  $ git config foo."bar".key test
  $ tail -n 3 .git/config
  [foo "Bar"]
        key = test
        key = test

Sub sections are case sensitive and we have a test for correctly reading
them. However we do not have a test for writing out config correctly with
case sensitive subsection names, which is why this went unnoticed in
6ae996f2acf (git_config_set: make use of the config parser's event
stream, 2018-04-09)

Unfortunately we have to make a distinction between old style configuration
that looks like

  [foo.Bar]
        key = test

and the new quoted style as seen above. The old style is documented as
case-agnostic, hence we need to keep 'strncasecmp'; although the
resulting setting for the old style config differs from the configuration.
That will be fixed in a follow up patch.

Reported-by: JP Sugarbroad <jpsugar@google.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 config.c          | 12 +++++++++++-
 t/t1300-config.sh |  1 +
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/config.c b/config.c
index 66645047eb3..ffc2ffeafeb 100644
--- a/config.c
+++ b/config.c
@@ -37,6 +37,7 @@ struct config_source {
 	int eof;
 	struct strbuf value;
 	struct strbuf var;
+	unsigned section_name_old_dot_style : 1;
 
 	int (*do_fgetc)(struct config_source *c);
 	int (*do_ungetc)(int c, struct config_source *conf);
@@ -605,6 +606,7 @@ static int get_value(config_fn_t fn, void *data, struct strbuf *name)
 
 static int get_extended_base_var(struct strbuf *name, int c)
 {
+	cf->section_name_old_dot_style = 0;
 	do {
 		if (c == '\n')
 			goto error_incomplete_line;
@@ -641,6 +643,7 @@ static int get_extended_base_var(struct strbuf *name, int c)
 
 static int get_base_var(struct strbuf *name)
 {
+	cf->section_name_old_dot_style = 1;
 	for (;;) {
 		int c = get_next_char();
 		if (cf->eof)
@@ -2364,14 +2367,21 @@ static int store_aux_event(enum config_event_t type,
 	store->parsed[store->parsed_nr].type = type;
 
 	if (type == CONFIG_EVENT_SECTION) {
+		int (*cmpfn)(const char *, const char *, size_t);
+
 		if (cf->var.len < 2 || cf->var.buf[cf->var.len - 1] != '.')
 			return error("invalid section name '%s'", cf->var.buf);
 
+		if (cf->section_name_old_dot_style)
+			cmpfn = strncasecmp;
+		else
+			cmpfn = strncmp;
+
 		/* Is this the section we were looking for? */
 		store->is_keys_section =
 			store->parsed[store->parsed_nr].is_keys_section =
 			cf->var.len - 1 == store->baselen &&
-			!strncasecmp(cf->var.buf, store->key, store->baselen);
+			!cmpfn(cf->var.buf, store->key, store->baselen);
 		if (store->is_keys_section) {
 			store->section_seen = 1;
 			ALLOC_GROW(store->seen, store->seen_nr + 1,
diff --git a/t/t1300-config.sh b/t/t1300-config.sh
index e87cfc1804f..4976e2fcd3f 100755
--- a/t/t1300-config.sh
+++ b/t/t1300-config.sh
@@ -1290,6 +1290,7 @@ test_expect_success 'setting different case sensitive subsections ' '
 		Qc = v2
 		[d "e"]
 		f = v1
+		[d "E"]
 		Qf = v2
 	EOF
 	# exact match
-- 
2.18.0.132.g195c49a2227

