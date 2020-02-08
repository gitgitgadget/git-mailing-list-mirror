Return-Path: <SRS0=24Vd=34=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D46B3C35242
	for <git@archiver.kernel.org>; Sat,  8 Feb 2020 23:08:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A51320658
	for <git@archiver.kernel.org>; Sat,  8 Feb 2020 23:08:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="JHd6TVdj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727073AbgBHXIF (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 8 Feb 2020 18:08:05 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:34973 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727517AbgBHXIF (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Feb 2020 18:08:05 -0500
Received: by mail-pf1-f194.google.com with SMTP id y73so1705736pfg.2
        for <git@vger.kernel.org>; Sat, 08 Feb 2020 15:08:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=hQDuGU1rnFqaO6H8Ybq7/stfc3sniRPONnypxAbCkUU=;
        b=JHd6TVdjeoX0fJekAWs2UAieZECdAs0LekJsiRTMebXum0jCtuT4pP3xttAPteNJuQ
         KW0rcCWUHnX+/j0OG5b94Fh9dIU7edg1BkM88JTipWX0RQPZzht2UMg4eaZ8cnEq+ddi
         XuAYK+mfpF1T9rDuwIgzEfeG8BOwiyfY4ii8LlhoFSHlsQHrDpDvB02Qz7w8KYhs3MvN
         8W+t2TqXkb24nzoM/NpOK62w5ucouusz7NOX2Cubm2+t51ECCX0mnZMbcfxu/vZGnR82
         FO3FSo69mLbmvCj/TqqE3fWXME7QLEOu6rykwuFIpgN7jQSRCZBPLT+9zOQI80Nn7s4H
         u6kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=hQDuGU1rnFqaO6H8Ybq7/stfc3sniRPONnypxAbCkUU=;
        b=K6AXcXSTdUX5VJnPh9H+Ipl8YdlPUyC8s06X060FoTgTRGesi9kyrLvBrUtnEy/KLZ
         lS3nJinY6tujEbzp62QPcz+516irjCxS8IF8N4j/xz9+Jwn0tLoosh8y4K+pkooDEPqX
         ZFiMmJjKZKSTrphG4Ix7UnY5AQ7ROIvXYc9qjJiC+DrNPK6eeBkDfVlcarIjO82viKst
         QbV7fBazby0gzIfmOpyj8q0w3w5xgsioV1WF+cH8pu8wqaZPlEfD07B8HH3Y2dAXOksa
         Et2VS2bGCLXPRL7oBITUZTUD5l15lQSK48h3qhKRFDYJgmRyYkIy5QI3DDereBYLkjYn
         TQ2g==
X-Gm-Message-State: APjAAAWedbECAeoZwjw1/awP2c6QU6UPp7DVYmW0V3NRdy+K4yIgbVcH
        KI1PggMhExKX5cl7xV3I6GXwmw==
X-Google-Smtp-Source: APXvYqzw5wd9/HvCcWcHEfnk3R5N2aicpDkUIukuVUTxeZDsJ4oc7nQlB9+XneGWKnBGy8clkLcc2g==
X-Received: by 2002:a62:2ccd:: with SMTP id s196mr6106134pfs.227.1581203282885;
        Sat, 08 Feb 2020 15:08:02 -0800 (PST)
Received: from localhost ([2601:602:9200:32b0:dc02:8cc6:46f8:4fa])
        by smtp.gmail.com with ESMTPSA id b98sm7076830pjc.16.2020.02.08.15.08.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Feb 2020 15:08:02 -0800 (PST)
Date:   Sat, 8 Feb 2020 15:08:01 -0800
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] strbuf: add and use strbuf_insertstr()
Message-ID: <20200208230801.GA33529@syl.local>
References: <019be197-e0aa-1234-e16f-6561d8340023@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <019be197-e0aa-1234-e16f-6561d8340023@web.de>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi René,

On Sat, Feb 08, 2020 at 08:56:43PM +0100, René Scharfe wrote:
> Add a function for inserting a C string into a strbuf.  Use it
> throughout the source to get rid of magic string length constants and
> explicit strlen() calls.
>
> Like strbuf_addstr(), implement it as an inline function to avoid the
> implicit strlen() calls to cause runtime overhead.

This all looks quite reasonable to me. Did you have a specific
motivation in mind when writing this patch, other than to get rid of
having to call strlen on the same argument like:

  strbuf_insert(&buf, pos, x, strlen(x))

? Not that this needs more motivation than that, I'm just curious.

I looked through 'git grep strbuf_insert(', and only noticed one spot
that I could be updated with 'strbuf_insertstr' in mailinfo.c:

diff --git a/mailinfo.c b/mailinfo.c
index c535dec2e9..543962d40c 100644
--- a/mailinfo.c
+++ b/mailinfo.c
@@ -570,7 +570,7 @@ static int check_header(struct mailinfo *mi,
    len = strlen("Content-Type: ");
    strbuf_add(&sb, line->buf + len, line->len - len);
    decode_header(mi, &sb);
-		strbuf_insert(&sb, 0, "Content-Type: ", len);
+		strbuf_insertstr(&sb, 0, "Content-Type: ");
    handle_content_type(mi, &sb);
    ret = 1;
    goto check_header_out;

Otherwise this looks quite good to me.

>
> Signed-off-by: René Scharfe <l.s.r@web.de>
> ---
>  builtin/checkout.c        |  2 +-
>  builtin/notes.c           |  4 ++--
>  builtin/sparse-checkout.c |  2 +-
>  commit.c                  |  2 +-
>  config.c                  |  2 +-
>  http.c                    |  4 ++--
>  mailinfo.c                |  2 +-
>  notes-utils.c             |  2 +-
>  notes.c                   |  4 ++--
>  pretty.c                  |  4 ++--
>  strbuf.h                  | 12 ++++++++++++
>  11 files changed, 26 insertions(+), 14 deletions(-)
>
> diff --git a/builtin/checkout.c b/builtin/checkout.c
> index fc2eb1befc..d6773818b8 100644
> --- a/builtin/checkout.c
> +++ b/builtin/checkout.c
> @@ -865,7 +865,7 @@ static void update_refs_for_switch(const struct checkout_opts *opts,
>  		strbuf_addf(&msg, "checkout: moving from %s to %s",
>  			old_desc ? old_desc : "(invalid)", new_branch_info->name);
>  	else
> -		strbuf_insert(&msg, 0, reflog_msg, strlen(reflog_msg));
> +		strbuf_insertstr(&msg, 0, reflog_msg);
>
>  	if (!strcmp(new_branch_info->name, "HEAD") && !new_branch_info->path && !opts->force_detach) {
>  		/* Nothing to do. */
> diff --git a/builtin/notes.c b/builtin/notes.c
> index 95456f3165..35e468ea2d 100644
> --- a/builtin/notes.c
> +++ b/builtin/notes.c
> @@ -622,7 +622,7 @@ static int append_edit(int argc, const char **argv, const char *prefix)
>
>  		strbuf_grow(&d.buf, size + 1);
>  		if (d.buf.len && prev_buf && size)
> -			strbuf_insert(&d.buf, 0, "\n", 1);
> +			strbuf_insertstr(&d.buf, 0, "\n");
>  		if (prev_buf && size)
>  			strbuf_insert(&d.buf, 0, prev_buf, size);
>  		free(prev_buf);
> @@ -745,7 +745,7 @@ static int merge_commit(struct notes_merge_options *o)
>  	memset(&pretty_ctx, 0, sizeof(pretty_ctx));
>  	format_commit_message(partial, "%s", &msg, &pretty_ctx);
>  	strbuf_trim(&msg);
> -	strbuf_insert(&msg, 0, "notes: ", 7);
> +	strbuf_insertstr(&msg, 0, "notes: ");
>  	update_ref(msg.buf, o->local_ref, &oid,
>  		   is_null_oid(&parent_oid) ? NULL : &parent_oid,
>  		   0, UPDATE_REFS_DIE_ON_ERR);
> diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
> index b3bed891cb..38d0d944b3 100644
> --- a/builtin/sparse-checkout.c
> +++ b/builtin/sparse-checkout.c
> @@ -373,7 +373,7 @@ static void strbuf_to_cone_pattern(struct strbuf *line, struct pattern_list *pl)
>  		return;
>
>  	if (line->buf[0] != '/')
> -		strbuf_insert(line, 0, "/", 1);
> +		strbuf_insertstr(line, 0, "/");
>
>  	insert_recursive_pattern(pl, line);
>  }
> diff --git a/commit.c b/commit.c
> index 3f91d3efc5..a6cfa41a4e 100644
> --- a/commit.c
> +++ b/commit.c
> @@ -993,7 +993,7 @@ static int do_sign_commit(struct strbuf *buf, const char *keyid)
>  			strbuf_insert(buf, inspos, gpg_sig_header, gpg_sig_header_len);
>  			inspos += gpg_sig_header_len;
>  		}
> -		strbuf_insert(buf, inspos++, " ", 1);
> +		strbuf_insertstr(buf, inspos++, " ");
>  		strbuf_insert(buf, inspos, bol, len);
>  		inspos += len;
>  		copypos += len;
> diff --git a/config.c b/config.c
> index d75f88ca0c..b386c0c628 100644
> --- a/config.c
> +++ b/config.c
> @@ -204,7 +204,7 @@ static int prepare_include_condition_pattern(struct strbuf *pat)
>  		strbuf_splice(pat, 0, 1, path.buf, slash - path.buf);
>  		prefix = slash - path.buf + 1 /* slash */;
>  	} else if (!is_absolute_path(pat->buf))
> -		strbuf_insert(pat, 0, "**/", 3);
> +		strbuf_insertstr(pat, 0, "**/");
>
>  	add_trailing_starstar_for_dir(pat);
>
> diff --git a/http.c b/http.c
> index 5f348169c3..00a0e50763 100644
> --- a/http.c
> +++ b/http.c
> @@ -680,8 +680,8 @@ static void curl_dump_header(const char *text, unsigned char *ptr, size_t size,
>  	for (header = headers; *header; header++) {
>  		if (hide_sensitive_header)
>  			redact_sensitive_header(*header);
> -		strbuf_insert((*header), 0, text, strlen(text));
> -		strbuf_insert((*header), strlen(text), ": ", 2);
> +		strbuf_insertstr((*header), 0, text);
> +		strbuf_insertstr((*header), strlen(text), ": ");
>  		strbuf_rtrim((*header));
>  		strbuf_addch((*header), '\n');
>  		trace_strbuf(&trace_curl, (*header));
> diff --git a/mailinfo.c b/mailinfo.c
> index b395adbdf2..c535dec2e9 100644
> --- a/mailinfo.c
> +++ b/mailinfo.c
> @@ -254,7 +254,7 @@ static void handle_content_type(struct mailinfo *mi, struct strbuf *line)
>  	mi->delsp = has_attr_value(line->buf, "delsp=", "yes");
>
>  	if (slurp_attr(line->buf, "boundary=", boundary)) {
> -		strbuf_insert(boundary, 0, "--", 2);
> +		strbuf_insertstr(boundary, 0, "--");
>  		if (++mi->content_top >= &mi->content[MAX_BOUNDARIES]) {
>  			error("Too many boundaries to handle");
>  			mi->input_error = -1;
> diff --git a/notes-utils.c b/notes-utils.c
> index a819410698..5f94c513d4 100644
> --- a/notes-utils.c
> +++ b/notes-utils.c
> @@ -52,7 +52,7 @@ void commit_notes(struct repository *r, struct notes_tree *t, const char *msg)
>  	strbuf_complete_line(&buf);
>
>  	create_notes_commit(r, t, NULL, buf.buf, buf.len, &commit_oid);
> -	strbuf_insert(&buf, 0, "notes: ", 7); /* commit message starts at index 7 */
> +	strbuf_insertstr(&buf, 0, "notes: "); /* commit message starts at index 7 */
>  	update_ref(buf.buf, t->update_ref, &commit_oid, NULL, 0,
>  		   UPDATE_REFS_DIE_ON_ERR);
>
> diff --git a/notes.c b/notes.c
> index 0c79964c26..a24af53de6 100644
> --- a/notes.c
> +++ b/notes.c
> @@ -1332,9 +1332,9 @@ void expand_notes_ref(struct strbuf *sb)
>  	if (starts_with(sb->buf, "refs/notes/"))
>  		return; /* we're happy */
>  	else if (starts_with(sb->buf, "notes/"))
> -		strbuf_insert(sb, 0, "refs/", 5);
> +		strbuf_insertstr(sb, 0, "refs/");
>  	else
> -		strbuf_insert(sb, 0, "refs/notes/", 11);
> +		strbuf_insertstr(sb, 0, "refs/notes/");
>  }
>
>  void expand_loose_notes_ref(struct strbuf *sb)
> diff --git a/pretty.c b/pretty.c
> index f5fbbc5ffb..28afc701b6 100644
> --- a/pretty.c
> +++ b/pretty.c
> @@ -1609,9 +1609,9 @@ static size_t format_commit_item(struct strbuf *sb, /* in UTF-8 */
>  			strbuf_setlen(sb, sb->len - 1);
>  	} else if (orig_len != sb->len) {
>  		if (magic == ADD_LF_BEFORE_NON_EMPTY)
> -			strbuf_insert(sb, orig_len, "\n", 1);
> +			strbuf_insertstr(sb, orig_len, "\n");
>  		else if (magic == ADD_SP_BEFORE_NON_EMPTY)
> -			strbuf_insert(sb, orig_len, " ", 1);
> +			strbuf_insertstr(sb, orig_len, " ");
>  	}
>  	return consumed + 1;
>  }
> diff --git a/strbuf.h b/strbuf.h
> index bfa66569a4..aae7ac3a82 100644
> --- a/strbuf.h
> +++ b/strbuf.h
> @@ -244,6 +244,18 @@ void strbuf_addchars(struct strbuf *sb, int c, size_t n);
>   */
>  void strbuf_insert(struct strbuf *sb, size_t pos, const void *, size_t);
>
> +/**
> + * Insert a NUL-terminated string to the given position of the buffer.
> + * The remaining contents will be shifted, not overwritten.  It's an
> + * inline function to allow the compiler to resolve strlen() calls on
> + * constants at compile time.
> + */
> +static inline void strbuf_insertstr(struct strbuf *sb, size_t pos,
> +				    const char *s)
> +{
> +	strbuf_insert(sb, pos, s, strlen(s));
> +}
> +
>  /**
>   * Insert data to the given position of the buffer giving a printf format
>   * string. The contents will be shifted, not overwritten.
> --
> 2.25.0
>

Thanks,
Taylor
