Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04A5EC433FE
	for <git@archiver.kernel.org>; Fri, 14 Oct 2022 16:15:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbiJNQPZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Oct 2022 12:15:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbiJNQPW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Oct 2022 12:15:22 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91B48AF1B6
        for <git@vger.kernel.org>; Fri, 14 Oct 2022 09:15:20 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 2FF771C114E;
        Fri, 14 Oct 2022 12:15:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=wbq1U80IO2iV94v9uQHQDA1yRtKAwl/ewpcGLI
        OrCY0=; b=GA8caiTbq72sjMq0qFY0Xi44PzMOI09ogrPnNVG+d0uyJhDzUXDt3V
        FyEd1klxTibdvl8WFy6q87sdYaSAaPVBVs3HYklooy0yzYCJvhVyRkN1TI9iwtdv
        Bch/gQCZ6FhBkHMr1eo0lK3b5dL3tBt2gQsxM8XU59mjHMonoVI5E=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 0F15F1C114D;
        Fri, 14 Oct 2022 12:15:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 2A1DF1C114C;
        Fri, 14 Oct 2022 12:15:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "nsengaw4c via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, nsengaw4c <nsengiyumvawilberforce@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>
Subject: Re: [PATCH v3] [OUTREACHY] t1002: modernize outdated conditional
References: <pull.1362.v2.git.git.1665733647421.gitgitgadget@gmail.com>
        <pull.1362.v3.git.git.1665734502591.gitgitgadget@gmail.com>
Date:   Fri, 14 Oct 2022 09:15:16 -0700
In-Reply-To: <pull.1362.v3.git.git.1665734502591.gitgitgadget@gmail.com>
        (nsengaw4c via GitGitGadget's message of "Fri, 14 Oct 2022 08:01:42
        +0000")
Message-ID: <xmqqv8om9yaz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 64598F6A-4BDB-11ED-BEBE-B31D44D1D7AA-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"nsengaw4c via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Nsengiyumva Wilberforce <nsengiyumvawilberforce@gmail.com>
>
> Tests in this script use an unusual and hard to reason about
> conditional construct
>
>     if expression; then false; else :; fi
>
> Change them to use more idiomatic construct:
>
>     ! expression
>
> Cc: Christian Couder  <christian.couder@gmail.com>
> Cc: Hariom Verma <hariom18599@gmail.com>
> Signed-off-by: Nsengiyumva  Wilberforce <nsengiyumvawilberforce@gmail.com>

What are these C: lines for?  I do not think the message I am
responding to is Cc'ed to them.  There may be a special incantation
to tell GitGitGadget to Cc to certain folks, but adding Cc: to the
log message trailer like this does not seem to be it---at least it
appears that it did not work that way.

> ...
> -     if read_tree_u_must_succeed -m -u $treeH $treeM; then false; else :; fi'
> +     ! read_tree_u_must_succeed -m -u $treeH $treeM'

Looks good. For the purpose of microproject, I think this is a good
place to stop, as it does not make anything worse and make the code
prettier.

To those more experienced contributors who are watching from
sidelines, and especially to our mentors, it may be worth taking a
look at the implementation of the helper shell function used here,
and think if it makes sense to expect a failure with a simple "!"
prefix (or with the original long hand if/then/else/fi that has
exactly the same issue).

read_tree_u_must_succeed () {
	git ls-files -s >pre-dry-run &&
	git diff-files -p >pre-dry-run-wt &&
	git read-tree -n "$@" &&
	git ls-files -s >post-dry-run &&
	git diff-files -p >post-dry-run-wt &&
	test_cmp pre-dry-run post-dry-run &&
	test_cmp pre-dry-run-wt post-dry-run-wt &&
	git read-tree "$@"
}

What if read-tree segfaults?  This entire function will fail and the
test that runs read_tree_u_must_succeed and negates its result would
be a poor fit here.

Thanks.
