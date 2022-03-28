Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F412C4332F
	for <git@archiver.kernel.org>; Mon, 28 Mar 2022 18:52:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245330AbiC1SyR (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Mar 2022 14:54:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245325AbiC1SyP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Mar 2022 14:54:15 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78D83644F9
        for <git@vger.kernel.org>; Mon, 28 Mar 2022 11:52:34 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id r23so18052985edb.0
        for <git@vger.kernel.org>; Mon, 28 Mar 2022 11:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=eteMXG8/ader2ErCTG/rzkC3RLqI7LGmlzw71jFlrPo=;
        b=c1xf8wg7XuV0aKBUAqPzQho2qaN2ge+LZ+CDKiHkONzwgmGBPJDC1lTSTVaF/YMbzT
         7oWMJKKxllfZ50b5gjg+9Sii0UM9WGQeujM4LRxf1kIIBZLHh+uF18PGjzql4kb3IqVa
         ShMl+QKoJQ36HiTrinYTsn/FGgF/9685RtVz4jl2oAVK/8t+SbfJxCrIknNWPTLy9RoQ
         NtgGoz8HgFt2K1gathVywr0Kr8arzFSm3QHdd3/NrSgxkq13R42WN1OzI2fmjwOxF2Lo
         TqGkjgHTY+u/Dd5ThNipStPxCTa/2W+q9CsbiIGCCoE3aT/3L0W62tOkdFDEwijJVo4w
         f3rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=eteMXG8/ader2ErCTG/rzkC3RLqI7LGmlzw71jFlrPo=;
        b=z0J/E9V/r3cO2mEq6e/foTxu8bCN8q3VJFQSDF4cwEkVGsv2vdY2lMVwBCiX620ouR
         IvstYKEedhoKITrSZieogMb2Qgj1GZP4nJtPXKpH8habtMZHJQFovReLbN9WNeco5EKw
         K+XaZ4ZJHYRKu1VbIeSfkeEaA8PREh/n30hUBhbc8e20dsSCrcDCJuyDB5HJ6NXGXsfg
         xgZNih+rZyOuIhFm/D6lu8q2DwuPItu+xllpr6BHXnIhTKMKW36hYeuZb52d4KYM1xRO
         sAQ+l1JqiAYCBBdAoh5w6RhTXsGHCgLjlfTJJ6wjPg1dkkFMZAylNThToLrVJ/Vf2m/R
         isPw==
X-Gm-Message-State: AOAM530nx+rmDHwwmPXnh7aJmrakpVy5HxjZojRgp3R/BkebKfdcHOdW
        8QEFfNjFY98HEUyWfBr5F64=
X-Google-Smtp-Source: ABdhPJwIp+mn2Yp6vBHwmcWJm6nhDzJ2SFsCCkWLnedjfdlbtw61GcZII0nD6s9C5lfOGvK59OagyQ==
X-Received: by 2002:a05:6402:3595:b0:419:336b:29e4 with SMTP id y21-20020a056402359500b00419336b29e4mr17910847edc.63.1648493552780;
        Mon, 28 Mar 2022 11:52:32 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id bw26-20020a170906c1da00b006c8aeca8febsm6183281ejb.47.2022.03.28.11.52.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Mar 2022 11:52:32 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nYuTf-003Nqi-6X;
        Mon, 28 Mar 2022 20:52:31 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Tao Klerks <tao@klerks.biz>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Tao Klerks via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v3] tracking branches: add advice to ambiguous refspec
 error
Date:   Mon, 28 Mar 2022 20:50:43 +0200
References: <pull.1183.v2.git.1647940686394.gitgitgadget@gmail.com>
 <pull.1183.v3.git.1648450268285.gitgitgadget@gmail.com>
 <xmqqwnge2ghe.fsf@gitster.g>
 <kl6l7d8et314.fsf@chooglen-macbookpro.roam.corp.google.com>
 <xmqqilry2dq7.fsf@gitster.g>
 <CAPMMpojYJ9sB7nbAAt1b_yH0Um1O-+TpSRYXTkZ6aDHobhS59A@mail.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.11
In-reply-to: <CAPMMpojYJ9sB7nbAAt1b_yH0Um1O-+TpSRYXTkZ6aDHobhS59A@mail.gmail.com>
Message-ID: <220328.86y20t3o5s.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Mar 28 2022, Tao Klerks wrote:

> On Mon, Mar 28, 2022 at 7:23 PM Junio C Hamano <gitster@pobox.com> wrote:
>>
>> Glen Choo <chooglen@google.com> writes:
>>
>> > Hm, what do you think of an alternate approach of storing of the
>> > matching remotes in a string_list, something like:
> [...]
>> > then construct the advice message in setup_tracking()? To my untrained
>> > eye, "case 2" requires a bit of extra work to understand.
>
> Interestingly, that was what I had in the original RFC. I started using
> the strbuf later, after =C3=86var confirmed that a single "advise()" call=
 is
> the way to go. I understood building the string as we go to lead to
> simpler code, as it meant one less loop. On the other hand I
> understand Junio is more concerned about performance than the
> existence of a second loop that we should almost never hit.
>
> I'm very happy to switch from strbuf-building to string_list-appending,
> but I'm curious to understand how/why the performance of
> strbuf_addf() would be notably worse than that of
> string_list_append().
>
> Is there public doc about this somewhere?

We could do a string_list as in your v1 and concat it as we're
formatting it, but pushing new strings to a string_list v.s. appending
to a strbuf is actually more efficient in favor of the strbuf.

But as to not penalizing those who don't have the advice enabled,
something like this (untested)?:

diff --git a/branch.c b/branch.c
index 5c28d432103..83545456c36 100644
--- a/branch.c
+++ b/branch.c
@@ -20,6 +20,7 @@ struct tracking {
=20
 struct find_tracked_branch_cb {
 	struct tracking *tracking;
+	unsigned int do_advice:1;
 	struct strbuf remotes_advice;
 };
=20
@@ -36,6 +37,9 @@ static int find_tracked_branch(struct remote *remote, voi=
d *priv)
 			free(tracking->spec.src);
 			string_list_clear(tracking->srcs, 0);
 		}
+		tracking->spec.src =3D NULL;
+		if (!ftb->do_advice)
+			return 0;
 		/*
 		 * TRANSLATORS: This is a line listing a remote with duplicate
 		 * refspecs, to be later included in advice message
@@ -43,7 +47,6 @@ static int find_tracked_branch(struct remote *remote, voi=
d *priv)
 		 * to swap the "%s" and leading "  " space around.
 		 */
 		strbuf_addf(&ftb->remotes_advice, _("  %s\n"), remote->name);
-		tracking->spec.src =3D NULL;
 	}
=20
 	return 0;
@@ -249,6 +252,7 @@ static void setup_tracking(const char *new_ref, const c=
har *orig_ref,
 	struct find_tracked_branch_cb ftb_cb =3D {
 		.tracking =3D &tracking,
 		.remotes_advice =3D STRBUF_INIT,
+		.do_advice =3D advice_enabled(ADVICE_AMBIGUOUS_FETCH_REFSPEC),
 	};
=20
 	memset(&tracking, 0, sizeof(tracking));
@@ -273,7 +277,7 @@ static void setup_tracking(const char *new_ref, const c=
har *orig_ref,
 	if (tracking.matches > 1) {
 		int status =3D die_message(_("not tracking: ambiguous information for re=
f %s"),
 					    orig_ref);
-		if (advice_enabled(ADVICE_AMBIGUOUS_FETCH_REFSPEC))
+		if (ftb_cb.do_advice)
 			advise(_("There are multiple remotes whose fetch refspecs map to the re=
mote\n"
 				 "tracking ref %s:\n"
 				 "%s"
