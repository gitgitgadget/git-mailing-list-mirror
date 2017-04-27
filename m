Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 79D731FC3E
	for <e@80x24.org>; Thu, 27 Apr 2017 05:00:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934436AbdD0FAU (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Apr 2017 01:00:20 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:35580 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933955AbdD0FAS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Apr 2017 01:00:18 -0400
Received: by mail-pf0-f193.google.com with SMTP id a188so5984080pfa.2
        for <git@vger.kernel.org>; Wed, 26 Apr 2017 22:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=fAKay1VanpkTYU/BtyHi59DwHqtpH1CcR9OxHY10UO0=;
        b=LJLonlrtuUTgMAF/44AVH83cxCEF3DMQhlMIwqkjnSnEQ2RyVYyfJ8Jh9aVD8AZmO5
         1C6JydJ2a5QaYhvluNPtO7SBJnKnbsUaQuakzLt6QsU+CENB8d3ChJKP9n59c7oDRHKY
         Qu/3dxAmLXzBgNYdgwm1p3yqeOv4FHLzhUd/bpunGulwRKwBBP2Q1imQZrFQ/hJbkjnW
         +6IuAJrVDT8dV7JlD7hTerSEklDygFB19gnMGQNRo5U4KPMtR6bcf1JicdxSBmclm81b
         ro5+/xrYPZ3UwQRKdDj3I00Ji1f33Ak+J3+baLnJlNgN8IIdAwPDITeKtyOHfUGyjxEQ
         MSrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=fAKay1VanpkTYU/BtyHi59DwHqtpH1CcR9OxHY10UO0=;
        b=lz2s5Vjt9EtMRy1tzKUVQHCHJxVJzrOJAT6ErR2Ve8iElXtLKBKzU57jEfdqVMrDyF
         ETeWYNliUO73z6BelQ9JELthzX7fCgDBW86RsF+AP8p4+dEh+TAEVmqvMHt9BpRj7Lu4
         OQ0K6UMbzuU/YCHQaJTlLErlrUSMB5b3JMKk1mGxKYeaDDsRXW55WoRtiV4oeL65HkcB
         Bfs1/5st6I/eTbRV+rNgMa1zulIp/7cQEUoNtxbBc7787Vyb5AOL879PB8OnTnISJRyi
         +R/GCmXzg/yLV0uDt4NuGhRYGCOMYwj/44IDTEcaPSbw7gz3F9fBsIhFUGCsmN+JjE87
         yhhw==
X-Gm-Message-State: AN3rC/7II3xgvXAXZuwRW1N3D0R0buNHoXxYsYJOAYbqMZcKJu0vLuhz
        fQzuB3HhPNIPnQ==
X-Received: by 10.84.238.194 with SMTP id l2mr4559803pln.7.1493269217834;
        Wed, 26 Apr 2017 22:00:17 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:d550:ca2:cfe6:6d97])
        by smtp.gmail.com with ESMTPSA id x2sm1615125pfi.80.2017.04.26.22.00.16
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 26 Apr 2017 22:00:17 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Philip Oakley <philipoakley@iee.org>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 4/9] rebase -i: also expand/collapse the SHA-1s via the rebase--helper
References: <cover.1493128210.git.johannes.schindelin@gmx.de>
        <cover.1493207864.git.johannes.schindelin@gmx.de>
        <df5263cc0cad5cffbd1932d4b9b8e5c0507536e6.1493207864.git.johannes.schindelin@gmx.de>
Date:   Wed, 26 Apr 2017 22:00:16 -0700
In-Reply-To: <df5263cc0cad5cffbd1932d4b9b8e5c0507536e6.1493207864.git.johannes.schindelin@gmx.de>
        (Johannes Schindelin's message of "Wed, 26 Apr 2017 13:59:23 +0200
        (CEST)")
Message-ID: <xmqqr30eo36n.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
> index 214af0372ba..52a19e0bdb3 100644
> --- a/git-rebase--interactive.sh
> +++ b/git-rebase--interactive.sh
> @@ -774,11 +774,11 @@ transform_todo_ids () {
>  }
>  
>  expand_todo_ids() {
> -	transform_todo_ids
> +	git rebase--helper --expand-sha1s
>  }
>  
>  collapse_todo_ids() {
> -	transform_todo_ids --short
> +	git rebase--helper --shorten-sha1s
>  }

Obviously correct ;-)  But doesn't this make transform_todo_ids ()
helper unused and removable?

> +int transform_todo_ids(int shorten_sha1s)
> +{
> +	const char *todo_file = rebase_path_todo();
> +	struct todo_list todo_list = TODO_LIST_INIT;
> +	int fd, res, i;
> +	FILE *out;
> +
> +	strbuf_reset(&todo_list.buf);
> +	fd = open(todo_file, O_RDONLY);
> +	if (fd < 0)
> +		return error_errno(_("could not open '%s'"), todo_file);
> +	if (strbuf_read(&todo_list.buf, fd, 0) < 0) {
> +		close(fd);
> +		return error(_("could not read '%s'."), todo_file);
> +	}
> +	close(fd);
> +
> +	res = parse_insn_buffer(todo_list.buf.buf, &todo_list);
> +	if (res) {
> +		todo_list_release(&todo_list);
> +		return error(_("unusable instruction sheet: '%s'"), todo_file);
> +	}
> +
> +	out = fopen(todo_file, "w");

The usual "open lockfile, write to it and then rename" dance is not
necessary for the purpose of preventing other people from reading
this file while we are writing to it.  But if we fail inside this
function before we fclose(3) "out", the user will lose the todo
list.  It probably is not a big deal, though.

> +	if (!out) {
> +		todo_list_release(&todo_list);
> +		return error(_("unable to open '%s' for writing"), todo_file);
> +	}
> +	for (i = 0; i < todo_list.nr; i++) {
> +		struct todo_item *item = todo_list.items + i;
> +		int bol = item->offset_in_buf;
> +		const char *p = todo_list.buf.buf + bol;
> +		int eol = i + 1 < todo_list.nr ?
> +			todo_list.items[i + 1].offset_in_buf :
> +			todo_list.buf.len;
> +
> +		if (item->command >= TODO_EXEC && item->command != TODO_DROP)
> +			fwrite(p, eol - bol, 1, out);
> +		else {
> +			int eoc = strcspn(p, " \t");
> +			const char *sha1 = shorten_sha1s ?
> +				short_commit_name(item->commit) :
> +				oid_to_hex(&item->commit->object.oid);
> +
> +			if (!eoc) {
> +				p += strspn(p, " \t");
> +				eoc = strcspn(p, " \t");
> +			}

It would be much easier to follow the logic if "int eoc" above were
a mere declaration without initialization and "skip to the
whitespaces" is done immediately before this if() statement.  It's
not like the initialized value of eoc is needed there because it
participates in the computation of sha1, and also having the
assignment followed by "oops, the line begins with a whitespace"
recovery that is done here.

Wouldn't it be simpler to do:

	else {
		int eoc;
		const char *sha1 = ...
		p += strspn(p, " \t"); /* skip optional indent */
		eoc = strcspn(p, " \t"); /* grab the command word */

without conditional?

> +			fprintf(out, "%.*s %s %.*s\n",
> +				eoc, p, sha1, item->arg_len, item->arg);
> +		}
> +	}
> +	fclose(out);
> +	todo_list_release(&todo_list);
> +	return 0;
> +}
> diff --git a/sequencer.h b/sequencer.h
> index 83f2943b7a9..47a81034e76 100644
> --- a/sequencer.h
> +++ b/sequencer.h
> @@ -48,6 +48,8 @@ int sequencer_remove_state(struct replay_opts *opts);
>  int sequencer_make_script(int keep_empty, FILE *out,
>  		int argc, const char **argv);
>  
> +int transform_todo_ids(int shorten_sha1s);
> +
>  extern const char sign_off_header[];
>  
>  void append_signoff(struct strbuf *msgbuf, int ignore_footer, unsigned flag);
