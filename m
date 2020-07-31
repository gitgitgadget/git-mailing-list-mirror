Return-Path: <SRS0=dkLL=BK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3167C433DF
	for <git@archiver.kernel.org>; Fri, 31 Jul 2020 02:04:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C36CD2083E
	for <git@archiver.kernel.org>; Fri, 31 Jul 2020 02:04:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="dKMAyMMd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731057AbgGaCEU (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jul 2020 22:04:20 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:58862 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730904AbgGaCEU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jul 2020 22:04:20 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 1F166E255F;
        Thu, 30 Jul 2020 22:04:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=XasLZDr44JRJCwEMAoC/tT1yDnQ=; b=dKMAyM
        Mdj+9O7tt2MBhKIfzBO2cMRlXs7t1QwtxZQoJZLd4UyO8UoVGE8UbLSXWfBTmd2Y
        CU5iTl09p27nqMIkq2iRIH2op8Xv89TadFXg8ZVUrF1wuIrnvE2mH2cOi0oP3gQv
        Z+UmFxumE1ucIHvinK5JSLwmiHepp2h9Y8DaA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=tsN0uXUI6rd7FTgDMdvBa1lAT9oDpSU6
        GjXWfVtOxZXlNZrTE8CB0D867q19zQapD5Y+lZTcCon8+9JAcwh5dzy3/ZBHFHQK
        te//veb/S70SRMMr9HO2Iv7/Xx6o/fYayaysFKyO50SmpPH6PcbMANcUXXLEqRDo
        Mzz97/Ks9pU=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 17DB0E255E;
        Thu, 30 Jul 2020 22:04:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 62DD3E255D;
        Thu, 30 Jul 2020 22:04:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3 0/2] fmt-merge-msg: selectively suppress "into <branch>"
References: <xmqq5za596uo.fsf@gitster.c.googlers.com>
        <20200730180237.1392480-1-gitster@pobox.com>
        <20200731004202.GA240563@coredump.intra.peff.net>
Date:   Thu, 30 Jul 2020 19:04:15 -0700
In-Reply-To: <20200731004202.GA240563@coredump.intra.peff.net> (Jeff King's
        message of "Thu, 30 Jul 2020 20:42:02 -0400")
Message-ID: <xmqqy2n04ezk.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 23D24736-D2D2-11EA-8F11-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> This version looks OK to me. The remaining issues that came up in
> earlier discussion but I didn't see you weigh in on are:
>
>   - what should happen with a detached HEAD? We'd match HEAD in the
>     suppressDest config, which I think is quite reasonable. Not sure if
>     it's worth documenting or testing that specifically.

I think what the code with posted patch happens to do is just fine.
If you say "git -c merge.suppressDest=HEA? merge $topic" while on a
detached HEAD, you'll get "into HEAD" omitted.

In a workflow where you'd do

	$ git co master^0
	... enumerate the topics merged in master..jch, and redo the
	... merge, but with updated versions of these topics
	$ git shortlog jch..HEAD
	$ git range-diff jch...HEAD
	$ git diff jch..HEAD
	... after inspection, find the result satisfactory, and ...
	$ git co -B jch

I would strongly suspect that hiding "into HEAD" is not enough, so I
do not think HEAD is all that relevant in the first place.

You'd rather want to "lie" about the destination branch while
redoing these merges, perhaps with

	$ git merge --pretend-dest=jch topic-name

with your HEAD detached, and tell fmt-merge-msg to pretend that the
merge is being made into jch branch.  And that is outside the scope
of this patch, though it might be a good #leftoverbits candidate.

>   - should "master" be in the list even if you configure a value? That
>     would do the wrong thing if you have a non-integration master, but
>     that seems unlikely. And it would do the right thing if somebody
>     later puts "main" in merge.suppressDest, but still occasionally
>     works with "master" repos (where "right" is defined as "what they
>     probably wanted", but it is perhaps a bit magical).

If you configure, you can configure it fully without manually
clearing first.  If you do not configure, you get a backward
compatible default.  I think that is the only sensible semantics.

Besides, I thought we were aiming to make 'master' less special.
When a user already has a concrete list of things to use shorter
merge title for, why should 'master' be magically added to the list
and force the user to explicitly clear it?  I do not think that
makes much sense.

>   - what's the plan if we do switch init.defaultBranch to "main"? Would
>     we add default_branch() to the list of defaults alongside "master",
>     or just add "main", or just leave it and let people configure
>     independently? It doesn't need to be decided now, but maybe worth
>     thinking about.

My understanding is that much more instances of repositories come to
exist by cloning than running "git init".  Hence, the value you set
to the init.defaultBranch has no relevance to the name of the
primary branch in majority of your repositories, whose primary branch
is what their origin has designated before/when you cloned.

And the latter, "what is the primary branch name for this particular
repository?", is what we want to ask here.  The answer to "what is
the first branch name for new repository I will create?" is not a
good proxy for that.

I do not mind too much, even though I doubt it will be all that
useful, if we taught "init" and "clone" to record which branch is
the primary one in the repository they created.  We'd need to add
the repo_primary_branch_name() helper to allow this caller to
replace the hardcoded 'master' in the patch with it, just like
"init" and "clone" may ask the repo_default_branch_name() helper
what the first branch name ought to be.

In any case, I do not think I want to see more reliance of the
notion that there always is one and only one single special branch
in the repository, so if we can get away without it, that would be
more preferrable.

Thanks.

