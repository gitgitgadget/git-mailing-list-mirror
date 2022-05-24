Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 208C1C433F5
	for <git@archiver.kernel.org>; Tue, 24 May 2022 19:50:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241022AbiEXTt6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 May 2022 15:49:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239067AbiEXTt5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 May 2022 15:49:57 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 580897892E
        for <git@vger.kernel.org>; Tue, 24 May 2022 12:49:56 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id f21so23793316ejh.11
        for <git@vger.kernel.org>; Tue, 24 May 2022 12:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=rpyO5MxuNg2gr1mN/HWzvPmpc6yOUyOmaKlo0a6QzVU=;
        b=EN/4ZXo+DtUY6CUiO+tIMRartfllYgYoIcj1KjWhifJwljq4jNPH28NIz/DroQpCy+
         djtilXSlUWGX+7h5DMIYl0x79Ra/uTa73kD/DFMJQDCHt+9YQxKTgw5nSdKnI1G6Rcyy
         2eh5yVhNa5Zk+2EtU6eXgGApAKk7ADKZm13gdOEr/quYJQ1gCuI8n47gxrfTLw92/I13
         ssFpp4Dban1VXZQy0w+nr+hrPHdtU+VBLYdQKJxxPVgfI5IPQJTZM3UiEn4R3iBSKIIA
         YQhGw2xJbnkF70pNpgThrTf23h8QG4PJ0iu7PVZsgy376F/T4VbVI9Njgx81skiwjNkf
         x6uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=rpyO5MxuNg2gr1mN/HWzvPmpc6yOUyOmaKlo0a6QzVU=;
        b=Alj7pOexUaol6Dfh/LwM0EHMD+pr8v4Rrhjt3WxzJ+w0FCt2usv9jKuJLhAS6nUcmQ
         pFaczvKKLssuPLcFGvsW+IdGMvnDvkwlIAmNbEGnRMeOyTvfjU8TT/vuWGmtoJar7fFU
         QEy2C2HXEpBTTnqwlWxXIB3ButBwdFr/4x15+V2qoAB/nzsZGvOIOElkSaviL7lfhIcn
         +CaUohZTMbOj2obw1tvYRtfAuRCeK030FCvObyXlppVNa4W0jd97b2jVMxP2ubzkAy0k
         vfKGENo0eWXId6c9NmipkWQL9nY1LEOBRg/5TtmeWwc49aKeTB9v3Ic98tQfnfMEkCAe
         oL/w==
X-Gm-Message-State: AOAM532dl4MWxU+OrGYBGOVjlImm8ZnjYhcCN2ynoYL+6dGLo7xBWaHN
        KqYzlnCpa7tlz6nI0Aq5BrU=
X-Google-Smtp-Source: ABdhPJz4hMnKf892bjgsBZoUCeVuvYRXucTaziHxDvQQOKkKwzQfxQ83JAP5Sw+7wdRjQjpDmyco/A==
X-Received: by 2002:a17:907:3dac:b0:6fe:c707:94e7 with SMTP id he44-20020a1709073dac00b006fec70794e7mr13132469ejc.268.1653421794809;
        Tue, 24 May 2022 12:49:54 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id 23-20020a17090600d700b006f4b2aab627sm7461530eji.222.2022.05.24.12.49.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 May 2022 12:49:54 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1ntaXR-003XTn-Le;
        Tue, 24 May 2022 21:49:53 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, vdye@github.com, jonathantanmy@google.com,
        gitster@pobox.com
Subject: Re: [PATCH v2 3/4] builtin/pack-objects.c: ensure included
 `--stdin-packs` exist
Date:   Tue, 24 May 2022 21:46:09 +0200
References: <cover.1652458395.git.me@ttaylorr.com>
 <cover.1653418457.git.me@ttaylorr.com>
 <cdc3265ec27f04accc433d9e4e54ac0edc3b3746.1653418457.git.me@ttaylorr.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <cdc3265ec27f04accc433d9e4e54ac0edc3b3746.1653418457.git.me@ttaylorr.com>
Message-ID: <220524.86zgj6vhge.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, May 24 2022, Taylor Blau wrote:

> -	struct rev_info *revs = _data;
> -	struct object_info oi = OBJECT_INFO_INIT;
>  	off_t ofs;
> -	enum object_type type;
> +	enum object_type type = OBJ_NONE;
>  
>  	display_progress(progress_state, ++nr_seen);
>  
> @@ -3215,20 +3213,25 @@ static int add_object_entry_from_pack(const struct object_id *oid,
>  	if (!want_object_in_pack(oid, 0, &p, &ofs))
>  		return 0;
>  
> -	oi.typep = &type;
> -	if (packed_object_info(the_repository, p, ofs, &oi) < 0)
> -		die(_("could not get type of object %s in pack %s"),
> -		    oid_to_hex(oid), p->pack_name);
> -	else if (type == OBJ_COMMIT) {
> -		/*
> -		 * commits in included packs are used as starting points for the
> -		 * subsequent revision walk
> -		 */
> -		add_pending_oid(revs, NULL, oid, 0);
> +	if (p) {
> +		struct rev_info *revs = _data;
> +		struct object_info oi = OBJECT_INFO_INIT;
> +
> +		oi.typep = &type;
> +		if (packed_object_info(the_repository, p, ofs, &oi) < 0) {
> +			die(_("could not get type of object %s in pack %s"),
> +			    oid_to_hex(oid), p->pack_name);
> +		} else if (type == OBJ_COMMIT) {
> +			/*
> +			 * commits in included packs are used as starting points for the
> +			 * subsequent revision walk
> +			 */
> +			add_pending_oid(revs, NULL, oid, 0);
> +		}
> +
> +		stdin_packs_found_nr++;
>  	}
>  
> -	stdin_packs_found_nr++;
> -
>  	create_object_entry(oid, type, 0, 0, 0, p, ofs);

Not rhetorical, since I have no idea: Is the behavior change here to
make create_object_entry with type=OBJ_NONE desired? I.e. do we actually
want to create object entries for OBJ_NONE?

If that is the case I for one would find this a bit easier to follow
like this, even if it has some minor duplication, i.e. the intent is
clearer:
	
	diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
	index ffeaecd1d84..a447f6d5164 100644
	--- a/builtin/pack-objects.c
	+++ b/builtin/pack-objects.c
	@@ -3202,7 +3202,6 @@ static int add_object_entry_from_pack(const struct object_id *oid,
	 				      void *_data)
	 {
	 	off_t ofs;
	-	enum object_type type = OBJ_NONE;
	 
	 	display_progress(progress_state, ++nr_seen);
	 
	@@ -3216,6 +3215,7 @@ static int add_object_entry_from_pack(const struct object_id *oid,
	 	if (p) {
	 		struct rev_info *revs = _data;
	 		struct object_info oi = OBJECT_INFO_INIT;
	+		enum object_type type;
	 
	 		oi.typep = &type;
	 		if (packed_object_info(the_repository, p, ofs, &oi) < 0) {
	@@ -3230,9 +3230,11 @@ static int add_object_entry_from_pack(const struct object_id *oid,
	 		}
	 
	 		stdin_packs_found_nr++;
	-	}
	 
	-	create_object_entry(oid, type, 0, 0, 0, p, ofs);
	+		create_object_entry(oid, type, 0, 0, 0, p, ofs);
	+	} else  {
	+		create_object_entry(oid, OBJ_NONE, 0, 0, 0, p, ofs);
	+	}
	 
	 	return 0;
	 }

Or the same with adding "type = OBJ_NONE" to the "else" branch, leaving
the initial "type" uninitialized"?

Or perhaps this is a bug? I see some OBJ_NONE mentions in the code, but
do packfiles really have "none" objects in some fashion as far as
add_object_entry_from_pack() is concerned? (I'm not familiar enough with
this part of the codebase to know).
