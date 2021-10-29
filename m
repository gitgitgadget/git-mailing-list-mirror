Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E786C433EF
	for <git@archiver.kernel.org>; Fri, 29 Oct 2021 10:57:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74D73610CF
	for <git@archiver.kernel.org>; Fri, 29 Oct 2021 10:57:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231788AbhJ2LAM (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Oct 2021 07:00:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231740AbhJ2LAM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Oct 2021 07:00:12 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BC37C061570
        for <git@vger.kernel.org>; Fri, 29 Oct 2021 03:57:42 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id w1so18442442edd.0
        for <git@vger.kernel.org>; Fri, 29 Oct 2021 03:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=Ty3hXPlzSGIWKq4kxbAe3v7g4pfG6Nie34qd6lPPSgA=;
        b=me6qMBvGwf/KofIqTXUYO+Q5kjNyuYpSrXAdJiWvS8iuW5bHgCNWNsLbXsO+WbklVm
         RHejf+u/P5+yf2wCRA6Kq/bOiXDp8wgTQNrGwO7NTgZJzNX3/t8GBb9XP4K6KbLtfjxo
         c4VKLFLaWCHiCWyy/hjfkZ4dDkX2FKjWeG9FlatEtQg55dx/sNYkAJyDDJyQWfg9BeDh
         xcomedAoCBaEPE418mZ9uS3u/bcZf0CviZgWOmVK9d109c58QAk6y++xyfrz8Cn3msQd
         ql65viaol2uFIPPjoW9dvtLkPVHBiM1T6jdJwIFVyFXxATKSxoERpYMBLA6Zi88bIWOE
         wzBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=Ty3hXPlzSGIWKq4kxbAe3v7g4pfG6Nie34qd6lPPSgA=;
        b=xTS/q3HbXZcKVTj+CXnxU2sh4Oax8vBNTYLTV9axuusNHGYL6ImXb/Y7IRrPQd2+Mo
         T2RKJCnkUvV+i3M9ADZyV2lZqoScik8LLF7uXQ1VDvwnO03zUSiqU+4PeTuXsfmilSQw
         h5A2nEYcozsoD9eloI48xRTcvPJPy4zqmuVYEN7jFmSd4aAxMwAA43sR4B7NilfsqAm7
         DsoVNMCiVohcLHqT7UI6BKu925bcsRV+swfdo7+2fOw9HG97mr6BCjGSTOtG8yzuTFjD
         /ew6fHgz5F5kG3TMhU5CB/UUnHBgolc4J9929cgm8AELkwCX+C/lmZ4rFp1jPqYuvImm
         2p9Q==
X-Gm-Message-State: AOAM5323Qe1ZbBoh1FnOH0R6StEyepH48ThrCv8LuV7j2mqh5OuNTaiV
        Qhs4Ygl2cugBaKdeGpuuXq8=
X-Google-Smtp-Source: ABdhPJzsV7u5xMZBBUr3JkRz6eyNNMNCL+IgUAGEAKEQ9406I3IJ/r/p5QMMfUzecgdmT/gIPqMl9w==
X-Received: by 2002:aa7:cb86:: with SMTP id r6mr14073320edt.236.1635505060918;
        Fri, 29 Oct 2021 03:57:40 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id ne10sm1872672ejc.67.2021.10.29.03.57.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Oct 2021 03:57:40 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mgPZr-0024gM-Q3;
        Fri, 29 Oct 2021 12:57:39 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Krzysztof =?utf-8?Q?=C5=BBelechows?= =?utf-8?Q?ki?= 
        <giecrilj@stegny.2a.pl>, git@vger.kernel.org,
        Hamza Mahfooz <someguy@effective-light.com>
Subject: Re: *Really* noisy encoding warnings post-v2.33.0
Date:   Fri, 29 Oct 2021 12:47:36 +0200
References: <9896630.2IqcCWsCYL@localhost.localdomain>
 <YSWVi8uLHZCTtG0l@coredump.intra.peff.net> <xmqqeeahjxj4.fsf@gitster.g>
 <YSkvNyR4uT52de13@coredump.intra.peff.net>
 <87ily7m1mv.fsf@evledraar.gmail.com>
 <YWEAEjIN0HVHbIpg@coredump.intra.peff.net>
 <YWEBmJk0aENR5Yeo@coredump.intra.peff.net>
 <871r4umfnm.fsf@evledraar.gmail.com>
 <YXkx6WzoF+B1id5T@coredump.intra.peff.net>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.6
In-reply-to: <YXkx6WzoF+B1id5T@coredump.intra.peff.net>
Message-ID: <211029.86bl38w124.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Oct 27 2021, Jeff King wrote:

> On Sat, Oct 09, 2021 at 03:47:16PM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>
>> But in this case this seems to have been because someone tried to feed
>> "HTML" to it, which is not an encoding, and something iconv_open() has
>> (I daresay) always and will always error on. It returns -1 and sets
>> errno=3DEINVAL.
>>=20
>> So having a warning or other detection in the revision loop seems
>> backwards to me, surely we want something like the below instead?
>> I.e. die as close to bad option parsing as possible?
>
> Sorry for the slow response; this got thrown on my "to think about and
> look at later" pile.
>
> Yeah, I agree that if we sanity-checked the encoding up front, that
> would cover the case we saw in practice, and goes a long way towards
> catching any practical errors.
>
> But I think this patch is tricky:
>
>> diff --git a/environment.c b/environment.c
>> index 43bb1b35ffe..c26b18f8e5c 100644
>> --- a/environment.c
>> +++ b/environment.c
>> @@ -357,8 +357,18 @@ void set_git_dir(const char *path, int make_realpat=
h)
>>=20=20
>>  const char *get_log_output_encoding(void)
>>  {
>> -	return git_log_output_encoding ? git_log_output_encoding
>> +	const char *encoding =3D git_log_output_encoding ? git_log_output_enco=
ding
>>  		: get_commit_output_encoding();
>> +#ifndef NO_ICONV
>> +	iconv_t conv;
>> +	conv =3D iconv_open(encoding, "UTF-8");
>> +	if (conv =3D=3D (iconv_t) -1 && errno =3D=3D EINVAL)
>> +		die_errno("the '%s' encoding is not known to iconv", encoding);
>> +#else
>> +	if (strcmp(encoding, "UTF-8"))
>> +		die("compiled with NO_ICONV=3DY, can't re-encode to '%s'", encoding);
>> +#endif
>> +	return encoding;
>>  }
>
> So one obvious problem here is that we call this function once per
> commit, so it's a lot of extra iconv_open() calls. But obviously we
> could use a static flag to do it once per process.

Yes, or the diff below, which seems like a better idea. I.e. stop
calling this in a loop if we know we'll need it, have setup_revisions()
populate it once.

> The other issue is that it is assuming UTF-8 on one end of the
> conversion. But we aren't necessarily doing such a conversion; it
> depends on the commit's on-disk encoding, and the requested output
> encoding. In particular:
>
>   - if both of those match, we do not need to call iconv at all (see the
>     same_encoding() check in repo_logmsg_reencode()). With the patch
>     above, the NO_ICONV case would start to die() when both are say
>     iso8859-1, even though it currently works.
>
>   - likewise, even if you have iconv support, it's possible that your
>     preferred encoding is not compatible with utf8. In which case
>     iconv_open() may complain, even though the actual conversion we'd
>     ask it to do would succeed.
>
> I.e., I don't think there's a way to just ask iconv "does this encoding
> name by itself make any sense". You can only ask it about to/from
> combos.

Yes, I'm not saying it covers the general problem, but that it covers
the specific complained-about issue of a completely nonsensical encoding
like "HTML". We should simply error on that on command startup, whether
or not we have any commits to visit.

But yes, if we want to cover specific encoding issues, e.g. not being
able to squash CJK UTF-8 into US-ASCII that needs to be per-commit,
but...

> So I think a much better version of this is to catch the _actual_
> iconv_open() call we make. And if it fails, say "woah, this combo of
> encodings isn't supported". The reason I didn't do that in the earlier
> patch is that all of this is obscured inside reencode_string_len(),
> which does both the iconv_open() and the iconv() call. We could surface
> that error information.
>
> But I'm not sure it would make sense to die() in that case. While for
> something like "git log --encoding=3Dnonsense" every commit is going to
> fail to re-encode, it's still possible that iconv_open() failures are
> commit-specific. I.e., you could have some garbage commit in your
> history with an unsupported encoding, and you wouldn't want to die() for
> it (it's the same case you are complaining about having a warning for,
> but much worse).
>
> I suspect the best we could do along these lines is to wait until a real
> iconv_open(to, from) fails, and then as a fallback try:
>
>   iconv_open("UTF-8", from);
>   iconv_open(to, "UTF-8");
>
> to sanity-check them individually, and guess that one of them is broken
> if it can't go to/from UTF-8. But even that feels like it's making
> assumptions about both the system iconv, and the charsets people use.
>
> To be clear, I'd expect that most people just use utf-8 in the first
> place, and even if they don't that their system has some basic utf-8
> support. But we are deep into the realm of weird corner cases here, and
> the utility of this warning / error-checking doesn't seem high enough to
> merit the possible regressions we'd get by trying to make too many
> assumptions.

I still think the right move here is to just revert your patch. Yes we
can think of a bunch of tricky edge cases that need to be fixed, but
this is a long-standing problem, and the change as-is has some pretty
bad UI problems.

I think any change that solves those (probably starting with the below)
is going to be relatively major this close to release.

So per <87ily7m1mv.fsf@evledraar.gmail.com> why can't we just revert the
warning(), and then consider a good way forward that covers some/all of
these cases we've noted?

Which should probably start with the below diff, so we can clearly
distinguish startup bad encoding names from runtime ones (we'd put that
proposed "die if iconv_open() doesn't like it" somewhere in
setup_revisions()).

diff --git a/builtin/log.c b/builtin/log.c
index f75d87e8d7f..2b3a607e947 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -539,7 +539,7 @@ static void show_tagger(const char *buf, struct rev_inf=
o *rev)
=20
 	pp.fmt =3D rev->commit_format;
 	pp.date_mode =3D rev->date_mode;
-	pp_user_info(&pp, "Tagger", &out, buf, get_log_output_encoding());
+	pp_user_info(&pp, "Tagger", &out, buf, rev->log_output_encoding);
 	fprintf(rev->diffopt.file, "%s", out.buf);
 	strbuf_release(&out);
 }
@@ -1208,7 +1208,7 @@ static void make_cover_letter(struct rev_info *rev, i=
nt use_separate_file,
 	log.file =3D rev->diffopt.file;
 	log.groups =3D SHORTLOG_GROUP_AUTHOR;
 	for (i =3D 0; i < nr; i++)
-		shortlog_add_commit(&log, list[i]);
+		shortlog_add_commit(rev, &log, list[i]);
=20
 	shortlog_output(&log);
=20
diff --git a/builtin/merge.c b/builtin/merge.c
index ea3112e0c0b..1a8fbafc149 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -431,6 +431,7 @@ static void squash_message(struct commit *commit, struc=
t commit_list *remotehead
 	ctx.abbrev =3D rev.abbrev;
 	ctx.date_mode =3D rev.date_mode;
 	ctx.fmt =3D rev.commit_format;
+	ctx.output_encoding =3D rev.log_output_encoding;
=20
 	strbuf_addstr(&out, "Squashed commit of the following:\n");
 	while ((commit =3D get_revision(&rev)) !=3D NULL) {
diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index 36cb909ebaa..905ba7462f3 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -165,7 +165,7 @@ static void show_commit(struct commit *commit, void *da=
ta)
 		ctx.date_mode =3D revs->date_mode;
 		ctx.date_mode_explicit =3D revs->date_mode_explicit;
 		ctx.fmt =3D revs->commit_format;
-		ctx.output_encoding =3D get_log_output_encoding();
+		ctx.output_encoding =3D revs->log_output_encoding;
 		ctx.color =3D revs->diffopt.use_color;
 		pretty_print_commit(&ctx, commit, &buf);
 		if (buf.len) {
diff --git a/builtin/shortlog.c b/builtin/shortlog.c
index e7f7af5de3f..2e5409a4fcc 100644
--- a/builtin/shortlog.c
+++ b/builtin/shortlog.c
@@ -198,7 +198,8 @@ static void insert_records_from_trailers(struct shortlo=
g *log,
 	unuse_commit_buffer(commit, commit_buffer);
 }
=20
-void shortlog_add_commit(struct shortlog *log, struct commit *commit)
+void shortlog_add_commit(struct rev_info *rev, struct shortlog *log,
+			 struct commit *commit)
 {
 	struct strbuf ident =3D STRBUF_INIT;
 	struct strbuf oneline =3D STRBUF_INIT;
@@ -210,7 +211,7 @@ void shortlog_add_commit(struct shortlog *log, struct c=
ommit *commit)
 	ctx.abbrev =3D log->abbrev;
 	ctx.print_email_subject =3D 1;
 	ctx.date_mode.type =3D DATE_NORMAL;
-	ctx.output_encoding =3D get_log_output_encoding();
+	ctx.output_encoding =3D rev->log_output_encoding;
=20
 	if (!log->summary) {
 		if (log->user_format)
@@ -254,7 +255,7 @@ static void get_from_rev(struct rev_info *rev, struct s=
hortlog *log)
 	if (prepare_revision_walk(rev))
 		die(_("revision walk setup failed"));
 	while ((commit =3D get_revision(rev)) !=3D NULL)
-		shortlog_add_commit(log, commit);
+		shortlog_add_commit(rev, log, commit);
 }
=20
 static int parse_uint(char const **arg, int comma, int defval)
diff --git a/bundle.c b/bundle.c
index a0bb687b0f4..32d74ab0bee 100644
--- a/bundle.c
+++ b/bundle.c
@@ -448,6 +448,7 @@ static int write_bundle_refs(int bundle_fd, struct rev_=
info *revs)
=20
 struct bundle_prerequisites_info {
 	struct object_array *pending;
+	struct rev_info *rev;
 	int fd;
 };
=20
@@ -464,7 +465,7 @@ static void write_bundle_prerequisites(struct commit *c=
ommit, void *data)
 	write_or_die(bpi->fd, buf.buf, buf.len);
=20
 	ctx.fmt =3D CMIT_FMT_ONELINE;
-	ctx.output_encoding =3D get_log_output_encoding();
+	ctx.output_encoding =3D bpi->rev->log_output_encoding;
 	strbuf_reset(&buf);
 	pretty_print_commit(&ctx, commit, &buf);
 	strbuf_trim(&buf);
@@ -544,6 +545,7 @@ int create_bundle(struct repository *r, const char *pat=
h,
 		die("revision walk setup failed");
 	bpi.fd =3D bundle_fd;
 	bpi.pending =3D &revs_copy.pending;
+	bpi.rev =3D &revs;
 	traverse_commit_list(&revs, write_bundle_prerequisites, NULL, &bpi);
 	object_array_remove_duplicates(&revs_copy.pending);
=20
diff --git a/log-tree.c b/log-tree.c
index 644893fd8cf..d79324d5bfd 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -737,7 +737,7 @@ void show_log(struct rev_info *opt)
=20
 		raw =3D (opt->commit_format =3D=3D CMIT_FMT_USERFORMAT);
 		format_display_notes(&commit->object.oid, &notebuf,
-				     get_log_output_encoding(), raw);
+				     opt->log_output_encoding, raw);
 		ctx.notes_message =3D strbuf_detach(&notebuf, NULL);
 	}
=20
@@ -758,7 +758,7 @@ void show_log(struct rev_info *opt)
 	ctx.mailmap =3D opt->mailmap;
 	ctx.color =3D opt->diffopt.use_color;
 	ctx.expand_tabs_in_log =3D opt->expand_tabs_in_log;
-	ctx.output_encoding =3D get_log_output_encoding();
+	ctx.output_encoding =3D opt->log_output_encoding;
 	ctx.rev =3D opt;
 	if (opt->from_ident.mail_begin && opt->from_ident.name_begin)
 		ctx.from_ident =3D &opt->from_ident;
diff --git a/pretty.c b/pretty.c
index fe95107ae5a..6eb64e8189d 100644
--- a/pretty.c
+++ b/pretty.c
@@ -2048,15 +2048,17 @@ void pretty_print_commit(struct pretty_print_contex=
t *pp,
 	int indent =3D 4;
 	const char *msg;
 	const char *reencoded;
-	const char *encoding;
+	const char *encoding =3D pp->output_encoding;
 	int need_8bit_cte =3D pp->need_8bit_cte;
=20
+	if (!encoding)
+		BUG("should have .output_encoding");
+
 	if (pp->fmt =3D=3D CMIT_FMT_USERFORMAT) {
 		format_commit_message(commit, user_format, sb, pp);
 		return;
 	}
=20
-	encoding =3D get_log_output_encoding();
 	msg =3D reencoded =3D logmsg_reencode(commit, NULL, encoding);
=20
 	if (pp->fmt =3D=3D CMIT_FMT_ONELINE || cmit_fmt_is_mail(pp->fmt))
@@ -2121,6 +2123,14 @@ void pp_commit_easy(enum cmit_fmt fmt, const struct =
commit *commit,
 		    struct strbuf *sb)
 {
 	struct pretty_print_context pp =3D {0};
+	static const char *output_encoding;
+
+	if (!output_encoding) {
+		const char *tmp =3D get_log_output_encoding();
+		output_encoding =3D tmp;
+	}
+=09
 	pp.fmt =3D fmt;
+	pp.output_encoding =3D output_encoding;
 	pretty_print_commit(&pp, commit, sb);
 }
diff --git a/remote-curl.c b/remote-curl.c
index d69156312bd..733a525bc73 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -345,8 +345,14 @@ static void free_discovery(struct discovery *d)
 static int show_http_message(struct strbuf *type, struct strbuf *charset,
 			     struct strbuf *msg)
 {
+	static const char *output_encoding;
 	const char *p, *eol;
=20
+	if (!output_encoding) {
+		const char *tmp =3D get_log_output_encoding();
+		output_encoding =3D tmp;
+	}
+
 	/*
 	 * We only show text/plain parts, as other types are likely
 	 * to be ugly to look at on the user's terminal.
@@ -354,7 +360,7 @@ static int show_http_message(struct strbuf *type, struc=
t strbuf *charset,
 	if (strcmp(type->buf, "text/plain"))
 		return -1;
 	if (charset->len)
-		strbuf_reencode(msg, charset->buf, get_log_output_encoding());
+		strbuf_reencode(msg, charset->buf, output_encoding);
=20
 	strbuf_trim(msg);
 	if (!msg->len)
diff --git a/revision.c b/revision.c
index ab7c1358042..0b2ad87f28e 100644
--- a/revision.c
+++ b/revision.c
@@ -2866,7 +2866,8 @@ int setup_revisions(int argc, const char **argv, stru=
ct rev_info *revs, struct s
=20
 	grep_commit_pattern_type(GREP_PATTERN_TYPE_UNSPECIFIED,
 				 &revs->grep_filter);
-	if (!is_encoding_utf8(get_log_output_encoding()))
+	revs->log_output_encoding =3D get_log_output_encoding();
+	if (!is_encoding_utf8(revs->log_output_encoding))
 		revs->grep_filter.ignore_locale =3D 1;
 	compile_grep_patterns(&revs->grep_filter);
=20
diff --git a/revision.h b/revision.h
index 5578bb4720a..bf9dbca727e 100644
--- a/revision.h
+++ b/revision.h
@@ -237,6 +237,7 @@ struct rev_info {
 	struct string_list *ref_message_ids;
 	int		add_signoff;
 	const char	*extra_headers;
+	const char	*log_output_encoding;
 	const char	*log_reencode;
 	const char	*subject_prefix;
 	int		patch_name_max;
diff --git a/shortlog.h b/shortlog.h
index 3f7e9aabcae..f809617f8a0 100644
--- a/shortlog.h
+++ b/shortlog.h
@@ -30,7 +30,9 @@ struct shortlog {
=20
 void shortlog_init(struct shortlog *log);
=20
-void shortlog_add_commit(struct shortlog *log, struct commit *commit);
+struct rev_info;
+void shortlog_add_commit(struct rev_info *rev, struct shortlog *log,
+			 struct commit *commit);
=20
 void shortlog_output(struct shortlog *log);
=20
diff --git a/submodule.c b/submodule.c
index c6890705241..f10e9c34ff6 100644
--- a/submodule.c
+++ b/submodule.c
@@ -501,7 +501,7 @@ static void print_submodule_diff_summary(struct reposit=
ory *r, struct rev_info *
 	while ((commit =3D get_revision(rev))) {
 		struct pretty_print_context ctx =3D {0};
 		ctx.date_mode =3D rev->date_mode;
-		ctx.output_encoding =3D get_log_output_encoding();
+		ctx.output_encoding =3D rev->log_output_encoding;
 		strbuf_setlen(&sb, 0);
 		repo_format_commit_message(r, commit, format, &sb,
 				      &ctx);
