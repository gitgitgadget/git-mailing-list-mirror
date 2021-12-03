Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB330C433F5
	for <git@archiver.kernel.org>; Fri,  3 Dec 2021 13:41:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381209AbhLCNov (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Dec 2021 08:44:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381200AbhLCNom (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Dec 2021 08:44:42 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DFDDC06173E
        for <git@vger.kernel.org>; Fri,  3 Dec 2021 05:41:18 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id l25so11566012eda.11
        for <git@vger.kernel.org>; Fri, 03 Dec 2021 05:41:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=M7swm+nG7z3utSFw6qWZEc+yWDv4Q0TmDBXXgEpR0mE=;
        b=O1h8K4qO6jrTDbkZz0/R0tGJJ1eRC88QnkBXa6sVW3T8aa+yPNkppXGZt+XlbVTlB4
         jNXdRGxdLxNYMaxseYFH7KnaZ6Ci6yA6de5XRzKDfw7CkuZCPimziqo7DZJkq8PrSKNK
         rTWwLbP2rNF1EZWHhAWvjXe7FrJZKPDbOzPPE5rD0JmCkTw9XUpVvT5jLEj4WvVY0ziI
         uBImwgbqNkVVgCP7Mi88H6ifS5x29/MZbHQV40pE5qUfuQwOOzjCKG+06uD3RWWoh2NW
         1Z3dsYiYNSIJGKiXlcGMXLTpFWqQl5+yQJtuTfU0x89D4QrKISCFLYPsAIsxNKEcflbT
         Sy5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=M7swm+nG7z3utSFw6qWZEc+yWDv4Q0TmDBXXgEpR0mE=;
        b=22vEry76NWmW4/tLS2ooMGkwdZbUpe4ycISUxLZjjaqtqI7/UZUE29HBhT7jfc4AJh
         WYGfBZzdMjrnD0qrdypVlXjLBjcacMbjQfpr4N9hsHzLuEtJ2yNyFLrSJngUh9hITh3k
         AJd9X3hU3Im9qxMxxZV+/iAcjbCt7lhBwj63MLCLhMCvdLQdB/6mgrnz+W+3hGonqLud
         3jXzZp2IupzI0VisVjMw9IVqJNFhdXM6RB5YMcgD76IFGKAWVGZnTk/NK4gwSZ4ZFVmU
         sa8ojywE3WlEeMo4F5DA9Qst87N+sEWYgjPTzRRQbCROmVY2vdLIJrTSec7YI6/6zahY
         cPug==
X-Gm-Message-State: AOAM530XYDgM/qaqYwJ/KU8/2Zb8Nk6/PEuhRiuWDcgGgJndDQ5gGYz/
        8dFRhpfbv4xQRrQqghdODAs=
X-Google-Smtp-Source: ABdhPJwhRAoINXNkBxU7WIl5oBSc9mZAdD36m/aRLzkpG0HFXGGPFci56jz/y8sYI32PS9dlUaMyUw==
X-Received: by 2002:a17:907:3f9d:: with SMTP id hr29mr24279617ejc.369.1638538876561;
        Fri, 03 Dec 2021 05:41:16 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id g9sm2021242edb.52.2021.12.03.05.41.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Dec 2021 05:41:16 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mt8oN-00094C-K4;
        Fri, 03 Dec 2021 14:41:15 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Han Xin <chiyutianyi@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Philip Oakley <philipoakley@iee.email>,
        Derrick Stolee <stolee@gmail.com>,
        Han Xin <hanxin.hx@alibaba-inc.com>
Subject: Re: [PATCH v4 1/5] object-file: refactor write_loose_object() to
 read buffer from stream
Date:   Fri, 03 Dec 2021 14:28:24 +0100
References: <20211122033220.32883-1-chiyutianyi@gmail.com>
 <20211203093530.93589-2-chiyutianyi@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.9
In-reply-to: <20211203093530.93589-2-chiyutianyi@gmail.com>
Message-ID: <211203.86r1atst50.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Dec 03 2021, Han Xin wrote:

> From: Han Xin <hanxin.hx@alibaba-inc.com>
>
> We used to call "get_data()" in "unpack_non_delta_entry()" to read the
> entire contents of a blob object, no matter how big it is. This
> implementation may consume all the memory and cause OOM.
>
> This can be improved by feeding data to "write_loose_object()" in a
> stream. The input stream is implemented as an interface. In the first
> step, we make a simple implementation, feeding the entire buffer in the
> "stream" to "write_loose_object()" as a refactor.
>
> Helped-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
> Signed-off-by: Han Xin <hanxin.hx@alibaba-inc.com>
> ---
>  object-file.c  | 53 ++++++++++++++++++++++++++++++++++++++++++++++----
>  object-store.h |  6 ++++++
>  2 files changed, 55 insertions(+), 4 deletions(-)
>
> diff --git a/object-file.c b/object-file.c
> index eb972cdccd..82656f7428 100644
> --- a/object-file.c
> +++ b/object-file.c
> @@ -1860,8 +1860,26 @@ static int create_tmpfile(struct strbuf *tmp, const char *filename)
>  	return fd;
>  }
>  
> +struct simple_input_stream_data {
> +	const void *buf;
> +	unsigned long len;
> +};

I see why you picked "const void *buf" here, over say const char *, it's
what "struct input_stream" uses.

But why not use size_t for the length, as input_stream does?

> +static const void *feed_simple_input_stream(struct input_stream *in_stream, unsigned long *len)
> +{
> +	struct simple_input_stream_data *data = in_stream->data;
> +
> +	if (data->len == 0) {

nit: if (!data->len)...

> +		*len = 0;
> +		return NULL;
> +	}
> +	*len = data->len;
> +	data->len = 0;
> +	return data->buf;

But isn't the body of this functin the same as:

        *len = data->len;
        if (!len)
                return NULL;
        data->len = 0;
        return data->buf;

I.e. you don't need the condition for setting "*len" if it's 0, then
data->len is also 0. You just want to return NULL afterwards, and not
set (harmless, but no need) data->len to 0)< or return data->buf.
> +	struct input_stream in_stream = {
> +		.read = feed_simple_input_stream,
> +		.data = (void *)&(struct simple_input_stream_data) {
> +			.buf = buf,
> +			.len = len,
> +		},
> +		.size = len,
> +	};

Maybe it's that I'm unused to it, but I find this a bit more readable:
	
	@@ -2013,12 +2011,13 @@ int write_object_file_flags(const void *buf, unsigned long len,
	 {
	 	char hdr[MAX_HEADER_LEN];
	 	int hdrlen = sizeof(hdr);
	+	struct simple_input_stream_data tmp = {
	+		.buf = buf,
	+		.len = len,
	+	};
	 	struct input_stream in_stream = {
	 		.read = feed_simple_input_stream,
	-		.data = (void *)&(struct simple_input_stream_data) {
	-			.buf = buf,
	-			.len = len,
	-		},
	+		.data = (void *)&tmp,
	 		.size = len,
	 	};
	
Yes there's a temporary variable, but no denser inline casting. Also
easier to strep through in a debugger (which will have the type
information on "tmp".

>  int hash_object_file_literally(const void *buf, unsigned long len,
> @@ -1977,6 +2006,14 @@ int hash_object_file_literally(const void *buf, unsigned long len,
>  {
>  	char *header;
>  	int hdrlen, status = 0;
> +	struct input_stream in_stream = {
> +		.read = feed_simple_input_stream,
> +		.data = (void *)&(struct simple_input_stream_data) {
> +			.buf = buf,
> +			.len = len,
> +		},
> +		.size = len,
> +	};

ditto..

>  	/* type string, SP, %lu of the length plus NUL must fit this */
>  	hdrlen = strlen(type) + MAX_HEADER_LEN;
> @@ -1988,7 +2025,7 @@ int hash_object_file_literally(const void *buf, unsigned long len,
>  		goto cleanup;
>  	if (freshen_packed_object(oid) || freshen_loose_object(oid))
>  		goto cleanup;
> -	status = write_loose_object(oid, header, hdrlen, buf, len, 0, 0);
> +	status = write_loose_object(oid, header, hdrlen, &in_stream, 0, 0);
>  
>  cleanup:
>  	free(header);
> @@ -2003,14 +2040,22 @@ int force_object_loose(const struct object_id *oid, time_t mtime)
>  	char hdr[MAX_HEADER_LEN];
>  	int hdrlen;
>  	int ret;
> +	struct simple_input_stream_data data;
> +	struct input_stream in_stream = {
> +		.read = feed_simple_input_stream,
> +		.data = &data,
> +	};
>  
>  	if (has_loose_object(oid))
>  		return 0;
>  	buf = read_object(the_repository, oid, &type, &len);
> +	in_stream.size = len;

Why are we setting this here?...

>  	if (!buf)
>  		return error(_("cannot read object for %s"), oid_to_hex(oid));

...Insted of after this point, as we may error and never use it?

> +	data.buf = buf;
> +	data.len = len;

Probably won't matter,  just a nit...

> +struct input_stream {
> +	const void *(*read)(struct input_stream *, unsigned long *len);
> +	void *data;
> +	size_t size;
> +};
> +

Ah, and here's the size_t... :)
