Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24214C433F5
	for <git@archiver.kernel.org>; Tue, 31 May 2022 16:53:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236198AbiEaQxl (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 May 2022 12:53:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232657AbiEaQxk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 May 2022 12:53:40 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C020E8B0A9
        for <git@vger.kernel.org>; Tue, 31 May 2022 09:53:38 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id h19so10258880edj.0
        for <git@vger.kernel.org>; Tue, 31 May 2022 09:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=0YgkGOGvp1OzTXwcLdv8I1xFEpKFiWGc5R+/9FQFPuw=;
        b=BRPmfGvIkzUPQSeVJWS40q2SnSFpvfaIELyqwRev+92BjXkwbFWpuQSbIqqywtoYpn
         4jEJfYsqVG+K2GuwnumxWrMxnE/QwCSQAfk5SMjiqaYg40oMxA4REg4ozXpUnBMYDtkX
         kJhNygj0rB/KzL4afyn+miotO2PcYE2+Ls1jSzSE1W4OE3ZzaogQI+G80qQeqUWVzjrO
         G9o0v3okE2g5F4tl4TT7SzlZI9oIzGOQNSDS4SS2mIyVBPOAXfTC4WUC6gIoKf85sdWW
         qU5eTW5y7g/hU0s2JIT5FClJtgHQd8hsBM2LI6de1E1DLKEMzW4tkHooGM/M4I5ka4RV
         uPnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=0YgkGOGvp1OzTXwcLdv8I1xFEpKFiWGc5R+/9FQFPuw=;
        b=kK5EC84oeVTQyk2RsXr+OH+I6ce4AxqYKN2oRKyS5eeNXZ0WC1c9eumsIHD0ouVoRP
         Cvl/fKZcyiGTx3yyQ7SBZ8HE7ASASpAr5IN2XOgoatbkiWE5f/X557DKTTOgUq4JjfTo
         543WvIRbjA4TRkDpc0kX6p6p5/y8JxeEjeqD5Tfll5Glk6119MPNvDWd2MuiyPKUJhTG
         sScrNxEHi7KwRYOj21YsxztMnVZTT19wyyBYUE6vArp6igYn3jGA/Y8Vkqc8HKJoyVUO
         JMGT6af4na8UNaPEOL6VaAS00tiRZsUXoOoGanMexry8H7tx9Oo6VcfcGme0VXTerSfy
         7uPA==
X-Gm-Message-State: AOAM530lcQdKgZOxyApY3lSXafvKuavl9ob6zPs0MT7WtEXDHqatdE8o
        RpHIrmUFLZNqz6dNb/bXikU=
X-Google-Smtp-Source: ABdhPJxuGg1bCqsxyRP0dT6p9FEhoZhMf79zDP6vLSBVoyfVDWFV2uUaVtv+FMfEx3PQH6wr7TKg+Q==
X-Received: by 2002:a05:6402:f17:b0:42d:d3f3:244c with SMTP id i23-20020a0564020f1700b0042dd3f3244cmr10539693eda.52.1654016017172;
        Tue, 31 May 2022 09:53:37 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id y8-20020a50f1c8000000b0042dccb44e88sm4958439edl.23.2022.05.31.09.53.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 May 2022 09:53:35 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nw57e-000wpG-Fg;
        Tue, 31 May 2022 18:53:34 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Bagas Sanjaya <bagasdotme@gmail.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Subject: Re: [PATCH 1/5] usage.c: add a non-fatal bug() function to go with
 BUG()
Date:   Tue, 31 May 2022 18:52:14 +0200
References: <cover-0.5-00000000000-20220521T170939Z-avarab@gmail.com>
 <patch-1.5-faa1c708a79-20220521T170939Z-avarab@gmail.com>
 <xmqqpmk15o46.fsf@gitster.g> <xmqqh75d2aif.fsf@gitster.g>
 <220526.86fskw7mbv.gmgdl@evledraar.gmail.com> <xmqqleuo1beq.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <xmqqleuo1beq.fsf@gitster.g>
Message-ID: <220531.86tu951w4x.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, May 26 2022, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>> I don't think we should do it like that and keep it a BUG() not to call
>> BUG_if_bug() when we hit exit(), because e.g. in the case of
>> parse-options.c once we have the a bad "struct options" we don't want to
>> continue, as we might segfault, or have other bad behavior etc. So we'd
>> like to BUG() out as soon as possible.
>
> Oh, there is no question about that.  When we detect that the
> program is in an inconsistent and unexpected state, we would want to
> bug out instead of continuing at some point, and that is why we would
> want to have BUG_if_bug(), or exit_if_called_bug(), as I called in
> the message you are reponding to.
>
> What I am getting at is that the code often or usually calls
> BUG_if_bug() is not a reason to require it to be called, especially
> if there are conditional calls to bug() near the end of the program.
> Imagine a program, after finishing to respond to the end-user
> request, before the end of the program, performing some self sanity
> checks with a series of "if (condition) bug()", and there is no more
> thing that needs to be done other than exiting after such check.  I
> would have added such a call to sanity_check_refcnt() at the end of
> "git blame", for example, if the facility existed.

I'm re-rolling this and FWIW came up with this on top of the re-roll,
but didn't include it. It could also call the find_alignment() and
output(), but for this it seemed just leaving it at the bug() calls was
sufficient:

diff --git a/blame.c b/blame.c
index da1052ac94b..84c112f76bd 100644
--- a/blame.c
+++ b/blame.c
@@ -1155,21 +1155,15 @@ static int compare_commits_by_reverse_commit_date(c=
onst void *a,
  */
 static void sanity_check_refcnt(struct blame_scoreboard *sb)
 {
-	int baa =3D 0;
 	struct blame_entry *ent;
=20
-	for (ent =3D sb->ent; ent; ent =3D ent->next) {
+	for (ent =3D sb->ent; ent; ent =3D ent->next)
 		/* Nobody should have zero or negative refcnt */
-		if (ent->suspect->refcnt <=3D 0) {
-			fprintf(stderr, "%s in %s has negative refcnt %d\n",
-				ent->suspect->path,
-				oid_to_hex(&ent->suspect->commit->object.oid),
-				ent->suspect->refcnt);
-			baa =3D 1;
-		}
-	}
-	if (baa)
-		sb->on_sanity_fail(sb, baa);
+		if (ent->suspect->refcnt <=3D 0)
+			bug("%s in %s has negative refcnt %d",
+			    ent->suspect->path,
+			    oid_to_hex(&ent->suspect->commit->object.oid),
+			    ent->suspect->refcnt);
 }
=20
 /*
diff --git a/blame.h b/blame.h
index 38bde535b3d..f110bf3c40e 100644
--- a/blame.h
+++ b/blame.h
@@ -154,7 +154,6 @@ struct blame_scoreboard {
 	int debug;
=20
 	/* callbacks */
-	void(*on_sanity_fail)(struct blame_scoreboard *, int);
 	void(*found_guilty_entry)(struct blame_entry *, void *);
=20
 	void *found_guilty_entry_data;
diff --git a/builtin/blame.c b/builtin/blame.c
index e33372c56b0..70f31e94d38 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -655,14 +655,6 @@ static void find_alignment(struct blame_scoreboard *sb=
, int *option)
 		abbrev =3D auto_abbrev + 1;
 }
=20
-static void sanity_check_on_fail(struct blame_scoreboard *sb, int baa)
-{
-	int opt =3D OUTPUT_SHOW_SCORE | OUTPUT_SHOW_NUMBER | OUTPUT_SHOW_NAME;
-	find_alignment(sb, &opt);
-	output(sb, opt);
-	die("Baa %d!", baa);
-}
-
 static unsigned parse_score(const char *arg)
 {
 	char *end;
@@ -1151,7 +1143,6 @@ int cmd_blame(int argc, const char **argv, const char=
 *prefix)
 		sb.copy_score =3D blame_copy_score;
=20
 	sb.debug =3D DEBUG_BLAME;
-	sb.on_sanity_fail =3D &sanity_check_on_fail;
=20
 	sb.show_root =3D show_root;
 	sb.xdl_opts =3D xdl_opts;


