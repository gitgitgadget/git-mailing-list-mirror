Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E5514883F
	for <git@vger.kernel.org>; Thu,  1 May 2025 13:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746105481; cv=none; b=gLWWabHX9Az51D2kXJyFCqi9MPkg7P+Y4ntc/Q70bwNNV5fwj9ifzWlyijiUrVqETmqjQRBIvXIoQbPhvVzMd+jkyXv0NN/s/fPVwzoJjRGVU03/dw+txU8L/nfBSbPpY4x1T3NLu8I/QVT5LN5wdw6KYbuxJ7Q86NvOQp4Up7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746105481; c=relaxed/simple;
	bh=ED7OlECa1cvUdS5HoQpoJQeJmATBzKT/S2Kc91QT6d4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jtFuukQGSNc+oS0Uoa+RaGAXkkf/ok408xZn1vs6/Wy18quP6uLv73qRNKN+2tRKn2pgdG8ve+9QtwvU9y3wigHgLjGpbJrk1+iiSWojhN4vdypeiS6WO+/TUPiT5PnBONyVosJ4QX8hnUbjJs02Vkl7o3uDsJXeEg8Uu+XLqyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=Jwu5LnGr; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="Jwu5LnGr"
Received: (qmail 23875 invoked by uid 109); 1 May 2025 13:17:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-transfer-encoding:in-reply-to; s=20240930; bh=ED7OlECa1cvUdS5HoQpoJQeJmATBzKT/S2Kc91QT6d4=; b=Jwu5LnGrgDBozfQJJHPxTS1IUT7Yuc0ZBodh6Ozcvjg1cdCLLXhWBtmjLoeSiXjhOGqar79vEg+H2oJFFZt1VmXehJU30QhekoPpTUovknFJjE/wzLuLgp5bV7/P5XsemDtpgi8Rb2hgulWkQwL/FiPeNa11XsRRvmv275CdwAHiGJIRLPOYtUVvQEnN3wK9RmLI7yMGZl9RMDF0MqMTwEJBitOBWL+WYkKX58FHKAoQZRHc446LbJfCcxUpaaQYshcP7gCdm1sEnQ2e4jYmfygj4FmswkFrlj/7lsFwORjQzFeXGdvr3A99cq5WRXyOPrZ9rzglrbg6q708L5/ETg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 01 May 2025 13:17:51 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6409 invoked by uid 111); 1 May 2025 13:17:51 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 01 May 2025 09:17:51 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 1 May 2025 09:17:51 -0400
From: Jeff King <peff@peff.net>
To: Kristoffer Haugsbakk <code@khaugsbakk.name>
Cc: Phillip Wood <phillip.wood@dunelm.org.uk>, git@vger.kernel.org
Subject: Re: [BUG] rebase: can write reflog with uninit. `action` string
Message-ID: <20250501131751.GA1725607@coredump.intra.peff.net>
References: <20250428194048.149348-1-code@khaugsbakk.name>
 <ce0f41e4-7d90-4398-a0e9-e8ba69791e57@gmail.com>
 <fbc97d6a-2022-4a64-a2ba-5a7255cd81a6@app.fastmail.com>
 <20250429215155.GA36727@coredump.intra.peff.net>
 <6743a9fc-11ca-45ac-bc40-4148f5d85d27@app.fastmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6743a9fc-11ca-45ac-bc40-4148f5d85d27@app.fastmail.com>

On Wed, Apr 30, 2025 at 05:17:38PM +0200, Kristoffer Haugsbakk wrote:

> > Have you tried building with "make SANITIZE=address,undefined"?
> 
> No I haven’t.  Thank you.  The following is with that `make`.
> 
> Still on f65182a99e5 (The ninth batch, 2025-04-24).  I eventually[1]
> got this:
> 
> [1] I run through 19 merge conflicts which I `--continue` (using rerere)
>     until the rebase is done
> 
> ```
> detached HEAD 5d96584c836] Merge branch '<branch>' into <something else>
>  Author: [author]
> =================================================================
> ==87324==ERROR: AddressSanitizer: heap-use-after-free on address 0x60300001daa0 at pc 0x79371ca5df89 bp 0x7fff8e215a50 sp 0x7fff8e2151c8

Makes sense. Presumably it triggers in your case but not others because
something about your particular reflog messages causes the strbuf to
reallocate (I guess one of them is a lot longer than the others).

But we should be able to trigger it reliably with this:

diff --git a/sequencer.c b/sequencer.c
index b5c4043757..43db0ce66b 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -3939,7 +3939,7 @@ static const char *reflog_message(struct replay_opts *opts,
 	static struct strbuf buf = STRBUF_INIT;
 
 	va_start(ap, fmt);
-	strbuf_reset(&buf);
+	strbuf_release(&buf); /* guarantees reallocation */
 	strbuf_addstr(&buf, sequencer_reflog_action(opts));
 	if (sub_action)
 		strbuf_addf(&buf, " (%s)", sub_action);

And indeed, building with that patch and SANITIZE=address seems to show
the problem reliably with the existing tests in t3430 (it might also
show up without ASan, but probably not as reliably).

Probably the smallest solution is for ctx->reflog_message to copy the
result and always own the memory (and then remember to free it, both at
cleanup and if it is ever overwritten).

But I think the way reflog_message() returns the "buf" member of a
static strbuf is kind of an anti-pattern, exactly because you can get
this kind of subtle re-use. It probably should just return a non-const
pointer, handing over memory ownership to the caller. That would require
adjusting its other callers, too.

So the "smallest" version is perhaps something like this, totally
untested except for confirming that t3430 no longer complains:

diff --git a/sequencer.c b/sequencer.c
index b5c4043757..07aa3b3731 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -228,7 +228,7 @@ struct replay_ctx {
 	 * Stores the reflog message that will be used when creating a
 	 * commit. Points to a static buffer and should not be free()'d.
 	 */
-	const char *reflog_message;
+	char *reflog_message;
 	/*
 	 * The number of completed fixup and squash commands in the
 	 * current chain.
@@ -411,6 +411,7 @@ static void replay_ctx_release(struct replay_ctx *ctx)
 {
 	strbuf_release(&ctx->current_fixups);
 	strbuf_release(&ctx->message);
+	free(ctx->reflog_message);
 }
 
 void replay_opts_release(struct replay_opts *opts)
@@ -3939,7 +3940,7 @@ static const char *reflog_message(struct replay_opts *opts,
 	static struct strbuf buf = STRBUF_INIT;
 
 	va_start(ap, fmt);
-	strbuf_reset(&buf);
+	strbuf_release(&buf); /* guarantees realloaction */
 	strbuf_addstr(&buf, sequencer_reflog_action(opts));
 	if (sub_action)
 		strbuf_addf(&buf, " (%s)", sub_action);
@@ -4886,9 +4887,11 @@ static int pick_one_commit(struct repository *r,
 	int res;
 	struct todo_item *item = todo_list->items + todo_list->current;
 	const char *arg = todo_item_get_arg(todo_list, item);
-	if (is_rebase_i(opts))
-		ctx->reflog_message = reflog_message(
-			opts, command_to_string(item->command), NULL);
+	if (is_rebase_i(opts)) {
+		free(ctx->reflog_message);
+		ctx->reflog_message = xstrdup(reflog_message(
+			opts, command_to_string(item->command), NULL));
+	}
 
 	res = do_pick_commit(r, item, opts, is_final_fixup(todo_list),
 			     check_todo);
@@ -4947,7 +4950,8 @@ static int pick_commits(struct repository *r,
 	struct replay_ctx *ctx = opts->ctx;
 	int res = 0, reschedule = 0;
 
-	ctx->reflog_message = sequencer_reflog_action(opts);
+	free(ctx->reflog_message);
+	ctx->reflog_message = xstrdup(sequencer_reflog_action(opts));
 	if (opts->allow_ff)
 		ASSERT(!(opts->signoff || opts->no_commit ||
 			 opts->record_origin || should_edit(opts) ||
@@ -5423,7 +5427,8 @@ int sequencer_continue(struct repository *r, struct replay_opts *opts)
 			unlink(rebase_path_dropped());
 		}
 
-		ctx->reflog_message = reflog_message(opts, "continue", NULL);
+		free(ctx->reflog_message);
+		ctx->reflog_message = xstrdup(reflog_message(opts, "continue", NULL));
 		if (commit_staged_changes(r, opts, &todo_list)) {
 			res = -1;
 			goto release_todo_list;
@@ -5475,7 +5480,8 @@ static int single_pick(struct repository *r,
 			TODO_PICK : TODO_REVERT;
 	item.commit = cmit;
 
-	opts->ctx->reflog_message = sequencer_reflog_action(opts);
+	free(opts->ctx->reflog_message);
+	opts->ctx->reflog_message = xstrdup(sequencer_reflog_action(opts));
 	return do_pick_commit(r, &item, opts, 0, &check_todo);
 }
 

I'm hoping your or Phillip can decide on the best fix from here.

-Peff
