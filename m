Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24AB6C433EF
	for <git@archiver.kernel.org>; Mon, 29 Nov 2021 10:59:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352065AbhK2LDB (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Nov 2021 06:03:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347256AbhK2LA6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Nov 2021 06:00:58 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02C66C061757
        for <git@vger.kernel.org>; Mon, 29 Nov 2021 02:14:34 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id e3so69521424edu.4
        for <git@vger.kernel.org>; Mon, 29 Nov 2021 02:14:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=rtVRYsmiNiHr9hPwoeEVOpVRnCoIKXrbz+fR/p0Spj0=;
        b=QnUBu0m/We5rHG0HJbkyGuhF7tHpeyNEB1/1Govbtv2xHOGlpYz2zk5aQU53T9nV02
         w6rE96GmM2Ih6IcvZz4yIHZRO5P8Taxk84ZKT+aW3M7bsX9NW5+uX8yO4CQ3MG6bR4I5
         Hy6/N2C/ayZvgoMDu74G5TXMIoLJN8wAiGzVgGnTsakVvXyNM+cNNBmM5d4NQ/ujBomK
         s45pvQ1R4Ps2gPuqSc5Jc3vOB/kWj0cVifdbxzZXcEY5Yon6SYo/c5pWxhcXgb7pgIQZ
         y1yqUmpJYU4Z2O+bzWXnmo1v1+lF+ARiLH2JkxByAeaROCD6HwnVWk+nKqifDUey5S6j
         ruCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=rtVRYsmiNiHr9hPwoeEVOpVRnCoIKXrbz+fR/p0Spj0=;
        b=7HOZfO+jUj+TjwV/+RuCutFynE5cCq7jVrhmwyB1KtJ7Tn7T7kbxQ0cYzn2SpyMZZq
         ZNpu068TZ3YCMGVNjNfWABuGhcPH2XqGSpoNcacQN44zlVMzHYB+a573eHUAsaYHWWW9
         miiak9qhdmFAUB3nWaYrBuIGElBUXG69XNaM8mL3NTB8RcIh38GrK/G1BAyNOCXaQMP8
         b749az9uEv2lQcJr9xLmI1vdhm3Vut4oJdulzHYzJo1kCga7eIjrdYlUik3oyQ/Y7d8S
         gxtFs/Aiz/tp1KOhN9hkRhz0CCCQQCFJhgwtUz12Jr/bdc46EZnRBlWZRoajnqhXRqSf
         fe8Q==
X-Gm-Message-State: AOAM533IBAKD6H038C0q7jqGMGbdlIwRqtcokbs+6eofcmC8wWrjtXl9
        Q8XUhzLXUi8Z5EWSReZR9TsAiQmXqWg=
X-Google-Smtp-Source: ABdhPJzCLMSB9s91BP1uZkD6CkBL2MACK0T4I/dQsbzWS/ZUuVl02jBGwd6GJarddwLl7AGNPhG1Xw==
X-Received: by 2002:a17:906:6d05:: with SMTP id m5mr15057307ejr.499.1638180872075;
        Mon, 29 Nov 2021 02:14:32 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id f22sm9641148edf.93.2021.11.29.02.14.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 02:14:31 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mrdg6-000gxt-Uq;
        Mon, 29 Nov 2021 11:14:30 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwen@google.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: Re: [PATCH v2 0/5] Inspect reflog data programmatically in more tests
Date:   Mon, 29 Nov 2021 10:50:33 +0100
References: <pull.1145.git.git.1637590855.gitgitgadget@gmail.com>
 <pull.1145.v2.git.git.1637855872.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.9
In-reply-to: <pull.1145.v2.git.git.1637855872.gitgitgadget@gmail.com>
Message-ID: <211129.86czmjgtfd.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Nov 25 2021, Han-Wen Nienhuys via GitGitGadget wrote:

> This helps for reftable support, and will help if we want to reconsider
> under which conditions reflogs get created/updated.

Having looked at this in a bit more detail than last time
(https://lore.kernel.org/git/211123.864k83w3y4.gmgdl@evledraar.gmail.com/)
I applaud the goals, but to be blunt the specific approach just seems a
bit backwards to me.

As noted in that message I have patches to tweak the "verbose" mode to
be backend-independent, which as we see from your series is one thing in
the files backend that consumes the "message" and assumes things about
newlines.

Similarly from peeking at the reflog code I see it stores name/email
separately in a struct, but the refs.[ch] API wants to pass "name
<email>" as one string.

The below working patch shows that we have three consumers of that
specific format, so we can just xstrfmt() that instead of xstrdup()-ing
it in one case, and tweak the printf in the other two, and then we pass
it as two parameters.

So it's truly backend-independent now, i.e. a "real DB" like reftable,
SQL or whatever would store those in two separate fields.

So on the "seems backwards" above: If you apply this (and it passes all
tests) and look at what "message" is used for you're guaranteed to find
all the callers, and only a handful more of them are using that for
anything.

So I'd really expect a series like this to just change the
strbuf_getwholeline() in files_for_each_reflog_ent() to be a
strbuf_getline(). Then flip everything downstream that expects a '\n' to
either not, or to add if needed.

E.g. the test helper that's now adding a newline would be correct, and
we'd just need to tweak the file backend specific stuff that's now
skipping the addition of newlines to add them instead.

Anyway, changing the callbacks is quite verbose, and I just did this
ident->name/email change expecting that it would be more difficult.

But likewise the big benefit is that we *are* forced to tweak all
callers, so we're more likely to catch any subtle regressions, and it's
thus easier to review once we get past the verbosity.

I also wonder if for name/email/message a bit more tweaking of this to
make them all const char */size_t pairs wouldn't result in a much better
end-state. I.e. now we read into a strbuf in a loop in files-backend.c
and xstrdup() it.

Perhaps reftable is capable of just handing the underlying code pointers
into the mmap()'d file, so we could even skip all (re)allocations? Or if
not, that certainly seems like a sensible thing to anticipate in a
backend-independent interface. We could do that in the file backend if
we were a bit smarter and used mmap() instead of the
fopen()/read-in-a-loop pattern.

Just my 0.02, if you're interested in running with the below assume my
SOB.

diff --git a/builtin/fsck.c b/builtin/fsck.c
index 27b9e78094d..2ccb20ce057 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -487,8 +487,9 @@ static void fsck_handle_reflog_oid(const char *refname, struct object_id *oid,
 }
 
 static int fsck_handle_reflog_ent(struct object_id *ooid, struct object_id *noid,
-		const char *email, timestamp_t timestamp, int tz,
-		const char *message, void *cb_data)
+				  const char *committer_name, const char *committer_email,
+				  timestamp_t timestamp, int tz,
+				  const char *message, void *cb_data)
 {
 	const char *refname = cb_data;
 
diff --git a/builtin/reflog.c b/builtin/reflog.c
index 175c83e7cc2..0cf7d484613 100644
--- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -295,7 +295,8 @@ static int unreachable(struct expire_reflog_policy_cb *cb, struct commit *commit
  * Return true iff the specified reflog entry should be expired.
  */
 static int should_expire_reflog_ent(struct object_id *ooid, struct object_id *noid,
-				    const char *email, timestamp_t timestamp, int tz,
+				    const char *committer_name, const char *committer_email,
+				    timestamp_t timestamp, int tz,
 				    const char *message, void *cb_data)
 {
 	struct expire_reflog_policy_cb *cb = cb_data;
@@ -659,8 +660,9 @@ static int cmd_reflog_expire(int argc, const char **argv, const char *prefix)
 }
 
 static int count_reflog_ent(struct object_id *ooid, struct object_id *noid,
-		const char *email, timestamp_t timestamp, int tz,
-		const char *message, void *cb_data)
+			    const char *committer_name, const char *committer_email,
+			    timestamp_t timestamp, int tz,
+			    const char *message, void *cb_data)
 {
 	struct expire_reflog_policy_cb *cb = cb_data;
 	if (!cb->cmd.expire_total || timestamp < cb->cmd.expire_total)
diff --git a/builtin/stash.c b/builtin/stash.c
index a0ccc8654df..b6963050b6d 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -620,7 +620,8 @@ static int apply_stash(int argc, const char **argv, const char *prefix)
 }
 
 static int reject_reflog_ent(struct object_id *ooid, struct object_id *noid,
-			     const char *email, timestamp_t timestamp, int tz,
+			     const char *committer_name, const char *committer_email,
+			     timestamp_t timestamp, int tz,
 			     const char *message, void *cb_data)
 {
 	return 1;
diff --git a/commit.c b/commit.c
index 551de4903c1..ea97f639cc4 100644
--- a/commit.c
+++ b/commit.c
@@ -937,8 +937,9 @@ static void add_one_commit(struct object_id *oid, struct rev_collect *revs)
 }
 
 static int collect_one_reflog_ent(struct object_id *ooid, struct object_id *noid,
-				  const char *ident, timestamp_t timestamp,
-				  int tz, const char *message, void *cbdata)
+				  const char *author, const char *email,
+				  timestamp_t timestamp, int tz,
+				  const char *message, void *cbdata)
 {
 	struct rev_collect *revs = cbdata;
 
diff --git a/object-name.c b/object-name.c
index fdff4601b2c..56b131fb4a7 100644
--- a/object-name.c
+++ b/object-name.c
@@ -1287,7 +1287,8 @@ struct grab_nth_branch_switch_cbdata {
 };
 
 static int grab_nth_branch_switch(struct object_id *ooid, struct object_id *noid,
-				  const char *email, timestamp_t timestamp, int tz,
+				  const char *author, const char *email,
+				  timestamp_t timestamp, int tz,
 				  const char *message, void *cb_data)
 {
 	struct grab_nth_branch_switch_cbdata *cb = cb_data;
diff --git a/reflog-walk.c b/reflog-walk.c
index 8ac4b284b6b..12865f4cb84 100644
--- a/reflog-walk.c
+++ b/reflog-walk.c
@@ -20,8 +20,9 @@ struct complete_reflogs {
 };
 
 static int read_one_reflog(struct object_id *ooid, struct object_id *noid,
-		const char *email, timestamp_t timestamp, int tz,
-		const char *message, void *cb_data)
+			   const char *author, const char *email,
+			   timestamp_t timestamp, int tz,
+			   const char *message, void *cb_data)
 {
 	struct complete_reflogs *array = cb_data;
 	struct reflog_info *item;
@@ -30,7 +31,7 @@ static int read_one_reflog(struct object_id *ooid, struct object_id *noid,
 	item = array->items + array->nr;
 	oidcpy(&item->ooid, ooid);
 	oidcpy(&item->noid, noid);
-	item->email = xstrdup(email);
+	item->email = xstrfmt("%s <%s>", author, email);
 	item->timestamp = timestamp;
 	item->tz = tz;
 	item->message = xstrdup(message);
diff --git a/refs.c b/refs.c
index d7cc0a23a3b..8d95fd2a6bb 100644
--- a/refs.c
+++ b/refs.c
@@ -894,8 +894,9 @@ static void set_read_ref_cutoffs(struct read_ref_at_cb *cb,
 }
 
 static int read_ref_at_ent(struct object_id *ooid, struct object_id *noid,
-		const char *email, timestamp_t timestamp, int tz,
-		const char *message, void *cb_data)
+			   const char *committer_name, const char *committer_email,
+			   timestamp_t timestamp, int tz,
+			   const char *message, void *cb_data)
 {
 	struct read_ref_at_cb *cb = cb_data;
 	int reached_count;
@@ -936,8 +937,9 @@ static int read_ref_at_ent(struct object_id *ooid, struct object_id *noid,
 }
 
 static int read_ref_at_ent_newest(struct object_id *ooid, struct object_id *noid,
-				  const char *email, timestamp_t timestamp,
-				  int tz, const char *message, void *cb_data)
+				  const char *author, const char *committer_email,
+				  timestamp_t timestamp, int tz,
+				  const char *message, void *cb_data)
 {
 	struct read_ref_at_cb *cb = cb_data;
 
@@ -948,8 +950,9 @@ static int read_ref_at_ent_newest(struct object_id *ooid, struct object_id *noid
 }
 
 static int read_ref_at_ent_oldest(struct object_id *ooid, struct object_id *noid,
-				  const char *email, timestamp_t timestamp,
-				  int tz, const char *message, void *cb_data)
+				  const char *committer_name, const char *committer_email,
+				  timestamp_t timestamp, int tz,
+				  const char *message, void *cb_data)
 {
 	struct read_ref_at_cb *cb = cb_data;
 
diff --git a/refs.h b/refs.h
index d5099d4984e..a34e98a4123 100644
--- a/refs.h
+++ b/refs.h
@@ -463,8 +463,9 @@ int delete_reflog(const char *refname);
  */
 typedef int each_reflog_ent_fn(
 		struct object_id *old_oid, struct object_id *new_oid,
-		const char *committer, timestamp_t timestamp,
-		int tz, const char *msg, void *cb_data);
+		const char *committer_name, const char *committer_email,
+		timestamp_t timestamp, int tz,
+		const char *msg, void *cb_data);
 
 /* Iterate over reflog entries in the log for `refname`. */
 
@@ -807,7 +808,7 @@ typedef void reflog_expiry_prepare_fn(const char *refname,
 				      void *cb_data);
 typedef int reflog_expiry_should_prune_fn(struct object_id *ooid,
 					  struct object_id *noid,
-					  const char *email,
+					  const char *author, const char *email,
 					  timestamp_t timestamp, int tz,
 					  const char *message, void *cb_data);
 typedef void reflog_expiry_cleanup_fn(void *cb_data);
diff --git a/refs/debug.c b/refs/debug.c
index 8667c640237..dc4b417abeb 100644
--- a/refs/debug.c
+++ b/refs/debug.c
@@ -277,8 +277,9 @@ struct debug_reflog {
 
 static int debug_print_reflog_ent(struct object_id *old_oid,
 				  struct object_id *new_oid,
-				  const char *committer, timestamp_t timestamp,
-				  int tz, const char *msg, void *cb_data)
+				  const char *committer, const char *committer_email,
+				  timestamp_t timestamp, int tz,
+				  const char *msg, void *cb_data)
 {
 	struct debug_reflog *dbg = (struct debug_reflog *)cb_data;
 	int ret;
@@ -289,10 +290,11 @@ static int debug_print_reflog_ent(struct object_id *old_oid,
 	if (new_oid)
 		oid_to_hex_r(n, new_oid);
 
-	ret = dbg->fn(old_oid, new_oid, committer, timestamp, tz, msg,
-		      dbg->cb_data);
-	trace_printf_key(&trace_refs, "reflog_ent %s (ret %d): %s -> %s, %s %ld \"%s\"\n",
-		dbg->refname, ret, o, n, committer, (long int)timestamp, msg);
+	ret = dbg->fn(old_oid, new_oid, committer, committer_email,
+		      timestamp, tz, msg, dbg->cb_data);
+	trace_printf_key(&trace_refs, "reflog_ent %s (ret %d): %s -> %s, %s <%s> %ld \"%s\"\n",
+		dbg->refname, ret, o, n, committer, committer_email,
+			 (long int)timestamp, msg);
 	return ret;
 }
 
@@ -374,12 +376,13 @@ static void debug_reflog_expiry_prepare(const char *refname,
 
 static int debug_reflog_expiry_should_prune_fn(struct object_id *ooid,
 					       struct object_id *noid,
-					       const char *email,
+					       const char *committer_name, const char *committer_email,
 					       timestamp_t timestamp, int tz,
 					       const char *message, void *cb_data) {
 	struct debug_reflog_expiry_should_prune *prune = cb_data;
 
-	int result = prune->should_prune(ooid, noid, email, timestamp, tz, message, prune->cb_data);
+	int result = prune->should_prune(ooid, noid, committer_name, committer_email,
+					 timestamp, tz, message, prune->cb_data);
 	trace_printf_key(&trace_refs, "reflog_expire_should_prune: %s %ld: %d\n", message, (long int) timestamp, result);
 	return result;
 }
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 151b0056fe5..d15f3342c31 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1931,7 +1931,10 @@ static int files_delete_reflog(struct ref_store *ref_store,
 static int show_one_reflog_ent(struct strbuf *sb, each_reflog_ent_fn fn, void *cb_data)
 {
 	struct object_id ooid, noid;
-	char *email_end, *message;
+	const char *name;
+	char *email;
+	char *email_end;
+	char *message;
 	timestamp_t timestamp;
 	int tz;
 	const char *p = sb->buf;
@@ -1940,6 +1943,8 @@ static int show_one_reflog_ent(struct strbuf *sb, each_reflog_ent_fn fn, void *c
 	if (!sb->len || sb->buf[sb->len - 1] != '\n' ||
 	    parse_oid_hex(p, &ooid, &p) || *p++ != ' ' ||
 	    parse_oid_hex(p, &noid, &p) || *p++ != ' ' ||
+	    !(name = p) ||
+	    !(email = strchr(p, '<')) ||
 	    !(email_end = strchr(p, '>')) ||
 	    email_end[1] != ' ' ||
 	    !(timestamp = parse_timestamp(email_end + 2, &message, 10)) ||
@@ -1948,13 +1953,20 @@ static int show_one_reflog_ent(struct strbuf *sb, each_reflog_ent_fn fn, void *c
 	    !isdigit(message[2]) || !isdigit(message[3]) ||
 	    !isdigit(message[4]) || !isdigit(message[5]))
 		return 0; /* corrupt? */
-	email_end[1] = '\0';
+	/* \0 the SP before "<", marks end of "name"... */
+	*(email - 1) = '\0';
+	/* ... and advance past the opening... "<" */
+	email++;
+	/* ...and stop at the ">" */
+	email_end[0] = '\0';
+
 	tz = strtol(message + 1, NULL, 10);
 	if (message[6] != '\t')
 		message += 6;
 	else
 		message += 7;
-	return fn(&ooid, &noid, p, timestamp, tz, message, cb_data);
+	return fn(&ooid, &noid, name, email, timestamp, tz, message,
+		  cb_data);
 }
 
 static char *find_beginning_of_line(char *bob, char *scan)
@@ -3047,7 +3059,8 @@ struct expire_reflog_cb {
 };
 
 static int expire_reflog_ent(struct object_id *ooid, struct object_id *noid,
-			     const char *email, timestamp_t timestamp, int tz,
+			     const char *author, const char *email,
+			     timestamp_t timestamp, int tz,
 			     const char *message, void *cb_data)
 {
 	struct expire_reflog_cb *cb = cb_data;
@@ -3056,7 +3069,8 @@ static int expire_reflog_ent(struct object_id *ooid, struct object_id *noid,
 	if (cb->flags & EXPIRE_REFLOGS_REWRITE)
 		ooid = &cb->last_kept_oid;
 
-	if ((*cb->should_prune_fn)(ooid, noid, email, timestamp, tz,
+	if ((*cb->should_prune_fn)(ooid, noid, author, email,
+				   timestamp, tz,
 				   message, policy_cb)) {
 		if (!cb->newlog)
 			printf("would prune %s", message);
@@ -3064,9 +3078,9 @@ static int expire_reflog_ent(struct object_id *ooid, struct object_id *noid,
 			printf("prune %s", message);
 	} else {
 		if (cb->newlog) {
-			fprintf(cb->newlog, "%s %s %s %"PRItime" %+05d\t%s",
+			fprintf(cb->newlog, "%s %s %s <%s> %"PRItime" %+05d\t%s",
 				oid_to_hex(ooid), oid_to_hex(noid),
-				email, timestamp, tz, message);
+				author, email, timestamp, tz, message);
 			oidcpy(&cb->last_kept_oid, noid);
 		}
 		if (cb->flags & EXPIRE_REFLOGS_VERBOSE)
diff --git a/remote.c b/remote.c
index f958543d707..3cd0cdce879 100644
--- a/remote.c
+++ b/remote.c
@@ -2428,8 +2428,9 @@ struct check_and_collect_until_cb_data {
 
 /* Get the timestamp of the latest entry. */
 static int peek_reflog(struct object_id *o_oid, struct object_id *n_oid,
-		       const char *ident, timestamp_t timestamp,
-		       int tz, const char *message, void *cb_data)
+		       const char *committer_name, const char *committer_email,
+		       timestamp_t timestamp, int tz,
+		       const char *message, void *cb_data)
 {
 	timestamp_t *ts = cb_data;
 	*ts = timestamp;
@@ -2438,8 +2439,9 @@ static int peek_reflog(struct object_id *o_oid, struct object_id *n_oid,
 
 static int check_and_collect_until(struct object_id *o_oid,
 				   struct object_id *n_oid,
-				   const char *ident, timestamp_t timestamp,
-				   int tz, const char *message, void *cb_data)
+				   const char *committer_name, const char *committer_email,
+				   timestamp_t timestamp, int tz,
+				   const char *message, void *cb_data)
 {
 	struct commit *commit;
 	struct check_and_collect_until_cb_data *cb = cb_data;
diff --git a/revision.c b/revision.c
index 1981a0859f0..2979f456cb6 100644
--- a/revision.c
+++ b/revision.c
@@ -1597,8 +1597,9 @@ static void handle_one_reflog_commit(struct object_id *oid, void *cb_data)
 }
 
 static int handle_one_reflog_ent(struct object_id *ooid, struct object_id *noid,
-		const char *email, timestamp_t timestamp, int tz,
-		const char *message, void *cb_data)
+				 const char *author, const char *email,
+				 timestamp_t timestamp, int tz,
+				 const char *message, void *cb_data)
 {
 	handle_one_reflog_commit(ooid, cb_data);
 	handle_one_reflog_commit(noid, cb_data);
diff --git a/t/helper/test-ref-store.c b/t/helper/test-ref-store.c
index b314b81a45b..727ac008ad8 100644
--- a/t/helper/test-ref-store.c
+++ b/t/helper/test-ref-store.c
@@ -148,12 +148,13 @@ static int cmd_for_each_reflog(struct ref_store *refs, const char **argv)
 }
 
 static int each_reflog(struct object_id *old_oid, struct object_id *new_oid,
-		       const char *committer, timestamp_t timestamp,
-		       int tz, const char *msg, void *cb_data)
+		       const char *committer, const char *committer_email,
+		       timestamp_t timestamp, int tz,
+		       const char *msg, void *cb_data)
 {
-	printf("%s %s %s %"PRItime" %d %s\n",
+	printf("%s %s %s <%s> %"PRItime" %d %s\n",
 	       oid_to_hex(old_oid), oid_to_hex(new_oid),
-	       committer, timestamp, tz, msg);
+	       committer, committer_email, timestamp, tz, msg);
 	return 0;
 }
 
diff --git a/wt-status.c b/wt-status.c
index e4f29b2b4c9..a8526a4a100 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -940,7 +940,8 @@ static void wt_longstatus_print_changed(struct wt_status *s)
 }
 
 static int stash_count_refs(struct object_id *ooid, struct object_id *noid,
-			    const char *email, timestamp_t timestamp, int tz,
+			    const char *committer_name, const char *committer_email,
+			    timestamp_t timestamp, int tz,
 			    const char *message, void *cb_data)
 {
 	int *c = cb_data;
@@ -1592,7 +1593,8 @@ struct grab_1st_switch_cbdata {
 };
 
 static int grab_1st_switch(struct object_id *ooid, struct object_id *noid,
-			   const char *email, timestamp_t timestamp, int tz,
+			   const char *committer_name , const char *committer_email,
+			   timestamp_t timestamp, int tz,
 			   const char *message, void *cb_data)
 {
 	struct grab_1st_switch_cbdata *cb = cb_data;
