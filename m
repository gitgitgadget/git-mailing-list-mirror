Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35C96C433EF
	for <git@archiver.kernel.org>; Mon, 20 Jun 2022 19:35:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243377AbiFTTfL (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Jun 2022 15:35:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242530AbiFTTfI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Jun 2022 15:35:08 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 652391C90C
        for <git@vger.kernel.org>; Mon, 20 Jun 2022 12:35:07 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id mf9so2733047ejb.0
        for <git@vger.kernel.org>; Mon, 20 Jun 2022 12:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=nKgebZED0895aGJNwujmUWBd6RGdFvnkztf5Pg+8wZU=;
        b=S0jiFGAOC+NfbM4fnpTSe9HzRPg1d4jb6EYdgtLRBgwYFqRyjxvfmrpF9IMsjQXTfn
         UG0NQbylI/vlYGjnAtWaBKLM1enru/C+/Cv5KEZcgI4c0hND7MXDBh2n/6Ps0AnEVan4
         OP581J3CbJCHI0Bo6USPBEucK9sYr3vLBZnvT6znSZKN4albsEckHB6+p+ob66CxM4N1
         5ckKgihHG+3BvJHV2XZttQ8r2A7KqcJPvqcyTeYOND3Jv8hR405dWInkHy2O6WwfLw8X
         oRaqswjyTIbqElNJUVPbCd/uhdtmFrJ7MAy5UHeSWmp4jdlJeP0F/0yu77WPdOS9FFjC
         o8+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=nKgebZED0895aGJNwujmUWBd6RGdFvnkztf5Pg+8wZU=;
        b=cD1RIHFgFe25NO5xb8EUAIP6igzt1UjHK3EfA4kfZkNjt01JcMOJNJGIYThkVoFlhm
         hT/NQE1lqfwxT3PMlGkwAWKVaV8i390zdHK1G+m8hLDC+bvI1pu10omrc7LEJWAXItD3
         qc7DJCHQOjcHC3kq4jjMyqH0fHEk0Lgv3+tB4eqA2FNNdzqgtL+CxczeQXpMCcEB66C6
         qdS4vM3y9rcYJRp0cOaRY9Isw1oqluaOPC0tVwPiueEXnSfvEF/s1jARK0qn0ojf+hUr
         5xO88oo8XIkpIURmEyShMMvMgWEiruxLw8E34v5foWUHkfmHUGly2ZiD3JJE6cgNL0Bu
         fxMA==
X-Gm-Message-State: AJIora/XBsPH7wcvzhCul3vDqFbXrbsB/eUqqcSLkBGRPplGR4PhqgPt
        gtx/folVsJXidsC9P0lOh8Pf957nTFY=
X-Google-Smtp-Source: AGRyM1sFAWlClpHlZQJq/uryIG8EmDftFUg9l0koK8u1hF9wRkqcnDgR6O+pz7z5F+7WD8kWzItRWQ==
X-Received: by 2002:a17:907:8a1f:b0:711:da32:8410 with SMTP id sc31-20020a1709078a1f00b00711da328410mr23358692ejc.298.1655753705741;
        Mon, 20 Jun 2022 12:35:05 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id 12-20020a170906318c00b0072124df085bsm3954683ejy.15.2022.06.20.12.35.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jun 2022 12:35:04 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1o3NAt-0005tN-CW;
        Mon, 20 Jun 2022 21:35:03 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 2/2] branch: drop unused worktrees variable
Date:   Mon, 20 Jun 2022 21:09:27 +0200
References: <Yq6deQf96g8M5wdg@coredump.intra.peff.net>
 <Yq6eJFUPPTv/zc0o@coredump.intra.peff.net>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <Yq6eJFUPPTv/zc0o@coredump.intra.peff.net>
Message-ID: <220620.865ykvw2l4.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Jun 18 2022, Jeff King wrote:

> After b489b9d9aa (branch: use branch_checked_out() when deleting refs,
> 2022-06-14), we no longer look at our local "worktrees" variable, since
> branch_checked_out() handles it under the hood. The compiler didn't
> notice the unused variable because we call functions to initialize and
> free it (so it's not totally unused, it just doesn't do anything
> useful).
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> It would be neat if there was some way to mark a function as "this is
> just allocating a structure, with no useful side effects" and another as
> "this is just freeing", which would let the compiler notice that we
> don't do anything useful with the structure in between the two. I have a
> feeling adding such annotations might be more work than occasionally
> finding and cleaning up such useless variables, though. :)

There is, at least with coccinelle. Perhaps the compiler can be made
smart enough, but I haven't found a way to massage it to do that.

I had this patch the other day, which basically does this, but it didn't
get any interest / wasn't picked up by Junio:
https://lore.kernel.org/git/patch-1.1-7d90f26b73f-20220520T115426Z-avarab@gmail.com/

I didn't think to add a rule for free_worktrees() specifically, but with
your 1/2 applied we find this:
	
	$ cat contrib/coccinelle/unused.cocci
	// Unused decl + assignment + release()
	@@
	identifier I;
	type T;
	@@
	- T I;
	  <+...
	- I = get_worktrees();
	  ... when != \( I \| &I \)
	- free_worktrees(I);
	  ...+>

	$ spatch --sp-file contrib/coccinelle/unused.cocci --all-includes builtin/branch.c
	init_defs_builtins: /usr/bin/../lib/coccinelle/standard.h
	HANDLING: builtin/branch.c
	diff = 
	--- builtin/branch.c
	+++ /tmp/cocci-output-16842-0b6416-branch.c
	@@ -204,7 +204,6 @@ static void delete_branch_config(const c
	 static int delete_branches(int argc, const char **argv, int force, int kinds,
	                           int quiet)
	 {
	-       struct worktree **worktrees;
	        struct commit *head_rev = NULL;
	        struct object_id oid;
	        char *name = NULL;
	@@ -242,8 +241,6 @@ static int delete_branches(int argc, con
	                        die(_("Couldn't look up commit object for HEAD"));
	        }
	 
	-       worktrees = get_worktrees();
	-
	        for (i = 0; i < argc; i++, strbuf_reset(&bname)) {
	                char *target = NULL;
	                int flags = 0;
	@@ -314,7 +311,6 @@ static int delete_branches(int argc, con
	 
	        free(name);
	        strbuf_release(&bname);
	-       free_worktrees(worktrees);
	 
	        return ret;
	 }

There's a bug in that rule I didn't quite figure out, the "<+..." line
needs the equivalent of the "when !=", but if I add that the "when" will
also match the "I = get_worktrees()" line.

I.e. if we had a "foo(worktrees)" line before the "worktrees =
get_worktrees()" we'd still remove these lines, but we don't want
that. It just needs to do the appropriate cocci for "don't match it if
you see this variable, unless the line matches...".

Of coures that only helps after your 1/2, so maybe there's not much
value in it for your case, i.e. it won't be reaching across functions.

But as that patch shows we could relatively easily be spotting dead
code.
