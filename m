Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 56BF21F597
	for <e@80x24.org>; Wed,  1 Aug 2018 19:34:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387454AbeHAVVm (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Aug 2018 17:21:42 -0400
Received: from mail-io0-f202.google.com ([209.85.223.202]:55813 "EHLO
        mail-io0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387396AbeHAVVl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Aug 2018 17:21:41 -0400
Received: by mail-io0-f202.google.com with SMTP id u23-v6so14422936iol.22
        for <git@vger.kernel.org>; Wed, 01 Aug 2018 12:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=yQvubwI8hEsVifhPin+5WeZOAsio6dH2XFmQ9V3Vaq0=;
        b=pxrE2QX40nEfahfeqQrEOOHHS2pUvC8AizP0o1zZbCg8wRxa8lNLVumX7lbQ6G185J
         lkvcO3UcZMmbG8yBRSGqYypgQUd7/2rkhMlQKdc6cWjuwDexw4XUyUW8LjVRWwjTlB2H
         OZOEQ0YytIlvlUyNiCfSML5Xxbg3MPXlSUuVuWP/x3va6ZPzrjzFWS2zTftbVv/eBMQD
         1/m47HeGp2yZxdraqYKZz72iRjKyVYEj/zu8ITF1f2qrrCiB3v5CKEKVLqm0FNcl/cSa
         DIx0p4MYySxMd8pSD8hCLIcfjMvmvfLAexfnVZCslnH0A38PKEZNEWD5mhhFcBybnDpJ
         Kv0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=yQvubwI8hEsVifhPin+5WeZOAsio6dH2XFmQ9V3Vaq0=;
        b=JUPX7G2wJugXZ6AjoP2USEZNNrutNxVfP7qhLYkaSReYMBnCjpJxW+KtKzWG2koBtS
         yAFE4PQTLlevfN+emnpbaFVGw5iZYd0CDHd+7eKpi3wbs9CDPkcgPJd3kRbWB/QMKH23
         wqstnQH4ObqRHR/30M5dzpjkGE6vfY5Al6nRlgJFktQIgsY1haRt4mUrgEKi8eSaBA9g
         +SkRamyb6Kr/m9HmKuJRBy3krBIJmn1Dy1HlOxBbsTo1KPLRRyiNmYkU6G5snNgy8oge
         kWUdEKpig/tImCaL8I+6qFAT6PcDQ+ZqoiP6PhhJY3O2+7q+QEIrX3ZxgGTy2euYW0F+
         fTbQ==
X-Gm-Message-State: AOUpUlHey0aCQB061v35+yLzGVRAp2vQL3WHcr4837bQ+MnI0Aa3XJT0
        5u+UxngFvpvl7IbHnUyNyzTN02AxeWJx
X-Google-Smtp-Source: AAOMgpejo0yhSlNmC7NEOJ/1KaD7h2eWwohB7zpIJxGvuVEcHPIz6wRw2OCzJ5eIG/o2rq8oFDc3t+hLMdK+
MIME-Version: 1.0
X-Received: by 2002:a24:ed87:: with SMTP id r129-v6mr121078ith.32.1533152063122;
 Wed, 01 Aug 2018 12:34:23 -0700 (PDT)
Date:   Wed,  1 Aug 2018 12:34:12 -0700
In-Reply-To: <20180801193413.146994-1-sbeller@google.com>
Message-Id: <20180801193413.146994-3-sbeller@google.com>
References: <xmqq7elbe8po.fsf@gitster-ct.c.googlers.com> <20180801193413.146994-1-sbeller@google.com>
X-Mailer: git-send-email 2.18.0.132.g195c49a2227
Subject: [PATCH 2/3] config: fix case sensitive subsection names on writing
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     bmwill@google.com, git@vger.kernel.org, johannes.schindelin@gmx.de,
        peff@google.com, sbeller@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A use reported a submodule issue regarding strange case indentation
issues, but it could be boiled down to the following test case:

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
index 7968ef7566a..1d3bf9b5fc0 100644
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
@@ -2355,14 +2358,21 @@ static int store_aux_event(enum config_event_t type,
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
index ced13012409..a93f966f128 100755
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

