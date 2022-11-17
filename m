Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CD05C433FE
	for <git@archiver.kernel.org>; Thu, 17 Nov 2022 19:47:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240406AbiKQTrl (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Nov 2022 14:47:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235052AbiKQTrk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Nov 2022 14:47:40 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EF0F87571
        for <git@vger.kernel.org>; Thu, 17 Nov 2022 11:47:39 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id i10so7758543ejg.6
        for <git@vger.kernel.org>; Thu, 17 Nov 2022 11:47:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vYO+BzmcMMI9c7NcthoUf+yxS+mPrgM3vQZMjYPKVYI=;
        b=dp58KuS3jxmbhC17B7la1q+4ZP0AFVUILjGxELBfRH0wbUoifubzaNI7vqbZPuYcvL
         cOTqb0H0RMa7K6Ys9UvSyfPCbhravo6UOgtgFK+ZU3Z3nlCg9CTmtIIg6J8UBW0sBSX0
         VZU8jIJPv2Uvnn39a/Cduglt5LZ94E6vZwwBEToA8CycP6z04TdaWJSigRYqEybY65gb
         T0TRiOcJ2T8Jt2KSbgk3LOng5UEzM2GRoVLX4MleqZvWe09h7/ELEemk04TN5MQ9AxoB
         KHHkENTZVO2JrkUcKVAXRiWegeo/ehSwRMHTwyTeu2hzeFsxHKjAi0nhNiuxukS62JUV
         7MKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vYO+BzmcMMI9c7NcthoUf+yxS+mPrgM3vQZMjYPKVYI=;
        b=iTedCvod/HJwjXLa2RCxL6fIQcraJLtrYcsm70IT0BPWIQ7hINIjZcRyDD5lxCKSZO
         +lAlMg7UXN9wPY5NXBxt+CcZp4pXgQMfgXmD0kBADYvhdAqU4drKYuO5RQWH1EEzZ4k6
         nQK04XpiU8neTirIalYuNccwscqhgBdGx2WJya58Mnc957pSKDTe0MQ+QOziM9MM5Tfk
         80cdhSVeFyvGnNXqJOneTB0NY9Vp8iYnrmzy3UnCThGHJK4uQEoYMaRYDawFrWJyPJtQ
         ezQm11PJapi+EkFTh4c24Qv/zolffJNOSJurX6gNR26wdhTtuitUxxScju7LL4Tb2r7Y
         VQAA==
X-Gm-Message-State: ANoB5plVajlel4ivTBY70dZbwI/0ctDBZzczvjhY3/lm8PwCciDLHl7V
        8BIrA2zPGKtrPPlbEriTzuc=
X-Google-Smtp-Source: AA0mqf4dlPton2yCbbLnGDTjzzOhcUQsD41NsgFsKFWjklkE5A+G/yl1fw2BhPSWz7+aXe9qe5RMCQ==
X-Received: by 2002:a17:906:1e50:b0:7ae:5a4:5344 with SMTP id i16-20020a1709061e5000b007ae05a45344mr3592029ejj.27.1668714457484;
        Thu, 17 Nov 2022 11:47:37 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id g5-20020a056402114500b00467cc919072sm907196edw.17.2022.11.17.11.47.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 11:47:37 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1ovkrI-004zeL-1B;
        Thu, 17 Nov 2022 20:47:36 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Glen Choo via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        Glen Choo <chooglen@google.com>
Subject: Re: [PATCH] object-file: use real paths when adding alternates
Date:   Thu, 17 Nov 2022 20:41:44 +0100
References: <pull.1382.git.git.1668706274099.gitgitgadget@gmail.com>
 <Y3aBzbzub7flQyca@coredump.intra.peff.net>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <Y3aBzbzub7flQyca@coredump.intra.peff.net>
Message-ID: <221117.86h6yxgy7b.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Nov 17 2022, Jeff King wrote:

> On Thu, Nov 17, 2022 at 05:31:13PM +0000, Glen Choo via GitGitGadget wrote:
> [...]
>> @@ -596,7 +603,7 @@ static void link_alt_odb_entries(struct repository *r, const char *alt,
>>  		return;
>>  	}
>>  
>> -	strbuf_add_absolute_path(&objdirbuf, r->objects->odb->path);
>> +	strbuf_realpath(&objdirbuf, r->objects->odb->path, 1);
>>  	if (strbuf_normalize_path(&objdirbuf) < 0)
>>  		die(_("unable to normalize object directory: %s"),
>>  		    objdirbuf.buf);
>
> Similarly here, I think we'd want to _replace_ the normalize with a
> realpath. There's no point in doing both. It's OK to die in this one
> because we assume the object directory can be normalized/realpath'd.
>
> So I'd have expected the code portion of your patch to be more like:
>
> diff --git a/object-file.c b/object-file.c
> index 957790098f..c6a195c6dd 100644
> --- a/object-file.c
> +++ b/object-file.c
> @@ -508,6 +508,7 @@ static int link_alt_odb_entry(struct repository *r, const struct strbuf *entry,
>  {
>  	struct object_directory *ent;
>  	struct strbuf pathbuf = STRBUF_INIT;
> +	struct strbuf tmp = STRBUF_INIT;
>  	khiter_t pos;
>  
>  	if (!is_absolute_path(entry->buf) && relative_base) {
> @@ -516,12 +517,18 @@ static int link_alt_odb_entry(struct repository *r, const struct strbuf *entry,
>  	}
>  	strbuf_addbuf(&pathbuf, entry);
>  
> -	if (strbuf_normalize_path(&pathbuf) < 0 && relative_base) {
> -		error(_("unable to normalize alternate object path: %s"),
> -		      pathbuf.buf);
> -		strbuf_release(&pathbuf);
> -		return -1;
> +	if (!strbuf_realpath(&tmp, pathbuf.buf, 0)) {
> +		if (relative_base) {
> +			error(_("unable to normalize alternate object path: %s"),
> +			      pathbuf.buf);
> +			strbuf_release(&pathbuf);
> +			return -1;
> +		}
> +		/* allow broken paths from env per 37a95862c625 */
> +		strbuf_addstr(&tmp, pathbuf.buf);
>  	}
> +	strbuf_swap(&pathbuf, &tmp);
> +	strbuf_release(&tmp);
>  
>  	/*
>  	 * The trailing slash after the directory name is given by
> @@ -596,10 +603,7 @@ static void link_alt_odb_entries(struct repository *r, const char *alt,
>  		return;
>  	}
>  
> -	strbuf_add_absolute_path(&objdirbuf, r->objects->odb->path);
> -	if (strbuf_normalize_path(&objdirbuf) < 0)
> -		die(_("unable to normalize object directory: %s"),
> -		    objdirbuf.buf);
> +	strbuf_realpath(&objdirbuf, r->objects->odb->path, 1);
>  
>  	while (*alt) {
>  		alt = parse_alt_odb_entry(alt, sep, &entry);
>
> The "tmp" swapping in link_alt_odb_entry is kind of unfortunate. It
> would be nice if there were an in-place version of strbuf_realpath, even
> if it was using two buffers under the hood (which is how the normalize
> code does it). And then the patch really would be s/normalize/realpath/,
> which is easier to understand.
>
> Possibly this should also be using the "forgiving" version. We
> eventually error out on missing entries later on, so it's not a big deal
> to error here. But it would let us keep the error message the same. I
> don't know that it matters much in practice.

This probably isn't worth it, but I wondered if this wouldn't be easier
if we pulled that memory management into the caller, it's not
performance sensitive (or maybe, how many alternatives do people have
:)), but an advantage of this is that we avoid the free()/malloc() if we
only get partway through, i.e. return early and keep looping.

In terms of general code smell & how we manage the "return" here, as
adding "RESULT_MUST_BE_USED" to this shows we never use the "0" or "-1"
(or any other...) return value.

That's been the case since this was added in c2f493a4ae1 (Transitively
read alternatives, 2006-05-07), so we can probably just make this a
"void" and ditch the returns if we're finding ourselves juggling these
return values...

 object-file.c | 44 ++++++++++++++++++++++----------------------
 1 file changed, 22 insertions(+), 22 deletions(-)

diff --git a/object-file.c b/object-file.c
index c6a195c6dd2..1a94d98e0c7 100644
--- a/object-file.c
+++ b/object-file.c
@@ -504,47 +504,43 @@ static void read_info_alternates(struct repository *r,
 				 const char *relative_base,
 				 int depth);
 static int link_alt_odb_entry(struct repository *r, const struct strbuf *entry,
-	const char *relative_base, int depth, const char *normalized_objdir)
+			      const char *relative_base, int depth,
+			      const char *normalized_objdir,
+			      struct strbuf *pathbuf)
 {
 	struct object_directory *ent;
-	struct strbuf pathbuf = STRBUF_INIT;
 	struct strbuf tmp = STRBUF_INIT;
 	khiter_t pos;
 
 	if (!is_absolute_path(entry->buf) && relative_base) {
-		strbuf_realpath(&pathbuf, relative_base, 1);
-		strbuf_addch(&pathbuf, '/');
+		strbuf_realpath(pathbuf, relative_base, 1);
+		strbuf_addch(pathbuf, '/');
 	}
-	strbuf_addbuf(&pathbuf, entry);
+	strbuf_addbuf(pathbuf, entry);
 
-	if (!strbuf_realpath(&tmp, pathbuf.buf, 0)) {
-		if (relative_base) {
-			error(_("unable to normalize alternate object path: %s"),
-			      pathbuf.buf);
-			strbuf_release(&pathbuf);
-			return -1;
-		}
+	if (!strbuf_realpath(&tmp, pathbuf->buf, 0)) {
+		if (relative_base)
+			return error(_("unable to normalize alternate object path: %s"),
+				     pathbuf->buf);
 		/* allow broken paths from env per 37a95862c625 */
-		strbuf_addstr(&tmp, pathbuf.buf);
+		strbuf_addstr(&tmp, pathbuf->buf);
 	}
-	strbuf_swap(&pathbuf, &tmp);
+	strbuf_swap(pathbuf, &tmp);
 	strbuf_release(&tmp);
 
 	/*
 	 * The trailing slash after the directory name is given by
 	 * this function at the end. Remove duplicates.
 	 */
-	while (pathbuf.len && pathbuf.buf[pathbuf.len - 1] == '/')
-		strbuf_setlen(&pathbuf, pathbuf.len - 1);
+	while (pathbuf->len && pathbuf->buf[pathbuf->len - 1] == '/')
+		strbuf_setlen(pathbuf, pathbuf->len - 1);
 
-	if (!alt_odb_usable(r->objects, &pathbuf, normalized_objdir, &pos)) {
-		strbuf_release(&pathbuf);
+	if (!alt_odb_usable(r->objects, pathbuf, normalized_objdir, &pos))
 		return -1;
-	}
 
 	CALLOC_ARRAY(ent, 1);
-	/* pathbuf.buf is already in r->objects->odb_by_path */
-	ent->path = strbuf_detach(&pathbuf, NULL);
+	/* pathbuf->buf is already in r->objects->odb_by_path */
+	ent->path = strbuf_detach(pathbuf, NULL);
 
 	/* add the alternate entry */
 	*r->objects->odb_tail = ent;
@@ -593,6 +589,7 @@ static void link_alt_odb_entries(struct repository *r, const char *alt,
 {
 	struct strbuf objdirbuf = STRBUF_INIT;
 	struct strbuf entry = STRBUF_INIT;
+	struct strbuf pathbuf = STRBUF_INIT;
 
 	if (!alt || !*alt)
 		return;
@@ -610,8 +607,11 @@ static void link_alt_odb_entries(struct repository *r, const char *alt,
 		if (!entry.len)
 			continue;
 		link_alt_odb_entry(r, &entry,
-				   relative_base, depth, objdirbuf.buf);
+				   relative_base, depth, objdirbuf.buf,
+				   &pathbuf);
+		strbuf_reset(&pathbuf);
 	}
+	strbuf_release(&pathbuf);
 	strbuf_release(&entry);
 	strbuf_release(&objdirbuf);
 }

