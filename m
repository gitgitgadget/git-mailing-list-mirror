Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F27BC0015E
	for <git@archiver.kernel.org>; Fri, 14 Jul 2023 17:31:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236069AbjGNRbN (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Jul 2023 13:31:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236050AbjGNRbK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Jul 2023 13:31:10 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DD1226B2
        for <git@vger.kernel.org>; Fri, 14 Jul 2023 10:31:06 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id ACF2718A10;
        Fri, 14 Jul 2023 13:31:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=8t+WuHCFBBcU764nT0e3e1YBxcJ9JH9GGUOfna
        yy1Go=; b=TiCXoc3oJNQy5Bt4soQZrqPRVJkMiCsT6awiadZ2rIYAN1v3GWsYY/
        DGRoTPCAlb1B2m5J8GFc5HPycenfiK9M9P2dP5pDDrbPH5nGodQh3Dr6gm+Dw90J
        je/HqoLjPxn3ixr+7/wOPKWQ80sShVQ9SJkAIlcQUTNcHlVmhE8ug=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 9F85918A0F;
        Fri, 14 Jul 2023 13:31:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.127.75.226])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 318BF18A0D;
        Fri, 14 Jul 2023 13:31:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Linus Arver <linusa@google.com>
Subject: Re: [PATCH v2 5/5] SubmittingPatches: simplify guidance for
 choosing a starting point
References: <pull.1556.git.1688778359.gitgitgadget@gmail.com>
        <pull.1556.v2.git.1689314493.gitgitgadget@gmail.com>
        <5ec91d02b7ae767cc9b2395e1c0fa10e1424c0c5.1689314493.git.gitgitgadget@gmail.com>
Date:   Fri, 14 Jul 2023 10:31:01 -0700
In-Reply-To: <5ec91d02b7ae767cc9b2395e1c0fa10e1424c0c5.1689314493.git.gitgitgadget@gmail.com>
        (Linus Arver via GitGitGadget's message of "Fri, 14 Jul 2023 06:01:33
        +0000")
Message-ID: <xmqq5y6mpfhm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 342C225E-226C-11EE-A000-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Linus Arver via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +There is one guiding principle for choosing the right starting point: in
> +general, always base your work on the oldest integration branch that
> +your change is relevant to (see "Merge upwards" in
> +linkgit:gitworkflows[7]).  What this principle means is that for the
> +vast majority of cases, the starting point for new work should be the
> +latest HEAD commit of `maint` or `master` based on the following cases:
> +
> +* If you are fixing bugs in the released version, use `maint` as the
> +  starting point (which may mean you have to fix things without using
> +  new API features on the cutting edge that recently appeared in
> +  `master` but were not available in the released version).

I think this is technically not optimal, but is good enough for the
sake of simplicity and brevity[*].

> +* Otherwise (such as if you are adding new features) use `master`.
> +
> +This also means that `next` or `seen` are inappropriate starting points
> +for your work, if you want your work to have a realistic chance of
> +graduating to `master`.  They are simply not designed to provide a
> +stable base for new work, because they are (by design) frequently
> +re-integrated with incoming patches on the mailing list and force-pushed
> +to replace previous versions of these branches.

"unstable" is not the primary reason why you shouldn't build on
'next'.  It is "your work, if queued on 'next', cannot be merged to
'master' without pulling all the other undercooked stuff still in
'next'", as you describe in the next paragraph.  But that is
different from being unstable.  I'd suggest to use something like
this instead:

	... not designed to be used as a base for new work---they
	are there only to make sure that topics in flight work well
	together.  A topic that is literally built on top of 'next'
	cannot be merged to 'master' without dragging all the other
	topics in 'next', some of which may not be ready.  In
	addition, `seen` is frequently re-integrated with incoming
	patches ...

> +For example, if you are making tree-wide changes, while somebody else is
> +also making their own tree-wide changes, your work may have severe
> +overlap with the other person's work.  This situation may tempt you to
> +use `next` as your starting point (because it would have the other
> +person's work included in it), but doing so would mean you'll not only
> +depend on the other person's work, but all the other random things from
> +other contributors that are already integrated into `next`.  And as soon
> +as `next` is updated with a new version, all of your work will need to
> +be rebased anyway in order for them to be cleanly applied by the
> +maintainer.
> +
> +Under truly exceptional circumstances where you absolutely must depend
> +on a select few topic branches that are already in `next` but not in
> +`master`, you may want to create your own custom base-branch by forking
> +`master` and merging the required topic branches to it. You could then
> +work on top of this base-branch.  But keep in mind that this base-branch
> +would only be known privately to you.  So when you are ready to send
> +your patches to the list, be sure to communicate how you created it in
> +your cover letter.  This critical piece of information would allow
> +others to recreate your base-branch on their end in order for them to
> +try out your work.

Very well written.

Thanks, will queue.


[Footnote]

 * An very old but still severe bug in tagged versions would want to
   be fixed ideally not on top of 'maint' but on top of the latest
   tagged version in the same maintenance track.  E.g. if the commit
   X introduced the bug, you may ask "git describe --contains X" the
   oldest version the commit appears in, say "v2.30.0-rc2-gXXXXXX".
   Then you would run "git checkout -b fix v2.30.9" to start the
   branch to fix it.
