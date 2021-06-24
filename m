Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2C7AC49EA5
	for <git@archiver.kernel.org>; Thu, 24 Jun 2021 23:33:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF3446138C
	for <git@archiver.kernel.org>; Thu, 24 Jun 2021 23:33:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232695AbhFXXgA (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Jun 2021 19:36:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbhFXXf7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Jun 2021 19:35:59 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99009C061574
        for <git@vger.kernel.org>; Thu, 24 Jun 2021 16:33:38 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id hq39so12133998ejc.5
        for <git@vger.kernel.org>; Thu, 24 Jun 2021 16:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=eStUZFUDOINUjA85e6tHVXVn7oPe7dz9XHgmydOnPd4=;
        b=sCg4wMcRoY4bcN7vpAsa13MEi8oOt0yfz9oUCDcbik8hpY2dTYlJNLzQ3BtCUDMiEL
         m1PKyI+Xjo7bufrYC0vX3hqWE/XJOjQxp+u8pAOflU40xT9V7jULM8g5AVn2ril4J8+i
         clviNzOaWMvaA1KyrtgU75SnlmT9ykThDrdc9yK19uL9WjrWiMbZAXF9r/dY+80RuAyn
         IJXhd7czWSIBXafAaGXzcFcMDZ8h2lcVocgazuv7QYxJk3+zPgpPqQ3ep6/+5aUW/eBC
         0gZhkmBkovJSc/OTZNBowDqm7vTsxlNIhenZBqgi18A0R+dgoiJwVZXuHSQVVpD/A26H
         NJOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=eStUZFUDOINUjA85e6tHVXVn7oPe7dz9XHgmydOnPd4=;
        b=HKh/IgLLGV/aJAh0AeywoNTgZulgDOiIxYvMlG+Mv0BxkGlOf1nkFKfSysiKghtAId
         wKJD+gYAJAFttyOhSoyNVUHxjYE5+qe1QGp4FbH+jRHEuZAAIHgGjAmnm7iafzrh2Avo
         06C+B5eA9eAYST9kN/0SuLuVJFY9Su5RIUeRrCtuA9yBk1FWP1OBjDz53omDW0ZyzHvy
         vB78j+qMRCylGmE91hPUvILbxljfl0xF2eVzzNV2oJOMC+1UzHVhIz8jXm2BS6eJwLFi
         g39yT6utNoaKjXa0Qcrx85H/thshPaPgR8oW/d45AsKkGxmm4NmLi7Pfy6bUVFWJ27Xc
         NXIg==
X-Gm-Message-State: AOAM532y2FpeMehXq9qQBwXzd5QV1IeYV/94XsMkjh1svuTDFHebn+2d
        jcrqWH0V+pbYvBBNIPGZBn0=
X-Google-Smtp-Source: ABdhPJzJaVi8b174jBGSCx1XywdQKv6KVuPPCaMLDeE80EdZ19CXaQx1RH9efjK0RFqzVi8Msm61Og==
X-Received: by 2002:a17:907:c02:: with SMTP id ga2mr7646498ejc.215.1624577615754;
        Thu, 24 Jun 2021 16:33:35 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id gz17sm1849603ejc.91.2021.06.24.16.33.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jun 2021 16:33:35 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, peff@peff.net, dstolee@microsoft.com,
        gitster@pobox.com, jonathantanmy@google.com
Subject: Re: [PATCH v2 02/24] pack-bitmap-write.c: gracefully fail to write
 non-closed bitmaps
Date:   Fri, 25 Jun 2021 01:23:40 +0200
References: <cover.1617991824.git.me@ttaylorr.com>
 <cover.1624314293.git.me@ttaylorr.com>
 <3e637d9ec83435540ad32b8325b0dce87f61bae0.1624314293.git.me@ttaylorr.com>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.12
In-reply-to: <3e637d9ec83435540ad32b8325b0dce87f61bae0.1624314293.git.me@ttaylorr.com>
Message-ID: <87eecqzvld.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Jun 21 2021, Taylor Blau wrote:

> -static uint32_t find_object_pos(const struct object_id *oid)
> +static uint32_t find_object_pos(const struct object_id *oid, int *found)
>  {
>  	struct object_entry *entry = packlist_find(writer.to_pack, oid);
>  
>  	if (!entry) {
> -		die("Failed to write bitmap index. Packfile doesn't have full closure "
> +		if (found)
> +			*found = 0;
> +		warning("Failed to write bitmap index. Packfile doesn't have full closure "
>  			"(object %s is missing)", oid_to_hex(oid));
> +		return 0;
>  	}
>  
> +	if (found)
> +		*found = 1;
>  	return oe_in_pack_pos(writer.to_pack, entry);
>  }
>  
> @@ -331,9 +336,10 @@ static void bitmap_builder_clear(struct bitmap_builder *bb)
>  	bb->commits_nr = bb->commits_alloc = 0;
>  }
>  
> -static void fill_bitmap_tree(struct bitmap *bitmap,
> -			     struct tree *tree)
> +static int fill_bitmap_tree(struct bitmap *bitmap,
> +			    struct tree *tree)
>  {
> +	int found;
>  	uint32_t pos;
>  	struct tree_desc desc;
>  	struct name_entry entry;
> @@ -342,9 +348,11 @@ static void fill_bitmap_tree(struct bitmap *bitmap,
>  	 * If our bit is already set, then there is nothing to do. Both this
>  	 * tree and all of its children will be set.
>  	 */
> -	pos = find_object_pos(&tree->object.oid);
> +	pos = find_object_pos(&tree->object.oid, &found);
> +	if (!found)
> +		return -1;

So, a function that returns an unsigned 32 bit int won't (presumably)
have enough space for an "is bad", but before it died so it didn't
matter.

Now it warns, so it needs a "is bad", so we add another "int" to pass
that information around.

So if we're already paying for that extra space (which, on some
platforms would already be a 64 bit int, and on some so would the
uint32_t, it's just "at least 32 bits").

Wouldn't it be more idiomatic to just have find_object_pos() return
int64_t now, if it's -1 it's an error, otherwise the "pos" is cast to
uint32_t:
	
	diff --git a/pack-bitmap-write.c b/pack-bitmap-write.c
	index 88d9e696a54..d71fa6f607a 100644
	--- a/pack-bitmap-write.c
	+++ b/pack-bitmap-write.c
	@@ -125,14 +125,12 @@ static inline void push_bitmapped_commit(struct commit *commit)
	 	writer.selected_nr++;
	 }
	 
	-static uint32_t find_object_pos(const struct object_id *oid)
	+static int64_t find_object_pos(const struct object_id *oid)
	 {
	 	struct object_entry *entry = packlist_find(writer.to_pack, oid);
	 
	-	if (!entry) {
	-		die("Failed to write bitmap index. Packfile doesn't have full closure "
	-			"(object %s is missing)", oid_to_hex(oid));
	-	}
	+	if (!entry)
	+		return -1;
	 
	 	return oe_in_pack_pos(writer.to_pack, entry);
	 }
	@@ -334,7 +332,7 @@ static void bitmap_builder_clear(struct bitmap_builder *bb)
	 static void fill_bitmap_tree(struct bitmap *bitmap,
	 			     struct tree *tree)
	 {
	-	uint32_t pos;
	+	int64_t pos;
	 	struct tree_desc desc;
	 	struct name_entry entry;
	 
	@@ -343,6 +341,9 @@ static void fill_bitmap_tree(struct bitmap *bitmap,
	 	 * tree and all of its children will be set.
	 	 */
	 	pos = find_object_pos(&tree->object.oid);
	+	if (pos < 0)
	+		die("unhappy: %s", oid_to_hex(&tree->object.oid));
	+
	 	if (bitmap_get(bitmap, pos))
	 		return;
	 	bitmap_set(bitmap, pos);

I mean, you don't want the die() part of that, but to me the rest looks
better.

> [...]
> diff --git a/t/t0410-partial-clone.sh b/t/t0410-partial-clone.sh
> index 584a039b85..1667450917 100755
> --- a/t/t0410-partial-clone.sh
> +++ b/t/t0410-partial-clone.sh
> @@ -536,7 +536,13 @@ test_expect_success 'gc does not repack promisor objects if there are none' '
>  repack_and_check () {
>  	rm -rf repo2 &&
>  	cp -r repo repo2 &&
> -	git -C repo2 repack $1 -d &&
> +	if test x"$1" = "x--must-fail"
> +	then
> +		shift
> +		test_must_fail git -C repo2 repack $1 -d
> +	else
> +		git -C repo2 repack $1 -d
> +	fi &&
>  	git -C repo2 fsck &&

This sent me down the rabbit hole of
https://lore.kernel.org/git/60c67bdf5b77e_f569220858@natae.notmuch/
again.
