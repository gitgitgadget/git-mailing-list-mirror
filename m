Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 117F2C433F5
	for <git@archiver.kernel.org>; Tue, 24 May 2022 21:50:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241969AbiEXVu6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 May 2022 17:50:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241956AbiEXVu4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 May 2022 17:50:56 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98CA381490
        for <git@vger.kernel.org>; Tue, 24 May 2022 14:50:55 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id wh22so37872851ejb.7
        for <git@vger.kernel.org>; Tue, 24 May 2022 14:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=C5i3sQDYJxgMmfUlVJR5wQLjTKvTfSXJEHgaASnGeow=;
        b=PQ1da6YWS99XwE0y2rtUnIewgbE/KPAR2aCBN5UDAlPQ3YKwbld9p38mxveMglAKXW
         ai5EZzPbjh6LuSmi5NxipLQDJdzze0ogkHvkbo9kGJFLwy0MftjV9dAQNSqAP3xooU8R
         VsfZsabRfRWOOCbRV5C0FmbxxT5EBpA39T7LiGl8Kru4J4Ks5Pvy9VCcc5Fo8mS5M2ta
         R3PSBHmaKWoQ8Ehm7vIM3f9LFDCc0rezuz6/0zWs/m8ErAoWvD1ODfJF9euXS9vmsnnb
         D/rTVRz4AZysoB6VEwUB/jBLTaXtsc230IK8e+mIj9AkVeaTnZZzLETaMvgc91vL6N0b
         crNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=C5i3sQDYJxgMmfUlVJR5wQLjTKvTfSXJEHgaASnGeow=;
        b=fj6foJPsG1d0yX03E3lkC6TQXoPVUbVCv6yR89SqOLSiL0AsNBK5AcTyvLCD0zdQ/y
         SULwcNz0l+sBrdY0sQ26CBmjv1GJxXv9Zn3ER0s9iEF3V5/WQA6muIFJLpnCufX9jbbz
         gKD3Sd9WZRZY2QZabeEUo3sO+B6H2Vbp85JHEr/HDUGQKrarHaz6K7QV/uzTky5xDZ4j
         IcVWaE1csMkRHYFbioAjcA29hYsZmcZSks+xhzWsIPk6o09srjxTVgliusn+wS1/9VTO
         HciMPT3hGP7wfw7lv6Sb79YOaE0T90NYcAJ0D7m5w5zaxBAP2LdJOanh2zLhJkS2taT5
         h6Hg==
X-Gm-Message-State: AOAM533csRoLRXpilzgOEVgxxyrHuIJkWeHtCcg57zFUu78DJGCUflHC
        peuagHioOYNoJsCahFOWFCY=
X-Google-Smtp-Source: ABdhPJxh/T6A/Yu6S50amz5vGgyN4QvrWCzDkLFBoAIG3f0Es6/bQmURTMRybq2gbcAgGXtyi3IwZg==
X-Received: by 2002:a17:907:1c8b:b0:6ff:1012:e7c with SMTP id nb11-20020a1709071c8b00b006ff10120e7cmr342797ejc.409.1653429054080;
        Tue, 24 May 2022 14:50:54 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id f21-20020a170906085500b006fe97996423sm3036231ejd.219.2022.05.24.14.50.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 May 2022 14:50:53 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1ntcQX-003c7Q-54;
        Tue, 24 May 2022 23:50:53 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, vdye@github.com, jonathantanmy@google.com,
        gitster@pobox.com
Subject: Re: [PATCH v2 3/4] builtin/pack-objects.c: ensure included
 `--stdin-packs` exist
Date:   Tue, 24 May 2022 23:49:38 +0200
References: <cover.1652458395.git.me@ttaylorr.com>
 <cover.1653418457.git.me@ttaylorr.com>
 <cdc3265ec27f04accc433d9e4e54ac0edc3b3746.1653418457.git.me@ttaylorr.com>
 <220524.86zgj6vhge.gmgdl@evledraar.gmail.com>
 <Yo1PRKUGgIyeDGKp@nand.local>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <Yo1PRKUGgIyeDGKp@nand.local>
Message-ID: <220524.861qwivbuq.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, May 24 2022, Taylor Blau wrote:

> On Tue, May 24, 2022 at 09:46:09PM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>>
>> On Tue, May 24 2022, Taylor Blau wrote:
>>
>> > -	struct rev_info *revs =3D _data;
>> > -	struct object_info oi =3D OBJECT_INFO_INIT;
>> >  	off_t ofs;
>> > -	enum object_type type;
>> > +	enum object_type type =3D OBJ_NONE;
>> >
>> >  	display_progress(progress_state, ++nr_seen);
>> >
>> > @@ -3215,20 +3213,25 @@ static int add_object_entry_from_pack(const st=
ruct object_id *oid,
>> >  	if (!want_object_in_pack(oid, 0, &p, &ofs))
>> >  		return 0;
>> >
>> > -	oi.typep =3D &type;
>> > -	if (packed_object_info(the_repository, p, ofs, &oi) < 0)
>> > -		die(_("could not get type of object %s in pack %s"),
>> > -		    oid_to_hex(oid), p->pack_name);
>> > -	else if (type =3D=3D OBJ_COMMIT) {
>> > -		/*
>> > -		 * commits in included packs are used as starting points for the
>> > -		 * subsequent revision walk
>> > -		 */
>> > -		add_pending_oid(revs, NULL, oid, 0);
>> > +	if (p) {
>> > +		struct rev_info *revs =3D _data;
>> > +		struct object_info oi =3D OBJECT_INFO_INIT;
>> > +
>> > +		oi.typep =3D &type;
>> > +		if (packed_object_info(the_repository, p, ofs, &oi) < 0) {
>> > +			die(_("could not get type of object %s in pack %s"),
>> > +			    oid_to_hex(oid), p->pack_name);
>> > +		} else if (type =3D=3D OBJ_COMMIT) {
>> > +			/*
>> > +			 * commits in included packs are used as starting points for the
>> > +			 * subsequent revision walk
>> > +			 */
>> > +			add_pending_oid(revs, NULL, oid, 0);
>> > +		}
>> > +
>> > +		stdin_packs_found_nr++;
>> >  	}
>> >
>> > -	stdin_packs_found_nr++;
>> > -
>> >  	create_object_entry(oid, type, 0, 0, 0, p, ofs);
>>
>> Not rhetorical, since I have no idea: Is the behavior change here to
>> make create_object_entry with type=3DOBJ_NONE desired? I.e. do we actual=
ly
>> want to create object entries for OBJ_NONE?
>
> This is intentional. OBJ_NONE tells create_object_entry() "we don't know
> the type of this object yet", and then `check_object()` (which does the
> bulk of the work in the "Counting objects" phase) goes through and fills
> in any missing type information.

Ah, I didn't know that.

> The caller in `builtin/pack-objects.c::read_object_list_from_stdin()` is
> a good example of this (all of the objects created this way start out
> with OBJ_NONE).
>
>> If that is the case I for one would find this a bit easier to follow
>> like this, even if it has some minor duplication, i.e. the intent is
>> clearer:
>>
>> 	diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
>> 	index ffeaecd1d84..a447f6d5164 100644
>> 	--- a/builtin/pack-objects.c
>> 	+++ b/builtin/pack-objects.c
>> 	@@ -3202,7 +3202,6 @@ static int add_object_entry_from_pack(const struc=
t object_id *oid,
>> 	 				      void *_data)
>> 	 {
>> 	 	off_t ofs;
>> 	-	enum object_type type =3D OBJ_NONE;
>>
>> 	 	display_progress(progress_state, ++nr_seen);
>>
>> 	@@ -3216,6 +3215,7 @@ static int add_object_entry_from_pack(const struc=
t object_id *oid,
>> 	 	if (p) {
>> 	 		struct rev_info *revs =3D _data;
>> 	 		struct object_info oi =3D OBJECT_INFO_INIT;
>> 	+		enum object_type type;
>>
>> 	 		oi.typep =3D &type;
>> 	 		if (packed_object_info(the_repository, p, ofs, &oi) < 0) {
>> 	@@ -3230,9 +3230,11 @@ static int add_object_entry_from_pack(const stru=
ct object_id *oid,
>> 	 		}
>>
>> 	 		stdin_packs_found_nr++;
>> 	-	}
>>
>> 	-	create_object_entry(oid, type, 0, 0, 0, p, ofs);
>> 	+		create_object_entry(oid, type, 0, 0, 0, p, ofs);
>> 	+	} else  {
>> 	+		create_object_entry(oid, OBJ_NONE, 0, 0, 0, p, ofs);
>> 	+	}
>>
>> 	 	return 0;
>> 	 }
>>
>> Or the same with adding "type =3D OBJ_NONE" to the "else" branch, leaving
>> the initial "type" uninitialized"?
>
> I'd be fine with that (and don't really have a very strong opinion
> either way). Let's see if anybody else has thoughts about it, and then
> I'm happy to change it in a subsequent version.

FWIW I think you should place a particularly low value on my suggestion
of this.

I.e. the last thing we should do is probably to optimize the code to be
read by someone who hadn't spent even 10 minutes finding out such
obvious major code-flow details, i.e. me not knowing about how OBJ_NONE
was used in this case....

So it's probably all fine as-is, but p erhaps others will think it's
good or whatever...
