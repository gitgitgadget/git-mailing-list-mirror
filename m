Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 541D6C433EF
	for <git@archiver.kernel.org>; Mon, 23 May 2022 14:35:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237287AbiEWOfk (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 May 2022 10:35:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237270AbiEWOfc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 May 2022 10:35:32 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF13B2E9D6
        for <git@vger.kernel.org>; Mon, 23 May 2022 07:35:24 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id en5so19420793edb.1
        for <git@vger.kernel.org>; Mon, 23 May 2022 07:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=CJgwlQybN8NUjEsVjDG9h6Ur36U4I6hpx1BU1KUXmQY=;
        b=YVlEBt8svZO2lXMSL/CuotwdvPfPQMWMPMnT/+v9shlBTcq5Kq58GH3mvdPsQKN3hT
         1cETLHhu7A7j3LRGhRGs2s/YKN1ngZXYM+/wVYxh+BB+7DWhtXo5q4gnkE1vI79tHya5
         1w7b8ZEZcZaPhXVZDeUgK6wDXKoDKVe/p9U61UCwnwYrpOO8k2LaD4qhxqTDwACbDGLW
         2F5JOQxc1r+nF5dFUD6MmUNJ1ta378/gxFd/czatdgz6It3xchTufbyFhnq6+qNdFdey
         NV7VgpNsxZyJogIdgKozVrqjuAmRksgyO0iKgQQz5jFSZbaBKrT8daYUCQF5GdF9czVb
         2CbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=CJgwlQybN8NUjEsVjDG9h6Ur36U4I6hpx1BU1KUXmQY=;
        b=etjz2bf/vQLHWWOYkzsMPy2ASsq3plrhoKsHIfxBnSAtg11tVcbvLoLXtwrr09ZAXK
         F5Pl8E8ipsAN4KFDU7EPGLS762lkZzKmNCQfr0o07+ItXpxpoU/yOgp4p4PhYEXtXcce
         r8BNIwIOGS/iRkoHyaognX6ahzX+yH9olO9V5kpxjV3DwRw+NtjVCbpKHQzfmUIU3pcU
         Z0HD55NTJwMwqGRR5pNlCl5nCkEaBRqLuiyU7d8+8AIQm5SD0cYRpYkEOaoSJ/a/1PbJ
         LwBU2jdoffYmUsvAvI8G/onh+70hz0eXeuGN6CtpxRjrXTzVOex27ITZ/NrJaVyyOFul
         mJcA==
X-Gm-Message-State: AOAM5320uSFKo8JVdBXoul0jdhmwNM2o4I1aLYCjNZnUw5MBetoLZluh
        uLFgEGbowvAr5Tj1gQtlIv8+aLi7/R0=
X-Google-Smtp-Source: ABdhPJzrOD900TIlgP80isO2vzSJkHK6aLKl7W3alIRNN+0UmbY8BwjU5jgjActcqx6ID0xk77Gq/A==
X-Received: by 2002:a05:6402:2391:b0:42b:74ef:f164 with SMTP id j17-20020a056402239100b0042b74eff164mr2716695eda.151.1653316523215;
        Mon, 23 May 2022 07:35:23 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id s7-20020a170906220700b006f3ef214e51sm6140166ejs.183.2022.05.23.07.35.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 May 2022 07:35:22 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nt99W-002yTN-5s;
        Mon, 23 May 2022 16:35:22 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] revert: optionally refer to commit in the "reference"
 format
Date:   Mon, 23 May 2022 15:45:26 +0200
References: <xmqqsfp2b30k.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <xmqqsfp2b30k.fsf@gitster.g>
Message-ID: <220523.86wnecxqol.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, May 21 2022, Junio C Hamano wrote:

> A typical "git revert" commit uses the full title of the original
> commit in its title, and starts its body of the message with:
>
>     This reverts commit 8fa7f667cf61386257c00d6e954855cc3215ae91.
>
> This does not encourage the best practice of describing not just
> "what" (i.e. "Revert X" on the title says what we did) but "why"
> (i.e. and it does not say why X was undesirable).
>
> We can instead phrase this first line of the body to be more like
>
>     This reverts commit 8fa7f667 (do this and that, 2022-04-25)
>
> so that the title does not have to be
>
>     Revert "do this and that"
>
> We can instead use the title to describe "why" we are reverting the
> original commit.
>
> Introduce the "--reference" option to "git revert", and also the
> revert.reference configuration variable, which defaults to false, to
> tweak the title and the first line of the draft commit message for
> when creating a "revert" commit.

This is fantastic, I've wanted to fix this particular nit for a long
time.

> +static void refer_to_commit(struct replay_opts *opts,
> +			    struct strbuf *msgbuf, struct commit *commit)
> +{
> +	if (opts->commit_use_reference) {
> +		struct pretty_print_context ctx = {
> +			.abbrev = DEFAULT_ABBREV,
> +			.date_mode.type = DATE_SHORT,
> +		};
> +		format_commit_message(commit, "%h (%s, %ad)", msgbuf, &ctx);
> +	} else {
> +		strbuf_addstr(msgbuf, oid_to_hex(&commit->object.oid));
> +	}
> +}
> +
>  static int do_pick_commit(struct repository *r,
>  			  struct todo_item *item,
>  			  struct replay_opts *opts,
> @@ -2167,14 +2184,19 @@ static int do_pick_commit(struct repository *r,
>  		base_label = msg.label;
>  		next = parent;
>  		next_label = msg.parent_label;
> -		strbuf_addstr(&msgbuf, "Revert \"");
> -		strbuf_addstr(&msgbuf, msg.subject);
> -		strbuf_addstr(&msgbuf, "\"\n\nThis reverts commit ");
> -		strbuf_addstr(&msgbuf, oid_to_hex(&commit->object.oid));
> +		if (!opts->commit_use_reference) {
> +			strbuf_addstr(&msgbuf, "Revert \"");
> +			strbuf_addstr(&msgbuf, msg.subject);
> +			strbuf_addstr(&msgbuf, "\"");
> +		} else {
> +			strbuf_addstr(&msgbuf, "DESCRIBE WHY WE ARE REVERTING HERE");

Having seen how people use git in the wild, this *WILL* result in a
bunch of history where people don't edit that at all.

If we want them to edit something we should come up with a buffer that's
empty except for suggested #-commented parts, and suggest that they
uncomment/edit some of it.

I also use "git revert --no-edit" in my own workflow, e.g. when
reverting back and forth in WIP code, having the OID is useful, having
this new "reference" would be even better, but having that just in the
body and "DESCRIBE WHY..." in the %s would be much less useful.

> +		}
> +		strbuf_addstr(&msgbuf, "\n\nThis reverts commit ");
> +		refer_to_commit(opts, &msgbuf, commit);
>  
>  		if (commit->parents && commit->parents->next) {
>  			strbuf_addstr(&msgbuf, ", reversing\nchanges made to ");
> -			strbuf_addstr(&msgbuf, oid_to_hex(&parent->object.oid));
> +			refer_to_commit(opts, &msgbuf, parent);
>  		}
>  		strbuf_addstr(&msgbuf, ".\n");
>  	} else {

This is very POC, but I wish we had something like the WIP diff at the
end of this E-Mail (which is a mess, I was experimenting). I.e. we'd
always emit (when this setting is enabled)

    Revert %h (%s, %ad)

Except that the %s and the rest of the line would use the truncation
feature of "git log" formats, and would make sure the line isn't longer
than so-and-so, e.g. 72 or 50 characters.

Then only if we truncated things there, or we have parents to mention
would we add a body like:

    This reverts commit %h (%s, %ad)

Followed by "reversing changes..."

All of which would be much easier than the below monstrosity I came up
with if:

 1. You could ask "git log" formats to not whitespace pad the
    truncation, I couldn't find a way to do that (but it's the first
    time I use it).

 2. We just had some generic "wrap this buffer" function, maybe we do, I
    didn't look much.

> diff --git a/sequencer.h b/sequencer.h
> index da64473636..698599fe4e 100644
> --- a/sequencer.h
> +++ b/sequencer.h
> @@ -49,6 +49,7 @@ struct replay_opts {
>  	int reschedule_failed_exec;
>  	int committer_date_is_author_date;
>  	int ignore_date;
> +	int commit_use_reference;
>  
>  	int mainline;
>  
> diff --git a/t/t3501-revert-cherry-pick.sh b/t/t3501-revert-cherry-pick.sh
> index 8617efaaf1..36f9565b92 100755
> --- a/t/t3501-revert-cherry-pick.sh
> +++ b/t/t3501-revert-cherry-pick.sh
> @@ -159,6 +159,7 @@ test_expect_success 'cherry-pick works with dirty renamed file' '
>  '
>  
>  test_expect_success 'advice from failed revert' '
> +	test_when_finished "git reset --hard" &&
>  	test_commit --no-tag "add dream" dream dream &&
>  	dream_oid=$(git rev-parse --short HEAD) &&
>  	cat <<-EOF >expected &&
> @@ -174,4 +175,34 @@ test_expect_success 'advice from failed revert' '
>  	test_must_fail git revert HEAD^ 2>actual &&
>  	test_cmp expected actual
>  '
> +
> +test_expect_success 'identification of reverted commit (vanilla)' '
> +	test_commit to-ident &&
> +	test_when_finished "git reset --hard to-ident" &&
> +	git checkout --detach to-ident &&
> +	git revert --no-edit HEAD &&
> +	git cat-file commit HEAD >actual.raw &&
> +	grep "^This reverts " actual.raw >actual &&
> +	echo "This reverts commit $(git rev-parse HEAD^)." >expect &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'identification of reverted commit (reference)' '
> +	git checkout --detach to-ident &&
> +	git revert --reference --no-edit HEAD &&
> +	git cat-file commit HEAD >actual.raw &&
> +	grep "^This reverts " actual.raw >actual &&
> +	echo "This reverts commit $(git show -s --pretty=reference HEAD^)." >expect &&

This hides the exit code of the embedded $() git command.

Re the suggested changes below: let's just test_cmp the whole thing,
subject+body instead?

> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'identification of reverted commit (reference)' '
> +	git checkout --detach to-ident &&
> +	git -c revert.reference=true revert --no-edit HEAD &&
> +	git cat-file commit HEAD >actual.raw &&
> +	grep "^This reverts " actual.raw >actual &&
> +	echo "This reverts commit $(git show -s --pretty=reference HEAD^)." >expect &&
> +	test_cmp expect actual
> +'
> +
>  test_done


diff --git a/sequencer.c b/sequencer.c
index 4abb77add09..a43444e2339 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2061,18 +2061,14 @@ static int should_edit(struct replay_opts *opts) {
 	return opts->edit;
 }
 
-static void refer_to_commit(struct replay_opts *opts,
-			    struct strbuf *msgbuf, struct commit *commit)
-{
-	if (opts->commit_use_reference) {
-		struct pretty_print_context ctx = {
-			.abbrev = DEFAULT_ABBREV,
-			.date_mode.type = DATE_SHORT,
-		};
-		format_commit_message(commit, "%h (%s, %ad)", msgbuf, &ctx);
-	} else {
-		strbuf_addstr(msgbuf, oid_to_hex(&commit->object.oid));
-	}
+static void refer_to_commit(struct strbuf *sb, struct commit *commit,
+			    const char *const fmt)
+{
+	struct pretty_print_context ctx = {
+		.abbrev = DEFAULT_ABBREV,
+		.date_mode.type = DATE_SHORT,
+	};
+	format_commit_message(commit, fmt, sb, &ctx);
 }
 
 static int do_pick_commit(struct repository *r,
@@ -2183,19 +2179,63 @@ static int do_pick_commit(struct repository *r,
 		base_label = msg.label;
 		next = parent;
 		next_label = msg.parent_label;
-		if (!opts->commit_use_reference) {
+		if (opts->commit_use_reference) {
+			struct strbuf sb_b = STRBUF_INIT;
+			struct strbuf sb_h = STRBUF_INIT;
+			struct strbuf sb_ad = STRBUF_INIT;
+			struct strbuf sb_s = STRBUF_INIT;
+			struct strbuf sb_s_t = STRBUF_INIT;
+			const size_t wraplen = 72;
+			char *fmt;
+			size_t len = wraplen;
+			int truncated;
+
+			refer_to_commit(&sb_h, commit, "Revert %h (");
+			len -= sb_h.len;
+			refer_to_commit(&sb_ad, commit, "%ad)");
+			len -= sb_ad.len;
+			len -= 2 ; /* The ", " in: Revert %h (%s, %ad) */
+			/* vanilla %h (%s, %ad) */
+			refer_to_commit(&sb_s, commit, "%s");
+
+			/* truncated %h (%s, %ad) */
+			fmt = xstrfmt("%%<(%d,trunc)%%s", (int)len);
+			refer_to_commit(&sb_s_t, commit, fmt);
+			free(fmt);
+			strbuf_rtrim(&sb_s_t);
+
+			truncated = strcmp(sb_s.buf, sb_s_t.buf);
+
+			strbuf_addbuf(&msgbuf, &sb_h);
+			strbuf_addbuf(&msgbuf, &sb_s_t);
+			strbuf_addbuf(&msgbuf, &sb_ad);
+			strbuf_addstr(&msgbuf, "\n\n");
+
+			if (truncated) {
+				const char *pfx = "This reverts commit ";
+				size_t len = wraplen - strlen(pfx); /* TODO: Consider %h etc. */
+				char *fmt;
+				
+				fmt = xstrfmt("%s%%h (%%w(%d,0,0)%%s, %%ad)",
+					      pfx, (int)len);
+				refer_to_commit(&sb_b, commit, fmt);
+				free(fmt);
+				strbuf_addbuf(&msgbuf, &sb_b);
+			} else {
+				/* TODO: The not-truncated version ... */
+			}
+		} else {
 			strbuf_addstr(&msgbuf, "Revert \"");
 			strbuf_addstr(&msgbuf, msg.subject);
 			strbuf_addstr(&msgbuf, "\"");
-		} else {
-			strbuf_addstr(&msgbuf, "DESCRIBE WHY WE ARE REVERTING HERE");
-		}
-		strbuf_addstr(&msgbuf, "\n\nThis reverts commit ");
-		refer_to_commit(opts, &msgbuf, commit);
+			strbuf_addstr(&msgbuf, "\n\nThis reverts commit ");
+			strbuf_addstr(&msgbuf, oid_to_hex(&commit->object.oid));
 
-		if (commit->parents && commit->parents->next) {
-			strbuf_addstr(&msgbuf, ", reversing\nchanges made to ");
-			refer_to_commit(opts, &msgbuf, parent);
+			if (commit->parents && commit->parents->next) {
+				/* TODO: Handle the wrapping of this too... */
+				strbuf_addstr(&msgbuf, ", reversing\nchanges made to ");
+				strbuf_addstr(&msgbuf, oid_to_hex(&parent->object.oid));
+			}
 		}
 		strbuf_addstr(&msgbuf, ".\n");
 	} else {
