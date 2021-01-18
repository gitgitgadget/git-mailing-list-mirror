Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA27AC433E0
	for <git@archiver.kernel.org>; Mon, 18 Jan 2021 20:34:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B093322573
	for <git@archiver.kernel.org>; Mon, 18 Jan 2021 20:34:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394370AbhARUe3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Jan 2021 15:34:29 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63583 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394348AbhARUeA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Jan 2021 15:34:00 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B440FA2603;
        Mon, 18 Jan 2021 15:33:16 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=wdaqnOczHZvTQ2c3KHR5jaDOZ/M=; b=m22Y5/
        yNLb5ggiCIl5APLMa8Xii9K7WT+vHy0C7rKjbMoCdpmxwvZQypPKYV+H/6dY8NLt
        Eu3e/DMs8/y8j8g5DcWTQQ0MDimReOunPBtXrcxc7pzWLsY+YKmcFwDtk4glpyV6
        Ew7gJbFhGEhMwH6G2BqHvOa3oGiKY0ilB4NIA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=eVEArBzbNi4FuUjf53UrlOYAOUarL9Oo
        bUe1alJtjwHK58BE3kTDFDxUg/EVGs7CnYya9yZUY5aNwnWX7MTkIGzmIBEIgVye
        nfoe1ssTHuScQHJq9YoKam+9HAcuSg75NVabG98ls1WZutJyiIE7I0sfng8dqsMJ
        PREa2QWykGk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id AB228A2602;
        Mon, 18 Jan 2021 15:33:16 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 394A2A2601;
        Mon, 18 Jan 2021 15:33:16 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kyle Marek <kmarek@pdinc.us>
Cc:     Jason Pyeron <jpyeron@pdinc.us>, git@vger.kernel.org,
        Philippe Blain <levraiphilippeblain@gmail.com>
Subject: Re: [PATCH 1/2] revision: Denote root commits with '#'
References: <196101d6eab6$20714550$6153cff0$@pdinc.us>
        <20210117110337.429994-1-kmarek@pdinc.us>
        <20210117110337.429994-2-kmarek@pdinc.us>
        <xmqq7dobmfrq.fsf@gitster.c.googlers.com>
        <e0264a29-2112-f8c8-f066-2be445654d8e@pdinc.us>
        <xmqqwnwajbuj.fsf@gitster.c.googlers.com>
Date:   Mon, 18 Jan 2021 12:33:15 -0800
In-Reply-To: <xmqqwnwajbuj.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Mon, 18 Jan 2021 11:15:16 -0800")
Message-ID: <xmqqr1mij88k.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 64B1929E-59CC-11EB-B9E0-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> [Footnote]
>
> *1* Stepping back a bit, I think concentrating too much on "is it
>     root?" is a wrong way to think about the problem.  Suppose you
>     have two histories, e.g. (time flows from left to right; A and X
>     are roots)

A shorter and more concrete example.  Start from an empty repository:

	$ git init
	$ git commit --allow-empty -m Aroot
	$ git checkout --orphan side
	$ git commit --allow-empty -m Xroot
	$ git log --all --graph --oneline
        * a1f7cb2 (HEAD -> side) Xroot
        * b6fb655 (master) Aroot

These depict two root commits, Aroot and Xroot, and no other
commits.  We do want to show that these two commits do not have
parent-child relationship at all, and your (and a few proposals made
by other in the past) solution was to show them both with "#".

Continuing in the same repository:

	$ git checkout --orphan another
	$ git commit --allow-empty -m Oroot
	$ git commit --allow-empty -m A
	$ git log --graph --oneline ^another^ another side
        * eddf116 (HEAD -> another) A
        * a1f7cb2 (side) Xroot

These depict two commits, A and Xroot, and no other commits.  We
also want to show that these two commits do not have parent-child
relationship at all, but if we paint Xroot with "#", it still makes
it appear that A is a child of Xroot.

>     And the right way to look at it is "does A have any parent in
>     the part of the history being shown?", not "does A have any
>     parent?"  Then 'A' will get exactly the same treatment in the
>     two examples, and the visual problem that makes A appear as if
>     it has parent-child relationship with unrelated commit X goes
>     away.

So the condition we saw in your patches, !commit->parents, which
attempted to see if it was root, needs to be replaced with a helper
function that checks if there is any parent that is shown in the
output.  Perhaps

	int no_interesting_parents(struct commit *commit)
	{
		struct commit_list *parents = commit->parents;

		while (parents) {
			if (!(parents->object.flags & UNINTERESTING))
				return 0;
			parents = parents->next;
		}
		return 1;
	}

or something like that should serve as a replacement, i.e.

	return !commit->parents ? "#" : "*";

would become

	return no_interesting_parents(commit) ? "#" : "*";

Hmm?

