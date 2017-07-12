Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 93EA120357
	for <e@80x24.org>; Wed, 12 Jul 2017 22:21:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752477AbdGLWV3 (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Jul 2017 18:21:29 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33481 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751369AbdGLWV2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jul 2017 18:21:28 -0400
Received: by mail-wm0-f68.google.com with SMTP id j85so1562779wmj.0
        for <git@vger.kernel.org>; Wed, 12 Jul 2017 15:21:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=31fRZTr1EdLH2XtFA7Jr8YDLO72Tvt6ftTvGxNfPiq8=;
        b=oovD3uG6ev+cK1GE9D86p7TDU+5KrNpeJbmgHKAwGwAD/oD75se55uP8XlD7Z73WnR
         bt2L5JWVxQ9h/ydJxlU5ZeXQLMuGsxk7CbV1tXUpngxCM1FwXiEMwne5ysNH5gfLE8Bt
         v32aCKWQy24cQXp5c9k+mRfWw89tOcJhGt12ENVhdtGnTxaj+3iwTqfNCtVx3mdNzyap
         FEMkBsm5zEhUqy4nX0pGU7O/8lR7+qMC98zIHlDECy2Xt8FczGyqAZvwHsEQW+xYPWB7
         DyaAC+0ymMzstMF4i5lh/xlIuh0LZg7F/NkLnRVI+INBZZA8uc28is5MvwaquR4jsUcK
         WIWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=31fRZTr1EdLH2XtFA7Jr8YDLO72Tvt6ftTvGxNfPiq8=;
        b=VCgZyFXfkqec3L9WsecQ8AdmjuC027Dd8bIo941U/5ThH8ZEhNtTmG8tJueuEHeEI9
         zvyvtSFSGys5PwwZXAS+WzC2XYRVjUdiysIuwIBLu84IcwcXMJIXbgtr7MdfPfvTJk5s
         MH7SAklkF3vrTqiKX4e3Ic/GZSbGVgqrZ/yJh2aa+uRxoSAtO4xulgJsQB+DF6Ey/ai6
         VdMW7ibdAPOmAlOXaBstHO4t1VrhfOJmz6oIaqmeRIdmOvhlSW/JFjwABKS18s40seDP
         k9D7NrktIm4fmp65N5BfVlAthJHjU3oN1al0nm/Asu1cY6nIJ5J9xDrM0hXeEzRqYj6s
         sdiA==
X-Gm-Message-State: AIVw113++0ZCVA74KxSZUkBE01dLLM4uBBRqaW9mg3JKuCXfW1ZCejVC
        xcey2Ofeob1vks/bf1M=
X-Received: by 10.28.1.8 with SMTP id 8mr4083504wmb.88.1499898081331;
        Wed, 12 Jul 2017 15:21:21 -0700 (PDT)
Received: from donizetti.redhat.com (94-39-191-51.adsl-ull.clienti.tiscali.it. [94.39.191.51])
        by smtp.gmail.com with ESMTPSA id r200sm3444539wmd.20.2017.07.12.15.21.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Jul 2017 15:21:20 -0700 (PDT)
From:   Paolo Bonzini <bonzini@gnu.org>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v2 1/3] trailers: create struct trailer_opts
Date:   Thu, 13 Jul 2017 00:21:14 +0200
Message-Id: <20170712222116.7095-2-bonzini@gnu.org>
X-Mailer: git-send-email 2.13.0
In-Reply-To: <20170712222116.7095-1-bonzini@gnu.org>
References: <20170712222116.7095-1-bonzini@gnu.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Paolo Bonzini <pbonzini@redhat.com>

Pass the command-line arguments as a pointer to a new struct.  This
will be extended in the next patch to include more options.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
	v1->v2: constify

 builtin/interpret-trailers.c | 13 ++++++-------
 trailer.c                    | 14 ++++++++------
 trailer.h                    |  7 ++++++-
 3 files changed, 20 insertions(+), 14 deletions(-)

diff --git a/builtin/interpret-trailers.c b/builtin/interpret-trailers.c
index 175f14797..6528680b5 100644
--- a/builtin/interpret-trailers.c
+++ b/builtin/interpret-trailers.c
@@ -18,13 +18,12 @@ static const char * const git_interpret_trailers_usage[] = {
 
 int cmd_interpret_trailers(int argc, const char **argv, const char *prefix)
 {
-	int in_place = 0;
-	int trim_empty = 0;
+	struct trailer_opts opts = { 0 };
 	struct string_list trailers = STRING_LIST_INIT_NODUP;
 
 	struct option options[] = {
-		OPT_BOOL(0, "in-place", &in_place, N_("edit files in place")),
-		OPT_BOOL(0, "trim-empty", &trim_empty, N_("trim empty trailers")),
+		OPT_BOOL(0, "in-place", &opts.in_place, N_("edit files in place")),
+		OPT_BOOL(0, "trim-empty", &opts.trim_empty, N_("trim empty trailers")),
 		OPT_STRING_LIST(0, "trailer", &trailers, N_("trailer"),
 				N_("trailer(s) to add")),
 		OPT_END()
@@ -36,11 +35,11 @@ int cmd_interpret_trailers(int argc, const char **argv, const char *prefix)
 	if (argc) {
 		int i;
 		for (i = 0; i < argc; i++)
-			process_trailers(argv[i], in_place, trim_empty, &trailers);
+			process_trailers(argv[i], &opts, &trailers);
 	} else {
-		if (in_place)
+		if (opts.in_place)
 			die(_("no input file given for in-place editing"));
-		process_trailers(NULL, in_place, trim_empty, &trailers);
+		process_trailers(NULL, &opts, &trailers);
 	}
 
 	string_list_clear(&trailers, 0);
diff --git a/trailer.c b/trailer.c
index 751b56c00..a3eb42818 100644
--- a/trailer.c
+++ b/trailer.c
@@ -164,13 +164,14 @@ static void print_tok_val(FILE *outfile, const char *tok, const char *val)
 		fprintf(outfile, "%s%c %s\n", tok, separators[0], val);
 }
 
-static void print_all(FILE *outfile, struct list_head *head, int trim_empty)
+static void print_all(FILE *outfile, struct list_head *head,
+		      const struct trailer_opts *opts)
 {
 	struct list_head *pos;
 	struct trailer_item *item;
 	list_for_each(pos, head) {
 		item = list_entry(pos, struct trailer_item, list);
-		if (!trim_empty || strlen(item->value) > 0)
+		if (!opts->trim_empty || strlen(item->value) > 0)
 			print_tok_val(outfile, item->token, item->value);
 	}
 }
@@ -968,7 +969,8 @@ static FILE *create_in_place_tempfile(const char *file)
 	return outfile;
 }
 
-void process_trailers(const char *file, int in_place, int trim_empty, struct string_list *trailers)
+void process_trailers(const char *file, const struct trailer_opts *opts,
+		      struct string_list *trailers)
 {
 	LIST_HEAD(head);
 	LIST_HEAD(arg_head);
@@ -980,7 +982,7 @@ void process_trailers(const char *file, int in_place, int trim_empty, struct str
 
 	read_input_file(&sb, file);
 
-	if (in_place)
+	if (opts->in_place)
 		outfile = create_in_place_tempfile(file);
 
 	/* Print the lines before the trailers */
@@ -990,14 +992,14 @@ void process_trailers(const char *file, int in_place, int trim_empty, struct str
 
 	process_trailers_lists(&head, &arg_head);
 
-	print_all(outfile, &head, trim_empty);
+	print_all(outfile, &head, opts);
 
 	free_all(&head);
 
 	/* Print the lines after the trailers as is */
 	fwrite(sb.buf + trailer_end, 1, sb.len - trailer_end, outfile);
 
-	if (in_place)
+	if (opts->in_place)
 		if (rename_tempfile(&trailers_tempfile, file))
 			die_errno(_("could not rename temporary file to %s"), file);
 
diff --git a/trailer.h b/trailer.h
index 65cc5d79c..e90ba1270 100644
--- a/trailer.h
+++ b/trailer.h
@@ -1,6 +1,11 @@
 #ifndef TRAILER_H
 #define TRAILER_H
 
+struct trailer_opts {
+	int in_place;
+	int trim_empty;
+};
+
 struct trailer_info {
 	/*
 	 * True if there is a blank line before the location pointed to by
@@ -22,7 +27,7 @@ struct trailer_info {
 	size_t trailer_nr;
 };
 
-void process_trailers(const char *file, int in_place, int trim_empty,
+void process_trailers(const char *file, const struct trailer_opts *opts,
 		      struct string_list *trailers);
 
 void trailer_info_get(struct trailer_info *info, const char *str);
-- 
2.13.0


