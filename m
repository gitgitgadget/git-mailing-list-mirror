Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBD07C43331
	for <git@archiver.kernel.org>; Thu, 18 Mar 2021 11:16:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8FC1264F53
	for <git@archiver.kernel.org>; Thu, 18 Mar 2021 11:16:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231127AbhCRLQN (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Mar 2021 07:16:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230356AbhCRLQB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Mar 2021 07:16:01 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8F4DC06174A
        for <git@vger.kernel.org>; Thu, 18 Mar 2021 04:16:00 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id j4-20020a05600c4104b029010c62bc1e20so3097799wmi.3
        for <git@vger.kernel.org>; Thu, 18 Mar 2021 04:16:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=KN4ecWaqquKWjWAirQsW6yyX1fnoJ6YKi60bd1aVzuQ=;
        b=BA1ck9RblcHgLJKPT+BTwieuHgAjs6OM2YOL7eANNnZspLlLteS7k7ar5mIFxRUHWO
         F6XJdVWFqqi96ZY2K8pfPFiDd7/zIEyYjceQTChaWkRrjLl3kKaSUKHg+mqw6AUMWxRn
         mZBNEQMQ4k3CNMlpkZiRDaXXkASUUZhzCTSyhS+B5Rb6m/V7/RvXroH7QPF0+fQXpD1F
         LbeUnMqqlSJ9PdvPMfiJUvAfsIH0xNZdMkRYTqqlz1wtjTFocYCCsYE0cI1Tp86Y023W
         f/CgAvv46/H6AS+T+K4NPkmPCy9KweQ39e4+Ql/Y9dn9o6bWsEnBic6CTBiRYNDeEtVf
         NnVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=KN4ecWaqquKWjWAirQsW6yyX1fnoJ6YKi60bd1aVzuQ=;
        b=Z9D+Ienc2oGY3OkvjRtTi6RCDoFQFbjSlG9GvTFFJRaWMzg9hY1j1QT8ImJJR20rru
         mtzF0grNLB1JH6ENH8vyXEMXYp4FrlRl0kqDCN1VwyTTT4Cg+z7sDwFfG2rwy3dJwcQw
         DjxsVHs1dtOrkq3Grnu10KmQ1sbWkPp8/P4oCVrBEbzJdZJytqCTJ9ZbajGuw1GSb21P
         CStmpKz/xols3AsRQAa28vS3xBFojgypSmU+Ne/bFOXba3bLQSmxp7gTQUV3Q5UAsP1Q
         2qu3wVo4u7SljzysmpE84OVwOJbtuIkrG5U79SBGJXd4E2mYj6Zl9ZS5BbfE8Q/HHmiC
         7wlQ==
X-Gm-Message-State: AOAM532KHaa+DfbL0zj2VmFVoIOdwUtIk2BMDxOpd16P3MdVntEcRk29
        qoV0ugroKTOIH5CQ7RdTuGMv5ni1C9U=
X-Google-Smtp-Source: ABdhPJy2ov26grBxcLYXQy30LKz/5CgabuOdkBsTNUDBevqKQ9d8aU53v2pCfnueUGEnxwajFNJz2w==
X-Received: by 2002:a1c:c906:: with SMTP id f6mr3082601wmb.128.1616066159539;
        Thu, 18 Mar 2021 04:15:59 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p18sm2457497wrs.68.2021.03.18.04.15.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Mar 2021 04:15:59 -0700 (PDT)
Message-Id: <42590e95deeece6ba65e0432c3a59746e717fee3.1616066156.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.901.v10.git.1616066156.gitgitgadget@gmail.com>
References: <pull.901.v9.git.1615891183320.gitgitgadget@gmail.com>
        <pull.901.v10.git.1616066156.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 18 Mar 2021 11:15:55 +0000
Subject: [PATCH v10 2/3] interpret-trailers: add own-identity option
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     "Bradley M. Kuhn" <bkuhn@sfconservancy.org>,
        Junio C Hamano <gitster@pobox.com>,
        Brandon Casey <drafnel@gmail.com>,
        Shourya Shukla <periperidip@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Rafael Silva <rafaeloliveira.cs@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: ZheNing Hu <adlternative@gmail.com>

Beacuse `git commit --trailer="Signed-off-by: \
$(git config user.name) <$(git config user.email)>"`
is difficult for users to add their own identities,
so teach interpret-trailers a new option `--own-identity`
which allow those trailers with no value add the user’s own
identity. This will help the use of `commit --trailer` as
easy as `--signoff`.

Signed-off-by: ZheNing Hu <adlternative@gmail.com>
---
 Documentation/git-interpret-trailers.txt | 14 ++++++++++++++
 builtin/interpret-trailers.c             |  6 ++++--
 t/t7513-interpret-trailers.sh            | 12 ++++++++++++
 trailer.c                                | 18 ++++++++++++++++--
 trailer.h                                |  3 ++-
 5 files changed, 48 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-interpret-trailers.txt b/Documentation/git-interpret-trailers.txt
index 96ec6499f001..ace44446c3e3 100644
--- a/Documentation/git-interpret-trailers.txt
+++ b/Documentation/git-interpret-trailers.txt
@@ -84,6 +84,19 @@ OPTIONS
 	trailer to the input messages. See the description of this
 	command.
 
+--own-identity::
+	Used with `--trailer`. Those trailers without value with the
+	`--own-identity` option all will add the user's own identity.
+	For example,` git interpret-trailers --trailer "A:B" --trailer \
+	"Signed-off-by" --trailer "Helped-by" --own-identity --inplace a.txt`
+	will output:
+	"
+	A:B
+	Signed-off-by: C O Mitter <committer@example.com>
+	Helped-by: C O Mitter <committer@example.com>
+	"
+	in `a.txt`.
+
 --where <placement>::
 --no-where::
 	Specify where all new trailers will be added.  A setting
@@ -131,6 +144,7 @@ OPTIONS
 	when you know your input contains just the commit message itself
 	(and not an email or the output of `git format-patch`).
 
+
 CONFIGURATION VARIABLES
 -----------------------
 
diff --git a/builtin/interpret-trailers.c b/builtin/interpret-trailers.c
index 84748eafc01b..be7f502a58d7 100644
--- a/builtin/interpret-trailers.c
+++ b/builtin/interpret-trailers.c
@@ -47,6 +47,7 @@ static void new_trailers_clear(struct list_head *trailers)
 	list_for_each_safe(pos, tmp, trailers) {
 		item = list_entry(pos, struct new_trailer_item, list);
 		list_del(pos);
+		free(item->text);
 		free(item);
 	}
 }
@@ -66,7 +67,7 @@ static int option_parse_trailer(const struct option *opt,
 		return -1;
 
 	item = xmalloc(sizeof(*item));
-	item->text = arg;
+	item->text = xstrdup(arg);
 	item->where = where;
 	item->if_exists = if_exists;
 	item->if_missing = if_missing;
@@ -94,7 +95,8 @@ int cmd_interpret_trailers(int argc, const char **argv, const char *prefix)
 	struct option options[] = {
 		OPT_BOOL(0, "in-place", &opts.in_place, N_("edit files in place")),
 		OPT_BOOL(0, "trim-empty", &opts.trim_empty, N_("trim empty trailers")),
-
+		OPT_BOOL(0, "own-identity", &opts.own_identity,
+			     N_("specify the user's own identity for omitted trailers value")),
 		OPT_CALLBACK(0, "where", NULL, N_("action"),
 			     N_("where to place the new trailer"), option_parse_where),
 		OPT_CALLBACK(0, "if-exists", NULL, N_("action"),
diff --git a/t/t7513-interpret-trailers.sh b/t/t7513-interpret-trailers.sh
index 6602790b5f4c..f82cee93bfb2 100755
--- a/t/t7513-interpret-trailers.sh
+++ b/t/t7513-interpret-trailers.sh
@@ -63,6 +63,18 @@ test_expect_success 'without config' '
 	test_cmp expected actual
 '
 
+test_expect_success 'without config with --own-identity' '
+	cat >expected <<-\EOF &&
+
+	Acked-by: A B <C>
+	Helped-by: C O Mitter <committer@example.com>
+	Signed-off-by: C O Mitter <committer@example.com>
+	EOF
+	git interpret-trailers --trailer "Acked-by: A B <C>" --trailer "Helped-by" \
+	--trailer "Signed-off-by" --own-identity empty >actual &&
+	test_cmp expected actual
+'
+
 test_expect_success 'without config in another order' '
 	sed -e "s/ Z\$/ /" >expected <<-\EOF &&
 
diff --git a/trailer.c b/trailer.c
index 249ed618ed8e..cd4f85e71c9a 100644
--- a/trailer.c
+++ b/trailer.c
@@ -690,8 +690,18 @@ static void add_arg_item(struct list_head *arg_head, char *tok, char *val,
 	list_add_tail(&new_item->list, arg_head);
 }
 
+static void add_user_own_identity(struct new_trailer_item *item)
+{
+	struct strbuf buf = STRBUF_INIT;
+	strbuf_addstr(&buf, item->text);
+	strbuf_add(&buf, "=", 1);
+	strbuf_addstr(&buf, fmt_name(WANT_COMMITTER_IDENT));
+	free(item->text);
+	item->text = buf.buf;
+}
+
 static void process_command_line_args(struct list_head *arg_head,
-				      struct list_head *new_trailer_head)
+				      struct list_head *new_trailer_head, int own_identity)
 {
 	struct arg_item *item;
 	struct strbuf tok = STRBUF_INIT;
@@ -728,6 +738,10 @@ static void process_command_line_args(struct list_head *arg_head,
 			error(_("empty trailer token in trailer '%.*s'"),
 			      (int) sb.len, sb.buf);
 			strbuf_release(&sb);
+		} else if (separator_pos == -1 && own_identity) {
+				add_user_own_identity(tr);
+				pos = pos->prev;
+				continue;
 		} else {
 			parse_trailer(&tok, &val, &conf, tr->text,
 				      separator_pos);
@@ -1048,7 +1062,7 @@ void process_trailers(const char *file,
 
 	if (!opts->only_input) {
 		LIST_HEAD(arg_head);
-		process_command_line_args(&arg_head, new_trailer_head);
+		process_command_line_args(&arg_head, new_trailer_head ,opts->own_identity);
 		process_trailers_lists(&head, &arg_head);
 	}
 
diff --git a/trailer.h b/trailer.h
index 795d2fccfd95..235dfdfa1978 100644
--- a/trailer.h
+++ b/trailer.h
@@ -57,7 +57,7 @@ struct trailer_info {
 struct new_trailer_item {
 	struct list_head list;
 
-	const char *text;
+	char *text;
 
 	enum trailer_where where;
 	enum trailer_if_exists if_exists;
@@ -73,6 +73,7 @@ struct process_trailer_options {
 	int no_divider;
 	int key_only;
 	int value_only;
+	int own_identity;
 	const struct strbuf *separator;
 	const struct strbuf *key_value_separator;
 	int (*filter)(const struct strbuf *, void *);
-- 
gitgitgadget

