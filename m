Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC1C3C433FE
	for <git@archiver.kernel.org>; Wed,  5 Oct 2022 13:04:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229773AbiJENE0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Oct 2022 09:04:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbiJENEX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Oct 2022 09:04:23 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEB021F9C0
        for <git@vger.kernel.org>; Wed,  5 Oct 2022 06:04:19 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id s2so12297048edd.2
        for <git@vger.kernel.org>; Wed, 05 Oct 2022 06:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ygJx6RAOUNduARBp+ZPOQJ5FPurJUyrosJXaweUte8o=;
        b=Jw6N86z74tUukPlRRK+OESN+S3Z+vhlQfzuqNMU7MRYERidz1CIXRdeCdJ3ruynaEX
         DYjxJIN2M5Qhe7jjbV/uv/JgPg8zwz1hAdBJwbAez/D0H6b7TX6la8CP7jUUevX9x7t/
         GCOeFrSFwxl6SMlK1WtBjSA05hxnFQhOm9VJmLSoKPfNtURTVL5us6TIT0E5zlgP4fVs
         +YwmcODjyC/eryHqPnYJtaqUeUIbymXD/B/aJYXn1gtEePl/U5rVoqARWvWtDOI8a8OT
         OePHCIrQm3VwALFcYS63FqjJlfDcmbFAz4c3TbMsv6b30STdM8el93GsYDMs8yf4DSrW
         PcSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ygJx6RAOUNduARBp+ZPOQJ5FPurJUyrosJXaweUte8o=;
        b=2YikNCr0cw0Kfvv5h6iW2Yebs07ACpGsKLDrPhBnxzT0KMCitaXwFyCdQb05dGH5Kl
         7+J3QiJW52OUpeIkaEF6AiTpVZWH/8/BACWdTwmLIOSq0WZ3rXmSRw9oEqUvozr/JTKV
         cvKtWMrTdb7vrCQjeARo2lZ97vNTeAgq6BKcXk6VG1IR0i0Cdjc0Jb6jcRnPcITVUks5
         mkHx4hd+Ssr/YNztR4vym0IZeUG7xscE5+taX0JUIz4ueMjGPJAiiD0SHAWVKlTDf3GZ
         PeSUNZLE2KJG/yQVZGQtUMP5ZnZyCWjP8ukyqIYPQ6k3VOvRpjGbO+gTSqW3wrWR7S2w
         oRrQ==
X-Gm-Message-State: ACrzQf3b1z/paaXZFNMDddCoVevAsWTM/2Kbq6ljN5fn1WcgPBGUO35x
        mpP7vJVIvsJP8vRk8eQbE7PMbIsgjBhKlw==
X-Google-Smtp-Source: AMsMyM5G9ijOY7hBuvmc4NkSUb8sNboYfB7D3nNn4ABgVc9+HYmi0/TvCZj7GsQzXhUh9adI9i9PCA==
X-Received: by 2002:a05:6402:2693:b0:450:a807:6c91 with SMTP id w19-20020a056402269300b00450a8076c91mr28545423edd.33.1664975058060;
        Wed, 05 Oct 2022 06:04:18 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id la3-20020a170907780300b00781dbdb292asm8584269ejc.155.2022.10.05.06.04.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Oct 2022 06:04:16 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1og44N-002Y9L-1L;
        Wed, 05 Oct 2022 15:04:15 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH 6/9] trace2: convert ctx.thread_name to flex array
Date:   Wed, 05 Oct 2022 13:14:50 +0200
References: <pull.1373.git.1664900407.gitgitgadget@gmail.com>
 <6492b6d2b989e08bb539fff3ffe5bdf50fa0a195.1664900407.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <6492b6d2b989e08bb539fff3ffe5bdf50fa0a195.1664900407.git.gitgitgadget@gmail.com>
Message-ID: <221005.86y1tus9ps.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Oct 04 2022, Jeff Hostetler via GitGitGadget wrote:

> From: Jeff Hostetler <jeffhost@microsoft.com>
>
> Convert the `tr2tls_thread_ctx.thread_name` field from a `strbuf`
> to a "flex array" at the end of the context structure.
>
> The `thread_name` field is a constant string that is constructed when
> the context is created.  Using a (non-const) `strbuf` structure for it
> caused some confusion in the past because it implied that someone
> could rename a thread after it was created.

I think it's been long enough that we could use a reminder about the
"some confusion", i.e. if it was a bug report or something else.

> That usage was not intended.  Changing it to a "flex array" will
> hopefully make the intent more clear.

I see we had some back & forth back in the original submission, although
honestly I skimmed this this time around, had forgetten about that, and
had this pop out at me, and then found my earlier comments.

I see that exchange didn't end as well as I'd hoped[1], and hopefully we
can avoid that here. So having looked at this with fresh eyes maybe
these comments/questions help:

 * I'm unable to bridge the cap from (paraphrased) "we must change the
   type" to "mak[ing] the [read-only] intent more clear".

   I.e. if you go across the codebase and look at various non-const
   "char name[FLEX_ARRAY]" and add a "const" to them you'll find cases
   where we re-write the "FLEX_ARRAY" string, e.g. the one in archive.c
   is one of those (the first grep hit, I stopped looking for others at
   that point).

   Making it "const" will yield:
=20=20=20
      archive.c: In function =E2=80=98queue_directory=E2=80=99:
   archive.c:206:29: error: passing argument 1 of =E2=80=98xsnprintf=E2=80=
=99 discards =E2=80=98const=E2=80=99 qualifier from pointer target type [-W=
error=3Ddiscarded-qualifiers]
     206 |         d->len =3D xsnprintf(d->path, len, "%.*s%s/", (int)base-=
>len, base->buf, filename);

   So aside from anything else (and I may be misunderstanding this) why
   does changing it to a FLEX_ARRAY give us the connotation in the
   confused API user's mind that it shouldn't be messed with that the
   "strbuf" doesn't give us?

 * Now, quoting from the below:

> [...]
> diff --git a/trace2/tr2_tls.c b/trace2/tr2_tls.c
> index 39b41fd2487..89437e773f6 100644
> --- a/trace2/tr2_tls.c
> +++ b/trace2/tr2_tls.c
> @@ -34,7 +34,18 @@ void tr2tls_start_process_clock(void)
>  struct tr2tls_thread_ctx *tr2tls_create_self(const char *name_hint,
>  					     uint64_t us_thread_start)
>  {
> -	struct tr2tls_thread_ctx *ctx =3D xcalloc(1, sizeof(*ctx));
> +	struct tr2tls_thread_ctx *ctx;
> +	struct strbuf buf_name =3D STRBUF_INIT;
> +	int thread_id =3D tr2tls_locked_increment(&tr2_next_thread_id);
> +
> +	if (thread_id)
> +		strbuf_addf(&buf_name, "th%02d:", thread_id);
> +	strbuf_addstr(&buf_name, name_hint);
> +
> +	FLEX_ALLOC_MEM(ctx, thread_name, buf_name.buf, buf_name.len);
> +	strbuf_release(&buf_name);
> +
> +	ctx->thread_id =3D thread_id;
>=20=20
>  	/*
>  	 * Implicitly "tr2tls_push_self()" to capture the thread's start
> @@ -45,15 +56,6 @@ struct tr2tls_thread_ctx *tr2tls_create_self(const cha=
r *name_hint,
>  	ctx->array_us_start =3D (uint64_t *)xcalloc(ctx->alloc, sizeof(uint64_t=
));
>  	ctx->array_us_start[ctx->nr_open_regions++] =3D us_thread_start;
>=20=20
> -	ctx->thread_id =3D tr2tls_locked_increment(&tr2_next_thread_id);
> -
> -	strbuf_init(&ctx->thread_name, 0);
> -	if (ctx->thread_id)
> -		strbuf_addf(&ctx->thread_name, "th%02d:", ctx->thread_id);
> -	strbuf_addstr(&ctx->thread_name, name_hint);
> -	if (ctx->thread_name.len > TR2_MAX_THREAD_NAME)
> -		strbuf_setlen(&ctx->thread_name, TR2_MAX_THREAD_NAME);
> -
>  	pthread_setspecific(tr2tls_key, ctx);
>=20=20
>  	return ctx;

I found this quote hard to follow because there's functional changes
there mixed up with code re-arangement, consider leading with a commit
like:
=09
	diff --git a/trace2/tr2_tls.c b/trace2/tr2_tls.c
	index 39b41fd2487..d7952062007 100644
	--- a/trace2/tr2_tls.c
	+++ b/trace2/tr2_tls.c
	@@ -31,10 +31,24 @@ void tr2tls_start_process_clock(void)
	 	tr2tls_us_start_process =3D getnanotime() / 1000;
	 }
=09=20
	+static void fill_thread_name(struct strbuf *buf, const char *name_hint,
	+			     int thread_id)
	+{
	+	if (thread_id)
	+		strbuf_addf(buf, "th%02d:", thread_id);
	+	strbuf_addstr(buf, name_hint);
	+	if (buf->len > TR2_MAX_THREAD_NAME)
	+		strbuf_setlen(buf, TR2_MAX_THREAD_NAME);
	+
	+}
	+
	 struct tr2tls_thread_ctx *tr2tls_create_self(const char *name_hint,
	 					     uint64_t us_thread_start)
	 {
	-	struct tr2tls_thread_ctx *ctx =3D xcalloc(1, sizeof(*ctx));
	+	struct tr2tls_thread_ctx *ctx;
	+	int thread_id =3D tr2tls_locked_increment(&tr2_next_thread_id);
	+
	+	ctx =3D xcalloc(1, sizeof(*ctx));
=09=20
	 	/*
	 	 * Implicitly "tr2tls_push_self()" to capture the thread's start
	@@ -45,14 +59,8 @@ struct tr2tls_thread_ctx *tr2tls_create_self(const char=
 *name_hint,
	 	ctx->array_us_start =3D (uint64_t *)xcalloc(ctx->alloc, sizeof(uint64_t)=
);
	 	ctx->array_us_start[ctx->nr_open_regions++] =3D us_thread_start;
=09=20
	-	ctx->thread_id =3D tr2tls_locked_increment(&tr2_next_thread_id);
	-
	 	strbuf_init(&ctx->thread_name, 0);
	-	if (ctx->thread_id)
	-		strbuf_addf(&ctx->thread_name, "th%02d:", ctx->thread_id);
	-	strbuf_addstr(&ctx->thread_name, name_hint);
	-	if (ctx->thread_name.len > TR2_MAX_THREAD_NAME)
	-		strbuf_setlen(&ctx->thread_name, TR2_MAX_THREAD_NAME);
	+	fill_thread_name(&ctx->thread_name, name_hint, thread_id);
=09=20
	 	pthread_setspecific(tr2tls_key, ctx);

I see from [1] that I comment on that before, i.e. that it was
"looks-to-be-unrelated", hopefully the above clarifies that, i.e. that
it's "unrelated" in the sense that we can do it separately with no
functiontal change, making the real change smaller.

If I then rebase your change on top of that I get the below diff, which
IMO makes it much clearer what's going on. Commenting on that:
=09
	diff --git a/trace2/tr2_tls.c b/trace2/tr2_tls.c
	index d7952062007..c540027e75d 100644
	--- a/trace2/tr2_tls.c
	+++ b/trace2/tr2_tls.c
	@@ -37,18 +37,21 @@ static void fill_thread_name(struct strbuf *buf, const=
 char *name_hint,
	 	if (thread_id)
	 		strbuf_addf(buf, "th%02d:", thread_id);
	 	strbuf_addstr(buf, name_hint);
	-	if (buf->len > TR2_MAX_THREAD_NAME)
	-		strbuf_setlen(buf, TR2_MAX_THREAD_NAME);
	-
	 }

Okey, so as explained in the commit message we no longer need to worry
about this limit, but I think leading with a change to just change that
first would help. I.e. wouldn't starting with keeping the strbuf and
doing this truncation in tr2_tgt_perf.c give you the functiotnal change
first, without the type change?

Doing it this way means we're changing the type, and also removing the
limit on thread names for non-perf backends.
=09=20
	 struct tr2tls_thread_ctx *tr2tls_create_self(const char *name_hint,
	 					     uint64_t us_thread_start)
	 {
	 	struct tr2tls_thread_ctx *ctx;
	+	struct strbuf buf_name =3D STRBUF_INIT;

Okey, now our scratch buffer is function local, but:

	 	int thread_id =3D tr2tls_locked_increment(&tr2_next_thread_id);
=09=20
	-	ctx =3D xcalloc(1, sizeof(*ctx));
	+	fill_thread_name(&buf_name, name_hint, thread_id);

We still need to malloc() that "struct strbuf", this is the main thing I
found confusing and why I didn't see the point in the original
series. I.e. we can normally pull compiler tricks with FLEX_ARRAY to
avoid allocations.

But here you need to format this string anyway, so we've already
malloc'd it, you just....

	+
	+	FLEX_ALLOC_MEM(ctx, thread_name, buf_name.buf, buf_name.len);

...memcpy() it to the FLEX_ARRAY here, but then...

	+	strbuf_release(&buf_name);

...we have to release this thing we malloc()'d, which was previously the
pointer in the struct.=20

	+
	+	ctx->thread_id =3D thread_id;
=09=20
	 	/*
	 	 * Implicitly "tr2tls_push_self()" to capture the thread's start

So, I don't really see the point of this "flex array for implicit const"
per the above, you noted in [1] "I convert the field to a flex-array to
avoid [...] the allocation" but what allocation are we really avoiding
here?

We still have to allocate the strbuf as before, we just now allocate the
struct as before + the length of that strbuf, then we can free the
strbuf.

Is it that the end memory use is lower because while we have a
allocation for the strbuf we release it right away, and the compiler (on
some platforms?) can play tricks with sticking this into padding it was
going to put there anyway, given the length of the string?

I can think of ways this *might* matter, I'm just mainly saying that
you're leaving the reader guessing still.

Aside: I can imagine that we *could* actually avoid an allocation here
by being more sneaky.

I.e. you could FLEX_ALLOC_MEM() before populating the strbuf, as we know
the format is "th%02d:", so the space we need for the string is:

	strlen(name_hint) + strlen("th") + strlen(4) /* %02d: + \0 */;

Then you could memset(&ctx->thread_name, 0, len) and strbuf_attach() the
pointer to the start of that, and voila, you could use strbuf_addf() to
do the %02d format part of that.

But I still don't see how this is an area that justifies that sort of
micro-optimization (or worrying about strbuf v.s. flex array),
i.e. don't we usually just have max ncpu threads anyway (the format
implies max 99), so a few strings like "th01:main" aren't going to cost
us much, are they?

<tries it out>

Anyway, if this area was actually performance critical and we *really
cared* about avoiding allocations wouldn't we want to skip both the
"strbuf" there and the "FLEX_ARRAY", and just save away the
"thread_hint" (which the caller hardcodes) and "thread_nr", and then
append on-the-fly?

I came up with the below to do that, it passes all tests, but contains
micro-optimizations that I don't think we need (e.g. I understood you
wanted to avoid printf, so it does that).

But I think it's a useful point of discussion. What test(s) do you have
where the "master" version, FLEX_ARRAY version, and just not strbuf
formatting the thing at all differ?
=09
	diff --git a/json-writer.c b/json-writer.c
	index f1cfd8fa8c6..124ad72d200 100644
	--- a/json-writer.c
	+++ b/json-writer.c
	@@ -161,6 +161,47 @@ void jw_object_string(struct json_writer *jw, const c=
har *key, const char *value
	 	append_quoted_string(&jw->json, value);
	 }
=09=20
	+void jw_strbuf_add_thread_name(struct strbuf *out, const char *thread_hin=
t,
	+			       int thread_id, int max_len)
	+{
	+	size_t oldlen =3D out->len;
	+
	+	if (thread_id) {
	+		strbuf_addf(out, "th");
	+		/*
	+		 * We're avoiding printf here when on-the-fly
	+		 * formatting, but why?
	+		 */
	+		if (thread_id < 10) {
	+			strbuf_addch(out, '0');
	+			strbuf_addch(out, thread_id % 10 + '0');
	+		} else {
	+			strbuf_addch(out, thread_id / 10 + '0');
	+			strbuf_addch(out, thread_id % 10 + '0');
	+		}
	+		strbuf_addch(out, ':');
	+	}
	+	if (max_len) {
	+		int added =3D out->len - oldlen;
	+		int limit =3D max_len - added;
	+
	+		strbuf_addf(out, "%.*s", limit, thread_hint);
	+	} else {
	+		strbuf_addstr(out, thread_hint);
	+	}
	+}
	+
	+void jw_object_thread(struct json_writer *jw, const char *thread_hint,
	+		      int thread_id)
	+{
	+	struct strbuf *out =3D &jw->json;
	+
	+	object_common(jw, "thread");
	+	strbuf_addch(out, '"');
	+	jw_strbuf_add_thread_name(out, thread_hint, thread_id, 0);
	+	strbuf_addch(out, '"');
	+}
	+
	 void jw_object_intmax(struct json_writer *jw, const char *key, intmax_t v=
alue)
	 {
	 	object_common(jw, key);
	diff --git a/json-writer.h b/json-writer.h
	index 209355e0f12..51b78296f8a 100644
	--- a/json-writer.h
	+++ b/json-writer.h
	@@ -77,6 +77,10 @@ void jw_array_begin(struct json_writer *jw, int pretty);
=09=20
	 void jw_object_string(struct json_writer *jw, const char *key,
	 		      const char *value);
	+void jw_strbuf_add_thread_name(struct strbuf *out, const char *thread_hin=
t,
	+			       int thread_id, int max_len);
	+void jw_object_thread(struct json_writer *jw, const char *thread_hint,
	+		      const int thread_id);
	 void jw_object_intmax(struct json_writer *jw, const char *key, intmax_t v=
alue);
	 void jw_object_double(struct json_writer *jw, const char *key, int precis=
ion,
	 		      double value);
	diff --git a/trace2/tr2_tgt_event.c b/trace2/tr2_tgt_event.c
	index bb0653e0e6f..6e480fce34a 100644
	--- a/trace2/tr2_tgt_event.c
	+++ b/trace2/tr2_tgt_event.c
	@@ -91,7 +91,7 @@ static void event_fmt_prepare(const char *event_name, co=
nst char *file,
=09=20
	 	jw_object_string(jw, "event", event_name);
	 	jw_object_string(jw, "sid", tr2_sid_get());
	-	jw_object_string(jw, "thread", ctx->thread_name);
	+	jw_object_thread(jw, ctx->thread_hint, ctx->thread_id);
=09=20
	 	/*
	 	 * In brief mode, only emit <time> on these 2 event types.
	diff --git a/trace2/tr2_tgt_perf.c b/trace2/tr2_tgt_perf.c
	index cbf8aefd56c..9f310756349 100644
	--- a/trace2/tr2_tgt_perf.c
	+++ b/trace2/tr2_tgt_perf.c
	@@ -71,6 +71,8 @@ static void perf_fmt_prepare(const char *event_name,
	 			     const char *category, struct strbuf *buf)
	 {
	 	int len;
	+	int oldlen;
	+	int thread_pad;
=09=20
	 	strbuf_setlen(buf, 0);
=09=20
	@@ -109,11 +111,11 @@ static void perf_fmt_prepare(const char *event_name,
	 	}
=09=20
	 	strbuf_addf(buf, "d%d | ", tr2_sid_depth());
	-	strbuf_addf(buf, "%-*.*s | %-*s | ",
	-		    TR2FMT_PERF_MAX_THREAD_NAME,
	-		    TR2FMT_PERF_MAX_THREAD_NAME,
	-		    ctx->thread_name,
	-		    TR2FMT_PERF_MAX_EVENT_NAME,
	+	oldlen =3D buf->len;
	+	jw_strbuf_add_thread_name(buf, ctx->thread_hint, ctx->thread_id,
	+				  TR2FMT_PERF_MAX_THREAD_NAME);
	+	thread_pad =3D TR2FMT_PERF_MAX_THREAD_NAME - (buf->len - oldlen);
	+	strbuf_addf(buf, "%-*s | %-*s | ", thread_pad, "", TR2FMT_PERF_MAX_EVENT=
_NAME,
	 		    event_name);
=09=20
	 	len =3D buf->len + TR2FMT_PERF_REPO_WIDTH;
	diff --git a/trace2/tr2_tls.c b/trace2/tr2_tls.c
	index 02117f808eb..9959ec9b160 100644
	--- a/trace2/tr2_tls.c
	+++ b/trace2/tr2_tls.c
	@@ -31,26 +31,13 @@ void tr2tls_start_process_clock(void)
	 	tr2tls_us_start_process =3D getnanotime() / 1000;
	 }
=09=20
	-static void fill_thread_name(struct strbuf *buf, const char *name_hint,
	-			     int thread_id)
	-{
	-	if (thread_id)
	-		strbuf_addf(buf, "th%02d:", thread_id);
	-	strbuf_addstr(buf, name_hint);
	-}
	-
	 struct tr2tls_thread_ctx *tr2tls_create_self(const char *name_hint,
	 					     uint64_t us_thread_start)
	 {
	-	struct tr2tls_thread_ctx *ctx;
	-	struct strbuf buf_name =3D STRBUF_INIT;
	+	struct tr2tls_thread_ctx *ctx =3D xcalloc(1, sizeof(*ctx));
	 	int thread_id =3D tr2tls_locked_increment(&tr2_next_thread_id);
=09=20
	-	fill_thread_name(&buf_name, name_hint, thread_id);
	-
	-	FLEX_ALLOC_MEM(ctx, thread_name, buf_name.buf, buf_name.len);
	-	strbuf_release(&buf_name);
	-
	+	ctx->thread_hint =3D name_hint;
	 	ctx->thread_id =3D thread_id;
=09=20
	 	/*
	@@ -120,7 +107,8 @@ void tr2tls_pop_self(void)
	 	struct tr2tls_thread_ctx *ctx =3D tr2tls_get_self();
=09=20
	 	if (!ctx->nr_open_regions)
	-		BUG("no open regions in thread '%s'", ctx->thread_name);
	+		BUG("no open regions in thread '%s' '%d'", ctx->thread_hint,
	+		    ctx->thread_id);
=09=20
	 	ctx->nr_open_regions--;
	 }
	diff --git a/trace2/tr2_tls.h b/trace2/tr2_tls.h
	index e306c9bf3ec..f873615ebef 100644
	--- a/trace2/tr2_tls.h
	+++ b/trace2/tr2_tls.h
	@@ -21,8 +21,8 @@ struct tr2tls_thread_ctx {
	 	unsigned int used_any_timer:1;
	 	unsigned int used_any_per_thread_timer:1;
	 	unsigned int used_any_counter:1;
	+	const char *thread_hint;
	 	unsigned int used_any_per_thread_counter:1;
	-	char thread_name[FLEX_ARRAY];
	 };
=09=20
	 /*
=09



1. https://lore.kernel.org/git/e3fd64ef-9e26-19da-7327-38ab77ae359a@jeffhos=
tetler.com/



> @@ -95,7 +97,6 @@ void tr2tls_unset_self(void)
>=20=20
>  	pthread_setspecific(tr2tls_key, NULL);
>=20=20
> -	strbuf_release(&ctx->thread_name);
>  	free(ctx->array_us_start);
>  	free(ctx);
>  }
> @@ -113,7 +114,7 @@ void tr2tls_pop_self(void)
>  	struct tr2tls_thread_ctx *ctx =3D tr2tls_get_self();
>=20=20
>  	if (!ctx->nr_open_regions)
> -		BUG("no open regions in thread '%s'", ctx->thread_name.buf);
> +		BUG("no open regions in thread '%s'", ctx->thread_name);
>=20=20
>  	ctx->nr_open_regions--;
>  }
> diff --git a/trace2/tr2_tls.h b/trace2/tr2_tls.h
> index f1ee58305d6..be0bc73d08f 100644
> --- a/trace2/tr2_tls.h
> +++ b/trace2/tr2_tls.h
> @@ -9,17 +9,12 @@
>   * There is NO relation to "transport layer security".
>   */
>=20=20
> -/*
> - * Arbitry limit for thread names for column alignment.
> - */
> -#define TR2_MAX_THREAD_NAME (24)
> -
>  struct tr2tls_thread_ctx {
> -	struct strbuf thread_name;
>  	uint64_t *array_us_start;
>  	size_t alloc;
>  	size_t nr_open_regions; /* plays role of "nr" in ALLOC_GROW */
>  	int thread_id;
> +	char thread_name[FLEX_ARRAY];
>  };
>=20=20
>  /*
> @@ -32,8 +27,6 @@ struct tr2tls_thread_ctx {
>   * upon the name of the thread-proc function).  For example:
>   *     { .thread_id=3D10, .thread_name=3D"th10fsm-listen" }
>   * This helps to identify and distinguish messages from concurrent threa=
ds.
> - * The ctx.thread_name field is truncated if necessary to help with colu=
mn
> - * alignment in printf-style messages.
>   *
>   * In this and all following functions the term "self" refers to the
>   * current thread.

