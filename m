Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAA09C433F5
	for <git@archiver.kernel.org>; Mon,  4 Oct 2021 15:43:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 82DD961357
	for <git@archiver.kernel.org>; Mon,  4 Oct 2021 15:43:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235851AbhJDPpk (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 Oct 2021 11:45:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235275AbhJDPpk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Oct 2021 11:45:40 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE76CC061745
        for <git@vger.kernel.org>; Mon,  4 Oct 2021 08:43:50 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id v18so65405369edc.11
        for <git@vger.kernel.org>; Mon, 04 Oct 2021 08:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=mAcdwd1z4960Eg1yEYFJ3MSCBRv1B6t7I16WXSD4LCc=;
        b=lFcYwvQdIxw4xWjFt4fzs80PFUE5TT6+4GgYXNkiDXCRDc1RrtKMh6gfZs0HiKLmfB
         +0dtF7TrxinTd/nsbfGsXo9YSbLkvcfOK5ABGoFUDeZP5H4zCeh2p3P6jAYa2blorsBu
         UY1Qy3g7FFGrO9lwCLGyS2tWWnlPbG4v37rxnWc+r7nZaDYKNOadvXQZfYlISYkpUE3c
         3h6dJQ8o/Voz3NP+J34RxIb7OkxWjYO6Xzj4shgQb1rzKuaPcItjYc6nGAQ2smjJx+uE
         SmB8L8DnxcrQfA7jgemSPFItC1mXtB1ZMj+GqI/OZ32+HJxJsK16jfeTPu31sqbaER3B
         aFbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=mAcdwd1z4960Eg1yEYFJ3MSCBRv1B6t7I16WXSD4LCc=;
        b=ILrnv3yTGA0cSv/8cBCzNeGI2qrygbG0qw5FPSSO0K0IhKa+iLFvb0wm2n/7rkfT8U
         gLQyo5LLhZwYs+yZY/8wUtC9e50sCHSnJLgG2c6NSJLqMCXzyA106dZcoPQrN1+MfiL0
         BjuqkMCdcJcvpFOzI2oqAJfiQYDyiDK9gTPp3K5rHtZHmR47sFvUPuh38MdxoNTjaufO
         TtX5bB5HbMclXzijczycQSvgVS6sj9igPOp/rWtlZ17nwYbF09oRnBK42u0ETen4qWKt
         SjsoU8E0WiSyvQtSr+dqPzN7eOO5w6bQjNVUzJWIfTvqJsFRcM4ohYnXY6M3EDOO00mO
         AZ0A==
X-Gm-Message-State: AOAM531AcT9+spw/KTSF8CCuheoQGCjjXI6AHjUaZe4WQCfbXgZrNI8M
        R1q1S7YXfkAVbqkKeODHJk+7kRupdYONhg==
X-Google-Smtp-Source: ABdhPJz7C3WajIVGbXbdQDMyt7wrjbUFspQoqfS3PR3+jZDV1EB/DCavhM0QYI7BNtpbl45k7OSI/A==
X-Received: by 2002:a17:907:1b1b:: with SMTP id mp27mr17852641ejc.538.1633362148941;
        Mon, 04 Oct 2021 08:42:28 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id bx11sm6817618ejb.107.2021.10.04.08.42.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Oct 2021 08:42:28 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Andrzej Hunt <ajrhunt@google.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH 04/10] unpack-trees API: don't have
 clear_unpack_trees_porcelain() reset
Date:   Mon, 04 Oct 2021 17:20:13 +0200
References: <cover-00.10-00000000000-20211004T002226Z-avarab@gmail.com>
 <patch-04.10-9d62edd35bf-20211004T002226Z-avarab@gmail.com>
 <CABPp-BH4ubjJ98Nvgp2iyKxmU9X+ypw4m1o=iL9Z4vSNZ-QTDw@mail.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <CABPp-BH4ubjJ98Nvgp2iyKxmU9X+ypw4m1o=iL9Z4vSNZ-QTDw@mail.gmail.com>
Message-ID: <87lf38n6e4.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Oct 04 2021, Elijah Newren wrote:

> On Sun, Oct 3, 2021 at 5:46 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <av=
arab@gmail.com> wrote:
>>
>> Change the clear_unpack_trees_porcelain() to be like a *_release()
>> function, not a *_reset() (in strbuf.c terms). Let's move the only API
>> user that relied on the latter to doing its own
>> unpack_trees_options_init(). See the commit that introduced
>> unpack_trees_options_init() for details on the control flow involved
>> here.
>>
>> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
>> ---
>>  merge-recursive.c | 1 +
>>  unpack-trees.c    | 1 -
>>  2 files changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/merge-recursive.c b/merge-recursive.c
>> index d24a4903f1d..a77f66b006c 100644
>> --- a/merge-recursive.c
>> +++ b/merge-recursive.c
>> @@ -442,6 +442,7 @@ static void unpack_trees_finish(struct merge_options=
 *opt)
>>  {
>>         discard_index(&opt->priv->orig_index);
>>         clear_unpack_trees_porcelain(&opt->priv->unpack_opts);
>> +       unpack_trees_options_init(&opt->priv->unpack_opts);
>
> This is wrong.  It suggests that unpack_opts is used after
> unpack_trees_finish() (other than an outer merge first calling
> unpack_trees_start() again), which can only serve to greatly confuse
> future readers.  Drop this hunk.

Sure, but (and also re:
https://lore.kernel.org/git/CABPp-BEA2myh2Np_YpFWnE+jqmT5vz7ohigZ0=3D2tL-wi=
zgYQmg@mail.gmail.com/)
if you'd like not initialize things in merge_start() just for good
measure wouldn't the diff-at-the-end on top of your 5bf7e5779ec
(merge-recursive: split internal fields into a separate struct,
2019-08-17) also make sense?

I.e. the reason I entered this particular rabbit hole was in looking at
existing members of "struct merge_options_internal" & past commits and
seeing how we did its initialization. That canary on top passes all our
tests, and per my reading we also don't use "df_conflict_file_set" until
as late as the things we setup in unpack_trees_start(). Should those be
moved to do the post-merge_start() setup at the same time?

>>  }
>>
>>  static int save_files_dirs(const struct object_id *oid,
>> diff --git a/unpack-trees.c b/unpack-trees.c
>> index 94767d3f96f..e7365322e82 100644
>> --- a/unpack-trees.c
>> +++ b/unpack-trees.c
>> @@ -197,7 +197,6 @@ void clear_unpack_trees_porcelain(struct unpack_tree=
s_options *opts)
>>  {
>>         strvec_clear(&opts->msgs_to_free);
>>         dir_clear(&opts->dir);
>> -       memset(opts->msgs, 0, sizeof(opts->msgs));
>
> This seems like a very dangerous change.  You want to leave opts->msgs
> pointing at freed memory?

Yes, as argued in
http://lore.kernel.org/git/87bl45niqs.fsf@evledraar.gmail.com; In this
series we can see that nothing re-uses it, so it's as safe as our
strbuf_release(), or a plain free().

Maybe I'm misunderstanding what you're getting at, and I could
understand a "let's just reset it for good measure" POV. But I can't
square your view that we shouldn't do setup in merge_start() for good
measure in case some new future code accidentally uses the data earlier
(which I'm fine with), but then also not finding it OK to skip the
memset() here ...

diff --git a/merge-recursive.c b/merge-recursive.c
index e594d4c3fa1..6d2b8e78896 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -601,6 +601,7 @@ static void record_df_conflict_files(struct merge_optio=
ns *opt,
 	df_sorted_entries.cmp =3D string_list_df_name_compare;
 	string_list_sort(&df_sorted_entries);
=20
+	assert(opt->priv->df_conflict_file_set.nr !=3D 123456);
 	string_list_clear(&opt->priv->df_conflict_file_set, 1);
 	for (i =3D 0; i < df_sorted_entries.nr; i++) {
 		const char *path =3D df_sorted_entries.items[i].string;
@@ -869,6 +870,7 @@ static int make_room_for_path(struct merge_options *opt=
, const char *path)
 	const char *msg =3D _("failed to create path '%s'%s");
=20
 	/* Unlink any D/F conflict files that are in the way */
+	assert(opt->priv->df_conflict_file_set.nr !=3D 123456);
 	for (i =3D 0; i < opt->priv->df_conflict_file_set.nr; i++) {
 		const char *df_path =3D opt->priv->df_conflict_file_set.items[i].string;
 		size_t pathlen =3D strlen(path);
@@ -3467,6 +3469,7 @@ static int merge_trees_internal(struct merge_options =
*opt,
 		return 1;
 	}
=20
+	string_list_init_dup(&opt->priv->df_conflict_file_set);
 	code =3D unpack_trees_start(opt, merge_base, head, merge);
=20
 	if (code !=3D 0) {
@@ -3703,7 +3706,7 @@ static int merge_start(struct merge_options *opt, str=
uct tree *head)
 	}
=20
 	CALLOC_ARRAY(opt->priv, 1);
-	string_list_init_dup(&opt->priv->df_conflict_file_set);
+	opt->priv->df_conflict_file_set.nr =3D 123456;
 	return 0;
 }
=20
