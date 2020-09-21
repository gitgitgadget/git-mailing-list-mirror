Return-Path: <SRS0=LBHq=C6=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75DE0C4363C
	for <git@archiver.kernel.org>; Mon, 21 Sep 2020 21:09:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 28ACC20874
	for <git@archiver.kernel.org>; Mon, 21 Sep 2020 21:09:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="hR4cnFQK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726594AbgIUVJd (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Sep 2020 17:09:33 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:54490 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726492AbgIUVJc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Sep 2020 17:09:32 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 79A24F5F59;
        Mon, 21 Sep 2020 17:09:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=s+WeyMUNecxA388GkBc+6FFwkeE=; b=hR4cnF
        QKeFPt1EU2w6pMu2RVSCwB1GIRyzrUCOGowmSipdSlnPmyua8YjebUGHGhtQ9YfT
        m5K5Helf8+v9GNdQDd4gSuPjaAxH34gK2+GlVc/V+jtXTasN6FNlCpBht3RVfavu
        AWzrox14uU6DmsZt9VDC/dwmWmUUca2DUm7IY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=LtyQ4Lg1DcpH9aoHcX754P5YiOgvuw2A
        sIDIORNgBN4g5lkyfgd2MKE6tt0jP51b5BPJhm2zUZolxLUuN+LT0C5AePhFukO6
        KwrcQgl1nlfbbO5yXEGXrULiJ1xiHkZPFa3cmoZ0igviwqqDpY7g07UrkZ5Sp/e1
        fUW3JyN70fs=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 72114F5F57;
        Mon, 21 Sep 2020 17:09:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 9FDC2F5F56;
        Mon, 21 Sep 2020 17:09:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH v3 09/10] builtin/diff-tree: learn --merge-base
References: <cover.1599723087.git.liu.denton@gmail.com>
        <cover.1600328335.git.liu.denton@gmail.com>
        <c0d27b125e969e13c52b0fa806a8e3caa8c20ac6.1600328336.git.liu.denton@gmail.com>
        <xmqq363gs1mt.fsf@gitster.c.googlers.com>
        <20200918104833.GB1874074@generichostname>
        <xmqqy2l7m3hk.fsf@gitster.c.googlers.com>
        <20200920110148.GA227771@generichostname>
        <xmqqzh5jf73t.fsf@gitster.c.googlers.com>
        <20200921172740.GA946178@generichostname>
Date:   Mon, 21 Sep 2020 14:09:24 -0700
In-Reply-To: <20200921172740.GA946178@generichostname> (Denton Liu's message
        of "Mon, 21 Sep 2020 10:27:40 -0700")
Message-ID: <xmqqwo0met17.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BB355A82-FC4E-11EA-84A3-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

> @@ -165,7 +175,12 @@ int cmd_diff_tree(int argc, const char **argv, const char *prefix)
>  	case 2:
>  		tree1 = opt->pending.objects[0].item;
>  		tree2 = opt->pending.objects[1].item;
> -		if (tree2->flags & UNINTERESTING) {
> +		if (merge_base) {
> +			struct object_id oid;
> +
> +			diff_get_merge_base(opt, &oid);
> +			tree1 = lookup_object(the_repository, &oid);
> +		} else if (tree2->flags & UNINTERESTING) {
>  			SWAP(tree2, tree1);
>  		}
>  		diff_tree_oid(&tree1->oid, &tree2->oid, "", &opt->diffopt);

OK.  Handling this in that "case 2" does make sense.

However.

The above code as-is will allow something like

    git diff --merge-base A..B

and it will be taken the same as

    git diff --merge-base A B

But let's step back and think why we bother with SWAP() in the
normal case.  This is due to the possibility that A..B, which
currently is left in the pending.objects[] array as ^A B, might
someday be stored as B ^A.  If we leave that code to protect us from
the possibility, shouldn't we be protecting us from the same
"someday" for the new code, too?  

That is "git diff --merge-base A..B", when the control reaches this
part of the code, may have tree1=B tree2=^A

Which suggests that a consistently written code would look like so:

	tree1 = opt->pending.objects[0].item;
	tree2 = opt->pending.objects[1].item;

	if (tree2->flags & UNINTERESTING)
		/* 
                 * A..B currently becomes ^A B but it is perfectly
		 * ok for revision parser to leave us B ^A; detect
		 * and swap them in the original order.
		 */
		SWAP(tree2, tree1);

	if (merge_base) {
		struct object_id oid;

		diff_get_merge_base(opt, &oid);
		tree1 = lookup_object(the_repository, &oid);
	}
	diff_tree_oid(&tree1->oid, &tree2->oid, "", &opt->diffopt);
	log_tree_diff_flush(opt);

Another possibility is to error out when "--merge-base A..B" is
given, which might be simpler.  Then the code would look more like


	tree1 = ...
	tree2 = ...

	if (merge_base) {
		if ((tree1->flags | tree2->flags) & UNINTERESTING)
			die(_("use of --merge-base with A..B forbidden"));
		... get merge base and assign it to tree1 ...
	} else if (tree2->flags & UNINTERESTING) {
		SWAP();
	}

While we are at it, what happens when "--merge-base A...B" is given?

In the original code without "--merge-base", "git diff-tree A...B"
places the merge base between A and B in pending.objects[0] and B in
pending.objects[1], I think.  "git diff-tree --merge-base A...B"
would further compute the merge base between these two objects, but
luckily $(git merge-base $(merge-base A B) B) is the same as $(git
merge-base A B), so you won't get an incorrect answer from such a
request.  Is this something we want to diagnose as an error?  I am
inclined to say we should allow it (and if it hurts the user can
stop doing so) as there is no harm done.

Thanks.


