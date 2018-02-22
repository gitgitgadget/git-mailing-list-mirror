Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3AA671F404
	for <e@80x24.org>; Thu, 22 Feb 2018 20:57:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751270AbeBVU5y (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Feb 2018 15:57:54 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:37458 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751119AbeBVU5x (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Feb 2018 15:57:53 -0500
Received: by mail-wm0-f68.google.com with SMTP id m207so891791wma.2
        for <git@vger.kernel.org>; Thu, 22 Feb 2018 12:57:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=1pfP0d5pvJ2X6O5BDJyj1vF3NdPWvDcAtj3q+leva10=;
        b=Reng7LsqOxgnIbBEpjyWOBOhrD1MNiNy5vv28NPDuTjiTTDIypIBBBNSXTbc6ytSai
         22P28Ge1iQIAk6BcrIhp9OfvOA7hfwwdoCfntnEr6kHCPK8ppGoRf5cFSRDN63RT3RFo
         axzVZhwN64tU6gqDsZmENbyIumQgjAlBe0t6BOuQTdSKG6vevOSecmEZbvfSsBtnMqAo
         Y5rY2s/qMTzvFQHf393Z/r741zPldYAYtwb1s6MgzwCOZq7OYHf78O4jGs9hvTVapKW7
         /ipo4Ed13NMGN1r3w+wmo9hMjN/bqxmZMwOqWs0d9Rrj+vUaDBGxj9VhKYTaYuG5MyMc
         uWHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=1pfP0d5pvJ2X6O5BDJyj1vF3NdPWvDcAtj3q+leva10=;
        b=DAGXar5fdpwJ6bLsXLt5iwVwOw0XDcy3bxSh2b86AdP2CbUDxQJp72PYwOjlKTp4pu
         Jk5dtQ7QMAPyswlDNDjrx6G84ekHxgly4hbyk/aPZ5/k+84QH3UD8Ll2OKoiiu1ga8H0
         kiCDEqggDnKaJbYQMsMDiQfRvKQkhluEiTiN++PmvE98TxSYKm66M7hWhJfRCFkONgHO
         38kdrDMC+92oIiUvbaPUdNKqiHNZZBHRSUNM/yTgU6eFSgYGicdkbRFO3U7WGSjwr//P
         yVrjuZcgF/Rg/WDoKDtsP/SF/EyRncASXemhWSTDJ2A3DMSt1sNvYLF5lKzIknk8/DFv
         KZqw==
X-Gm-Message-State: APf1xPDxcBupeokatXtU/NhEizgd75+8qaQyZ/OZFg4HY+2kDObAJhVM
        7dricW+q2GU5FdOt3rumMLE=
X-Google-Smtp-Source: AG47ELt9c5bvDE5c47K4WvFggjBZFCjdTUDoDZ3qh6zSQopmgFu+YIBIuC7YfOf/3ghm/Qfs1YPEVg==
X-Received: by 10.28.184.8 with SMTP id i8mr432072wmf.52.1519333071573;
        Thu, 22 Feb 2018 12:57:51 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id 72sm305965wmh.44.2018.02.22.12.57.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 22 Feb 2018 12:57:50 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] sequencer: factor out strbuf_read_file_or_whine()
References: <6b58885c-b0f6-1687-3f2d-4594aacff9ac@web.de>
Date:   Thu, 22 Feb 2018 12:57:50 -0800
In-Reply-To: <6b58885c-b0f6-1687-3f2d-4594aacff9ac@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Thu, 22 Feb 2018 20:29:25 +0100")
Message-ID: <xmqqlgfkvj1t.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

René Scharfe <l.s.r@web.de> writes:

> Reduce code duplication by factoring out a function that reads an entire
> file into a strbuf, or reports errors on stderr if something goes wrong.
>
> Signed-off-by: Rene Scharfe <l.s.r@web.de>
> ---
> The difference to using strbuf_read_file() is more detailed error
> messages for open(2) failures.  But I don't know if we need them -- or
> under which circumstances reading todo files could fail anyway.  When
> doing multiple rebases in parallel perhaps?
>
>  sequencer.c | 74 +++++++++++++++++++++++--------------------------------------
>  1 file changed, 28 insertions(+), 46 deletions(-)
>
> diff --git a/sequencer.c b/sequencer.c
> index e9baaf59bd..e34334f0ef 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -1869,22 +1869,31 @@ static int count_commands(struct todo_list *todo_list)
>  	return count;
>  }
>  
> +static ssize_t strbuf_read_file_or_whine(struct strbuf *sb, const char *path)
> +{
> +	int fd;
> +	ssize_t len;
> +
> +	fd = open(path, O_RDONLY);
> +	if (fd < 0)
> +		return error_errno(_("could not open '%s'"), path);
> +	len = strbuf_read(sb, fd, 0);
> +	close(fd);
> +	if (len < 0)
> +		return error(_("could not read '%s'."), path);
> +	return len;
> +}
> +

This looks like a good granularity of a unit of independent work.
The original we see below looks like it was written with scissors
and glue ;-)

It appears to me that no topic in flight introduce more instances
that need to be converted with a quick trial merge to 'pu', so I'll
queue this forked at the tip of 'master'.

Thanks.

>  static int read_populate_todo(struct todo_list *todo_list,
>  			struct replay_opts *opts)
>  {
>  	struct stat st;
>  	const char *todo_file = get_todo_path(opts);
> -	int fd, res;
> +	int res;
>  
>  	strbuf_reset(&todo_list->buf);
> -	fd = open(todo_file, O_RDONLY);
> -	if (fd < 0)
> -		return error_errno(_("could not open '%s'"), todo_file);
> -	if (strbuf_read(&todo_list->buf, fd, 0) < 0) {
> -		close(fd);
> -		return error(_("could not read '%s'."), todo_file);
> -	}
> -	close(fd);
> +	if (strbuf_read_file_or_whine(&todo_list->buf, todo_file) < 0)
> +		return -1;
>  
>  	res = stat(todo_file, &st);
>  	if (res)
> @@ -3151,20 +3160,13 @@ int check_todo_list(void)
>  	struct strbuf todo_file = STRBUF_INIT;
>  	struct todo_list todo_list = TODO_LIST_INIT;
>  	struct strbuf missing = STRBUF_INIT;
> -	int advise_to_edit_todo = 0, res = 0, fd, i;
> +	int advise_to_edit_todo = 0, res = 0, i;
>  
>  	strbuf_addstr(&todo_file, rebase_path_todo());
> -	fd = open(todo_file.buf, O_RDONLY);
> -	if (fd < 0) {
> -		res = error_errno(_("could not open '%s'"), todo_file.buf);
> -		goto leave_check;
> -	}
> -	if (strbuf_read(&todo_list.buf, fd, 0) < 0) {
> -		close(fd);
> -		res = error(_("could not read '%s'."), todo_file.buf);
> +	if (strbuf_read_file_or_whine(&todo_list.buf, todo_file.buf) < 0) {
> +		res = -1;
>  		goto leave_check;
>  	}
> -	close(fd);
>  	advise_to_edit_todo = res =
>  		parse_insn_buffer(todo_list.buf.buf, &todo_list);
>  
> @@ -3180,17 +3182,10 @@ int check_todo_list(void)
>  
>  	todo_list_release(&todo_list);
>  	strbuf_addstr(&todo_file, ".backup");
> -	fd = open(todo_file.buf, O_RDONLY);
> -	if (fd < 0) {
> -		res = error_errno(_("could not open '%s'"), todo_file.buf);
> -		goto leave_check;
> -	}
> -	if (strbuf_read(&todo_list.buf, fd, 0) < 0) {
> -		close(fd);
> -		res = error(_("could not read '%s'."), todo_file.buf);
> +	if (strbuf_read_file_or_whine(&todo_list.buf, todo_file.buf) < 0) {
> +		res = -1;
>  		goto leave_check;
>  	}
> -	close(fd);
>  	strbuf_release(&todo_file);
>  	res = !!parse_insn_buffer(todo_list.buf.buf, &todo_list);
>  
> @@ -3271,15 +3266,8 @@ int skip_unnecessary_picks(void)
>  	}
>  	strbuf_release(&buf);
>  
> -	fd = open(todo_file, O_RDONLY);
> -	if (fd < 0) {
> -		return error_errno(_("could not open '%s'"), todo_file);
> -	}
> -	if (strbuf_read(&todo_list.buf, fd, 0) < 0) {
> -		close(fd);
> -		return error(_("could not read '%s'."), todo_file);
> -	}
> -	close(fd);
> +	if (strbuf_read_file_or_whine(&todo_list.buf, todo_file) < 0)
> +		return -1;
>  	if (parse_insn_buffer(todo_list.buf.buf, &todo_list) < 0) {
>  		todo_list_release(&todo_list);
>  		return -1;
> @@ -3370,17 +3358,11 @@ int rearrange_squash(void)
>  	const char *todo_file = rebase_path_todo();
>  	struct todo_list todo_list = TODO_LIST_INIT;
>  	struct hashmap subject2item;
> -	int res = 0, rearranged = 0, *next, *tail, fd, i;
> +	int res = 0, rearranged = 0, *next, *tail, i;
>  	char **subjects;
>  
> -	fd = open(todo_file, O_RDONLY);
> -	if (fd < 0)
> -		return error_errno(_("could not open '%s'"), todo_file);
> -	if (strbuf_read(&todo_list.buf, fd, 0) < 0) {
> -		close(fd);
> -		return error(_("could not read '%s'."), todo_file);
> -	}
> -	close(fd);
> +	if (strbuf_read_file_or_whine(&todo_list.buf, todo_file) < 0)
> +		return -1;
>  	if (parse_insn_buffer(todo_list.buf.buf, &todo_list) < 0) {
>  		todo_list_release(&todo_list);
>  		return -1;
