Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 736B41F4C0
	for <e@80x24.org>; Mon, 21 Oct 2019 02:48:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726846AbfJUCso (ORCPT <rfc822;e@80x24.org>);
        Sun, 20 Oct 2019 22:48:44 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64547 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726764AbfJUCso (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Oct 2019 22:48:44 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D87F323696;
        Sun, 20 Oct 2019 22:48:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=J7EkTcD4dfN//cnJ3ASM01atxdo=; b=g57jF7
        a8/JNyZ4iu4VMsGsdwRTF/5LjFpDuyAtuYZJyNaJ/jg7xgSJhk6OaZbAFzONVi0Z
        nUgjilW7Z2rWjjyb3YSaQqn5AEw9DMvzvY3navUfDNoq+QcbYGoWA974A0bczJpz
        qcE3rYMPBkkjaC14gzOjU2NQZTVPiey8/7tm4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=FeAjWSOSArVjf4/2m5kGEe5W6n5iSxuh
        2YLQEagxzdCpWRNFYLdcsGa5ZJ5vMYAouSIeGx429/3Y/Uh5DvgDS/AFmTQP1qXi
        6Kk/Xdusjm4B5A5K1WPfbYMzAiaTs4nYgzNT3N3AqjwyoGzl3zB27TCeTNiPq3oZ
        X+yzvUX45fM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CF8C323695;
        Sun, 20 Oct 2019 22:48:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3C4CB23694;
        Sun, 20 Oct 2019 22:48:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Philip Oakley <philipoakley@iee.email>
Cc:     GitList <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Pratyush Yadav <me@yadavpratyush.com>
Subject: Re: [PATCH v5] Doc: Bundle file usage
References: <9e097bb2-ff3e-db5b-f0fd-0803e56b2cd6@iee.email>
        <20191020110306.1714-1-philipoakley@iee.email>
Date:   Mon, 21 Oct 2019 11:48:40 +0900
In-Reply-To: <20191020110306.1714-1-philipoakley@iee.email> (Philip Oakley's
        message of "Sun, 20 Oct 2019 12:03:06 +0100")
Message-ID: <xmqq7e4yn793.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4A485130-F3AD-11E9-9D8C-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Philip Oakley <philipoakley@iee.email> writes:

> @@ -20,11 +20,14 @@ DESCRIPTION
>  Some workflows require that one or more branches of development on one
>  machine be replicated on another machine, but the two machines cannot
>  be directly connected, and therefore the interactive Git protocols (git,
> +ssh, http) cannot be used.
> +
> +The 'git bundle' command packages objects and references in an archive
> +at the originating machine, which can then be imported into another
> +repository using 'git fetch', 'git pull', or 'git clone',
> +after moving the archive by some means (e.g., by sneakernet).
> +
> +As no
>  direct connection between the repositories exists, the user must specify a
>  basis for the bundle that is held by the destination repository: the
>  bundle assumes that all objects in the basis are already in the

Notice that we use the term `basis` here.  It is referring to the
bottom end(s) of the commit graph.

> +`git clone` can use any bundle created without negative refspecs
> +(e.g., `new`, but not `old..new`).

To be consistent with the phrasing of this particular document we
saw earlier, you would have said "without basis", but I think the
use of `basis` did not spread beyond "git bundle" documentation.  

If we were writing "git bundle" and its documentation from scratch
using more modern lingo, we probably would say "negative revisions"
here.  Note that the word `refspec` has no place in the context of
this sentence; they are to specify the mapping of refs between the
repository in which transferred objects originate and the repository
that accept the objects.  Also note that `basis` discussed in 'git
bundle' is a bit wider concept than `negative revisions`, so mere
mechanical replacements would not be sufficient as a preliminary
modernization/prepation step for this patch.

> +If you want to match `git clone --mirror`, which would include your
> +refs such as `refs/remotes/*`, use `--all`.
> +If you want to provide the same set of refs that a clone directly
> +from the source repository would get, use `--branches --tags` for
> +the `<git-rev-list-args>`.

This is not wrong per-se, but may lead to confusion.  The readers
must be able to learn:

 - "git clone --mirror full.bndl dst/" from a full bundle created
   with "git bundle create full.bndl --all" can mimic creation of a
   full mirror of the original.

 - "git clone full.bndl dst/" from such a bundle does *not* result
   in creation of a mirror.

 - "git clone slim.bndl dst/" from a minimum bundle created wth "git
   bundle create slim.bndl --branches --tags" would be sufficient to
   obtain the same result as the above.

 - "git clone --mirror slim.bndl dst/" from such a minimum bundle
   cannot mimic creation of a full mirror of the original.

I am not sure the second point is conveyed well with the new
paragraph.  That is, "--all" must be used if the resulting bundle is
meant to be usable to "--mirror" clone from, but it can still be
used to clone normally.  If you do not intend to mirror-clone from,
there is not much point in using "--all" to record extra refs.

Not having the new paragraph does not convey anything at all, so it
definitely is an improvement, though ;-)

Thanks.

