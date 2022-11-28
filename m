Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69562C43217
	for <git@archiver.kernel.org>; Mon, 28 Nov 2022 12:31:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230040AbiK1Mbr (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Nov 2022 07:31:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbiK1Mbq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Nov 2022 07:31:46 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 841C2E000
        for <git@vger.kernel.org>; Mon, 28 Nov 2022 04:31:44 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id fy37so25319699ejc.11
        for <git@vger.kernel.org>; Mon, 28 Nov 2022 04:31:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XBwNOfw4xVqSPqYdUvtFj4X2haxhmPr5LqMFD8KkcmE=;
        b=Zfk3acuiaOxjA8HkPnDgPRi6UaoVKN+uddO89Trhytnh4+2p93H7TNuNKKkxahP4A8
         99Tjnf9nrnqF5spqwaHdHZtmcYJEHyk5CM6f5+vpJk5w9CkC1J22ol9//WblEXp0CRtk
         oxESU+UooZO7VW8ijdRuL9ttUKrs5T3pi9AYO/8XIC1v+uP51MZlR6iKhn9BEHNpFqew
         1nbEGi3uvJmWEVhfqazuHypUJuja68p3V5IBA4iLz3dacR0/kVIQGcFSeUc06T6CVujE
         Tth8DsthexKP8HLm02vc7x6nAFFv9OvMcB6uHyxgHn3NdmJPycB9bp41V1vESAPJDqgD
         Vi5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XBwNOfw4xVqSPqYdUvtFj4X2haxhmPr5LqMFD8KkcmE=;
        b=MEktm+CS6VW56XxlEcr4pz8C376BoOZKa8xygmbG613v5mqDbVAe3yfXegC3Wy2k+h
         nISABzC4grqndsPr8ri0TdFNvIikjgysxbAbxEZmOPCtKXoSVpuExXAIDe6FqERYYMZG
         2932jtJj3ByBZ6LQ3Dn783bvBqwddMY6P99Qyd8/pLj2fUrY/Cv72R6N2tqP5TsA6o9Y
         QhhNX3upSGOmJ/JHhPb38A1ckUU81fxwEOeB8prvi98+qHLhCA/l+j98tVYqZZQU+HUH
         v/jS9TQ2sNR/YYXlcGXibbyI8aiSB6mVbB3uPKhZh5l985f5jn9Hc7we0WnCJXS+3f5G
         RI+Q==
X-Gm-Message-State: ANoB5pmeqk46wD5QYjAk+YIzPkZSSCXksH+SX9r7y8GnuUkQtdHjuzh3
        5rFfAOCbPluZILPQkbBSZ8c=
X-Google-Smtp-Source: AA0mqf4SEAPm2ejoiMXKIY+9Rfv6VZ6V/nWP7QFyPAB3EGlcB59w9vJFE8zGMTYlJqhYDTvw/7EsJw==
X-Received: by 2002:a17:906:a148:b0:7ad:b286:8ee2 with SMTP id bu8-20020a170906a14800b007adb2868ee2mr745742ejb.511.1669638702898;
        Mon, 28 Nov 2022 04:31:42 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id i16-20020a17090639d000b00779cde476e4sm4901260eje.62.2022.11.28.04.31.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Nov 2022 04:31:42 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1ozdIT-0011t2-2z;
        Mon, 28 Nov 2022 13:31:41 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Taylor Blau <me@ttaylorr.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 3/3] Revert "pack-objects: lazily set up "struct
 rev_info", don't leak"
Date:   Mon, 28 Nov 2022 13:24:33 +0100
References: <c64e4fa5-62c2-2a93-a4ef-bd84407ea570@web.de>
 <d19c6cb4-611f-afea-8a14-5e58d7509113@web.de>
 <f5779e19-813c-cda9-2f84-9fe58f745e89@web.de> <xmqqv8mz5ras.fsf@gitster.g>
 <d10de9b5-e5ff-18d6-d950-1d090d87b113@web.de>
 <221128.864jujmhgp.gmgdl@evledraar.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <221128.864jujmhgp.gmgdl@evledraar.gmail.com>
Message-ID: <221128.86zgcbl0pe.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Nov 28 2022, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

Ren=C3=A9:

> On Mon, Nov 28 2022, Ren=C3=A9 Scharfe wrote:
>
>> Am 28.11.2022 um 11:03 schrieb Junio C Hamano:
>>> Ren=C3=A9 Scharfe <l.s.r@web.de> writes:
>>>
>>>> This reverts commit 5cb28270a1ff94a0a23e67b479bbbec3bc993518.
>>>>
>>>> 5cb28270a1 (pack-objects: lazily set up "struct rev_info", don't leak,
>>>> 2022-03-28) avoided leaking rev_info allocations in many cases by
>>>> calling repo_init_revisions() only when the .filter member was actually
>>>> needed, but then still leaking it.  That was fixed later by 2108fe4a19
>>>> (revisions API users: add straightforward release_revisions(),
>>>> 2022-04-13), making the reverted commit unnecessary.
>>>
>>> Hmph, with this merged, 'seen' breaks linux-leaks job in a strange
>>> way.
>>>
>>> https://github.com/git/git/actions/runs/3563546608/jobs/5986458300#step=
:5:3917
>>>
>>> Does anybody want to help looking into it?
>
> [I see we crossed E-Mails]:
> https://lore.kernel.org/git/221128.868rjvmi3l.gmgdl@evledraar.gmail.com/
>
>> The patch exposes that release_revisions() leaks the diffopt allocations
>> as we're yet to address the TODO added by 54c8a7c379 (revisions API: add
>> a TODO for diff_free(&revs->diffopt), 2022-04-14).
>
> That's correct, and we have that leak in various places in our codebase,
> but per the above side-thread I think this is primarily exposing that
> we're setting up the "struct rev_info" with your change when we don't
> need to. Why can't we just skip it?
>
> Yeah, if we do set it up we'll run into an outstanding leak, and that
> should also be fixed (I have some local patches...), but the other cases
> I know of where we'll leak that data is where we're actually using the
> "struct rev_info".
>
> I haven't tried tearing your change apart to poke at it myself, and
> maybe there's some really good reason for why you can't separate getting
> rid of the J.5.7 dependency and removing the lazy-init.
>
>> The patch below plugs it locally.
>>
>> --- >8 ---
>> Subject: [PATCH 4/3] fixup! revision: free diffopt in release_revisions()
>>
>> Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
>> ---
>>  builtin/pack-objects.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
>> index 3e74fbb0cd..a47a3f0fba 100644
>> --- a/builtin/pack-objects.c
>> +++ b/builtin/pack-objects.c
>> @@ -4462,6 +4462,7 @@ int cmd_pack_objects(int argc, const char **argv, =
const char *prefix)
>>  	} else {
>>  		get_object_list(&revs, rp.nr, rp.v);
>>  	}
>> +	diff_free(&revs.diffopt);
>>  	release_revisions(&revs);
>>  	cleanup_preferred_base();
>>  	if (include_tag && nr_result)
>
> So, the main motivation for the change was paranoia that a compiler or
> platform might show up without J.5.7 support and that would bite us, but
> we're now adding a double-free-in-waiting?
>
> I think we're both a bit paranoid, but clearly have different
> paranoia-priorities :)
>
> If we do end up with some hack like this instead of fixing the
> underlying problem I'd much prefer that such a hack just be an UNLEAK()
> here.
>
> I.e. we have a destructor for "revs.*" already, let's not bypass it and
> start freeing things from under it, which will result in a double-free
> if we forget this callsite once the TODO in 54c8a7c379 is addressed.
>
> As you'd see if you made release_revisions() simply call
> diff_free(&revs.diffopt) doing so would reveal some really gnarly edge
> cases.
>
> I haven't dug into this one, but offhand I'm not confident in saying
> that this isn't exposing us to some aspect of that gnarlyness (maybe
> not, it's been a while since I looked).
>
> (IIRC some of the most gnarly edge cases will only show up as CI
> failures on Windows, to do with the ordering of when we'll fclose()
> files hanging off that "diffopt").

This squashed into 3/3 seems to me to be a proper fix to a change that
wants to refactor the code for non-J.5.7 compatibility. I.e. this just
does the data<->fp casting part of the change, without refactoring the
"lazy init".

But I think you should check this a bit more carefully. Your 3/3 says
that your change "mak[es] the reverted commit unnecessary", but as I
noted if you'd run the command that commit shows, you'd have seen you're
re-introducing the leak it fixed. So I wonder what else has been missed
here.

I vaguely recall that one reason I ended up with that J.5.7 dependency
was because there was an objection to mocking up the "struct option" as
I'm doing here. I.e. here we assume that the
opt_parse_list_objects_filter() is only ever going to care about the
"value" member.

I think that's probably fine, but I may be misrecalling, or missing some
crucial detail. I'll leave digging that up & convincing us that it's
fine to the person pushing for refactoring all of this :)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 3e74fbb0cd5..faf210bfe8c 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -4149,6 +4149,27 @@ static int option_parse_cruft_expiration(const struc=
t option *opt,
 	return 0;
 }
=20
+struct po_filter_data {
+	unsigned have_revs:1;
+	struct rev_info revs;
+};
+
+static int opt_parse_list_objects_filter_init(const struct option *opt,
+					      const char *arg, int unset)
+{
+	struct po_filter_data *data =3D opt->value;
+	struct rev_info *revs =3D &data->revs;
+	const struct option opt_rev =3D {
+		.value =3D (void *)&revs->filter,
+	};
+
+	if (!data->have_revs)
+		repo_init_revisions(the_repository, revs, NULL);
+	data->have_revs =3D 1;
+
+	return opt_parse_list_objects_filter(&opt_rev, arg, unset);
+}
+
 int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 {
 	int use_internal_rev_list =3D 0;
@@ -4159,7 +4180,7 @@ int cmd_pack_objects(int argc, const char **argv, con=
st char *prefix)
 	int rev_list_index =3D 0;
 	int stdin_packs =3D 0;
 	struct string_list keep_pack_list =3D STRING_LIST_INIT_NODUP;
-	struct rev_info revs;
+	struct po_filter_data pfd =3D { .have_revs =3D 0 };
=20
 	struct option pack_objects_options[] =3D {
 		OPT_SET_INT('q', "quiet", &progress,
@@ -4250,7 +4271,8 @@ int cmd_pack_objects(int argc, const char **argv, con=
st char *prefix)
 			      &write_bitmap_index,
 			      N_("write a bitmap index if possible"),
 			      WRITE_BITMAP_QUIET, PARSE_OPT_HIDDEN),
-		OPT_PARSE_LIST_OBJECTS_FILTER(&revs.filter),
+		OPT_CALLBACK(0, "filter", &pfd, N_("args"), N_("object filtering"),
+			     opt_parse_list_objects_filter_init),
 		OPT_CALLBACK_F(0, "missing", NULL, N_("action"),
 		  N_("handling for missing objects"), PARSE_OPT_NONEG,
 		  option_parse_missing_action),
@@ -4269,8 +4291,6 @@ int cmd_pack_objects(int argc, const char **argv, con=
st char *prefix)
=20
 	read_replace_refs =3D 0;
=20
-	repo_init_revisions(the_repository, &revs, NULL);
-
 	sparse =3D git_env_bool("GIT_TEST_PACK_SPARSE", -1);
 	if (the_repository->gitdir) {
 		prepare_repo_settings(the_repository);
@@ -4372,7 +4392,7 @@ int cmd_pack_objects(int argc, const char **argv, con=
st char *prefix)
 	if (!rev_list_all || !rev_list_reflog || !rev_list_index)
 		unpack_unreachable_expiration =3D 0;
=20
-	if (revs.filter.choice) {
+	if (pfd.have_revs && pfd.revs.filter.choice) {
 		if (!pack_to_stdout)
 			die(_("cannot use --filter without --stdout"));
 		if (stdin_packs)
@@ -4459,10 +4479,16 @@ int cmd_pack_objects(int argc, const char **argv, c=
onst char *prefix)
 		read_cruft_objects();
 	} else if (!use_internal_rev_list) {
 		read_object_list_from_stdin();
+	} else if (pfd.have_revs) {
+		get_object_list(&pfd.revs, rp.nr, rp.v);
+		release_revisions(&pfd.revs);
 	} else {
+		struct rev_info revs;
+
+		repo_init_revisions(the_repository, &revs, NULL);
 		get_object_list(&revs, rp.nr, rp.v);
+		release_revisions(&revs);
 	}
-	release_revisions(&revs);
 	cleanup_preferred_base();
 	if (include_tag && nr_result)
 		for_each_tag_ref(add_ref_tag, NULL);
