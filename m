Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 414BA20401
	for <e@80x24.org>; Mon, 12 Jun 2017 22:49:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752789AbdFLWtO (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Jun 2017 18:49:14 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:36535 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752666AbdFLWtN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jun 2017 18:49:13 -0400
Received: by mail-pf0-f194.google.com with SMTP id y7so17881639pfd.3
        for <git@vger.kernel.org>; Mon, 12 Jun 2017 15:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=nDsbFEiX+n9yfWvDK+uaHRrji3pflwjLQpiUmOVunn4=;
        b=dkHLqneIOjbePXYwqps0NFGTUJDE3VbOyKp2lU3MQnXAyxT6fbm08Dc7t+3JijOd2a
         W6ce7OudRPigZf2bzqS10/m2JAAyj93SnMjLfTnJpkNCO+j+yuA1jq8N21xwMXUVwATb
         UuRivNE0TOIpE9uwTCCtmCOMH56gCO4tWluW1we81nF4JxFNPeNBFm9b33kzoY4oQnxN
         vWECoZs1tK/QJar6c8OyZ+mnJDsWpodmjwL1xtxvifpUB+LMo0dYcDnOqC1+lOoW+SiB
         brsFMk0AnHvgbf/hrMb65JXgJ8Km0WklYmleZzRDb2bPvVV9gPxV8Fuq0mASPMfF7ctf
         Zm8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=nDsbFEiX+n9yfWvDK+uaHRrji3pflwjLQpiUmOVunn4=;
        b=J00quTOP+/CWBdPsczCYjQ4qMG/1WtHqGPuco95esXKQ1p+UhVIyMRtwGp8SQnWgka
         MOv+mRUHNhp23UVdmyvjCZE5uJy9o7+mXVzk4gsvv9Abqdrp/qJ9ThACvXVxur6XBTEy
         uPOX6v873nw6njyrzUqiVZGjJV6szyJC6VjC5OxvAPRfw2FFYHz2sy6lyQgBNocmDJxR
         PslUzxJybwCmWRZV84nxu9H7ZENGIETgXZLWjPHnD/pmdutE7vV2NE0WcjeqyfS78lRP
         tu5LKLQUbkKUT1v5wTyaSkdtq6xJd4ld47+9h3pCHSToSPsuzNuUQuF4pdZYo4fU7fu9
         xp2A==
X-Gm-Message-State: AODbwcDL05EDBfAgNMave2lZ2W3d9XP6A9RowLZREEB9hgi21AQ2a3j8
        h251i1IdKs/CiA==
X-Received: by 10.84.160.204 with SMTP id v12mr42952728plg.91.1497307752636;
        Mon, 12 Jun 2017 15:49:12 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:695d:4129:fb97:59df])
        by smtp.gmail.com with ESMTPSA id j71sm21665093pge.63.2017.06.12.15.49.11
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 12 Jun 2017 15:49:11 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Michael Giuffrida <michaelpg@chromium.org>
Cc:     git@vger.kernel.org,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [BUG] add_again() off-by-one error in custom format
References: <CACi5S_1j46SbP7cQMdUnULmgGD7xBkSUrS2PKbzq8ZydybHE=w@mail.gmail.com>
Date:   Mon, 12 Jun 2017 15:49:11 -0700
In-Reply-To: <CACi5S_1j46SbP7cQMdUnULmgGD7xBkSUrS2PKbzq8ZydybHE=w@mail.gmail.com>
        (Michael Giuffrida's message of "Sun, 11 Jun 2017 20:13:16 -0700")
Message-ID: <xmqqd1a8n7o8.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Michael Giuffrida <michaelpg@chromium.org> writes:

> For the abbreviated commit hash placeholder ('h'), pretty.c uses
> add_again() to cache the result of the expansion, and then uses that
> result in future expansions. This causes problems when the expansion
> includes whitespace:
>
>     $ git log -n 1 --pretty='format:newline:%+h%nno_newline:%h'
>     newline:
>     a0b1c2d
>     no_newline:
>     a0b1c2
>
> The second expansion of the hash added an unwanted newline and removed
> the final character. It seemingly used the cached expansion *starting
> from the inserted newline*.
>
> The expected output is:
>
>     $ git log -n 1 --pretty='format:newline:%+h%nno_newline:%h'
>     newline:
>     a0b1c2d
>     no_newline:a0b1c2d

Nicely explained.  The add_again() mechanism caches an earlier
result by remembering the offset and the length in the strbuf the
formatted string is being accumulated to, but because %+x (and
probably %-x) magic placeholders futz with the result of
format_commit_one() in place, the cache goes out of sync, of course.

I think the call to format_commit_one() needs to be taught to pass
'magic' through, and then add_again() mechanism needs to be told not
to cache when magic is in effect, or something like that.

Perhaps something along this line...?

 pretty.c | 64 ++++++++++++++++++++++++++++++++++++++--------------------------
 1 file changed, 38 insertions(+), 26 deletions(-)

diff --git a/pretty.c b/pretty.c
index 09701bd2ff..be22b12986 100644
--- a/pretty.c
+++ b/pretty.c
@@ -789,20 +789,22 @@ struct format_commit_context {
 	size_t wrap_start;
 };
 
-static int add_again(struct strbuf *sb, struct chunk *chunk)
+static int add_again(struct strbuf *sb, struct chunk *chunk, int no_cache)
 {
 	if (chunk->len) {
 		strbuf_adddup(sb, chunk->off, chunk->len);
 		return 1;
 	}
 
-	/*
-	 * We haven't seen this chunk before.  Our caller is surely
-	 * going to add it the hard way now.  Remember the most likely
-	 * start of the to-be-added chunk: the current end of the
-	 * struct strbuf.
-	 */
-	chunk->off = sb->len;
+	if (!no_cache) {
+		/*
+		 * We haven't seen this chunk before.  Our caller is surely
+		 * going to add it the hard way now.  Remember the most likely
+		 * start of the to-be-added chunk: the current end of the
+		 * struct strbuf.
+		 */
+		chunk->off = sb->len;
+	}
 	return 0;
 }
 
@@ -1066,15 +1068,24 @@ static size_t parse_padding_placeholder(struct strbuf *sb,
 	return 0;
 }
 
+enum format_commit_item_magic {
+	NO_MAGIC,
+	ADD_LF_BEFORE_NON_EMPTY,
+	DEL_LF_BEFORE_EMPTY,
+	ADD_SP_BEFORE_NON_EMPTY
+};
+
 static size_t format_commit_one(struct strbuf *sb, /* in UTF-8 */
 				const char *placeholder,
-				void *context)
+				void *context,
+				enum format_commit_item_magic magic)
 {
 	struct format_commit_context *c = context;
 	const struct commit *commit = c->commit;
 	const char *msg = c->message;
 	struct commit_list *p;
 	int ch;
+	int no_cache;
 
 	/* these are independent of the commit */
 	switch (placeholder[0]) {
@@ -1139,6 +1150,8 @@ static size_t format_commit_one(struct strbuf *sb, /* in UTF-8 */
 	if (!commit->object.parsed)
 		parse_object(&commit->object.oid);
 
+	no_cache = magic != NO_MAGIC;
+
 	switch (placeholder[0]) {
 	case 'H':		/* commit hash */
 		strbuf_addstr(sb, diff_get_color(c->auto_color, DIFF_COMMIT));
@@ -1147,24 +1160,26 @@ static size_t format_commit_one(struct strbuf *sb, /* in UTF-8 */
 		return 1;
 	case 'h':		/* abbreviated commit hash */
 		strbuf_addstr(sb, diff_get_color(c->auto_color, DIFF_COMMIT));
-		if (add_again(sb, &c->abbrev_commit_hash)) {
+		if (add_again(sb, &c->abbrev_commit_hash, no_cache)) {
 			strbuf_addstr(sb, diff_get_color(c->auto_color, DIFF_RESET));
 			return 1;
 		}
 		strbuf_add_unique_abbrev(sb, commit->object.oid.hash,
 					 c->pretty_ctx->abbrev);
 		strbuf_addstr(sb, diff_get_color(c->auto_color, DIFF_RESET));
-		c->abbrev_commit_hash.len = sb->len - c->abbrev_commit_hash.off;
+		if (!no_cache)
+			c->abbrev_commit_hash.len = sb->len - c->abbrev_commit_hash.off;
 		return 1;
 	case 'T':		/* tree hash */
 		strbuf_addstr(sb, oid_to_hex(&commit->tree->object.oid));
 		return 1;
 	case 't':		/* abbreviated tree hash */
-		if (add_again(sb, &c->abbrev_tree_hash))
+		if (add_again(sb, &c->abbrev_tree_hash, no_cache))
 			return 1;
 		strbuf_add_unique_abbrev(sb, commit->tree->object.oid.hash,
 					 c->pretty_ctx->abbrev);
-		c->abbrev_tree_hash.len = sb->len - c->abbrev_tree_hash.off;
+		if (!no_cache)
+			c->abbrev_tree_hash.len = sb->len - c->abbrev_tree_hash.off;
 		return 1;
 	case 'P':		/* parent hashes */
 		for (p = commit->parents; p; p = p->next) {
@@ -1174,7 +1189,7 @@ static size_t format_commit_one(struct strbuf *sb, /* in UTF-8 */
 		}
 		return 1;
 	case 'p':		/* abbreviated parent hashes */
-		if (add_again(sb, &c->abbrev_parent_hashes))
+		if (add_again(sb, &c->abbrev_parent_hashes, no_cache))
 			return 1;
 		for (p = commit->parents; p; p = p->next) {
 			if (p != commit->parents)
@@ -1182,8 +1197,9 @@ static size_t format_commit_one(struct strbuf *sb, /* in UTF-8 */
 			strbuf_add_unique_abbrev(sb, p->item->object.oid.hash,
 						 c->pretty_ctx->abbrev);
 		}
-		c->abbrev_parent_hashes.len = sb->len -
-		                              c->abbrev_parent_hashes.off;
+		if (!no_cache)
+			c->abbrev_parent_hashes.len = 
+				sb->len - c->abbrev_parent_hashes.off;
 		return 1;
 	case 'm':		/* left/right/bottom */
 		strbuf_addstr(sb, get_revision_mark(NULL, commit));
@@ -1314,7 +1330,8 @@ static size_t format_commit_one(struct strbuf *sb, /* in UTF-8 */
 
 static size_t format_and_pad_commit(struct strbuf *sb, /* in UTF-8 */
 				    const char *placeholder,
-				    struct format_commit_context *c)
+				    struct format_commit_context *c,
+				    enum format_commit_item_magic magic)
 {
 	struct strbuf local_sb = STRBUF_INIT;
 	int total_consumed = 0, len, padding = c->padding;
@@ -1329,7 +1346,7 @@ static size_t format_and_pad_commit(struct strbuf *sb, /* in UTF-8 */
 	}
 	while (1) {
 		int modifier = *placeholder == 'C';
-		int consumed = format_commit_one(&local_sb, placeholder, c);
+		int consumed = format_commit_one(&local_sb, placeholder, c, magic);
 		total_consumed += consumed;
 
 		if (!modifier)
@@ -1420,12 +1437,7 @@ static size_t format_commit_item(struct strbuf *sb, /* in UTF-8 */
 {
 	int consumed;
 	size_t orig_len;
-	enum {
-		NO_MAGIC,
-		ADD_LF_BEFORE_NON_EMPTY,
-		DEL_LF_BEFORE_EMPTY,
-		ADD_SP_BEFORE_NON_EMPTY
-	} magic = NO_MAGIC;
+	enum format_commit_item_magic magic = NO_MAGIC;
 
 	switch (placeholder[0]) {
 	case '-':
@@ -1445,9 +1457,9 @@ static size_t format_commit_item(struct strbuf *sb, /* in UTF-8 */
 
 	orig_len = sb->len;
 	if (((struct format_commit_context *)context)->flush_type != no_flush)
-		consumed = format_and_pad_commit(sb, placeholder, context);
+		consumed = format_and_pad_commit(sb, placeholder, context, magic);
 	else
-		consumed = format_commit_one(sb, placeholder, context);
+		consumed = format_commit_one(sb, placeholder, context, magic);
 	if (magic == NO_MAGIC)
 		return consumed;
 
