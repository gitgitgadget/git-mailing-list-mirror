Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EF92C433EF
	for <git@archiver.kernel.org>; Thu,  3 Feb 2022 21:31:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355346AbiBCVbg (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Feb 2022 16:31:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355502AbiBCVba (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Feb 2022 16:31:30 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BCD6C061748
        for <git@vger.kernel.org>; Thu,  3 Feb 2022 13:31:25 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id k25so12678140ejp.5
        for <git@vger.kernel.org>; Thu, 03 Feb 2022 13:31:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=CXayoNZLUqjNJjLqxuCn8If5Hcbhk7tJKM94Za3B1Jc=;
        b=W0kDFIEfBpfO4zB3r3niZ8MWmbgYOax3oB5S6PnmAbOmyLa6I4AfqYlUnIi7rsBCV1
         JmDOaH4BFd/ql8Spn696JSNQCmowj8MtQ4vQ7bcuOk3qYEFWV1fHm8TJXTy/JIhp43rz
         B7PyyHAXJqFIcBdcZcqTsX6wf6PhSvDB74wh0IWVfEFfYNLhX+ieSE4LTvGm9eIGaf46
         I//dlBUZYFLvNzuZa8ZVaZiMv4OsrvSoUrx1hwbDbVQMozEb75o6bJr29e0ulih7lQBU
         c9n9w9y4rzmYeJWjiZluY548ryheNZ26ap1ehjbR7fFhpGuKkoqFWIe4epAc+8vshmrN
         0gBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=CXayoNZLUqjNJjLqxuCn8If5Hcbhk7tJKM94Za3B1Jc=;
        b=T2DthCi+9J+BCxXIvl9hDG7fUAPfcp2u3wK8LCgm/SpSio5ZJ9+L8bbvKTR4BLhUkJ
         W9bXj7SO2WV/1xc6fJs/RXUJG33jyY98aCniPq5ECOauy8avPgBiC0rhZc6NjZtfa93D
         xWUTfKW5j4FzwocBjkrW//DZqqBANmHlNbNsih4pAxszMGIhQZBt9zXp0e4k9BoM5y0j
         LN0RN1/J3Wpo7+my3pvFXD0hqh6+oAWcaUaMOZd2oWPjOLcEmyWyvCDHOKdcYrDuV4HY
         qLYzNZ3jh0hDQvUOjtTzoe+D6uwyPk+MeGDCs206Iw7EWm5QiUuPRu/s/55x7+N2UkuM
         UeUw==
X-Gm-Message-State: AOAM531SPw7ZRj6O/QudMN0nBA9ZdNeDGdHKSHP9vQN6AhAZPBE09qoy
        w6RkLAD042jKzV5scWtHhcLt08QzmzU=
X-Google-Smtp-Source: ABdhPJxYcphEDHoQTej6jl8vgguCuaKKEgiyeRue6CnmVroiupo1bz/hXMGWN6yLEdcqbfAcAgnanA==
X-Received: by 2002:a17:906:730a:: with SMTP id di10mr31416617ejc.489.1643923883794;
        Thu, 03 Feb 2022 13:31:23 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id k20sm23717eja.14.2022.02.03.13.31.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Feb 2022 13:31:23 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nFjhK-005EDT-EY;
        Thu, 03 Feb 2022 22:31:22 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Han-Wen Nienhuys <hanwen@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: Re: [PATCH v2] refs.h: make all flags arguments unsigned
Date:   Thu, 03 Feb 2022 22:20:39 +0100
References: <pull.1210.git.git.1643660136530.gitgitgadget@gmail.com>
 <pull.1210.v2.git.git.1643719616840.gitgitgadget@gmail.com>
 <220201.86ilty9vq2.gmgdl@evledraar.gmail.com> <xmqq8ruub35i.fsf@gitster.g>
 <CAFQ2z_Oxq67XO20oG7Tokk48wm5ZzHRR3GDi4PG5wg7FMJ89aA@mail.gmail.com>
 <220203.8635kz6d2o.gmgdl@evledraar.gmail.com>
 <CAFQ2z_NWM0F1uY==rCrc2pvJYjgPyOHz5aLFLSng-DvgiQVxqw@mail.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <CAFQ2z_NWM0F1uY==rCrc2pvJYjgPyOHz5aLFLSng-DvgiQVxqw@mail.gmail.com>
Message-ID: <220203.86tudf4oyd.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Feb 03 2022, Han-Wen Nienhuys wrote:

> On Thu, Feb 3, 2022 at 7:05 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <av=
arab@gmail.com> wrote:
>> > I proposed both options because a distinct typename lets me jump to
>> > the definition of the flags easily through ctags.
>>
>> I'm not sure I understand you here. I use ctags (via Emacs) and it's
>
> "I proposed both options" (ie. enum or typedef) , so we are in
> resounding agreement.

Ah, so by "because a distinct typename lets me jump to the definition of
the flags easily through ctags." you mean one of "enum x" or "typedef
enum { ... } x", not just the latter?

>> > Another idea is to mark the type of the flags by its name, eg.
>> > transaction_flags, resolve_flags, reftype_flags etc. This wouldn't
>> > help with ctags, but it does help with readability.
>>
>> Yes, enums or not, what I was also pointing out in
>> https://lore.kernel.org/git/220201.86ilty9vq2.gmgdl@evledraar.gmail.com/
>> is that changing just one logical set of flags at a time would make this
>> much easier to review.
>>
>> It doesn't matter for the end result as long as we end up with "unsigned
>> int" everywhere, but would with enums.
>
> Not sure if you need to review it in that detail. If you change a
> definition in the .h file,  the compiler will complain about all
> mismatches. So it doesn't need human verification once you know it
> compiles.

That's true in C++ I think, but not C. Or do you have a compiler that'll
warn about e.g. this change:
=09
	diff --git a/refs.c b/refs.c
	index addb26293b4..e6c3931ec00 100644
	--- a/refs.c
	+++ b/refs.c
	@@ -1078,7 +1078,7 @@ int ref_transaction_update(struct ref_transaction *t=
ransaction,
	 			   const char *refname,
	 			   const struct object_id *new_oid,
	 			   const struct object_id *old_oid,
	-			   unsigned int flags, const char *msg,
	+			   enum foobar flags, const char *msg,
	 			   struct strbuf *err)
	 {
	 	assert(err);
	diff --git a/refs.h b/refs.h
	index 8f91a7f9ff2..63dde1da4de 100644
	--- a/refs.h
	+++ b/refs.h
	@@ -670,11 +670,12 @@ struct ref_transaction *ref_transaction_begin(struct=
 strbuf *err);
	  * See the above comment "Reference transaction updates" for more
	  * information.
	  */
	+enum foobar { FOOBAR =3D 0 };
	 int ref_transaction_update(struct ref_transaction *transaction,
	 			   const char *refname,
	 			   const struct object_id *new_oid,
	 			   const struct object_id *old_oid,
	-			   unsigned int flags, const char *msg,
	+			   enum foobar flags, const char *msg,
	 			   struct strbuf *err);
=09=20
	 /*

What I'm referring to, keeping in mind that that doesn't warn, is that
since we can't get the compiler to whine about e.g. that "flags" being
compared against values not in the enum, or when I pass that "enum" to a
not-that-enum right after in ref_transaction_add_update() is that it's
extra useful for reviewing these sorts of changes if what's logically
one flag is changed at a time, as opposed to a big search/replacement
(and tracking things down for s/int/enum/ would force one to do that).

For doing this sort of change in C I find it to be a useful technique to do=
 this:
=09
	diff --git a/refs.c b/refs.c
	index addb26293b4..ab58dd8948d 100644
	--- a/refs.c
	+++ b/refs.c
	@@ -1078,7 +1078,7 @@ int ref_transaction_update(struct ref_transaction *t=
ransaction,
	 			   const char *refname,
	 			   const struct object_id *new_oid,
	 			   const struct object_id *old_oid,
	-			   unsigned int flags, const char *msg,
	+			   unsigned int *flags, const char *msg,
	 			   struct strbuf *err)
	 {
	 	assert(err);
	diff --git a/refs.h b/refs.h
	index 8f91a7f9ff2..80ef4616838 100644
	--- a/refs.h
	+++ b/refs.h
	@@ -674,7 +674,7 @@ int ref_transaction_update(struct ref_transaction *tra=
nsaction,
	 			   const char *refname,
	 			   const struct object_id *new_oid,
	 			   const struct object_id *old_oid,
	-			   unsigned int flags, const char *msg,
	+			   unsigned int *flags, const char *msg,
	 			   struct strbuf *err);
=09=20
	 /*


Which will get you a hard compilation error, e.g.:
=09
	$ make builtin/update-ref.o
	    CC builtin/update-ref.o
	builtin/update-ref.c:205:8: error: incompatible integer to pointer convers=
ion passing 'unsigned int' to parameter of type 'unsigned int *' [-Werror,-=
Wint-conversion]
	                                   update_flags | create_reflog_flag,
	                                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	./refs.h:677:21: note: passing argument to parameter 'flags' here
	                           unsigned int *flags, const char *msg,
	                                         ^
	1 error generated.
	make: *** [Makefile:2542: builtin/update-ref.o] Error 1

Which you'd then "fix" like this:
=09=09
	diff --git a/builtin/update-ref.c b/builtin/update-ref.c
	index a84e7b47a20..33bcde36871 100644
	--- a/builtin/update-ref.c
	+++ b/builtin/update-ref.c
	@@ -185,6 +185,7 @@ static void parse_cmd_update(struct ref_transaction *t=
ransaction,
	 	char *refname;
	 	struct object_id new_oid, old_oid;
	 	int have_old;
	+	unsigned int f =3D update_flags | create_reflog_flag;
=09=20
	 	refname =3D parse_refname(&next);
	 	if (!refname)
	@@ -202,7 +203,7 @@ static void parse_cmd_update(struct ref_transaction *t=
ransaction,
=09=20
	 	if (ref_transaction_update(transaction, refname,
	 				   &new_oid, have_old ? &old_oid : NULL,
	-				   update_flags | create_reflog_flag,
	+				   &f,
	 				   msg, &err))
	 		die("%s", err.buf);
=09=20
Now, obviously those changes suck, but the point is that if you do it
like that you can be assured that you got all callsites, so if you first
change it to an "int *", then get it to compile, and then search/replace
the resulting hunks you just changed & repeat, you can be assured that
you got all the callers, and that we don't have cases left where an
"int" becomes "unsigned int", or that our shiny new "enum" is
immediately passed as an "int" etc.
