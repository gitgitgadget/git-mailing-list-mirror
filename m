Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FE9BC433F5
	for <git@archiver.kernel.org>; Fri,  3 Dec 2021 13:54:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352369AbhLCN57 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Dec 2021 08:57:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243650AbhLCN56 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Dec 2021 08:57:58 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90A50C06173E
        for <git@vger.kernel.org>; Fri,  3 Dec 2021 05:54:34 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id t5so12061460edd.0
        for <git@vger.kernel.org>; Fri, 03 Dec 2021 05:54:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=bz7rNuUvbOoG2aWJgouJK2/L01AfZnpuVYX9BYmOo+g=;
        b=pnTaNxyyKL9F0SfsdUtklh7oL/uNqoFG6zMVKB/FqU7Eavb3w3gkBOGvx4goxPQLyR
         RTDF4fG2hLYTPVZI4HCUYliYg3BGOQ4OPB7qVZPWDwRATIDq6BFnAkM/70r6OkI3tpED
         4cBwrCkwW51+1ftyakKVv88l5P23Fi1CqZQKSMwjgPeYWvXen0HmUPyvGbuZndnag4gw
         f59m0Bqdb6CAnHfkXTfUm7MLaR2qwH4W8BRLb7uATyiOrjx/ePSHYKdBmZrreZyasgBo
         N9uoPRR+jfW1Lb/GvYxfUok6w4e+L8X4MkP8vJgmr4Zy28YuXM35Jq9Sb/dbc9zo8Y95
         stGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=bz7rNuUvbOoG2aWJgouJK2/L01AfZnpuVYX9BYmOo+g=;
        b=5Za96/NsUKw4DwB53jlk0rtJd1zJcsC0ph33xpXUubom8oV2pdGOInuwvIGDaVD8SO
         ngVry8FP1t5Q5ryG4rjFAzogUdcGh7zgvJIhd4cPqBzlByB/Ky7jyJRvzVEGu5OokyXg
         2OaJhQJii03myifHZwt15sPAd5D57tVgb+f5HR2jcIxzWe6A3oBNP0vDVtHXBbg7NowN
         kcDC1Zdku9nhu6Zzm9nhdR7vEjMZ+EIVdNxjrksUGbGmtwonVOG+N/dibq9KrPKca3dn
         WJB3R+cUNBuuszZtDq0eG8KBFtXmmzN6xEwfKzslIfyiDQsPnQvJgcWbfI3ZOfak3oys
         Zf9g==
X-Gm-Message-State: AOAM53144HevKNqF8ro6/ga4xBhzx0clGXMJBeGITSKEKGdvsxw9u9uS
        zVzK90/knEnERk9hKHX1R6Y=
X-Google-Smtp-Source: ABdhPJxMCdTiI+7PXrh8wHi5Sq0KXiiGAYprikz4voF41NLBJAszZ84r18H+wOJtGlfQYZZEDT72kA==
X-Received: by 2002:aa7:c155:: with SMTP id r21mr27252665edp.124.1638539664895;
        Fri, 03 Dec 2021 05:54:24 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id s4sm2181267ejn.25.2021.12.03.05.54.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Dec 2021 05:54:24 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mt915-0009Ox-Kz;
        Fri, 03 Dec 2021 14:54:23 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Han Xin <chiyutianyi@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Philip Oakley <philipoakley@iee.email>,
        Derrick Stolee <stolee@gmail.com>,
        Han Xin <hanxin.hx@alibaba-inc.com>
Subject: Re: [PATCH v4 2/5] object-file.c: handle undetermined oid in
 write_loose_object()
Date:   Fri, 03 Dec 2021 14:41:28 +0100
References: <20211122033220.32883-1-chiyutianyi@gmail.com>
 <20211203093530.93589-3-chiyutianyi@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.9
In-reply-to: <20211203093530.93589-3-chiyutianyi@gmail.com>
Message-ID: <211203.86mtlhssj4.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Dec 03 2021, Han Xin wrote:

> From: Han Xin <hanxin.hx@alibaba-inc.com>
>
> When streaming a large blob object to "write_loose_object()", we have no
> chance to run "write_object_file_prepare()" to calculate the oid in
> advance. So we need to handle undetermined oid in function
> "write_loose_object()".
>
> In the original implementation, we know the oid and we can write the
> temporary file in the same directory as the final object, but for an
> object with an undetermined oid, we don't know the exact directory for
> the object, so we have to save the temporary file in ".git/objects/"
> directory instead.
>
> Helped-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
> Signed-off-by: Han Xin <hanxin.hx@alibaba-inc.com>
> ---
>  object-file.c | 30 ++++++++++++++++++++++++++++--
>  1 file changed, 28 insertions(+), 2 deletions(-)
>
> diff --git a/object-file.c b/object-file.c
> index 82656f7428..1c41587bfb 100644
> --- a/object-file.c
> +++ b/object-file.c
> @@ -1892,7 +1892,14 @@ static int write_loose_object(const struct object_id *oid, char *hdr,
>  	const void *buf;
>  	unsigned long len;
>  
> -	loose_object_path(the_repository, &filename, oid);
> +	if (is_null_oid(oid)) {
> +		/* When oid is not determined, save tmp file to odb path. */
> +		strbuf_reset(&filename);

Why re-use this & leak memory? An existing strbuf use in this function
doesn't leak in the same way. Just release it as in the below patch on
top (the ret v.s. err variable naming is a bit confused, maybe could do
with a prep cleanup step.).

> +		strbuf_addstr(&filename, the_repository->objects->odb->path);
> +		strbuf_addch(&filename, '/');

And once we do that this could just become:

	strbuf_addf($filename, "%s/", ...)

Is there's existing uses of this pattern, so mayb e not worth it, but it
allows you to remove the braces on the if/else.

diff --git a/object-file.c b/object-file.c
index 8bd89e7b7ba..2b52f3fc1cc 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1880,7 +1880,7 @@ int write_loose_object(const struct object_id *oid, char *hdr,
 		       int hdrlen, struct input_stream *in_stream,
 		       time_t mtime, unsigned flags)
 {
-	int fd, ret;
+	int fd, ret, err = 0;
 	unsigned char compressed[4096];
 	git_zstream stream;
 	git_hash_ctx c;
@@ -1892,7 +1892,6 @@ int write_loose_object(const struct object_id *oid, char *hdr,
 
 	if (is_null_oid(oid)) {
 		/* When oid is not determined, save tmp file to odb path. */
-		strbuf_reset(&filename);
 		strbuf_addstr(&filename, the_repository->objects->odb->path);
 		strbuf_addch(&filename, '/');
 	} else {
@@ -1902,11 +1901,12 @@ int write_loose_object(const struct object_id *oid, char *hdr,
 	fd = create_tmpfile(&tmp_file, filename.buf);
 	if (fd < 0) {
 		if (flags & HASH_SILENT)
-			return -1;
+			err = -1;
 		else if (errno == EACCES)
-			return error(_("insufficient permission for adding an object to repository database %s"), get_object_directory());
+			err = error(_("insufficient permission for adding an object to repository database %s"), get_object_directory());
 		else
-			return error_errno(_("unable to create temporary file"));
+			err = error_errno(_("unable to create temporary file"));
+		goto cleanup;
 	}
 
 	/* Set it up */
@@ -1968,10 +1968,13 @@ int write_loose_object(const struct object_id *oid, char *hdr,
 			struct strbuf dir = STRBUF_INIT;
 			strbuf_add(&dir, filename.buf, dirlen - 1);
 			if (mkdir(dir.buf, 0777) && errno != EEXIST)
-				return -1;
-			if (adjust_shared_perm(dir.buf))
-				return -1;
-			strbuf_release(&dir);
+				err = -1;
+			else if (adjust_shared_perm(dir.buf))
+				err = -1;
+			else
+				strbuf_release(&dir);
+			if (err < 0)
+				goto cleanup;
 		}
 	}
 
@@ -1984,7 +1987,10 @@ int write_loose_object(const struct object_id *oid, char *hdr,
 			warning_errno(_("failed utime() on %s"), tmp_file.buf);
 	}
 
-	return finalize_object_file(tmp_file.buf, filename.buf);
+	err = finalize_object_file(tmp_file.buf, filename.buf);
+cleanup:
+	strbuf_release(&filename);
+	return err;
 }
 
 static int freshen_loose_object(const struct object_id *oid)
