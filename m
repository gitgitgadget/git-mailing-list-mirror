Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7321BC43334
	for <git@archiver.kernel.org>; Tue, 12 Jul 2022 06:55:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbiGLGzo (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Jul 2022 02:55:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbiGLGze (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jul 2022 02:55:34 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E71F8C179
        for <git@vger.kernel.org>; Mon, 11 Jul 2022 23:55:33 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id l23so12634722ejr.5
        for <git@vger.kernel.org>; Mon, 11 Jul 2022 23:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=TC7gayjEBlPot7v4VIpU+5zf2A1EmWiHICGh3XAQIHo=;
        b=Qk+zB7uUt776e/g5S6Dl2Tn/T4enFkQvtdx/ZEd0q5hQU0Nn3ijmiSkzA96tJAS94b
         0EvInvQ6DVAA7M3QzW3wd22dtKVVyKmCwz3Kz2N5eEzGjYch/I/zVpIvG2OEm/UxzSeP
         iTMoNX9ScU4tQZSPZ5P0DC1sxgQcZg0eWz7SGB9HFNsot3/+rIkLhX3EFAy2RRxCqRhQ
         b4s+JilqLCq/j/hyOQpRcE9kTHu0JwajfjdX3+H3dnmGpzQvfX+uESZQ/pscaAMy/buu
         B631bK01O6AlP6qDaFW6DMKHq7GqcjXHI25/kbLu7+aiP17o5k6o1kyU5hBQs5NMQ0gh
         Gq7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=TC7gayjEBlPot7v4VIpU+5zf2A1EmWiHICGh3XAQIHo=;
        b=TX61sJX1f3I0293GqGfLHIKCVyw2jFoBOFE1HdgKMGBFwX7f7w8R0WwWB5cBfUJ+HN
         4z1atJYzELNwzEcv2DZcuC4etuaHPygU4MErGHk0/hVOibRvyYegXaXIM21H5M1BZw/F
         Xkq1mmz+aNdhQE9ax/J17OhQ5Rxeh+Dtngbbkj92S4wpgYkGmFS+oGjjcRVnmeO9R34d
         viGuPV5n34dNcI66R5UovvegdNEmFBmB1Bd/X/ugO7eCN/1np4vDuO9iQbb3E2u6pRXE
         W8QSDOY7M6r2ctSlXk0ctg51iS7E6u3k4wXkaGx0sO2jFYtP1BIU4EnPFUPkqO0EczG+
         MhnQ==
X-Gm-Message-State: AJIora/r9MbY2i5mkimTG1CyV1iOrVmtbM2YOgs0DtNBKMsWPVgAdxW7
        m+wSEAL2YfeGmeThEgck+B6b/8uqOkbXjw==
X-Google-Smtp-Source: AGRyM1usz2mH/JV/5fcgpmxdqfVaUjZpjvxA5sdIdFj9poxckTBFRAUwbQSkTgl0xWk10pC+oUCtbg==
X-Received: by 2002:a17:907:a055:b0:72b:16dd:d485 with SMTP id gz21-20020a170907a05500b0072b16ddd485mr22149389ejc.435.1657608931693;
        Mon, 11 Jul 2022 23:55:31 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id r21-20020aa7d155000000b00435a08a3557sm5472680edo.27.2022.07.11.23.55.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jul 2022 23:55:31 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1oB9nt-0018WY-L1;
        Tue, 12 Jul 2022 08:55:29 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Han Xin <chiyutianyi@gmail.com>, Git List <git@vger.kernel.org>
Subject: Re: [PATCH] unpack-objects: fix compilation warning/error due to
 missing braces
Date:   Tue, 12 Jul 2022 08:41:49 +0200
References: <20220710081135.74964-1-sunshine@sunshineco.com>
 <CAO0brD0PBXDqe2HDdjg1ZhXWoYZihQ0=SY80UR+Cy3xRqqH8Sg@mail.gmail.com>
 <CAPig+cQJWgerk08j=1b=aWRZsKBu3BnEACQuiqktU4BwzM-xaA@mail.gmail.com>
 <xmqq7d4kp8l6.fsf@gitster.g>
 <CAPig+cQMJcUc4gpRDpR=Q8M44rTjUA7SWgXNmzrnDH7V12z0dQ@mail.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <CAPig+cQMJcUc4gpRDpR=Q8M44rTjUA7SWgXNmzrnDH7V12z0dQ@mail.gmail.com>
Message-ID: <220712.86lesy6cri.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Jul 12 2022, Eric Sunshine wrote:

> On Mon, Jul 11, 2022 at 12:38 AM Junio C Hamano <gitster@pobox.com> wrote:
>> Eric Sunshine <sunshine@sunshineco.com> writes:
>> > On Sun, Jul 10, 2022 at 10:00 PM Han Xin <chiyutianyi@gmail.com> wrote:
>> >> On Sun, Jul 10, 2022 at 4:12 PM Eric Sunshine <sunshine@sunshineco.com> wrote:
>> >> > [1]: `cc --version` => "Apple LLVM version 10.0.0 (clang-1000.10.44.4)"
>> >> > -       git_zstream zstream = { 0 };
>> >> > +       git_zstream zstream = {{ 0 }};
>> >>
>> >> Not a comment, just wondering, when should I use "{ { 0 } }" and when
>> >> should I use "{ 0 }"?
>> >
>> > I don't have a good answer. More modern `clang` versions don't seem to
>> > complain about plain old `{0}` here, but the older `clang` with which
>> > I'm stuck does complain.
>>
>> I think, from the language-lawyer perspective, "{ 0 }" is how we
>> should spell these initialization when we are not using designated
>> initializers, even when the first member of the struct happens to be
>> a struct.
>>
>> The older clang that complains at you is simply buggy, and I think
>> we had the same issue with older sparse.
>
> I can't tell from your response whether or not you intend to pick up
> this patch. I don't disagree that older clang may be considered buggy
> in this regard, but older clang versions still exist in the wild, and
> we already support them by applying `{{0}}` when appropriate:
>
>     % git grep -n '{ *{ *0 *} *}'
>     builtin/merge-file.c:31: xmparam_t xmp = {{0}};

Not so fast :) If you check out "next", does compiling
builtin/merge-file.o there complain on that clang version now? I changed
this to the "{ 0 }" form.

If not I wonder if this has to do with one of git_zstream being
typedef'd, or with the first member being an embedded struct (I couldn't
find another example of that). For the former does the patch at the end
& "make builtin/unpack-objects.o" make it go away?


>     builtin/worktree.c:262: struct config_set cs = { { 0 } };
>     oidset.h:25:#define OIDSET_INIT { { 0 } }
>     worktree.c:840: struct config_set cs = { { 0 } };

Uh, and here are some other examples, so those also warn if you make
them just a "{ 0 }"?

> so the change made by this patch is in line with existing practice on
> this project.

It is nice though to be able to use standard C99 consistently, where a
"{ 0 }" recursively initializes the members, I think that's what your
clang version is doing, it's just complaining about it.

Since this is only a warning, and only a practical issue with -Werror I
wonder if a config.mak.dev change wouldn't be better, i.e. to provide a
-Wno-missing-braces for this older clang version.

The ad-hoc test patch referred to above:

diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
index 43789b8ef29..f08092cb26d 100644
--- a/builtin/unpack-objects.c
+++ b/builtin/unpack-objects.c
@@ -110,7 +110,7 @@ static void use(int bytes)
  */
 static void *get_data(unsigned long size)
 {
-	git_zstream stream;
+	struct git_zstream stream;
 	unsigned long bufsize = dry_run && size > 8192 ? 8192 : size;
 	void *buf = xmallocz(bufsize);
 
@@ -352,7 +352,7 @@ static void unpack_non_delta_entry(enum object_type type, unsigned long size,
 }
 
 struct input_zstream_data {
-	git_zstream *zstream;
+	struct git_zstream *zstream;
 	unsigned char buf[8192];
 	int status;
 };
@@ -361,7 +361,7 @@ static const void *feed_input_zstream(struct input_stream *in_stream,
 				      unsigned long *readlen)
 {
 	struct input_zstream_data *data = in_stream->data;
-	git_zstream *zstream = data->zstream;
+	struct git_zstream *zstream = data->zstream;
 	void *in = fill(1);
 
 	if (in_stream->is_finished) {
@@ -385,7 +385,7 @@ static const void *feed_input_zstream(struct input_stream *in_stream,
 
 static void stream_blob(unsigned long size, unsigned nr)
 {
-	git_zstream zstream = { 0 };
+	struct git_zstream zstream = { 0 };
 	struct input_zstream_data data = { 0 };
 	struct input_stream in_stream = {
 		.read = feed_input_zstream,
diff --git a/cache.h b/cache.h
index ac5ab4ef9d3..797f8e4edae 100644
--- a/cache.h
+++ b/cache.h
@@ -18,7 +18,7 @@
 #include "repository.h"
 #include "mem-pool.h"
 
-typedef struct git_zstream {
+struct git_zstream {
 	z_stream z;
 	unsigned long avail_in;
 	unsigned long avail_out;
@@ -26,21 +26,21 @@ typedef struct git_zstream {
 	unsigned long total_out;
 	unsigned char *next_in;
 	unsigned char *next_out;
-} git_zstream;
-
-void git_inflate_init(git_zstream *);
-void git_inflate_init_gzip_only(git_zstream *);
-void git_inflate_end(git_zstream *);
-int git_inflate(git_zstream *, int flush);
-
-void git_deflate_init(git_zstream *, int level);
-void git_deflate_init_gzip(git_zstream *, int level);
-void git_deflate_init_raw(git_zstream *, int level);
-void git_deflate_end(git_zstream *);
-int git_deflate_abort(git_zstream *);
-int git_deflate_end_gently(git_zstream *);
-int git_deflate(git_zstream *, int flush);
-unsigned long git_deflate_bound(git_zstream *, unsigned long);
+};
+
+void git_inflate_init(struct git_zstream *);
+void git_inflate_init_gzip_only(struct git_zstream *);
+void git_inflate_end(struct git_zstream *);
+int git_inflate(struct git_zstream *, int flush);
+
+void git_deflate_init(struct git_zstream *, int level);
+void git_deflate_init_gzip(struct git_zstream *, int level);
+void git_deflate_init_raw(struct git_zstream *, int level);
+void git_deflate_end(struct git_zstream *);
+int git_deflate_abort(struct git_zstream *);
+int git_deflate_end_gently(struct git_zstream *);
+int git_deflate(struct git_zstream *, int flush);
+unsigned long git_deflate_bound(struct git_zstream *, unsigned long);
 
 #if defined(DT_UNKNOWN) && !defined(NO_D_TYPE_IN_DIRENT)
 #define DTYPE(de)	((de)->d_type)
@@ -1372,7 +1372,7 @@ enum unpack_loose_header_result {
 	ULHR_BAD,
 	ULHR_TOO_LONG,
 };
-enum unpack_loose_header_result unpack_loose_header(git_zstream *stream,
+enum unpack_loose_header_result unpack_loose_header(struct git_zstream *stream,
 						    unsigned char *map,
 						    unsigned long mapsize,
 						    void *buffer,
