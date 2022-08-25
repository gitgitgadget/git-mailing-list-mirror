Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAA1BC28D13
	for <git@archiver.kernel.org>; Thu, 25 Aug 2022 10:59:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241107AbiHYK7R (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Aug 2022 06:59:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240046AbiHYK7Q (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Aug 2022 06:59:16 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94C30AE230
        for <git@vger.kernel.org>; Thu, 25 Aug 2022 03:59:15 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id kk26so9077431ejc.11
        for <git@vger.kernel.org>; Thu, 25 Aug 2022 03:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc;
        bh=x8Bj2iqJyNvu27rrWPp86CK18zsn4NKy1H5GndSpoJg=;
        b=aapOUadY9nBN/Q1w8R6Jh0pQywzau5uOe0NvZYpg8ZLSN9XB983KpcqLLM345wWyMd
         ZjN2IYazpCwsKwfhiDLzn3ZaJ/mZoZKD80Eu5w8RTIuNgOuKrwl5mqyqQdlNBvYN7c7V
         ndyEFF3xVlssrZepc2H9H7rI3YU6Aeh3ebeKHloFqIlSjxmaBU5qa/wV6tGCsT/8Dr2t
         bnpV0yuACpdPmJ2lJi+R/exO7NLbxyLVW5TPML4Gwle9fZTwIQpGwOW3TGn03Tfqr3MA
         doH/OBj7KL+pF9hfgXngSSqVWT70b5gIJMHICcD7Ebg2touHo6tq63bac/STZQXIfcGF
         fBIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=x8Bj2iqJyNvu27rrWPp86CK18zsn4NKy1H5GndSpoJg=;
        b=3EznC/3OAWbsCHAN8iYhDubpI2O6NnKz8oAPXsJmaqJaDPqmQQF10rIoWujF6WHjQN
         30ESwxE81+Ej+iH1fSobfsJ+43jXKVF7jyz37Cyf5GpEQ1xHcgP8i+YZk5IIgVjpBneX
         p3scCHlweGP0//8fRbyvbjv5RHqGxAXh3phVxzz8K59cGe3bI7jw8wNZuuxqKIGPuZ33
         DGpjsKSuZlj0U1NkQlwY+27mOk5vbRiJzkyPZ9U6W48+Cr1JqcX3neBwRdXMO8m7Az31
         TMcx3wUEYYGu5kuj+4hLCQjz6JTLGOTRhmA4qMPstZRWx/Ua4ExFjEcI8AfzGoe3dFLp
         vu7Q==
X-Gm-Message-State: ACgBeo0ELPhi32ADrMPsL9vqOf4/3AUZWO6kDwoIBdMIPwW/VKmcK1MN
        qI1beziElxMXRjWzCuGhGHY=
X-Google-Smtp-Source: AA6agR7lS1LKmx0Zm31y/Swz07+PxImwsoxwpDICuRKsnp9xnP2WvyQZnsVsyh0eBlFaHxmKm05G+A==
X-Received: by 2002:a17:906:844b:b0:73d:d822:46f8 with SMTP id e11-20020a170906844b00b0073dd82246f8mr705505ejy.579.1661425154025;
        Thu, 25 Aug 2022 03:59:14 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id y70-20020a50bb4c000000b0043bea0a48d0sm4695794ede.22.2022.08.25.03.59.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Aug 2022 03:59:13 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1oRAZu-001EPt-0v;
        Thu, 25 Aug 2022 12:59:14 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH] ci: update 'static-analysis' to Ubuntu 22.04
Date:   Thu, 25 Aug 2022 12:47:53 +0200
References: <pull.1334.git.1661275691795.gitgitgadget@gmail.com>
 <xmqqwnax438x.fsf@gitster.g>
 <7364f631-e05b-0db8-aaa4-9f0101b6db56@github.com>
 <xmqqfshl3pbp.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <xmqqfshl3pbp.fsf@gitster.g>
Message-ID: <220825.86ilmg4mil.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Aug 24 2022, Junio C Hamano wrote:

> Derrick Stolee <derrickstolee@github.com> writes:
>
>>> We probably need to fix or revert/remove rules we have in
>>> unused.cocci that makes bogus "suggestion".
>>> 
>>>   https://github.com/git/git/runs/8005321972?check_suite_focus=true
>>
>> Yes, this is definitely a bogus suggestion. It's probable that it
>> is picked up by the newer version of Coccinelle.
>
> Yes, I think we should tentatively disable the offending one until
> we know how to properly "fix" it.

I'm seeing this relatively late, it would be nice to get a CC on
discussions of of one's code :)

This is indeed completely broken, but it's not the unused.cocci rule
that's broken.

What's happening here is that coccinelle can no longer properly parse
the file after the UNUSED() macros were applied to refs.c.

Try running with "--verbose-match --verbose-parsing", on
"seen". Deleting the UNUSED() from warn_if_dangling_symref() happens to
"fix" it, but it's only working as a result of some hack. Coccinelle is
running into some unbalanced paren issue, and it happens to balance out
with that.

I don't think there's any issue here in unused.cocci, it just happens to
be the rule that's unlucky enough to fire like that in the face of these
parse errors.

We should probably coerce coccinelle into stopping in general if it's
encountering "BAD:!!!!!" parse errors behind the scenes, as it clearly
results in broken logic, but offhand (and from briefly browsing the
manpage) I don't know a way to do that.

But the fix here isn't to delete unused.cocci, but to hold off on the
UNUSEwork D() patches until we figure out how to make coccinelle jive with
them.

One thing that *would* fix it is to go with the approach I suggested in
https://lore.kernel.org/git/220819.868rnk54ju.gmgdl@evledraar.gmail.com/,
i.e. to not use an "UNUSED(var)" form, but just "UNUSED".

I tried that just now with this hack, which wouldn't even compile with
the compiler, but coccinelle is seemingly smart enough to ignore unknown
tokens it doesn't know about if they're not introducing parens (i.e. I
didn't even have to define UNUSED2).

It's also not that it punted out entirely, with this changing
refs_verify_refname_available() so that "referent" actually isn't unused
for real would have unused.cocci suggest the same removal, so we're
managing to fully apply rules to the file:
	
	diff --git a/refs.c b/refs.c
	index 607694c2662..37e7d88920c 100644
	--- a/refs.c
	+++ b/refs.c
	@@ -442,7 +442,7 @@ struct warn_if_dangling_data {
	 };
	 
	 static int warn_if_dangling_symref(const char *refname,
	-				   const struct object_id *UNUSED(oid),
	+				   const struct object_id *oid UNUSED2,
	 				   int flags, void *cb_data)
	 {
	 	struct warn_if_dangling_data *d = cb_data;
	@@ -982,7 +982,7 @@ static void set_read_ref_cutoffs(struct read_ref_at_cb *cb,
	 }
	 
	 static int read_ref_at_ent(struct object_id *ooid, struct object_id *noid,
	-			   const char *UNUSED(email),
	+			   const char *email UNUSED2,
	 			   timestamp_t timestamp, int tz,
	 			   const char *message, void *cb_data)
	 {
	@@ -1024,9 +1024,9 @@ static int read_ref_at_ent(struct object_id *ooid, struct object_id *noid,
	 	return cb->found_it;
	 }
	 
	-static int read_ref_at_ent_newest(struct object_id *UNUSED(ooid),
	+static int read_ref_at_ent_newest(struct object_id *ooid UNUSED2,
	 				  struct object_id *noid,
	-				  const char *UNUSED(email),
	+				  const char *email UNUSED2,
	 				  timestamp_t timestamp, int tz,
	 				  const char *message, void *cb_data)
	 {
	@@ -1039,7 +1039,7 @@ static int read_ref_at_ent_newest(struct object_id *UNUSED(ooid),
	 }
	 
	 static int read_ref_at_ent_oldest(struct object_id *ooid, struct object_id *noid,
	-				  const char *UNUSED(email),
	+				  const char *email UNUSED2,
	 				  timestamp_t timestamp, int tz,
	 				  const char *message, void *cb_data)
	 {
	@@ -1904,7 +1904,7 @@ struct ref_store_hash_entry
	 	char name[FLEX_ARRAY];
	 };
	 
	-static int ref_store_hash_cmp(const void *UNUSED(cmp_data),
	+static int ref_store_hash_cmp(const void *cmp_data UNUSED2,
	 			      const struct hashmap_entry *eptr,
	 			      const struct hashmap_entry *entry_or_key,
	 			      const void *keydata)
	
