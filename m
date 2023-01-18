Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B3D3C38159
	for <git@archiver.kernel.org>; Wed, 18 Jan 2023 12:03:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbjARMDY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Jan 2023 07:03:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229883AbjARMCw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jan 2023 07:02:52 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D86FF48619
        for <git@vger.kernel.org>; Wed, 18 Jan 2023 03:20:12 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id bk15so24899305ejb.9
        for <git@vger.kernel.org>; Wed, 18 Jan 2023 03:20:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/+qkjmz/2ZS4oWHzmQ6eqZ4zW4yrrgLn/jLNcc33Vdg=;
        b=dAP5fkXvmFZiHkW+V+50Y8eU393nnJC7esUkKE5wAMvVcLKnwUH+M+Wh8r5g9r8G5b
         UPJ9x9aXjYmyzl8BewPVGl5cAYv4T/AsnxWj1rY0Oji7eNElgXaNnfU6cXeR8epmY4xJ
         Nk7K77yRboWlJeDbZlUjLL2z5fzyO2JtlmJXYFTc3eT2Aog2eaXFeHwmQ+HdNgb1V3ZB
         3lybWAi0ecvNm9Z/amsTr+ZGhXY67AF9PAEU9XzlDJPnYh/7aXJMta4mJUTa6bYEIioT
         kqW61ZLICPsRmYEYD/2+FV4mJyTde6B94//DtZqaTLcOKvPw1Pzs0xJ4OW2jj6ueNKT3
         I5Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/+qkjmz/2ZS4oWHzmQ6eqZ4zW4yrrgLn/jLNcc33Vdg=;
        b=tnj1f40sL6uPcDDY5S16651hCxX3fB/pzzDKsSMlp825S7DP0FyG3lH0Lq6pYB6yzU
         fMrQ23zkhj/rQ4xASy6J/H3DLpqJ0ZOhcAG/f1dtXC6ull+bkjuEs46K4w81/3PZU/yO
         MjJ1pvLH+BfvyE/X/hCTmN0lU92HAPbebYshLhgWjI3MdCaZAEo8xUzghImPO2/xAch2
         CD70V3xATn8ah1jUNtKydwRt1O4+a6Pv1RTYX9c5+PzjNE0LbKQ4Wdeqz0oY48AFk9ar
         y5MIyucMPrM1702zys2qY4Z0Wp60PEZcBSaP58Ej3WJNHPKnmLa0Pp6jN+MKx7T11hoK
         KFFw==
X-Gm-Message-State: AFqh2kppPSpF/fcNrY7O+RBTWnlgC3bmZP9XjGC49m5YTUeIqCrpGhks
        phdSjxGZn9kBa7/VNK/geM2bVDaFp9Zf8A==
X-Google-Smtp-Source: AMrXdXt15PznK9A6LzNXQzDGtfZzxpmHaCE9OiqQCzvd7TUDle9SlttHt4OEoUJO7Goa6VnPTE1RdQ==
X-Received: by 2002:a17:907:6281:b0:7c4:f752:e95c with SMTP id nd1-20020a170907628100b007c4f752e95cmr9380056ejc.1.1674040810917;
        Wed, 18 Jan 2023 03:20:10 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id k8-20020a1709062a4800b0083ffb81f01esm14456546eje.136.2023.01.18.03.20.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 03:20:10 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1pI6UD-002o4B-1e;
        Wed, 18 Jan 2023 12:20:09 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Matthew John Cheetham via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        M Hickford <mirth.hickford@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Glen Choo <chooglen@google.com>,
        Victoria Dye <vdye@github.com>,
        Matthew John Cheetham <mjcheetham@github.com>,
        Matthew John Cheetham <mjcheetham@outlook.com>
Subject: Re: [PATCH v6 06/12] test-http-server: add HTTP request parsing
Date:   Wed, 18 Jan 2023 12:14:55 +0100
References: <pull.1352.v5.git.1673475190.gitgitgadget@gmail.com>
 <pull.1352.v6.git.1674012618.gitgitgadget@gmail.com>
 <252098db219574527c587bc601565eab81b40c2c.1674012618.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 28.2; mu4e 1.9.0
In-reply-to: <252098db219574527c587bc601565eab81b40c2c.1674012618.git.gitgitgadget@gmail.com>
Message-ID: <230118.86bkmwxf6e.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Jan 18 2023, Matthew John Cheetham via GitGitGadget wrote:

> From: Matthew John Cheetham <mjcheetham@outlook.com>
>
> Add ability to parse HTTP requests to the test-http-server test helper.
>
> Signed-off-by: Matthew John Cheetham <mjcheetham@outlook.com>
> ---
>  t/helper/test-http-server.c | 175 +++++++++++++++++++++++++++++++++++-
>  1 file changed, 173 insertions(+), 2 deletions(-)
>
> diff --git a/t/helper/test-http-server.c b/t/helper/test-http-server.c
> index 6cdac223a55..36f4a54fe6d 100644
> --- a/t/helper/test-http-server.c
> +++ b/t/helper/test-http-server.c
> @@ -83,6 +83,42 @@ enum worker_result {
>  	WR_HANGUP   = 1<<1,
>  };
>  
> +/*
> + * Fields from a parsed HTTP request.
> + */
> +struct req {
> +	struct strbuf start_line;
> +
> +	const char *method;
> +	const char *http_version;
> +
> +	struct strbuf uri_path;
> +	struct strbuf query_args;
> +
> +	struct string_list header_list;
> +	const char *content_type;
> +	ssize_t content_length;
> +};
> +
> +#define REQ__INIT { \
> +	.start_line = STRBUF_INIT, \
> +	.uri_path = STRBUF_INIT, \
> +	.query_args = STRBUF_INIT, \
> +	.header_list = STRING_LIST_INIT_NODUP, \
> +	.content_type = NULL, \
> +	.content_length = -1 \
> +	}

Style nit: Don't indent the trailing "}", and add a "," after the last
"content_length" item.

We omit the comma by convention when there really should not be another
item, such as when we have a "NULL" terminator, here though we might add
a struct element at the end, so...

> +static enum worker_result req__read(struct req *req, int fd)
> +{
> +	struct strbuf h = STRBUF_INIT;
> +	struct string_list start_line_fields = STRING_LIST_INIT_DUP;
> +	int nr_start_line_fields;
> +	const char *uri_target;
> +	const char *query;
> +	char *hp;
> +	const char *hv;
> +
> +	enum worker_result result = WR_OK;
> +
> +	/*
> +	 * Read line 0 of the request and split it into component parts:
> +	 *
> +	 *    <method> SP <uri-target> SP <HTTP-version> CRLF
> +	 *
> +	 */
> +	if (strbuf_getwholeline_fd(&req->start_line, fd, '\n') == EOF) {
> +		result = WR_OK | WR_HANGUP;
> +		goto done;
> +	}
> +
> +	strbuf_trim_trailing_newline(&req->start_line);
> +
> +	nr_start_line_fields = string_list_split(&start_line_fields,
> +						 req->start_line.buf,
> +						 ' ', -1);
> +	if (nr_start_line_fields != 3) {
> +		logerror("could not parse request start-line '%s'",
> +			 req->start_line.buf);
> +		result = WR_IO_ERROR;
> +		goto done;
> +	}
> +
> +	req->method = xstrdup(start_line_fields.items[0].string);
> +	req->http_version = xstrdup(start_line_fields.items[2].string);
> +
> +	uri_target = start_line_fields.items[1].string;
> +
> +	if (strcmp(req->http_version, "HTTP/1.1")) {
> +		logerror("unsupported version '%s' (expecting HTTP/1.1)",
> +			 req->http_version);
> +		result = WR_IO_ERROR;
> +		goto done;
> +	}
> +
> +	query = strchr(uri_target, '?');
> +
> +	if (query) {
> +		strbuf_add(&req->uri_path, uri_target, (query - uri_target));
> +		strbuf_trim_trailing_dir_sep(&req->uri_path);
> +		strbuf_addstr(&req->query_args, query + 1);
> +	} else {
> +		strbuf_addstr(&req->uri_path, uri_target);
> +		strbuf_trim_trailing_dir_sep(&req->uri_path);
> +	}
> +
> +	/*
> +	 * Read the set of HTTP headers into a string-list.
> +	 */
> +	while (1) {
> +		if (strbuf_getwholeline_fd(&h, fd, '\n') == EOF)
> +			goto done;
> +		strbuf_trim_trailing_newline(&h);
> +
> +		if (!h.len)
> +			goto done; /* a blank line ends the header */
> +
> +		hp = strbuf_detach(&h, NULL);
> +		string_list_append(&req->header_list, hp);
> +
> +		/* also store common request headers as struct req members */
> +		if (skip_prefix(hp, "Content-Type: ", &hv)) {
> +			req->content_type = hv;
> +		} else if (skip_prefix(hp, "Content-Length: ", &hv)) {
> +			req->content_length = strtol(hv, &hp, 10);

In POSIX the "ssize_t" is not a "this is the unsigned size_t", but can
be a much smaller integer type (although in practice it tends to be the
signed version of "size_t".

But this seems like a potential overflow trap as a result, but sometimes
we need to live with "ssize_t".

However, in this case it seems like we don't, as it seems the only
reason you init'd this to -1 and then...

> +	if (trace2_is_enabled()) {
> +		struct string_list_item *item;
> +		trace2_printf("%s: %s", TR2_CAT, req->start_line.buf);
> +		trace2_printf("%s: hver: %s", TR2_CAT, req->http_version);
> +		trace2_printf("%s: hmth: %s", TR2_CAT, req->method);
> +		trace2_printf("%s: path: %s", TR2_CAT, req->uri_path.buf);
> +		trace2_printf("%s: qury: %s", TR2_CAT, req->query_args.buf);
> +		if (req->content_length >= 0)
> +			trace2_printf("%s: clen: %d", TR2_CAT, req->content_length);

...use that ">= 0" is to keep the state of "did I assign to this above?

So firstly, shouldn't we error or something on a "Content-Length: 0",
and aside from that wouldn't we just have a "int have_content_length =
0" in this function that we'd then flip to 1?
