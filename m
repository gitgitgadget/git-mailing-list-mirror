Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5F85C433EF
	for <git@archiver.kernel.org>; Tue, 14 Jun 2022 00:14:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231726AbiFNAOl (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Jun 2022 20:14:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229892AbiFNAOg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Jun 2022 20:14:36 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8936531916
        for <git@vger.kernel.org>; Mon, 13 Jun 2022 17:14:34 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id s12so14108513ejx.3
        for <git@vger.kernel.org>; Mon, 13 Jun 2022 17:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=ad4JA33+EphgWq35uMI7oAT6uf9UaYG1S0NlKjkXJmA=;
        b=ohYXkncJqsjyvWYVT9w2/H2k5dwl7pM1ytwWW0xuQC1O9fS+P21j3J4o/HA8RZk/hv
         FEzDbHVKE8J95sUuTbFQ88CduqWT9bmuw6Qyz5dzNeGR3qsZBRgGaptoj5Cj+fmPx3st
         aM0DgYE01RobWyV/9/Fjt3AiLXpb98C/gzmaB+YxiPOjRFYqM5mquiWoc6kukzDKRzuv
         mycmLBtywydMXZkScAozcWcRYHjMOSTWDpmXYHfbrFp9GiT9apZcw8PcMEh1oiQ0TbRP
         o9zxeEHe9SzFJc0FPqWk2p0uDOTCgOV9EUH2V4VDFkPHc81ZOqWy3hkVUQ3Efgp/ZRqD
         YTVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=ad4JA33+EphgWq35uMI7oAT6uf9UaYG1S0NlKjkXJmA=;
        b=5gnpMGN3ALqnDxTnTCo2DKwlf3gdfmOUVt8eXk1AIaYyeRb2EkE9gw2F26KelhCVrt
         zeNkbaAlpnfXyFb0jMGuOCHwCpNmL8GbjdLZKWdgVhuxgJaRuKwXA9+cAAbKxVB1RJz6
         lYCJR392KEgNcqT6AbhMaJ7TQUziwKAAk+QGN/+aMU7wTBSymwa/b15zAHdZywhnrAId
         3fyIbwZr13/VAbLlnGK6wpqJKnEg0qubalrMB3DJdjQyIMp12EcfHztz4Na1gQZdADw4
         nNmtAlHtC6ulRfYjDUjikBQjviCyKbAaJC7DSmojj+G4cQVpqZn5kGrDfCxBax6x6xxh
         f77A==
X-Gm-Message-State: AJIora8ER8HJ7l7gXOtRUm0yPK9g86yOhzRnIdSVzkahCf/OM0Tjq3jR
        IpEOr6KqOl5rUPDdMmN3tj0p+MmZY/JbNQ==
X-Google-Smtp-Source: ABdhPJwroFtu2hoR3onyfjxXCq1SoGEGo1b6qN0yMEktV6s2XgWyr+vgeeAb804A//gF9px1kh7dmA==
X-Received: by 2002:a17:907:c1d:b0:70f:469a:3d73 with SMTP id ga29-20020a1709070c1d00b0070f469a3d73mr1977175ejc.248.1655165672820;
        Mon, 13 Jun 2022 17:14:32 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id d5-20020a1709061f4500b00711aed17047sm4356578ejk.28.2022.06.13.17.14.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 17:14:32 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1o0uCV-000IRy-Ch;
        Tue, 14 Jun 2022 02:14:31 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, johannes.schindelin@gmx.de,
        me@ttaylorr.com, Jeff Hostetler <git@jeffhostetler.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 3/4] fetch: use new branch_checked_out() and add tests
Date:   Tue, 14 Jun 2022 02:05:51 +0200
References: <pull.1254.git.1654718942.gitgitgadget@gmail.com>
 <4540dbeed385341f8c5b45134e1a65dc48c75b0c.1654718942.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <4540dbeed385341f8c5b45134e1a65dc48c75b0c.1654718942.git.gitgitgadget@gmail.com>
Message-ID: <220614.86h74oyuc8.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Jun 08 2022, Derrick Stolee via GitGitGadget wrote:

> From: Derrick Stolee <derrickstolee@github.com>

re a comment on 1/4...

>  	struct commit *current = NULL, *updated;
> -	const struct worktree *wt;
> +	char *path = NULL;

Init'd to NULL here...

>  	const char *pretty_ref = prettify_refname(ref->name);
>  	int fast_forward = 0;
>  
> @@ -900,17 +900,17 @@ static int update_local_ref(struct ref *ref,
>  	}
>  
>  	if (!update_head_ok &&
> -	    (wt = find_shared_symref(worktrees, "HEAD", ref->name)) &&
> -	    !wt->is_bare && !is_null_oid(&ref->old_oid)) {
> +	    !is_null_oid(&ref->old_oid) &&
> +	    branch_checked_out(ref->name, &path)) {
>  		/*
>  		 * If this is the head, and it's not okay to update
>  		 * the head, and the old value of the head isn't empty...
>  		 */
>  		format_display(display, '!', _("[rejected]"),
> -			       wt->is_current ?
> -				       _("can't fetch in current branch") :
> -				       _("checked out in another worktree"),
> +			       path ? _("can't fetch in current branch") :
> +				      _("checked out in another worktree"),
>  			       remote, pretty_ref, summary_width);
> +		free(path);
>  		return 1;

..but only used if branch_checkoed_out() returns non-zero, but (and I've
only eyeballed this, not run it) isn't it impossible for that function
not to return successfully and have "path" be non-NULL?

This seems to be a defense against the underlying strmap_get() starting
to return nonsensical results, but if we instead just trust it...

Also re the "can't we just expose the strmap?" comment on 1/4, here we
strmap_get() it, and xstrdup() and free() it, but we never needed our
own copy, or even cared about the string at all, we're just checking
"was it in the set?".

Which is what strmap_contains() would give us, if we just exposed it at
that level. So:

	struct strmap *map = make_my_branchs_map_thing();

        [...]
        if ([...] && strmap_contains(map, ref->name)) {
	        ...

Seems more straightforward, no?

Looking at the other callers it seems none of them need the xstrdup() at
all, if looking at the end state. This one is a strmp_contains(), then
an error() which could use strmap_get() without the xstrdup(), as we
format it immediately.

The remaining two are calling die() right afterwards, which ditto can
use a plain strmap_get() without xstrdup().

It's not that I care about the extra xstrdup(), which is obviously
trivial, it's just harder to read & reason about APIs which e.g. "&&
path", and strdup(), only to find that apparently no user in-tree cared
about those...

Maybe they'll be needed, but let's just add them then, and in the
meantime aim for simpler? :)
