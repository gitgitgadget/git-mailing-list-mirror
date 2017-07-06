Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0E2B9202AB
	for <e@80x24.org>; Thu,  6 Jul 2017 17:23:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751765AbdGFRXM (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Jul 2017 13:23:12 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63465 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750970AbdGFRXL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Jul 2017 13:23:11 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 907959ACDD;
        Thu,  6 Jul 2017 13:23:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=TZyfO3YnUtyVYoF4PSNCN2OTboM=; b=Dz+Qaq
        YYsVuN91N+KEr+s0ZzWGbl2Is63rbeMYKePsJ3SL+7Hoh38u2J/KNlZLR9op/3UL
        fv8x7B9b71kJRPpHexRup6/WY309+7be350FuSo5UjYiqYU0CPBOmR5pmhgCKBP2
        /qZUys/IKSfkWTM/FwsXiUDz4+TT0mr/lU87E=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 890B29ACDC;
        Thu,  6 Jul 2017 13:23:03 -0400 (EDT)
Received: from localhost (unknown [24.60.167.92])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0B6799ACDB;
        Thu,  6 Jul 2017 13:23:03 -0400 (EDT)
From:   Kyle Meyer <kyle@kyleam.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: name-rev: anchor pattern without --exclude?
In-Reply-To: <xmqqfue9fqfe.fsf@gitster.mtv.corp.google.com>
References: <87k23ltsl6.fsf@kyleam.com> <xmqqfue9fqfe.fsf@gitster.mtv.corp.google.com>
Date:   Thu, 06 Jul 2017 13:23:02 -0400
Message-ID: <87h8yptr7t.fsf@kyleam.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C431BA9E-626F-11E7-B870-EFB41968708C-24757444!pb-smtp1.pobox.com
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=kyleam.com;
 h=from:to:cc:subject:in-reply-to:references:date:message-id:mime-version:content-type; s=mesmtp; bh=TZyfO3YnUtyVYoF4PSNCN2OTboM=; b=1e7icdvranOOymnDUZpF+M66eHKFWJczWSnsy99+DZEKzlJg5nhgcFi6YUFuqYgTALrcIzJqw0Z3kJzmgWakqKj4m9iJyb7aCvnGV7klS9K2HEN48mcKnudGsN8zOaJpcp4qhboN9SbRUFchIBj8DgxxRucyK9TDTM+haYR/x4Q=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Kyle Meyer <kyle@kyleam.com> writes:
>
>> [*] A bit more information on why I'm trying to do this: In Magit, we
>>     have a work-in-progress feature that takes "snapshots" of changes
>>     before they are committed.  These snapshots are stored as
>>     "refs/wip/{wtree,index}/<full refname>".
>>
>>     We want to use name-rev to map a commit to a name in "refs/heads/",
>>     ignoring these snapshot refs.
>
> What is the <full refname> in the above supposed to represent?

It's the current branch, as returned by "git symbolic-ref HEAD".

> When a user sees two refs "refs/wip/{wtree,index}/<full refname>",
> does it mean: "These two represent a snapshot for changes while the
> user was working on this branch"?

Yes.

> Isn't name-rev a wrong tool to find that information?

Sorry for the confusion.  We're using "symbolic-ref HEAD" to get the
above information.  I was just trying to explain why we're dealing with
ref names that contain a "refs/heads" substring (like
refs/wip/wtree/refs/heads/master in the example I gave).

> What is the answer desired by your application when two or more
> branches point at the same commit you are interested in?  Pick one at
> random?  An error saying it cannot decide where to place the snapshot?

Our use of name-rev is just to get a friendly name for a hash.  If two
branches point to the same commit, we're fine with whatever decision
"git name-rev" makes; we just want to limit it to refs in the
"refs/heads/" namespace.

-- 
Kyle
